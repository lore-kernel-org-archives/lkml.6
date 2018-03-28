Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753817AbeC1Obx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:31:53 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:34071 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753772AbeC1Obw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:31:52 -0400
Date: Wed, 28 Mar 2018 16:31:50 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Guneshwor Singh <guneshwor.o.singh@intel.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Libin Yang <libin.yang@intel.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda_intel: mark PM functions as __maybe_unused
Message-ID: <20180328143150.GA17992@wunner.de>
References: <20180328142020.3275989-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328142020.3275989-1-arnd@arndb.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 04:19:29PM +0200, Arnd Bergmann wrote:
> Two callsites of azx_suspend/azx_resume were removed, leaving these
> functions only called from the optional SET_SYSTEM_SLEEP_PM_OPS()
> and causing a warning without CONFIG_PM_SLEEP:
> 
> sound/pci/hda/hda_intel.c:1029:12: error: 'azx_resume' defined but not used [-Werror=unused-function]
>  static int azx_resume(struct device *dev)
>             ^~~~~~~~~~
> sound/pci/hda/hda_intel.c:994:12: error: 'azx_suspend' defined but not used [-Werror=unused-function]
>  static int azx_suspend(struct device *dev)
>             ^~~~~~~~~~~
> 
> Keeping track of the correct #ifdef checks is hard, so this removes
> all the #ifdefs for power management in this file and instead uses
> __maybe_unused annotations that let the compiler do the job right
> by itself.

Ugh, this isn't as hard as it may seem, just replace

	#if defined(CONFIG_PM_SLEEP) || defined(SUPPORT_VGA_SWITCHEROO)

with

	#if defined(CONFIG_PM_SLEEP)

That way it's just a simple one line change which is less intrusive.

Care to respin like this?

Thanks for the report,

Lukas
