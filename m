Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5215C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4852075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4852075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbeIGBQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:16:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:2827 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbeIGBQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:16:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 13:39:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,339,1531810800"; 
   d="scan'208";a="260483659"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.20])
  by fmsmga005.fm.intel.com with ESMTP; 06 Sep 2018 13:39:26 -0700
Date:   Thu, 6 Sep 2018 13:39:26 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v5 5/5] x86/kvm: Avoid dynamic allocation of pvclock data
 when SEV is active
Message-ID: <20180906203926.GA5717@linux.intel.com>
References: <1536234182-2809-1-git-send-email-brijesh.singh@amd.com>
 <1536234182-2809-6-git-send-email-brijesh.singh@amd.com>
 <20180906122423.GA11144@zn.tnic>
 <20180906135041.GB32336@linux.intel.com>
 <20180906141825.GB370@linux.intel.com>
 <fcd5efe9-3e26-3aff-9173-9f8c3f3183f1@amd.com>
 <20180906184750.GB4570@linux.intel.com>
 <c219ec47-1a1f-5d19-0b5b-0cebb706ca6c@amd.com>
 <20180906194710.GA16605@linux.intel.com>
 <9126c92f-ad3b-a5b6-ac44-416405489a7e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9126c92f-ad3b-a5b6-ac44-416405489a7e@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 03:20:46PM -0500, Brijesh Singh wrote:
> 
> 
> On 09/06/2018 02:47 PM, Sean Christopherson wrote:
> ...
> 
> >>
> >>Yes, the auxiliary array will dumped into the regular .bss when
> >>CONFIG_AMD_MEM_ENCRYPT=n. Typically it will be few k, I am not
> >>sure if its worth complicating the code to save those extra memory.
> >>Most of the distro's have CONFIG_AMD_MEM_ENCRYPT=y anyways.
> >
> >I just realized that we'll try to create a bogus array if 'NR_CPUS <=
> >HVC_BOOT_ARRAY_SIZE'.  A bit ugly, but we could #ifdef away both that
> >and CONFIG_AMD_MEM_ENCRYPT=n in a single shot, e.g.:
> >
> >#if defined(CONFIG_AMD_MEM_ENCRYPT) && NR_CPUS > HVC_BOOT_ARRAY_SIZE
> >#define HVC_AUX_ARRAY_SIZE  \
> >	PAGE_ALIGN((NR_CPUS - HVC_BOOT_ARRAY_SIZE) * \
> >		   sizeof(struct pvclock_vsyscall_time_info))
> >static struct pvclock_vsyscall_time_info
> >	hv_clock_aux[HVC_AUX_ARRAY_SIZE] __decrypted __aligned(PAGE_SIZE);
> >#endif
> >
> 
> The HVC_BOOT_ARRAY_SIZE macro uses sizeof(..) and to my understanding
> the sizeof operators are not allowed in '#if'. Anyway, I will try to see
> if it can be used, if not then I will stick to CONFIG_AMD_MEM_ENCRYPT
> check.

Hmm, we'll need something otherwise 'NR_CPUS - HVC_BOOT_ARRAY_SIZE'
will wrap and cause build errors.
