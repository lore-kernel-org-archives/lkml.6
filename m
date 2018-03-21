Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751686AbeCUEYp convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 00:24:45 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6877 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751040AbeCUEYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 00:24:43 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 20 Mar 2018 21:24:42 -0700
Subject: Re: [PATCH 04/15] mm/hmm: unregister mmu_notifier when last HMM
 client quit
To: <jglisse@redhat.com>, <linux-mm@kvack.org>
CC: Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Evgeny Baskakov <ebaskakov@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
References: <20180320020038.3360-1-jglisse@redhat.com>
 <20180320020038.3360-5-jglisse@redhat.com>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <55b8cf9f-2a81-19f3-ff4f-70d5a411baaa@nvidia.com>
Date: Tue, 20 Mar 2018 21:24:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320020038.3360-5-jglisse@redhat.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/19/2018 07:00 PM, jglisse@redhat.com wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
> 
> This code was lost in translation at one point. This properly call
> mmu_notifier_unregister_no_release() once last user is gone. This
> fix the zombie mm_struct as without this patch we do not drop the
> refcount we have on it.
> 
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Cc: Evgeny Baskakov <ebaskakov@nvidia.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Mark Hairgrove <mhairgrove@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> ---
>  mm/hmm.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 6088fa6ed137..667944630dc9 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -244,10 +244,29 @@ EXPORT_SYMBOL(hmm_mirror_register);
>  void hmm_mirror_unregister(struct hmm_mirror *mirror)
>  {
>  	struct hmm *hmm = mirror->hmm;
> +	struct mm_struct *mm = NULL;
> +	bool unregister = false;
>  
>  	down_write(&hmm->mirrors_sem);
>  	list_del_init(&mirror->list);
> +	unregister = list_empty(&hmm->mirrors);

Hi Jerome,

This first minor point may be irrelevant, depending on how you fix 
the other problem below, but: tiny naming idea: rename unregister 
to either "should_unregister", or "mirror_snapshot_empty"...the 
latter helps show that this is stale information, once the lock is 
dropped. 

>  	up_write(&hmm->mirrors_sem);
> +
> +	if (!unregister)
> +		return;

Whee, here I am, lock-free, in the middle of a race condition
window. :)  Right here, someone (hmm_mirror_register) could be adding
another mirror.

It's not immediately clear to me what the best solution is.
I'd be happier if we didn't have to drop one lock and take
another like this, but if we do, then maybe rechecking that
the list hasn't changed...safely, somehow, is a way forward here.


> +
> +	spin_lock(&hmm->mm->page_table_lock);
> +	if (hmm->mm->hmm == hmm) {
> +		mm = hmm->mm;
> +		mm->hmm = NULL;
> +	}
> +	spin_unlock(&hmm->mm->page_table_lock);
> +
> +	if (mm == NULL)
> +		return;
> +
> +	mmu_notifier_unregister_no_release(&hmm->mmu_notifier, mm);
> +	kfree(hmm);
>  }
>  EXPORT_SYMBOL(hmm_mirror_unregister);
>  

thanks,
-- 
John Hubbard
NVIDIA
 
