Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF68C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0F720664
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=openedev.com header.i=@openedev.com header.b="aLX6M3Fy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0F720664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=openedev.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbeJ2V3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:29:39 -0400
Received: from se15t.web-hosting.com ([162.255.118.154]:56979 "EHLO
        se15t.web-hosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729210AbeJ2V3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:29:39 -0400
Received: from [68.65.123.203] (helo=server153.web-hosting.com)
        by se15.registrar-servers.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <jagan@openedev.com>)
        id 1gH6qq-00056f-Ib; Mon, 29 Oct 2018 05:41:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=openedev.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Twhaj3EeHbXtWFuvs41H1HaPwSZHo6QIZWBl/tLQTqM=; b=aLX6M3FyJbMN9IYyTT5HtCAfTf
        ujJmHjhhwh5EfkygN89B/GsjLOa/YzDnAAKJM/gTB89lGGvyajznSofqfYW8r8y53AgZa+rpnQbH/
        sd1hvS6N7YcE7jGYRu2UOZgZkO/VZ0DIsF0qLZqmvxg1u0q9Wc37d9KoesywzOpjfDd8AvfSoU4Uq
        YaDmy2FZ4zuklrhpwyvsYYwDYto/FCcY0opjoQSUMdzy5BzZ2VoKNVOe8/dqferXu7RcBQn5nxkee
        g88uGdGqXwbkYLmFOy/C2Su4xP7pMIG8EtwsNCFHDg08/yRr6BlgM5yVNrtL/nOhAqXcEJuL8nm4b
        AaAb4WwA==;
Received: from [27.7.51.1] (port=44346 helo=[192.168.0.10])
        by server153.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <jagan@openedev.com>)
        id 1gH6ql-0048DE-VK; Mon, 29 Oct 2018 08:40:56 -0400
Subject: Re: [linux-sunxi] Re: [PATCH v2 02/15] clk: sunxi-ng: Add check for
 minimal rate to NKM PLLs
To:     maxime.ripard@bootlin.com, Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
 <20181023155035.9101-3-jagan@amarulasolutions.com>
 <20181024180436.5n3i3z6h2yezc4cv@flea>
 <CAMty3ZC2wn-DjR+93yc-n-bAmVCHaEqR_=4XPddoo+7LjebTEg@mail.gmail.com>
 <20181029085843.3bslqwktxbp2ywk2@flea>
