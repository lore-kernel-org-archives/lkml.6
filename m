Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E00C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBD7214F1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fmGjv2DL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBD7214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731807AbeHNMEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:04:39 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:32957 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbeHNMEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:04:39 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180814091818euoutp01bbe8b27a792c418a7367dab1ce5fda57~KtZqocb0y0413604136euoutp01O
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 09:18:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180814091818euoutp01bbe8b27a792c418a7367dab1ce5fda57~KtZqocb0y0413604136euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1534238298;
        bh=UBORJukN16J6gQ/Dui9ydm0Nmncgkzm76db+Yj60cnQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=fmGjv2DL5mWqREU9AZcb2pPVwZwwvCI+XoKXD/WffBcV/VuHVi5DW6M/hUiJzuEG6
         4suLk4UA8lQaZr5yEAT+3ZWB4rVCb1FT8SxHdwbvMYGyalaXd4LCDqVH25OkcbDFsk
         VIWUpfKOq6OqKKGibAPGxltp09y60g3lsvxW07tE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180814091817eucas1p2582ce2537a3f23ea423c0b5036b48ef2~KtZpsxZyw3015030150eucas1p2W;
        Tue, 14 Aug 2018 09:18:17 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 3A.A8.04441.95E927B5; Tue, 14
        Aug 2018 10:18:17 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180814091817eucas1p2c505255028937f57af4194a80151c015~KtZo3LHoA2083920839eucas1p2-;
        Tue, 14 Aug 2018 09:18:17 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180814091816eusmtrp1cdb3692bea5b293606f2181808f4644e~KtZonEpD40396503965eusmtrp1a;
        Tue, 14 Aug 2018 09:18:16 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-9f-5b729e59bc85
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C3.73.04128.85E927B5; Tue, 14
        Aug 2018 10:18:16 +0100 (BST)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180814091816eusmtip146cf368335d18537509ae2226f3d7717~KtZoOdmvf1206712067eusmtip1v;
        Tue, 14 Aug 2018 09:18:16 +0000 (GMT)
Subject: Re: [PATCH] drm/bridge/synopsys: dw-hdmi: re-run dw_hdmi_setup when
 setting mode
To:     Icenowy Zheng <icenowy@aosc.io>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Date:   Tue, 14 Aug 2018 11:18:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ddd86a558977fc9942f5f1fa8cefc813ad80f614.camel@aosc.io>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7djP87qR84qiDW5PVbZo6njLarHw4V1m
        iytf37NZfF54j8ni6veXzBadE5ewW1zeNYfN4sHL/YwWh/qiHTg9Fv/8x+Tx/kYru8e8NdUe
        l/t6mTz2flvA4jG7Yyarx/3u40weB3ons3h83iQXwBnFZZOSmpNZllqkb5fAlbFz9zqWglPa
        FecWv2VsYFyo0sXIySEhYCLRPv0LWxcjF4eQwApGibnbHrFCOF8YJaY9WcYC4XxmlJiz6TUz
        TMvx6e8YIRLLGSUOLlrMDOG8BXKuNDKCVAkLREucXzEdLCEisI5JouftZyaQBLOAo8Tf/q1g
        o9gENCX+br7JBmKzCKhKTLh2G8wWFYiQOPJgIdggXgFBiZMzn7CA2JwCrhJTXr9jhJgjL9G8
        dTYzhC0ucevJfCaQZRICt9gl1i/+wwzRXCZx7vRHVoi7XSSm390K9YOwxKvjW9ghbBmJ05N7
        WCDseommmVeYIQZ1MEqcWLycDSJhLXH4+EWgQRxA2zQl1u/Shwg7Spz98Z0JJCwhwCdx460g
        xD18EpO2gTwPEuaV6GgTgqhWlLh/FuYCcYmlF76yTWBUmoXky1lIPpuF5LNZCHsXMLKsYhRP
        LS3OTU8tNsxLLdcrTswtLs1L10vOz93ECExfp/8d/7SD8eulpEOMAhyMSjy8G9YXRguxJpYV
        V+YeYpTgYFYS4bXcChTiTUmsrEotyo8vKs1JLT7EKM3BoiTOy6eVFi0kkJ5YkpqdmlqQWgST
        ZeLglGpgXObjvred+cydI0+uxXt/3KNtyuIw5dTKqxtmPM/h+cA87f8H+2DPXruXF/46PFdP
        OGaYfFlHd2OeS9BczlaTfOfLRjH5ht3SPxb/3N+YX60RXyvIYyeyJuh3OlvoQv5rotVJa98u
        /FwafDd6z95y9kSr2ctv9n6fe2KDm7yi1LUJU5+Gb7w3R4mlOCPRUIu5qDgRAM80gydbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsVy+t/xu7oR84qiDY4s1bFo6njLarHw4V1m
        iytf37NZfF54j8ni6veXzBadE5ewW1zeNYfN4sHL/YwWh/qiHTg9Fv/8x+Tx/kYru8e8NdUe
        l/t6mTz2flvA4jG7Yyarx/3u40weB3ons3h83iQXwBmlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hp
        oWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl7Fz9zqWglPaFecWv2VsYFyo0sXIySEhYCJx
        fPo7xi5GLg4hgaWMEr9ntzFBJMQlds9/ywxhC0v8udbFBlH0mlFi+/1FrCAJYYFoifMrpjOD
        JEQENjFJfPt1hQUkwSzgKPG3fyszRMcGJonju+6wgSTYBDQl/m6+CWbzCthJHDy/AWwdi4Cq
        xIRrt8HiogIREquXv2CFqBGUODnzCdhQTgFXiSmvQW4FWaAu8WfeJWYIW16ieetsKFtc4taT
        +UwTGIVmIWmfhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiM2G3Hfm7Z
        wdj1LvgQowAHoxIPL8emwmgh1sSy4srcQ4wSHMxKIryWW4FCvCmJlVWpRfnxRaU5qcWHGE2B
        npvILCWanA9MJnkl8YamhuYWlobmxubGZhZK4rznDSqjhATSE0tSs1NTC1KLYPqYODilGhj7
        emr2+htezHGcJzmtf8r3q7oN0uHKUTdLM0o/vnFq9D7DmatR8+Der0Izu73uL4pF7c0O/9+2
        dYLCSvsTbW+1bJe1ZB3aVLJ2kr3UXvH1zYrCJUbd5Rm7tubcf1LjbP+As63p5uJ3Zy9L6MrM
        4BEy0Mk5tePM1eP8hbu5FhyKulU9wW6R728lluKMREMt5qLiRACubofc7gIAAA==
