Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoy9L1YKcvCGZvAr+hGhzCmiisyUULxvwLUhEQaOuP7XM62vCKKvmpFNmj885Ru4MBXyQ0O
ARC-Seal: i=1; a=rsa-sha256; t=1524838279; cv=none;
        d=google.com; s=arc-20160816;
        b=LeXe8ta4C1VQduTERFyJpxTkz+8F6l9QM74poT3r1upC6ASnjkkPqvOX9Nv3iakwUd
         PPZiywVOc4q0wQ134+qWsTKulq79TbQdsEzwlQ+eEbxxquHY/2YWyHq0yDsHydrg6ade
         hjczdUNXzftf3HpP21r5AO7ceYNktWHqs3ouuOIfmpm2efX5mtjH91VFe6FPJ/wMOezl
         02NnYDy689zRwDeJygWxRVjjZzLXm5m9eMDNoy3kArfH7MHBgE8bO3iO/7YkDR/skXrA
         2XmR5+/7ko1BaY42IZTDk7YJe0N2kDq821PQicnD3At/Q5sWUyqSNxMj3vZqXIWf4rAu
         9Gww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=M3gyS//mj3SbyUxWd+fBM0GRl1FkgCKWl9giu8jh414=;
        b=0HWghAUjt04aTZNcNL/lsNomFRYGBBIA4jooqyJvODNQiR9Ygsf+3VQYfDKmOEUrrz
         MCktvzV0AlJfsvvolZzQm60OfAJB6h2K8QLYhp4Yypo9ltPYO10sFYpJYDW1FkMg5jtE
         iqeHmDU5pnQwQ+SD+3u3ooWMgYrMdvdgKF8GS+2g4Ti9du7g5O3rm7WgkR1dW/JNBvUS
         xo2mqchGdzxuwlpgzVn8EthEaStGtenpli5VDJL2VTyr+QyRk35GIH7tqowNZZArREUa
         2ZEJHbeAm+v6FqcznvLKRvhzaAp9O/41aa6ORkRth1+yfuEu27yGaxucZjSr1U8QlOi/
         spFg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E0E21892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 46/81] llc: fix NULL pointer deref for SOCK_ZAPPED
Date: Fri, 27 Apr 2018 15:58:48 +0200
Message-Id: <20180427135745.864093520@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908105270702201?=
X-GMAIL-MSGID: =?utf-8?q?1598908823337295841?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>


[ Upstream commit 3a04ce7130a7e5dad4e78d45d50313747f8c830f ]

For SOCK_ZAPPED socket, we don't need to care about llc->sap,
so we should just skip these refcount functions in this case.

Fixes: f7e43672683b ("llc: hold llc_sap before release_sock()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/llc/af_llc.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -189,7 +189,6 @@ static int llc_ui_release(struct socket
 {
 	struct sock *sk = sock->sk;
 	struct llc_sock *llc;
-	struct llc_sap *sap;
 
 	if (unlikely(sk == NULL))
 		goto out;
@@ -200,15 +199,19 @@ static int llc_ui_release(struct socket
 		llc->laddr.lsap, llc->daddr.lsap);
 	if (!llc_send_disc(sk))
 		llc_ui_wait_for_disc(sk, sk->sk_rcvtimeo);
-	sap = llc->sap;
-	/* Hold this for release_sock(), so that llc_backlog_rcv() could still
-	 * use it.
-	 */
-	llc_sap_hold(sap);
-	if (!sock_flag(sk, SOCK_ZAPPED))
+	if (!sock_flag(sk, SOCK_ZAPPED)) {
+		struct llc_sap *sap = llc->sap;
+
+		/* Hold this for release_sock(), so that llc_backlog_rcv()
+		 * could still use it.
+		 */
+		llc_sap_hold(sap);
 		llc_sap_remove_socket(llc->sap, sk);
-	release_sock(sk);
-	llc_sap_put(sap);
+		release_sock(sk);
+		llc_sap_put(sap);
+	} else {
+		release_sock(sk);
+	}
 	if (llc->dev)
 		dev_put(llc->dev);
 	sock_put(sk);
