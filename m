Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25E5C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D0420821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="Nhv+ay56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbfAIFcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 00:32:52 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25400 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbfAIFcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 00:32:51 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1547011918; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=Yutn97Lc2kuInlcxUBGNCYuI50Zanxpo2dh5A7MiMoDfsCToa/UNQGDiaiy8JlEbuhbrwBbeyvVmNQU7tgfm+UIOdez7h3BEVPS7rO/PCvz9X2C+hZ+4H+DPU5ajc3TF2HG5bxh43fd8WdeyuSFDL+wPL/FvHBcnayCcPhO5aLU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1547011918; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=LQScH7Z9ASTjwz+BDMoHBx4OT6Si3H3lqWmXMhgmtTk=; 
        b=N6kBWgKrIcNY5+3jwICp+rfxfClpH0T3sJ64omwr9Ob1kjx+x/RjDuL9Z88imR/rw4yG0pugpOOdfxT1cAbypyoV+qKtpJ5R5B+pMFUoXoRrfX9MUWfKQ8SzUJsHEjOjFNK48sf+dl/Z44REUM59ieduWH2qTAnF4LkljZ+Rdno=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=RrFUyYGiJw4aW79hat51p/nWRHJuirwkadiGOu3A2pxubRqY7TF1uAEfDpnIFkyVMueEAIvIcSzy
    ab/11lmt2LkWBDMLc9j7tBoqzswyvNahXV8EsOG2CNYTXiSlx4WO  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1547011918;
        s=default; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; l=927;
        bh=LQScH7Z9ASTjwz+BDMoHBx4OT6Si3H3lqWmXMhgmtTk=;
        b=Nhv+ay56yWrVvTn+ZcbZ9JM2YzBxzlrC1iU5NdnNk91u3KdoNh/viZW1jVTuTMMx
        rn08rsklR70jHOb1bUxl2kKGmeWngSF/o2D7GXOTOLcD6+em9BEraJ/UWynLbwpXz3P
        uw5gbZFhA45eD4bWTrzJjiFX0oCyI3JStLbQPVNw=
Received: from YEHS1XR956R00D1.lenovo.com (123.120.89.99 [123.120.89.99]) by mx.zohomail.com
        with SMTPS id 1547011915743450.1697423849781; Tue, 8 Jan 2019 21:31:55 -0800 (PST)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     snitzer@redhat.com, agk@redhat.com
Cc:     dan.j.williams@intel.com, hch@lst.de, jack@suse.cz, corbet@lwn.net,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-doc@vger.kernel.org,
        chengnt@lenovo.com, Huaisheng Ye <yehs1@lenovo.com>
Subject: [RFC PATCH v2 4/4] Documentation/device-mapper: add optional parameter reinit
Date:   Wed,  9 Jan 2019 13:31:27 +0800
Message-Id: <20190109053127.8128-5-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
In-Reply-To: <20190109053127.8128-1-yehs2007@zoho.com>
References: <20190109053127.8128-1-yehs2007@zoho.com>
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


