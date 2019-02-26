Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D16C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC892173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBujiMqN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfBZRqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:46:50 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40015 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfBZRqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:46:49 -0500
Received: by mail-pg1-f195.google.com with SMTP id u9so6549197pgo.7;
        Tue, 26 Feb 2019 09:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jil8x2G8wTr/zfa3snLMAWOX16KxW5NDXpSRbYDm7os=;
        b=eBujiMqNFoLIuSkkA6W/YYJ2NV0/hHGANeUX+Aj1zoG5W+fC26u6jh6MdGWS8FJqvp
         kjorEaRR0BUk3ktw5mSD9Fc7opHCV+CcVTrgvfRfYYJKI9+NLyhYMCu2byRTlu0yyiFY
         vB7fhrdlNqmnLtT5HBTL2nKOvkiPXHQwsGCX/uPm48G5iKtSYUmo40i4ZnVhD25wYhXL
         HgU+Q1REuSYWRgK5d6VvX0idac2pX7Y6/OBfk+DDal2a84b1ET3SBpVk5Wh/+v7S6/Y3
         HY32vfX7hM1Zghb46YLH1jzCp7cJrz6pB7i3LK7Dh8wOZw4w5TPSF7qhusEW79upzYV7
         IF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jil8x2G8wTr/zfa3snLMAWOX16KxW5NDXpSRbYDm7os=;
        b=LSBTTBzJh1AJlwmpNvFvb2RfU5h6Ddaf5jUz+9grjansD6zPciQImJCBEMCabBC+js
         raQtspOx2btWLlxXg7nv3Yy7KvUzoMGQ405p8G9GYGZVuqSRZgjOsiBUL3ZcaWKlSSje
         g5781kxak9+LimCwPg6A0i/Lzr1GDPAfM4cyolwLYHfBtAz7cztA9QcLBWyv37ChdxxQ
         SjwBdOsJC7zcFdIOsq38kvy2Xqkudxjys4hDGvERrJXcgKWkd9IC8Y8lhUExJlH5IDbd
         KMjutGaUWTDSoLDd1PhpeI+dC4TYSFSAhZl7hViYNQ2qtw99wLIt55KSgtiTJAlXhA2n
         RyNA==
X-Gm-Message-State: AHQUAuaWUlu/bRJR1dtTWq6giZqw/bfjkZG1hrEGkVsMNFVefkZpBLhi
        C4HkmDn7Ylr1NiNR2hbOYmM=
X-Google-Smtp-Source: AHgI3Ib+/NZk/732rgRFhYncAQH0z4Kyyp9Hu9ZNbBgs96joQ00HX1NYbpyFMSdq9h6HHf1ds6qrNQ==
X-Received: by 2002:a63:d64:: with SMTP id 36mr5493717pgn.360.1551203209228;
        Tue, 26 Feb 2019 09:46:49 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c18sm4242898pfo.44.2019.02.26.09.46.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 09:46:48 -0800 (PST)
Date:   Tue, 26 Feb 2019 09:46:47 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/71] 4.14.104-stable review
Message-ID: <20190226174647.GD8682@roeck-us.net>
References: <20190225195034.555044862@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225195034.555044862@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 10:11:02PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.104 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 27 19:50:01 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 171 fail: 1
Failed builds: 
	powerpc:ppc6xx_defconfig
Qemu test results:
	total: 328 pass: 328 fail: 0

Same gcc related problem as reported with v4.4.y and v4.9.y; no concerns.

Guenter
