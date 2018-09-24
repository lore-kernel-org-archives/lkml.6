Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C71FECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398142086B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 398142086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbeIXWLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:11:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:2107 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728976AbeIXWLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:11:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 09:08:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,298,1534834800"; 
   d="scan'208";a="86127432"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.148])
  by orsmga003.jf.intel.com with ESMTP; 24 Sep 2018 09:04:57 -0700
Message-ID: <1537805097.8731.2.camel@intel.com>
Subject: Re: [PATCH] KVM: x86: never trap MSR_KERNEL_GS_BASE
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Date:   Mon, 24 Sep 2018 09:04:57 -0700
In-Reply-To: <1537803519-17941-1-git-send-email-pbonzini@redhat.com>
References: <1537803519-17941-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-24 at 17:38 +0200, Paolo Bonzini wrote:
> KVM has an old optimization whereby accesses to the kernel GS base MSR
> are trapped when the guest is in 32-bit and not when it is in 64-bit mode.
> The idea is that swapgs is not available in 32-bit mode and thus the
> guest has no reason to access the MSR unless in 64-bit mode.  Therefore
> 32-bit applications need not pay the price of switching the kernel GS
> base between the host and the guest values, 64-bit applications.
> 
> However, this optimization adds complexity to the code for little
> benefit (these days most guests are going to be 64-bit anyway) and in fact
> broke after commit 678e315e78a7 ("KVM: vmx: add dedicated utility to
> access guest's kernel_gs_base", 2018-08-06); the guest kernel GS base
> can be corrupted across SMIs and UEFI Secure Boot is therefore broken
> (a secure boot Linux guest, for example, fails to reach the login prompt
> about half the time).  This patch just removes the optimization; the
> kernel GS base MSR is now never trapped by KVM, similarly to the FS and
> GS base MSRs.
> 
> Fixes: 678e315e78a780dbef384b92339c8414309dbc11
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
