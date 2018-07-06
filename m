Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF02C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0E12249E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0E12249E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933633AbeGFRWS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:22:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58665 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932776AbeGFRWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:22:15 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7B1D692182E7F;
        Sat,  7 Jul 2018 01:22:08 +0800 (CST)
Received: from localhost (10.202.226.43) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.382.0; Sat, 7 Jul 2018
 01:22:07 +0800
Date:   Fri, 6 Jul 2018 18:21:54 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
CC:     David Lechner <david@lechnology.com>, <gregkh@linuxfoundation.org>,
        <jic23@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <fabrice.gasnier@st.com>,
        <benjamin.gaignard@st.com>, <robh+dt@kernel.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <mark.rutland@arm.com>
Subject: Re: [PATCH v7 00/10] Introduce the Counter subsystem
Message-ID: <20180706182154.0000002d@huawei.com>
In-Reply-To: <20180703024835.GA9493@sophia>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
        <603b0373-f1e1-5938-fa53-8328c9a5964f@lechnology.com>
        <20180703024835.GA9493@sophia>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2018 22:48:35 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Mon, Jul 02, 2018 at 01:13:40PM -0500, David Lechner wrote:
> >On 06/21/2018 04:06 PM, William Breathitt Gray wrote:  
> >> I decided to strip down these devices to arrive at the core essence of
> >> what constitutes a "counter device" and therefore design a "generic
> >> counter" abstraction to better represent these devices and prevent the
> >> ambiguity we discovered with the existing IIO Counter interface. This
> >> abstraction became the Generic Counter paradigm, which is explained in
> >> detail within the Documentation/driver-api/generic-counter.rst file
> >> introduced by this patchset.  
> >
> >I'm curious if you have given any thought to the time aspect of counters.
> >I am interested in the rate at which the counters are counting (e.g. how
> >many counts per second). I realize that you can calculate this in
> >userspace or in the kernel using the system timer, but it is not very
> >accurate since Linux is not a realtime OS. So, I would like to get the
> >rate directly from the hardware. For example, the TI eQEP[1], like the
> >one found in BeagleBones, has a couple ways of measuring time (see link
> >for details).
> >
> >[1]: http://www.ti.com/lit/ug/sprug05a/sprug05a.pdf  

Cool in eQEP if that is what you are targetting - been wanting to see
nice kernel support implemented for that for a long time, but never
got the spare cycles to do it myself!

> 
> Ah yes, I see you initially attempted adding a frequency channel type to
> the IIO code. I agree with you that this calculation is best kept away
> from the operating system, not just because of the realtime requirement
> considerations, but also because the hardware likely knows best its own
> data, so let's expose it!
> 
> Regarding the Generic Counter interface, a frequency attribute can be
> added quite easily in a technical sense, so this discussion should be
> focused more on the warrant for exposing this data. I understand from
> the discussion thread on your initial patch submission that you're
> working with hot-swappable encoder wheels and would like to expose a
> counting rate since you have trouble otherwise knowing the number of
> counts equal to one revolution due to the various possible encoder
> wheels that could be installed -- do I understand this correctly?
> 
> Luckily the Generic Counter interface is a more abstract paradigm, so
> the hot-swappable encoder wheels should not be a problem for us as long
> as we nail down a consistent and thorough definition for this attribute.
> To that end, since the Generic Counter paradigm is designed to abstract
> away specifics of counter devices in order to present the final data of
> interest to users (e.g. the count value, the mode of operation, etc.),
> let's make sure frequency is actually what we want to expose and not
> just a middle-step datum on the path to the final result.
> 
> What is the real life use-case for this information (are you tracking
> position)? Does the relevant hardware report the number of counts equal
> to one revolution, or are you calculating this from frequency? Are you
> using this frequency to simply track the number of revolutions? Should
> revolution count also be exposed? Is frequency useful for other
> applications on its own (perhaps velocity of an automobile device
> equipped with an encoder wheel for some reason or other)?
> 
> Once we figure out how this data is used, we can determine the best
> design and place to introduce it into the Generic Counter interface,
> then move on to integration from there.

Great - as long as this fits reasonably well in ABI wise (whatever the
details) sounds like we don't need to solve it today.  I'm anxious not
to delay merging this counter subsystem for another cycle.

Jonathan

> 
> William Breathitt Gray
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


