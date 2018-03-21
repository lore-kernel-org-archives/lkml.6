Return-Path: <vbabka@suse.cz>
X-Google-Smtp-Source: AG47ELtwF7Cfgli48gwfV/A7ueXMiIpEKDZyCUCtrrLJe9oLIeI4k31fIdFiqBO0GmwawfJeVvCP
ARC-Seal: i=1; a=rsa-sha256; t=1521620840; cv=none;
        d=google.com; s=arc-20160816;
        b=zLvkamJA5EYJsGqHc6BvNeYsOWXYI50AiZmOQP9UDPvG7lxFYkkJi6jc/59HnoRONn
         0dhwP3vxVKXyMKjwkZizZ/131uqPiD5JAIC6VLt9INQ9q6+HCAgtEDKRVVt6gN7e60Kc
         3iIg8n2suDfJF+2QGLVNA8qq/DXg+Gtxt+5C/CqAXnTIFRb2wjZJZXvKBKnEx4I99U6F
         OasG0NO90gP0hg2lwOiRubMFkPSAzU2+Wu9R0rQT2+138Mzi7bk/0Ey+wKADS2IJxUKZ
         qCq/ua/NtCVqCY3Qzln3dsO4vn1MLKHWx9p1YyY/LARvB6/SSEL23SNqA2NGknLKgGSp
         Xhbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=//K9gozBWpX1+aMeaM1vIXNyuWzLgO46VMGLC5UYIrU=;
        b=b1Z20Zi+ihOaFunVXzxGPNRJ2qeWUJ2/yYkBVRtAQFc/0LGkUG4YOl56hau3mZoB5X
         DgbcheqDaMrEJ8PwhS7q4N/DSR7ruRmYWynXS/GPhbFtc9PKzRDNd55gIfiHDdkmcEUx
         zPNNqtjtcHfsrWa28E+gniVnzQtqeHpjQFHwmId+WauLHCPKgoOpuJGsK5LgXMsv9R2C
         8WSKwI6bZM3+xnu/SwXXqhIjTlEpNE3mXzX5B04iYw0ItSAwm5YTo7yE3qJSWFvX50qo
         CkBKIkqgIwPUqCnbhsLRIYNKspOnnNEWTEP20+GnREuA7HkpxTXHYK5GL68ulRh4RKCx
         wJ/w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of vbabka@suse.cz designates 195.135.220.15 as permitted sender) smtp.mailfrom=vbabka@suse.cz
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of vbabka@suse.cz designates 195.135.220.15 as permitted sender) smtp.mailfrom=vbabka@suse.cz
Subject: Re: [PATCH 1/1] mm/page_owner: fix recursion bug after changing skip
 entries
To: Maninder Singh <maninder1.s@samsung.com>, akpm@linux-foundation.org,
 mhocko@suse.com, osalvador@techadventures.net, gregkh@linuxfoundation.org,
 ayush.m@samsung.com, guptap@codeaurora.org, vinmenon@codeaurora.org,
 gomonovych@gmail.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
 pankaj.m@samsung.com, Vaneet Narang <v.narang@samsung.com>
References: <CGME20180321043818epcas5p176fe0e0bbfce685420df2bfb7a421acd@epcas5p1.samsung.com>
 <1521607043-34670-1-git-send-email-maninder1.s@samsung.com>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <40171c50-4466-6589-3968-024f936e5c7a@suse.cz>
Date: Wed, 21 Mar 2018 09:25:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521607043-34670-1-git-send-email-maninder1.s@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595520689228013182?=
X-GMAIL-MSGID: =?utf-8?q?1595535093877195838?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/21/2018 05:37 AM, Maninder Singh wrote:
> This patch fixes "5f48f0bd4e368425db4424b9afd1bd251d32367a".
> (mm, page_owner: skip unnecessary stack_trace entries)
> 
> Because if we skip first two entries then logic of checking count
> value as 2 for recursion is broken and code will go in one depth
> recursion.
> 
> so we need to check only one call of _RET_IP(__set_page_owner)
> while checking for recursion.
> 
> Current Backtrace while checking for recursion:-
> 
> (save_stack)             from (__set_page_owner)  // (But recursion returns true here)
> (__set_page_owner)       from (get_page_from_freelist)
> (get_page_from_freelist) from (__alloc_pages_nodemask)
> (__alloc_pages_nodemask) from (depot_save_stack)
> (depot_save_stack)       from (save_stack)       // recursion should return true here
> (save_stack)             from (__set_page_owner)
> (__set_page_owner)       from (get_page_from_freelist)
> (get_page_from_freelist) from (__alloc_pages_nodemask+)
> (__alloc_pages_nodemask) from (depot_save_stack)
> (depot_save_stack)       from (save_stack)
> (save_stack)             from (__set_page_owner)
> (__set_page_owner)       from (get_page_from_freelist)
> 
> Correct Backtrace with fix:
> 
> (save_stack)             from (__set_page_owner) // recursion returned true here
> (__set_page_owner)       from (get_page_from_freelist)
> (get_page_from_freelist) from (__alloc_pages_nodemask+)
> (__alloc_pages_nodemask) from (depot_save_stack)
> (depot_save_stack)       from (save_stack)
> (save_stack)             from (__set_page_owner)
> (__set_page_owner)       from (get_page_from_freelist)
> 
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Fixes: 5f48f0bd4e36 ("mm, page_owner: skip unnecessary stack_trace entries")

Good catch.
Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_owner.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 8592543..46ab1c4 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -123,13 +123,13 @@ void __reset_page_owner(struct page *page, unsigned int order)
>  static inline bool check_recursive_alloc(struct stack_trace *trace,
>  					unsigned long ip)
>  {
> -	int i, count;
> +	int i;
>  
>  	if (!trace->nr_entries)
>  		return false;
>  
> -	for (i = 0, count = 0; i < trace->nr_entries; i++) {
> -		if (trace->entries[i] == ip && ++count == 2)
> +	for (i = 0; i < trace->nr_entries; i++) {
> +		if (trace->entries[i] == ip)
>  			return true;
>  	}
>  
> 
