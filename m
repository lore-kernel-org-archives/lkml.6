Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB6FC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71760208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71760208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934550AbeFRNo6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:44:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56932 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754091AbeFRNoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:44:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0B6C7402178A;
        Mon, 18 Jun 2018 13:44:55 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B99A52026D68;
        Mon, 18 Jun 2018 13:44:54 +0000 (UTC)
Date:   Mon, 18 Jun 2018 09:44:54 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3 1/5] md: Avoid namespace collision with bitmap API
Message-ID: <20180618134454.GA25547@redhat.com>
References: <20180618131003.88110-1-andriy.shevchenko@linux.intel.com>
 <20180618131003.88110-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618131003.88110-2-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 18 Jun 2018 13:44:55 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 18 Jun 2018 13:44:55 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'msnitzer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18 2018 at  9:09am -0400,
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> bitmap API (include/linux/bitmap.h) has 'bitmap' prefix for its methods.
> 
> On the other hand MD bitmap API is special case.
> Adding 'md' prefix to it to avoid name space collision.
> 
> No functional changes intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/md/dm-raid.c                          |   6 +-
>  drivers/md/md-bitmap.c                        | 301 +++++++++---------
>  drivers/md/md-bitmap.h                        |  46 +--
>  drivers/md/md-cluster.c                       |  16 +-
>  drivers/md/md.c                               |  44 +--
>  .../md/persistent-data/dm-space-map-common.c  |  12 +-
>  drivers/md/raid1.c                            |  20 +-
>  drivers/md/raid10.c                           |  26 +-
>  drivers/md/raid5-cache.c                      |   2 +-
>  drivers/md/raid5.c                            |  24 +-
>  10 files changed, 244 insertions(+), 253 deletions(-)

Seems my previous mail just missed your v3 cutoff but...

<snip>

All of these drivers/md/persistent-data/dm-space-map-common.c renames
are wrong.  DM is the only consumer (it is confusing because all DM and
MD code lives in drivers/md/ despite only sharing a bit of MD code).

Anyway, please rename bitmap methods in this file to have a "dm_bitmap"
prefix instead.  Thanks.

Mike

> diff --git a/drivers/md/persistent-data/dm-space-map-common.c b/drivers/md/persistent-data/dm-space-map-common.c
> index 829b4ce057d8..049e999fc6c4 100644
> --- a/drivers/md/persistent-data/dm-space-map-common.c
> +++ b/drivers/md/persistent-data/dm-space-map-common.c
> @@ -69,7 +69,7 @@ static struct dm_block_validator index_validator = {
>   */
>  #define BITMAP_CSUM_XOR 240779
>  
> -static void bitmap_prepare_for_write(struct dm_block_validator *v,
> +static void md_bitmap_prepare_for_write(struct dm_block_validator *v,
>  				     struct dm_block *b,
>  				     size_t block_size)
>  {
> @@ -81,7 +81,7 @@ static void bitmap_prepare_for_write(struct dm_block_validator *v,
>  						       BITMAP_CSUM_XOR));
>  }
>  
> -static int bitmap_check(struct dm_block_validator *v,
> +static int md_bitmap_check(struct dm_block_validator *v,
>  			struct dm_block *b,
>  			size_t block_size)
>  {
> @@ -108,8 +108,8 @@ static int bitmap_check(struct dm_block_validator *v,
>  
>  static struct dm_block_validator dm_sm_bitmap_validator = {
>  	.name = "sm_bitmap",
> -	.prepare_for_write = bitmap_prepare_for_write,
> -	.check = bitmap_check
> +	.prepare_for_write = md_bitmap_prepare_for_write,
> +	.check = md_bitmap_check,
>  };
>  
>  /*----------------------------------------------------------------*/
> @@ -124,7 +124,7 @@ static void *dm_bitmap_data(struct dm_block *b)
>  
>  #define WORD_MASK_HIGH 0xAAAAAAAAAAAAAAAAULL
>  
> -static unsigned bitmap_word_used(void *addr, unsigned b)
> +static unsigned md_bitmap_word_used(void *addr, unsigned b)
>  {
>  	__le64 *words_le = addr;
>  	__le64 *w_le = words_le + (b >> ENTRIES_SHIFT);
> @@ -170,7 +170,7 @@ static int sm_find_free(void *addr, unsigned begin, unsigned end,
>  {
>  	while (begin < end) {
>  		if (!(begin & (ENTRIES_PER_WORD - 1)) &&
> -		    bitmap_word_used(addr, begin)) {
> +		    md_bitmap_word_used(addr, begin)) {
>  			begin += ENTRIES_PER_WORD;
>  			continue;
>  		}
