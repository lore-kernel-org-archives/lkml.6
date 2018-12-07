Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054C6C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC81E20837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLz8kWiM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC81E20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbeLGXiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 18:38:12 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35988 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGXiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 18:38:12 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so2502349plo.3;
        Fri, 07 Dec 2018 15:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SiXxp0h6CEld/uvb8BvcRVxTXYK178nEP3kg12UX8Ps=;
        b=rLz8kWiMWSjiEBcZw4gk1njS+E14bGtgF3ObyMNN1hFFnkgaGEaXqQ0xx/Sg1siSo7
         an+BFrbCKp4fXJDcJVT+0kAIYFJxsffTpFA2o89I70SCsgJTnrKGDGLShMDU0hSNjg4+
         ZmKWiYjB3+CWd9ObKV5/wS8PPDnfnUv56y7hmJEZU8Jkbu1NKal5FaTB6fdw5bu+U6H1
         KEnoVPfEmH1owMsC72L7k3osgElq5gKtHA9QE8rNmcAwJJerM1Rote7yGPQh53p+6rm1
         fzoZZiKKwxGOVNTg8027fmzReF4kfB6GtJIko45I4pDDqEwqzeYpCi08dnyrenyJXpRa
         LaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SiXxp0h6CEld/uvb8BvcRVxTXYK178nEP3kg12UX8Ps=;
        b=OT2VnzVedf0sm8ITPrsO93YI+8cOQLkhkWyHwVONp3Nr++xs6k1yKh6JeacHKFA7NI
         NkDNNqoCPlhqB1IqIqB3cyE+1cOg1stogzOds3z8INbDZpo10PlEdOZm3r3PFo5BKZU3
         J290BEzTFEVO+pvSlFQnJA45OtnBvXBrdARrbHKMkOtctCahZT3eBPPslJ0+u5o5QDol
         IGJVsqk+vZofheDwgKSB8jp3tcpGWaeRLD+Im5BYd0cbMxEcWCeeZFKorCnq8zaHsH7Q
         KDswTzHwTcj74rk6YPuMiNj15Ofmd+lvCzk0j7Rm/tqZPN0sd7P8u9q1XwmPYTuBu0Q/
         rUXg==
X-Gm-Message-State: AA+aEWZcMCV9X/ZY9BF27LkrNAZ2iSKYMYXoV5y20d5p+h3wCGGRXLTD
        5Z4EWpt8M00i8I65PF93XA8=
X-Google-Smtp-Source: AFSGD/VB/LmAgi++y3m7WZw9Ue1c/+CXS1Wpera2noRTiQCTm6TywOTskvgxqrBAKRTHZiLSA0t3Iw==
X-Received: by 2002:a17:902:45:: with SMTP id 63mr3806171pla.272.1544225890754;
        Fri, 07 Dec 2018 15:38:10 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h128sm4697717pgc.15.2018.12.07.15.38.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 15:38:09 -0800 (PST)
Date:   Fri, 7 Dec 2018 15:38:08 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 000/101] 4.9.144-stable review
Message-ID: <20181207233808.GA30285@roeck-us.net>
References: <20181206143011.174892052@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 03:37:59PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.144 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Dec  8 14:29:43 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.9.143-103-g2eb2c353eec4:

Build results:
	total: 171 pass: 171 fail: 0
Qemu test results:
	total: 311 pass: 311 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
