Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A23AC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8ECA21727
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XROU9wnQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8ECA21727
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbeHNWv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 18:51:58 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46591 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbeHNWv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 18:51:58 -0400
Received: by mail-ua1-f66.google.com with SMTP id u11-v6so14560078uan.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 13:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+NQ1WSG8jaiHTeVKMmtoDbxDA6s3RtBEaDUiEmvyqKQ=;
        b=XROU9wnQRQFtyL5qQnqPcmR+9aAP+/2/VnYre2WKONbnctBOyvmOfxAaEAg/6u3E/5
         Upeut3rO5yt6Wvx8/cxWxi7T6HWO0YuKrMXwotOnGD68cJ1ZdAvZVxKb0uK9GP328T8G
         C34vYI/66okEmYyZtqfmPlBqFB3EL6jXcxhZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+NQ1WSG8jaiHTeVKMmtoDbxDA6s3RtBEaDUiEmvyqKQ=;
        b=MLVr3pMdkRnkLINm6JsiD8fx6VdSrh2MBbExbG4yHtqmaYeUjVNNPVo6qEv5fvf5aD
         DYP4J8QaGTiwxqRu0gUgaR5rdDWYuO3ymhBqaBejvSCdDijWvtYUq951tIjeGNCouvsU
         gqvTlTKzBqOzaMRXUESpXR62krYxNI7JyGdrvl6bitR5FKydX+hZh4/UgKVA2XTap2XY
         +Xrd8bOmlseHYAPlk4zfCed5grGeL01Z9QvQDBs28v49/1+pGlnQCmg/6UAcRXw2rgXX
         iv0MMGou8TnJAUhWrTCQhsilJi9ktEFM/TCGs1LrNsDMcydPCe8GlagPNVOua88VPZQF
         kNFQ==
X-Gm-Message-State: AOUpUlEdCyBlZIyL1Wzs4wbL0R9ukLUD95b+YMym++jb3/0iTa9imMP3
        x9OhuqusTK+XghodGB8+FLaGhqEt4tg=
X-Google-Smtp-Source: AA+uWPy0eOe9vf6Ilxfz47DGMWSjw3a9OuJhTIAnZhefotZYHXILklJbGbZMmmD9MRWlXawVeRZjbQ==
X-Received: by 2002:a9f:3613:: with SMTP id r19-v6mr15241860uad.73.1534276990042;
        Tue, 14 Aug 2018 13:03:10 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id m133-v6sm6205546vka.52.2018.08.14.13.03.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 13:03:09 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id k25-v6so14554906uao.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 13:03:09 -0700 (PDT)
X-Received: by 2002:ab0:4364:: with SMTP id k91-v6mr3278628uak.46.1534276988384;
 Tue, 14 Aug 2018 13:03:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 13:03:07 -0700 (PDT)
In-Reply-To: <bf70f01d-41ac-dcdc-b503-5e0eb1e70329@codeaurora.org>
References: <20180814170617.100087-1-dianders@chromium.org>
 <20180814170617.100087-2-dianders@chromium.org> <bf70f01d-41ac-dcdc-b503-5e0eb1e70329@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 14 Aug 2018 13:03:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VNCOyyq5+xvSudTmtBgPm4-s7gj7GRCvuL5vSmA6yDVA@mail.gmail.com>
Message-ID: <CAD=FV=VNCOyyq5+xvSudTmtBgPm4-s7gj7GRCvuL5vSmA6yDVA@mail.gmail.com>
Subject: Re: [PATCH 1/4] regulator: core: If consumers don't call
 regulator_set_load() assume max
To:     David Collins <collinsd@codeaurora.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 14, 2018 at 11:30 AM, David Collins <collinsd@codeaurora.org> wrote:
> The behavior introduced by this patch seems like an undesirable hack to
> me.  It goes against the general philosophy within the regulator framework
> of taking no action unless directed to do so by an explicit consumer
> request (or special device tree property).  We should assume that
> consumers make requests to meet their needs instead of assuming that they
> are missing important votes required by their hardware.

I don't agree so I guess it will be up to Mark to decide.

Specifically I will note that there are boatloads of drivers out there
that use the regulator framework but don't have a call to
regulator_set_load() in them.  Are these drivers all broken?  I don't
think so.  IMO the regulator_set_load() API is an optional call for
drivers that they can use to optimize power usage, not a required API.


>> --- a/drivers/regulator/core.c
>> +++ b/drivers/regulator/core.c
>> @@ -732,6 +732,7 @@ static int drms_uA_update(struct regulator_dev *rdev)
>>       struct regulator *sibling;
>>       int current_uA = 0, output_uV, input_uV, err;
>>       unsigned int mode;
>> +     bool any_unset = false;
>>
>>       lockdep_assert_held_once(&rdev->mutex);
>>
>> @@ -751,11 +752,17 @@ static int drms_uA_update(struct regulator_dev *rdev)
>>               return -EINVAL;
>>
>>       /* calc total requested load */
>> -     list_for_each_entry(sibling, &rdev->consumer_list, list)
>> +     list_for_each_entry(sibling, &rdev->consumer_list, list) {
>>               current_uA += sibling->uA_load;
>> +             if (!sibling->uA_load_set)
>> +                     any_unset = true;
>> +     }
>>
>>       current_uA += rdev->constraints->system_load;
>>
>> +     if (any_unset)
>> +             current_uA = INT_MAX;
>> +
>
> This check will incorrectly result in a constant load request of INT_MAX
> for all regulators that have at least one child regulator.  This is the
> case because such child regulators are present in rdev->consumer_list and
> because regulator_set_load() requests are not propagated up to parent
> regulators.  Thus, the regulator structs for child regulators will always
> have uA_load==0 and uA_load_set==false.

Ah, interesting.

...but doesn't this same bug exist anyway, just in the opposite
direction?  Without my patch we'll try to request a 0 mA load in this
case which seems just as wrong (or perhaps worse?).  I guess on RPMh
regulator you're "saved" because the RPMh hardware itself knows the
parent/child relationship and knows to ignore this 0 mA load, but it's
still a bug in the overall Linux framework...

I have no idea how we ought to propagate regulator_set_load() to
parents though.  That seems like a tough thing to try to handle
automagically.


-Doug
