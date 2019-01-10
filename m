Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6465C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF112206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfAJKsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:48:46 -0500
Received: from relay.sw.ru ([185.231.240.75]:57818 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbfAJKsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:48:46 -0500
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1ghXtD-0003ak-61; Thu, 10 Jan 2019 13:48:43 +0300
Subject: Re: [PATCH 1/2] fuse: Fix race in fuse_writepage_in_flight()
To:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <154322517208.18737.3297786654135648324.stgit@localhost.localdomain>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <00b1782a-5c5c-5bc8-7ea9-4f8450679fa1@virtuozzo.com>
Date:   Thu, 10 Jan 2019 13:48:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <154322517208.18737.3297786654135648324.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Miklos,

any comments about this?

On 26.11.2018 12:46, Kirill Tkhai wrote:
> Checking for FR_PENDING in fuse_writepage_in_flight() is racy.
> It does not guarantee the first request in misc.write.next list
> is not in userspace, since there we take fc->lock, while
> fuse_dev_do_read() takes fiq->waitq.lock:
> 
> fuse_dev_read()                           fuse_writepage_in_flight()
>                                             test_bit(FR_PENDING)
>   clear_bit(FR_PENDING)
> handle old_req->pages[0] in userspace
>                                             copy_highpage(old_req->pages[0], page)
>                                             ^^^^^
>                                             userspace never sees this pages
> 
> The only reliable way to determ, whether we are able to replace
> old_req's page, is to completely skip the first request in the list.
> This patch makes the function to do that.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  fs/fuse/file.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index b52f9baaa3e7..c6650c68b31a 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1740,6 +1740,7 @@ static bool fuse_writepage_in_flight(struct fuse_req *new_req,
>  {
>  	struct fuse_conn *fc = get_fuse_conn(new_req->inode);
>  	struct fuse_inode *fi = get_fuse_inode(new_req->inode);
> +	struct fuse_req *first_req;
>  	struct fuse_req *tmp;
>  	struct fuse_req *old_req;
>  	bool found = false;
> @@ -1764,6 +1765,7 @@ static bool fuse_writepage_in_flight(struct fuse_req *new_req,
>  	}
>  
>  	new_req->num_pages = 1;
> +	first_req = old_req;
>  	for (tmp = old_req; tmp != NULL; tmp = tmp->misc.write.next) {
>  		BUG_ON(tmp->inode != new_req->inode);
>  		curr_index = tmp->misc.write.in.offset >> PAGE_SHIFT;
> @@ -1773,7 +1775,7 @@ static bool fuse_writepage_in_flight(struct fuse_req *new_req,
>  		}
>  	}
>  
> -	if (old_req->num_pages == 1 && test_bit(FR_PENDING, &old_req->flags)) {
> +	if (old_req->num_pages == 1 && old_req != first_req) {
>  		struct backing_dev_info *bdi = inode_to_bdi(page->mapping->host);
>  
>  		copy_highpage(old_req->pages[0], page);
> 
