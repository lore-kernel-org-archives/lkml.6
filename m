Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A66CC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E7220832
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E7220832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbeJXSlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 14:41:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:61009 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbeJXSlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 14:41:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 03:13:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,420,1534834800"; 
   d="scan'208";a="268358455"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.212])
  by orsmga005.jf.intel.com with ESMTP; 24 Oct 2018 03:13:47 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Luwei Kang <luwei.kang@intel.com>, kvm@vger.kernel.org,
        x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        pbonzini@redhat.com, rkrcmar@redhat.com, joro@8bytes.org,
        songliubraving@fb.com, peterz@infradead.org,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        thomas.lendacky@amd.com, konrad.wilk@oracle.com,
        mattst88@gmail.com, Janakarajan.Natarajan@amd.com,
        dwmw@amazon.co.uk, jpoimboe@redhat.com, marcorr@google.com,
        ubizjak@gmail.com, sean.j.christopherson@intel.com,
        jmattson@google.com, linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Luwei Kang <luwei.kang@intel.com>
Subject: Re: [PATCH v13 08/12] KVM: x86: Add Intel PT context switch for each vcpu
In-Reply-To: <1540368316-12998-9-git-send-email-luwei.kang@intel.com>
References: <1540368316-12998-1-git-send-email-luwei.kang@intel.com> <1540368316-12998-9-git-send-email-luwei.kang@intel.com>
Date:   Wed, 24 Oct 2018 13:13:44 +0300
Message-ID: <87a7n37iuf.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luwei Kang <luwei.kang@intel.com> writes:

> +static void pt_guest_enter(struct vcpu_vmx *vmx)
> +{
> +	if (pt_mode == PT_MODE_SYSTEM)
> +		return;
> +
> +	/* Save host state before VM entry */
> +	rdmsrl(MSR_IA32_RTIT_CTL, vmx->pt_desc.host.ctl);
> +
> +	/*
> +	 * Set guest state of MSR_IA32_RTIT_CTL MSR (PT will be disabled
> +	 * on VM entry when it has been disabled in guest before).
> +	 */
> +	vmcs_write64(GUEST_IA32_RTIT_CTL, vmx->pt_desc.guest.ctl);
> +
> +	if (vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) {
> +		wrmsrl(MSR_IA32_RTIT_CTL, 0);
> +		pt_save_msr(&vmx->pt_desc.host, vmx->pt_desc.addr_range);
> +		pt_load_msr(&vmx->pt_desc.guest, vmx->pt_desc.addr_range);
> +	}
> +}

From my side this is still a NAK, because [1].

[1] https://marc.info/?l=kvm&m=153847567226248&w=2

Thanks,
--
Alex
