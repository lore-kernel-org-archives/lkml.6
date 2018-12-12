Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243EFC6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 01:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8F62084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 01:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD8F62084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbeLLBJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 20:09:09 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50374 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeLLBJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 20:09:09 -0500
Received: from [123.112.96.60] (helo=[192.168.1.109])
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <hui.wang@canonical.com>)
        id 1gWt1N-0003rS-WD; Wed, 12 Dec 2018 01:09:06 +0000
Subject: Re: [alsa-devel] [PATCH] ALSA: hda/realtek - Add quirks for Dell
 Optiplex 5060, 7060 for audio out while using headphones
To:     Girija Kumar Kasinadhuni <gkumar@neverware.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20181211224937.28889-1-gkumar@neverware.com>
From:   Hui Wang <hui.wang@canonical.com>
Message-ID: <d898d4c8-ec8f-57f0-8f45-450c02ef9d8c@canonical.com>
Date:   Wed, 12 Dec 2018 09:09:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181211224937.28889-1-gkumar@neverware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/12 上午6:49, Girija Kumar Kasinadhuni wrote:
> There are two audio ports on these machines - headset and mic.
Looks like the two audio ports are headset and lineout.
> There' s no sound when hp is inserted into the headset port,
> though the hp is detected. Without pulseaudio, this issue is
> seen on both the Optiplex machines. The issue goes away with the
> "options snd-hda-intel model=dell-headset-dock" quirk in the
> /etc/modprobe.d/alsa-base.conf or /etc/modprobe.d/alsa.conf
> Getting this fix into the kernel instead of fixing in an
> application layer above, or in a .conf file. This is also helpful
> for audio clients using the ALSA api like cras from ChromiumOS.

Did you test audio playback and recording on two audio jacks after 
applying the patch?

And Node 0x16 of this codec is "Vendor Defined Widget", but the fixup 
will set it to "dock line out", it looks weird.

>
> Signed-off-by: Girija Kumar Kasinadhuni <gkumar@neverware.com>
> ---
> alsa-info:
>
>   Optiplex 5060 -
>   - without fix:	http://www.alsa-project.org/db/?f=2cf3c4354e82bde4aa480612a914535982fa3f91
>   - with fix: http://www.alsa-project.org/db/?f=7a928960400ec828b82632411284ad8a63727b92
>   Optiplex 7060
>   - without fix: http://www.alsa-project.org/db/?f=69fa554faa712e7cad1f188be4a5192353d64f2c
>   - with fix: http://www.alsa-project.org/db/?f=80ce1fb178b377b27b0795ac1c55e8cbee1b5b96
>
>   sound/pci/hda/patch_realtek.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 8d75597028ee..581f6a288abf 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -6444,6 +6444,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>   	SND_PCI_QUIRK(0x1028, 0x064b, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
>   	SND_PCI_QUIRK(0x1028, 0x0665, "Dell XPS 13", ALC288_FIXUP_DELL_XPS_13),
>   	SND_PCI_QUIRK(0x1028, 0x0669, "Dell Optiplex 9020m", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
> +	SND_PCI_QUIRK(0x1028, 0x085b, "Dell Optiplex 5060", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
> +	SND_PCI_QUIRK(0x1028, 0x085a, "Dell Optiplex 7060", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
>   	SND_PCI_QUIRK(0x1028, 0x069a, "Dell Vostro 5480", ALC290_FIXUP_SUBWOOFER_HSJACK),
>   	SND_PCI_QUIRK(0x1028, 0x06c7, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
>   	SND_PCI_QUIRK(0x1028, 0x06d9, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),


