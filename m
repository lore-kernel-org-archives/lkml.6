Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225hjVJrRpgyP9fuK06OJS0s+bYrTRVJI4+XtSidww0+Z9iz7WZKyRddU0z4YGiX/cZ3AgWB
ARC-Seal: i=1; a=rsa-sha256; t=1517591723; cv=none;
        d=google.com; s=arc-20160816;
        b=CSmX4rM8IYGQ8ZxY9C+aSg5AATIVN/TYi4CLCQardESj9ig8fx6LBVeCjPYuGWtuyf
         9SPpK7LfaCKP8mjQlxSVIaDC87lvk4lrz4790QeaDKZaq7eOjryTrGjiKpAnle4X/Kcp
         +agFgdTl3iSTWdPJ3Ii8ug3NfT/HWAYRLG2IIMGAcayFpjRF/Sr3EsIYuB7DBl/XM0Aq
         NOuj4juAyIG2nAU0+7sl4dz4httlnfeuIxcMBrluK0R81Gwq3d+xhCxgB6idyuCKgK09
         31Swu6ZoaXJO8EJTy1Ea7+BFwDWdPgJLINSrplUXc+PLynqx4hHUkppb+LhZpPFj0csw
         xuUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mTLdmG08mRypGMOQipFSpyb0HW7qsp4ryHvVS/VuNw4=;
        b=g/sIwrxZ6iV/N+kx7t0+cJXPTuVubIbJn/47oXePwagBS1roX52hnRE2YBPbZ2fPmp
         pLiweol/j49JBf2U9bhfCBP7NmUebzQM6A1+RTnKnosLWpKq7JotZGr7Rhcae9FoCMT4
         RMdnmfAxt0ZA7hRuRC6kmbw6Y5uYxrLFDGt5Bd6wG8ZCazD15rVjL0CRhf+XJ7mbwrBI
         rOsj3JH8KKQBCtJBD5l6CrmVL1UG6JVCQA4+czBlYslT3MQNNug6mF+nnU5X73pKph9w
         YAHE/vGrt/e/ik2wA5+lRhMabeoM9dvgR/+ns+0ufRlnEIs22lGArt0pB0sL09cLCNND
         0ndg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stephan Mueller <smueller@chronox.de>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.15 07/55] crypto: aesni - handle zero length dst buffer
Date: Fri,  2 Feb 2018 17:58:25 +0100
Message-Id: <20180202140826.711881579@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309279717381300?=
X-GMAIL-MSGID: =?utf-8?q?1591310258585670001?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephan Mueller <smueller@chronox.de>

commit 9c674e1e2f9e24fa4392167efe343749008338e0 upstream.

GCM can be invoked with a zero destination buffer. This is possible if
the AAD and the ciphertext have zero lengths and only the tag exists in
the source buffer (i.e. a source buffer cannot be zero). In this case,
the GCM cipher only performs the authentication and no decryption
operation.

When the destination buffer has zero length, it is possible that no page
is mapped to the SG pointing to the destination. In this case,
sg_page(req->dst) is an invalid access. Therefore, page accesses should
only be allowed if the req->dst->length is non-zero which is the
indicator that a page must exist.

This fixes a crash that can be triggered by user space via AF_ALG.

Signed-off-by: Stephan Mueller <smueller@chronox.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/crypto/aesni-intel_glue.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -824,7 +824,7 @@ static int gcmaes_decrypt(struct aead_re
 	if (sg_is_last(req->src) &&
 	    (!PageHighMem(sg_page(req->src)) ||
 	    req->src->offset + req->src->length <= PAGE_SIZE) &&
-	    sg_is_last(req->dst) &&
+	    sg_is_last(req->dst) && req->dst->length &&
 	    (!PageHighMem(sg_page(req->dst)) ||
 	    req->dst->offset + req->dst->length <= PAGE_SIZE)) {
 		one_entry_in_sg = 1;
