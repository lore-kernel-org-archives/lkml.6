Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40193C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BFC62084C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="QU8yZwJ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbfAaCcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 21:32:36 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25406 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbfAaCcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 21:32:36 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548901888; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=YtnG9vz/O8yeb2MNeONfLbdtluy7M9hj3MuFGwV3MvOPMlItJ81dFVQM1zTsdAJxDgfx3ritJPlZsvYZzaL2qXeVsIE4QkHRnmX8UdAkISsLPrkJDZ+DLInB3T8dSrZpCw0bBu6GrkHneMBW6iccH6wVQBmEVBmW7GERT/3m+BQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548901888; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=LQScH7Z9ASTjwz+BDMoHBx4OT6Si3H3lqWmXMhgmtTk=; 
        b=Vkvg4xglJaYStlJZKUZSKcJIUfwVf9Td9bX1E/vg/2j244afehfT7KOEUUwehNSCugH16IlXBB9hsshxs2sJ+AmjWDD0Ih6EkPhKylBubaZeBnm4aQ1huD79w2Dn8PHqxnvNnf7kG+EKOhYnsuPSE1ISuS6qeq13LF3w3wpXhQU=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=YTmQfU2DMhroOwFiwJYWEqVCs4EDKZKSuzi5bqP+fbrs5jLJLchtR/ZRLBKnYQeLCn9wuzZrzUEU
    oPM1+xfIPz224xdB/KchiATUum6Rsmk5Q3QvGuNPI0b8wVT5b+WF  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548901888;
        s=default; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; l=927;
        bh=LQScH7Z9ASTjwz+BDMoHBx4OT6Si3H3lqWmXMhgmtTk=;
        b=QU8yZwJ1bXOM/lnRu9a7Xi9FWCs1kWMxs99q6tZq0Fubgz0Xi4G9kEnx9EhnCjrm
        DIGBuBvofT5Ad7M2jStIOe7kMsoI/Xh5M4brJxJaXqflRMqakDFEqkvm5px2psb8f99
        zwzU+64LOiHq4TLmE9870GY6arm2E110HR8nTwXQ=
Received: from YEHS1XR956R00D1.lenovo.com (106.38.1.115 [106.38.1.115]) by mx.zohomail.com
        with SMTPS id 1548901885991120.6711966437723; Wed, 30 Jan 2019 18:31:25 -0800 (PST)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     mpatocka@redhat.com, snitzer@redhat.com, agk@redhat.com
Cc:     dan.j.williams@intel.com, hch@lst.de, jack@suse.cz, corbet@lwn.net,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-doc@vger.kernel.org,
        Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH v3 4/5] Documentation/device-mapper: add optional parameter reinit
Date:   Thu, 31 Jan 2019 10:29:54 +0800
Message-Id: <20190131022955.9920-5-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
In-Reply-To: <20190131022955.9920-1-yehs2007@zoho.com>
References: <20190131022955.9920-1-yehs2007@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

Add intro and usage guide for reinit.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 Documentation/device-mapper/writecache.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/device-mapper/writecache.txt b/Documentation/device-mapper/writecache.txt
index 01532b3..255c68c 100644
--- a/Documentation/device-mapper/writecache.txt
+++ b/Documentation/device-mapper/writecache.txt
@@ -45,6 +45,10 @@ Constructor parameters:
 		afterwards
 		- some underlying devices perform better with fua, some
 		  with nofua. The user should test it
+	reinit		(by default off)
+		applicable only to persistent memory - use the REINIT flag
+		when the surper block has messy data, that would cause fn ctr
+		failed to work with invalid magic or version in the superblock
 
 Status:
 1. error indicator - 0 if there was no error, otherwise error number
-- 
1.8.3.1


