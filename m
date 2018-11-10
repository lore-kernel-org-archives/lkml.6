Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B488C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 21:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB95920892
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 21:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB95920892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbeKKGqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 01:46:31 -0500
Received: from mga03.intel.com ([134.134.136.65]:29642 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbeKKGqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 01:46:30 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Nov 2018 13:00:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,488,1534834800"; 
   d="scan'208";a="103307755"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 10 Nov 2018 13:00:09 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gLaMT-0007Up-Bp; Sun, 11 Nov 2018 05:00:09 +0800
Date:   Sun, 11 Nov 2018 04:59:52 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     kbuild-all@01.org, X86 ML <x86@kernel.org>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/16] x86/microcode/AMD: Fix container size's type
Message-ID: <201811110436.ppUT9LcR%fengguang.wu@intel.com>
References: <20181107170218.7596-13-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107170218.7596-13-bp@alien8.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tip/x86/core]
[also build test WARNING on v4.20-rc1 next-20181109]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Borislav-Petkov/x86-microcode-AMD-Improve-container-verification/20181109-065233

smatch warnings:
arch/x86/kernel/cpu/microcode/amd.c:368 scan_containers() warn: always true condition '(size >= 0) => (0-u32max >= 0)'
arch/x86/kernel/cpu/microcode/amd.c:368 scan_containers() warn: always true condition '(size >= 0) => (0-u32max >= 0)'

vim +368 arch/x86/kernel/cpu/microcode/amd.c

   361	
   362	/*
   363	 * Scan the ucode blob for the proper container as we can have multiple
   364	 * containers glued together.
   365	 */
   366	static void scan_containers(u8 *ucode, size_t size, struct cont_desc *desc)
   367	{
 > 368		while (size >= 0) {
   369			size_t s = parse_container(ucode, size, desc);
   370			if (!s)
   371				return;
   372	
   373			/* catch wraparound */
   374			if (size >= s) {
   375				ucode += s;
   376				size  -= s;
   377			} else
   378				return;
   379		}
   380	}
   381	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
