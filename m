Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeC0Gwu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 02:52:50 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:40235 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752635AbeC0Gws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 02:52:48 -0400
X-Google-Smtp-Source: AG47ELvId/laZPqOugZJ+5+oMG3vKX6zLrc27DDzr2Jud1DhvAch1TzPO7tyGOiHuDdav1jchn1DShu1TtT0GQnRHhQ=
MIME-Version: 1.0
X-Originating-IP: [217.140.96.140]
In-Reply-To: <20180327010633.GB23487@redhat.com>
References: <1522003290-27243-1-git-send-email-yael.chemla@foss.arm.com>
 <1522003290-27243-2-git-send-email-yael.chemla@foss.arm.com> <20180327010633.GB23487@redhat.com>
From: Gilad Ben-Yossef <gilad@benyossef.com>
Date: Tue, 27 Mar 2018 09:52:46 +0300
Message-ID: <CAOtvUMfArPgAmbmBW672nq2QuS8mJgkepwF9O+7R-G7KeLtRsA@mail.gmail.com>
Subject: Re: [PATCH 2/2] md: dm-verity: allow parallel processing of bio blocks
To: Mike Snitzer <snitzer@redhat.com>
Cc: Yael Chemla <yael.chemla@foss.arm.com>,
        Alasdair Kergon <agk@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        ofir.drang@gmail.com, Yael Chemla <yael.chemla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 4:06 AM, Mike Snitzer <snitzer@redhat.com> wrote:
> On Sun, Mar 25 2018 at  2:41pm -0400,
> Yael Chemla <yael.chemla@foss.arm.com> wrote:
>
>>  Allow parallel processing of bio blocks by moving to async. completion
>>  handling. This allows for better resource utilization of both HW and
>>  software based hash tfm and therefore better performance in many cases,
>>  depending on the specific tfm in use.
>>
>>  Tested on ARM32 (zynq board) and ARM64 (Juno board).
>>  Time of cat command was measured on a filesystem with various file sizes.
>>  12% performance improvement when HW based hash was used (ccree driver).
>>  SW based hash showed less than 1% improvement.
>>  CPU utilization when HW based hash was used presented 10% less context
>>  switch, 4% less cycles and 7% less instructions. No difference in
>>  CPU utilization noticed with SW based hash.
>>
>> Signed-off-by: Yael Chemla <yael.chemla@foss.arm.com>
>
> This one had various issues.  I've fixed most of what I saw and staged
> in linux-next (purely for build test coverage purposes).  I may drop
> this patch if others disagree with it (or my sg deallocation in the
> error path question isn't answered).
>
> I've staged the changes here (and in linux-next via 'for-next'):
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-4.17
>
> I switched all the new GFP_KERNEL uses to GFP_NOIO.  The fact that
> you're doing allocations at all (per IO) is bad enough.  Using
> GFP_KERNEL is a serious liability (risk of deadlock if dm-verity were to
> be used for something like.. swap.. weird setup but possible).

Out of my curiosity, since I thought whether or not this should use
GFP_NOIO during my review
but than answered to myself "Nah, dm-verity is read only, can't swap
to that" - how does one
use a read only DM-Verity to host swap partition/file? :-)


>
> But the gfp flags aside, the need for additional memory and the
> expectation of scalable async parallel IO is potentially at odds with
> changes like this (that I just staged, and had to rebase your 2 patches
> ontop of):
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-4.17&id=a89f6a2cfec86fba7a115642ff082cb4e9450ea6
>
> So I'm particulalry interested to hear from google folks to understand
> if they are OK with your proposed verity async crypto API use.

If by "scalable async parallel IO" you mean crypto HW than for what
it's worth, my experience is that makers of devices with is less
powerful CPUs
are the ones that tend to add them, so they stands to benefit  the
most of this change.

Gilad

-- 
Gilad Ben-Yossef
Chief Coffee Drinker

"If you take a class in large-scale robotics, can you end up in a
situation where the homework eats your dog?"
 -- Jean-Baptiste Queru
