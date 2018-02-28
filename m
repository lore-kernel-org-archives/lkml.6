Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751713AbeB1AD0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 19:03:26 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44308 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbeB1ADZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 19:03:25 -0500
X-Google-Smtp-Source: AH8x224DEqHfoJR9ImJC9ABzld5OADRN6hwhTShCbJDIYMU5SY+ThySsNZFu1XEgGhB5E59mMEpc+Q==
Date: Wed, 28 Feb 2018 09:03:19 +0900
From: Minchan Kim <minchan@kernel.org>
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: linux-mm@kvack.org, Nitin Gupta <ngupta@vflare.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/zsmalloc: strength reduce zspage_size calculation
Message-ID: <20180228000319.GD168047@rodete-desktop-imager.corp.google.com>
References: <20180226122126.coxtwkv5bqifariz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226122126.coxtwkv5bqifariz@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joey,

On Mon, Feb 26, 2018 at 02:21:26AM -1000, Joey Pabalinas wrote:
> Replace the repeated multiplication in the main loop
> body calculation of zspage_size with an equivalent
> (and cheaper) addition operation.
> 
> Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
> 
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index c3013505c30527dc42..647a1a2728634b5194 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -821,15 +821,15 @@ static enum fullness_group fix_fullness_group(struct size_class *class,
>   */
>  static int get_pages_per_zspage(int class_size)
>  {
> +	int zspage_size = 0;
>  	int i, max_usedpc = 0;
>  	/* zspage order which gives maximum used size per KB */
>  	int max_usedpc_order = 1;
>  
>  	for (i = 1; i <= ZS_MAX_PAGES_PER_ZSPAGE; i++) {
> -		int zspage_size;
>  		int waste, usedpc;
>  
> -		zspage_size = i * PAGE_SIZE;
> +		zspage_size += PAGE_SIZE;
>  		waste = zspage_size % class_size;
>  		usedpc = (zspage_size - waste) * 100 / zspage_size;
>  

Thanks for the patch! However, it's used only zs_create_pool which
is really cold path so I don't feel it would improve for real practice.

Thanks.
