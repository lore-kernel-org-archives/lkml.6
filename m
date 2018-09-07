Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE95C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82602075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YHbGllDj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C82602075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbeIGVHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:07:05 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:44334 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbeIGVHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:07:05 -0400
Received: by mail-yw1-f65.google.com with SMTP id l9-v6so5579410ywc.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 09:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OEk2WljBHFeTbPUuH4TMNaRorwBNs6MuUKX7hXCUFzc=;
        b=YHbGllDjtYi2DUYdXpsjF8F6SeVlYr4l9I8XUaU0729wAnT1vKsQWT6veBojJR6kfm
         LW40w1V4yT8LlC9RjMYoNIEH2qkA0V8w6Ec1Ctgse0zUiv5EfzRPojKThpCrn8tWboOG
         KvWQ0OlfdLfnSM0JVFH60rC0ouUVzV/4lUMDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OEk2WljBHFeTbPUuH4TMNaRorwBNs6MuUKX7hXCUFzc=;
        b=jPP39Up5CikPFxxmzi3GSRH+C4PdRXkF2WZem3eKnfEi03aonJFmVf7a3Cy7RCh2S7
         KY2ELIeu9TrNWtRXwb/kpU10rTlMPiSKdXBK3CgEG9NoTfGAzffOMdho7nx9BY787Fe5
         jTazgC+cTTbU5GLC/X41sg8iFod9SykLTwYWoCcBJ8Mz+Ay9il9h7SA0RfDBg9s3/Mc5
         iGuVswXczW4IQZ53AgmRVuzh2VKKj7ZTzyBVhw04B1Hz0mqEfphzE6jfzwMVHNZ7B3+F
         K6KqwBgwv1uiO0WO0374wUGotg/toCvS7NkVkBsX2GJLaUBZ4W1qPU4cYSx6JDHNNl/L
         nQ5Q==
X-Gm-Message-State: APzg51B1Ye7El9fW42BB6Yj8ONNfXS+E5HgJDnMkmkhQbo6iHfsu87fg
        7XMgnIOqe2WrgakpbQM0Syh8TcH3/Ac=
X-Google-Smtp-Source: ANB0VdbFYmtT5o6ek47q1j/pCwk+oGd/6nXptmrfQrQbRxbb8IvIuhmZtGuQulPsk2GydJmIi53m+g==
X-Received: by 2002:a81:7815:: with SMTP id t21-v6mr4451570ywc.174.1536337524445;
        Fri, 07 Sep 2018 09:25:24 -0700 (PDT)
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id f82-v6sm3145943ywf.58.2018.09.07.09.25.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 09:25:24 -0700 (PDT)
Received: by mail-yw1-f52.google.com with SMTP id j131-v6so5574884ywc.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 09:25:24 -0700 (PDT)
X-Received: by 2002:a0d:ea0a:: with SMTP id t10-v6mr4453847ywe.60.1536337148524;
 Fri, 07 Sep 2018 09:19:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d04c:0:0:0:0:0 with HTTP; Fri, 7 Sep 2018 09:19:06 -0700 (PDT)
In-Reply-To: <2493fc3fa3f6e5d2bcdde27cee1c33df@codeaurora.org>
References: <1535107336-2214-1-git-send-email-dkota@codeaurora.org>
 <CAD=FV=XigmU1LXnNbj9NYkjJmj18chBFjbctrBeOKoS=34PLXw@mail.gmail.com> <2493fc3fa3f6e5d2bcdde27cee1c33df@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 7 Sep 2018 09:19:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VzYYyive--RzN=_OCQnFT-wgHwbUy1Vao2-8GADxHDLw@mail.gmail.com>
Message-ID: <CAD=FV=VzYYyive--RzN=_OCQnFT-wgHwbUy1Vao2-8GADxHDLw@mail.gmail.com>
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
