Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D129BC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BAC21717
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65BAC21717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbeHNXVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 19:21:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726837AbeHNXVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 19:21:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A42E04219DD3;
        Tue, 14 Aug 2018 20:32:46 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FECF2156712;
        Tue, 14 Aug 2018 20:32:46 +0000 (UTC)
Date:   Tue, 14 Aug 2018 16:32:46 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     xiao jin <jin.xiao@intel.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Cc:     agk@redhat.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        yanmin.zhang@intel.com
Subject: Re: dm-bufio: adjust the reserved buffer for dm-verify-target.
Message-ID: <20180814203245.GA15636@redhat.com>
References: <1533710457-6411-1-git-send-email-jin.xiao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533710457-6411-1-git-send-email-jin.xiao@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 14 Aug 2018 20:32:46 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 14 Aug 2018 20:32:46 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'msnitzer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08 2018 at  2:40am -0400,
xiao jin <jin.xiao@intel.com> wrote:

> We hit the BUG() report at include/linux/scatterlist.h:144!
> The callback is as bellow:
>   => verity_work
>   => verity_hash_for_block
>   => verity_verify_level
>   => verity_hash
>   => verity_hash_update
>   => sg_init_one
>   => sg_set_buf
> 
> More debug shows the root cause. When creating dufio client it
> uses the __vmalloc() to allocate the buffer data for the reserved
> dm_buffer. The buffer that allocated by the __vmalloc() is invalid
> according to the __virt_addr_valid().
> 
> Mostly the reserved dm_buffer is not touched. But occasionally
> it might fail to allocate the dm_buffer data when we try to
> allocate in the __alloc_buffer_wait_no_callback(). Then it has
> to take the reserved dm_buffer for usage. Finally it reports the
> BUG() as virt_addr_valid() detects the buffer data address is invalid.
> 
> The patch is to adjust the reserved buffer for dm-verity-target. We
> allocated two dm_buffers into the reserved buffers list when creating
> the buffer interface. The first dm_buffer in the reserved buffer list
> is allocated by the __vmalloc(), it's not used after that. The second
> dm_buffer in the reserved buffer list is allocated by the
> __get_free_pages() which can be consumed after that.
> 
> Signed-off-by: xiao jin <jin.xiao@intel.com>
> ---
>  drivers/md/dm-bufio.c         | 4 ++--
>  drivers/md/dm-verity-target.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
> index dc385b7..3b7ca5e 100644
> --- a/drivers/md/dm-bufio.c
> +++ b/drivers/md/dm-bufio.c
> @@ -841,7 +841,7 @@ static struct dm_buffer *__alloc_buffer_wait_no_callback(struct dm_bufio_client
>  			tried_noio_alloc = true;
>  		}
>  
> -		if (!list_empty(&c->reserved_buffers)) {
> +		if (!c->need_reserved_buffers) {
>  			b = list_entry(c->reserved_buffers.next,
>  				       struct dm_buffer, lru_list);
>  			list_del(&b->lru_list);
> @@ -1701,7 +1701,7 @@ struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev, unsign
>  		goto bad;
>  	}
>  
> -	while (c->need_reserved_buffers) {
> +	if (list_empty(&c->reserved_buffers)) {
>  		struct dm_buffer *b = alloc_buffer(c, GFP_KERNEL);
>  
>  		if (!b) {

Point was to allocate N buffers (as accounted in
c->need_reserved_buffers).  This change just allocates a single one.
Why?

Your header isn't clear on this at all.

> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index 12decdbd7..40c66fc 100644
> --- a/drivers/md/dm-verity-target.c
> +++ b/drivers/md/dm-verity-target.c
> @@ -1107,7 +1107,7 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
>  	v->hash_blocks = hash_position;
>  
>  	v->bufio = dm_bufio_client_create(v->hash_dev->bdev,
> -		1 << v->hash_dev_block_bits, 1, sizeof(struct buffer_aux),
> +		1 << v->hash_dev_block_bits, 2, sizeof(struct buffer_aux),
>  		dm_bufio_alloc_callback, NULL);
>  	if (IS_ERR(v->bufio)) {
>  		ti->error = "Cannot initialize dm-bufio";
> -- 
> 2.7.4
> 
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://www.redhat.com/mailman/listinfo/dm-devel

It isn't at all clear from my initial review that what you're doing
makes any sense.

Seems like you're just papering over bufio's use of !__virt_addr_valid()
memory in unintuitive ways.

Mikulas, can you see a better way forward?

Mike
