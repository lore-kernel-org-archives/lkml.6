Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751784AbeEQS1O (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 14:27:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48868 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeEQS1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 14:27:13 -0400
Date: Thu, 17 May 2018 11:26:38 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, lurodriguez@suse.de
Subject: Re: [PATCH v2] vfs: avoid dereferencing pointers in iterate_supers
 callbacks
Message-ID: <20180517182638.GD26718@bombadil.infradead.org>
References: <20180517154646.18751-1-jlayton@kernel.org>
 <20180517174336.18529-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517174336.18529-1-jlayton@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 01:43:36PM -0400, Jeff Layton wrote:
> @@ -107,12 +109,10 @@ static void fdatawait_one_bdev(struct block_device *bdev, void *arg)
>   */
>  void ksys_sync(void)
>  {
> -	int nowait = 0, wait = 1;
> -
>  	wakeup_flusher_threads(WB_REASON_SYNC);
>  	iterate_supers(sync_inodes_one_sb, NULL);
> -	iterate_supers(sync_fs_one_sb, &nowait);
> -	iterate_supers(sync_fs_one_sb, &wait);
> +	iterate_supers(sync_fs_one_sb, NULL);
> +	iterate_supers(sync_fs_one_sb, (void *)1UL);

I think this is actually less clear.  How about:

	void *wait = (void *)1UL;

	iterate_supers(sync_fs_one_sb, !wait);
	iterate_supers(sync_fs_one_sb, wait);
