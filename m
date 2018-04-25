Return-Path: <labbott@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524671257; cv=none;
        d=google.com; s=arc-20160816;
        b=SW+YnsJEdDqd03eeXzts4X4ehoAMzQP+mZv3V54ISEGkaiQupDgmWHILTvlqsWUHqI
         g3SJLFi8KW9ARQgIjwvhqUGsTtY7CUZRQSPc1eL/VbjV4vX8yf38B5EUqLeGyxmGKBYO
         mt0oHmPYXrGv7pnJfEwSin7VMN5FfbyPHZGAf6i1wPuTlVyZL6v/V701RRH0PN6z5OhM
         WSvyxX/z8SQtVKhpA3MBmMMgRhqyECa9/0elpMTZ7Wx/ljJEmiR+XPd7caqWcfhmpSVB
         qgaPxZPR6Xt2zNpIfYSK4TMn3GqkLRh0qS337vhaM3gcWgYP/9FEbdXRdJhGOV/hlKr7
         gr2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=zxDLaRXGm8d7OuSwf5W7Lg2cXcWHFMrVBc617UmcgzY=;
        b=SWcZtUpnPcojnq4J4Gpa4aamhL3mLN2AWIh/GcROU8l5qXkgAHXB5sEwORCSY1BmSv
         /DJZXPSw5lUvTfUTZ/s4H6uQdKGRZh4502odZT4cnA6fTsKlWRoe/TkGpEyUtpfSPFRk
         8m7cOoYW8YtwiCUyomltlD1m2DJ9zikIU5Fg4JiK4oR4OPi+Jk8IVjiwXdDquZ8Wdm+r
         qTYtrOh2oVDnwr+4yAjkqMaAxiSizGuA/C4vCbCdDbrRv/UUZPa9HaW7wcLrsH7THYIG
         IrUflLvJax6pth/vMvdbvY0COXpQYUZgO8DBS02VuP6WhQ+23ToFrgb3J55qRMtZPWdZ
         nP/A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of labbott@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=labbott@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of labbott@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=labbott@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AIpwx48ZBKKnqCbFxHj7ykVqakPg1KVNA+jYNs6KNGWi9cQVhmw9oIPxWj0s0ClI1+BUidouzpMkzg==
Subject: Re: [PATCH] ion: Consider ion pool pages as indirectly reclaimable
To: vjitta@codeaurora.org, sumit.semwal@linaro.org
Cc: gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
 maco@android.com, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <1524627830-17187-1-git-send-email-vjitta@codeaurora.org>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <8618859b-06f9-39a7-80a9-af36cf9faf9f@redhat.com>
Date: Wed, 25 Apr 2018 08:47:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524627830-17187-1-git-send-email-vjitta@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598686980343164648?=
X-GMAIL-MSGID: =?utf-8?q?1598733688796825208?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/24/2018 08:43 PM, vjitta@codeaurora.org wrote:
> From: Vijayanand Jitta <vjitta@codeaurora.org>
> 
> An issue is observed where mallocs are failing due to overcommit failure.
> The failure happens when there is high ION page pool since ION page
> pool is not considered reclaimable by the overcommit calculation code.
> This change considers ion pool pages as indirectly reclaimable and thus
> accounted as available memory in the overcommit calculation.
> 
> Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
> ---
>   drivers/staging/android/ion/ion_page_pool.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
> index db8f614..9bc56eb 100644
> --- a/drivers/staging/android/ion/ion_page_pool.c
> +++ b/drivers/staging/android/ion/ion_page_pool.c
> @@ -32,6 +32,9 @@ static void ion_page_pool_add(struct ion_page_pool *pool, struct page *page)
>   		list_add_tail(&page->lru, &pool->low_items);
>   		pool->low_count++;
>   	}
> +
> +	mod_node_page_state(page_pgdat(page), NR_INDIRECTLY_RECLAIMABLE_BYTES,
> +			    (1 << (PAGE_SHIFT + pool->order)));
>   	mutex_unlock(&pool->mutex);
>   }
>   
> @@ -50,6 +53,8 @@ static struct page *ion_page_pool_remove(struct ion_page_pool *pool, bool high)
>   	}
>   
>   	list_del(&page->lru);
> +	mod_node_page_state(page_pgdat(page), NR_INDIRECTLY_RECLAIMABLE_BYTES,
> +			    -(1 << (PAGE_SHIFT + pool->order)));
>   	return page;
>   }
>   
> 

I'm sure this fixes the problem but I don't think we want to
start throwing page adjustments into Ion. Why isn't this
memory already considered reclaimable by existing calculations?

Thanks,
Laura
