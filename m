Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032A9C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 23:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75072075B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 23:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfABXu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 18:50:29 -0500
Received: from mga06.intel.com ([134.134.136.31]:26780 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728145AbfABXu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 18:50:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2019 15:50:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,432,1539673200"; 
   d="scan'208";a="106524032"
Received: from ellorapa-mobl1.amr.corp.intel.com (HELO [10.252.195.139]) ([10.252.195.139])
  by orsmga008.jf.intel.com with ESMTP; 02 Jan 2019 15:50:27 -0800
Subject: Re: [alsa-devel] [PATCH v5 08/11] ASoC: Intel: atom: Make PCI
 dependency explicit
To:     Sinan Kaya <Okaya@kernel.org>
Cc:     "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>,
        Mark Brown <broonie@kernel.org>,
        Jie Yang <yang.jie@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>
References: <20190102181038.4418-1-okaya@kernel.org>
 <20190102181038.4418-9-okaya@kernel.org>
 <57ed1d94-7f89-20e8-3289-7ef7efd18c20@linux.intel.com>
 <CAK9iUCNMAuDOh_CM-bTE1xT5FePfYbq7W+0R4KF1KbqskuJ8FA@mail.gmail.com>
 <a9ccf7e1-4752-6bf5-2621-15b21a80c2ca@linux.intel.com>
 <CAK9iUCPWQ=9EgnUFo8BHraEgFwHs3FdbegPLwhT-KHD=r2WBkQ@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <8c69f8d0-6a95-0011-ff87-8ac9236a992d@linux.intel.com>
Date:   Wed, 2 Jan 2019 17:50:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK9iUCPWQ=9EgnUFo8BHraEgFwHs3FdbegPLwhT-KHD=r2WBkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/2/19 4:58 PM, Sinan Kaya wrote:
> On Wed, Jan 2, 2019 at 10:50 PM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>>
>>> This is pointing to a kconfig issue on ia64 arch.
>>>
>>> arch/ia64/Kconfig:128:error: recursive dependency detected!
>>> arch/ia64/Kconfig:128:    choice <choice> contains symbol IA64_HP_SIM
>>> arch/ia64/Kconfig:202:    symbol IA64_HP_SIM is part of choice PM
>>>
>>> IA64_HP_SIM is both a choice and is selected.
>>>
>>> I did allyesconfig and disabled PCI afterwards to find all the issues
>>> on this patchset.
>> Are you saying there's a newer series that fixes this issue for both
>> allyesconfig and allmodconfig?
>>
>> if yes, then we're good.
>
> No, I haven't fixed ia64 kconfig issue. That's somebody else's job. I
> used allyesconfig to find out all compilation issues on x86 arch to
> come up with this patchset.

Nothing makes me cringe more than "somebody else's job" statements. In 
this case, there is obviously a correlation with your ACPI changes since 
the circular dependency happens because of the ACPI symbol.

arch/ia64/Kconfig:126:error: recursive dependency detected!
arch/ia64/Kconfig:126:    choice <choice> contains symbol IA64_HP_SIM
arch/ia64/Kconfig:200:    symbol IA64_HP_SIM is part of choice PM
kernel/power/Kconfig:144:    symbol PM is selected by PM_SLEEP
kernel/power/Kconfig:104:    symbol PM_SLEEP depends on HIBERNATE_CALLBACKS
kernel/power/Kconfig:31:    symbol HIBERNATE_CALLBACKS is selected by 
HIBERNATION
kernel/power/Kconfig:34:    symbol HIBERNATION depends on SWAP
init/Kconfig:250:    symbol SWAP depends on BLOCK
block/Kconfig:5:    symbol BLOCK is selected by UBIFS_FS
fs/ubifs/Kconfig:1:    symbol UBIFS_FS depends on MISC_FILESYSTEMS
fs/Kconfig:220:    symbol MISC_FILESYSTEMS is selected by ACPI_APEI
drivers/acpi/apei/Kconfig:8:    symbol ACPI_APEI depends on ACPI
drivers/acpi/Kconfig:9:    symbol ACPI depends on ARCH_SUPPORTS_ACPI 
<<<< LOOK HERE
drivers/acpi/Kconfig:6:    symbol ARCH_SUPPORTS_ACPI is selected by 
IA64_HP_SIM
arch/ia64/Kconfig:200:    symbol IA64_HP_SIM is part of choice <choice>

At any rate, a 3 mn git bisect tells me the circular dependency is 
exposed by this change:

f3fd6cd74fedf99b6060f75df00943fda13b65f2 is the first bad commit
commit f3fd6cd74fedf99b6060f75df00943fda13b65f2
Author: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Date:   Sat Dec 8 12:21:38 2018 +0530

     fscrypt: remove filesystem specific build config option

     In order to have a common code base for fscrypt "post read" processing
     for all filesystems which support encryption, this commit removes
     filesystem specific build config option (e.g. 
CONFIG_EXT4_FS_ENCRYPTION)
     and replaces it with a build option (i.e. CONFIG_FS_ENCRYPTION) whose
     value affects all the filesystems making use of fscrypt.

     Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
     Signed-off-by: Theodore Ts'o <tytso@mit.edu>

-Pierre


