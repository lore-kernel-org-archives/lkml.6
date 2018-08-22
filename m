Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A157CC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B9F21528
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ZJAwYAa+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B9F21528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbeHVPFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 11:05:25 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39372 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbeHVPFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 11:05:25 -0400
Received: by mail-lf1-f67.google.com with SMTP id j201-v6so1152158lfg.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 04:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PMPH23ZwhmFsU1KB5KHyHtGl4ZWVYfXtO1yGlWevmtc=;
        b=ZJAwYAa+ylAi8JIvk+euPBc+k0X9TGaVMUeCotwsMDh/wS7Y6IMV/rJjSpt1UHgs1Q
         kuy5BhWwphQIdIhxDDx4G9hFncPnKFTbPyGOFeqcvtRRkwpnOLNs113x3klVCoHk8EXn
         VqtbLVGnCHehL2YA7ZwlqL/o0tN6LApKrL+NU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PMPH23ZwhmFsU1KB5KHyHtGl4ZWVYfXtO1yGlWevmtc=;
        b=eDkTK2wkDtAEZHvKGITzYaLrkBjj8aPmAqxYQdUJd0P5cDuot9EQjBJ5mf2xFjoOpi
         bCrz8OzLGXMiTaZAjcf2KmBfuArzrcdUXISOkSD6ViXxJOdkE2odiNCSqKURXZIDemmB
         rFMXehCDnzn6ZrpYn90Lqn1JYvXFpUVxxdXrCEQ4nTrcjx0s2QJ570qD3dyQGzNlhfxl
         zY8mA6UDPpz9LhwN20YDiMB+e6M+wcYieZynqVpdgq13GVRBf867hM1Wp4tG06VTm9sm
         Kpwzo+tiqkL9BWM55lWq23l55UtVzR8NZrwe9XJx2OWSvcdO8IhJ5WovdKMGuM/KaEun
         t+iQ==
X-Gm-Message-State: AOUpUlEwdlVuK52SyTnJIB1VeCgMwtjMf9C1fU1NlFf/O/2y8GmNJqq3
        CngZG6/AOJnPKmYtuCOTzHqQRQ==
X-Google-Smtp-Source: AA+uWPwrWFnB1WPko48TnSga7cnRcIW9RUWR0P4teZg4gKx9SHKpY35Uz0popfIy8tAVuGCiolc24w==
X-Received: by 2002:a19:5788:: with SMTP id l130-v6mr36338152lfb.93.1534938050421;
        Wed, 22 Aug 2018 04:40:50 -0700 (PDT)
Received: from [172.16.11.40] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id w12-v6sm252088lji.63.2018.08.22.04.40.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 04:40:49 -0700 (PDT)
Subject: Re: [PATCH 1/4] string: try to find const-laundering bugs
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-nfs@vger.kernel.org
References: <20180822110009.17583-1-linux@rasmusvillemoes.dk>
 <e28ec4d435200be4d10dc76b17e6a4af0d71b77e.camel@perches.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <9c463cc2-8385-6e1b-334b-367218b4440e@rasmusvillemoes.dk>
Date:   Wed, 22 Aug 2018 13:40:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e28ec4d435200be4d10dc76b17e6a4af0d71b77e.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-22 13:07, Joe Perches wrote:
> On Wed, 2018-08-22 at 13:00 +0200, Rasmus Villemoes wrote:
>> This wraps strchr and friends in macros that ensure the return value has
>> type const char* if the passed-in string (which the return value points
>> into) also has type const char*. The (s)+0 thing is to force a const
>> char[] (e.g. a string literal) to decay to a const char* for the
>> __same_type comparison.
> []
>> diff --git a/include/linux/string.h b/include/linux/string.h
> []
>> +#define strchr(s, c) (						  \
>> +	__builtin_choose_expr(__same_type((s) + 0, const char *), \
>> +			      (const char *)strchr(s, c),	  \
>> +			      strchr(s, c)))
>> +#endif
> []
>> diff --git a/lib/string.c b/lib/string.c
> []
>> @@ -367,7 +367,7 @@ EXPORT_SYMBOL(strncmp);
>>   * @s: The string to be searched
>>   * @c: The character to search for
>>   */
>> -char *strchr(const char *s, int c)
>> +char *(strchr)(const char *s, int c)
> 
> I've tried to use this macro/function wrapping
> a few times before, but it seems that it's fairly
> unusual in the kernel.  I believe there may not
> be any current uses of that style.
> 
> A comment explaining the form might be useful.
> 

True. I dislike the more conventional #undef strchr approach, because
that would mean any other function in string.c that calls strchr and
happens to be defined after strchr() would not be 'instrumented'. It's
more a principle than a practical thing because, well, none of the
instrumented functions happen to be used by other functions in string.c.

Rasmus

