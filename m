Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48t0IBVzyHU70xs81l5hCVhrerWvT/uKq6cajJzjkAxaSEH++FiPjkja/FRYfhgs6s10Nh8
ARC-Seal: i=1; a=rsa-sha256; t=1523473210; cv=none;
        d=google.com; s=arc-20160816;
        b=ro+NvGYLTz7Kt6V0f72EKn7Bgl7qlKlqoKheDMWYL2Yvs/1xkByJRuVeIjBhKT7oW0
         wkrtrk9b/UTpKnA4lJ5xrBnMaGvUPueXFTEC6WnKT9fbFYQ8aCzBU18knCP3TmRsKvTW
         JvrisGtUUkyylZ9HhCHgf5TTXT6dKgvUO88ypGrf45w0qZT0OhiT8gYD0c6El6iA5+5A
         MkYk2g8F6TQPswPriZvcvoCtjXWF78MimBLX7gRsBUjUboeqroaA/13ZrNVDTV/ppUyM
         X9XaFrAUztTsosgMn1CDKsQ2LB/9xartuAidq/C3+ZQ8DXzEo008wLjhWgdxUXyt47a9
         gUuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=iEPHOmyY+ggQczFbaFcngtyqKNsNPccZ9jqFSXFk+Lk=;
        b=gIvfhxaY6b/aO3uoR0PDvcdErpEzG8EEPklUjDoQjnl4WOtW0Yo2mIzndpCPA9bmNv
         XETLu1o9SR3x81ql7VCGAr2S2QiWp2HNCzzb3IaMSarJcFkOBARRHZLFhITGzLEZ9qRi
         Iw8MlxEMve3qit55bFJZ43MOi0zMPX3KqW1FvSK9X52biRUBeDUmog4yvQ5NqHaGG/92
         TuJvKChmg2m5RXRPGXOJ08EHNY0pWEa15MdL3d0Pyt5VF0b3DQty3xAzBfyKhGx7qE+N
         KoMtHgwy8fZ486TMB3JVueM6qNNBcQzjdZQmT5GbfJwfx5pM4UPFK4zdAR2AvpDlRebw
         g/lA==
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
Subject: [PATCH 4.9 164/310] SUNRPC: ensure correct error is reported by xs_tcp_setup_socket()
Date: Wed, 11 Apr 2018 20:35:03 +0200
Message-Id: <20180411183629.437813707@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476789904573594?=
X-GMAIL-MSGID: =?utf-8?q?1597477445000747065?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2384,7 +2384,12 @@ static void xs_tcp_setup_socket(struct w
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
