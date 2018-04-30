Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrzDGu9CzszKS5ofEJ6VYJWzp/OwBZ6vxaHplWdcWcLlRVPezvFiehY0RVQmM41xwar7Mou
ARC-Seal: i=1; a=rsa-sha256; t=1525116413; cv=none;
        d=google.com; s=arc-20160816;
        b=evHYf6tX+oj7aoMgJXHxwk6q3rW7eg6rad+0qyjdEMLSHkfjSQ7nTJavOL3L2fuXEk
         bJeiTQAhDp63vPEdATelcGXaCI4qlLIzBjOxPWQCbF4yHAa9jL29/+zWfsb1Xso4JGme
         z5o4orU+gc1FdgbKMOJ35N+t247SvgIOjmsxl/y4Mvm5qCd0D7CJEAcmJKQBKJ8RJq3K
         YEznmAJ/hBLjhYPVlfDjxMv0+Og1uZIXZHhL9Z4ApZ1yhIqC7OoXtCfDtUgNI8rL8JTy
         I9ZbKknurX6lrStyLsb1sSRpe3s+H4NqhFNfc7NKSHbCo+kG1FAUuI26L5Ls88mnZhNO
         RUIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=ia/z4cV6s8sggu57SMdDb2V1ITC45F1xB9wB1lWQewc=;
        b=Ds+XUTQc/u+3C61SXxJnCo+Ujl+cIHt8XiH1zkHpIQTnqgxzSsfWxtYoo9iyFn9WTX
         Xxa5H77FHUXQJmdccWXBvuP+wM0Tke/k7ea5/OMps5cTAg+gABi/PUfl7HwS1RJYDyDB
         QmqIYDVPUqVZZPjt9XYJYIQtDxL2H8IKuvzsSzayU0sUTq4cUQF+X2Ysg03CIHezbSkR
         9XUOt0XYYV6jfXX2Q9DA3PIfzcSPEQLuXaYDnMWQ1M5DsKzjWdch8mL5UlJ9Sc6+paCQ
         WPDAOb2CATtid09d4Fk4vkbAQ4To30ou1nh+2IJ/oCTNAnP9rIj+NXUWvbyLeF82EJos
         HVVA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8895322E71
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stephan Mueller <smueller@chronox.de>,
	syzbot+75397ee3df5c70164154@syzkaller.appspotmail.com,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.9 47/61] crypto: drbg - set freed buffers to NULL
Date: Mon, 30 Apr 2018 12:24:50 -0700
Message-Id: <20180430183955.325249799@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200468155576446?=
X-GMAIL-MSGID: =?utf-8?q?1599200468155576446?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
