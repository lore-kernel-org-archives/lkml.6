Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B843C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 11:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E2D2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 11:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="iMup3Hxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfB0LI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 06:08:28 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41366 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfB0LI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 06:08:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id n2so17431396wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 03:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xVgaF+6RCsy76G62m4+uEGC9wcs64CsqkQWHMsa431Q=;
        b=iMup3HxvT8clgaIFE2CxprbdkRG2pdDGVrQx067aKuQiQ4A0ey688XFpdHh/2tL/QM
         i85zru5+xjngwSMz1F83WUQSayeXV498Ks8+UVO1prQ8PT915qLd7UcTOZOCtREdM5V5
         o75vM/JHplHW223ZSJEE28WX6Jn1es36eUI4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xVgaF+6RCsy76G62m4+uEGC9wcs64CsqkQWHMsa431Q=;
        b=mWjaJciVsgI/FxDTR2m0/0D3DJzZWfkRkaNnXBCuQQCJp71T6XDN933LtPJdByFFHp
         X7hCXiSKgVEKabvskRrvoCOqlBs6aqD9l1hZ9PSAf8VH74GxZszhkbSNqZNuCwW/hbXr
         KLdU5rxmtCY0i6dn7sfEEUxyRojPqDwwWTL9SrHBI9OdG9+gNuhzHQQk+8A1Y/ql5f/6
         30tnEV3uiogjOuy3mWXrZWplzftu1L1UWZvYi3YuOAwuu5zqNo48AoAUGc5zro8L6S67
         6qFEVgJqWxIG2CyaShfwvMKRwP9RT2kE8qMf6EymbJ7pPog2hDHNAir5RM/6CdpEWFBk
         vpCA==
X-Gm-Message-State: APjAAAWphSHiPs9XEm/gT6cwAAyLPPaWyY5hzRMoIkXo7DI0ThEYxSmZ
        T+WsL3rntD9zBLF0EkIHJ33GWg==
X-Google-Smtp-Source: APXvYqzPXthKE7p21sHhQIvApgZp51uV6IMOyRbArPaRyRc7TpMrbtc1pY7xHeWxbmLIBM7YGhqdkQ==
X-Received: by 2002:adf:b741:: with SMTP id n1mr1861847wre.287.1551265706023;
        Wed, 27 Feb 2019 03:08:26 -0800 (PST)
Received: from localhost.localdomain ([5.148.119.11])
        by smtp.gmail.com with ESMTPSA id a20sm996194wmb.17.2019.02.27.03.08.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 03:08:25 -0800 (PST)
From:   Louis Taylor <louis@kragniz.eu>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        ndesaulniers@google.com, Louis Taylor <louis@kragniz.eu>
Subject: [PATCH v2] HID: quirks: use correct format chars in dbg_hid
Date:   Wed, 27 Feb 2019 11:07:20 +0000
Message-Id: <20190227110720.27329-1-louis@kragniz.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226234853.20441-1-louis@kragniz.eu>
References: <20190226234853.20441-1-louis@kragniz.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with -Wformat, clang warns:

drivers/hid/hid-quirks.c:1075:27: warning: format specifies type
'unsigned short' but the argument has type '__u32' (aka 'unsigned int')
[-Wformat]
		  bl_entry->driver_data, bl_entry->vendor,
					 ^~~~~~~~~~~~~~~~
./include/linux/hid.h:1170:48: note: expanded from macro 'dbg_hid'
	  printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);      \
				   ~~~~~~              ^~~
drivers/hid/hid-quirks.c:1076:4: warning: format specifies type
'unsigned short' but the argument has type '__u32' (aka 'unsigned int')
[-Wformat]
		  bl_entry->product);
		  ^~~~~~~~~~~~~~~~~
./include/linux/hid.h:1170:48: note: expanded from macro 'dbg_hid'
	  printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);      \
				   ~~~~~~              ^~~
drivers/hid/hid-quirks.c:1242:12: warning: format specifies type
'unsigned short' but the argument has type '__u32' (aka 'unsigned int')
[-Wformat]
		  quirks, hdev->vendor, hdev->product);
			  ^~~~~~~~~~~~
./include/linux/hid.h:1170:48: note: expanded from macro 'dbg_hid'
	  printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);      \
				   ~~~~~~              ^~~
drivers/hid/hid-quirks.c:1242:26: warning: format specifies type
'unsigned short' but the argument has type '__u32' (aka 'unsigned int')
[-Wformat]
		  quirks, hdev->vendor, hdev->product);
					^~~~~~~~~~~~~
./include/linux/hid.h:1170:48: note: expanded from macro 'dbg_hid'
	  printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);      \
				   ~~~~~~              ^~~
4 warnings generated.

This patch fixes the format strings to use the correct format type for unsigned
ints.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Louis Taylor <louis@kragniz.eu>
---

v2: change format string to use %04x instead of %x

 drivers/hid/hid-quirks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 94088c0ed68a..b608a57b7908 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -1071,7 +1071,7 @@ static struct hid_device_id *hid_exists_dquirk(const struct hid_device *hdev)
 	}
 
 	if (bl_entry != NULL)
-		dbg_hid("Found dynamic quirk 0x%lx for HID device 0x%hx:0x%hx\n",
+		dbg_hid("Found dynamic quirk 0x%lx for HID device 0x%04x:0x%04x\n",
 			bl_entry->driver_data, bl_entry->vendor,
 			bl_entry->product);
 
@@ -1238,7 +1238,7 @@ static unsigned long hid_gets_squirk(const struct hid_device *hdev)
 		quirks |= bl_entry->driver_data;
 
 	if (quirks)
-		dbg_hid("Found squirk 0x%lx for HID device 0x%hx:0x%hx\n",
+		dbg_hid("Found squirk 0x%lx for HID device 0x%04x:0x%04x\n",
 			quirks, hdev->vendor, hdev->product);
 	return quirks;
 }
-- 
2.20.1

