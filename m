Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E53C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99EB420878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=fugz2012@zoho.com header.b="Dx6Ulynk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99EB420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zoho.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbeJBKb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 06:31:29 -0400
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25437 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbeJBKb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 06:31:29 -0400
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Oct 2018 06:31:28 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1538451310; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=D7b9HT2CTLt6x5fzI9TjuxtW/eKCjns2eb1Uy4/nYI54dMIkoxTPCjhmknp2Qc6Zy+CSJIERS+jiy1iHLwOh0aqzAMHw8Awop1ti9BU6tqEo+Q+8Arm0d+9PUGjHcUWiINMYiZpBN6B/7AcuEBJHOLDeqT0Yj1ESOMMzj5q7CJY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1538451310; h=Cc:Date:From:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=6fo8BclJw9yZ+/naCfnmfTjSQCGmEKIXPZrL7jdSjio=; 
        b=d/6R9n0xYTWPPtFOzafobHp9B5Mb+5CcYzPzHYOjqevpKrjOl7KF1Loqa05LOYz0YRVRq1MQ9cMLw4iIJatdKWELtaMgYbZ+T35prj7QjqVlwLE2v3Yg4I7slyQcMMKz0Wd86tCaQqpEHesMxLWtiWCF/pMmumdD4ylZ3SynvNw=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=fugz2012@zoho.com;
        dmarc=pass header.from=<fugz2012@zoho.com> header.from=<fugz2012@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=SX2eadM0/KeCEj1fzSSdprFgJN3H9sXEDQQlpA3Vfcow66HKW08OCEDIP3e471vXVar/89dB3m7Q
    U/7XIWnDZygqRoMpOexoRTE96G3FktrhOP6FYigrv3nlr3wDmC6S  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1538451310;
        s=default; d=zoho.com; i=fugz2012@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id; l=799;
        bh=6fo8BclJw9yZ+/naCfnmfTjSQCGmEKIXPZrL7jdSjio=;
        b=Dx6Ulynk7E0VzXBnGuJKRIoErup5CAyyzRYRRMhqgUM9Gmy/z5oK/N6Ntqx/2GGb
        QcGnadU8Qx955E10iKtJIqCD2pWa+9yzcDxbojieVqib2gA5ltsUyQGJfjAL85jBJiM
        ZqmCpWG5qcLGo7FUFrJvYF9S0Mv+G+akT8G4FB5A=
Received: from localhost.localdomain (111.196.209.82 [111.196.209.82]) by mx.zohomail.com
        with SMTPS id 1538451308755325.76493684998684; Mon, 1 Oct 2018 20:35:08 -0700 (PDT)
From:   GuangZhe Fu <fugz2012@zoho.com>
To:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Cc:     dan.j.williams@intel.com, ross.zwisler@linux.intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com, fugz2012@zoho.com,
        GuangZhe Fu <fugz1@lenovo.com>
Subject: [PATCH] libnvdimm, namespace: Drop the repeat assignment for variable dev->parent
Date:   Mon,  1 Oct 2018 23:35:00 -0400
Message-Id: <20181002033500.3383-1-fugz2012@zoho.com>
X-Mailer: git-send-email 2.9.5
X-ZohoMailClient: External
X-ZohoMail: Z_672410577 SPT_1 SLF_E S_173 ZMSCN
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: GuangZhe Fu <fugz1@lenovo.com>

The variable dev-parent is assigned twice with the same &nd_region->dev. I think we could drop the second one.

Signed-off-by: GuangZhe Fu <fugz1@lenovo.com>
---
 drivers/nvdimm/namespace_devs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index cb322f2..db0abf1 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -2099,7 +2099,6 @@ static struct device *nd_namespace_pmem_create(struct nd_region *nd_region)
 		return NULL;
 	}
 	dev_set_name(dev, "namespace%d.%d", nd_region->id, nspm->id);
-	dev->parent = &nd_region->dev;
 	dev->groups = nd_namespace_attribute_groups;
 	nd_namespace_pmem_set_resource(nd_region, nspm, 0);
 
-- 
2.9.5


