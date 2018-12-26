Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1777C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3736218AD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbeLZNhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:37:07 -0500
Received: from mga04.intel.com ([192.55.52.120]:33941 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726724AbeLZNhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:37:05 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 05:37:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,400,1539673200"; 
   d="scan'208";a="121185455"
Received: from wangdan1-mobl1.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.210.154])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Dec 2018 05:37:01 -0800
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1gc9Mr-0005Nv-69; Wed, 26 Dec 2018 21:37:01 +0800
Message-Id: <20181226133351.106676005@intel.com>
User-Agent: quilt/0.65
Date:   Wed, 26 Dec 2018 21:14:47 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Fan Du <fan.du@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>
cc:     kvm@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
cc:     Yao Yuan <yuan.yao@intel.com>
cc:     Peng Dong <dongx.peng@intel.com>
cc:     Huang Ying <ying.huang@intel.com>
CC:     Liu Jingqi <jingqi.liu@intel.com>
cc:     Dong Eddie <eddie.dong@intel.com>
cc:     Dave Hansen <dave.hansen@intel.com>
cc:     Zhang Yi <yi.z.zhang@linux.intel.com>
cc:     Dan Williams <dan.j.williams@intel.com>
Subject: [RFC][PATCH v2 01/21] e820: cheat PMEM as DRAM
References: <20181226131446.330864849@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0001-e820-Force-PMEM-entry-as-RAM-type-to-enumerate-NUMA-.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fan Du <fan.du@intel.com>

This is a hack to enumerate PMEM as NUMA nodes.
It's necessary for current BIOS that don't yet fill ACPI HMAT table.

WARNING: take care to backup. It is mutual exclusive with libnvdimm
subsystem and can destroy ndctl managed namespaces.

Signed-off-by: Fan Du <fan.du@intel.com>
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 arch/x86/kernel/e820.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux.orig/arch/x86/kernel/e820.c	2018-12-23 19:20:34.587078783 +0800
+++ linux/arch/x86/kernel/e820.c	2018-12-23 19:20:34.587078783 +0800
@@ -403,7 +403,8 @@ static int __init __append_e820_table(st
 		/* Ignore the entry on 64-bit overflow: */
 		if (start > end && likely(size))
 			return -1;
-
+		if (type == E820_TYPE_PMEM)
+			type = E820_TYPE_RAM;
 		e820__range_add(start, size, type);
 
 		entry++;


