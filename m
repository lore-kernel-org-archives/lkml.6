Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755CFECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338D021523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 338D021523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388984AbeIUHbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:31:43 -0400
Received: from mail.windriver.com ([147.11.1.11]:54658 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeIUHbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:31:39 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w8L1ioIx010462
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 20 Sep 2018 18:44:51 -0700 (PDT)
Received: from yow-pgortmak-d1.corp.ad.wrs.com (128.224.56.57) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.408.0; Thu, 20 Sep 2018 18:44:50 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <platform-driver-x86@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Peter Feuerer <peter@piie.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [PATCH 0/6] platform/x86: acerhdf: new BIOS string, better modparam handling
Date:   Thu, 20 Sep 2018 21:44:15 -0400
Message-ID: <20180921014421.30804-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I came across this older netbook over the xmas holidays, and noticed the
acerhdf driver wouldn't load.  Turns out the BIOS string was too new,
and not listed in the driver.  There were module params for overrides,
but I found their use isn't quite clear without reading the source.

Here I clarify some of the module parameter usage, and then add the new
BIOS string, so they won't be needed for this particular platform.  Some
probe code is also shifted out to be __init to reduce the driver size a
bit.  Further details can be found in the respective commit logs.

Since it was months ago when I created these patches, I retested on top
of tree to ensure things still work, as can be seen below.

root@gw:~# cat /proc/version 
Linux version 4.19.0-rc4+ (paul@host) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.10)) #1 SMP Thu Sep 20 18:47:15 EDT 2018
root@gw:~# modprobe acerhdf
root@gw:~# dmesg|tail -n3
acerhdf: Acer Aspire One Fan driver, v.0.7.0
acerhdf: Fan control off, to enable do:
acerhdf: echo -n "enabled" > /sys/class/thermal/thermal_zoneN/mode # N=0,1,2...
root@gw:~# lsmod
Module                  Size  Used by
acerhdf                16384  0 
root@gw:~# 

Paul.
---

Cc: Peter Feuerer <peter@piie.net>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>

Paul Gortmaker (6):
  platform/x86: acerhdf: clarify modinfo messages for BIOS override
  platform/x86: acerhdf: Enable ability to list supported systems
  platform/x86: acerhdf: Remove cut-and-paste trap from instructions
  platform/x86: acerhdf: Add BIOS entry for Gateway LT31 v1.3307
  platform/x86: acerhdf: mark appropriate content with __init prefix
  platform/x86: acerhdf: restructure to allow large BIOS table be __initconst

 drivers/platform/x86/Kconfig   |  5 +++-
 drivers/platform/x86/acerhdf.c | 68 ++++++++++++++++++++++++++++++------------
 2 files changed, 53 insertions(+), 20 deletions(-)

-- 
2.15.0

