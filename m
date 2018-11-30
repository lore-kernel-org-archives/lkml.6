Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D31C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BACD20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnAO76fH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BACD20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbeLAJhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:37:09 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33247 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLAJhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:37:08 -0500
Received: by mail-pl1-f193.google.com with SMTP id z23so3469503plo.0;
        Fri, 30 Nov 2018 14:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9e91PKNRMLKFidBS+X7Faz89jaCCS1mf0/KRxJnJv7w=;
        b=BnAO76fH2ImIM9NPGhjqMW3Uq5fufIRHo5AA/XncslwQ8TF0Yc4myBwHnoYOKAp5Iu
         ppVMbQ8bXSH7uytCow/7Mg52jaH4wyeHYD5YMbGWUysadl1m56NXptQAHtH6Z4BXEYxw
         gg8hIWPvPwpaVCn9iCoeFIiEpLj79qbvc4sG/krgDxyXxrBAH1cJn+niA6IpFGu5beXH
         fZpFwmauibS2py4QQMz2d86HHa8AaP4Zu/PQQc6brgaZqnhF/YP15vGABPSgrSL3smBW
         jJq4hAJMTKXkzgghAmaOExEjMAemwh0r3uuQe/O6kmy3HEYbjvzRFCgZQeLz/GGcuxzQ
         CZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9e91PKNRMLKFidBS+X7Faz89jaCCS1mf0/KRxJnJv7w=;
        b=r1WwjoSOeOh0/zGymgu2rD2EKJ8byptGZIwuOGZnOgQi5xGJU3o4vIiWTIIWa/D92u
         xEpicv+GC7maJdskpmQUNC0Ci2I4HP+N6wxFjchp07FbVer+ZBQ3C+uzHS5zvtEV7Kjg
         /3T+IhsiqTB7y7jXmfQ6BhnFt1wWH7QGUTMTpWOoVI05Bh4/usMuLKhRJN6Fp+JpZd61
         a6meA0/mieMizdNMa3Fp17No9KNVxuBs+sR2Sg02zQKyHQIPZ9pPEbrE6dNYYTwP2g70
         LtFwIidNkp1JrqN20IzNyetu/pQhCaNRvVgnZQ8wnroYso0Z8xMdToQ5hA6Et4bgQJuW
         uhzQ==
X-Gm-Message-State: AA+aEWZMJ3hdXFX8nJ2Kh5T0zAxHmlLjEtrSgFyQaj8JhKeyFBRei1PX
        HE2Hphz0XThW3PoWlFAfXfvJA7tH
X-Google-Smtp-Source: AFSGD/VKrwdhs178dix9995WMsDjSuQCFSndxRd25VuYMHZiLHlLLIGPWG4rDG1tdjvpJUEg/A5ZNQ==
X-Received: by 2002:a17:902:f83:: with SMTP id 3-v6mr7450520plz.254.1543616781360;
        Fri, 30 Nov 2018 14:26:21 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m198sm6979855pga.10.2018.11.30.14.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 14:26:20 -0800 (PST)
Date:   Fri, 30 Nov 2018 14:26:19 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/83] 3.18.128-stable review
Message-ID: <20181130222619.GA13361@roeck-us.net>
References: <20181129140138.002176596@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129140138.002176596@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 03:11:18PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.128 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Dec  1 14:01:23 UTC 2018.
> Anything received after that time might be too late.
> 

For v3.18.127-83-gc3953c334bf6:

Build results:
	total: 160 pass: 160 fail: 0
Qemu test results:
	total: 223 pass: 223 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
