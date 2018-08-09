Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2501DC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A2D22392
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A2D22392
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeHIWac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 18:30:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50342 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbeHIWac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 18:30:32 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 48BFF308FBAB;
        Thu,  9 Aug 2018 20:04:09 +0000 (UTC)
Received: from gimli.home (ovpn-116-35.phx2.redhat.com [10.3.116.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B7DBA4B9B;
        Thu,  9 Aug 2018 20:04:04 +0000 (UTC)
Subject: [PATCH v4 0/3] PCI: NVMe reset quirks
From:   Alex Williamson <alex.williamson@redhat.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Date:   Thu, 09 Aug 2018 14:04:03 -0600
Message-ID: <153384487209.15793.15203778129263981368.stgit@gimli.home>
User-Agent: StGit/0.18-136-gffd7-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 09 Aug 2018 20:04:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4: Fix 0-day i386 build error for readq, simply use readl
    instead, the bits we're interested in are 24:31 and the NVMe
    spec indicates that smaller, aligned accesses are allowed.
    Update bz links for both device specific resets.

v3: Separate quirks, only for the afflicted devices

v2: Add bug link, use Samsung vendor ID, add spec references

Fix two different NVMe device reset issues with device specific
quirks.  The Samsung controller in patch 2 sometimes doesn't like
being reset while enabled, so disable the NVMe controller prior to
FLR.  This quirk is generic to all NVMe class devices, though I've
dropped the additional delay some devices require between disabling
and checking ready status.  This can be added later should any of
those devices need this quirk.  The Intel controller quirk is now
just a simple delay after FLR, which clearly any device needing
similar behavior can also use.  Thanks,

Alex

---

Alex Williamson (3):
      PCI: Export pcie_has_flr()
      PCI: Samsung SM961/PM961 NVMe disable before FLR quirk
      PCI: Intel DC P3700 NVMe delay after FLR quirk


 drivers/pci/pci.c    |    3 +
 drivers/pci/quirks.c |  105 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h  |    1 
 3 files changed, 108 insertions(+), 1 deletion(-)
