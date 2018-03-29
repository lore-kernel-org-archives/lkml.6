Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48WS1+FDTAeFnOBy4ofbxCh7yZNHpju2HY36lfvQS/epscpKFg1fJ6LAZmojiEVBLObUovF
ARC-Seal: i=1; a=rsa-sha256; t=1522346539; cv=none;
        d=google.com; s=arc-20160816;
        b=z9VwWQS4ro6/mNxwOFkWQ24DcywOqJuND0HYkUA/+gqLDPyTgd7vt2GmxbcAt0lRWD
         qc9g9GUCgGhfVejoUYLyCeO3pn4st77790A7O4XqY5YtVtbbWgDnsAljBv1CSZbkvXcd
         BbhmEKR+00EZLoFPzXXQV9qxHjD4oy2wAhenXpNCiRIPjJiuT3Cfn+XXaTOIXvUb9nAn
         ye+4jdHISUvFaHqeUnmR+ZUYtE4zqfmOKu+1Bdp5U48OdoECzOwMEPUlwa8c62Dq3QAx
         JXfy9fr2IFdbSPSDU7FVGNRlLcc1bF31mmVIvouoydr3Gal20WvRRo9WRTDr3njedfSL
         6bDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=G43vjKF7pXJ58acYQD++tAAFAiCPpV44s00pF2nErUM=;
        b=WJgRXgdXmvlIIudKg3JpEz4sRj4/n9B6i4i55ZvSxobxeDGUbnphGOdjP1mWbznyKO
         EGxmkSahTWfErzRqVOTYnWsqtKKO8MafZ2CnXMvMD5aVI431hoZ4R0edunQACGho80fY
         Q5UcYqYEvzsk4PZSkmQNwiOemVFaqkNNvFZbpif8FOt7ecaKjX8VtYMwaPR9/lXx0GPo
         08AWtOi4HeuTqTcEqchrYIuSjQq0wAaSN1SEHN+OYHhtD3Mz72vOekNbMZsZpkbuSz4C
         wGLjJNcxf9izpac7zVp6Tnc7i/fea/kjjjk3gi04NofE7bwku2fJ4JzZw4xuSPLz5zMp
         VOsw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+ea75c0ffcd353d32515f064aaebefc5279e6161e@syzkaller.appspotmail.com,
	Tom Herbert <tom@quantonium.net>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 21/47] kcm: lock lower socket in kcm_attach
Date: Thu, 29 Mar 2018 20:00:02 +0200
Message-Id: <20180329175730.748910575@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296045408642540?=
X-GMAIL-MSGID: =?utf-8?q?1596296045408642540?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Herbert <tom@quantonium.net>


[ Upstream commit 2cc683e88c0c993ac3721d9b702cb0630abe2879 ]

Need to lock lower socket in order to provide mutual exclusion
with kcm_unattach.

v2: Add Reported-by for syzbot

Fixes: ab7ac4eb9832e32a09f4e804 ("kcm: Kernel Connection Multiplexor module")
Reported-by: syzbot+ea75c0ffcd353d32515f064aaebefc5279e6161e@syzkaller.appspotmail.com
Signed-off-by: Tom Herbert <tom@quantonium.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/kcm/kcmsock.c |   33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1381,24 +1381,32 @@ static int kcm_attach(struct socket *soc
 		.parse_msg = kcm_parse_func_strparser,
 		.read_sock_done = kcm_read_sock_done,
 	};
-	int err;
+	int err = 0;
 
 	csk = csock->sk;
 	if (!csk)
 		return -EINVAL;
 
+	lock_sock(csk);
+
 	/* Only allow TCP sockets to be attached for now */
 	if ((csk->sk_family != AF_INET && csk->sk_family != AF_INET6) ||
-	    csk->sk_protocol != IPPROTO_TCP)
-		return -EOPNOTSUPP;
+	    csk->sk_protocol != IPPROTO_TCP) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
 
 	/* Don't allow listeners or closed sockets */
-	if (csk->sk_state == TCP_LISTEN || csk->sk_state == TCP_CLOSE)
-		return -EOPNOTSUPP;
+	if (csk->sk_state == TCP_LISTEN || csk->sk_state == TCP_CLOSE) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
 
 	psock = kmem_cache_zalloc(kcm_psockp, GFP_KERNEL);
-	if (!psock)
-		return -ENOMEM;
+	if (!psock) {
+		err = -ENOMEM;
+		goto out;
+	}
 
 	psock->mux = mux;
 	psock->sk = csk;
@@ -1407,7 +1415,7 @@ static int kcm_attach(struct socket *soc
 	err = strp_init(&psock->strp, csk, &cb);
 	if (err) {
 		kmem_cache_free(kcm_psockp, psock);
-		return err;
+		goto out;
 	}
 
 	write_lock_bh(&csk->sk_callback_lock);
@@ -1419,7 +1427,8 @@ static int kcm_attach(struct socket *soc
 		write_unlock_bh(&csk->sk_callback_lock);
 		strp_done(&psock->strp);
 		kmem_cache_free(kcm_psockp, psock);
-		return -EALREADY;
+		err = -EALREADY;
+		goto out;
 	}
 
 	psock->save_data_ready = csk->sk_data_ready;
@@ -1455,7 +1464,10 @@ static int kcm_attach(struct socket *soc
 	/* Schedule RX work in case there are already bytes queued */
 	strp_check_rcv(&psock->strp);
 
-	return 0;
+out:
+	release_sock(csk);
+
+	return err;
 }
 
 static int kcm_attach_ioctl(struct socket *sock, struct kcm_attach *info)
@@ -1507,6 +1519,7 @@ static void kcm_unattach(struct kcm_psoc
 
 	if (WARN_ON(psock->rx_kcm)) {
 		write_unlock_bh(&csk->sk_callback_lock);
+		release_sock(csk);
 		return;
 	}
 
