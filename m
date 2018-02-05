Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753356AbeBERAj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 12:00:39 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41186 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753292AbeBERAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 12:00:24 -0500
Date: Mon, 5 Feb 2018 09:00:06 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Wang Long <wanglong19@meituan.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jbd2: set to NULL after kmem_cache_destroy
Message-ID: <20180205170006.GA4838@magnolia>
References: <1517837957-1636-1-git-send-email-wanglong19@meituan.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517837957-1636-1-git-send-email-wanglong19@meituan.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8796 signatures=668662
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=753
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802050214
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 09:39:17PM +0800, Wang Long wrote:
> Signed-off-by: Wang Long <wanglong19@meituan.com>
> ---
>  fs/jbd2/journal.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 93016bb..38dc24c 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -2649,11 +2649,14 @@ static int __init jbd2_journal_init_handle_cache(void)
>  
>  static void jbd2_journal_destroy_handle_cache(void)
>  {
> -	if (jbd2_handle_cache)
> +	if (jbd2_handle_cache) {
>  		kmem_cache_destroy(jbd2_handle_cache);

kmem_cache_destroy already handles null pointers, so you can remove the
conditional test entirely.

--D

> -	if (jbd2_inode_cache)
> +		jbd2_handle_cache = NULL;
> +	}
> +	if (jbd2_inode_cache) {
>  		kmem_cache_destroy(jbd2_inode_cache);
> -
> +		jbd2_inode_cache = NULL;
> +	}
>  }
>  
>  /*
> -- 
> 1.8.3.1
> 
