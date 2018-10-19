Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F2BECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 20:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03A521476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 20:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="bTr4bHyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03A521476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbeJTErI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 00:47:08 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:45000 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbeJTErI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 00:47:08 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id EBC4ECFD
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 20:39:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8j3vWuAI9_Xb for <linux-kernel@vger.kernel.org>;
        Fri, 19 Oct 2018 15:39:26 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id BC83180E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 15:39:26 -0500 (CDT)
Received: by mail-io1-f70.google.com with SMTP id f9-v6so31255037iok.23
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 13:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8xYoiRynmnEoMoJLcYQvBlb5siR4tDJjtLBRz6IrP84=;
        b=bTr4bHyVTmxp5TjN/XzPj31Q574T+9i6j5m1ZY9g+7lbZMWVNMBuObw1+S2JYbnmFx
         wnFA4UGSE0WZKx//S9EgwdSy5cKMwP33/VsDVwxXz+4kX65i1T6KLD7y0LhN6z8XB8ZR
         g6sXeTwlyAB908cg9posXrTJrFsOOYPrik/r9xMwUUhMF/2mZcO72OCjLKio/LLv2cnX
         Vso7vQvgBw2LJsj84mSTlm3qgyMsvkkuoBGU6QwUmz1XnAUUwruuTE0WJHDqR8yzvgQ7
         PlhxTR+Gv1sAV86yX3mZtULOiOLzugvEyQIYoCPo5qlLN++7ffkx6vFByI6eGjgK0bh0
         G9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8xYoiRynmnEoMoJLcYQvBlb5siR4tDJjtLBRz6IrP84=;
        b=iNnLrj1cq4kZFjNwJ3wXUWon5T4vEL4fjCHtlaMhj6G6Ln/1Py9uBFDsymVqChWTCy
         nqCiq9NlPY9ooZQ2ITXqzgLokV7ll9XmWBkpim6nseY3+YWVGQxchd5M10hUntNkwfvt
         0I3UlUI4VJI40gO1yHr1R1UuzcbHTMlwtSMTEObvQ1o9U7Z0C90KTkvc5qVF2sYrm42/
         lrHBtwRDywkkMuL5Tmhfvio8exFZqAcpE4tThgzfUOTKQVOjRPV2wUilu1wVe9w04EYU
         PT+E7gKoYhvNquEI0izFG/TfrVr0uWBQvJsKzcnxNDb09vMBOTIb1jRqmZ8ldTC7A7JG
         NRBQ==
X-Gm-Message-State: AGRZ1gKstlU1fdAeeWrBJDAq6U3x6D+EkXzO4hghBKVjLom2or2HdCn2
        Ny9P53RA79hL1FTltQpczzUI9iIz2K+x6d1T7mYHJYlx6cRh93dlYnRRZ+u7sTFXrdz2EKCNHZp
        hxaabxeORaVARzUbnVuypu12hswc0
X-Received: by 2002:a5e:dd0a:: with SMTP id t10-v6mr3964761iop.62.1539981566037;
        Fri, 19 Oct 2018 13:39:26 -0700 (PDT)
X-Google-Smtp-Source: AJdET5e9D2AwVhI+4ifydxZ1szmWyEZb8Y/yYPv7TgFl9kHsKXwqwRsV16mH7W/yz9VE6stCb570SA==
X-Received: by 2002:a5e:dd0a:: with SMTP id t10-v6mr3964752iop.62.1539981565780;
        Fri, 19 Oct 2018 13:39:25 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id 82-v6sm1595304ita.17.2018.10.19.13.39.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Oct 2018 13:39:24 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
        linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] video: fbdev: sis: fix a missing-check bug
Date:   Fri, 19 Oct 2018 15:39:17 -0500
Message-Id: <1539981557-13590-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sisfb_find_rom(), the official pci ROM is checked to see whether it
contains the expected value at specific locations. This is done by firstly
mapping the rom into the IO memory region 'rom_base' and then invoking
sisfb_check_rom() to perform the checks. If the checks succeed, i.e.,
sisfb_check_rom() returns 1, the whole content of the rom is then copied to
'myrombase' through memcpy_fromio(). The problem here is that the checks
are conducted on the IO region 'rom_base' directly. Given that the device
also has the permission to access the IO region, it is possible that a
malicious device controlled by an attacker can race to modify the values in
the region after the checks but before memcpy_fromio(). By doing so, the
attacker can supply unexpected roms, which can cause undefined behavior of
the kernel and introduce potential security risk. The following for loop
also has a similar issue.

