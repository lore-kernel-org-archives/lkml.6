Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227+mBZ/LRGhmJ5+w0dxAnEaZOfkg9UEEnpJNOTARfwgWezX9AjqpbC/IO2d/EuaUmzPR/mp
ARC-Seal: i=1; a=rsa-sha256; t=1517590884; cv=none;
        d=google.com; s=arc-20160816;
        b=IVQK2QEshlsr48mcpEB+Dd0wN4U9ydGgzwBn0FjkLl+B+EITZc+SPz6qyQ4fGboAMa
         ChH4XQX3FlhKuXCNCo6LdU26GhMXVYXc33Oe8/lxTgrgy+PBcjpZ0BZTVLawYM7dp4Ud
         XXyBFC2uH2aX7JM4gRPnoxrkyvDdYMzDvGEwJUw5ZNZmWasXbq8rlXSr0P7MBWePKHyz
         EUcXP0BhWQMwyJzYDl0Q8dafJIQqyKB4Q6gnHRuinjvuf3rSNJFDQdVGGpizhQPVLC8c
         TAazJLymfVB+Qp5AJFDraMMcv1G04wRbtcGkGiidojziM02IdsXSRtL2f7UFNcGvEd/D
         xFIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7bwvNSWbCNpY/Pbt7kHH4vh2YU+TEo7vhS3Nz4N3Ggc=;
        b=ugNrVunuvWeRofR4lYRRGjCI0utp6YPmg/XG6qavSjMKx4OxQYwl5Qwv7uIkWCEEiV
         88rtz6r4vdeJH8Scbk34Xqaaa/5ez6WEYK9Tw98C+0SDSU/UkOqWbWSIesKGc58q974T
         ctDUGpXcqNPv/AKEt2WKYqe7Rhe8yWzdz608bwF4CPMr4a8SpXoSIb5hRvBn6Q+9gSb4
         I+ThikJK5+iNOt3Wb+iR+PsOe73fIFxsj0NDHB6KdeUepmEUCRaG0CGmQ9g2xqrc3NWz
         v254QnR8QkZliIV653coxqmPF62FBV4hF5Xj3zXToyxqjiy3HacBd8+UucjE+2rhNQn4
         zLaA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>,
	Trond Myklebust <trond.myklebust@primarydata.com>,
	Anna Schumaker <Anna.Schumaker@Netapp.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 46/67] SUNRPC: Allow connect to return EHOSTUNREACH
Date: Fri,  2 Feb 2018 17:58:15 +0100
Message-Id: <20180202140820.487727094@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309379764684718?=
X-GMAIL-MSGID: =?utf-8?q?1591309379764684718?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@primarydata.com>


[ Upstream commit 4ba161a793d5f43757c35feff258d9f20a082940 ]

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Tested-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sunrpc/xprtsock.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2360,6 +2360,7 @@ static void xs_tcp_setup_socket(struct w
 	case -ECONNREFUSED:
 	case -ECONNRESET:
 	case -ENETUNREACH:
+	case -EHOSTUNREACH:
 	case -EADDRINUSE:
 	case -ENOBUFS:
 		/* retry with existing socket, after a delay */
