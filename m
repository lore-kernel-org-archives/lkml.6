Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C91DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D742120842
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394737AbfBNVJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:09:03 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:38020 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393552AbfBNVJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 16:09:01 -0500
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EL1Ecq019562;
        Thu, 14 Feb 2019 21:08:41 GMT
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0a-002e3701.pphosted.com with ESMTP id 2qnevd8g78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Feb 2019 21:08:41 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 89B1CBE;
        Thu, 14 Feb 2019 21:08:40 +0000 (UTC)
Received: from hpe.com (ben.americas.hpqcorp.net [10.33.153.7])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 980C75B;
        Thu, 14 Feb 2019 21:08:39 +0000 (UTC)
Date:   Thu, 14 Feb 2019 15:08:39 -0600
From:   Russ Anderson <rja@hpe.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Hedi Berriche <hedi.berriche@hpe.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [Patch v3 0/4] Protect against concurrent calls into UV BIOS
Message-ID: <20190214210839.fpghjsexpfid4bc4@hpe.com>
Reply-To: Russ Anderson <rja@hpe.com>
References: <20190213193413.25560-1-hedi.berriche@hpe.com>
 <CAKv+Gu9MkLBv_unbhjikwOTit4xC0-WmS_HMLr1RQ+FZAoW_9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9MkLBv_unbhjikwOTit4xC0-WmS_HMLr1RQ+FZAoW_9g@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902140139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 09:17:37AM +0100, Ard Biesheuvel wrote:
> On Wed, 13 Feb 2019 at 20:34, Hedi Berriche <hedi.berriche@hpe.com> wrote:
> >
> > - Changes since v2
> >   Addressed comments from Ard Biesheuvel:
> >  * expose efi_runtime_lock to UV platform only instead of globally
> >  * remove unnecessary #ifdef CONFIG_EFI from bios_uv.c
> >
> > - Changes since v1:
> >   Addressed comments from Bhupesh Sharma, Thomas Gleixner, and Ard Biesheuvel:
> >  * made __uv_bios_call() static
> >  * moved the efi_enabled() cleanup to its own patchlet
> >  * explained the reason for renaming the efi_runtime_lock semaphore
> >  * dropped the reviewed-bys as they should be given on the mailing list
> >  * Cc'ng stable@vger.kernel.org given the nature of the problem addressed by the patches
> >
> 
> Hi Hedi,
> 
> The patches look good to me now.
> 
> For the series,
> 
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> However, I don't think all the patches should go to -stable. Only 4/4
> fixes an actual bug, and the remaining patches don't look like they
> are prerequisites for that change.
> 
> Also, if your colleagues reviewed your patches, now would be the time
> to ask them to give their Reviewed-by as well.

Reviewed-by: Russ Anderson <rja@hpe.com>

Thanks.

> -- 
> Ard.
> 
> 
> 
> > ---
> >
> > Calls into UV BIOS were not being serialised which is wrong as it violates EFI
> > runtime rules, and bad as it does result in all sorts of potentially hard to
> > track down hangs and panics when efi_scratch.prev_mm gets clobbered whenever
> > efi_switch_mm() gets called concurrently from two different CPUs.
> >
> > Patch #1 removes an unnecessary #ifdef CONFIG_EFI guard from bios_uv.c.
> >
> > Patch #2 removes uv_bios_call_reentrant() because it's dead code.
> >
> > Patch #3 is a cleanup that drops test_bit() in favour of the ad hoc efi_enabled().
> >
> > Patch #4 makes uv_bios_call() variants use the efi_runtime_lock semaphore to
> > protect against concurrency.
> >
> > Cc: Russ Anderson <rja@hpe.com>
> > Cc: Mike Travis <mike.travis@hpe.com>
> > Cc: Dimitri Sivanich <sivanich@hpe.com>
> > Cc: Steve Wahl <steve.wahl@hpe.com>
> > Cc: stable@vger.kernel.org # v4.9+
> >
> > Hedi Berriche (4):
> >   x86/platform/UV: remove unnecessary #ifdef CONFIG_EFI
> >   x86/platform/UV: kill uv_bios_call_reentrant() as it has no callers
> >   x86/platform/UV: use efi_enabled() instead of test_bit()
> >   x86/platform/UV: use efi_runtime_lock to serialise BIOS calls
> >
> >  arch/x86/include/asm/uv/bios.h          | 13 ++++-----
> >  arch/x86/platform/uv/bios_uv.c          | 35 ++++++++++++++-----------
> >  drivers/firmware/efi/runtime-wrappers.c |  7 +++++
> >  3 files changed, 34 insertions(+), 21 deletions(-)
> >
> > --
> > 2.20.1
> >

-- 
Russ Anderson,  SuperDome Flex Linux Kernel Group Manager
HPE - Hewlett Packard Enterprise (formerly SGI)  rja@hpe.com
