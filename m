Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085EBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84C520855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="feJ2v6da"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84C520855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbeK0B1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:27:30 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49574 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeK0B1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:27:30 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181126143311euoutp0148900609e1a6ef385a0c0ef1d0483672~qsyRqvkP80377303773euoutp01t
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 14:33:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181126143311euoutp0148900609e1a6ef385a0c0ef1d0483672~qsyRqvkP80377303773euoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543242791;
        bh=IUA4Toq0dTeF3103/ASVyV5zvRsmW9+FXDCYMPfJLsY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=feJ2v6damayDluuhbhMrJ6/oMVZcHuU+uCP8ir5RuM4KtfWIADr2QpuQEG2hVNKAL
         MyvWhiG2HyKev3K2GcNvmUtWROik03vnV+C+L/EYIYZJNDlkHgl8Yc+a6LriSrs1AC
         DjNCfGKtXLOijVIvtgc4QXNCRCiiK4EnWhTN51WU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181126143310eucas1p1106e5c073bebaf67bbd54280978ce657~qsyRBvG7G0908309083eucas1p1P;
        Mon, 26 Nov 2018 14:33:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 31.A4.04294.6240CFB5; Mon, 26
        Nov 2018 14:33:10 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181126143309eucas1p1de850ddef9dc6beba46e899919c92c39~qsyQLaY0M0989509895eucas1p1g;
        Mon, 26 Nov 2018 14:33:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181126143309eusmtrp1ba7c3a818182621f514c9794e4536c17~qsyP8HB_31639316393eusmtrp1M;
        Mon, 26 Nov 2018 14:33:09 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-cd-5bfc0426b52a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 47.00.04128.5240CFB5; Mon, 26
        Nov 2018 14:33:09 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181126143309eusmtip17e81b823e99d01e8351c06cda04264f9~qsyPi8Y7f2753427534eusmtip1s;
        Mon, 26 Nov 2018 14:33:09 +0000 (GMT)
Subject: Re: [REGRESSION PATCH] fbdev: fbmem: behave better with small
 rotated displays and many CPUs
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Fabian Frederick <ffrederick@users.sourceforge.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Geoff Levand <geoff@infradead.org>,
        James Simmons <jsimmons@users.sf.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <94947dad-2ac4-99b0-3ebd-0aba62f27d4a@samsung.com>
Date:   Mon, 26 Nov 2018 15:33:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <8faae5c6-ce11-99b4-4fc7-7a8925aad3e4@axentia.se>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRj2O2c7no0mx2n6amm4vJDgLYQOJsNucCK60K/QHzbzMMUrm7NM
        AlOmslnpJMVLaDptTmVjhpYi2Spn3kC6YAXqDwksl9Z0kkrldpT89zzP+7zv+7wfH4mLLfxA
        MjO3gFXkyrIlhJDXP/p7Oiqct50Suzgnpt+vrxD02MIQTj9q0iFavySl5wxB9Nj9VT79brCZ
        oIetLYg2tXwmkgRM3UiTJ1MzFcX0GSKZea0NY2yzAxjT3XWJKR2v4DMOS/AVMlmYmM5mZxay
        ihjpdWGG2VJP5Du8b7WZS/ES1OSlQSQJVDxUf4jSICEppgwIdF9reRxZQ9C5oMM54kDwS3uX
        r0ECd0encRXjCk8QmO/Zd8kKgnWNGnO5fCg5vNA1EC7sS4VA62CjexROdeBgaJp3jyKoBKip
        MCIXFlFS0A/X8V2heFQYOIyhLniQugYPJiM4hze8bVjkubBgx12u1rvH49QRGLA3u8cDNeoJ
        WzMlnlzSs2Ad7yY47APfbE939cMwUVvF4xrqESxvduwSE4KeyVGMc52EV7YZdyCcOgamwRhO
        PgW9rw0Y93heMGv35kJ4ga6/HudkEVSWizl3OJg7zcTeWs3zLpzDDPxoq8KqUUjjvtMa953T
        +H9vK8KNyJ9VKXPkrPJ4LnszWinLUapy5dE38nIsaOcnTfyxrT1Dg9tpVkSRSHJAZN7YShHz
        ZYXKohwrAhKX+Iou6nckUbqs6DaryEtVqLJZpRUdInkSf1Gxx0KKmJLLCtgsls1nFXtVjBQE
        liCy9gy/TtirtmKmoQRnVnna8vnk1A1nxHamQPu93Tb3RTWi1qcFnI728qNJR8BcdR8Y2sPw
        WrXPOU3snbjxMo86cWLAzyQsNEEqD6r4mI2XmaZFbzoe25adm6pubRlpccjWPqUa/V4eZRL/
        TvU8vHri8oWldnu8MyW4OKtSwlNmyOIicYVS9g9aou8VRQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xu7qqLH+iDeaelLS48vU9m8WJB7uZ
        LebOnsRoseSlncW9FbIWJ/o+sFpc3jWHzWLvofmMFuvn32Jz4PSYdmA2u8fEs7oem1doedzv
        Ps7kcfzGdiaP1Sv9PJpOtbN6fN4kF8ARpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hs
        HmtlZKqkb2eTkpqTWZZapG+XoJexYdN0toLPghWLNjQxNzDO5uti5OSQEDCRWLbqA1MXIxeH
        kMBSRol/k+cwdzFyACVkJI6vL4OoEZb4c62LDaLmLaPEnzkTmUESwgLpEp2v+sFsEQFFiQW7
        ZjFDFO1hlJj+/wMjiMMssJRZovvoVVaQKjYBK4mJ7asYQWxeATuJJXunsYJsYxFQlfi8SgUk
        LCoQIXHrYQcLRImgxMmZT8BsTqDyttYlbCA2s4C6xJ95l5ghbHmJ7W/nME9gFJyFpGUWkrJZ
        SMoWMDKvYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIy2bcd+btnB2PUu+BCjAAejEg/vhu+/
        o4VYE8uKK3MPMUpwMCuJ8PouAQrxpiRWVqUW5ccXleakFh9iNAX6YSKzlGhyPjAR5JXEG5oa
        mltYGpobmxubWSiJ8543qIwSEkhPLEnNTk0tSC2C6WPi4JRqYOxYwM8xec1yN+5jClPXvr10
        UkZRwXJSWknhJY79L1K0n5b7ZEtpXPOQbz3V1xf0nuncn9ZFbflfnx2o6lkreLpdhaH+tZpL
        ypbQ9CXnH1ZdzTXVUFnOx5Wp+cNFyeyPqRPvzH2GG6av+1fIlnntpYqz+42FpY0qG6d7J/19
        8XLOhBcmmtf17iqxFGckGmoxFxUnAgDOOU8tzAIAAA==
