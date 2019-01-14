Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F42AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A3620651
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfANSdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:33:23 -0500
Received: from mga09.intel.com ([134.134.136.24]:15619 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbfANSdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 13:33:21 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 10:33:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,478,1539673200"; 
   d="scan'208,223";a="116686451"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.154])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jan 2019 10:33:19 -0800
Date:   Mon, 14 Jan 2019 10:33:19 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Harald Arnesen <harald@skogtun.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [BISECTED] KVM error with 5.0-rc
Message-ID: <20190114183319.GB5141@linux.intel.com>
References: <c8d44a6a-bdb6-6b8c-4a50-1d152a3964f8@skogtun.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <c8d44a6a-bdb6-6b8c-4a50-1d152a3964f8@skogtun.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 14, 2019 at 06:04:27PM +0100, Harald Arnesen wrote:
> Qemu with KVM acceleration fails with kernel 5.0-rc1 and 5.0-rc2.
> It works fine with 4.20.

...

> Bisecting gives:
> 
> c73da3fcab43357feb68cac227194b13e998a8db is the first bad commit
> commit c73da3fcab43357feb68cac227194b13e998a8db
> Author: Sean Christopherson <sean.j.christopherson@intel.com>
> Date:   Mon Dec 3 13:53:00 2018 -0800
> 
>     KVM: VMX: Properly handle dynamic VM Entry/Exit controls
> 
>     EFER and PERF_GLOBAL_CTRL MSRs have dedicated VM Entry/Exit controls
>     that KVM dynamically toggles based on whether or not the guest's value
>     for each MSRs differs from the host.  Handle the dynamic behavior by
>     adding a helper that clears the dynamic bits so the bits aren't set
>     when initializing the VMCS field outside of the dynamic toggling flow.
>     This makes the handling consistent with similar behavior for other
>     controls, e.g. pin, exec and sec_exec.  More importantly, it eliminates
>     two global bools that are stealthily modified by setup_vmcs_config.
> 
>     Opportunistically clean up a comment and print related to errata for
>     IA32_PERF_GLOBAL_CTRL.
> 
>     Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Can you test the attached patch?  Found a bug when re-inspecting the
guilty commit, the wrong VMCS field is being modifying when applying an
errata to disable VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL.  Your CPU is
listed as one of the models affected by the errata.  Compile tested only.

--3MwIy2ne0vdjdPXF
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-KVM-VMX-Use-the-correct-var-field-when-clearing-VM_E.patch"

From 6dde876a992ca2e3627b1fe7aca3975487bc1da6 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <sean.j.christopherson@intel.com>
Date: Mon, 14 Jan 2019 10:23:46 -0800
Subject: [PATCH] KVM: VMX: Use the correct var field when clearing
 VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL

Fix a recently introduced bug that results in the wrong VMCS control
field being updated when applying a IA32_PERF_GLOBAL_CTRL errata.

Fixes: c73da3fcab43 ("KVM: VMX: Properly handle dynamic VM Entry/Exit controls")
Reported-by: Harald Arnesen <harald@skogtun.org>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f6915f10e584..0762fcab8fc9 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2344,7 +2344,7 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 		case 37: /* AAT100 */
 		case 44: /* BC86,AAY89,BD102 */
 		case 46: /* BA97 */
-			_vmexit_control &= ~VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
+			_vmentry_control &= ~VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
 			_vmexit_control &= ~VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
 			pr_warn_once("kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL "
 					"does not work properly. Using workaround\n");
-- 
2.19.2


--3MwIy2ne0vdjdPXF--
