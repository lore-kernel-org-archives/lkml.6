Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932939AbeCOWsc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 18:48:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59470 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932665AbeCOWsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 18:48:31 -0400
Date: Thu, 15 Mar 2018 15:48:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: jglisse@redhat.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>,
        Evgeny Baskakov <ebaskakov@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 3/4] mm/hmm: HMM should have a callback before MM is
 destroyed
Message-Id: <20180315154829.89054bfd579d03097b0f6457@linux-foundation.org>
In-Reply-To: <20180315183700.3843-4-jglisse@redhat.com>
References: <20180315183700.3843-1-jglisse@redhat.com>
        <20180315183700.3843-4-jglisse@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018 14:36:59 -0400 jglisse@redhat.com wrote:

> From: Ralph Campbell <rcampbell@nvidia.com>
> 
> The hmm_mirror_register() function registers a callback for when
> the CPU pagetable is modified. Normally, the device driver will
> call hmm_mirror_unregister() when the process using the device is
> finished. However, if the process exits uncleanly, the struct_mm
> can be destroyed with no warning to the device driver.

The changelog doesn't tell us what the runtime effects of the bug are. 
This makes it hard for me to answer the "did Jerome consider doing
cc:stable" question.

> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -160,6 +160,23 @@ static void hmm_invalidate_range(struct hmm *hmm,
>  	up_read(&hmm->mirrors_sem);
>  }
>  
> +static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
> +{
> +	struct hmm *hmm = mm->hmm;
> +	struct hmm_mirror *mirror;
> +	struct hmm_mirror *mirror_next;
> +
> +	VM_BUG_ON(!hmm);

This doesn't add much value.  We'll reliably oops on the next statement
anyway, which will provide the same info.  And Linus gets all upset at
new BUG_ON() instances.

> +	down_write(&hmm->mirrors_sem);
> +	list_for_each_entry_safe(mirror, mirror_next, &hmm->mirrors, list) {
> +		list_del_init(&mirror->list);
> +		if (mirror->ops->release)
> +			mirror->ops->release(mirror);
> +	}
> +	up_write(&hmm->mirrors_sem);
> +}
> +
