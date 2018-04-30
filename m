Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754987AbeD3Qgs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 12:36:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:3485 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754961AbeD3Qgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 12:36:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,346,1520924400";
   d="scan'208";a="47199464"
Subject: Re: [PATCH 4/9] x86, pkeys: override pkey when moving away from
 PROT_EXEC
To: Ram Pai <linuxram@us.ibm.com>
References: <20180326172721.D5B2CBB4@viggo.jf.intel.com>
 <20180326172727.025EBF16@viggo.jf.intel.com>
 <20180407000943.GA15890@ram.oc3035372033.ibm.com>
 <6e3f8e1c-afed-64de-9815-8478e18532aa@intel.com>
 <20180407010919.GB15890@ram.oc3035372033.ibm.com>
 <aedcb0b6-73f5-f72f-742e-b417131895d3@intel.com>
 <20180430075106.GA5666@ram.oc3035372033.ibm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, shakeelb@google.com,
        stable@kernel.org, tglx@linutronix.de, mpe@ellerman.id.au,
        mingo@kernel.org, akpm@linux-foundation.org, shuah@kernel.org
From: Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Message-ID: <54b94b65-807d-ebc5-ccfd-30eef1873faf@intel.com>
Date: Mon, 30 Apr 2018 09:36:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430075106.GA5666@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/30/2018 12:51 AM, Ram Pai wrote:
> 	/*
> 	 * Look for a protection-key-drive execute-only mapping
> 	 * which is now being given permissions that are not
> 	 * execute-only.  Move it back to the default pkey.
> 	 */
> 	if (vma_is_pkey_exec_only(vma) && (prot != PROT_EXEC)) <--------
> 		return ARCH_DEFAULT_PKEY;
> 
> 	/*
> 	 * The mapping is execute-only.  Go try to get the
> 	 * execute-only protection key.  If we fail to do that,
> 	 * fall through as if we do not have execute-only
> 	 * support.
> 	 */
> 	if (prot == PROT_EXEC) {
> 		pkey = execute_only_pkey(vma->vm_mm);
> 		if (pkey > 0)
> 			return pkey;
> 	}

Yes, that would also work.  It's just a matter of whether you prefer
having the prot==PROT_EXEC checks in one place or two.  I'd rather leave
it the way I've got it unless there are major objections since it's been
tested.
