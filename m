Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752359AbeC0C0n (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 22:26:43 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38339 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbeC0C0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 22:26:41 -0400
X-Google-Smtp-Source: AG47ELsXxvBIjffUeNn47xwFIE6SxozBP+fqOrbMaR0FXCphE1bmovIQzuj+qIpNhtSYFvFsshKCGQ==
Date: Tue, 27 Mar 2018 11:26:35 +0900
From: Minchan Kim <minchan@kernel.org>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] zram: idle memory tracking
Message-ID: <20180327022635.GA74514@rodete-desktop-imager.corp.google.com>
References: <20180326064951.123940-1-minchan@kernel.org>
 <20180326064951.123940-2-minchan@kernel.org>
 <20180327022126.GH467@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327022126.GH467@jagdpanzerIV>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 11:21:26AM +0900, Sergey Senozhatsky wrote:
> On (03/26/18 15:49), Minchan Kim wrote:
> [..]
> > +static ssize_t read_access_time(struct file *file, char __user *buf,
> > +				size_t count, loff_t *ppos)
> > +{
> [..]
> > +
> > +	for (index = *ppos; index < nr_pages; index++) {
> > +		zram_slot_lock(zram, index);
> > +		if (zram_test_flag(zram, index, ZRAM_WB))
> > +			goto next;
> 
> I think it'll be better to show ZRAM_WB pages as well. Those pages
> are swapped out pages after all, consuming swap space - a physical
> page. Freeing those should also be beneficial. So tracking "bad"
> incompressible pages is quite handful.
> 
> > +		if (zram_test_flag(zram, index, ZRAM_SAME))
> > +			goto next;
> > +		if (!zram_get_handle(zram, index))
> > +			goto next;
> > +
> > +		ret = snprintf(kbuf + written, remained, "%lu %lu\n", index,
> > +				get_seconds() - zram->table[index].ac_time);
> 
> So here you can add a flag after index and age which will tell if the page
> is in zsmalloc pool or on backing swap device.

Yeb, that's the way I'm approach during our discussion!

Thanks for the review, Sergey!