From:   Jagan Teki <jagan@openedev.com>
Message-ID: <e7566001-8933-adbb-4c30-7a3f66ebae4e@openedev.com>
Date:   Mon, 29 Oct 2018 18:10:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181029085843.3bslqwktxbp2ywk2@flea>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-1.0
X-Originating-IP: 68.65.123.203
X-SpamExperts-Domain: nctest.net
X-SpamExperts-Username: whmcalls3
Authentication-Results: registrar-servers.com; auth=pass (login) smtp.auth=whmcalls3@nctest.net
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.12)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5jtnxjJTX1r/FHjct7FdKQR602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO0Ma0zdKrj2HeYAO9pcN4rBgaa/6KAnDjbDW9Kfk8S67rc0diZKnmpMa4igsMUptb3ws
 3TRjaC42FtNJuTWwh7zDil9nzpwm+X/neb6NqWhvt8C9mOBdONdnsxgsk1D2p81t61bzOH+dRuda
 OCHhfvkbONHJki/bT3w/adEN9DqaPbFM3vei53Yyp3v779HcSLG62plOzR5DsoLGZCSqoE3JNAYC
 28t8cR5ITCXTcZqmvaqpXrmasHx4eiR7j6vX9B9laqTmco/p+9en7IdA6p9E/g67cwxyIR8VmA5e
 WtNvnSJzSMipXLKj208wF0l+/LRpsq1uynJlGc1wGBNxKAasUDAM310p3PNWWaIaSygi7PgEVsGe
 cFro/0JGrOyRSaDNUgpG8fAJ7Lg21L451C+Y73wey0WZIByhkSafuhnLcy3brt7kvrJyGkSOIbze
 Phts3vFtUDOwEYF9reFkRh1Z2XmZE6Ulo3Sg6/fHCWNx01dKq9doQCQL/RyDC8HpXAynucv4rnju
 YPOfZh8jslwg7QT+iN5/VyfWKR5edUF17qyCLW5GY4F23J7eq8SL0BtM8UT3jCT30WOGa77ANY69
 cBNhkoiRE9GgA7DbpeRaXeO0Hg/cLwycMnvIieVWIs4dJKDqjPjhvPjqAjKg6VeiSiHqKnOM6HUc
 1C6txUOgA50Rgoi231VkAC4d/u07DCMMQ72GN0COt/Z36GxUDe1/x2bFJS+Hj6rj4u8HaEmUmRte
 96yD8dzCpBzb1xqI9vQuc8Wou4TIK4Bcb6TQCr94GXpVQ2KwGtu81JXrQcgqRYMJqVDlz3D3q3rG
 z4wpqXduuWzX2YNPcyspnKOz/GpVtBEI/lNmY9JL/ej0hsKuKmLtSOgDyocRXs5/Dj5QrbiOquAw
 kPRjlgIoLaXIRRdYY1xob1S/a4Rw9BKeg+GlaQRG0qurVqDgRPCOBb4ws+nK6Hdu5ythdss+87CL
 YnNBoGfS0DhK3BfvFNI4fRpBbmGFHU0Fd1FYwiLqVhSu3v+nCpyCSdscG09FH1xvLyyjtb2gYbxM
 T6+Iy9pOFZK275ou5bBvQX3uElphnHsYcHZLfQ+dkTJQ3t6fkiyQeQV6EipRzMVZ5LqwTx7Vvn9S
 VCuiP+10HNhHuWYhdKNkJvfZdFJiZZPY9MnZD1O5yq1ycjOgLhowTS+P/adv11jhdDXJuCjECe9/
 DZu9RkdixH794DwLyWvhpaC58QnTx8fUsuiVMUz2osEFaYRxsB6RP1WtefrqFnxOMi6sKMFKy5Lq
 LFUIM7si3XKl+gouHE7VOEtHO7BXRk+kb0Ie3l6uI43eRHGnZHBV/yCqCu6qSDKF6cyRQGDgv3gB
 ylcgE5FvKJMDf827d4qRh+RMTc6UnSUfEaFbXfx3YmWV3Eu1dd5T48p+m8Gi9mpWQ6cJTOhMhoTy
 AjQts04eAyoaGqs2BxWyJ5iZ/mYkQw5Sva7E5XuqpjkxjsxX7/OU+X56MDbCOXzqrgeRjh9HHXX0
 2BXFZ0oSYx0xwIlnSxHDnJq+tjf1ariSumYaswHs71h51UM9FqN9xH7aeMYHGsZ/4QaVkaMLBQ2N
 o2eCxS3UTYtuZQ==
X-Report-Abuse-To: spam@se16.registrar-servers.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/18 2:28 PM, Maxime Ripard wrote:
> On Thu, Oct 25, 2018 at 04:25:59PM +0530, Jagan Teki wrote:
>> On Wed, Oct 24, 2018 at 11:34 PM Maxime Ripard
>> <maxime.ripard@bootlin.com> wrote:
>>>
>>> On Tue, Oct 23, 2018 at 09:20:22PM +0530, Jagan Teki wrote:
>>>> Some NKM PLLs doesn't work well when their output clock rate is set below
>>>> certain rate.
>>>>
>>>> So, add support for minimal rate for relevant PLLs.
>>>>
>>>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>>>> ---
>>>> Changes for v2:
>>>> - new patch
>>>>
>>>>   drivers/clk/sunxi-ng/ccu_nkm.c | 7 +++++++
>>>>   drivers/clk/sunxi-ng/ccu_nkm.h | 1 +
>>>>   2 files changed, 8 insertions(+)
>>>>
>>>> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
>>>> index 841840e35e61..d17539dc88dd 100644
>>>> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
>>>> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
>>>> @@ -125,6 +125,13 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
>>>>        if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
>>>>                rate *= nkm->fixed_post_div;
>>>>
>>>> +     if (rate < nkm->min_rate) {
>>>> +             rate = nkm->min_rate;
>>>> +             if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
>>>> +                     rate /= nkm->fixed_post_div;
>>>
>>> I'm not sure this is right. Is the post divider taken into account to
>>> calculate the minimum, or is the minimum on the rate before the fixed
>>> post divider.
>>
>> Since we are returning from here, we need to take care post div which
>> is actually doing at the end of round_rate.
> 
> That's not my point though. Does the rate needs to be superior to min
> / post_div, or min?

ie what I'm trying to say, since it's common code min or max should / 
post_div and PLL_MIPI doesn't use any post_div.

We need to take care post_div though the current test (PLL_MIPI) in not 
used since it's common code. just like nkmp, nm etc.

> 
>>>
>>> How did you test this?
>>
>> I've not used this on PLL_MIPI atleast, so I didn't test this.
> 
> If you've never tested this, why are you adding that code?

Like above, it's common code. otherwise might effect.
