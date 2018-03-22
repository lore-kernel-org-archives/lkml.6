Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752386AbeCVG63 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 02:58:29 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13703 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752024AbeCVG6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 02:58:25 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 21 Mar 2018 23:58:25 -0700
Subject: Re: [PATCH 03/15] mm/hmm: HMM should have a callback before MM is
 destroyed v3
To: <jglisse@redhat.com>, <linux-mm@kvack.org>
CC: Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Ralph Campbell <rcampbell@nvidia.com>,
        Evgeny Baskakov <ebaskakov@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
References: <20180320020038.3360-4-jglisse@redhat.com>
 <20180322012848.6936-1-jglisse@redhat.com>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <0fd1e592-83db-99d6-4e69-dab65e20621f@nvidia.com>
Date: Wed, 21 Mar 2018 23:58:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180322012848.6936-1-jglisse@redhat.com>
X-Originating-IP: [10.2.165.252]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/21/2018 06:28 PM, jglisse@redhat.com wrote:
> From: Ralph Campbell <rcampbell@nvidia.com>
> 
> The hmm_mirror_register() function registers a callback for when
> the CPU pagetable is modified. Normally, the device driver will
> call hmm_mirror_unregister() when the process using the device is
> finished. However, if the process exits uncleanly, the struct_mm
> can be destroyed with no warning to the device driver.
> 
> Changed since v1:
>   - dropped VM_BUG_ON()
>   - cc stable
> Changed since v2:
>   - drop stable
>   - Split list removale and call to driver release callback. This
>     allow the release callback to wait on any pending fault handler
>     without deadlock.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Cc: Evgeny Baskakov <ebaskakov@nvidia.com>
> Cc: Mark Hairgrove <mhairgrove@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/linux/hmm.h | 10 ++++++++++
>  mm/hmm.c            | 29 ++++++++++++++++++++++++++++-
>  2 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 36dd21fe5caf..fa7b51f65905 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -218,6 +218,16 @@ enum hmm_update_type {
>   * @update: callback to update range on a device
>   */
>  struct hmm_mirror_ops {
> +	/* release() - release hmm_mirror
> +	 *
> +	 * @mirror: pointer to struct hmm_mirror
> +	 *
> +	 * This is called when the mm_struct is being released.
> +	 * The callback should make sure no references to the mirror occur
> +	 * after the callback returns.
> +	 */
> +	void (*release)(struct hmm_mirror *mirror);
> +
>  	/* sync_cpu_device_pagetables() - synchronize page tables
>  	 *
>  	 * @mirror: pointer to struct hmm_mirror
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 320545b98ff5..34c16297f65e 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -160,6 +160,32 @@ static void hmm_invalidate_range(struct hmm *hmm,
>  	up_read(&hmm->mirrors_sem);
>  }
>  
> +static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
> +{
> +	struct hmm_mirror *mirror;
> +	struct hmm *hmm = mm->hmm;
> +
> +	down_write(&hmm->mirrors_sem);
> +	mirror = list_first_entry_or_null(&hmm->mirrors, struct hmm_mirror,
> +					  list);
> +	while (mirror) {
> +		list_del_init(&mirror->list);
> +		if (mirror->ops->release) {
> +			/*
> +			 * Drop mirrors_sem so callback can wait on any pending
> +			 * work that might itself trigger mmu_notifier callback
> +			 * and thus would deadlock with us.
> +			 */
> +			up_write(&hmm->mirrors_sem);
> +			mirror->ops->release(mirror);
> +			down_write(&hmm->mirrors_sem);
> +		}
> +		mirror = list_first_entry_or_null(&hmm->mirrors, struct hmm_mirror,
> +						  list);
> +	}
> +	up_write(&hmm->mirrors_sem);
> +}
> +

Hi Jerome,

This looks good (and the list handling is way better than my horrible 
copy-the-list idea)!

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

>  static void hmm_invalidate_range_start(struct mmu_notifier *mn,
>  				       struct mm_struct *mm,
>  				       unsigned long start,
> @@ -185,6 +211,7 @@ static void hmm_invalidate_range_end(struct mmu_notifier *mn,
>  }
>  
>  static const struct mmu_notifier_ops hmm_mmu_notifier_ops = {
> +	.release		= hmm_release,
>  	.invalidate_range_start	= hmm_invalidate_range_start,
>  	.invalidate_range_end	= hmm_invalidate_range_end,
>  };
> @@ -230,7 +257,7 @@ void hmm_mirror_unregister(struct hmm_mirror *mirror)
>  	struct hmm *hmm = mirror->hmm;
>  
>  	down_write(&hmm->mirrors_sem);
> -	list_del(&mirror->list);
> +	list_del_init(&mirror->list);
>  	up_write(&hmm->mirrors_sem);
>  }
>  EXPORT_SYMBOL(hmm_mirror_unregister);
> 
