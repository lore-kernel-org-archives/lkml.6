Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E4DECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C7C2086E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="WIUd9J/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C7C2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeJTC2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 22:28:10 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:48188 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeJTC2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 22:28:09 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 2DD66839
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 18:20:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6q3q8e20bB2v for <linux-kernel@vger.kernel.org>;
        Fri, 19 Oct 2018 13:20:57 -0500 (CDT)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id EBA99B05
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 13:20:56 -0500 (CDT)
Received: by mail-it1-f200.google.com with SMTP id 207-v6so4694103itj.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 11:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WXSvFJIXT+uGScquomKG8+xbpaigI0Fwr+jtoZB7FIo=;
        b=WIUd9J/BRO1f0nImqtfl6QES0CSpz/RsphMT4yQXzeeG7nakEB0CnKj08YSgHyjRlZ
         OQU+DAjYBCYBQqJz+MvkmV49i2LmOdshGbLIYDbwDgRlUB1kriZiHVkFPHOzT7rlOir+
         gwpSdsJNwUQRCu758JgbNwQLl9xKbUM30a7GgvL5VAE8cscRKZrfVka5DX/E1MyZuLuG
         iR/00o8TAjlsOcMdQud1zNMfxQUGxKVQygB+85Gr9gyFLFumCE49COGIelHcYIQw/M50
         nQCR+Nh4FYFfUNAbS0GxM+/Y+b2thYRC3SUSEBsQMF1rOubRQ6RskYUH4F8Ab5+O+YfL
         uJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WXSvFJIXT+uGScquomKG8+xbpaigI0Fwr+jtoZB7FIo=;
        b=BphVTPW5dYchGtLBV4we2wKxUFsZZGO0Y6rVEaesRCM/vgRe80IKHw/RvbcAbogbu8
         zCFW+ouzGVfvQKxwdOqh0j6FlHTTpefvu0ZHRUGtpS1Z+XHSK0g9cLhDJRnKHSEOzR0T
         /8zvUC4nMIfOaoD0qa2ohE+BXPOgFqWRHy9ICgZpyWdMyH32M4/2AkzdqfJXS22AnYRd
         dYR2GjOsz79HmO7bqGdEXEfJ+wHEVLADXPApy/5np7XHgkSVL4OlWLKc8vWUPNDfotfp
         y9kXXa4JiVBigxdMb3xAdfjuH+pW3TZ1eKuQNsPgdWtimgB0h4APH7RZ1c/cYXvSaiYZ
         YH2Q==
X-Gm-Message-State: AGRZ1gJXHVYWAfqk96MBVIVw5O34DG6GhWA0J+EnAMEP8O4BEqnZ/+/1
        PCG59BpZwQO2ELE1hY27JDvFxQrXQj0Qo3xyFlyit0xk1nX/A9eZlZQI8jAnoXxLF2iovY/ypJQ
        7HxF71J+46peAkksNZACQEX4PlWHj
X-Received: by 2002:a6b:b383:: with SMTP id c125-v6mr3616422iof.267.1539973256632;
        Fri, 19 Oct 2018 11:20:56 -0700 (PDT)
X-Google-Smtp-Source: AJdET5fMuchsU2ck5rSP3eoTTWZQ8mAJNSB9irL2CKISGdoQ3hWOi28EgyNlaqCc3Xg5R30CJ21i/Q==
X-Received: by 2002:a6b:b383:: with SMTP id c125-v6mr3616414iof.267.1539973256458;
        Fri, 19 Oct 2018 11:20:56 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id q123-v6sm9073277iod.23.2018.10.19.11.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Oct 2018 11:20:55 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Intel SCU Linux support <intel-linux-scu@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org (open list:INTEL C600 SERIES SAS CONTROLLER
        DRIVER), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] scsi: isci: Fix a missing-check bug
Date:   Fri, 19 Oct 2018 13:20:43 -0500
Message-Id: <1539973243-12774-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In isci_request_oprom(), a for loop is used to find the OEM table by
scanning the signature, which has four bytes. In each iteration, the
signature is copied from the IO memory region 'oprom + i' to 'oem_sig'
through memcpy_fromio(). Then 'oem_sig' is checked to see whether it is
ISCI_OEM_SIG. If yes, the OEM table is found. Next, the header of the rom,
including the signature, is then copied to 'oem_hdr' through
memcpy_fromio(). It is obvious that the signature is copied twice here.
Given that the device also has the permission to access the IO memory
region, it is possible that a malicious device controlled by an attacker
can modify the signature between these two copies. By doing so, the
attacker can supply unexpected signatures, which can cause undefined
behavior of the kernel and introduce potential security risk.

This patch rewrites the signature after the second copy, using the value
obtained in the first copy, and thus avoids the above issue.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/scsi/isci/probe_roms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/isci/probe_roms.c b/drivers/scsi/isci/probe_roms.c
index a2bbe46..bff54f2 100644
--- a/drivers/scsi/isci/probe_roms.c
+++ b/drivers/scsi/isci/probe_roms.c
@@ -68,6 +68,7 @@ struct isci_orom *isci_request_oprom(struct pci_dev *pdev)
 			size_t copy_len;
 
 			memcpy_fromio(&oem_hdr, oprom + i, sizeof(oem_hdr));
+			memcpy(&oem_hdr.sig, oem_sig, ISCI_OEM_SIG_SIZE);
 
 			copy_len = min(oem_hdr.len - sizeof(oem_hdr),
 				       sizeof(*rom));
-- 
2.7.4

