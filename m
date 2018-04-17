Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753072AbeDQMNG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 08:13:06 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33398 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752743AbeDQMNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 08:13:02 -0400
X-Google-Smtp-Source: AIpwx4+l2LtbnHmZ7TkF5lF762x8JzQhVoQkFearNKhFxIwCziScoW5naJPtshsF2u6q21P41ugvyw==
Subject: Re: [PATCH 08/11] lightnvm: pblk: remove unnecessary argument
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
References: <1523874332-6272-1-git-send-email-javier@cnexlabs.com>
 <1523874332-6272-9-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <feabf6cc-a25b-b3de-3259-c211cb7120f0@lightnvm.io>
Date: Tue, 17 Apr 2018 14:12:48 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523874332-6272-9-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/18 12:25 PM, Javier González wrote:
> Remove unnecessary argument on pblk_line_free()
> 

Why was the argument no longer needed?

> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-core.c | 6 +++---
>   drivers/lightnvm/pblk-init.c | 2 +-
>   drivers/lightnvm/pblk.h      | 2 +-
>   3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 6bc0c7f61aac..1b871441d816 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1337,7 +1337,7 @@ static struct pblk_line *pblk_line_retry(struct pblk *pblk,
>   	retry_line->emeta = line->emeta;
>   	retry_line->meta_line = line->meta_line;
>   
> -	pblk_line_free(pblk, line);
> +	pblk_line_free(line);
>   	l_mg->data_line = retry_line;
>   	spin_unlock(&l_mg->free_lock);
>   
> @@ -1562,7 +1562,7 @@ struct pblk_line *pblk_line_replace_data(struct pblk *pblk)
>   	return new;
>   }
>   
> -void pblk_line_free(struct pblk *pblk, struct pblk_line *line)
> +void pblk_line_free(struct pblk_line *line)
>   {
>   	kfree(line->map_bitmap);
>   	kfree(line->invalid_bitmap);
> @@ -1584,7 +1584,7 @@ static void __pblk_line_put(struct pblk *pblk, struct pblk_line *line)
>   	WARN_ON(line->state != PBLK_LINESTATE_GC);
>   	line->state = PBLK_LINESTATE_FREE;
>   	line->gc_group = PBLK_LINEGC_NONE;
> -	pblk_line_free(pblk, line);
> +	pblk_line_free(line);
>   	spin_unlock(&line->lock);
>   
>   	atomic_dec(&gc->pipeline_gc);
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index 8f8c9abd14fc..b52855f9336b 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -509,7 +509,7 @@ static void pblk_lines_free(struct pblk *pblk)
>   	for (i = 0; i < l_mg->nr_lines; i++) {
>   		line = &pblk->lines[i];
>   
> -		pblk_line_free(pblk, line);
> +		pblk_line_free(line);
>   		pblk_line_meta_free(line);
>   	}
>   	spin_unlock(&l_mg->free_lock);
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 856ac41e1201..ff0e5e6421dd 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -766,7 +766,7 @@ struct pblk_line *pblk_line_get_data(struct pblk *pblk);
>   struct pblk_line *pblk_line_get_erase(struct pblk *pblk);
>   int pblk_line_erase(struct pblk *pblk, struct pblk_line *line);
>   int pblk_line_is_full(struct pblk_line *line);
> -void pblk_line_free(struct pblk *pblk, struct pblk_line *line);
> +void pblk_line_free(struct pblk_line *line);
>   void pblk_line_close_meta(struct pblk *pblk, struct pblk_line *line);
>   void pblk_line_close(struct pblk *pblk, struct pblk_line *line);
>   void pblk_line_close_ws(struct work_struct *work);
> 
