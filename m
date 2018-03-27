Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752259AbeC0CVc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 22:21:32 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38950 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752019AbeC0CVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 22:21:31 -0400
X-Google-Smtp-Source: AG47ELtQ9r+8HfmJnyDDtD8B95JGBSgFkOYCca1GBqzsLTHuMLSnROYrqWULtLmD18Jo274Or2NgVw==
Date: Tue, 27 Mar 2018 11:21:26 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] zram: idle memory tracking
Message-ID: <20180327022126.GH467@jagdpanzerIV>
References: <20180326064951.123940-1-minchan@kernel.org>
 <20180326064951.123940-2-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326064951.123940-2-minchan@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/26/18 15:49), Minchan Kim wrote:
[..]
> +static ssize_t read_access_time(struct file *file, char __user *buf,
> +				size_t count, loff_t *ppos)
> +{
[..]
> +
> +	for (index = *ppos; index < nr_pages; index++) {
> +		zram_slot_lock(zram, index);
> +		if (zram_test_flag(zram, index, ZRAM_WB))
> +			goto next;

I think it'll be better to show ZRAM_WB pages as well. Those pages
are swapped out pages after all, consuming swap space - a physical
page. Freeing those should also be beneficial. So tracking "bad"
incompressible pages is quite handful.

> +		if (zram_test_flag(zram, index, ZRAM_SAME))
> +			goto next;
> +		if (!zram_get_handle(zram, index))
> +			goto next;
> +
> +		ret = snprintf(kbuf + written, remained, "%lu %lu\n", index,
> +				get_seconds() - zram->table[index].ac_time);

So here you can add a flag after index and age which will tell if the page
is in zsmalloc pool or on backing swap device.

> +		if (remained < ret) {
> +			zram_slot_unlock(zram, index);
> +			break;
> +		}
> +		written += ret;
> +		remained -= ret;
> +next:
> +		zram_slot_unlock(zram, index);
> +		*ppos += 1;
> +	}
> +
> +	up_read(&zram->init_lock);
> +	copy_to_user(buf, kbuf, written);
> +	kvfree(kbuf);
> +
> +	return written;
> +}

	-ss
