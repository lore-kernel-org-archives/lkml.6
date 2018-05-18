Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrKIOY32OyuBbF+arFFHuqeAf0V8MuZ+RaNO7t3szoBVS8V1s7YcMqwnf/pwGpXxI9rSuLq
ARC-Seal: i=1; a=rsa-sha256; t=1526631720; cv=none;
        d=google.com; s=arc-20160816;
        b=FVZ1tjN5Z2YDGVwCg0tuXF+PT7439WjwBnSI9RWVK52P/Lk3LJJVJKrBZmPqT8iQKK
         JogaxJ8gD9Fb+NL67CDz5Th05fICU7CTCnEDYZDJx8T0j36ZIG7T0G10U7RnAWn17pj9
         hytG+6itDcUYFJU1NI3UGCWGqXvAMH58GjsfUKD1dWW3mgNFrSaGOqyWjLpn0Qkopgiz
         /QXDf22ZlejDIbL+3rSXkokzA7s0btLR8Un4AITKgasI1E9Ud39x+r1cW3rkiedZSzXD
         p6wIZqZkNNc4Bm2kLWvG5rjIL3kBl6FTYFxDIlwY+IzMdWn57atpBxOwb0XAAWz34gpe
         2kEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=HSIVLB0aQ4hEpWJW2tis2ni4B6IA3LDl21By8Rj8LAo=;
        b=G6RIurc8cfEWnWASh8uHK1DC8NjPAdPAY+anBeNw43d9LgaALJsyutnUXjkz0xLWd0
         z4nUdfDNK4Ts2giE2iDOomGDZbgVhwkP5cgZRT0yNwr7ikhij6OOv7zOJSomWBC2vsmR
         Z4Rwd/9ZIoJnV81UcdQ9bE6weEIw82E0JspPCxr2jrcRbQLjdPbuz/tDMVZ310z2MgqJ
         T4v9zjX54NgCsI2SkgQKti5AIBFgIwNT4k1XsPx+HUXWrqVgIyyGT66poHmcbOjSBar6
         GRqFgEUXFbsCO0hbXy/yBSGUSMyvaGR/p3zTDBDDfmJ685qF3RBhJljWNV62fBjikvRt
         j4nA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=0UL0fnW7;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=0UL0fnW7;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andrey Ignatov <rdna@fb.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 04/33] ipv4: fix memory leaks in udp_sendmsg, ping_v4_sendmsg
Date: Fri, 18 May 2018 10:15:43 +0200
Message-Id: <20180518081535.269832637@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081535.096308218@linuxfoundation.org>
References: <20180518081535.096308218@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789075042388036?=
X-GMAIL-MSGID: =?utf-8?q?1600789382400894526?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Ignatov <rdna@fb.com>

[ Upstream commit 1b97013bfb11d66f041de691de6f0fec748ce016 ]

Fix more memory leaks in ip_cmsg_send() callers. Part of them were fixed
earlier in 919483096bfe.

* udp_sendmsg one was there since the beginning when linux sources were
  first added to git;
* ping_v4_sendmsg one was copy/pasted in c319b4d76b9e.

Whenever return happens in udp_sendmsg() or ping_v4_sendmsg() IP options
have to be freed if they were allocated previously.

Add label so that future callers (if any) can use it instead of kfree()
before return that is easy to forget.

Fixes: c319b4d76b9e (net: ipv4: add IPPROTO_ICMP socket kind)
Signed-off-by: Andrey Ignatov <rdna@fb.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ping.c |    7 +++++--
 net/ipv4/udp.c  |    7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -775,8 +775,10 @@ static int ping_v4_sendmsg(struct sock *
 	ipc.addr = faddr = daddr;
 
 	if (ipc.opt && ipc.opt->opt.srr) {
-		if (!daddr)
-			return -EINVAL;
+		if (!daddr) {
+			err = -EINVAL;
+			goto out_free;
+		}
 		faddr = ipc.opt->opt.faddr;
 	}
 	tos = get_rttos(&ipc, inet);
@@ -841,6 +843,7 @@ back_from_confirm:
 
 out:
 	ip_rt_put(rt);
+out_free:
 	if (free)
 		kfree(ipc.opt);
 	if (!err) {
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -982,8 +982,10 @@ int udp_sendmsg(struct sock *sk, struct
 	sock_tx_timestamp(sk, ipc.sockc.tsflags, &ipc.tx_flags);
 
 	if (ipc.opt && ipc.opt->opt.srr) {
-		if (!daddr)
-			return -EINVAL;
+		if (!daddr) {
+			err = -EINVAL;
+			goto out_free;
+		}
 		faddr = ipc.opt->opt.faddr;
 		connected = 0;
 	}
@@ -1090,6 +1092,7 @@ do_append_data:
 
 out:
 	ip_rt_put(rt);
+out_free:
 	if (free)
 		kfree(ipc.opt);
 	if (!err)
