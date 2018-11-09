Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9DCC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFDED20818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksjryap5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFDED20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbeKJHNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:13:07 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36801 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeKJHNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:13:07 -0500
Received: by mail-pf1-f196.google.com with SMTP id d13-v6so1496534pfo.3;
        Fri, 09 Nov 2018 13:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z965BfpumDTFd11WWj1q3egUudyX88bWRmHmSxwIMXE=;
        b=ksjryap59IjST3h9qNGTZPgcoSuZ+eSZWjgte5ZGgBBrQJqIv7LYesZRgrNbuj2XK1
         5UuxiGxlZwkgUj1ITcV510IoXodocxjSx+24XJflX0bLFr1cpYDWoyHcEjDrSiQwXcVd
         9f7FLCZr6R6OKjxvjRMdTCmtP/qstiYBYfFYeh7ZQ3FHeKPsgxkQ0/Uc20Aqbt3ZID8q
         Q7GgsmHYUx+docbJdSBNdpKXJ9cCuyTXewtreEUUdq+8VDNaKXgJFwkWFNNq6ZLa2hDs
         Powd41LkJdZ5xVJscpCUxmZ90o/SDv0XWZVhi8/GAe164Bh5ccnXR0nIZxV9n4P35+87
         dOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=z965BfpumDTFd11WWj1q3egUudyX88bWRmHmSxwIMXE=;
        b=WDdmceXNniZwEY2NysLX6pzhFiVLP3nflwH0z1P/CX1gam6hk5GIcjksoRNAONMQYF
         KnE8IRquTQDptHDqTNZycVu2Kr5SzrsQ1LqW6X2P6mkGZ/37dcGTlvjqKIbWxgTONS/E
         9inHrSfUlc6p8cZ2WgABsNjLZ8nVSzpwxMpHM0ijc2t4ttz3SqKe0e/NKQUhwSuD7zaw
         AtJ726XUGoQUYhHyhmVkQKvILqtzlZfKdwp4HP3ewM1vIJTPY8kgchS1je1xF26hNKVX
         sNndJOnfRjiQ7tjj+jXQvofRCvvXq5X0GeVNp1N+8BTfjG/cm2ZjaM1gqC8YeVaPixIc
         ZnDQ==
X-Gm-Message-State: AGRZ1gKYojn28vmsSZgJ2XQYNf8fY6Z3AubEEQ/dhDs1gG6zp52t7Aph
        WSCPGhZh1kv39pa3QjqMKhs=
X-Google-Smtp-Source: AJdET5dZ4QHmRdWXiKLTHNKdlN/gkVSfkUG27cKnaPU82qvYmpSqZA1dX9zo3r9a9+XHmXD7JmFDRg==
X-Received: by 2002:a63:c503:: with SMTP id f3mr1632306pgd.431.1541799043117;
        Fri, 09 Nov 2018 13:30:43 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w2-v6sm9510908pfn.89.2018.11.09.13.30.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 13:30:41 -0800 (PST)
Date:   Fri, 9 Nov 2018 13:30:40 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/114] 4.4.163-stable review
Message-ID: <20181109213040.GA16915@roeck-us.net>
References: <20181108215059.051093652@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 01:50:15PM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.163 release.
> There are 114 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Nov 10 21:50:28 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.4.162-116-gb63fc4e232df:

Build results:
	total: 150 pass: 150 fail: 0
Qemu test results:
	total: 262 pass: 262 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
