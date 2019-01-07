Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F8EC43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B102183F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVmcYUT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfAGVRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:17:53 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39264 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfAGVRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 16:17:53 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so739401pld.6;
        Mon, 07 Jan 2019 13:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XlPsn6r23XxSclxH61s3k7oJGYMlYJfuWwARzOKEY30=;
        b=rVmcYUT6BrVPARKK3AXfG0wAMzYGMUEYO0s74e58aDI/ACDp2509GjGBQzc8TDkjC5
         AyPF+gdNqGYKciynkxYIFy316IynxaWo2IgqGdfRRhcjgykrlTt1R8G2hkZnvY3actAb
         gHS4mRlPDFI75T7DCRcubYo+chMzGRqU4sKPrGzYKlborx92Hsz98K17r0Xxx4/Oc/qj
         bJBc7i5nt8fgPr1QazhzNJsHtWkHAJnd4vdF64jxtUd8DGyAF4GAYioRyPn4wUjQvW12
         CQ7fS1F4iwaCYipqEpGgruvTUTrGTqAz5YIRearPwuhd88NOafMD0yBR9meMLe1yqFfy
         uM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XlPsn6r23XxSclxH61s3k7oJGYMlYJfuWwARzOKEY30=;
        b=jskQJ0oo/F4AsTMq6md2bfl2jINYm204gZdwDy6hqhDcRjtoh+n4SUutOH6to2hdrK
         qdhocA5v/0sEUkRI+W6oLkYPfnopwybzm8Z8FEeVugzydfPgcqhLPSiyOzBbiq+w9/xe
         qqj6BM9EvFzBOWimyb1Dq8HkVKPGCV1EwGCGYUk0xd2hEvzfrKuGeGhyZUgyI56dRW+s
         YdCgJtp/Vuzwm9voImYe1CHF7gV9yUf4jyowo/FCP604YI55D98zN3PrV+b/yzhpu6vY
         ba1dvPDq1x7hWOtRKD91Q8sIlDrGaeVOX8dDQNKcF+lKruFy3pC2vu7jcob0q5iQXfh6
         6GPg==
X-Gm-Message-State: AJcUukfFKgQvliXHk3mshB7q8gTwpyS8fc1fFD3Wv8hhAoibSY61zn+K
        F0lH72RyHXFxpB211cW4PzU=
X-Google-Smtp-Source: ALg8bN7UC+waEX+z+0ZAUh8DnhMlP2ZaiY6R5Cogqi/6MN38vehfsgyydtjGuETHiS2Xvqt9wW37TA==
X-Received: by 2002:a17:902:b48b:: with SMTP id y11mr60682574plr.200.1546895872295;
        Mon, 07 Jan 2019 13:17:52 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o1sm102570318pgn.63.2019.01.07.13.17.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 13:17:51 -0800 (PST)
Date:   Mon, 7 Jan 2019 13:17:49 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.20 000/145] 4.20.1-stable review
Message-ID: <20190107211749.GA12835@roeck-us.net>
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

Build results:
	total: 158 pass: 154 fail: 4
Failed builds: 
	arm:allmodconfig 
	mips:allmodconfig 
	parisc:allmodconfig 
	xtensa:allmodconfig 
Qemu test results:
	total: 332 pass: 327 fail: 5
Failed tests: 
	mipsel64:fuloong2e_defconfig:fulong2e:rootfs
	sh:rts7751r2dplus_defconfig:nvme:rootfs 
	sh:rts7751r2dplus_defconfig:usb:rootfs 
	sh:rts7751r2dplus_defconfig:usb-hub:rootfs 
	sh:rts7751r2dplus_defconfig:usb-ohci:rootfs

---
Build errors:

ERROR: "__bad_cmpxchg" [drivers/spi/spi-bcm2835.ko] undefined!

Qemu errors:

Building mipsel64:fuloong2e_defconfig:fulong2e:rootfs ... failed
------------
Error log:
In file included from ./arch/mips/include/asm/mmzone.h:10:0,
                 from ./arch/mips/include/asm/r4kcache.h:23,
		 from arch/mips/mm/c-r4k.c:33:
./arch/mips/include/asm/mach-loongson64/mmzone.h:48:0: error: "NODE_DATA" redefined

sh images fail silently. That may be a recently introduced spurious problem.
I'll try to track that down.

Guenter
