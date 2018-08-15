Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32668C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C975321473
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O/gYJBMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C975321473
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbeHOWHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 18:07:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36796 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbeHOWHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 18:07:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id h12-v6so914772pgs.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 12:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=pTX9ZBM0lo/9R3KAJqHp5EcmXEzBdg9wbtQtlj3XAWk=;
        b=O/gYJBMG0ZYa5fdPzp8dOetwJRI7GNkqcsXNrtBN+fSRnySoMFGj+pL+/7yNpAJNm4
         oYs/VlS1HKRw/yg/TET97vv5eK5OEKoqQQhz3knqyiwED1DVMyhQWnCkgTUTphKutdtQ
         BRJXKEuh+cDbgb08MpyBpZo6FATZbuJzHNkFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=pTX9ZBM0lo/9R3KAJqHp5EcmXEzBdg9wbtQtlj3XAWk=;
        b=p+T9wGveQGiwMbpdo0bR+hugvcl+xyFV0Gmb9ujjQxay/VFEMwxCh9F4NOqOtu4hEo
         0ZIQlOxFUNsMJ4U3mrRIlAiFTUfk6qGemky08RYSGNQgZ4JQOcdTdodAnI+59BEi7cuS
         QmD8pMhiNnmN6CJ1VBRt4TFI3otoWuGJ7eaLVFRSr0CBAJrb764yePUmVCmNGdKjcsre
         8+shi+07lpP0HTE5yIKCIKhHzPf0e+wCHfVO88jgu5uumv+Op4iihNr8K475IHNUuP7f
         j5IOzM8EFoQilfv5GlcdWym+rJaie9O7pgghmJfpnQeh5D9cjor6HTRkcY4IDzYMOl5f
         tugA==
X-Gm-Message-State: AOUpUlF5SUmV3jSWHWrCZLWDdDr+8x8e3ragYHN+NlLp8SyQ6ZuXcjVD
        Sskkm+tFP0QDzYMKqkguJCcyEg==
X-Google-Smtp-Source: AA+uWPzJsJtZYl1KqcRt+q3S2L1tQjzOW7LbecEC6e+f3S5m22/kHZ1/9KB7HWMBz4SCsmkPHDSrnA==
X-Received: by 2002:a63:2647:: with SMTP id m68-v6mr26241556pgm.60.1534360447092;
        Wed, 15 Aug 2018 12:14:07 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id j191-v6sm39342410pfc.136.2018.08.15.12.14.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 12:14:05 -0700 (PDT)
Date:   Wed, 15 Aug 2018 12:14:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Karsten Keil <isdn@linux-pingi.de>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] isdn: Disable IIOCDBGVAR
Message-ID: <20180815191405.GA29528@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was possible to directly leak the kernel address where the isdn_dev
structure pointer was stored. This is a kernel ASLR bypass for anyone
with access to the ioctl. The code had been present since the beginning
of git history, though this shouldn't ever be needed for normal operation,
therefore remove it.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Cc: Karsten Keil <isdn@linux-pingi.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
netdev doesn't like explict stable markings, so I'll just ask here that it
get included in -stable please. :)
---
 drivers/isdn/i4l/isdn_common.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/isdn/i4l/isdn_common.c b/drivers/isdn/i4l/isdn_common.c
index 7a501dbe7123..6a5b3f00f9ad 100644
--- a/drivers/isdn/i4l/isdn_common.c
+++ b/drivers/isdn/i4l/isdn_common.c
@@ -1640,13 +1640,7 @@ isdn_ioctl(struct file *file, uint cmd, ulong arg)
 			} else
 				return -EINVAL;
 		case IIOCDBGVAR:
-			if (arg) {
-				if (copy_to_user(argp, &dev, sizeof(ulong)))
-					return -EFAULT;
-				return 0;
-			} else
-				return -EINVAL;
-			break;
+			return -EINVAL;
 		default:
 			if ((cmd & IIOCDRVCTL) == IIOCDRVCTL)
 				cmd = ((cmd >> _IOC_NRSHIFT) & _IOC_NRMASK) & ISDN_DRVIOCTL_MASK;
-- 
2.17.1


-- 
Kees Cook
Pixel Security
