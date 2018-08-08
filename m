Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3D8C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4215E21765
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XBZmxL1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4215E21765
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbeHHSBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:01:45 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43370 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbeHHSBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:01:44 -0400
Received: by mail-yw1-f66.google.com with SMTP id l189-v6so1851435ywb.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 08:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=w5DZR1Hj5OKUI3bISCQwYDPdEe4C/ei/hIs8E76wxu0=;
        b=XBZmxL1puwaMlmron0Mg6EQr8Kb80OoJ17eTi9ws8Aqu08R46gZi+Gl0ZjdvVumkvJ
         BILYXGZW6sG9KKIdpyqBiOx48QgZt+0ILci69/W4e1bBZCiIXX283Fjdj69cOl0o2P8T
         QWmoLQH4BtjH9R9vqMbgDbY2LpuJPS3FeAmgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=w5DZR1Hj5OKUI3bISCQwYDPdEe4C/ei/hIs8E76wxu0=;
        b=SY5+06dtv4MbOedWUQiQC5ow9luumTuEGaXpO/PPgpH6Cs9Q+/SZps3tlR2lH1XF1V
         31bbIHNfLy4M427mcAPX8CcQeRy0NO6cmqXOQ82h5zuf5R1qM/lDq13zOampfR6EBwc0
         IVoCbhRXLaCwSVS/s4h7Ad/2hIXmuza+fz+hcgi5/Bu2xTyh46xN32KpBxA7KXLUAXi5
         XzlTNyZGoMf50NcPZhE/NFsPvh14D1xG3DKQcXDQgHuZF4oGDJmNgTyJLAFS5Uz4417z
         gURZedfLPbumwoci/xdMqYAn0F4Jx5ffStbduNq+ifH4ema3WCwpoFBqsMo7hQ4ISyiJ
         VNHQ==
X-Gm-Message-State: AOUpUlGwv4jN77X+BRIaOhT1mVi9MHfeFT6Xb2nr9Gp3QU7NJ3UBCraD
        FWXPW/6BOEwfkRd8i1kW/hH2V+AOj6o=
X-Google-Smtp-Source: AA+uWPxitvvVhsGKY4UUDrU4RYeeMa7Mfygovxo+eJR+xOax3rYmwRx2xboCkL7MFJiMRg7kXki2Hg==
X-Received: by 2002:a25:7c44:: with SMTP id x65-v6mr1723662ybc.437.1533742891271;
        Wed, 08 Aug 2018 08:41:31 -0700 (PDT)
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com. [209.85.161.48])
        by smtp.gmail.com with ESMTPSA id u64-v6sm3735465ywu.107.2018.08.08.08.41.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:41:29 -0700 (PDT)
Received: by mail-yw1-f48.google.com with SMTP id z143-v6so1856688ywa.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 08:41:29 -0700 (PDT)
X-Received: by 2002:a25:add4:: with SMTP id d20-v6mr1735945ybe.463.1533742888843;
 Wed, 08 Aug 2018 08:41:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:7450:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 08:41:28 -0700 (PDT)
In-Reply-To: <871sb942cx.fsf@kamboji.qca.qualcomm.com>
References: <20180807225040.GA2164@beast> <20180808092450.GA25772@redhat.com> <871sb942cx.fsf@kamboji.qca.qualcomm.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 8 Aug 2018 08:41:28 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKqeAHDWdNg++QJko5AM4g160kEQ54jLAojpRq6FszqgA@mail.gmail.com>
Message-ID: <CAGXu5jKqeAHDWdNg++QJko5AM4g160kEQ54jLAojpRq6FszqgA@mail.gmail.com>
Subject: Re: [PATCH wireless-drivers] mt76x0: Remove VLA usage
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Stanislaw Gruszka <sgruszka@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 2:46 AM, Kalle Valo <kvalo@codeaurora.org> wrote:
> Stanislaw Gruszka <sgruszka@redhat.com> writes:
>
>> On Tue, Aug 07, 2018 at 03:50:40PM -0700, Kees Cook wrote:
>>> Even with "const" variables, the compiler will generate warnings about
>>> VLA usage. In the quest to remove all VLAs from the kernel[1], this uses
>>> a #define instead of a const to do the array sizing.
>>>
>>> [1]
>>> https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>>
>>> Fixes: e87b5039511a ("mt76x0: eeprom files")
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>> ---
>>> Please include this for the v4.19 merge window. The VLA was introduced
>>> with the new source file (which I also note is missing a SPDX line), so
>>
>> I thought SPDX line is needed only if file has no license and eeprom.c
>> file and other mt76x0 files have specified the license. Is SPDX still
>> needed in that case ?

I thought all source files needed SPDX: https://lwn.net/Articles/739183/

>>
>>> +#define MT_MAP_READS        DIV_ROUND_UP(MT_EFUSE_USAGE_MAP_SIZE, 16)
>>>  static int
>>>  mt76x0_efuse_physical_size_check(struct mt76x0_dev *dev)
>>>  {
>>> -    const int map_reads = DIV_ROUND_UP(MT_EFUSE_USAGE_MAP_SIZE, 16);
>>> -    u8 data[map_reads * 16];
>>
>> Why this is variable length array? DIV_ROUND_UP can not be calculated
>> at compile time? But if so, macro do not change the situation either.
>
> The commit log mentioned:
>
>   "Even with "const" variables, the compiler will generate warnings about
>    VLA usage."
>
> So I guess the compiler (gcc?) is just not smart enough in this case?

Correct. This is technically a false positive, but with the goal of
adding -Wvla to the build globally, we have to get rid of these as
well. It's a little frustrating, I agree, but with all others fixed
now, these stand out. :)

-Kees

-- 
Kees Cook
Pixel Security
