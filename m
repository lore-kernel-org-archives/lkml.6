Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836E4C282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 04:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7352148D
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 04:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7HjVuVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfA0EMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 23:12:15 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52464 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfA0EMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 23:12:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so10437726wml.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 20:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:references;
        bh=VgvZcxRTKZNydZGMeLnIIEEwY33IYJfdy58ePKF8fks=;
        b=c7HjVuVuxsfVxbY0XM1rrdYvfjT7xyNgGpSxMsBeC3xon/aNnnBfIGnR9iv4r7dSAL
         bCDr/BRfBBYe9dtdvY9729Z0KnCb9CDyYfwx7DwXMLn66Bu/qcPOBzsHS1WQb1/gZPiU
         WRZIQpfYootkmMvHDPl6ya1g5I9WjT8Fw4cpPA0bBetBJWxdrczsMF1bFlZNIpcd/yRr
         kMMse7Y8kWtHRzV7sk8eG/FmB3W7lpiogd9lDm74oZi344vkAd12ggLNcccWJbdS30cc
         0pIMqZyY3FRVJIdRh1TbTtKNYQPUFKkyth4msUye8J/GeGE8T6FuxeXZBRzLfXSdyp/O
         WQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:references;
        bh=VgvZcxRTKZNydZGMeLnIIEEwY33IYJfdy58ePKF8fks=;
        b=frE3eKDluYCg12quRZIDUOe3Dapeu2jDPSvyJr047tfBZsFkalNIDTPLCUt8zoiion
         Z9a2MA/lsZD7MaOCnZgLJqpwBgRK48YFTLm51mI7psTtTL/PEHx8fOFNlXNtv+/3C+FZ
         NW0H05tljucdeKzRpSBAmdHREHKc/Vd7+f2q52pZLHoE84tMIW3i4qVQ7+C+NV8SD6na
         MK5sSb0IPn+exsIijz/5RSIWNr24CuTvO0SVfHPqEui5VRgG4cHDTXe7+vUTF74uyrjK
         AREAZEUCQvQ2J16/M8qrwBJL47v1l6Et/jdxzNAL2VKOtd8HWjM3jSrszVthWFZZ6SZx
         ciCg==
X-Gm-Message-State: AJcUukeQxKD3dqMQCTVKYIJzfFCTTwJg8QbJWSFPJpTEd85BLImk7RAH
        eljSJnuqG2jYhmNYOjZul0E=
X-Google-Smtp-Source: ALg8bN4P76UKQ5q8W5T/wvwJpic1NAF3KRjstmwQ+BAUPx+UNRPmMVKLGyuhEmZNc7xjYLSz8jZWrA==
X-Received: by 2002:a1c:4c0c:: with SMTP id z12mr11448849wmf.17.1548562332792;
        Sat, 26 Jan 2019 20:12:12 -0800 (PST)
Received: from localhost ([81.17.27.135])
        by smtp.gmail.com with ESMTPSA id v6sm107229768wrd.88.2019.01.26.20.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Jan 2019 20:12:12 -0800 (PST)
From:   Yang Fan <nullptr.cpp@gmail.com>
To:     rppt@linux.ibm.com, william.kucharski@oracle.com,
        akpm@linux-foundation.org, will.deacon@arm.com
Cc:     Yang Fan <nullptr.cpp@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/mmap.c: Remove some redundancy in arch_get_unmapped_area_topdown()
Date:   Sun, 27 Jan 2019 05:11:12 +0100
Message-Id: <20190127041112.25599-1-nullptr.cpp@gmail.com>
X-Mailer: git-send-email 2.17.1
References: <cover.1547966629.git.nullptr.cpp@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'addr' is redundant in arch_get_unmapped_area_topdown(), 
just use parameter 'addr0' directly. Then remove the const qualifier 
of the parameter, and change its name to 'addr'.

And in according with other functions, remove the const qualifier of all 
other no-pointer parameters in function arch_get_unmapped_area_topdown().

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Yang Fan <nullptr.cpp@gmail.com>
---
Changes in v2:
  - Merge the two patches into one.

 mm/mmap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index f901065c4c64..84cdde125d4d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2126,13 +2126,12 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
  */
 #ifndef HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
 unsigned long
-arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
-			  const unsigned long len, const unsigned long pgoff,
-			  const unsigned long flags)
+arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
+			  unsigned long len, unsigned long pgoff,
+			  unsigned long flags)
 {
 	struct vm_area_struct *vma, *prev;
 	struct mm_struct *mm = current->mm;
-	unsigned long addr = addr0;
 	struct vm_unmapped_area_info info;
 	const unsigned long mmap_end = arch_get_mmap_end(addr);
 
-- 
2.17.1

