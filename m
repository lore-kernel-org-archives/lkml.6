Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A87C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE50214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE50214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732426AbeKVEOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:14:05 -0500
Received: from mga18.intel.com ([134.134.136.126]:51217 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbeKVEOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:14:05 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2018 09:38:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,261,1539673200"; 
   d="scan'208";a="87681720"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga007.fm.intel.com with ESMTP; 21 Nov 2018 09:38:42 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gPWSX-0005Qv-Bm; Wed, 21 Nov 2018 19:38:41 +0200
Date:   Wed, 21 Nov 2018 19:38:41 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, liam.r.girdwood@linux.intel.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] ASoC: Intel: Skylake: Add CFL-S support
Message-ID: <20181121173841.GS10650@smile.fi.intel.com>
References: <20181120213644.19103-1-pierre-louis.bossart@linux.intel.com>
 <20181120213644.19103-2-pierre-louis.bossart@linux.intel.com>
 <20181121142721.GO10650@smile.fi.intel.com>
 <414b4c3a-7e04-2775-7d87-16a236b5b4e8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414b4c3a-7e04-2775-7d87-16a236b5b4e8@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 11:16:50AM -0600, Pierre-Louis Bossart wrote:
> On 11/21/18 8:27 AM, Andy Shevchenko wrote:

> > May you consider to switch to PCI_DEVICE_DATA() first?
> 
> Is this really the recommended path?
> 
> The macro generates PCI_DEVICE_ID_##vend##_##dev, and I don't have a turn
> key #define PCI_DEVICE_ID_INTEL_AUDIO_CFL 0xa348 I can use. In a number of
> cases we have multiple variants of the same hardware, and it starts being
> painful to use a 20-letter macro to differentiate between INTEL_AUDIO_CFL_Y
> and INTEL_AUDIO_CFL_H. The explicit code and a short comment are more
> readable really.
> 
> git grep PCI_DEVICE_ID_INTEL gives me hundreds of definitions, some global,
> some local to specific drivers, doesn't seem like there is a well-agreed
> usage of this macro, is there? I don't mind making the change but I don't
> sense an strong argument for it?

Compare:

	/* CFL */
	{ PCI_DEVICE(0x8086, 0xa348),
		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},

to something like:

#define PCI_DEVICE_ID_INTEL_AUDIO_CFL	0xa348
...

	{PCI_DEVICE_DATA(INTEL, AUDIO_CFL, &snd_soc_acpi_intel_cnl_machines)},


Macro is recently introduced, that's why not many users of it. At least I'm
planning to clean up dwc3-pci.c using it.

-- 
With Best Regards,
Andy Shevchenko