X-CMS-MailID: 20181126143309eucas1p1de850ddef9dc6beba46e899919c92c39
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181126141651epcas1p346d68ff01402cea354ad4686fdbb7284
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181126141651epcas1p346d68ff01402cea354ad4686fdbb7284
References: <20181108095347.19326-1-peda@axentia.se>
        <CGME20181126141651epcas1p346d68ff01402cea354ad4686fdbb7284@epcas1p3.samsung.com>
        <8faae5c6-ce11-99b4-4fc7-7a8925aad3e4@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/2018 03:16 PM, Peter Rosin wrote:
> Ping?!

Hi,

Thank you for your patch, it will be considered for 4.21 (as it is not
a recent regression + I'm busy with other things currently).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Cheers,
> Peter
> 
> On 2018-11-08 10:54, Peter Rosin wrote:
>> Blitting an image with "negative" offsets is not working since there
>> is no clipping. It hopefully just crashes. For the bootup logo, there
>> is protection so that blitting does not happen as the image is drawn
>> further and further to the right (ROTATE_UR) or further and further
>> down (ROTATE_CW). There is however no protection when drawing in the
>> opposite directions (ROTATE_UD and ROTATE_CCW).
>>
>> Add back this protection.
>>
>> The regression is 20-odd years old but the mindless warning-killing
>> mentality displayed in commit 34bdb666f4b2 ("fbdev: fbmem: remove
>> positive test on unsigned values") is also to blame, methinks.
>>
>> Fixes: 448d479747b8 ("fbdev: fb_do_show_logo() updates")
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/video/fbdev/core/fbmem.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
>> index bb7f5f23e347..1abeb0b72455 100644
>> --- a/drivers/video/fbdev/core/fbmem.c
>> +++ b/drivers/video/fbdev/core/fbmem.c
>> @@ -435,7 +435,9 @@ static void fb_do_show_logo(struct fb_info *info, struct fb_image *image,
>>  			image->dx += image->width + 8;
>>  		}
>>  	} else if (rotate == FB_ROTATE_UD) {
>> -		for (x = 0; x < num; x++) {
>> +		u32 dx = image->dx;
>> +
>> +		for (x = 0; x < num && image->dx <= dx; x++) {
>>  			info->fbops->fb_imageblit(info, image);
>>  			image->dx -= image->width + 8;
>>  		}
>> @@ -447,7 +449,9 @@ static void fb_do_show_logo(struct fb_info *info, struct fb_image *image,
>>  			image->dy += image->height + 8;
>>  		}
>>  	} else if (rotate == FB_ROTATE_CCW) {
>> -		for (x = 0; x < num; x++) {
>> +		u32 dy = image->dy;
>> +
>> +		for (x = 0; x < num && image->dy <= dy; x++) {
>>  			info->fbops->fb_imageblit(info, image);
>>  			image->dy -= image->height + 8;
>>  		}
