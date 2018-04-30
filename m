Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoBJIERFBUgNywWjJaxTegAvKcfO3yMp0HaS3x1IIdDvn4jc/2W9f8rl+z97f3iNnAgf8XB
ARC-Seal: i=1; a=rsa-sha256; t=1525116470; cv=none;
        d=google.com; s=arc-20160816;
        b=0E20Nyo9dDUVa3C8UoHFIP5fj/lHkDcFpTWogLaVuL6HT9cq8iw8EFcwC0l1C1yYmT
         yfqAbfxAm+Y43DiNjNFEcAVcqLMOEVjt63TOtRBXoqurthrosfOasFSJ6PSDcQ8fv0tn
         RJJlsN6tHvPieM1XEMwn60m323tnihQ+sio2DDvCayFK1D+lMf6aX3nurnfM6FPs9I0U
         pADubHCjHwf1Wd8D+kDIHynSKTsAPcI1cAtAh5YishuxNli5/lwPx0qRpRmnDSpi+oGX
         mhxSzjIQ7e/eZDrqsmcb7R8lKpnwlhvbeV4qP5Pp0wKMBSnVbq8Tm8DoV2pjcuKslTSq
         SnuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=DXL16JLVbFhVwAsZIQp+1hWYvRb6Yqkq/1VpvZSqt3s=;
        b=Po3vWuyHAAv7PUZnGMCdx7F1NIWLoc5/rnSJYOFuQA9s/KplTAZPiJ9Eh+Tv3CZKDX
         K9rxz28K9uoQ/eDAJdJxJsQ1fN18tNTaXXRbckrVg5SHYboDJD+NhMSu9V2MMRKhLd3g
         4rNfYRa1sUlzCkCisQ7yFLDLfiuyLDPBX4R7Wf4Kq4tuleROi0C2zTGZ1Z/ftBtTKCC6
         waL5Si21YbSX82MltccVg80PiU+WTy+jZzEAlkaV9Smy86IgNiVX0oLMjdxqEH1elp6u
         hzyop82TdPE7vt5CTNdopaYi4G6QhOo0o/lOviSNPBaqkp6L9SI2q6cA0BDCe11bd/p2
         EOWw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE84422E72
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stephan Mueller <smueller@chronox.de>,
	syzbot+75397ee3df5c70164154@syzkaller.appspotmail.com,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 71/91] crypto: drbg - set freed buffers to NULL
Date: Mon, 30 Apr 2018 12:24:53 -0700
Message-Id: <20180430184007.964340007@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200468155576446?=
X-GMAIL-MSGID: =?utf-8?q?1599200528294991533?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephan Mueller <smueller@chronox.de>

commit eea0d3ea7546961f69f55b26714ac8fd71c7c020 upstream.

During freeing of the internal buffers used by the DRBG, set the pointer
to NULL. It is possible that the context with the freed buffers is
reused. In case of an error during initialization where the pointers
do not yet point to allocated memory, the NULL value prevents a double
free.

Cc: stable@vger.kernel.org
Fixes: 3cfc3b9721123 ("crypto: drbg - use aligned buffers")
Signed-off-by: Stephan Mueller <smueller@chronox.de>
Reported-by: syzbot+75397ee3df5c70164154@syzkaller.appspotmail.com
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/drbg.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -1134,8 +1134,10 @@ static inline void drbg_dealloc_state(st
 	if (!drbg)
 		return;
 	kzfree(drbg->Vbuf);
+	drbg->Vbuf = NULL;
 	drbg->V = NULL;
 	kzfree(drbg->Cbuf);
+	drbg->Cbuf = NULL;
 	drbg->C = NULL;
 	kzfree(drbg->scratchpadbuf);
 	drbg->scratchpadbuf = NULL;
