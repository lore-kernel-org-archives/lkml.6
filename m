Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqqOVV5yyvhaWRoPpE9u0APWMSp/fz2qhrpS7rdBibz93j1hJkTQe9xeS7mkI/SxVDGndz4
ARC-Seal: i=1; a=rsa-sha256; t=1526631472; cv=none;
        d=google.com; s=arc-20160816;
        b=KxtSABldvxfO82kYORqfJAEdAbpsKUAbIiWhEMQmgutUS0y1+ukX9KUQ9rQBbDcvHk
         pZ69jhQ2JK7EE3n727HhjwTVTJxszM5NXvxI6PWaRvNUBfy17L/NLwu3WfcOsksV0A7+
         LQFXB077b1G6ULdA4CK9zYY9PuH6a1u0T3uoVIhltjJD1u+97mY/681qd6faTlLkAF3H
         RHkqaF2oSYH1PhazrDIHEJ2jXmRiL1HdrDOFvf6SjWjwc5tirReiJlKl9DmboSXo+yg6
         gEdCKcWYx24+A4zF1sMlDX50NbvBYST0RbgYA4aJ7dPmGU16cGQ03rDSn4NFmuO9+oXr
         h7dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=+1aN0g0XzyOrPSYVrRQxGm1J4D6PaMzcI5NPIouOCBk=;
        b=iPtjSHjmL8fhckkFQK9axaXUZTBQMMKscPDzIqmw41+ceuYxz6Y9tm1WOLdq6/xx04
         57pnKFoa/yKhkK1fviBh1y1wdm0IfQNBulTRX7DY5irhC/r6vgMaOF8hVilrFpYmk2mS
         cXgwOpp9ISWTeVtAW/OVj+oUiB/yykX9YcklyXrBn/D6cLWVbPQ7ndQ9GQyTjwtjx+mt
         qzGWvu06ij8Ogk1rldeEdcUBNAyWS/Fzwe1dknrOnO5tAgVV2tqmZPikn0Ua5XzzYrTA
         U8TW4+VcmHXhouQ+7HDNPU2fuOrwHl3drzYdXQnytUATwwiO1V4pl5s646K6PI9eYdEV
         Z23A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=YFBaC1Mk;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=YFBaC1Mk;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ursula Braun <ubraun@linux.ibm.com>,
	syzbot+03faa2dc16b8b64be396@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 15/55] net/smc: restrict non-blocking connect finish
Date: Fri, 18 May 2018 10:15:11 +0200
Message-Id: <20180518081458.215956909@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789123047137185?=
X-GMAIL-MSGID: =?utf-8?q?1600789123047137185?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ursula Braun <ubraun@linux.ibm.com>

[ Upstream commit 784813aed6ba24a1f24e7e11d9d0f208cee37a7d ]

The smc_poll code tries to finish connect() if the socket is in
state SMC_INIT and polling of the internal CLC-socket returns with
EPOLLOUT. This makes sense for a select/poll call following a connect
call, but not without preceding connect().
With this patch smc_poll starts connect logic only, if the CLC-socket
is no longer in its initial state TCP_CLOSE.

In addition, a poll error on the internal CLC-socket is always
propagated to the SMC socket.

With this patch the code path mentioned by syzbot
https://syzkaller.appspot.com/bug?extid=03faa2dc16b8b64be396
is no longer possible.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Reported-by: syzbot+03faa2dc16b8b64be396@syzkaller.appspotmail.com
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/smc/af_smc.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1165,13 +1165,15 @@ static __poll_t smc_poll(struct file *fi
 		/* delegate to CLC child sock */
 		release_sock(sk);
 		mask = smc->clcsock->ops->poll(file, smc->clcsock, wait);
-		/* if non-blocking connect finished ... */
 		lock_sock(sk);
-		if ((sk->sk_state == SMC_INIT) && (mask & EPOLLOUT)) {
-			sk->sk_err = smc->clcsock->sk->sk_err;
-			if (sk->sk_err) {
-				mask |= EPOLLERR;
-			} else {
+		sk->sk_err = smc->clcsock->sk->sk_err;
+		if (sk->sk_err) {
+			mask |= EPOLLERR;
+		} else {
+			/* if non-blocking connect finished ... */
+			if (sk->sk_state == SMC_INIT &&
+			    mask & EPOLLOUT &&
+			    smc->clcsock->sk->sk_state != TCP_CLOSE) {
 				rc = smc_connect_rdma(smc);
 				if (rc < 0)
 					mask |= EPOLLERR;
