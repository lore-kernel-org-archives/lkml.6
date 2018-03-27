Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752596AbeC0Pgk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:36:40 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:52151 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752343AbeC0Pgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:36:38 -0400
Date: Tue, 27 Mar 2018 17:36:36 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: " Subhransu S. Prusty " <subhransu.s.prusty@intel.com>,
        Anshuman Gupta <anshuman.gupta@intel.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
        <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] [sound] hdac-codec runtime suspended at PM:Suspend.
Message-ID: <20180327153636.GA4588@wunner.de>
References: <1520853467-31653-1-git-send-email-anshuman.gupta@intel.com>
 <CAJZ5v0hyk=jto8Wt0er==YmKEsgvfvZhO2wDbGOhxZaWWCNgBg@mail.gmail.com>
 <5aa8fbe9.4251620a.c3daa.3711SMTPIN_ADDED_BROKEN@mx.google.com>
 <CAJZ5v0jrKPNFhgpoL97Ac-k9jAmMa-vzgc-4PD+uuynSMqE2Fw@mail.gmail.com>
 <s5hr2o770pv.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hr2o770pv.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 09:30:36AM +0200, Takashi Iwai wrote:
> On Mon, 26 Mar 2018 09:03:55 +0200, Subhransu S. Prusty  wrote:
> > On Thu, Mar 15, 2018 at 09:02:30PM +0530, Anshuman Gupta wrote:
> > > On Thu, Mar 15, 2018 at 04:12:44PM +0530, Subhransu S. Prusty wrote:
> > > > This driver needs a late resume as it receives a jack notification
> > > > from the i915 driver and the skl controller driver resume may not
> > > > have happened and in turn hda controller may not ready. This ensures
> > > > a synchronization for jack event during resume from S3.
> > > 
> > > Let me give you insight of the issue, this driver blocks the direct
> > > complete of hda controller PCI 00:1f.3, sometimes it takes 280ms to
> > > resume hda controller from S3 and s2idle. So it does not make sense
> > > to suspend/resume hda controller when it is already in runtime
> > > suspend.
> 
> If it's about the power well issue, it had been fixed in multiple
> ways.  In i915 side, every relevant component callback is wrapped with
> power domain get/put.  And, at least HD-audio legacy side, such a
> spurious notification is filtered out in the eld notifier:
> 
> static void intel_pin_eld_notify(void *audio_ptr, int port, int pipe)
> {
> 	....
> 	/* skip notification during system suspend (but not in runtime PM);
> 	 * the state will be updated at resume
> 	 */
> 	if (snd_power_get_state(codec->card) != SNDRV_CTL_POWER_D0)
> 		return;
> 	/* ditto during suspend/resume process itself */
> 	if (atomic_read(&(codec)->core.in_pm))
> 		return;
> 
> 	snd_hdac_i915_set_bclk(&codec->bus->core);
> 	check_presence_and_report(codec, pin_nid, dev_id);
> }
> 
> Last but not least, the jack state is explicitly updated via reading
> the ELD at resume callback.
> 
> In that way, we can live with the standard suspend/resume procedure.

FWIW, the i915 folks have put on their todo list to migrate the
i915/hda_intel interaction to device links:

https://git.kernel.org/next/linux-next/c/7b3b61b62a58

Something similar has already been done for HDA controllers
integrated into AMD / Nvidia GPUs with:

https://git.kernel.org/next/linux-next/c/07f4f97d7b4b

With device links, direct_complete will be used naturally,
so time is probably best spent working towards this approach.

Thanks,

Lukas
