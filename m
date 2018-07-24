Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D14ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD68920856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="NMfnX3lu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bfYfFNtq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD68920856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388403AbeGXQS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:18:29 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:33470 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388363AbeGXQS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:18:29 -0400
Received: by mail-vk0-f67.google.com with SMTP id y70-v6so2210446vkc.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 08:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=qFM+fiXNPUXOjGJ7BHvFw+K1F10NxCr2EFaxJr0BO1o=;
        b=NMfnX3luOwCNzrFo2HQdDKNCI2PQwGwlGIENTa4Z7ephtWCB66tKnPcXQitmswmkNL
         aFzaS0F/bN2Jeqv/tHM/OTk4nBT7+Lfny3HkKTcGOFVpMRtz/xa+WXLDLd961w9Fu4oD
         0sY/oxn32+q2Bo08H+Gp3aFxSP+acOjAfpIdQhycWN1WMbYDRvRoEqbzjArQQpUQ3uaq
         0yz6vDY9FxkbY5/mcL9ww7IBZFX5kDm2WajUPc34Zj+EiSeL+Sfn89ZWv5Z0Jja2lCQ6
         mZDxWLZS48Rn8Z4r9209MYl9Z2TbtrV5+DVb/vMY0zyftyTGszhpV+DKMi0glmIsI2p5
         zv5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=qFM+fiXNPUXOjGJ7BHvFw+K1F10NxCr2EFaxJr0BO1o=;
        b=bfYfFNtq683JT9K0r8LYfNTWBSyIGst6qh8fx0ods1vO43AHHl8GucG6ANG85+2E/k
         +ylpxHmcm4TztA6Oa5g6m3g8Ty6yBAFvcykL6pAwXOrNz98MTD3COkOAGc2HWiWijqci
         bIbFrphEKh/MfyI3lMhfrTW/dYQJzvAeJZSP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=qFM+fiXNPUXOjGJ7BHvFw+K1F10NxCr2EFaxJr0BO1o=;
        b=rhJf2Q6eEPB+E+GLk74xDOguqicJ0EQne6N+OyMTdDVs/nWd8qZY3BfBFqe4l0nxfm
         Q5+EJMET/tF1rDQAjE/P/X6dn6/VebOsTo0Zq/F91f7KgUhlfEfwGG0BQQqMq3sN8T8r
         nkFkZgUpHnoPwE4FXfbT0AqaaZ+PzAEqxidFjRUhJYdQJFOBGsmoX86KJI9HqT0hKz1Z
         Q4P8mFQ8kpgWAb0MoJhbqUch1FOsMMKjVsYx3D3HuB5hAqNkcp4onrdXX708joEFeOtY
         VjdYQEsFWQecGshPsEAzLHkBb9AApXNfuAY98vqbqpIK/LfE8JRxhtacJk7+cLB6SoTx
         31LQ==
X-Gm-Message-State: AOUpUlFMwl95kq7/kBKdynV641+4cq+w+zThEfSyH2cPumVbPgKymJbn
        /Gtx0eCOSx2yiWktQcpOIffZi95EBLMXvCIqRQyTXg==
X-Google-Smtp-Source: AAOMgpct4QsRF9Iic5VH1NzLv39Bt104bFnZAYFiPiWzIY3vXZJ5Ultm3tDHcx2jNTucemt266IfttW7aJnkuf+0o6s=
X-Received: by 2002:a1f:a784:: with SMTP id q126-v6mr10905600vke.70.1532445092069;
 Tue, 24 Jul 2018 08:11:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 08:11:30 -0700 (PDT)
In-Reply-To: <20180724145755.GF13268@sirena.org.uk>
References: <cover.1531531808.git.collinsd@codeaurora.org> <56b9d5c38cfe46da1228c54f001a49773c3e31dc.1531531808.git.collinsd@codeaurora.org>
 <CAD=FV=VmfqWRGRMEn+0dzZ8x4R5vVaHbkthXAN91Lm-XmP9Gqg@mail.gmail.com> <20180724145755.GF13268@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 24 Jul 2018 08:11:30 -0700
X-Google-Sender-Auth: mgimC9Yod0cgnybveRBY4gqSY-w
Message-ID: <CAD=FV=Uo8sT72a0gRitOVoK0SfC-_QixsovW94_LnL6H7QdKvA@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] regulator: dt-bindings: add QCOM RPMh regulator bindings
To:     Mark Brown <broonie@kernel.org>
Cc:     David Collins <collinsd@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 24, 2018 at 7:57 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jul 23, 2018 at 01:09:05PM -0700, Doug Anderson wrote:
>
>> I know you are still looking for time to review the RPMh-regulator
>> driver and that's fine.  One idea I had though: if the bindings look
>> OK to you and are less controversial, is there any chance they could
>> land in the meantime?
>
> This appears to have a bunch of dependencies which I've got no idea
> what's going on with the merging of and no idea if they'll affect the
> bindings or anything, nobody's said anything and last I looked it was
> unclear what was going on.

RPMh itself landed in Andy's tree and he sent a pull request on
Saturday.  Feel free to refer to the request ("[GIT PULL] Qualcomm
Driver updates for 4.19") AKA
<https://patchwork.kernel.org/patch/10539125/>.

It doesn't look like arm-soc has picked up Andy's pull request yet
though.  If having it in arm-soc is a requirement then I'm happy to
monitor arm-soc and ping this thread again when it's there.


> I'm kind of hoping that things might have
> sorted themselves out of the merge window.
>
> Some of the decisions in the code have flowed out into the bindings
> before so I'm not keen to merge the bindings separately,

Fair point.  I was thinking that we had pared the driver down enough
now that the bindings were no longer anything other than just
boilerplate bits describing the hardware, but it's obviously your
decision when you're happy to land them.


> and if the
> driver for the thing used to communicate with the device is still in
> review then that's definitely a red flag.

As per above it's been landed, so hopefully this red flag is removed?


-Doug
