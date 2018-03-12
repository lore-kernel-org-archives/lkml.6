Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751348AbeCLL04 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 07:26:56 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:44264 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbeCLL0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 07:26:54 -0400
X-Google-Smtp-Source: AG47ELtIQ9NMMSuSBoVBML+vtunOWQrrQ06S0AR/IKdluidgIxtnnyOSADHzfkrhTa4oawYxcOksCcshmW9olPRGwpI=
MIME-Version: 1.0
In-Reply-To: <1520853467-31653-1-git-send-email-anshuman.gupta@intel.com>
References: <1520853467-31653-1-git-send-email-anshuman.gupta@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 Mar 2018 12:26:53 +0100
X-Google-Sender-Auth: p6UdRQVdhHL1bbDiEifmzgyZLYY
Message-ID: <CAJZ5v0hyk=jto8Wt0er==YmKEsgvfvZhO2wDbGOhxZaWWCNgBg@mail.gmail.com>
Subject: Re: [PATCH] [sound] hdac-codec runtime suspended at PM:Suspend.
To: Anshuman Gupta <anshuman.gupta@intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
        <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 12:17 PM, Anshuman Gupta
<anshuman.gupta@intel.com> wrote:
> Keep hdac-codec to be in runtime suspended while entering to suspend.
> If hdac-codec is already in runtime suspend state skip its power down
> sequence in prepare, power up sequence in complete phase.
>
> Avoid resuming hdac controller PCI device 00:1f.3 from runtime suspend
> state in case  hdac-codec already in runtime-suspend state, this is
> unnecessary and block the direct complete even for hdac controller
> PCI device 00:1f.3.
>
> This enabled direct complete path for hdac-codec and PCI device 00:1f.3.
>
> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> ---
>  sound/soc/codecs/hdac_hdmi.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
> index f3b4f4d..810a8a6 100644
> --- a/sound/soc/codecs/hdac_hdmi.c
> +++ b/sound/soc/codecs/hdac_hdmi.c
> @@ -1852,6 +1852,8 @@ static int hdmi_codec_prepare(struct device *dev)
>         struct hdac_ext_device *edev = to_hda_ext_device(dev);
>         struct hdac_device *hdac = &edev->hdac;
>
> +       if (pm_runtime_status_suspended(dev))
> +               return 1;

This is racy in principle, because the runtime PM status can still
change after you've checked here.

But even if it isn't racy in practice, the following
pm_runtime_get_sync() becomes redundant after it, doesn't it?

>         pm_runtime_get_sync(&edev->hdac.dev);
>
>         /*
> @@ -1873,6 +1875,8 @@ static void hdmi_codec_complete(struct device *dev)
>         struct hdac_hdmi_priv *hdmi = edev->private_data;
>         struct hdac_device *hdac = &edev->hdac;
>
> +       if (pm_runtime_status_suspended(dev))
> +               return;

That, again, is somewhat fragile from the concurrency perspective.

>         /* Power up afg */
>         snd_hdac_codec_read(hdac, hdac->afg, 0, AC_VERB_SET_POWER_STATE,
>                                                         AC_PWRST_D0);
> --
> 2.7.4
>
