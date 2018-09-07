Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698C9C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248992075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iaUvVQkR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248992075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeIGVAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:00:49 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:42823 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbeIGVAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:00:49 -0400
Received: by mail-yw1-f67.google.com with SMTP id n207-v6so5577488ywn.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 09:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OEk2WljBHFeTbPUuH4TMNaRorwBNs6MuUKX7hXCUFzc=;
        b=iaUvVQkRJNvY3V9Jdvx6YNOKucyCZCAPBGkMg45U1trBsdG+aYANRr9P5dYq2W01mR
         yC0wiHvreFqvvijNPYj5Ak7R+Q9Bg+adETuOwWt1WwkSuO6O5Md4ZiT1zv1/pxLQw8a4
         pH4F8480RmBIlupyXdCFlBMZLqPj2pHij5Xrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OEk2WljBHFeTbPUuH4TMNaRorwBNs6MuUKX7hXCUFzc=;
        b=FXwH4OhKOfuN8UM0VATKw60UApCyUbJmA3+W4kU0ChDNvsGmQqa4rRr/BAExbES0Mr
         iKDnOwNpSTEeod1e/EZdlUUPi/CNMsuS4NwvDLxOw2KnuuvJijEszwb80gY1fed/smVq
         UG4ESLRSpJnTZOlHCN5BEV1VQY70IjhDxzCmRlU4XmP+SeVE5Ir7Dmwr5qgsmAZm4sOv
         XiMV0Z6ztldu4yJhuFVEzzMb8efaxYti1i7TLuSfOofw0ROo/V70Q7pqgkzMgijvjb5B
         /N5kjxGiAxV5ocO47XETWIWWRahk5EpldImA73JFCTI8DTtKJkON+CJPD51VLZZmSIU9
         yghg==
X-Gm-Message-State: APzg51CBPVEYGAbeC9dVm8dhRKvPn2tSnNcvRShKQbESgg8hNcbXMhPL
        NjXIk8jk9XignWerPypHLYg6M5tYM0g=
X-Google-Smtp-Source: ANB0VdYDt//LjSP8jIaDDpI/zM/fZdzjMtYpXrTu/7fbwrq5Dfv7SBKuGAWBWt5GbeQtcgzI/Fe5xA==
X-Received: by 2002:a81:3743:: with SMTP id e64-v6mr3315749ywa.29.1536337149952;
        Fri, 07 Sep 2018 09:19:09 -0700 (PDT)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id j70-v6sm2856840ywb.69.2018.09.07.09.19.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 09:19:08 -0700 (PDT)
Received: by mail-yw1-f43.google.com with SMTP id 14-v6so5596077ywe.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 09:19:08 -0700 (PDT)
X-Received: by 2002:a81:380a:: with SMTP id f10-v6mr4539910ywa.83.1536337147841;
 Fri, 07 Sep 2018 09:19:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:5e8e:0:0:0:0:0 with HTTP; Fri, 7 Sep 2018 09:19:03 -0700 (PDT)
In-Reply-To: <2493fc3fa3f6e5d2bcdde27cee1c33df@codeaurora.org>
References: <1535107336-2214-1-git-send-email-dkota@codeaurora.org>
 <CAD=FV=XigmU1LXnNbj9NYkjJmj18chBFjbctrBeOKoS=34PLXw@mail.gmail.com> <2493fc3fa3f6e5d2bcdde27cee1c33df@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 7 Sep 2018 09:19:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U8rzZcZUixo=zD1C9y0VBBfFfM6jAB9+9uerkfTMrRiQ@mail.gmail.com>
Message-ID: <CAD=FV=U8rzZcZUixo=zD1C9y0VBBfFfM6jAB9+9uerkfTMrRiQ@mail.gmail.com>
Subject: Re: [PATCH V3] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
To:     Dilip Kota <dkota@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 7, 2018 at 3:00 AM,  <dkota@codeaurora.org> wrote:
>> In v2, I said:
>>
>>> I'm not sure where to comment about this, so adding it to the end:
>>>
>>> Between v1 and v2 you totally removed all the locking.  Presumably
>>> this is because you didn't want to hold the lock in
>>> handle_fifo_timeout() while waiting for the completion.  IMO taking
>>> the lock out was the wrong thing to do.  You should keep it, but just
>>> drop the lock before wait_for_completion_timeout() and add it back
>>> afterwards.  Specifically you _don't_ want the IRQ and timeout code
>>> stomping on each other.
>>
>>
>> ...but still no spinlock?
>
> I see there is no need of taking the spinlock as timeout will be handled
> after the calculated time as per data size and speed.
> There is 99.9% less chances of interrupt during the timeout handler.
>>
>>
>>
>> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1201081

The thing is, we want it to be 100% reliable, not 99.9% reliable.  Is
it somehow wrong to add the spinlock?  ...or are you noticing
performance problems with the spinlock there?  It's just nice not to
have to think about it.

-Doug
