Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333A3C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9FA20811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVSd0d60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC9FA20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbeLLSuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:50:13 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40886 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbeLLSuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:50:12 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so8738311pgp.7;
        Wed, 12 Dec 2018 10:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cjld7bIpVhWU1r2JRRnfV8a20GikQ57WXmz1iUXVang=;
        b=oVSd0d6093yeTJCIQYX3cORlrkWX14lROsno15xpMHsbd2bwN1D1llyCE+f4RASTci
         JsQ70eX+qiDEypqbx6UT6IsrMNrGuMIKPfBIaJflUOu4Z8N2Zh28kT2Nrg/hsb8VL2NK
         UqXOs+r4pc3sJtyhQRXBlIoTN2z9VNdPD4GSPI9EWqrZSWa5lHNWgBUEht4ibALCpuPa
         YPT8zADafYolBBkbcevdAPIDxRnYo6QH0tPbA9++CDLknxO/dYI2tWIj2N5P5ITQMtqr
         aCirHfraQMQwjkXlblxbmUebabOOsQCYkTYXMOmg5xUZdNftjrGPrjNhJZBAQvQZDfyj
         3kVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cjld7bIpVhWU1r2JRRnfV8a20GikQ57WXmz1iUXVang=;
        b=p5Yu1QqnJaksA938vQohhwQLQ3Wgdl3jJujYRxugxhpZ0u7E2/t8KBZvOa3bgiWIjo
         2vdpc2LN9g55KYuc/NWBagwm4jkRF+4B2jlJNrSOuSWvpOaPZ1Ak+oLM6tc86JTKESI5
         Fzl0sZY4p/I5L0vBvhmZHB5leNy/P7VC7p0UyiN+7o4eAGVtY2r+85XIkVnN5rcAmocp
         qeIB6I/FbaJxowJrH4e/p8BhFcqGpx/lgIjVy9n9YU+fI4vC9ushHGJkRWFYt2GawFFC
         d0+kt3aFe7AeW/ZSc9oNzbmPaE5vCh0IymxflbJOJ+d66g+/1p8URUXYvKOm9OyQeeQc
         FKog==
X-Gm-Message-State: AA+aEWb/RBSfi5EEg1RMH5uhzvSJa1YVHc0npTgUjJEYaoTk71GBz6rB
        qcafM768cxLtAGsaQ1FoMKDtWCAa
X-Google-Smtp-Source: AFSGD/Un1uLj4qh1Yd2v9KQyf7vyrrcj1jvMmaEWl4cNAyds+Tt5/BRQ+W8fwK04+yYwnTmbP/g4mg==
X-Received: by 2002:a63:6506:: with SMTP id z6mr733401pgb.334.1544640612221;
        Wed, 12 Dec 2018 10:50:12 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m65sm34443420pfg.180.2018.12.12.10.50.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 10:50:11 -0800 (PST)
Date:   Wed, 12 Dec 2018 10:50:10 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/67] 4.14.88-stable review
Message-ID: <20181212185010.GB21649@roeck-us.net>
References: <20181211151630.378216233@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211151630.378216233@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 04:41:00PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.88 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Dec 13 15:16:01 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 171 pass: 171 fail: 0
Qemu test results:
	total: 322 pass: 322 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
