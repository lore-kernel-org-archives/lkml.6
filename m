Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/+LepnvpHiuITuiFsDy4tAuCqN494WGgVlFp1JjidfxdhMpI3Ar3SZsp/k2w+rZMvqGXX6
ARC-Seal: i=1; a=rsa-sha256; t=1522346825; cv=none;
        d=google.com; s=arc-20160816;
        b=I7hGTn6KYULaAGGA4yJmO1Z0af01SU0jAmmJb0wjxomujHIHdjKA514D9cNwL1seVG
         3y+4vhdCxaSOQbvGEp7i42FwdEaiFKBzWgZF3BmgmAqsUBEfTgykMnAcea/i7grCKIDm
         QD/ncAoTJv9pYsKI/8W7N+S7TLxZvrs99Si5wkI/XqVkupd6a7k/4IRaHGwoM45pCSTL
         hza2QTfp9HWni/Kw5i0AWgQGuvobYSmxg63euCnaF8svvvkbl8B4WMBOaLExyKvkoWDY
         aJyvXtio4qnfOuOJG/603MPCisTIwufWbR01JN0pVhBpTKo1OZ5sXGUBPPbfZ0wMKAhp
         HjBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ifwNW5B9NEMusyW6qfM8A4FRIFzG4osrg+3wOxie0yE=;
        b=DLQ4nLjIU6IdmXka+1TLwd9F4N5Ovl/xr+6BIucQlzYLFbeqZ7d+a7yyaEzImbX4+N
         b3I+txLJ2kYvedQ5fZkbS+27NGXI9Yps+jmXPf90+Atc/KLckbRD2VZUkOJzPEQYfsQc
         ktkQY633rahBDbzyiMinr6KYpGy7m+T2HTPI87jCmccsD+3iGajtSs1CQq/o3Eki+s/L
         sxkKnzAIDiJ2SbNKKxmdH/IWUrZ0959pkpQ+0lgkEUGf5C+MpuKM4GHp6nPlTYIK3Td0
         xdI5bDBTAwtJI/WM+uk4M+vlyFMGNFwSOtLWvgGkFRFoAkHDhZhsigGtFyk9tXDxBsDp
         NNFQ==
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
Subject: [PATCH 4.9 27/28] kcm: lock lower socket in kcm_attach
Date: Thu, 29 Mar 2018 20:00:46 +0200
Message-Id: <20180329175736.687245659@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175733.447823703@linuxfoundation.org>
References: <20180329175733.447823703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296045408642540?=
X-GMAIL-MSGID: =?utf-8?q?1596296344981024550?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1375,24 +1375,32 @@ static int kcm_attach(struct socket *soc
 	struct list_head *head;
 	int index = 0;
 	struct strp_callbacks cb;
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
@@ -1406,7 +1414,7 @@ static int kcm_attach(struct socket *soc
 	err = strp_init(&psock->strp, csk, &cb);
 	if (err) {
 		kmem_cache_free(kcm_psockp, psock);
-		return err;
+		goto out;
 	}
 
 	write_lock_bh(&csk->sk_callback_lock);
@@ -1418,7 +1426,8 @@ static int kcm_attach(struct socket *soc
 		write_unlock_bh(&csk->sk_callback_lock);
 		strp_done(&psock->strp);
 		kmem_cache_free(kcm_psockp, psock);
-		return -EALREADY;
+		err = -EALREADY;
+		goto out;
 	}
 
 	psock->save_data_ready = csk->sk_data_ready;
@@ -1454,7 +1463,10 @@ static int kcm_attach(struct socket *soc
 	/* Schedule RX work in case there are already bytes queued */
 	strp_check_rcv(&psock->strp);
 
-	return 0;
+out:
+	release_sock(csk);
+
+	return err;
 }
 
 static int kcm_attach_ioctl(struct socket *sock, struct kcm_attach *info)
@@ -1506,6 +1518,7 @@ static void kcm_unattach(struct kcm_psoc
 
 	if (WARN_ON(psock->rx_kcm)) {
 		write_unlock_bh(&csk->sk_callback_lock);
+		release_sock(csk);
 		return;
 	}
 
