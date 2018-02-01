Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeBAPQK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 10:16:10 -0500
Received: from foss.arm.com ([217.140.101.70]:51380 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751788AbeBAPQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 10:16:07 -0500
Subject: Re: [PATCH] soc: mediatek: Handle return of of_match_device function
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Himanshu Jha <himanshujha199640@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Weiyi Lu <weiyi.lu@mediatek.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>, sean.wang@mediatek.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kevin-cw.chen@mediatek.com, Cheng Mars <mars.cheng@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <1517482822-28758-1-git-send-email-himanshujha199640@gmail.com>
 <b8265d37-0ef0-9d24-8ace-8fae7f67477d@arm.com>
 <CAMuHMdWxH9kQ7Zq5jCHL0hkA3Oin17f75TAq9dPC7FQMagT-vA@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <5fe8a04b-de13-87fb-2916-f3d26e320c4d@arm.com>
Date: Thu, 1 Feb 2018 15:16:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWxH9kQ7Zq5jCHL0hkA3Oin17f75TAq9dPC7FQMagT-vA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/18 15:09, Geert Uytterhoeven wrote:
> On Thu, Feb 1, 2018 at 4:02 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>> On 01/02/18 11:00, Himanshu Jha wrote:
>>> In scpsys_probe function, return value of of_match_device function which
>>> returns null is dereferenced without checking. Therefore, add a check for
>>> potential null dereference.
>>>
>>> Detected by CoverityScan, CID#1424087 "Dereference null return value"
>>>
>>> Fixes: commit 53fddb1a66dd ("soc: mediatek: reduce code duplication of
>>> scpsys_probe across all SoCs")
>>> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
>>> ---
>>>    drivers/soc/mediatek/mtk-scpsys.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/soc/mediatek/mtk-scpsys.c
>>> b/drivers/soc/mediatek/mtk-scpsys.c
>>> index 435ce5e..6e7f196 100644
>>> --- a/drivers/soc/mediatek/mtk-scpsys.c
>>> +++ b/drivers/soc/mediatek/mtk-scpsys.c
>>> @@ -981,6 +981,9 @@ static int scpsys_probe(struct platform_device *pdev)
>>>          int i, ret;
>>>          match = of_match_device(of_scpsys_match_tbl, &pdev->dev);
>>> +       if (!match)
>>> +               return -EINVAL;
>>> +
>>>          soc = (const struct scp_soc_data *)match->data;
>>
>> You could of course replace the whole sequence with an
>> of_device_get_match_data() call, which happens to be inherently safe against
>> the no-match case even when that *is* impossible by design.
> 
> +1
> 
>>>          scp = init_scp(pdev, soc->domains, soc->num_domains, &soc->regs,
> 
> ... followed by the static analyser gang complaining we may dereference
> NULL pointer soc...

Well, if the static analysers can't track the provenance of 
dev->driver->of_match_table, let's keep ignoring them until they get 
cleverer :P

Robin.

> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
> 
