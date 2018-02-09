Return-Path: <kernel-hardening-return-11685-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x225BYLmPpYzikY9wT8kF8Pl4hwKrLUro406BT/DVcotipPKmwyJo7/ZgeuZRDTA7jis/0vQi
ARC-Seal: i=1; a=rsa-sha256; t=1518186528; cv=none;
        d=google.com; s=arc-20160816;
        b=gmDRAYrgoF8H/lcFzHdzKtDSAoRyRl6MqAGHI5YD73kMo7deW5X5W5MLEccnAjxtrk
         x2D4fh25sBOkrkCaU0VNa/FIB8w4y4cvTZpU3tC24+gHoUJlRozA9JtZTFF3rPHVtTjT
         zEjfVWaHLgsz7XBE/sxvcpPfx1d72vRhLdUgc0T27taULWcpqThBQwlchwx7cZqGyv3B
         H7ONQltUhStfx077addbWN+Z/o4pHAgqVGHykOTsfoF/RXV4ssVAHuDa6IJF0m4Gma4K
         98EomIwUjsQqhJcaQc83x/pylDP9lw7SmTtUwNC0fsJOJKCLPbv8pUlghEFC3+SyHVvO
         raJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=nqoD8Ko20JqS/JNr421Bhzt+aWBIjQUke7UWDFTWuVg=;
        b=DneJ1JKRw6asfHdeJc/3f0kaACQl6TNpCdhMAZKUZ7sF26yCKro5xHQcaVhk/liRRW
         6xeGDnjDIOoVffo7iMAb1CrHSpXoZae26x7QRwvhiF1TUa3CS8DBwQakav+utlMSxIFF
         qkVT3NpUJzKw649I7NNaWvllGGbtDWT0kL/XEIb8xIXjMFLqeAAr4zo2GX3E40dNWkmU
         +4SDlZHPEqL09sai6sRY1sStpZIoCTzEC6p6t5LK3yHXHO/754b+38e6Xkz901TjVf6m
         aQvLt88p+AyeKrOy2WvQLBRuLfiipVxDLOh9Ubsy/uvoNUHTgcM1zkNUPreJZ5oqEl6Z
         hkaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11685-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11685-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11685-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11685-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 1/6] genalloc: track beginning of allocations
To: Matthew Wilcox <willy@infradead.org>, Randy Dunlap <rdunlap@infradead.org>
CC: <jglisse@redhat.com>, <keescook@chromium.org>, <mhocko@kernel.org>,
	<labbott@redhat.com>, <hch@infradead.org>, <cl@linux.com>,
	<linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kernel-hardening@lists.openwall.com>
References: <20180204164732.28241-1-igor.stoppa@huawei.com>
 <20180204164732.28241-2-igor.stoppa@huawei.com>
 <60e66c5a-c1de-246f-4be8-b02cb0275da6@infradead.org>
 <20180205034531.GA18559@bombadil.infradead.org>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <ca8891c9-c916-abf1-7370-5e4f37beaac9@huawei.com>
Date: Fri, 9 Feb 2018 16:28:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180205034531.GA18559@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591489766378692364?=
X-GMAIL-MSGID: =?utf-8?q?1591933957432761728?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/02/18 05:45, Matthew Wilcox wrote:
> On Sun, Feb 04, 2018 at 02:34:08PM -0800, Randy Dunlap wrote:
>>> +/**
>>> + * cleart_bits_ll - according to the mask, clears the bits specified by
>>
>>       clear_bits_ll
> 
> 'make W=1' should catch this ... yes?
> 
> (hint: building with 'make C=1 W=1' finds all kinds of interesting issues
> in your code.  W=12 or W=123 finds too many false positives for my tastes)

ok, thank you, I will start using it

--
igor