To avoid the above issue, this patch firstly copies the content of the rom
and then performs the checks on the copied version. If all the checks are
satisfied, the copied version will then be returned.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/video/fbdev/sis/sis_main.c | 52 ++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 30 deletions(-)

diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/sis/sis_main.c
index 20aff90..a2d8051 100644
--- a/drivers/video/fbdev/sis/sis_main.c
+++ b/drivers/video/fbdev/sis/sis_main.c
@@ -4089,29 +4089,29 @@ static int __init sisfb_setup(char *options)
 }
 #endif
 
-static int sisfb_check_rom(void __iomem *rom_base,
+static int sisfb_check_rom(unsigned char *rom_base,
 			   struct sis_video_info *ivideo)
 {
-	void __iomem *rom;
+	unsigned char *rom;
 	int romptr;
 
-	if((readb(rom_base) != 0x55) || (readb(rom_base + 1) != 0xaa))
+	if ((*rom_base != 0x55) || (*(rom_base + 1) != 0xaa))
 		return 0;
 
-	romptr = (readb(rom_base + 0x18) | (readb(rom_base + 0x19) << 8));
+	romptr = (*(rom_base + 0x18) | (*(rom_base + 0x19) << 8));
 	if(romptr > (0x10000 - 8))
 		return 0;
 
 	rom = rom_base + romptr;
 
-	if((readb(rom)     != 'P') || (readb(rom + 1) != 'C') ||
-	   (readb(rom + 2) != 'I') || (readb(rom + 3) != 'R'))
+	if ((*(rom)     != 'P') || (*(rom + 1) != 'C') ||
+	   (*(rom + 2) != 'I') || (*(rom + 3) != 'R'))
 		return 0;
 
-	if((readb(rom + 4) | (readb(rom + 5) << 8)) != ivideo->chip_vendor)
+	if ((*(rom + 4) | (*(rom + 5) << 8)) != ivideo->chip_vendor)
 		return 0;
 
-	if((readb(rom + 6) | (readb(rom + 7) << 8)) != ivideo->chip_id)
+	if ((*(rom + 6) | (*(rom + 7) << 8)) != ivideo->chip_id)
 		return 0;
 
 	return 1;
@@ -4124,6 +4124,10 @@ static unsigned char *sisfb_find_rom(struct pci_dev *pdev)
 	unsigned char *myrombase = NULL;
 	size_t romsize;
 
+	myrombase = vmalloc(65536);
+	if (!myrombase)
+		return NULL;
+
 	/* First, try the official pci ROM functions (except
 	 * on integrated chipsets which have no ROM).
 	 */
@@ -4131,20 +4135,15 @@ static unsigned char *sisfb_find_rom(struct pci_dev *pdev)
 	if(!ivideo->nbridge) {
 
 		if((rom_base = pci_map_rom(pdev, &romsize))) {
-
-			if(sisfb_check_rom(rom_base, ivideo)) {
-
-				if((myrombase = vmalloc(65536))) {
-					memcpy_fromio(myrombase, rom_base,
-							(romsize > 65536) ? 65536 : romsize);
-				}
-			}
+			memcpy_fromio(myrombase, rom_base,
+					(romsize > 65536) ? 65536 : romsize);
 			pci_unmap_rom(pdev, rom_base);
+
+			if (sisfb_check_rom(myrombase, ivideo))
+				return myrombase;
 		}
 	}
 
-	if(myrombase) return myrombase;
-
 	/* Otherwise do it the conventional way. */
 
 #if defined(__i386__) || defined(__x86_64__)
@@ -4156,24 +4155,17 @@ static unsigned char *sisfb_find_rom(struct pci_dev *pdev)
 			rom_base = ioremap(temp, 65536);
 			if (!rom_base)
 				continue;
-
-			if (!sisfb_check_rom(rom_base, ivideo)) {
-				iounmap(rom_base);
-				continue;
-			}
-
-			if ((myrombase = vmalloc(65536)))
-				memcpy_fromio(myrombase, rom_base, 65536);
-
+			memcpy_fromio(myrombase, rom_base, 65536);
 			iounmap(rom_base);
-			break;
 
+			if (sisfb_check_rom(myrombase, ivideo))
+				return myrombase;
 		}
 
 	}
 #endif
-
-	return myrombase;
+	vfree(myrombase);
+	return NULL;
 }
 
 static void sisfb_post_map_vram(struct sis_video_info *ivideo,
-- 
2.7.4

