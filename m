Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752662AbeEGSAP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 14:00:15 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:61664 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752051AbeEGSAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 14:00:13 -0400
X-IronPort-AV: E=Sophos;i="5.49,375,1520899200";
   d="scan'208";a="343004303"
From: "van der Linden, Frank" <fllinden@amazon.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "jgross@suse.com" <jgross@suse.com>
Subject: Re: [PATCH 1/1] x86/xen: Reset VCPU0 info pointer after shared_info
 remap
Thread-Topic: [PATCH 1/1] x86/xen: Reset VCPU0 info pointer after shared_info
 remap
Thread-Index: AQHT4+Qi8Y/Xj7e/qEORkG6cypvfEqQkZMKA//+4loA=
Date: Mon, 7 May 2018 18:00:09 +0000
Message-ID: <B3C02FE4-651D-4A89-90BB-78E389764688@amazon.com>
References: <C508E5F5-024E-4F71-A91E-7BB0BE046F5D@amazon.com>
 <965354d1-e2e7-1764-a14e-bb4258b9ed13@oracle.com>
In-Reply-To: <965354d1-e2e7-1764-a14e-bb4258b9ed13@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.180]
Content-Type: text/plain; charset="utf-8"
Content-ID: <25A854A9F4885141B76DD53234C4FCB1@amazon.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w47I0KjK009814

Hi Boris,

Thanks for the feedback.

﻿On 5/7/18, 8:13 AM, "Boris Ostrovsky" <boris.ostrovsky@oracle.com> wrote:

    > diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
    > index 6b424da1ce75..c78b3e8fb2e5 100644
    > --- a/arch/x86/xen/enlighten_hvm.c
    > +++ b/arch/x86/xen/enlighten_hvm.c
    > @@ -71,6 +71,19 @@ static void __init xen_hvm_init_mem_mapping(void)
    >  {
    >  	early_memunmap(HYPERVISOR_shared_info, PAGE_SIZE);
    >  	HYPERVISOR_shared_info = __va(PFN_PHYS(shared_info_pfn));
    > +
    > +	/*
    > +	 * The virtual address of the shared_info page has changed, so
    > +	 * the vcpu_info pointer for VCPU 0 is now stale.
    
    Is it "has changed" or "has changed if kaslr is on"?

It's "has changed".  See commit 4ca83dcf4e3bc0c98836dbb97553792ca7ea5429 .  It's a way to make kaslr work, but it's done regardless of whether it's enabled or not.
 
    > +	 *
    > +	 * The prepare_boot_cpu callback will re-initialize it via
    > +	 * xen_vcpu_setup, but we can't rely on that to be called for
    > +	 * old Xen versions (xen_have_vector_callback == 0).
    > +	 *
    > +	 * It is, in any case, bad to have a stale vcpu_info pointer
    > +	 * so reset it now.
    > +	 */
    > +	xen_vcpu_info_reset(0);
    
    
    Why not xen_vcpu_setup(0)?
    
Basically, I wanted to be minimally invasive. xen_vcpu_setup does a little more work (tries to do the VCPU placement hypercall), and will be called later in any case. So doing just the basic xen_vcpu_info_reset for VCPU 0 seems like the best way to do it; it just re-iterates what is done for VCPU 0 earlier in boot, which is also a vcpu_info_reset.

Frank
