Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E484C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4207A20685
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4207A20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbeKOI5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:57:45 -0500
Received: from mga04.intel.com ([192.55.52.120]:42175 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbeKOI5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:57:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2018 14:52:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,234,1539673200"; 
   d="scan'208";a="96351484"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Nov 2018 14:52:32 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 0/7] ACPI HMAT memory sysfs representation
Date:   Wed, 14 Nov 2018 15:49:02 -0700
Message-Id: <20181114224902.12082-1-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series provides a new sysfs representation for heterogeneous
system memory.

The previous series that was specific to HMAT that this series was based
on was last posted here: https://lkml.org/lkml/2017/12/13/968

Platforms may provide multiple types of cpu attached system memory. The
memory ranges for each type may have different characteristics that
applications may wish to know about when considering what node they want
their memory allocated from. 

It had previously been difficult to describe these setups as memory
rangers were generally lumped into the NUMA node of the CPUs. New
platform attributes have been created and in use today that describe
the more complex memory hierarchies that can be created.

This series first creates new generic APIs under the kernel's node
representation. These new APIs can be used to create links among local
memory and compute nodes and export characteristics about the memory
nodes. Documentation desribing the new representation are provided.

Finally the series adds a kernel user for these new APIs from parsing
the ACPI HMAT.

Keith Busch (7):
  node: Link memory nodes to their compute nodes
  node: Add heterogenous memory performance
  doc/vm: New documentation for memory performance
  node: Add memory caching attributes
  doc/vm: New documentation for memory cache
  acpi: Create subtable parsing infrastructure
  acpi/hmat: Parse and report heterogeneous memory

 Documentation/vm/numacache.rst |  76 ++++++++
 Documentation/vm/numaperf.rst  |  71 ++++++++
 drivers/acpi/Kconfig           |   9 +
 drivers/acpi/Makefile          |   1 +
 drivers/acpi/hmat.c            | 384 +++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/tables.c          |  85 +++++++--
 drivers/base/Kconfig           |   8 +
 drivers/base/node.c            | 193 +++++++++++++++++++++
 include/linux/node.h           |  47 +++++
 9 files changed, 864 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/vm/numacache.rst
 create mode 100644 Documentation/vm/numaperf.rst
 create mode 100644 drivers/acpi/hmat.c

-- 
2.14.4

