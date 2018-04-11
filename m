Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49QXKNtl6a1s9RkV84RDnDlA+ZazNj7bJyHZ5Yus0RoURPiAg415bW1gAfuaQjwgQdW+k4K
ARC-Seal: i=1; a=rsa-sha256; t=1523472585; cv=none;
        d=google.com; s=arc-20160816;
        b=Bs7wyObMhpADJavxu8BSa00mLyj1Yuzk/7BE6e37Zd2t0OocnYZGocdvj+0EoNt8YJ
         bfuTBwjxbEpBtqrVI2kznQ7LM0X1V0+Hud2EtETewFnQbgFogRO6hAD2FMNat4MbjcGj
         XLOjYAzvUk1vepDxVsIUlazucZ0QPMToHjoJ+U2e56PPDyt2SUAS7r1DciUawufpk0n1
         q7dy1L4I8oMcACc9UkS1LTfj9zJVdz0hz0gF8THMTMAiGhmzGeInc70Nj5dkK2us31P+
         eAq1azpZCtCl1YGxDifGXRg/ROjywLrUJhjCLMQY1ii62CTHcEvoA+iXfXJJ6JctY54S
         aZZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9tJuar9MI15L/HIROLz1N2Mu1H7pyTcWgMueTLhhnvc=;
        b=uSM4EY723agxM78XU1ENagp9vGP96iMPycPdMTf0AT/SwlLEYxLVes+2Vm5odZhseB
         xsEqHYubuFmQlRRDjQwofjKfURmyCp7lyF/7Da9Zazn9dNs0pecTtS/m4pykBh1BCwyd
         /mlLjKRgCDY+K+kw5Qa31VVHUBYTV9IBZQyFj1OyzwukJfk3n9oZhdOolSJ8Urx1VXvi
         XSw0YOyVc0Fwd8cqWUPYDtgl3OseKs2pD7aYU5U95WFhH7HXs3vlMemx20xRPQgby8cL
         ghi4u+gVWCrIgwSFnEZ9rGEShpSfzxcfw05t+Ecd2a8ClVQcfLFpYbZ/H+PF1aF4+rbf
         K06g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	NeilBrown <neilb@suse.com>,
	Trond Myklebust <trond.myklebust@primarydata.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 104/190] SUNRPC: ensure correct error is reported by xs_tcp_setup_socket()
Date: Wed, 11 Apr 2018 20:35:50 +0200
Message-Id: <20180411183556.672161741@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476789904573594?=
X-GMAIL-MSGID: =?utf-8?q?1597476789904573594?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neilb@suse.com>


[ Upstream commit 6ea44adce91526700535b3150f77f8639ae8c82d ]

If you attempt a TCP mount from an host that is unreachable in a way
that triggers an immediate error from kernel_connect(), that error
does not propagate up, instead EAGAIN is reported.

This results in call_connect_status receiving the wrong error.

A case that it easy to demonstrate is to attempt to mount from an
address that results in ENETUNREACH, but first deleting any default
route.
Without this patch, the mount.nfs process is persistently runnable
and is hard to kill.  With this patch it exits as it should.

The problem is caused by the fact that xs_tcp_force_close() eventually
calls
      xprt_wake_pending_tasks(xprt, -EAGAIN);
which causes an error return of -EAGAIN.  so when xs_tcp_setup_sock()
calls
      xprt_wake_pending_tasks(xprt, status);
the status is ignored.

Fixes: 4efdd92c9211 ("SUNRPC: Remove TCP client connection reset hack")
Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sunrpc/xprtsock.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2363,7 +2363,12 @@ static void xs_tcp_setup_socket(struct w
 	case -EHOSTUNREACH:
 	case -EADDRINUSE:
 	case -ENOBUFS:
-		/* retry with existing socket, after a delay */
+		/*
+		 * xs_tcp_force_close() wakes tasks with -EIO.
+		 * We need to wake them first to ensure the
+		 * correct error code.
+		 */
+		xprt_wake_pending_tasks(xprt, status);
 		xs_tcp_force_close(xprt);
 		goto out;
 	}
