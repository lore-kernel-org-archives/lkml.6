Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AE84DC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62137208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Vpx+657J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62137208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754946AbeFNKHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:07:34 -0400
Received: from mail-ot0-f174.google.com ([74.125.82.174]:47053 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754709AbeFNKH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:07:29 -0400
Received: by mail-ot0-f174.google.com with SMTP id q1-v6so6385914oth.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 03:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=yy1mL7T18vh71p8O2rU29Bnk8l9Mgbll7Pmm0/nGr+o=;
        b=Vpx+657Jq98fPKuaUHL30QCI3Z0TYBCNWrBBrtQRrK3vPcLarAT21O//dD/sXSIGi5
         QjXs+0nl6r0UeAHqTsv1lE+zA0aq+0Rdly7XCSGUaoQb4C4ZVE5PDmUSLFnRx0gw/j00
         m1r8KIMzi7cSxRBgPFdND2270ZkjT6ayxtQ4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=yy1mL7T18vh71p8O2rU29Bnk8l9Mgbll7Pmm0/nGr+o=;
        b=c3mIAcvb8pKKSQrmBnixsC0PJ4KwjvllSz6Ea7Jovx4zmX7658oOSfboIFF+9ZBbeM
         01p0E2YFau3Tdo9dPSxjbNH7Au4jWKJdvN/sxNDMdWASCxGyazDNjdWpde8UpoAHioem
         Ag0O0l/F35SkStD8tb6g2dx/5N12yDii77SiDQ/0pIK3wpSdJiJQ5Z7pI7LBj7wOFUrj
         Hp/0TvZE9w1nEMRfvQzALsWIlRgBWUcDjNOFo115NXRzQnxGw0Kn9OAXqAcek8x5UGQ9
         obuVsLhfaATcyuY6JUTfX6HgdJZQPjvxCiRJJMvd8tqEvvglU7Ll49ShyB3nhiApNRk6
         Y8fA==
X-Gm-Message-State: APt69E3MgD6/v8vC16iRZMXnA1dD9QqxGx6v25/smk59v8n8locAbg5R
        T3SUzXVW5tu/QoX3ld1IP6T/evlYMKS8CPgbPazddA==
X-Google-Smtp-Source: ADUXVKIpMm3nwpIiR6P1917QfdAHhehsqCKiMwNOGdyaq7Zdm3Esi8qHFQQRsPjv5BtMM/2XQsYTig402kMiUPar/G8=
X-Received: by 2002:a9d:60d2:: with SMTP id b18-v6mr874296otk.305.1528970848685;
 Thu, 14 Jun 2018 03:07:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4044:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 03:07:28
 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Thu, 14 Jun 2018 15:37:28 +0530
Message-ID: <CABe79T41Cr0mjH_k2drzccHvObFwRcW3n+WKCj0JvFUBy0wz-A@mail.gmail.com>
Subject: Requirement to get BAR pci_bus_address in user space
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,


We observed an issue in NVMe CMD cards in SPDK NVMe libraries.
Similar issue fixed with "nvme-pci: Use PCI bus address for
data/queues in CMB" commit in nvme kernel driver.
As per the fix, pci_bus_address of CMB bar is required to program to NVMe cards.

We need to implement similar fix for SPDK NVMe libraries also.

User space libraries get pci device resource information (resource phy
address, resource size) from resource file in sysfs.
But no mechanism available to get  pci_bus_address of corresponding
resource physical address in sysfs.

Please suggest me if any alternate mechanism available to get
pci_bus_address in user space.

Thank you.

Regards,
Srinath.
