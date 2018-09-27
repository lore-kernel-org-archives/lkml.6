Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2242BC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76CD215E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76CD215E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbeI1BBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:01:47 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:59943 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbeI1BBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:01:46 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g5bEm-00005T-Sw; Thu, 27 Sep 2018 12:42:08 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g5bEl-0003a3-ER; Thu, 27 Sep 2018 12:42:08 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, linux-sgx@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES),
        linux-kernel@vger.kernel.org (open list)
References: <20180925130845.9962-1-jarkko.sakkinen@linux.intel.com>
        <20180925130845.9962-9-jarkko.sakkinen@linux.intel.com>
Date:   Thu, 27 Sep 2018 20:41:48 +0200
In-Reply-To: <20180925130845.9962-9-jarkko.sakkinen@linux.intel.com> (Jarkko
        Sakkinen's message of "Tue, 25 Sep 2018 16:06:45 +0300")
Message-ID: <87in2qpytv.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g5bEl-0003a3-ER;;;mid=<87in2qpytv.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19kV+2kuKa9xKfhj4/4O5sif/vv7FEdn3c=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v14 08/19] signal: x86/sgx: Add SIGSEGV siginfo code for SGX EPCM fault
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> writes:

> From: Sean Christopherson <sean.j.christopherson@intel.com>
>
> The SGX Enclave Page Cache Map (EPCM) is a hardware-managed table
> that enforces accesses to an enclave's EPC page in addition to the
> software-managed kernel page tables, i.e. the effective permissions
> for an EPC page are a logical AND of the kernel's page tables and
> the corresponding EPCM entry.  The primary purpose of the EPCM is
> to prevent a malcious or compromised kernel from attacking an enclave
> by modifying the enclave's page tables.  The EPCM entires for an
> enclave are populated when the enclave is built and verified, using
> metadata provided by the enclave that is included in the measurement
> used to verify the enclave.
>
> In normal operation of a properly functioning, non-malicious kernel
> (and enclave), the EPCM permissions will never trigger a fault, i.e.
> the kernel may make the permissions for an EPC page more restrictive,
> e.g. mark it not-present to swap out the EPC page, but the kernel will
> never make its permissions less restrictive.
>
> But, there is a legitimate scenario in which the kernel's page tables
> can become less restrictive than the EPCM: on current hardware all
> enclaves are destroyed (by hardware) on a transition to S3 or lower
> sleep states, i.e. all EPCM entries are invalid (not-present) after
> the system resumes from its sleep state.
>
> Unfortunately, on CPUs that support only SGX1, EPCM violations result
> in a #GP.  The upside of the #GP is that no kernel changes are needed
> to deal with the EPCM being blasted away by hardware, e.g. userspace
> gets a SIGSEGV, assumes the EPCM was lost and restarts its enclave
> and everyone is happy.  The downside is that userspace has to assume
> the SIGSEGV was because the EPC was lost (or possibly do some leg work
> to rule out other causes).
>
> In SGX2, the oddity of delivering a #GP due to what are inherently
> paging related violations is remedied.  CPUs that support SGX2 deliver
> EPCM violations as #PFs with a new SGX error code bit set.  So, now
> that hardware provides us with a way to unequivocally determine that
> a fault was due to a EPCM violation, define a signfo code for SIGSEGV
> so that the information can be passed onto userspace.
>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  include/uapi/asm-generic/siginfo.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> index 80e2a7227205..fdd898e2325b 100644
> --- a/include/uapi/asm-generic/siginfo.h
> +++ b/include/uapi/asm-generic/siginfo.h
> @@ -225,7 +225,11 @@ typedef struct siginfo {
>  #else
>  # define SEGV_PKUERR	4	/* failed protection key checks */
>  #endif
> +#ifdef __x86_64__
> +#define SEGV_SGXERR	5	/* SGX Enclave Page Cache Map fault */
> +#else
>  #define SEGV_ACCADI	5	/* ADI not enabled for mapped object */
> +#endif

Don't do this crazy ifdef thing.  si_codes are not supposed to be per
architecture.  There are a few historical bugs but with a 32bit space
it is just stupid to add #ifdefs.

Just set.
#define SEGV_SGXERR 8 and increase NSIGSEGV

Anything else is just asking for trouble.  Especially when you want to
get SGX working on itaninum.

>  #define SEGV_ADIDERR	6	/* Disrupting MCD error */
>  #define SEGV_ADIPERR	7	/* Precise MCD exception */
>  #define NSIGSEGV	7

Eric
