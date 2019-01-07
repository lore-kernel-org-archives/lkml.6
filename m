Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEBEC43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4212085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehBq5HmW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfAGSFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:05:49 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40429 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfAGSFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:05:48 -0500
Received: by mail-pl1-f195.google.com with SMTP id u18so502121plq.7;
        Mon, 07 Jan 2019 10:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ftlP/iE14vHWbUXNY93njplRwF0KrdtXTkO0PGd/2/E=;
        b=ehBq5HmWgV5W0O/V7d3ep1MigUlmciVfQppCrO5wTQLG4XL/fHL2th1MTm95bQPvUA
         vUTJPoL1zvDXEUR9aKIjA5xWyuvYLXpbi5heF6gvQ4MBh4owBOqdZHyWzeuuCCQkiPGL
         GmKxQ6SbRMLJrquBOxnqetfmYZlln1UAAc1awhsY+KDgpuY/aUWx+kiEpOXUMUxr4P0M
         xhw0ljcTIzl3vRY9nC3BbwC39yoDlF4atslJXRTZb/ytYeEOIHlw5WmsVgOX0Qz2oy92
         Kw3bMfAKAfSFXkGTg9lE7O9wQwdwfpV4bPs6RjlstRdchipxozk3eY/4UeoqstJvyEA7
         LABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ftlP/iE14vHWbUXNY93njplRwF0KrdtXTkO0PGd/2/E=;
        b=IR8T9PpZGIbe5pZhevHW+jOHNXmaE+FfCZuOJW0iTQJGX8zbxpQckg9xCstzJWjvQC
         67EhPWiQbGd43pLsEZdJ2+9Wf69Aw7xK8eYBdKRaY2eheZ7F5ECk6QcQ4os7oeCDMpRa
         K7h/QZdeoBL4MbGFLqhlnMKO6sDSOH1Q9sQvDRUA2ea68CUrwwyVXX2yFfiyMqBbH4P3
         Md3H1VkRn0X4a4b7sMHdT2BMkGm/d32yoBHg3QVlBqhC0hXMPHb3hh9rdUZH5Ah66iTB
         kUf4PoXqJxz/Tn2LjGPpfAOg+eux0aLLVuBLPHaLjv1+9J3jtAcNMWz1PTwbesgwm7nS
         PAnQ==
X-Gm-Message-State: AJcUukcStacN1zCKGP12XYX65h6TSQG03jzva0qA9f1EKpWnZ3/o7RVS
        xgw/aJnrG+MvkWGFrTsBjLU=
X-Google-Smtp-Source: ALg8bN5AZ2IkXVx0NKOVhpib6zw4+GK9PbpEOYdzzaEZWyCHWEWg1/O2IbtOMIo8PH+4mrGvyEzbhA==
X-Received: by 2002:a17:902:7581:: with SMTP id j1mr2020769pll.308.1546884347851;
        Mon, 07 Jan 2019 10:05:47 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w88sm116302399pfk.11.2019.01.07.10.05.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 10:05:47 -0800 (PST)
Date:   Mon, 7 Jan 2019 10:05:46 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.20 000/145] 4.20.1-stable review
Message-ID: <20190107180546.GB11134@roeck-us.net>
References: <20190107104437.308206189@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 01:30:37PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.20.1 release.
> There are 145 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jan  9 10:43:39 UTC 2019.
> Anything received after that time might be too late.
> 

[ partial results, qemu tests incomplete ]

Build results:
	total: 158 pass: 154 fail: 4
Failed builds: 
	arm:allmodconfig 
	mips:allmodconfig 
	parisc:allmodconfig 
	xtensa:allmodconfig 
Qemu test results:
	total: 332 pass: 331 fail: 1
Failed tests: 
	mipsel64:fuloong2e_defconfig:fulong2e:rootfs

For the allmodconfig builds:

ERROR: "__bad_cmpxchg" [drivers/spi/spi-bcm2835.ko] undefined!

Qemu/mips64:

Building mipsel64:fuloong2e_defconfig:fulong2e:rootfs ... failed
------------
Error log:
In file included from ./arch/mips/include/asm/mmzone.h:10:0,
                 from ./arch/mips/include/asm/r4kcache.h:23,
		 from arch/mips/mm/c-r4k.c:33:
./arch/mips/include/asm/mach-loongson64/mmzone.h:48:0: error: "NODE_DATA" redefined 

Guenter
