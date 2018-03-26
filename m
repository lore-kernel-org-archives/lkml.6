Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751157AbeCZHVS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 03:21:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:11339 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751042AbeCZHVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 03:21:16 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,364,1517904000";
   d="scan'208";a="40621498"
Date: Mon, 26 Mar 2018 12:33:55 +0530
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
To: Anshuman Gupta <anshuman.gupta@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
        <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] [sound] hdac-codec runtime suspended at PM:Suspend.
Message-ID: <20180326070349.GA14895@subhransu-desktop>
References: <1520853467-31653-1-git-send-email-anshuman.gupta@intel.com>
 <CAJZ5v0hyk=jto8Wt0er==YmKEsgvfvZhO2wDbGOhxZaWWCNgBg@mail.gmail.com>
 <5aa8fbe9.4251620a.c3daa.3711SMTPIN_ADDED_BROKEN@mx.google.com>
 <CAJZ5v0jrKPNFhgpoL97Ac-k9jAmMa-vzgc-4PD+uuynSMqE2Fw@mail.gmail.com>
 <20180314153714.GA11459@anshuman.gupta@intel.com>
 <20180315104237.GB13659@subhransu-desktop>
 <20180315153230.GA16531@anshuman.gupta@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315153230.GA16531@anshuman.gupta@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 09:02:30PM +0530, Anshuman Gupta wrote:
> On Thu, Mar 15, 2018 at 04:12:44PM +0530, Subhransu S. Prusty wrote:
> > On Wed, Mar 14, 2018 at 09:07:14PM +0530, Anshuman Gupta wrote:
> > > On Wed, Mar 14, 2018 at 11:53:58AM +0100, Rafael J. Wysocki wrote:
> > > > On Wed, Mar 14, 2018 at 11:38 AM, Anshuman Gupta
> > > > <anshuman.gupta@intel.com> wrote:
> > > > > On Mon, Mar 12, 2018 at 12:26:53PM +0100, Rafael J. Wysocki wrote:
> > > > >> On Mon, Mar 12, 2018 at 12:17 PM, Anshuman Gupta
> > > > >> <anshuman.gupta@intel.com> wrote:
> > > > >> >
> > > > >> > +       if (pm_runtime_status_suspended(dev))
> > > > >> > +               return;
> > > > >>
> > > > >> That, again, is somewhat fragile from the concurrency perspective.
> > > > >>
> > > > 
> > > > And here you want to avoid the below if the device is still suspended.
> > >   Yes, if we do not avoid the code below, complete callback takes about 
> > >   3 seconds due to snd_hdac_codec_read timed out because hdac controller 
> > >   would be in runtime suspend state.	
> > > > 
> > > > Why is the below code located in the ->complete callback anyway?
> > > > Shouldn't it be there in the ->resume one?
> > > > 
> > >   Yes even i am also having same doubt, why these power down and power up
> > >   sequences are part of prepare and complete callback.
> > >   Adding driver author "Subhransu S. Prusty" to provide more inputs on this.
> > 
> > This driver needs a late resume as it receives a jack notification from the
> > i915 driver and the skl controller driver resume may not have happened and
> > in turn hda controller may not ready. This ensures a synchronization for
> > jack event during resume from S3.
>   Let me give you insight of the issue, this driver blocks the direct complete
>   of hda controller PCI 00:1f.3, sometimes it takes 280ms to resume hda controller
>   from S3 and s2idle. So it does not make sense to suspend/resume hda controller 
>   when it is already in runtime suspend.

I get it now. I think this patch needs rework to address both the issues. 

> > 
> > I think this patch defeats the purpose.
>   Here in this case PCI driver may kick the direct complete for hda controller
>   https://elixir.bootlin.com/linux/latest/source/drivers/pci/pci-driver.c#L691
>   But hdac hdmi codec driver is blocking it.
>   So i think it will be ok to keep this codec and hda controller in runtime 
>   suspend while entering S3 or s2idle, both can resume by runtime PM as well,
>   will it brake any audio functionality?

There was some PM and jack detection issues (I don't recollect now) because
of which this was added. This was due to the gfx display power and hda
controller synchronization. The rework may be required in both hdac_hdmi
and skylake drivers.

Regards,
Subhransu

> > 
> > Regards,
> > Subhransu
> > 
> > > > >> >         /* Power up afg */
> > > > >> >         snd_hdac_codec_read(hdac, hdac->afg, 0, AC_VERB_SET_POWER_STATE,
> > > > >> >                                                         AC_PWRST_D0);
> > > > >> > --
> > > > >> > 2.7.4
> > > 
> > > -- 
> > > Thanks,
> > > Anshuman
> > 
> > -- 
> 
> -- 
> Thanks,
> Anshuman

-- 
