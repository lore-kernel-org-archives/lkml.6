Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D5DC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A92320881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A92320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbeIMMKJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 08:10:09 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34903 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbeIMMKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 08:10:09 -0400
Received: by mail-lf1-f67.google.com with SMTP id q13-v6so3874126lfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 00:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KRdWlk5uVYAEVUZwL4iHRm9XeMBrapaUYPwsyVAv6Po=;
        b=ScPXeCf1vtpiUpfJV8204nKYrJsYc/3ByqrVByXbbuNPZrQ5MphRfbMcqp+W7+kQO9
         2Nq+qWOCXpDmoc/2JXoT5mfhQhfFzhFU4gg6Ng99vjy5uaDEQ94yEkXN3U7JJ/6dLpp0
         fLp+tz2YEluxrEVFp84zujaJqLsOZv0kGWBmcMt86QYdBgSMtfHN9eqRhyMCoDD2Q2vk
         fWBy3VIVfU9mzMdynLZ1h9Goc6rXwA1F+HyQ+CEkBdoMoS8of8F1z62dyeJY56AWB7he
         JnVrbcato9x/PjxxVOQEhOAKVUZ59iOwuwSwRWQzXx5TBPAiJAr/uSvh2S2DQeRHUdMu
         QLHw==
X-Gm-Message-State: APzg51B25bZX3kefGWu9DWasDfRJs0H8fJ+WVxvm423YCK5p3a5x/Yzf
        +LeJ1t7vwEwDsa8SRs9ezysN2ZNbpGbwFfTf0Encdg==
X-Google-Smtp-Source: ANB0VdZytGP0eoinSUaXt/bBQ/lgoKfUWjwpbdRV2iMxMG6v+iN2HyPmFcwSyOFmbac0nc0bpfIOd2//YkulEiLHFdE=
X-Received: by 2002:a19:d808:: with SMTP id p8-v6mr3685382lfg.105.1536822119306;
 Thu, 13 Sep 2018 00:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <1536810739-27342-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1536810739-27342-1-git-send-email-zhongjiang@huawei.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 13 Sep 2018 09:01:47 +0200
Message-ID: <CAO-hwJJAGdUokt4rByNFsit1bY8t3ZpV3CFh-ES7-GNukZTBLw@mail.gmail.com>
Subject: Re: [PATCH] HID: logitech: fix a used uninitialized GCC warning
To:     zhongjiang@huawei.com
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 6:04 AM zhong jiang <zhongjiang@huawei.com> wrote:
>
> Fix the following compile warning:
>
> drivers/hid/hid-logitech-hidpp.c: In function ‘hi_res_scroll_enable’:
> drivers/hid/hid-logitech-hidpp.c:2714:54: warning: ‘multiplier’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>   hidpp->vertical_wheel_counter.resolution_multiplier = multiplier;
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 5f0c080..83c43dd 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -2696,7 +2696,7 @@ static int hi_res_scroll_look_up_microns(__u32 product_id)
>  static int hi_res_scroll_enable(struct hidpp_device *hidpp)
>  {
>         int ret;
> -       u8 multiplier;
> +       u8 uninitialized_var(multiplier);

I think your patch is correct (multiplier will be set given the code
path), but IMO, it feels terribly wrong to explicitly remove this
warning this way. The problem is that if someone else adds a new piece
of code, we might miss the fact that multiplier is not set and we
might show garbage in the hid_info call.

Why don't you initialize the value to 8 as in the 'else' statement and
remove the now duplicated assignement in this else statement?

Cheers,
Benjamin

>
>         if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_X2121) {
>                 ret = hidpp_hrw_set_wheel_mode(hidpp, false, true, false);
> --
> 1.7.12.4
>
