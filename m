Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0526DC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC41E21532
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOJt9uqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC41E21532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753012AbeGDP1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:27:47 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35718 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752381AbeGDP1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:27:44 -0400
Received: by mail-pf0-f194.google.com with SMTP id q7-v6so1756071pff.2;
        Wed, 04 Jul 2018 08:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QsmmNwDklD9Ao74MkW1YEiz0KRzFAzTDNf7xvAAnCHQ=;
        b=KOJt9uqxWmaDtICXyH5SraZMkXD3pv/NiSkb0JVY82xkCBcVyGMDi4ru+v1ByjBhBs
         LyJdxAvP7vKxmjK1taMqcp/R0NgfeKBDyV8Gd4yoBmrZTjBIGnTIkRbbSxQHNAPewmzb
         HDuU8aGP7hL16IamNSANsLj5CcHlBBwtd9aeSfQOgK3KeSPsjgpFXhTPPv/S54rE5H6W
         jEH2eQhixDJg841zX45BffxjHdvN1MlHV6o1GsGRHVjE9nDBagpYslBKdopynNQFNhYc
         BHqVBl7XpEVsVgkn16uMuqK2PsrBdTUed1JAnV92NiwJHHRQjEwuiXl0OcIpwYXDTdnN
         eptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QsmmNwDklD9Ao74MkW1YEiz0KRzFAzTDNf7xvAAnCHQ=;
        b=e2Aj2j7lNp2Jk6OIRNSA/a7YRLXGN/QnDQud11rsH3wt91OCj2H7kG2Wo8VuWJXLqD
         WjifYqRiW96XecxtDBv9C2TPW53hogqvGk7ip+sgtUUhDqUUFr43ydgDCqb+azkdPvRX
         /gAkeUpxQuEbvvxVYBtcu9RbjA8jFOngnlgEYCjMTS9/emyar0kB6Mt2aYA9pYsb6mWS
         66SxO5ik2uUw49HSqsGpY7oGxwTBKPU6wPjHCQ7eTydNbnxVGrI3j342ZQslq20rg/m7
         gM5AjodTJYp/aL8BYDNDnM+aX9Y83VlUtbfWcORvWYCgcH8lvKY9qo692hwmFeiprcgr
         hdLQ==
X-Gm-Message-State: APt69E0npMr4+alKyhkJECZSdZTfooB94/99XrVgQhnBftDrz4kIzmji
        O3EdX9zI2sUBn3gEe+/LNHU=
X-Google-Smtp-Source: AAOMgpdMxGbAzIXkQ/T0QyFQbO6e2fG2unSbwybHs0bl9Ks5AzQj1x4KLU/5SoRbm4cFeQx5BQFbVA==
X-Received: by 2002:a63:b00f:: with SMTP id h15-v6mr2385850pgf.442.1530718063731;
        Wed, 04 Jul 2018 08:27:43 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([183.82.18.94])
        by smtp.gmail.com with ESMTPSA id v89-v6sm13926560pfd.64.2018.07.04.08.27.41
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jul 2018 08:27:42 -0700 (PDT)
Date:   Wed, 4 Jul 2018 21:00:14 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     willy@infradead.org, kwankhede@nvidia.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        svptas.linux@gmail.com, brajeswar.linux@gmail.com,
        sabyasachi.linux@gmail.com, ajitn.linux@gmail.com
Subject: [PATCH] sample/vfio-mdev: Change return type to vm_fault_t
Message-ID: <20180704153014.GA26121@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

convert mbochs_region_vm_fault and mbochs_dmabuf_vm_fault
to return vm_fault_t type.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 samples/vfio-mdev/mbochs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/vfio-mdev/mbochs.c b/samples/vfio-mdev/mbochs.c
index 2960e26..7743fbc 100644
--- a/samples/vfio-mdev/mbochs.c
+++ b/samples/vfio-mdev/mbochs.c
@@ -657,7 +657,7 @@ static void mbochs_put_pages(struct mdev_state *mdev_state)
 	dev_dbg(dev, "%s: %d pages released\n", __func__, count);
 }
 
-static int mbochs_region_vm_fault(struct vm_fault *vmf)
+static vm_fault_t mbochs_region_vm_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct mdev_state *mdev_state = vma->vm_private_data;
@@ -695,7 +695,7 @@ static int mbochs_mmap(struct mdev_device *mdev, struct vm_area_struct *vma)
 	return 0;
 }
 
-static int mbochs_dmabuf_vm_fault(struct vm_fault *vmf)
+static vm_fault_t mbochs_dmabuf_vm_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct mbochs_dmabuf *dmabuf = vma->vm_private_data;
-- 
1.9.1

