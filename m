Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F2BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D3D21780
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HVmYoEIf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XFgbnn5Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D3D21780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731741AbeKLQTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 11:19:08 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36534 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730263AbeKLQTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 11:19:07 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0646960A33; Mon, 12 Nov 2018 06:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542004038;
        bh=XEInYHBy9jRQo8sLJ7d/Ay7Mf++oPj7Vbsw6EctUZ1I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HVmYoEIfz2e30p2AzV6+sgKzTTJ3dlZ1MGQqfhNuH1UKonvdiybRcyS0Kc5QGbbG9
         5QBfYbxlsAAwGt7xLIIUz0lE/QIcQIYqJxdAZ2hBoayjBPcz+x7Hn3YUV/stSgDAOW
         HZYasF05InTT033+h7PahtnW+7Rc5Lc8+i8uc/UA=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 4773F60710;
        Mon, 12 Nov 2018 06:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542004037;
        bh=XEInYHBy9jRQo8sLJ7d/Ay7Mf++oPj7Vbsw6EctUZ1I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XFgbnn5ZL2g1MSbMdLD+P49PWnp35UaJnVl37FUx19mxp23QE/UANug9C+i7pq7N3
         MTEAoz0qocsmcSEhdG/8szYMVNyjGMtrejMJTKLUiVLdr+jo+ZF4Lxw6VdxKnjS7Zo
         /ZQggUzlqT68ZRzgacKJZvYUxcL/slLNvcgidivY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 12 Nov 2018 11:57:17 +0530
From:   Arun KS <arunks@codeaurora.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     keescook@chromium.org, khlebnikov@yandex-team.ru,
        minchan@kernel.org, getarunks@gmail.com,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        mhocko@kernel.org, vbabka@suse.cz, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vatsa@codeaurora.org
Subject: Re: [PATCH v4 1/4] mm: reference totalram_pages and managed_pages
 once per function
In-Reply-To: <20181112061337.GG21824@bombadil.infradead.org>
References: <1542002869-16704-1-git-send-email-arunks@codeaurora.org>
 <1542002869-16704-2-git-send-email-arunks@codeaurora.org>
 <20181112061337.GG21824@bombadil.infradead.org>
Message-ID: <a40d8c9e5c0c3c412d347a24a7c66010@codeaurora.org>
X-Sender: arunks@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Matthew,

Thanks for reviewing.
On 2018-11-12 11:43, Matthew Wilcox wrote:
> On Mon, Nov 12, 2018 at 11:37:46AM +0530, Arun KS wrote:
>> +++ b/arch/um/kernel/mem.c
>> @@ -51,8 +51,7 @@ void __init mem_init(void)
>> 
>>  	/* this will put all low memory onto the freelists */
>>  	memblock_free_all();
>> -	max_low_pfn = totalram_pages;
>> -	max_pfn = totalram_pages;
>> +	max_pfn = max_low_pfn = totalram_pages;
> 
> We don't normally do "a = b = c".  How about:
> 
>  	max_low_pfn = totalram_pages;
> -	max_pfn = totalram_pages;
> +	max_pfn = max_low_pfn;

Point taken. Will fix it.

> 
>> +++ b/arch/x86/kernel/cpu/microcode/core.c
>> @@ -434,9 +434,10 @@ static ssize_t microcode_write(struct file *file, 
>> const char __user *buf,
>>  			       size_t len, loff_t *ppos)
>>  {
>>  	ssize_t ret = -EINVAL;
>> +	unsigned long totalram_pgs = totalram_pages;
> 
> Can't we use a better variable name here?  Even nr_pages would look
> better to me.

Looks better.

Regards,
Arun

> 
>> +++ b/drivers/hv/hv_balloon.c
>> +	unsigned long totalram_pgs = totalram_pages;
> 
> Ditto
> 
>> +++ b/fs/file_table.c
>> +	unsigned long totalram_pgs = totalram_pages;
> 
> ... throughout, I guess.



