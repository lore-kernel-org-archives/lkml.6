Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751822AbeCNKyB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 06:54:01 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38450 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751440AbeCNKyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 06:54:00 -0400
X-Google-Smtp-Source: AG47ELv8w97mJ/6BPO4pW0cJKSKKz5/jzW4NtUE5r2pkcUKVb570BXXAnsSx+srOA/LpxRsf/MYlRguFLJdgZMraVmA=
MIME-Version: 1.0
In-Reply-To: <5aa8fbe9.4251620a.c3daa.3711SMTPIN_ADDED_BROKEN@mx.google.com>
References: <1520853467-31653-1-git-send-email-anshuman.gupta@intel.com>
 <CAJZ5v0hyk=jto8Wt0er==YmKEsgvfvZhO2wDbGOhxZaWWCNgBg@mail.gmail.com> <5aa8fbe9.4251620a.c3daa.3711SMTPIN_ADDED_BROKEN@mx.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 14 Mar 2018 11:53:58 +0100
X-Google-Sender-Auth: HCXBTnS_zm_4bnJdOhJcHv6Sfk4
Message-ID: <CAJZ5v0jrKPNFhgpoL97Ac-k9jAmMa-vzgc-4PD+uuynSMqE2Fw@mail.gmail.com>
Subject: Re: [PATCH] [sound] hdac-codec runtime suspended at PM:Suspend.
To: Anshuman Gupta <anshuman.gupta@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
        <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 11:38 AM, Anshuman Gupta
<anshuman.gupta@intel.com> wrote:
> On Mon, Mar 12, 2018 at 12:26:53PM +0100, Rafael J. Wysocki wrote:
>> On Mon, Mar 12, 2018 at 12:17 PM, Anshuman Gupta
>> <anshuman.gupta@intel.com> wrote:
>> > Keep hdac-codec to be in runtime suspended while entering to suspend.
>> > If hdac-codec is already in runtime suspend state skip its power down
>> > sequence in prepare, power up sequence in complete phase.
>> >
>> > Avoid resuming hdac controller PCI device 00:1f.3 from runtime suspend
>> > state in case  hdac-codec already in runtime-suspend state, this is
>> > unnecessary and block the direct complete even for hdac controller
>> > PCI device 00:1f.3.
>> >
>> > This enabled direct complete path for hdac-codec and PCI device 00:1f.3.
>> >
>> > Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
>> > ---
>> >  sound/soc/codecs/hdac_hdmi.c | 4 ++++
>> >  1 file changed, 4 insertions(+)
>> >
>> > diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
>> > index f3b4f4d..810a8a6 100644
>> > --- a/sound/soc/codecs/hdac_hdmi.c
>> > +++ b/sound/soc/codecs/hdac_hdmi.c
>> > @@ -1852,6 +1852,8 @@ static int hdmi_codec_prepare(struct device *dev)
>> >         struct hdac_ext_device *edev = to_hda_ext_device(dev);
>> >         struct hdac_device *hdac = &edev->hdac;
>> >
>> > +       if (pm_runtime_status_suspended(dev))
>> > +               return 1;
>>
>> This is racy in principle, because the runtime PM status can still
>> change after you've checked here.
>   Will using pm_runtime_disable/pm_runtime_enable for safe check of runtime
>   status avoids this race?

It might help, but is this a leaf device or does it have children?

>> But even if it isn't racy in practice, the following
>> pm_runtime_get_sync() becomes redundant after it, doesn't it?
>   I have no idea but if there can be a case that PCI 00:1f.3 (hdac controller)
>   is runtime suspended and hdac hdmi codec is active, in that case it may be
>   required to use pm_runtime_get_sync() for hdac controller as it is parent of
>   hdac hdmi codec.
>>
>> >         pm_runtime_get_sync(&edev->hdac.dev);
>> >

So it sounds like you need the "get" part, but you don't need the
"sync" one, because you've just checked that the device is not
suspended.

I guess the idea is to return 1 for the direct-complete mechanism to
kick in if the device is already suspended, but otherwise bump up its
reference counter to prevent it from suspending going forward, right?

>> >         /*
>> > @@ -1873,6 +1875,8 @@ static void hdmi_codec_complete(struct device *dev)
>> >         struct hdac_hdmi_priv *hdmi = edev->private_data;
>> >         struct hdac_device *hdac = &edev->hdac;
>> >
>> > +       if (pm_runtime_status_suspended(dev))
>> > +               return;
>>
>> That, again, is somewhat fragile from the concurrency perspective.
>>

And here you want to avoid the below if the device is still suspended.

Why is the below code located in the ->complete callback anyway?
Shouldn't it be there in the ->resume one?

>> >         /* Power up afg */
>> >         snd_hdac_codec_read(hdac, hdac->afg, 0, AC_VERB_SET_POWER_STATE,
>> >                                                         AC_PWRST_D0);
>> > --
>> > 2.7.4