Message-Id: <20180814091817eucas1p2c505255028937f57af4194a80151c015~KtZo3LHoA2083920839eucas1p2-@eucas1p2.samsung.com>
X-CMS-MailID: 20180814091817eucas1p2c505255028937f57af4194a80151c015
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180725035712epcas1p25df72b8af38438b7bb66a2729fdff445
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180725035712epcas1p25df72b8af38438b7bb66a2729fdff445
References: <CGME20180725035712epcas1p25df72b8af38438b7bb66a2729fdff445@epcas1p2.samsung.com>
        <20180725035627.58223-1-icenowy@aosc.io>
        <20180813114945eucas1p1e9d900848b4256341fe93278f4fa6f67~Kb0nDRoKq0841508415eucas1p1p@eucas1p1.samsung.com>
        <ddd86a558977fc9942f5f1fa8cefc813ad80f614.camel@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.08.2018 07:28, Icenowy Zheng wrote:
> 在 2018-08-13一的 13:49 +0200，Andrzej Hajda写道：
>> On 25.07.2018 05:56, Icenowy Zheng wrote:
>>> Currently dw_hdmi_setup is only run when the dw-hdmi bridge is
>>> enabled,
>>> with the mode set last time.
>>>
>>> When the bridge is enabled before any mode is set (this may happen
>>> when
>>> booting), the mode won't be set at all, some setup steps will be
>>> skipped or fail, and the HDMI output may not work.
>> I guess, it should not happen. Could you show the stack-trace.
> Mysteriously dw_hdmi_setup isn't called at all currently when booting
> in thie situation. I added dump_stack() at the head of the function,
> and it's only triggered when I re-plug the monitor.

I think more informative would be stack trace from bridge enable, which
happens before any modeset, this is something suspicious.

Anyway if dw_hdmi_setup is not called at boot it clearly shows there is
issue with power-on logic in dw-hdmi.c, not with mode_set.
Quick look at dw_hdmi_update_power shows it is not straightforward, and
could be buggy.

