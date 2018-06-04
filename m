Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbeFDSZO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:25:14 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38322 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbeFDSZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:25:12 -0400
X-Google-Smtp-Source: ADUXVKKlxJ6X1ju9A+2vCXpRyW9JPcpaS1xdexiPAt4oRl3NzvjSRDe1FJCkSfOCSUKn8RKSic85yQ==
Date: Mon, 4 Jun 2018 20:25:09 +0200
From: Simon Horman <simon.horman@netronome.com>
To: nixiaoming <nixiaoming@huawei.com>
Cc: davem@davemloft.net, dhowells@redhat.com, manuel.schoelling@gmx.de,
        wang840925@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] net/dns_resolver: dns_query Modify parameter checking to
 avoid dead code
Message-ID: <20180604182508.273hg4nnsykqo3zl@netronome.com>
References: <20180604064031.116472-1-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604064031.116472-1-nixiaoming@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 02:40:31PM +0800, nixiaoming wrote:
> After commit 1a4240f4764a ("DNS: Separate out CIFS DNS Resolver code")
> a dead code exists in function dns_query
> 
> code show as below:
> 	if (!name || namelen == 0)
> 		return -EINVAL;
> 	/*Now the value of "namelen" cannot be equal to 0*/
> 	....
> 	if (!namelen) /*The condition "!namelen"" cannot be true*/
> 		namelen = strnlen(name, 256); /*deadcode*/
> 
> Modify parameter checking to avoid dead code
> 
> Signed-off-by: nixiaoming <nixiaoming@huawei.com>
> ---
>  net/dns_resolver/dns_query.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/net/dns_resolver/dns_query.c b/net/dns_resolver/dns_query.c
> index 49da670..f2acee2 100644
> --- a/net/dns_resolver/dns_query.c
> +++ b/net/dns_resolver/dns_query.c
> @@ -81,7 +81,9 @@ int dns_query(const char *type, const char *name, size_t namelen,
>  	kenter("%s,%*.*s,%zu,%s",
>  	       type, (int)namelen, (int)namelen, name, namelen, options);
>  
> -	if (!name || namelen == 0)
> +	if (!name || namelen < 3 || namelen > 255)
> +		return -EINVAL;
> +	if (namelen > strnlen(name, 256)) /*maybe only need part of name*/

The line above seems to change the behaviour of this function.
I think it and the previous line can be dropped.

>  		return -EINVAL;
>  
>  	/* construct the query key description as "[<type>:]<name>" */
> @@ -94,10 +96,6 @@ int dns_query(const char *type, const char *name, size_t namelen,
>  		desclen += typelen + 1;
>  	}
>  
> -	if (!namelen)
> -		namelen = strnlen(name, 256);
> -	if (namelen < 3 || namelen > 255)
> -		return -EINVAL;
>  	desclen += namelen + 1;

I think the initialisation of desclen can be changed
to include namelen + 1 without changing the behaviour of this function.

>  
>  	desc = kmalloc(desclen, GFP_KERNEL);
> -- 
> 2.10.1
> 
