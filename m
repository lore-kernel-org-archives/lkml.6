Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757015AbeDZR5d (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 13:57:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:35663 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756942AbeDZR5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 13:57:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,331,1520924400";
   d="scan'208";a="51082966"
Subject: Re: [PATCH 4/9] x86, pkeys: override pkey when moving away from
 PROT_EXEC
To: Ram Pai <linuxram@us.ibm.com>
References: <20180326172721.D5B2CBB4@viggo.jf.intel.com>
 <20180326172727.025EBF16@viggo.jf.intel.com>
 <20180407000943.GA15890@ram.oc3035372033.ibm.com>
 <6e3f8e1c-afed-64de-9815-8478e18532aa@intel.com>
 <20180407010919.GB15890@ram.oc3035372033.ibm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, shakeelb@google.com,
        stable@kernel.org, tglx@linutronix.de, mpe@ellerman.id.au,
        mingo@kernel.org, akpm@linux-foundation.org, shuah@kernel.org
From: Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Message-ID: <aedcb0b6-73f5-f72f-742e-b417131895d3@intel.com>
Date: Thu, 26 Apr 2018 10:57:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180407010919.GB15890@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/2018 06:09 PM, Ram Pai wrote:
> Well :). my point is add this code and delete the other
> code that you add later in that function.

I don't think I'm understanding what your suggestion was.  I looked at
the code and I honestly do not think I can remove any of it.

For the plain (non-explicit pkey_mprotect()) case, there are exactly
four paths through __arch_override_mprotect_pkey(), resulting in three
different results.

1. New prot==PROT_EXEC, no pkey-exec support -> do not override
2. New prot!=PROT_EXEC, old VMA not PROT_EXEC-> do not override
3. New prot==PROT_EXEC, w/ pkey-exec support -> override to exec pkey
4. New prot!=PROT_EXEC, old VMA is PROT_EXEC -> override to default

I don't see any redundancy there, or any code that we can eliminate or
simplify.  It was simpler before, but that's what where bug was.
