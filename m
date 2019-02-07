Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B067C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4465321904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfBGPGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:06:43 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38416 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfBGPGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:06:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E39BCEBD;
        Thu,  7 Feb 2019 07:06:42 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 229F33F719;
        Thu,  7 Feb 2019 07:06:40 -0800 (PST)
Date:   Thu, 7 Feb 2019 15:06:38 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jisheng Zhang <jszhang@marvell.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Joshua Frkuska <joshua_frkuska@mentor.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH] drivers: base: add support to skip power management in
 device/driver model
Message-ID: <20190207150638.GB14464@e107155-lin>
References: <20190206150935.12140-1-sudeep.holla@arm.com>
 <CAPDyKFr2qwXoOL3SRy7Crf-pg4FMn_qecPrw__BE+YpVAjAFZA@mail.gmail.com>
 <20190207103600.GA14464@e107155-lin>
 <CAPDyKFpkiaP0J_LJxP6tRUOyz3QKtDgA+PuhL-9vew7-RfKyNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpkiaP0J_LJxP6tRUOyz3QKtDgA+PuhL-9vew7-RfKyNA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 03:29:07PM +0100, Ulf Hansson wrote:
> On Thu, 7 Feb 2019 at 11:36, Sudeep Holla <sudeep.holla@arm.com> wrote:

[..]

> >
> > May be, but as mentioned above we can't really. Also this change will
> > help to avoid creating unnecessary power sysfs which is mainly runtime
> > pm related for some of the devices created. CPU/caches was just one
> > example which triggered this, but this can be more useful. We can avoid
> > adding them to dpm list.
>
> Well, to me the approach you suggest sounds prone to errors and I am
> afraid people may abuse it. Moreover, I don't know if there is other
> problems with it, let's see what Rafael thinks about it.
>

Sorry, I should have put reference to earlier discussion that led to this
patch. For your reference: [1]

> Instead I think we should make the PM core to deal with this scenario,
> as all it boils down to, is to allow a device to be unregistered and
> registered during system suspend/resume, with a parent device that is
> "persistent" during the sequence.
>

OK

> Perhaps we could even just drop the corresponding printed warning,
> "cache: parent cpu1 should not be sleeping", in device_pm_add() as I
> wonder if it's really a necessary print.
>
Indeed, I was ignoring knowing that it's harmless. But more people
started to complain, and Rafael suggested this which I agree as we
have several pseudo devices created in the kernel that we can bypass
some of these pm handling knowing we won't need it.

--
Regards,
Sudeep

[1] https://lkml.org/lkml/2019/1/30/1078
