Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81ACC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9770B21B1A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B80IEHWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfBNXKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:10:40 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40954 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfBNXKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:10:40 -0500
Received: by mail-wr1-f67.google.com with SMTP id q1so8352343wrp.7;
        Thu, 14 Feb 2019 15:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z+9zbb8RFe/yUhMkwO8O4v64fl479cQbUFQDaaeTxkI=;
        b=B80IEHWH7Opk+JI5pSyBN4WBwwOYdiaWFl5lpRa56dKMWQrdo0SWI013F9SnWvp4RU
         a4xLPNKiVu07GJ1V7SYGutQTTXfzXuy7JpPMaCZ24/2Op1XfDcdkxZMRzHfbqAFjrFpw
         SklayuQMtbEtVR/7bOqkXTvN+qe9TiN5iOahznxESvMsLUm642K93wv2CyS9BvegFx3U
         OcRMfZEkQjDQChQB7YhbPScjb1bLjsnQwEK6iCk0M5fNlDU7nKcz6EAWOWf7Dfc/kvwJ
         C1wGcbVsMUIqUMzWqKgK8CRMX8WJzStgIy0HvBfie3isr4IJbfeSWGGtGaQnric/khNQ
         LrMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z+9zbb8RFe/yUhMkwO8O4v64fl479cQbUFQDaaeTxkI=;
        b=a6k1QS0HdAwEUgF4W4WV93QntnIaDkUSjhaSYcd6YOxGb5FHZTmJG9uVjTtHMPeKwY
         25pytrI68b+pjWuHmZTi2DkLsXMSv0Dh5RpQWc8VyLaF2B2lD2kJs7jJN+IHqI8hP4ba
         4spKHbX7dVOpqAb5CzgQwIZnHayjyHRVLz3L51tCAIJ8wrSx9zZEADltRyPtq6MMiVUo
         uj9TN3epRLmQyyKWeoKdCaTF/8K2qwqBJoPapKlJe+BR4bil/uuScsOeVIXGpg4MY8UV
         N40vGWs6hD1utl4XHW8zj2KrT3vHwbOr6N3nCrZ51Rbil134qpLuLQtuhcrRO/iRYU03
         yXwg==
X-Gm-Message-State: AHQUAuZYlRINruZxmrkBujwfBz9FYfvtp0/yJPc8rE4FEx8fUk+8+Yn9
        MOmY4yj7FCERahYT670Mrc6pwhuANPA=
X-Google-Smtp-Source: AHgI3IbsNlk4Fvpr3HH+kDs+qGc4Q1NAHmTiRsxdrVOqxRzBB2FRVhft3utppOvMD+0T6z/BkkeXbA==
X-Received: by 2002:adf:e949:: with SMTP id m9mr4830622wrn.1.1550185838039;
        Thu, 14 Feb 2019 15:10:38 -0800 (PST)
Received: from [10.32.107.126] ([80.227.69.14])
        by smtp.gmail.com with ESMTPSA id o12sm10467992wre.0.2019.02.14.15.10.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 15:10:37 -0800 (PST)
Subject: Re: [RFC PATCH v5 03/12] __wr_after_init: Core and default arch
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Igor Stoppa <igor.stoppa@huawei.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1550097697.git.igor.stoppa@huawei.com>
 <b99f0de701e299b9d25ce8cfffa3387b9687f5fc.1550097697.git.igor.stoppa@huawei.com>
 <20190214112849.GM32494@hirez.programming.kicks-ass.net>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <6e9ec71c-ee75-9b1e-9ff8-a3210030e85d@gmail.com>
Date:   Fri, 15 Feb 2019 01:10:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214112849.GM32494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/02/2019 13:28, Peter Zijlstra wrote:
> On Thu, Feb 14, 2019 at 12:41:32AM +0200, Igor Stoppa wrote:

[...]

>> +#define wr_rcu_assign_pointer(p, v) ({	\
>> +	smp_mb();			\
>> +	wr_assign(p, v);		\
>> +	p;				\
>> +})
> 
> This requires that wr_memcpy() (through wr_assign) is single-copy-atomic
> for native types. There is not a comment in sight that states this.

Right, I kinda expected native-aligned <-> atomic, but it's not 
necessarily true. It should be confirmed when enabling write rare on a 
new architecture. I'll add the comment.

> Also, is this true of x86/arm64 memcpy ?


For x86_64:
https://elixir.bootlin.com/linux/v5.0-rc6/source/arch/x86/include/asm/uaccess.h#L462 
  the mov"itype"  part should deal with atomic copy of native, aligned 
types.


For arm64:
https://elixir.bootlin.com/linux/v5.0-rc6/source/arch/arm64/lib/copy_template.S#L110 
.Ltiny15 deals with copying less than 16 bytes, which includes pointers. 
When the data is aligned, the copy of a pointer should be atomic.


--
igor
