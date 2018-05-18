Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752061AbeERB0t (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 21:26:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7682 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751839AbeERB0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 21:26:48 -0400
Subject: Re: [PATCH 1/3] f2fs: fix to wait page writeback during revoking
 atomic write
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20180423023615.33247-1-yuchao0@huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <56edfbcd-b400-d68e-9a4a-6b063bdb008f@huawei.com>
Date: Fri, 18 May 2018 09:26:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180423023615.33247-1-yuchao0@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaegeuk,

Could you recheck this patch?

On 2018/4/23 10:36, Chao Yu wrote:
> After revoking atomic write, related LBA can be reused by others, so we
> need to wait page writeback before reusing the LBA, in order to avoid
> interference between old atomic written in-flight IO and new IO.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/segment.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index cba59fc58eb6..24299f81f80d 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -231,6 +231,8 @@ static int __revoke_inmem_pages(struct inode *inode,
>  
>  		lock_page(page);
>  
> +		f2fs_wait_on_page_writeback(page, DATA, true);
> +
>  		if (recover) {
>  			struct dnode_of_data dn;
>  			struct node_info ni;
> 
