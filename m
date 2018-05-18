Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrGqr/lWkrhVtnTzF3VDVNegspa0Ef4lpEYYUdwGG10JVGPZ4A5nNrNifYi/cSOcJlWGDsE
ARC-Seal: i=1; a=rsa-sha256; t=1526631547; cv=none;
        d=google.com; s=arc-20160816;
        b=WN0AmBxVlFQOVffE7B80ZZLBUAvdmkNFT1uUI7N5mnsrt/dkj7C7rwRf26Cbcou1Gj
         L/5+vr6hKmFZqeDIFtWUSNDDHI3HjZJ1yiuZNHZ7d6ZfMdCtu/PP6WnuAtWAxfv7v0Q0
         S+sfjH9xte7iBkH921UAL4h0Dd+DaQuIxoNE4su5NbwRkPWM/FbCJ+AWw6HokMUkfODD
         UOIvhjGKAl9Tjw+ukUYjLHHVHTwWITChrS7Oq1MuHtCF6+tJrh5SyukEkNU+EMam+5xB
         0p/xLjOp18tcq1L5XA1nTdtIVJRkWgUPti1tS0IqR8c3yL8sHF0WSMqNUT6kgNURdk9Q
         5ykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=2jbYwr55DR8bmi+05T8C/UAg05xfiXFR0/yo4F1SGTQ=;
        b=NXLwexDd9L6VFmwrZQzo53NB1Cd+8UgZwCH40V69GkoTIZNBcK3gYHVw//MN2J7bPY
         dumxImY3ohHumWnYX2QVXqfeJYDfr2hEGxpHmIwhiaGfXpaSyPU+gosK34fN+IlMCgiY
         dKOBQ99bRxSKFpXJLFFPCheh7nS0hf0d+7O4cYvkNMWG8l/60/4H8lkqxTOrtVWLlkIm
         mUU7YQMgC7F00FgjPFJc/2SZ9hNr+ECchSfjkHtZoU7m4sRQxWom/D8t7yKZHSSQA7+5
         96TTYuIxPXET9P29rj3itpbatJ0cmxyxhozPQ+Gs2Vdn81gXppHFeobFa6izRSFy3Lig
         2K2w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=XijOmVrq;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=XijOmVrq;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ursula Braun <ubraun@linux.ibm.com>,
	syzbot+9045fc589fcd196ef522@syzkaller.appspotmail.com,
	syzbot+28a2c86cf19c81d871fa@syzkaller.appspotmail.com,
	syzbot+9605e6cace1b5efd4a0a@syzkaller.appspotmail.com,
	syzbot+cf9012c597c8379d535c@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 53/55] net/smc: keep clcsock reference in smc_tcp_listen_work()
Date: Fri, 18 May 2018 10:15:49 +0200
Message-Id: <20180518081459.866212728@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789201927088797?=
X-GMAIL-MSGID: =?utf-8?q?1600789201927088797?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ursula Braun <ubraun@linux.ibm.com>

[ Upstream commit 070204a34884110ac5e19c1e2e036fcfd033f8e3 ]

The internal CLC socket should exist till the SMC-socket is released.
Function tcp_listen_worker() releases the internal CLC socket of a
listen socket, if an smc_close_active() is called. This function
is called for the final release(), but it is called for shutdown
SHUT_RDWR as well. This opens a door for protection faults, if
socket calls using the internal CLC socket are called for a
shutdown listen socket.

With the changes of
commit 3d502067599f ("net/smc: simplify wait when closing listen socket")
there is no need anymore to release the internal CLC socket in
function tcp_listen_worker((). It is sufficient to release it in
smc_release().

Fixes: 127f49705823 ("net/smc: release clcsock from tcp_listen_worker")
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Reported-by: syzbot+9045fc589fcd196ef522@syzkaller.appspotmail.com
Reported-by: syzbot+28a2c86cf19c81d871fa@syzkaller.appspotmail.com
Reported-by: syzbot+9605e6cace1b5efd4a0a@syzkaller.appspotmail.com
Reported-by: syzbot+cf9012c597c8379d535c@syzkaller.appspotmail.com
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/smc/af_smc.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -973,10 +973,6 @@ static void smc_tcp_listen_work(struct w
 	}
 
 out:
-	if (lsmc->clcsock) {
-		sock_release(lsmc->clcsock);
-		lsmc->clcsock = NULL;
-	}
 	release_sock(lsk);
 	sock_put(&lsmc->sk); /* sock_hold in smc_listen */
 }
