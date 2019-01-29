Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D713C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E419320856
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfA2ThO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:37:14 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:33081 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726828AbfA2ThO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:37:14 -0500
Received: from [192.168.0.13] (ip5f5bf33f.dynamic.kabel-deutschland.de [95.91.243.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3B833201352016;
        Tue, 29 Jan 2019 20:37:12 +0100 (CET)
Subject: Re: [PATCH 0/2] Fix TSC issues on (some) AMD Ryzen based systems
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     =?UTF-8?Q?Jan_H=2e_Sch=c3=b6nherr?= <jan@schnhrr.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Thomas Lendacky <Thomas.Lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        it+linux-x86@molgen.mpg.de
References: <20190129102329.27610-1-jan@schnhrr.de>
 <74929a77-6a21-d13e-9a65-5a0753009ddf@molgen.mpg.de>
Message-ID: <986788f4-2a89-78a9-edee-3754dadba512@molgen.mpg.de>
Date:   Tue, 29 Jan 2019 20:37:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <74929a77-6a21-d13e-9a65-5a0753009ddf@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jan,


Am 29.01.19 um 20:33 schrieb Paul Menzel:

> Thank you for adding me to the CC list.
> 
> 
> Am 29.01.19 um 11:23 schrieb Jan H. Schönherr:
>> My newly acquired AMD Ryzen Threadripper based system seems to have
>> some TSC quirks, which go away once the system is up.
>>
>> Given the discussion in https://lkml.org/lkml/2019/1/28/1356
>> I don't seem to be the only one, and it does not seem to be
>> Threadripper specific.
>>
>> The first patch addresses presumably SMI interruptions, that occur
>> on my system at a 60 Hz frequency. They take too long, making the
>> existing code fail. The patch makes that code more resilient.
>> (These interruptions go away at some point during boot; also proven
>> by the fact, that I don't have any TSC issues, when kexecing into
>> a new kernel.)
>>
>> The second patch prevents TSC going unstable when resuming from S3.
>> This may have a similar source, but is certainly more weird: the
>> TSC is observed to go backwards on CPU0 by about 200 to 500 cycles
>> compared to other CPUs every once in a while, as long as its sibling
>> (CPU16 in my case) hasn't been resumed yet. (I did some experiments
>> with CPU hotplug before and after suspend, but apart from reproducing
>> the issue and verifying the "fix", I got nowhere.)
>>
>> The patches are against v4.20.
>>
>> Jan H. Schönherr (2):
>>    x86/tsc: Allow quick PIT calibration despite interruptions
>>    cpu/hotplug: Unfreeze sibling CPU first on resume from S3
>>
>>   arch/x86/kernel/tsc.c | 80 +++++++++++++++++++++++++------------------
>>   kernel/cpu.c          | 34 ++++++++++++------
>>   2 files changed, 70 insertions(+), 44 deletions(-)
> 
> I successfully tested both applied on Linus’ current master branch
> (v5.0-rc4-1-g4aa9fc2a435a).
> 
>> [    0.000000] DMI: HP HP EliteDesk 705 G4 MT/83E7, BIOS Q06 Ver. 02.04.01 09/14/2018
>> [    0.000000] tsc: Fast TSC calibration using PIT
>> [    0.000000] tsc: Detected 3616.864 MHz processor

Please do not forget to tag both patches for the stable releases
by adding the tag.

 > CC: stable@vger.kernel.org


Kind regards,

Paul
