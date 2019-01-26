Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53443C282C0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 00:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1B5218FF
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 00:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QRAMv4pt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfAZABV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 19:01:21 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35866 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfAZABU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 19:01:20 -0500
Received: by mail-lj1-f193.google.com with SMTP id g11-v6so9801596ljk.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 16:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bivZF+N5UQBK8QlBWBWjTitl9qn7GkzcyFvvnhd7MCs=;
        b=QRAMv4pt2wTw41Xy606JFLtBQ/Tzuun7yaXzkdy58rK1o7QtdzeUSY8XDAQYSicxsR
         BM92IpzsANL7rWyV/Iyr2xtH644hOohv3nCQ8RmH0uEELReZdPnLqSaXmb/xJcuosCKo
         /0t3S4WlVMeSC8Qb7DzJBljcsJ4NrbOK5JNQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bivZF+N5UQBK8QlBWBWjTitl9qn7GkzcyFvvnhd7MCs=;
        b=bdI1/lnwueYd3BGfF8eASNRNbXQkWV9tPVJZ4nd7IXJw9MzHKstYDQhfSge8kzMbE4
         47ETRfY9O0NaoOTg3Hy0N2kub/P31NfKNm9gaHQYpWKZ5Zco3g9H168MHGZOCp32QGot
         EhX2P1CfZpQ4YjXavUXJoCy4XYkxReGaBzdHJmTNVaEAtvE8F4yrwOpcFwnNBVwDzZJA
         my2/nl/eRjrwEkkZm0UpZIte6aOkXuxbdesPRcvnmAmMIdHaHtZtoxuf35zdiz9vghrc
         Diav+O6A+KPCDPBcjGIUpGzFTUROcXT3KtRaAi/AhNc9WzYjkTQA5+kgENzyfBoO+rrr
         EPuw==
X-Gm-Message-State: AJcUukdCTM8cV37TvhOLMcqwTs8Tr9i4aLz7XpYwtZ8pBBnayCwZNxHW
        KvXyogegmDGxREa5W0QvB8b3cmNavMk=
X-Google-Smtp-Source: ALg8bN6h9W/wx29UQhWLuf8Z1Ep2PPR2dfwtnpu1i3AFhc3xVfO084+ql2wCPUFYWKYpMiW92Ng6OQ==
X-Received: by 2002:a2e:3012:: with SMTP id w18-v6mr10215653ljw.75.1548460877760;
        Fri, 25 Jan 2019 16:01:17 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id s127sm1776108lfe.8.2019.01.25.16.01.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 16:01:16 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id k15-v6so9764211ljc.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 16:01:15 -0800 (PST)
X-Received: by 2002:a2e:7e04:: with SMTP id z4-v6mr10925579ljc.97.1548460875218;
 Fri, 25 Jan 2019 16:01:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548312692.git.asutoshd@codeaurora.org> <d6aa4d9bd29bbb2c3ee78e6635d4704e4113a26e.1548312692.git.asutoshd@codeaurora.org>
 <CAE=gft6P9ssNp_GRUFJT7BvJUHduorg=-bvi0KytDMWTd0pGew@mail.gmail.com> <926d2232-67f2-bd3a-ab79-87bbca3a1add@codeaurora.org>
In-Reply-To: <926d2232-67f2-bd3a-ab79-87bbca3a1add@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 25 Jan 2019 16:00:38 -0800
X-Gmail-Original-Message-ID: <CAE=gft7fxf52ud7FQLqT6L3PRoP3cUDYqnG8yqPtyTh=9D72UA@mail.gmail.com>
Message-ID: <CAE=gft7fxf52ud7FQLqT6L3PRoP3cUDYqnG8yqPtyTh=9D72UA@mail.gmail.com>
Subject: Re: [<PATCH v1> 1/1] scsi: qcom-ufs: Add support for bus voting using
 ICB framework
To:     "Asutosh Das (asd)" <asutoshd@codeaurora.org>
Cc:     subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 2:29 AM Asutosh Das (asd)
<asutoshd@codeaurora.org> wrote:
>
> On 1/24/2019 10:22 PM, Evan Green wrote:
> > On Wed, Jan 23, 2019 at 11:02 PM Asutosh Das <asutoshd@codeaurora.org> wrote:
> >>
> >> Adapt to the new ICB framework for bus bandwidth voting.
> >>
> >> This requires the source/destination port ids.
> >> Also this requires a tuple of values.
> >>
> >> The tuple is for two different paths - from UFS master
> >> to BIMC slave. The other is from CPU master to UFS slave.
> >> This tuple consists of the average and peak bandwidth.
> >>
> >> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> >> ---
> >>   .../devicetree/bindings/ufs/ufshcd-pltfrm.txt      |  12 ++
> >>   drivers/scsi/ufs/ufs-qcom.c                        | 234 ++++++++++++++++-----
> >>   drivers/scsi/ufs/ufs-qcom.h                        |  20 ++
> >>   3 files changed, 218 insertions(+), 48 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> >> index a99ed55..94249ef 100644
> >> --- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> >> +++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> >> @@ -45,6 +45,18 @@ Optional properties:
> >>   Note: If above properties are not defined it can be assumed that the supply
> >>   regulators or clocks are always on.
> >>
> >> +* Following bus parameters are required:
> >> +interconnects
> >> +interconnect-names
> >> +- Please refer to Documentation/devicetree/bindings/interconnect/
> >> +  for more details on the above.
> >> +qcom,msm-bus,name - string describing the bus path
> >> +qcom,msm-bus,num-cases - number of configurations in which ufs can operate in
> >> +qcom,msm-bus,num-paths - number of paths to vote for
> >> +qcom,msm-bus,vectors-KBps - Takes a tuple <ib ab>, <ib ab> (2 tuples for 2 num-paths)
> >> +                           The number of these entries *must* be same as
> >> +                           num-cases.
> >
> > I think we can do away with all of the qcom* ones, right? This should
> > be achievable with just interconnects and interconnect-names.
> Let me give that a bit more thought - though I'm not sure how that'd work.

From the downstream kernel that I have, it looks like these are
basically used to define the bandwidth values for each gear/mode in
UFS. My understanding is that the DT folks generally balk at having
configuration data in the device tree. I'm hopeful that we can have a
snippet of code that actually computes the required bandwidth for a
certain combination of gear speed and lanes. But if that is somehow
not possible, this can at worst be a table in code of
bandwidths[gear]. But let's try for the computation first.

>
> >
> > Also, is this patch based on a downstream tree? I don't recognize a
> > lot of the context. We'll need a patch that's based on an upstream
> > tree.
> This was developed on the internal Chrome AU and ported to ufs-next.
> Let me check internally on this anyway.
>

Whoops, you're right, the context I was confused about does appear to
be upstream. I was unaware there was dangling code to the old
downstream bus scaling stuff in the upstream kernel. I think we should
get rid of all of that and start fresh.

Also, like the dangling downstream code was, the new stuff should
probably be surrounded by ifdefs for the new interconnect core.

I also think we don't really need the max_bus_bw thing, so when we rip
out all the downstream leftovers we don't need to put that back in.

-Evan
