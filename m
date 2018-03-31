Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752264AbeCaEMi (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 00:12:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43303 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752059AbeCaEMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 00:12:35 -0400
Subject: Re: [PATCH][next] apparmor: fix memory leak on buffer on error exit
 path
To: Colin King <colin.king@canonical.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, "Serge E . Hallyn" <serge@hallyn.com>,
        linux-kernel@vger.kernel.org
References: <20180327133558.13072-1-colin.king@canonical.com>
From: John Johansen <john.johansen@canonical.com>
Organization: Canonical
Message-ID: <5ddbfd4d-12f3-1cde-c080-8fde508c664f@canonical.com>
Date: Fri, 30 Mar 2018 21:12:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180327133558.13072-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/27/2018 06:35 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently on the error exit path the allocated buffer is not free'd
> causing a memory leak. Fix this by kfree'ing it.
> 
> Detected by CoverityScan, CID#1466876 ("Resource leaks")
> 
> Fixes: 1180b4c757aa ("apparmor: fix dangling symlinks to policy rawdata after replacement")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

thanks Colin

I've pulled it into apparmor-next

> ---
>  security/apparmor/apparmorfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
> index 96bb6b73af65..949dd8a48164 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -1497,8 +1497,10 @@ static char *gen_symlink_name(int depth, const char *dirname, const char *fname)
>  	}
>  
>  	error = snprintf(s, size, "raw_data/%s/%s", dirname, fname);
> -	if (error >= size || error < 0)
> +	if (error >= size || error < 0) {
> +		kfree(buffer);
>  		return ERR_PTR(-ENAMETOOLONG);
> +	}
>  
>  	return buffer;
>  }
> 
