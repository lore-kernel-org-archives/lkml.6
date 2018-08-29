Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D45C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC2F20659
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC2F20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbeH2TAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:00:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:16515 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728062AbeH2TAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:00:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 08:03:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,303,1531810800"; 
   d="scan'208";a="76504705"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.9])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Aug 2018 08:03:14 -0700
Date:   Wed, 29 Aug 2018 08:03:14 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        stable@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v2 2/3] x86/mm: add .data..decrypted section to hold
 shared variables
Message-ID: <20180829150314.GA32493@linux.intel.com>
References: <1535494377-25600-1-git-send-email-brijesh.singh@amd.com>
 <1535494377-25600-3-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535494377-25600-3-git-send-email-brijesh.singh@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 05:12:56PM -0500, Brijesh Singh wrote:
> kvmclock defines few static variables which are shared with hypervisor
> during the kvmclock initialization.
> 
> When SEV is active, memory is encrypted with a guest-specific key, and
> if guest OS wants to share the memory region with hypervisor then it must
> clear the C-bit before sharing it. Currently, we use
> kernel_physical_mapping_init() to split large pages before clearing the
> C-bit on shared pages. But the kernel_physical_mapping_init fails when
> called from the kvmclock initialization (mainly because memblock allocator
> was not ready).
> 
> The '__decrypted' can be used to define a shared variable; the variables
> will be put in the .data.decryption section. This section is mapped with
> C=0 early in the boot, we also ensure that the initialized values are
> updated to match with C=0 (i.e perform an in-place decryption). The
> .data..decrypted section is PMD aligned and sized so that we avoid the
> need to split the large pages when mapping this section.

What about naming the attribute (and section) '__unencrypted' instead
of '__decrypted'?  The attribute should be a property describing how
the data must be accessed, it shouldn't imply anything regarding the
history of the data.  Decrypted implies that data was once encrypted,
whereas unencrypted simply states that the data is stored in plain
text.  All data that has been decrypted is also unencrypted, but the
reverse does not hold true.
