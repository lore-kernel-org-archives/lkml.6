Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B138BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825DB206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfAIRj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:39:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37616 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726886AbfAIRjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:39:55 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 30C91A8BB;
        Wed,  9 Jan 2019 17:39:55 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-223.bos.redhat.com [10.18.17.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF59F17AE4;
        Wed,  9 Jan 2019 17:39:53 +0000 (UTC)
Subject: Re: [PATCH v2 4/4] /proc/stat: Call kstat_irqs_usr() only for active
 IRQs
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
References: <1547054628-12703-1-git-send-email-longman@redhat.com>
 <1547054628-12703-5-git-send-email-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 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
 weim8xU=
Organization: Red Hat
Message-ID: <e46e1e57-957c-9024-eb56-b60478c9a9c9@redhat.com>
Date:   Wed, 9 Jan 2019 12:39:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1547054628-12703-5-git-send-email-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 09 Jan 2019 17:39:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2019 12:23 PM, Waiman Long wrote:
> After skipping the percpu summation of non-active IRQs on a 4-socket
> Broadwell system with about 3k IRQs, about half of the CPU cycles were
> spent in the kstat_irqs() call. The majority of which were used to look
> up the IRQ descriptors for the corresponding IRQ numbers.
>
> We can recoup a lot of those lost cycles by calling kstat_irqs_usr()
> only for those IRQs that are active. A bitmap is now used to keep track
> of the list of the active IRQs. Changes in nr_active_irqs count will
> cause the code to rescan all the IRQs and repopulate the bitmap.
>
> On the same 4-socket server, the introduction of this patch further
> reduces the system time of reading /proc/stat 5k times from 8.048s
> to 5.817s. This is a another time reduction of 28%.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  fs/proc/stat.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>
> diff --git a/fs/proc/stat.c b/fs/proc/stat.c
> index 4b06f1b..5e2a398 100644
> --- a/fs/proc/stat.c
> +++ b/fs/proc/stat.c
> @@ -93,6 +93,25 @@ static u64 compute_stat_irqs_sum(void)
>  }
>  
>  /*
> + * Write the given number of space separated '0' into the sequence file.
> + */
> +static void write_zeros(struct seq_file *p, int cnt)
> +{
> +	/* String of 16 '0's */
> +	static const char zeros[] = " 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0";
> +
> +	while (cnt > 0) {
> +		if (cnt >= 16) {
> +			seq_write(p, zeros, 32);
> +			cnt -= 16;
> +		} else {
> +			seq_write(p, zeros, 2 * cnt);
> +			cnt = 0;
> +		}
> +	}
> +}
> +
> +/*
>   * Print out the "intr" line of /proc/stat.
>   */
>  static void show_stat_irqs(struct seq_file *p)
> @@ -100,9 +119,74 @@ static void show_stat_irqs(struct seq_file *p)
>  	int i;
>  
>  	seq_put_decimal_ull(p, "intr ", compute_stat_irqs_sum());
> +
> +	if (IS_ENABLED(CONFIG_SMP) && (nr_cpu_ids >= 10) && (nr_irqs >= 256)) {
> +		/*
> +		 * On systems with 10 or more CPUs and 256 or more IRQs,
> +		 * we used a bitmap to keep track of the number of active
> +		 * IRQs and call kstat_irqs_usr() only for those IRQs.
> +		 * The bitmap will be refreshed whenever nr_active_irqs
> +		 * changes.
> +		 */
> +		extern atomic_t nr_active_irqs;
> +		static DEFINE_MUTEX(irqs_mutex);
> +		static int last_irq = -1;
> +		static int bitmap_size, active_irqs;
> +		static unsigned long *bitmap;
> +		int current_irqs = atomic_read(&nr_active_irqs);
> +
> +		mutex_lock(&irqs_mutex);
> +		if (current_irqs != active_irqs) {
> +			/*
> +			 * Rescan all the IRQs for active ones.
> +			 */
> +			if (nr_irqs > bitmap_size) {
> +				static unsigned long *new_bitmap;
> +				static int new_size;
> +
> +				new_size = BITS_TO_LONGS(nr_irqs)*sizeof(long);
> +				new_bitmap = (unsigned long *)krealloc(bitmap,
> +						new_size, GFP_KERNEL);
> +				if (!new_bitmap)
> +					goto fallback;
> +				bitmap = new_bitmap;
> +				bitmap_size = new_size;
> +			}
> +			memset(bitmap, 0, bitmap_size/BITS_PER_BYTE);
> +			last_irq = 0;

Sorry, last_irq should be initialized to -1 here.

Cheers,
Longman

