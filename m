Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4604CC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE9E20811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dOmth98p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE9E20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbeLLFqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 00:46:30 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46426 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbeLLFq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 00:46:29 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so16301537wrt.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 21:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iYjpjhqWEVdwBSRetUBfnfvuhWcZhfMXzJpWRMq2qFU=;
        b=dOmth98pTDIjOQZ70Stz7JOrHKvOAwm0y87/L587hKd46tEdpGlBBeYY6MbBR6TSLC
         neKsajk873us1d/w11Z4bqo1fXTiCKBeDL6Em7krdzObTeUWmkh2ONBNQkr/+Hjacq3n
         SbWEUidJtWZ1RCTe0zjiohtspg91WzlBDGyQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iYjpjhqWEVdwBSRetUBfnfvuhWcZhfMXzJpWRMq2qFU=;
        b=Dw2vE8dajYoqZEEIVGx4UgLcxN8xrTFDY9j2Zkf5Uvvn0E2ji2yzhebpnF75Y7+Wek
         3p/UFz9QvLl6J1w7SpU6Ds8luQLPKD9i3rQP4Lb7hHaVh11NLQDsONP/eBV9KGxEKuSE
         vN3o6C26Ap4k4BB3W3wXp4Mla8UHk6IWO6YFKR4ekcuMB2EAW+QeyzSa5NjumzZwua1U
         SKP+etxuw/JbayryZya9RtJH4tkCRjBqFewOYaAqlLfIRaJ08Wu/B4LGMYHOJZ9tNl7Z
         cb452lW9vAPTIe9n9Qped0J6gqaH+bpEi5icsPWJX2gT0uw0OKhEAZgFAedhAvQBa/LS
         u2/A==
X-Gm-Message-State: AA+aEWZGQnkmpyJdu7CPoeO5LHA/JBUq1n64UB9vI0Fv7r8njb4RpEIw
        mejHdj+SkPvNBzue2iIzLiq1qA==
X-Google-Smtp-Source: AFSGD/WHzBH6vUYB80WSgOhqfoFb89sO27o2t9d+uHDivBQ8B7BdAO9zeF3PYDofDU8E+CUrFoQL6g==
X-Received: by 2002:adf:f5d1:: with SMTP id k17mr17321627wrp.59.1544593586849;
        Tue, 11 Dec 2018 21:46:26 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z206sm2015947wmc.18.2018.12.11.21.46.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Dec 2018 21:46:25 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [RFC PATCH 0/3] PCIe Host request to reserve IOVA
Date:   Wed, 12 Dec 2018 11:16:06 +0530
Message-Id: <1544593569-8923-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few SOCs have limitation that their PCIe host
can't allow few inbound address ranges.
Allowed inbound address ranges are listed in
dma-ranges DT property and this address ranges
are required to do IOVA mapping.
Remaining address ranges have to be reserved in
IOVA mapping.

PCIe Host driver of those SOCs has to list all
address ranges which have to reserve their IOVA
address into PCIe host bridge resource entry list.
IOMMU framework will reserve these IOVAs while
initializing IOMMU domain.

This patch set is based on Linux-4.19-rc1.

Srinath Mannam (3):
  PCI: Add dma-resv window list
  iommu/dma: IOVA reserve for PCI host reserve address list
  PCI: iproc: Add dma reserve resources to host

 drivers/iommu/dma-iommu.c           |  8 ++++++
 drivers/pci/controller/pcie-iproc.c | 49 +++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c                 |  3 +++
 include/linux/pci.h                 |  1 +
 4 files changed, 61 insertions(+)

-- 
2.7.4

