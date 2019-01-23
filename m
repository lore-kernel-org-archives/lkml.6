Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95E9C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 04:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4B1217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 04:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="USJlPe1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfAWEvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 23:51:17 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39382 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfAWEvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 23:51:17 -0500
Received: by mail-ot1-f68.google.com with SMTP id n8so825956otl.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 20:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h7AFpoW1OJISLjtuUgEaf+hEQBevXpMX4q7t19fZ9Wg=;
        b=USJlPe1wxD1C6SXpCm93y8NpbgWM07sGNXpWuJjtSnGbPsJ+wYZp3dC/a+kfvpFtUi
         NmkBrNZoABfM+unuOFIZUfiP3KZJZRFEYzPJ3hopBK1rdosSjIm8HxfElpsI4F9qzH1z
         bZRQ8MBMmcV3SY2Ab6S/Vn5gqN+8M7PL1wMpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h7AFpoW1OJISLjtuUgEaf+hEQBevXpMX4q7t19fZ9Wg=;
        b=kuOIGL76nOoSr5Fj0vA3L4F40XedcCKwbPS98Lk2k238t8w6k9FTjNSqOBdi5toZpV
         OY68yO1zeuB+3fRA4gk5jKoSYSQQ5Gy9RIGIXWlKL8FlGSoLPStHgFNauc4fg3hkrbta
         +RrHxLvK6xhevdVovaglHrx+jHap22llqmm9MMFqI0pm0yd0BuU5WRktXZfnkFxHdP1i
         Xx49nFNiD6dSIbab8E61i1wHY4ooDvMpSwKHfi0KpWeRABxCtCihbtts75Idt0dkRugw
         qNeaqdyxGz4980HqNHJLqK8xcP+n2/eXfbVBNxa1XtWrKM524ZmC5DUo4JjM7//Fdoe/
         b2wA==
X-Gm-Message-State: AJcUukf1EBDbGH7+S1NX1/WHuK5yqCLqnioZjt2E/waB6Vy6+J2isnVA
        zGqfrEZJEVADFlcCS5BKHVChL2b6EaKC4WytLJ1MLQ==
X-Google-Smtp-Source: ALg8bN7efuFFPTz8RBWZw9yzvR1ezKo1h9zO8Ab+ROmmOp4w68TnEXlG5nNCPyTu0uw1dsckBkCoRKF0oh6R1RdGDwQ=
X-Received: by 2002:a9d:4:: with SMTP id 4mr519114ota.174.1548219076241; Tue,
 22 Jan 2019 20:51:16 -0800 (PST)
MIME-Version: 1.0
References: <1547790380-6276-1-git-send-email-pramod.kumar@broadcom.com>
 <20190118113242.GA8928@e107155-lin> <CAJ+tv6+6yqT1xkmkY3x6SNQ83K+J6zqKZr7PV5A_ffvyEzceqg@mail.gmail.com>
 <20190121112248.GA27784@e107155-lin>
In-Reply-To: <20190121112248.GA27784@e107155-lin>
From:   Pramod Kumar <pramod.kumar@broadcom.com>
Date:   Wed, 23 Jan 2019 10:21:05 +0530
Message-ID: <CAJ+tv6++eXwu7Ez-GW62Avgaj+h0aPhyL0K-n3mBgwM2RtXXjQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/1] arm64: Use PSCI calls for CPU stop when hotplug
 is supported
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Sudeep for reviewing. Please see my comment inline below.

On Mon, Jan 21, 2019 at 4:52 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Mon, Jan 21, 2019 at 11:28:27AM +0530, Pramod Kumar wrote:
> > On Fri, Jan 18, 2019 at 5:02 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > On Fri, Jan 18, 2019 at 11:16:20AM +0530, Pramod Kumar wrote:
> > > > If CPU hotplug is supported, ipi_cpu_stop should use PSCI cpudie
> > > > call to stop the CPU. This call ensures L1/L2 cache flush,
> > > > CPUs cache-cohenrecy setting w.r.to interconnect.
> > >
> > > Firstly, this is not specific to PSCI and I don't see any PSCI calls as
> > > $subject claims.
> >
> > I had seen all the other cpu ops methods where only PSCI supports only
> > cpu_die features hence used PSCI reference in my subject line to be more
> > clear where this die gets converted in last.
> >
>
> OK, but since you are not directly dealing with PSCI APIs, it's misleading.
>

I can re-phrase my commit message which links explanation to PSCI.

> > > Next, you fail to explain why do you have to ensure
> > > caches are cleaned and why do you need that in ipi_cpu_stop ?
> > > What's the use case ?
> > >
> > Need comes from a specific use case where one Accelerator card(SoC) is
> > plugged in a sever over a PCIe interface.  This Card gets supply from a
> > battery, which could provide very less power for a very small time, in case
> > of any power loss. Once Card switches to battery, this has to reduce its
> > power consumption to its lowest point and back-up the DDR contents asap
> > before battery gets fully drained off.
> >
>
> OK, but I was expecting the complete call path for this use-case.

OK. Once power loss happens, Application processor gets interrupt and
it has to switch to MCU asap so that it can switch-off all irrelevant
power domain to reduce battery drain.
flow is like this-
Power loss interrupt --> interrupt handler -> send IPI to stop all
secondary CPUs-> switch primary CPU to ATF which ultimately transition
to MCU where all power off action is taken.

>
> > Since battery can provide limited power for a very short time hence need to
> > transition to lowest power. As per the transition process , CPUs power
> > domain has to be off but before that it needs to flush out its content to
> > system memory(L3) so that content could be backed-up by a MCU, a controller
> > consuming very less power. Since we can not afford plugging-out every
> > individual CPUs in sequence hence uses  ipi_cpu_stop for all other CPUs
>
> So, you are randomly using ipi_cpu_stop for something it's not supposed to
> be used. What do you exactly want to achieve in that context where you need
> to save power ?

Need to back-up DDR from MCU which will require L1/L2 content gets
flushed before CPUs getting shutdown.

>Why system off or reset not sufficient ?
System off or reset is not sufficient as we can not afford that much
delay in transition.

Flushing L1/L2 contents to System memory and Bringing out CPUs
Clusters out of coherency domain before shutting down Clusters puts
rest of system in sane state.  If cluster are not being taken out
properly from coherency domain before shutting down, it could lead
system un-reliable for rest parts.

> --
> Regards,
> Sudeep
>
