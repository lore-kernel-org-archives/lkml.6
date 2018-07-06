Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456B6C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0049E2402E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGwDWmMn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0049E2402E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753611AbeGFGQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:16:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:48282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753314AbeGFGQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 02:16:32 -0400
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 453B42402E;
        Fri,  6 Jul 2018 06:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530857791;
        bh=kV+BExkt3fLYQoqCAj9s8kMcxfG9L+bus3/UAJWRsbg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=tGwDWmMnpdnwVw+G0cz+Uf/1Vj8T4kYq/y41mUiE1o7MDKoLwL1353elOiqPBIPCb
         BuzAXr+gZxGgaN9FNOyQ4Nzg3md/dzra58qbVFTgrBgcRq7fZYxZevWWeh4nvel3Yv
         NAVs3WTX/t7hNMvK6rauMZYGtW60lDk4EoOQKf7k=
Received: by mail-wm0-f41.google.com with SMTP id z13-v6so13319062wma.5;
        Thu, 05 Jul 2018 23:16:31 -0700 (PDT)
X-Gm-Message-State: APt69E2o9d6q9Vzt4RQfY/SFI3yESPN/ecHS+J8i5Wtz7vX4A8TyRBKe
        vBDXifCF+uaOqUmuQMHeKo/Z6WxpT8F9j3SQJq0=
X-Google-Smtp-Source: AAOMgpdo0FxW9dkhXpcspdDTM+sLqoSxkYPUDANuD+TYQCyRKQ3BTfFYFpIhYCtghcmj35AUDsWNJBvTungTSMP0FLg=
X-Received: by 2002:a1c:3a15:: with SMTP id h21-v6mr5929681wma.72.1530857789827;
 Thu, 05 Jul 2018 23:16:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9166:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 23:16:29 -0700 (PDT)
In-Reply-To: <20180706060541.GT22377@vkoul-mobl>
References: <CAJKOXPcVFrkEA4YV3gi-gPYhtTXHeKtv4CvL29gstfTacz2sMg@mail.gmail.com>
 <20180705073552.GI22377@vkoul-mobl> <20180705081253.GA3513@jerusalem>
 <20180705124526.GA3620@jerusalem> <7d2bc5bc8cd01347acf1858ba816b12d@agner.ch>
 <20180705162308.GB3620@jerusalem> <20180706060541.GT22377@vkoul-mobl>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 6 Jul 2018 08:16:29 +0200
X-Gmail-Original-Message-ID: <CAJKOXPf+Ja-SnZ+kKFNE1Uwi84dfSwW=eYaYz92E_u+X4XSUqA@mail.gmail.com>
Message-ID: <CAJKOXPf+Ja-SnZ+kKFNE1Uwi84dfSwW=eYaYz92E_u+X4XSUqA@mail.gmail.com>
Subject: Re: [BUG] Serial/dma stall/failure after "dmaengine: fsl-edma:
 extract common fsl-edma code (no changes in behavior intended)"
To:     Vinod <vkoul@kernel.org>
Cc:     Angelo Dureghello <angelo@sysam.it>,
        Stefan Agner <stefan@agner.ch>, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 July 2018 at 08:05, Vinod <vkoul@kernel.org> wrote:
> On 05-07-18, 18:23, Angelo Dureghello wrote:
>> Hi Stafan,
>>
>> On Thu, Jul 05, 2018 at 05:55:31PM +0200, Stefan Agner wrote:
>> > Hi Vinod, Hi Angelo,
>> >
>> > On 05.07.2018 14:45, Angelo Dureghello wrote:
>> > > Hi Vinod,
>> > >
>> > > On Thu, Jul 05, 2018 at 10:12:53AM +0200, Angelo Dureghello wrote:
>> > >> Hi Vinod,
>> > >>
>> > >> On Thu, Jul 05, 2018 at 01:05:52PM +0530, Vinod wrote:
>> > >> > On 04-07-18, 10:54, Krzysztof Kozlowski wrote:
>> > >> > > Hi,
>> > >> > >
>> > >> > > The commit 6ad069123f03bebe4315dea13d44845854ca6043 ("dmaengine:
>> > >> > > fsl-edma: extract common fsl-edma code (no changes in behavior
>> > >> > > intended)"), even though marked as no changes in behavior intended...
>> > >> > > make serial console with DMA broken after boot. The console just hangs
>> > >> > > - is not responsive even to SysRq. Usually after finishing boot -
>> > >> > > before or after login prompt. Sometimes login is allowed and then it
>> > >> > > hangs during printing dmesg.
>> > >> > >
>> > >> > > Board: Toradex Colibri VF50 (NXP VF500, Cortex A5, serial configured
>> > >> > > with DMA) on Iris Carrier.
>> > >> >
>> > >> > Angelo ?
>> > >> >
>> > >> sorry for this. As said i couldn't test it in any of those arm boards
>> > >> but i take a look.
>> > >>
>> > >> The only code part that changes is the initial setting up of the registers.
>> > >> I am checking that.
>> > >>
>> > >> Regards,
>> > >> Angelo
>> > >>
>> > >
>> > > I cannot find anything obviously wrong.
>> > > And i cannot test on Vybrid.
>> > > I will try to get a Vybrid V50 board to test this issue. It would
>> > > require some days and also i wil be 3 weeks off on July.
>> > >
>> > > So please revert my patch.
>> >
>> > I did not found the issue quickly. But I must say that I gave up pretty
>> > quickly. There are too many changes in a single patch which makes it
>> > hard to figure out what could be wrong. I'd rather prefer if we could
>> > drop that patch again and go through another review phase.
>> >
>> > Angelo, as far as I can see the patch has not been sent to LKML or the
>> > ARM mailing list. Especially since you do not have such a device it
>> > would have been nice to also send it to the ARM mailing list...
>> >
>> > Can you resend your last revision with CC to me/ARM mailing list?
>> >
>>
>> Thanks for looking into it.
>>
>> I have spent a lot of time on this patch and really would have
>> dma for Coldfire available. So, have ordered a Colibri / v50 board.
>>
>> Should receive it in few days and should be able to debug this issue,
>> but as said, i will be off for some weeks so looks like it is probably
>> better to revert the patch.
>>
>> My initial submit was a separate driver, to avoid such issues where
>> i cannot test, but it resulted in too much duplicated code.
>>
>> Sure, i can send the full patch to you/arm with all the fixes included
>> until now.
>
> Okay dropped now from -next. I still keeping topic/fsl around and
> collect other fixes for you guys to check.
>
> One way would be to split to common patch into multiple patch and check
> regression. That should help quickly identify the issue.

Even with show -C20% -M20% I gave up when trying to spot possible
differences in the commit. I understand that logically it is one
change and it makes sense... but it touches, moves and adds too much
making review extremely difficult. I think the splitting into smaller
chunks would be beneficial anyway.

Today's next boots fine.

Best regards,
Krzysztof
