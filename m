Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45215C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9932173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qju8xDJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfBZRrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:47:39 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42424 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728801AbfBZRrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:47:39 -0500
Received: by mail-pg1-f195.google.com with SMTP id b2so6545931pgl.9;
        Tue, 26 Feb 2019 09:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fvUmyi76UexAK1Q1qfhM7ol8X8Ysrx4VvzIs26CYIvk=;
        b=qju8xDJeJ6pM4s/0RVMnEuhKQyQFcvG5rIw6IwXq46RTp4z4lr+oCOlNZhRaQTdO91
         ATP+veF/Ryft8fh20DjjcP/JDzrwyoaHxaRboDRx8Llscl88qGFKnAwYgAYBF6CpsTmD
         goRNWB/KKToXa1IrL6BjtV79/reiCn2q0Y8xF8rp34m1o9MdzobOUgtoqtnDPlq94lUk
         gm4wgcydn6XdDRAR+AUIcD4pPtbaxYGwJxby9BcQDGxX0z1xq4ojiIGZ+CyCqNqov7oN
         Su3z/wjK0ZiInm6A5f/cOoAwyVxi1aFdmiZNUiQnx/UbFZuFaP/KbbziXk3VFEpIhFwp
         CcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fvUmyi76UexAK1Q1qfhM7ol8X8Ysrx4VvzIs26CYIvk=;
        b=TGFmUsZkUKXTDUyxtpdx4+P3yX0UGwyyMd5MDKPJM/FI47ODdPh7rqxgXQx4Qs1/I3
         dKKdhuCPLgbiFVRxKHnsDb3ySU8vnN+tWx07/Mkh9y+lERu7PqOLshimiHMiG6t9E8ZL
         lhQ429ENYWXbpcibxHkwD2Pu6IFWrgyTBv7M3wwdBTklDzi38S4HQ/pYD1eLllJsC6nG
         aWCz6Ea1RX7NNfK82L4Hq8aMeEARwD8cXE0mSQtgmjVFS/5EcVEa2y1wAyQAguJx9Rce
         7QgeYZrXWBkC9EOo7Xf9D1wmWEEPEPDv24dF6hc7/wPkjo9CsTjT30+EORoWjtOZ9+cB
         qfvg==
X-Gm-Message-State: AHQUAuaLB051TlGbAEnsHogV6qyVxt1mF7K3wUaRIOtCHfY2jjDNsahr
        w9LyozaQCyKewsv/5W6A4sM=
X-Google-Smtp-Source: AHgI3IbTqSZPoGWB00FG5RZG5lxYAf4dnNME7ZaGzED4HzaoEioAnbSEib1ZMkewTJx8uVsg7yWYww==
X-Received: by 2002:a65:6149:: with SMTP id o9mr21956044pgv.315.1551203258678;
        Tue, 26 Feb 2019 09:47:38 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p34sm28202488pgb.18.2019.02.26.09.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 09:47:37 -0800 (PST)
Date:   Tue, 26 Feb 2019 09:47:36 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.20 000/183] 4.20.13-stable review
Message-ID: <20190226174736.GF8682@roeck-us.net>
References: <20190225195054.748060397@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 10:09:33PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.20.13 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 27 19:49:59 UTC 2019.
> Anything received after that time might be too late.
> 
Build results:
	total: 159 pass: 158 fail: 1
Failed builds: 
	powerpc:ppc6xx_defconfig
Qemu test results:
	total: 343 pass: 343 fail: 0

Guenter
