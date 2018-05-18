Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpmXxHp1S2HfB8CrnptrfJSfJtbSMAdSrrkvELuQhUTXdHd7qbTgcWTi4IjfsVMj1XvR6Xi
ARC-Seal: i=1; a=rsa-sha256; t=1526631426; cv=none;
        d=google.com; s=arc-20160816;
        b=pcVcMDNCeCEBgojSpdsmOZo3GM6hGlciB3IMX/pxVNNqiWhJmgHLiTz+Z3wRrOnIdP
         xTmzd/1SosEkhhR5aoLTgSt18CyMEj+KaqU2QSDQexZzIZ71VSiihl1kVNUUT8VUep+D
         kCX7N/mJhnWyDYs0uXprZuaFPLJ9JojPuNOkB3yL1OufiDhsVepHX2r2xSWPIlGCJyNM
         SAejiSPwj/oFDRo5Qe8BBq91lbujpl2BzNDwlD5QEvitSUK6LoPGjyqhU4nmfQcE2QXF
         OpSwcQdfbk86BCdqVB+R/KMKanuYuNmFM57ddOZ48zAf7zdSUIoa6ll1tr8Wyg5mW306
         9Htw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=mDCutQWNwELQ28Zphera7XHc6RViOfCx42Exd+UtkkE=;
        b=G0Evnu0zfEoSZjDQkeoZKgfysvCJB+JvgDOyQcE6/yZzOTRvJhtkLBZGuZQ+nnJWHC
         Z7xTsLFoI+uvPsOCfia+IltAT34dSwTXP/FfBBlASESPfYl+g3+Lyz5uEICVT81kGVP3
         dq0qvTWRdb286+BdnT14ps7J7uK8xmcUhzRMxRkmWwjdrDyAtwLBAKPsf0D66ZR9Bm5A
         gU1NOLuoDrp47YylEXqc4RIb321duo8Os5FwmORdV27G7Wxi+3iMo7BRmiiwQcIv+duX
         K2jvxpl8jJ8s+VfhyLF+eehnGdQS/j/K0/mi0vjUK9XVNeFQWaKLOLf5qGmiB8goC9Ya
         81/g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=0+lRewbX;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=0+lRewbX;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andrey Ignatov <rdna@fb.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 05/55] ipv4: fix memory leaks in udp_sendmsg, ping_v4_sendmsg
Date: Fri, 18 May 2018 10:15:01 +0200
Message-Id: <20180518081457.651163744@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789075042388036?=
X-GMAIL-MSGID: =?utf-8?q?1600789075042388036?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -842,6 +844,7 @@ back_from_confirm:
 
 out:
 	ip_rt_put(rt);
+out_free:
 	if (free)
 		kfree(ipc.opt);
 	if (!err) {
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -958,8 +958,10 @@ int udp_sendmsg(struct sock *sk, struct
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
@@ -1080,6 +1082,7 @@ do_append_data:
 
 out:
 	ip_rt_put(rt);
+out_free:
 	if (free)
 		kfree(ipc.opt);
 	if (!err)
