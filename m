Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78EBC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFA22082F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIbUetxy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731564AbfA3XOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:14:11 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43335 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbfA3XOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:14:10 -0500
Received: by mail-pf1-f195.google.com with SMTP id w73so526489pfk.10;
        Wed, 30 Jan 2019 15:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5n1+cIrWtv2S9KD3Xm+6tUPSq7KGqqGhy9S8hO6zw8w=;
        b=LIbUetxyW0GONSuLb/bsF4zpShJUDCSG7sUK6lSN5JbI8TuXR1+xfWWQifunsz8cXy
         hZMtxa3lRza/Md6rLKk/GIKtkiS6hknwGnDEPjO8iH70LsWs/1JBbkAo1q0vgw1Z8FFF
         FZJplgmm3VHEQJPufQ0M7nXbxtBXbFKwTBsRJZnRbLnkzZwDeAtswwzuVUs/PIaw9/zT
         uH7k6u72ymD8TxDdcX3pF9E+cr/dkDGcb9tI7a6WodaY2ZYT9d8psCyM1KMebTAuo6Sl
         03t3+nP1zNapRwJd6ztyfknZopAP/mpF3mbO1FuDR8fOfq0PCGBrFVYykkKHNSSCFN49
         eqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5n1+cIrWtv2S9KD3Xm+6tUPSq7KGqqGhy9S8hO6zw8w=;
        b=FOdb3Li5KkFAE5YTT3XbOeL599tLN51r3f6UebYhHsWVAvXgV3p1r5eMGMgOr1f+Ht
         8eOA1RYv2SD7WeseG++8aHWyZYfLYde92wr8+IS/X9HwTxpiwRfM6NzRYgbAz2+HR6Os
         XrsrzWH356gjfor192tKJ/hXVCwyXuoiCHUY+nXz3yc9r6Ot21nYwsroJO9Ic0xTckl5
         SG7ueNmNlO8OJ2jnsulVJyWxG0KgEGOPDtsXxX+XNcEi/i2rFLKYK/ar2Cvc6MtdX2Sw
         dPYKTnRKu8DLx9lipoSSbzgLMq6p23Xcoh9xg5461KQf55ibaAFtiyveKLf6oLoqBrXA
         X+Eg==
X-Gm-Message-State: AJcUukfK3PgjTIf5yX+L4QCaOpxc8Ha4zoJUGgGGizLli2X8cSPwuZ14
        fzh60UqFicRs3tAFWIo9qLxE/6RE
X-Google-Smtp-Source: ALg8bN54lBtNAGAJe43khZaxOAndRuQjYtei06wfBmcHa32RZ7QTkvlITyPjo4+ZEcIgRkz+rPqqGg==
X-Received: by 2002:a62:4587:: with SMTP id n7mr32000051pfi.118.1548886373792;
        Wed, 30 Jan 2019 14:12:53 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q7sm3356998pgp.40.2019.01.30.14.12.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 14:12:52 -0800 (PST)
Date:   Wed, 30 Jan 2019 14:12:51 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/44] 4.9.154-stable review
Message-ID: <20190130221251.GA26954@roeck-us.net>
References: <20190129113139.826927690@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129113139.826927690@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 12:35:55PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.154 release.
> There are 44 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jan 31 11:31:22 UTC 2019.
> Anything received after that time might be too late.
> 

For v4.9.153-43-g6674590d15d2:

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 315 pass: 315 fail: 0

Guenter
