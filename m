Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398E3C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 06:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C926F208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 06:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YJkcRigO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C926F208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeH1Khq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 06:37:46 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:45682 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbeH1Khq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 06:37:46 -0400
Received: by mail-ed1-f54.google.com with SMTP id p52-v6so522838eda.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 23:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:mime-version:thread-index:date:message-id:subject:to:cc;
        bh=qu2vyL1J9ZOyYa2iMrvTGdovkv9TEWup7sxfj4Kv52A=;
        b=YJkcRigOIgDpSO+Pc10MVogrlHfKYupLA9qXAlk3lNwLQl2qjyEIz9NvX1ZrMkoDtF
         nzLXPEmBBUF3LXg13vTlJBG6FvYha36tUef2hRw51MYVvMy0eODsL+6K5K5m/5QoMuwT
         BdE9e6RgR/P01ookH2McBpNi0zn/CEKr0PEo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:thread-index:date:message-id
         :subject:to:cc;
        bh=qu2vyL1J9ZOyYa2iMrvTGdovkv9TEWup7sxfj4Kv52A=;
        b=I/p8FNVpIFvfe3hlO4/xYBiIH+gEabriysIrutxrZqf/IAWAkltNJ21Mdje+XIuJYN
         B0QLM3X80nfJYSNYQzQL3moc4F5El2oeWvUm60mE8CY6oDGkQhjeXPvCP/5HHeFv4ptI
         kYYPIbdPqr+VMAoUypScGTBjSsu7NAgFtkn7E53il9mv7EbgTyiMy50Dp1H5m2ag3elQ
         IECxQ5R4b/uH+armXOKblET8peJgcf+6uacQygIUkXw3ftNMdCyxNK5U2LnBBBgVtCyu
         NS9zQh9WEdMoT8ZqoG4Z2uMEOWI56bXjc2y7rWgeJlnw+GIhADH6rR5Opq+5pyvFd6Uz
         Y1lQ==
X-Gm-Message-State: APzg51DWW8dDN77Qi94TAMXW2+JW0nRXyGcVUAnHUWBNHTCxuc6YmqsO
        2LL51OSp9BERb+exM9P6HmhhndUpKSsgeymrob4Ejw==
X-Google-Smtp-Source: ANB0VdYW8kUg25mOwzuCbDIVQxwaxJfpA/LoA97Mq/pZ0zZUClq1SE0tsLsna39N3DBMbt6UDwI3kART0O0HjED3S0w=
X-Received: by 2002:a50:d75d:: with SMTP id i29-v6mr818080edj.17.1535438855326;
 Mon, 27 Aug 2018 23:47:35 -0700 (PDT)
From:   Sumit Saxena <sumit.saxena@broadcom.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AdQ+miVPsihcmATkRfqx0GqsuSXgZg==
Date:   Tue, 28 Aug 2018 12:17:33 +0530
Message-ID: <453338ab43d43c0bf24acf1aeba95251@mail.gmail.com>
Subject: Affinity managed interrupts vs non-managed interrupts
To:     tglx@linutronix.de
Cc:     Ming Lei <ming.lei@redhat.com>, hch@lst.de,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

We are working on next generation MegaRAID product where requirement is-
to allocate additional 16 MSI-x vectors in addition to number of MSI-x
vectors megaraid_sas driver usually allocates.  MegaRAID adapter supports
128 MSI-x vectors.

To explain the requirement and solution, consider that we have 2 socket
system (each socket having 36 logical CPUs). Current driver will allocate
total 72 MSI-x vectors by calling API- pci_alloc_irq_vectors(with flag-
PCI_IRQ_AFFINITY).  All 72 MSI-x vectors will have affinity across NUMA
nodes and interrupts are affinity managed.

If driver calls- pci_alloc_irq_vectors_affinity() with pre_vectors = 16
and, driver can allocate 16 + 72 MSI-x vectors.
All pre_vectors (16) will be mapped to all available online CPUs but
effective affinity of each vector is to CPU 0. Our requirement is to have
pre_vectors 16 reply queues to be mapped to local NUMA node with effective
CPU should be spread within local node cpu mask. Without changing kernel
code, we can achieve this by driver calling pci_enable_msix_range()
(requesting to allocate 16 + 72 MSI-x vectors) instead of
pci_alloc_irq_vectors() API. If we use pci_enable_msix_range(), it also
requires MSI-x to CPU affinity handled by driver and these interrupts will
be non-managed.

Question is-
Is there any restriction or preference of using
pci_alloc_irq_vectors{/_affinity} vs pci_enable_msix_range in low level
driver?
If driver uses non-managed interrupt, all cases are handled correctly
through irqbalancer. Is there any plan in future to migrate to managed
interrupts entirely or it is a choice based call for driver maintainers?

Thanks,
Sumit
