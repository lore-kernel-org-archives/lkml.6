Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751908AbeBAPJa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 10:09:30 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39659 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751555AbeBAPJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 10:09:27 -0500
X-Google-Smtp-Source: AH8x227YDFQ+Gal1dtoxF5cWEzeqK9xireETs3acexueeXtqtwaoOfZrkoNhx5jnQl0BrpesmsK+GR8FYZBhpU4m38A=
MIME-Version: 1.0
In-Reply-To: <b8265d37-0ef0-9d24-8ace-8fae7f67477d@arm.com>
References: <1517482822-28758-1-git-send-email-himanshujha199640@gmail.com> <b8265d37-0ef0-9d24-8ace-8fae7f67477d@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 1 Feb 2018 16:09:26 +0100
X-Google-Sender-Auth: Ec1pTHdfQD_-GUHPaoeZh2ubZqA
Message-ID: <CAMuHMdWxH9kQ7Zq5jCHL0hkA3Oin17f75TAq9dPC7FQMagT-vA@mail.gmail.com>
Subject: Re: [PATCH] soc: mediatek: Handle return of of_match_device function
To: Robin Murphy <robin.murphy@arm.com>
Cc: Himanshu Jha <himanshujha199640@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Weiyi Lu <weiyi.lu@mediatek.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>, sean.wang@mediatek.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kevin-cw.chen@mediatek.com, Cheng Mars <mars.cheng@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 1, 2018 at 4:02 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 01/02/18 11:00, Himanshu Jha wrote:
>> In scpsys_probe function, return value of of_match_device function which
>> returns null is dereferenced without checking. Therefore, add a check for
>> potential null dereference.
>>
>> Detected by CoverityScan, CID#1424087 "Dereference null return value"
>>
>> Fixes: commit 53fddb1a66dd ("soc: mediatek: reduce code duplication of
>> scpsys_probe across all SoCs")
>> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
>> ---
>>   drivers/soc/mediatek/mtk-scpsys.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/soc/mediatek/mtk-scpsys.c
>> b/drivers/soc/mediatek/mtk-scpsys.c
>> index 435ce5e..6e7f196 100644
>> --- a/drivers/soc/mediatek/mtk-scpsys.c
>> +++ b/drivers/soc/mediatek/mtk-scpsys.c
>> @@ -981,6 +981,9 @@ static int scpsys_probe(struct platform_device *pdev)
>>         int i, ret;
>>         match = of_match_device(of_scpsys_match_tbl, &pdev->dev);
>> +       if (!match)
>> +               return -EINVAL;
>> +
>>         soc = (const struct scp_soc_data *)match->data;
>
> You could of course replace the whole sequence with an
> of_device_get_match_data() call, which happens to be inherently safe against
> the no-match case even when that *is* impossible by design.

+1

>>         scp = init_scp(pdev, soc->domains, soc->num_domains, &soc->regs,

... followed by the static analyser gang complaining we may dereference
NULL pointer soc...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
