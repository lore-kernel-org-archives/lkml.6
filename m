Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753064AbeCETJ1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 14:09:27 -0500
Received: from mga04.intel.com ([192.55.52.120]:54818 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753048AbeCETJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 14:09:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,428,1515484800";
   d="scan'208";a="32575678"
Subject: Re: [RFC, PATCH 16/22] x86/mm: Preserve KeyID on pte_modify() and
 pgprot_modify()
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
 <20180305162610.37510-17-kirill.shutemov@linux.intel.com>
Cc: Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <774c1251-46d9-534e-24c2-ca04f1e0a8bb@intel.com>
Date: Mon, 5 Mar 2018 11:09:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305162610.37510-17-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2018 08:26 AM, Kirill A. Shutemov wrote:
> + * It includes full range of PFN bits regardless if they were claimed for KeyID
> + * or not: we want to preserve KeyID on pte_modify() and pgprot_modify().
>   */
> -#define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |		\
> +#define PTE_PFN_MASK_MAX \
> +	(((signed long)PAGE_MASK) & ((1UL << __PHYSICAL_MASK_SHIFT) - 1))
> +#define _PAGE_CHG_MASK	(PTE_PFN_MASK_MAX | _PAGE_PCD | _PAGE_PWT |		\
>  			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |	\
>  			 _PAGE_SOFT_DIRTY)

Is there a way to make this:

#define _PAGE_CHG_MASK	(PTE_PFN_MASK | PTE_KEY_MASK...? | _PAGE_PCD |

That would be a lot more understandable.
