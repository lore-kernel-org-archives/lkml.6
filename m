Return-Path: <kernel-hardening-return-12944-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+2sg7Yww6pmI59z2z3CakYAxGOLZpEAIgFJinwwBct+/NEvq2hLYyLzzstTsNnMkrh6v1/
ARC-Seal: i=1; a=rsa-sha256; t=1523315688; cv=none;
        d=google.com; s=arc-20160816;
        b=wWAuGiPE1NdALLGZh8jlMnTgc54GMnNKBy2KpRLeUS038A2YDHddvIEUYv3TYsXlZ7
         Zi306AJIsgQl5elUHDYIzMoBdSY0whDTLISXREqodF+I6u+pxUaVWn3N2mrzj6r6Tcea
         WuJ5QrwcbkvsvTuwvaoBurhD7h5ThCYxLhoXR3Lv3f+UEtMveNZ/t3sHZsq4+POUHho2
         QMxYXdRBmMqLBVQVzQb2Ab/OLZzfQh1awxohoVJ55tnH9VCztyk0sMZf3KdYzluHnTvO
         SH0iDYr9cQcmov8qnbUR9unhGubaLlPUWL7uhgPcM6MODMqgZuUuqMCFr8z/an2rxjQ1
         AKzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=vwEDXkAhqs7n55VQY7BQnGti3DQXVLcYlL5qAby3A90=;
        b=sdBvucEhhKT6PWjBpQWKw3Lo0E/Mko6HoP7czcRVvjaiAf+yt5Llq0LCqD8rkfCGus
         AJ3pMm+dek8dUnd++Xj6AQ0NenpQ8IZFqHlB80yrCgKEXl8t7400ub4kgjst2gM3pbpk
         m2ObXlmvn8frdH/1AT2709BBhk017DjWkfH+jxGmzwmcPGVzhZtg9th7x6A2gfCB5MeN
         wDKzGgkZ9PAAgn/eflX/3MZRICxT9UBJpCGU9Vndp31uKKCsyelLDJl1im18l50r/l9T
         yA4Wsl0ATb3CwA4gzhM8lX9Yq0uUZUhiUegjH1rdaShixM2UCoO+bUFbUCTC7bjokaCa
         0q4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12944-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12944-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12944-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12944-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH] dmaengine: dmatest: Remove use of VLAs
To: Sinan Kaya <okaya@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com, Kees Cook <keescook@chromium.org>
References: <20180409210603.3575-1-labbott@redhat.com>
 <4491bde2-cf38-5103-0634-1986ecd32a7c@codeaurora.org>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <9bdd8bb4-b6d9-e170-b585-b2dc3b8f0d67@redhat.com>
Date: Mon, 9 Apr 2018 16:14:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <4491bde2-cf38-5103-0634-1986ecd32a7c@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597304199213101990?=
X-GMAIL-MSGID: =?utf-8?q?1597312271577951017?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/09/2018 03:48 PM, Sinan Kaya wrote:
> On 4/9/2018 5:06 PM, Laura Abbott wrote:
>> +			/* dst_cnt can't be more than u8 */
>> +			dma_addr_t dma_pq[255];
> 
> This is 2k stack space on 64 bit architectures. Isn't that a lot?
> 

Depends on your definition of 'a lot'. My assumption was that
since this was a test module there would be some willingness
to be a bit more generous. The problem is the array size is
based off of the parameters passed in, although oddly enough
it's based off of the minimum of two variables. If you have
a suggestion for a tighter bound we can use that. Another
option is to just switch to allocating the array with kmalloc.
That might be reasonable here since there's other setup
that happens before the test starts.

Thanks,
Laura
