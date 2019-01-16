Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1BBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9CF206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ev4VRuny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbfAPUgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 15:36:49 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36490 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfAPUgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 15:36:48 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so3570348plo.3;
        Wed, 16 Jan 2019 12:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ovy3jkoX1UUQS918oy6h6YJ7+tMeN60vVk3JwGmcSR8=;
        b=ev4VRuny5FphFta/RzZVPATkmq1VcJGIKfJ2f/DoSDZvcvUt2QUHnKdR+J9nH7ich/
         4kShOOWj9FKv/6MY3C25LS7uFljdFDcYvThaS9GBGW1wLf9j/Wc15aPF51oTmpulg59k
         8NW6gHL6qtPo3FEammAUFyuOKpNAdZ8nftbym9cNx/Afrk8u9wuSvVG3IuUdXIW5B4NC
         oQnsdDzs0nHCyNQsb1PrxjajJ7+Z7wS64iOnu6hdYfieL6hAzWoJ+5vLPXofXfgSaZRi
         RiZISxrh9+sBcfJLHSM42PnI/8+aeGF/2jqzYa88rcOMxiHndTIQISfzAPiRxYhN4cTi
         o50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ovy3jkoX1UUQS918oy6h6YJ7+tMeN60vVk3JwGmcSR8=;
        b=lnnRCYTrgYks5k47tKSBJ0XK0DiUJhCfKJW005zpuq1A/d1+fuafPmbcwxT4rK4kRV
         LMSzwCJWMoe/9EFUfD33wk275CwxDeyj1tydH6hDIZJ7txgKpK6++wrI7qQW2rQ1Evr2
         V/A3yn13WnOga4r7hIGa2OIQ9wuyW9g6JFwtDeB/aiWwj6Or4Es1fuj+Loegr0XUWJte
         n2QauAvG4xgdJuuLkrh2L+HdrJsygqrQfEkAikcjM6b4SIU1W5rq64HWmB+hGEtwdogJ
         rcKOyE/tYjU8kz0T7NQD7TTG8m8GbIBgKyzj+ViTM74w4izjs1hrSzcOGAmKeykF4t1V
         ho+w==
X-Gm-Message-State: AJcUukd+OfYtrmcTv4164zw0eCW9gpnMsyxNefHQM8N87h2ngURT/CGF
        /W3T9EuMtNV1cKKDw+HhD0Yx8fGz
X-Google-Smtp-Source: ALg8bN67/3xEodUZ/ua1nWb98YLjh1ERo2EiadoYVUb8RbjiY30KO/HrIoceXPhTaokAtcoNHCXrhw==
X-Received: by 2002:a17:902:9a8b:: with SMTP id w11mr11614653plp.121.1547671007792;
        Wed, 16 Jan 2019 12:36:47 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c13sm8059949pfo.121.2019.01.16.12.36.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 12:36:47 -0800 (PST)
Date:   Wed, 16 Jan 2019 12:36:45 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/51] 4.4.171-stable review
Message-ID: <20190116203645.GA1302@roeck-us.net>
References: <20190115154846.928796000@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115154846.928796000@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 05:34:56PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.171 release.
> There are 51 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jan 17 15:48:21 UTC 2019.
> Anything received after that time might be too late.
> 
Build results:
	total: 171 pass: 171 fail: 0
Qemu test results:
	total: 291 pass: 291 fail: 0

Guenter
