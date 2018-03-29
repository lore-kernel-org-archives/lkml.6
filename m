Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49EqQACOLmjZYOUe00k3S67ggCcV59O0xaCHT4YRYGtQtrL7h0O9qL0GkQdxe6Gfv4E8qs9
ARC-Seal: i=1; a=rsa-sha256; t=1522346736; cv=none;
        d=google.com; s=arc-20160816;
        b=oALkXIgKNEdGOtXqveXSGLvgcoK4GArS3YH1hyMkoRi84C+2785NabrCBN0iQvjWLa
         /aY9Vb7ktIxMau0CY/q2hurIw6zeh5CEFMjwvba+8YpGbxrik21y6D3S2ZMdGDbPtOeH
         Co3URZwoYD/49jCenyXKE+lANR9vU8Tj6fbiyqGn4axDE7c/EilxXsi4y0Zi46Ghecnt
         /QrEsA4hR4a/aaFFNt7WZzfcFd0Z6fUp5gm0ZLaKW4OrWyDCLQ3C/Ehre31RgT8dqbfR
         V6SdhyQ5hATqbBgaMPJ3JwOa9vrI7w2cD11t7FpLIWyCMNzhQRU2yxEUOsbDnr/z6/lM
         OTXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2ptrj1DOgifx9IfBvHPnnG6KZJeZ5FshLrPKl1jurJM=;
        b=Mh8qoc+C7xSYrfsBVmQQaCYoI+asJFPJPrpOqw+QzrRE51HM2XPkonzkKHRfLiEe97
         pOrkMT+FJJ5iv7w+A6JJPgMpk1shpq+pPtI0RyIKZI4ms6VamKKkjUovHK2PplaMLX/0
         fS7PsS+FdmacDI5SISDfkGt0775Z7yhVg2e050AQoulKvMIKK33NAnAisq52U/JxuCJ9
         nC2NgPMsTJ/uIx72xm9c8tMMk1TkgMf2ODfko2BoMock5z0uAdOlKMz0YPSV6HEjX0bY
         l6wbC04yyV2+JACxLv8bMjvmr+lnBZ3tfcA5xZAy9+PGq8Isn28LJEyh3Ecq1O+EHL8p
         4jwg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+f99ab3887ab65d70f816@syzkaller.appspotmail.com,
	Alexey Kodanev <alexey.kodanev@oracle.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 22/43] dccp: check sk for closed state in dccp_sendmsg()
Date: Thu, 29 Mar 2018 20:00:17 +0200
Message-Id: <20180329175732.432357056@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296089395383323?=
X-GMAIL-MSGID: =?utf-8?q?1596296250824182738?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Kodanev <alexey.kodanev@oracle.com>


[ Upstream commit 67f93df79aeefc3add4e4b31a752600f834236e2 ]

dccp_disconnect() sets 'dp->dccps_hc_tx_ccid' tx handler to NULL,
therefore if DCCP socket is disconnected and dccp_sendmsg() is
called after it, it will cause a NULL pointer dereference in
dccp_write_xmit().

This crash and the reproducer was reported by syzbot. Looks like
it is reproduced if commit 69c64866ce07 ("dccp: CVE-2017-8824:
use-after-free in DCCP code") is applied.

Reported-by: syzbot+f99ab3887ab65d70f816@syzkaller.appspotmail.com
Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dccp/proto.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -789,6 +789,11 @@ int dccp_sendmsg(struct sock *sk, struct
 	if (skb == NULL)
 		goto out_release;
 
+	if (sk->sk_state == DCCP_CLOSED) {
+		rc = -ENOTCONN;
+		goto out_discard;
+	}
+
 	skb_reserve(skb, sk->sk_prot->max_header);
 	rc = memcpy_from_msg(skb_put(skb, len), msg, len);
 	if (rc != 0)
