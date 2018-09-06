Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21F2C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8152075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F8152075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbeIGAYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 20:24:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:47147 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728461AbeIGAYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 20:24:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 12:47:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,339,1531810800"; 
   d="scan'208";a="255116529"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.20])
  by orsmga005.jf.intel.com with ESMTP; 06 Sep 2018 12:47:10 -0700
Date:   Thu, 6 Sep 2018 12:47:10 -0700
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
Message-ID: <20180906194710.GA16605@linux.intel.com>
References: <1536234182-2809-1-git-send-email-brijesh.singh@amd.com>
 <1536234182-2809-6-git-send-email-brijesh.singh@amd.com>
 <20180906122423.GA11144@zn.tnic>
 <20180906135041.GB32336@linux.intel.com>
 <20180906141825.GB370@linux.intel.com>
 <fcd5efe9-3e26-3aff-9173-9f8c3f3183f1@amd.com>
 <20180906184750.GB4570@linux.intel.com>
 <c219ec47-1a1f-5d19-0b5b-0cebb706ca6c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c219ec47-1a1f-5d19-0b5b-0cebb706ca6c@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 02:24:32PM -0500, Brijesh Singh wrote:
> 
> 
> On 09/06/2018 01:47 PM, Sean Christopherson wrote:
> >On Thu, Sep 06, 2018 at 01:37:50PM -0500, Brijesh Singh wrote:
> >>
> >>
> >>On 09/06/2018 09:18 AM, Sean Christopherson wrote:
> >>....
> >>
> >>>>>
> >>>>>So are we going to be defining a decrypted section for every piece of
> >>>>>machinery now?
> >>>>>
> >>>>>That's a bit too much in my book.
> >>>>>
> >>>>>Why can't you simply free everything in .data..decrypted on !SVE guests?
> >>>>
> >>>>That would prevent adding __decrypted to existing declarations, e.g.
> >>>>hv_clock_boot, which would be ugly in its own right.  A more generic
> >>>>solution would be to add something like __decrypted_exclusive to mark
> >>>>data that is used if and only if SEV is active, and then free the
> >>>>SEV-only data when SEV is disabled.
> >>>
> >>>Oh, and we'd need to make sure __decrypted_exclusive is freed when
> >>>!CONFIG_AMD_MEM_ENCRYPT, and preferably !sev_active() since the big
> >>>array is used only if SEV is active.  This patch unconditionally
> >>>defines hv_clock_dec but only frees it if CONFIG_AMD_MEM_ENCRYPT=y &&
> >>>!mem_encrypt_active().
> >>>
> >>
> >>Again we have to consider the bare metal scenario while doing this. The
> >>aux array you proposed will be added in decrypted section only when
> >>CONFIG_AMD_MEM_ENCRYPT=y.  If CONFIG_AMD_MEM_ENCRYPT=n then nothng
> >>gets put in .data.decrypted section. At the runtime, if memory
> >>encryption is active then .data.decrypted_hvclock will contains useful
> >>data.
> >>
> >>The __decrypted attribute in "" when CONFIG_AMD_MEM_ENCRYPT=n.
> >
> >Right, but won't the data get dumped into the regular .bss in that
> >case, i.e. needs to be freed?
> >
> 
> 
> Yes, the auxiliary array will dumped into the regular .bss when
> CONFIG_AMD_MEM_ENCRYPT=n. Typically it will be few k, I am not
> sure if its worth complicating the code to save those extra memory.
> Most of the distro's have CONFIG_AMD_MEM_ENCRYPT=y anyways.

I just realized that we'll try to create a bogus array if 'NR_CPUS <=
HVC_BOOT_ARRAY_SIZE'.  A bit ugly, but we could #ifdef away both that
and CONFIG_AMD_MEM_ENCRYPT=n in a single shot, e.g.:

#if defined(CONFIG_AMD_MEM_ENCRYPT) && NR_CPUS > HVC_BOOT_ARRAY_SIZE
#define HVC_AUX_ARRAY_SIZE  \
	PAGE_ALIGN((NR_CPUS - HVC_BOOT_ARRAY_SIZE) * \
		   sizeof(struct pvclock_vsyscall_time_info))
static struct pvclock_vsyscall_time_info
	hv_clock_aux[HVC_AUX_ARRAY_SIZE] __decrypted __aligned(PAGE_SIZE);
#endif

