Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932533AbeCETNk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 14:13:40 -0500
Received: from mga11.intel.com ([192.55.52.93]:15760 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932505AbeCETNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 14:13:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,428,1515484800";
   d="scan'208";a="32576800"
Subject: Re: [RFC, PATCH 13/22] mm, rmap: Free encrypted pages once mapcount
 drops to zero
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
 <20180305162610.37510-14-kirill.shutemov@linux.intel.com>
Cc: Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <e04536bc-77e9-84d0-3c23-1dfea8542da5@intel.com>
Date: Mon, 5 Mar 2018 11:13:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305162610.37510-14-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2018 08:26 AM, Kirill A. Shutemov wrote:
> @@ -1292,6 +1308,12 @@ static void page_remove_anon_compound_rmap(struct page *page)
>  		__mod_node_page_state(page_pgdat(page), NR_ANON_MAPPED, -nr);
>  		deferred_split_huge_page(page);
>  	}
> +
> +	anon_vma = page_anon_vma(page);
> +	if (anon_vma_encrypted(anon_vma)) {
> +		int keyid = anon_vma_keyid(anon_vma);
> +		free_encrypt_page(page, keyid, compound_order(page));
> +	}
>  }

It's not covered in the description and I'm to lazy to dig into it, so:
Without this code, where do they get freed?  Why does it not cause any
problems to free them here?
