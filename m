Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753691AbeC1WOG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 18:14:06 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35579 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753098AbeC1WOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 18:14:04 -0400
X-Google-Smtp-Source: AIpwx4+3SUCM1iF42d7x7dcm2UY9g/2WbbG/f5bTW9SO/SlpRlnY0ghIw+hQuSBxsQ4y9IrgE9qZDrobR9+GsOdtc1w=
MIME-Version: 1.0
In-Reply-To: <20180328143150.GA17992@wunner.de>
References: <20180328142020.3275989-1-arnd@arndb.de> <20180328143150.GA17992@wunner.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 29 Mar 2018 00:14:03 +0200
X-Google-Sender-Auth: qdkeqGWe9PvdBUuDBIWo9X4-F7M
Message-ID: <CAK8P3a2RSDgxOcAqJK9fJ-zsZJu37nTVn3Wdogj3B655d0yr5Q@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda_intel: mark PM functions as __maybe_unused
To: Lukas Wunner <lukas@wunner.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Guneshwor Singh <guneshwor.o.singh@intel.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Libin Yang <libin.yang@intel.com>, alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 4:31 PM, Lukas Wunner <lukas@wunner.de> wrote:
> On Wed, Mar 28, 2018 at 04:19:29PM +0200, Arnd Bergmann wrote:
>> Two callsites of azx_suspend/azx_resume were removed, leaving these
>> functions only called from the optional SET_SYSTEM_SLEEP_PM_OPS()
>> and causing a warning without CONFIG_PM_SLEEP:
>>
>> sound/pci/hda/hda_intel.c:1029:12: error: 'azx_resume' defined but not used [-Werror=unused-function]
>>  static int azx_resume(struct device *dev)
>>             ^~~~~~~~~~
>> sound/pci/hda/hda_intel.c:994:12: error: 'azx_suspend' defined but not used [-Werror=unused-function]
>>  static int azx_suspend(struct device *dev)
>>             ^~~~~~~~~~~
>>
>> Keeping track of the correct #ifdef checks is hard, so this removes
>> all the #ifdefs for power management in this file and instead uses
>> __maybe_unused annotations that let the compiler do the job right
>> by itself.
>
> Ugh, this isn't as hard as it may seem, just replace
>
>         #if defined(CONFIG_PM_SLEEP) || defined(SUPPORT_VGA_SWITCHEROO)
>
> with
>
>         #if defined(CONFIG_PM_SLEEP)
>
> That way it's just a simple one line change which is less intrusive.
>
> Care to respin like this?

I won't be able to test that properly before the merge window. If you
are sure that works, maybe you can send that patch and just mark
it as 'Reported-by: Arnd Bergmann <arnd@arndb.de>'?

I've mostly stopped trying to figure out what the correct set of #ifdef
for power management functions is, since I get those wrong as much
as everyone else. ;-). The patch I sent has been through a few days
of randconfig testing.

      Arnd
