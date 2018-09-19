Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD55ECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40EBD2146D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eiWWoIVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40EBD2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbeISHyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:54:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35113 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbeISHyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:54:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id 205-v6so1005554pgd.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 19:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oy5DbuF7CYPV4PtmLt5437WSeAaoA2AwlwpYpljL60w=;
        b=eiWWoIVDIlBYPTbbkdI9pCPyoWrnajXdH0DDRidVjrC3Ogtikd0A70Pqo7C3CPlRsh
         iE2K0zF1zlgK+qwRRrrKRTBPZ6VpxlboovR51hbd+e/lSD6wO/uzUudpD0DKRwH3ERyV
         RcSjg42JLpLhSQI4s5Q5qsaq00hFpn7lGdc1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oy5DbuF7CYPV4PtmLt5437WSeAaoA2AwlwpYpljL60w=;
        b=WNyHIwIQ3ot91IB+TSAplS0bFg+o1Fjo353tRFeyBBArYkofwYzWBts2UFmJJIBjnP
         abq8Gk19YPJQRVHofMB2Xy5aDvj6vqx7eYWrYGFv8/tERGBTz64yUC8dfoVr5hJBbWo5
         +Y2DNI/Z7GKAT+B9O4EDFHZsrt1Md+Edy/rMOUR9e4WMWyAm1YkPzaYN30sGY58oFTm1
         6KROAqp6InhgHRYOX+tFFQfqvE38PiSrkQSncn8WDa/vaWMn32FLO5Ssc1PVZcvQYI0E
         GvG87yjQHrttLmpXzaX7EHrHjv7prGRNXmTsIQ29ZFLl7mBufrvrMBZOnoF79zRLoVgy
         34og==
X-Gm-Message-State: APzg51C6bUpz8ysg9wg0b8vyLOLTW0iTix1IkMv3o2OehQhZKCCrY9ue
        NxucliOlE3tO5QKb9HCMzQ5Mag==
X-Google-Smtp-Source: ANB0Vdao0+AmDrii5YU1+N32s1AluRmUTxrYnXHC9BXCRqQdzsWMn7qD7cvVvFuK2EtF5yGY20K1Qw==
X-Received: by 2002:a63:c245:: with SMTP id l5-v6mr30303669pgg.255.1537323559802;
        Tue, 18 Sep 2018 19:19:19 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id r1-v6sm39294690pfi.17.2018.09.18.19.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 19:19:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH crypto-next 23/23] crypto: skcipher - Remove SKCIPHER_REQUEST_ON_STACK()
Date:   Tue, 18 Sep 2018 19:11:00 -0700
Message-Id: <20180919021100.3380-24-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919021100.3380-1-keescook@chromium.org>
References: <20180919021100.3380-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all the users of the VLA-generating SKCIPHER_REQUEST_ON_STACK()
macro have been moved to SYNC_SKCIPHER_REQUEST_ON_STACK(), we can remove
the former.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/crypto/skcipher.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/crypto/skcipher.h b/include/crypto/skcipher.h
index d00ce90dc7da..45ae894fda32 100644
--- a/include/crypto/skcipher.h
+++ b/include/crypto/skcipher.h
@@ -156,11 +156,6 @@ struct skcipher_alg {
 			    ] CRYPTO_MINALIGN_ATTR; \
 	struct skcipher_request *name = (void *)__##name##_desc
 
-#define SKCIPHER_REQUEST_ON_STACK(name, tfm) \
-	char __##name##_desc[sizeof(struct skcipher_request) + \
-		crypto_skcipher_reqsize(tfm)] CRYPTO_MINALIGN_ATTR; \
-	struct skcipher_request *name = (void *)__##name##_desc
-
 /**
  * DOC: Symmetric Key Cipher API
  *
-- 
2.17.1

