Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA9CC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA9120835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405493AbfBMSrj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:47:39 -0500
Received: from mga17.intel.com ([192.55.52.151]:16333 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406599AbfBMSrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:47:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 10:47:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,366,1544515200"; 
   d="scan'208";a="320123164"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga005.fm.intel.com with ESMTP; 13 Feb 2019 10:47:02 -0800
Received: from fmsmsx120.amr.corp.intel.com (10.18.124.208) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 13 Feb 2019 10:47:02 -0800
Received: from crsmsx152.amr.corp.intel.com (172.18.7.35) by
 fmsmsx120.amr.corp.intel.com (10.18.124.208) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 13 Feb 2019 10:47:02 -0800
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.57]) by
 CRSMSX152.amr.corp.intel.com ([169.254.5.81]) with mapi id 14.03.0415.000;
 Wed, 13 Feb 2019 12:46:59 -0600
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v5 08/13] x86/fsgsbase/64: Introduce the
 FIND_PERCPU_BASE macro
Thread-Topic: [PATCH v5 08/13] x86/fsgsbase/64: Introduce the
 FIND_PERCPU_BASE macro
Thread-Index: AQHUunBnyK8xBeMjrkOJBZxNaNROKKXNJgUAgBFirgA=
Date:   Wed, 13 Feb 2019 18:46:59 +0000
Message-ID: <5474F9B1-6E8F-4677-976B-C10103175B05@intel.com>
References: <20190201205319.15995-1-chang.seok.bae@intel.com>
 <20190201205319.15995-10-chang.seok.bae@intel.com>
 <CALCETrU0LD_sZOM2d6dSbnvEbs=zsVxEiy6dPp0w+AJO2JZf3A@mail.gmail.com>
In-Reply-To: <CALCETrU0LD_sZOM2d6dSbnvEbs=zsVxEiy6dPp0w+AJO2JZf3A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.156.136]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <53F8A4509FBB3D48B090E20927100E14@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Feb 2, 2019, at 09:17, Andy Lutomirski <luto@kernel.org> wrote:
> 
> On Fri, Feb 1, 2019 at 12:55 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>> 
>> +
>> +/*
>> + * CPU/node NR is loaded from the limit (size) field of a special segment
>> + * descriptor entry in GDT.
>> + */
>> +.macro LOAD_CPU_AND_NODE_SEG_LIMIT reg:req
>> +       movq    $__CPUNODE_SEG, \reg
>> +       lsl     \reg, \reg
>> +.endm
>> +
> 
> Please put the alternative in here instead of in FIND_PERCPU_BASE.

I would like to apply your comment though, build errors will come up due to the
__CPUNODE_SEG. So, still hoping the alternative line below is straightforward enough.
Will send out a revision, that reflects all other comments, shortly.

Chang

> 
>> +/*
>> + * Fetch the per-CPU GSBASE value for this processor and put it in @reg.
>> + * We normally use %gs for accessing per-CPU data, but we are setting up
>> + * %gs here and obviously can not use %gs itself to access per-CPU data.
>> + */
>> +.macro FIND_PERCPU_BASE reg:req
>> 
>> +       ALTERNATIVE \
>> +               "LOAD_CPU_AND_NODE_SEG_LIMIT \reg", \
>> +               "RDPID  \reg", \
>> +               X86_FEATURE_RDPID
>> +       andq    $VDSO_CPUNODE_MASK, \reg
>> +       movq    __per_cpu_offset(, \reg, 8), \reg
>> +.endm
