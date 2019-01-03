Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE82C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7285F20815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731371AbfACQ2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:28:31 -0500
Received: from mga05.intel.com ([192.55.52.43]:44083 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730795AbfACQ2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 11:28:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2019 08:28:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,435,1539673200"; 
   d="scan'208";a="105258262"
Received: from lgszafar-mobl.amr.corp.intel.com (HELO [10.254.190.180]) ([10.254.190.180])
  by orsmga006.jf.intel.com with ESMTP; 03 Jan 2019 08:28:29 -0800
Subject: Re: [alsa-devel] [PATCH v5 08/11] ASoC: Intel: atom: Make PCI
 dependency explicit
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Chandan Rajendra <chandan@linux.ibm.com>
Cc:     "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>,
        Sinan Kaya <Okaya@kernel.org>,
        Jie Yang <yang.jie@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ted Ts'o <tytso@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>
References: <20190102181038.4418-1-okaya@kernel.org>
 <CAK9iUCPWQ=9EgnUFo8BHraEgFwHs3FdbegPLwhT-KHD=r2WBkQ@mail.gmail.com>
 <8c69f8d0-6a95-0011-ff87-8ac9236a992d@linux.intel.com>
 <5797826.UxqLOWUXRU@localhost.localdomain>
 <CAJZ5v0j=i_YN7szXLV8cKLp2XmoqUTQR6EJhRJhWFJzenhzM9Q@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <fd520793-4ec4-2ced-7b00-2cdd3297d74c@linux.intel.com>
Date:   Thu, 3 Jan 2019 10:28:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0j=i_YN7szXLV8cKLp2XmoqUTQR6EJhRJhWFJzenhzM9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> arch/ia64/Kconfig:126:error: recursive dependency detected!
>>> arch/ia64/Kconfig:126:    choice <choice> contains symbol IA64_HP_SIM
>>> arch/ia64/Kconfig:200:    symbol IA64_HP_SIM is part of choice PM
>>> kernel/power/Kconfig:144:    symbol PM is selected by PM_SLEEP
>>> kernel/power/Kconfig:104:    symbol PM_SLEEP depends on HIBERNATE_CALLBACKS
>>> kernel/power/Kconfig:31:    symbol HIBERNATE_CALLBACKS is selected by
>>> HIBERNATION
>>> kernel/power/Kconfig:34:    symbol HIBERNATION depends on SWAP
>>> init/Kconfig:250:    symbol SWAP depends on BLOCK
>>> block/Kconfig:5:    symbol BLOCK is selected by UBIFS_FS
>>> fs/ubifs/Kconfig:1:    symbol UBIFS_FS depends on MISC_FILESYSTEMS
>>> fs/Kconfig:220:    symbol MISC_FILESYSTEMS is selected by ACPI_APEI
>>> drivers/acpi/apei/Kconfig:8:    symbol ACPI_APEI depends on ACPI
>>> drivers/acpi/Kconfig:9:    symbol ACPI depends on ARCH_SUPPORTS_ACPI
>>> <<<< LOOK HERE
>>> drivers/acpi/Kconfig:6:    symbol ARCH_SUPPORTS_ACPI is selected by
>>> IA64_HP_SIM
>>> arch/ia64/Kconfig:200:    symbol IA64_HP_SIM is part of choice <choice>
>>>
>>> At any rate, a 3 mn git bisect tells me the circular dependency is
>>> exposed by this change:
>>>
>>> f3fd6cd74fedf99b6060f75df00943fda13b65f2 is the first bad commit
>>> commit f3fd6cd74fedf99b6060f75df00943fda13b65f2
>>> Author: Chandan Rajendra <chandan@linux.vnet.ibm.com>
>>> Date:   Sat Dec 8 12:21:38 2018 +0530
>>>
>>>       fscrypt: remove filesystem specific build config option
>>>
>>>       In order to have a common code base for fscrypt "post read" processing
>>>       for all filesystems which support encryption, this commit removes
>>>       filesystem specific build config option (e.g.
>>> CONFIG_EXT4_FS_ENCRYPTION)
>>>       and replaces it with a build option (i.e. CONFIG_FS_ENCRYPTION) whose
>>>       value affects all the filesystems making use of fscrypt.
>>>
>>>       Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
>>>       Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>>>
>> FWIW, The patch at https://patchwork.kernel.org/patch/10725883/ fixes this
>> problem by removing "select BLOCK if FS_ENCRYPTION" from fs/ubifs/Kconfig.
> OK
>
> Pierre-Louis, can you check if this patch makes the issue go away for
> you, please?

Wondering if Chandan provided the right pointer, I wasn't able to apply 
this patch, but commenting out "select BLOCK if FS_ENCRYPTION" in 
fs/ubifs/Kconfig makes the circular dependency go away. All good for me.

