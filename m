Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF64C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87372084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E87372084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbeJBFXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 01:23:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:2168 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbeJBFXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 01:23:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2018 15:43:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,329,1534834800"; 
   d="scan'208";a="267577834"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by fmsmga005.fm.intel.com with ESMTP; 01 Oct 2018 15:43:13 -0700
Date:   Mon, 1 Oct 2018 15:43:13 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Russ Anderson <rja@hpe.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Justin Ernst <justin.ernst@hpe.com>, russ.anderson@hpe.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aristeu Rozanski Filho <arozansk@redhat.com>
Subject: [PATCH] EDAC: Don't add devices under /sys/bus/edac
Message-ID: <20181001224313.GA9487@agluck-desk>
References: <20180926130340.6b22918b@coco.lan>
 <20180926161749.GI5584@zn.tnic>
 <20180926181035.GA1132@agluck-desk>
 <20180926182317.patqjso7nzw2oxiz@hpe.com>
 <20180926230257.GA5666@agluck-desk>
 <20180927045244.GA30912@zn.tnic>
 <20180927214400.GA2249@agluck-desk>
 <20180927220355.GF19687@zn.tnic>
 <20180927221054.580220e5@coco.lan>
 <20181001124754.GD7269@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001124754.GD7269@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nobody(*) uses them.  Dropping this will allow us to make the total
number of memory controllers configurable (as we won't have to
worry about duplicated device names under this directory).

(*) https://marc.info/?l=linux-edac&m=153809709903987&w=2

Signed-off-by: Tony Luck <tony.luck@intel.com>
---

Boris: Apply this, then your earlier patch to get rid of the
hard coded limit on the number of memory controllers:
  https://marc.info/?l=linux-edac&m=153797567628947&w=2
the combination works on my 4 socket machine. Perhaps HPE
can test on their superdome.

 drivers/edac/edac_mc_sysfs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 20374b8248f0..4c1bee59c2e6 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -405,7 +405,6 @@ static int edac_create_csrow_object(struct mem_ctl_info *mci,
 				    struct csrow_info *csrow, int index)
 {
 	csrow->dev.type = &csrow_attr_type;
-	csrow->dev.bus = mci->bus;
 	csrow->dev.groups = csrow_dev_groups;
 	device_initialize(&csrow->dev);
 	csrow->dev.parent = &mci->dev;
@@ -636,7 +635,6 @@ static int edac_create_dimm_object(struct mem_ctl_info *mci,
 	dimm->mci = mci;
 
 	dimm->dev.type = &dimm_attr_type;
-	dimm->dev.bus = mci->bus;
 	device_initialize(&dimm->dev);
 
 	dimm->dev.parent = &mci->dev;
@@ -940,7 +938,6 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
 	device_initialize(&mci->dev);
 
 	mci->dev.parent = mci_pdev;
-	mci->dev.bus = mci->bus;
 	mci->dev.groups = groups;
 	dev_set_name(&mci->dev, "mc%d", mci->mc_idx);
 	dev_set_drvdata(&mci->dev, mci);
-- 
2.17.1