>
> In this case I got:
> ```
> [   46.891513] CPU: 0 PID: 73 Comm: irq/34-1ee0000. Not tainted 4.18.0+
> #152
> [   46.898290] Hardware name: Allwinner sun8i Family
> [   46.903008] [<c010efac>] (unwind_backtrace) from [<c010bfd0>]
> (show_stack+0x10/0x14)
> [   46.910746] [<c010bfd0>] (show_stack) from [<c06f59c4>]
> (dump_stack+0x88/0x9c)
> [   46.917966] [<c06f59c4>] (dump_stack) from [<c04444d8>]
> (dw_hdmi_update_power+0xb8/0x12cc)
> [   46.926225] [<c04444d8>] (dw_hdmi_update_power) from [<c044593c>]
> (dw_hdmi_bridge_enable+0x2c/0x70)
> [   46.935262] [<c044593c>] (dw_hdmi_bridge_enable) from [<c04261f0>]
> (drm_bridge_enable+0x24/0x34)
> [   46.944040] [<c04261f0>] (drm_bridge_enable) from [<c0404fd0>]
> (drm_atomic_helper_commit_modeset_enables+0x9c/0x180)
> [   46.954552] [<c0404fd0>] (drm_atomic_helper_commit_modeset_enables)
> from [<c040879c>] (drm_atomic_helper_commit_tail_rpm+0x24/0x64)
> [   46.966361] [<c040879c>] (drm_atomic_helper_commit_tail_rpm) from
> [<c040861c>] (commit_tail+0x40/0x6c)
> [   46.975657] [<c040861c>] (commit_tail) from [<c040870c>]
> (drm_atomic_helper_commit+0xbc/0x128)
> [   46.984259] [<c040870c>] (drm_atomic_helper_commit) from
> [<c040ac70>] (restore_fbdev_mode_atomic+0x1cc/0x220)
> [   46.994164] [<c040ac70>] (restore_fbdev_mode_atomic) from
> [<c040df90>] (drm_fb_helper_restore_fbdev_mode_unlocked+0x54/0xa0)
> [   47.005369] [<c040df90>] (drm_fb_helper_restore_fbdev_mode_unlocked)
> from [<c040e00c>] (drm_fb_helper_set_par+0x30/0x54)
> [   47.016226] [<c040e00c>] (drm_fb_helper_set_par) from [<c040df08>]
> (drm_fb_helper_hotplug_event.part.11+0xa0/0xa8)
> [   47.026563] [<c040df08>] (drm_fb_helper_hotplug_event.part.11) from
> [<c03fee0c>] (drm_helper_hpd_irq_event+0x110/0x118)
> [   47.037334] [<c03fee0c>] (drm_helper_hpd_irq_event) from
> [<c0445888>] (dw_hdmi_irq+0x10c/0x194)
> [   47.046025] [<c0445888>] (dw_hdmi_irq) from [<c01626a8>]
> (irq_thread_fn+0x1c/0x54)
> [   47.053589] [<c01626a8>] (irq_thread_fn) from [<c01629c4>]
> (irq_thread+0x158/0x21c)
> [   47.061241] [<c01629c4>] (irq_thread) from [<c013a324>]
> (kthread+0x148/0x150)
> [   47.068373] [<c013a324>] (kthread) from [<c01010e8>]
> (ret_from_fork+0x14/0x2c)
> [   47.075584] Exception stack(0xee8bbfb0 to 0xee8bbff8)
> [   47.080630] bfa0:                                     00000000
> 00000000 00000000 00000000
> [   47.088797] bfc0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [   47.096964] bfe0: 00000000 00000000 00000000 00000000 00000013
> 00000000
> ```
>
>>> Re-run dw_hdmi_setup when setting mode, in order to prevent such
>>> situation.
>> mode_set is run with hardware disabled, thus usually it should not
>> touch
>> hardware.
> However I think there's many instances now where some hardware setup is
> performed in mode_set.

It does not prove it is correct way :)

If you look at docs [1] for descriptions of *mode_set* callbacks for
various components (crtc,encoder,bridge), you will see it should not be
used to program HW in case of runtime_pm drivers, and since dw-hdmi is
used by multiple platforms you cannot assume it is or it will not be the
case. IMO whole mode_set callback can be removed, as it performs
unnecessary work.


>
>>
>>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>> ---
>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>> index 5971976284bf..e2f832182afe 100644
>>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>> @@ -2007,6 +2007,7 @@ static void dw_hdmi_bridge_mode_set(struct
>>> drm_bridge *bridge,
>>>  
>>>  	/* Store the display mode for plugin/DKMS poweron events */
>>>  	memcpy(&hdmi->previous_mode, mode, sizeof(hdmi-
>>>> previous_mode));
>>> +	dw_hdmi_setup(hdmi, mode);
>> This hdmi->previous_mode also looks strange, it is current mode and
>> moreover it is always available from crtc state, there is no point in
>> copying it to private field.
> Sorry I don't know about this. Maybe you should ask the original author
> of dw-hdmi?

Sorry for noise, it is not introduced by your patch, but just related to it.

Regards
Andrzej

>
>> Regards
>> Andrzej
>>>  
>>>  	mutex_unlock(&hdmi->mutex);
>>>  }
>>
>
>

