Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EC0C00449
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 14:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B666F2086D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 14:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="NDspYlSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B666F2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbeJGVwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 17:52:09 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:38668 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbeJGVwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 17:52:09 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id F2332F00
        for <linux-kernel@vger.kernel.org>; Sun,  7 Oct 2018 14:44:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id J-_wnVMhfsVn for <linux-kernel@vger.kernel.org>;
        Sun,  7 Oct 2018 09:44:39 -0500 (CDT)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id C35BBB13
        for <linux-kernel@vger.kernel.org>; Sun,  7 Oct 2018 09:44:39 -0500 (CDT)
Received: by mail-it1-f197.google.com with SMTP id v13-v6so7525711itc.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 07:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zmJW304Drts08w59yTcGYvwTGz4bjKkqz7qCSzjGoZ4=;
        b=NDspYlSousdaNdoya8xkYzkI2eVao1E+qLaUwNfbz7IT9Ey8uxRn+iZghYvcYA3JIY
         3l/3SRHgTKhRA4FzcAfbcXVbc1N/jyQ3b8V/VL3dPhcJeXNhL9SFNBT5C3SjhY81i61X
         jhh4iaFC7AuHbEywlXdyNhYZyfDlgeFROE9wmnJWzo2Mcse/WmeNSXDuij4EhJ3XEdNl
         VK1mOgVCZDyeW7vF2TXgFr7EgkYichTcCPMbVWBcaFa+393x99JpLiZ9Pkx8c1SXUuNJ
         URsM2RidfIG50P0Y9qVmksTVCe0FCM9sEW010y5sOEP3VUq3kJn6oZS7AMSS8rvewa2g
         e0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zmJW304Drts08w59yTcGYvwTGz4bjKkqz7qCSzjGoZ4=;
        b=heqYCOYeiWq7/XtIXSsfyxMXo/UYZ5AcDGIeObB6Cp11cCI9q7dVNfSKhI3jgztEy6
         JI2lOhxv5uf7ZA40+TVSUX+kxqiWgTK2JXn3oTLQprbC0foAX85fkCe9pCbcW8n0uGQc
         YlYiwncl0JlDXRWM+IRoe0IHgEZyKsJDzAVtmSOoQwq2RpChn8IQqniS+xAh1K7yIugV
         hJkF8awjd0GPcPDjBPU9v7gSF79+T5eKVH5uNWWQ8yKsZg4sphylLzrlbjBK3y8gneb0
         Lm+Z5T2lUTD8Ssd4aFIWBnvSWUUjYw/zRIsJ2y89QvCLqDLNv+gO5suJlgQFA+GoSlUh
         4neQ==
X-Gm-Message-State: ABuFfoj4pD5996UjXAp0czXorhMMJ0F+mtp5bLP7BHBOwUard2HR1zOh
        7LFsb0uKIDhES8Gb9dmpbwXDcb0aN0ZFHvdfZt0/r8Mxo7DJFmps3woTOKxHRzXVLC8t63ajyYp
        efJD8tEaIwpJ/HnKHoW9WigvBHjZ+
X-Received: by 2002:a6b:1f8b:: with SMTP id f133-v6mr13315506iof.179.1538923479406;
        Sun, 07 Oct 2018 07:44:39 -0700 (PDT)
X-Google-Smtp-Source: ACcGV60pBuhba1ijY7WQ3k77P1Z0AQjKPMPSzgC/odPaSIeoidnTvjyGvpkVoGygVQERjkhbbY7SFg==
X-Received: by 2002:a6b:1f8b:: with SMTP id f133-v6mr13315500iof.179.1538923479199;
        Sun, 07 Oct 2018 07:44:39 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id n5-v6sm2115015ioh.58.2018.10.07.07.44.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Oct 2018 07:44:38 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Alex Williamson <alex.williamson@redhat.com>,
        kvm@vger.kernel.org (open list:VFIO DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drivers/vfio: Fix a redundant copy bug
Date:   Sun,  7 Oct 2018 09:44:25 -0500
Message-Id: <1538923466-29705-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vfio_spapr_iommu_eeh_ioctl(), if the ioctl command is VFIO_EEH_PE_OP,
the user-space buffer 'arg' is copied to the kernel object 'op' and the
'argsz' and 'flags' fields of 'op' are checked. If the check fails, an
error code EINVAL is returned. Otherwise, 'op.op' is further checked
through a switch statement to invoke related handlers. If 'op.op' is
VFIO_EEH_PE_INJECT_ERR, the whole user-space buffer 'arg' is copied again
to 'op' to obtain the err information. However, in the following execution
of this case, the fields of 'op', except the field 'err', are actually not
used. That is, the second copy has a redundant part. Therefore, for both
performance and security reasons, the redundant part of the second copy
should be removed.

This patch removes such a part in the second copy. It only copies the 'err'
information from the buffer 'arg'.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/vfio/vfio_spapr_eeh.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio_spapr_eeh.c b/drivers/vfio/vfio_spapr_eeh.c
index 38edeb4..5bc4b60 100644
--- a/drivers/vfio/vfio_spapr_eeh.c
+++ b/drivers/vfio/vfio_spapr_eeh.c
@@ -86,10 +86,10 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
 			ret = eeh_pe_configure(pe);
 			break;
 		case VFIO_EEH_PE_INJECT_ERR:
-			minsz = offsetofend(struct vfio_eeh_pe_op, err.mask);
-			if (op.argsz < minsz)
+			if (op.argsz < sizeof(op))
 				return -EINVAL;
-			if (copy_from_user(&op, (void __user *)arg, minsz))
+			if (copy_from_user(&op.err, (char __user *)arg +
+						minsz, sizeof(op.err)))
 				return -EFAULT;
 
 			ret = eeh_pe_inject_err(pe, op.err.type, op.err.func,
-- 
2.7.4

