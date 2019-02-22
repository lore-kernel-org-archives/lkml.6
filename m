Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B01FC10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47FBD2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gK+WDoYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfBVXbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:31:08 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33412 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBVXbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:31:07 -0500
Received: by mail-pf1-f195.google.com with SMTP id i19so1790053pfd.0;
        Fri, 22 Feb 2019 15:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oyWnp4RRR55ZxiDzIJEui3M2anjSQKFeBhJbdwJZWAw=;
        b=gK+WDoYJWxkBP/ic09N656rwiFY5tPSJC6msjDkTZE1/LuP4RuxiG2nQNQ03yd2+ag
         ke/q4YqpkXK7TQ0KsT+lOxrpvJmiiXHc/Z/2WGb5S1sztVY+797fidFBNXVxnwBjBPqT
         gadX/0uLtIu7lVxqYg42V+xfOQ7lhLkh2iJB7dYgteEDXszTIsBDpC0WT8l1eBCK0t+3
         m7F0Vu94jz1RHQk/RRjDTRHER+rJydi3fAsgUyxq5GmrU18k3III1b8DaT6qLCbMr66I
         RjVJ9Sl25e+oybA/3gTOeXHBbDNuV+JLrFX4y4iNBxTt6gnBRMDDXw4BEzREIWwAsJDw
         6fKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=oyWnp4RRR55ZxiDzIJEui3M2anjSQKFeBhJbdwJZWAw=;
        b=KIBPHTPtK+jNjLPGGBvmhLNxPk+8NpCPdyl+Uss37CnkuXRP4s8VpcGXM+SFpsEG5v
         O+X5FJRH9n1SIwysnKgvCwyRVxLChOpThACtYVaQmrNjmHeiAimZ/gBKYxulC2nlteFH
         IeejhjiDNl9i+OcDLZnk9u7K0Msq4OyfT1C1MVoDO9bd/VI6C/6VhoxYCU+7xpk5czKy
         SllFM7GEICRMTXGxvditR9I+cLJy6is7/Xh+Y/kf+DNM65qkK9lotsiMUewdiGP97KIL
         pREQLYQL5VYYMqYfm6iMDIgOm2cTdK4J4Z1AX7l4Obuui6HYvWq5bBJLlOm6rNyex71n
         gILg==
X-Gm-Message-State: AHQUAubwraJarKR6XdZ1+utluxsLyr3Q94DA/65CZMKwsa39Da1t0OuM
        gs20MJNRKooePeyl49QxZUo=
X-Google-Smtp-Source: AHgI3IYvBHKPuoRbJL8RcbCYANvcR7MVReJq2VoinPs4K4Gwqa+Q+RuDlYN1tvwsoQ5F8ZK8ZOrmBg==
X-Received: by 2002:a62:e214:: with SMTP id a20mr6580899pfi.192.1550878267168;
        Fri, 22 Feb 2019 15:31:07 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k128sm3925753pfc.34.2019.02.22.15.31.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 15:31:06 -0800 (PST)
Date:   Fri, 22 Feb 2019 15:31:05 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/20] 4.9.160-stable review
Message-ID: <20190222233105.GC25975@roeck-us.net>
References: <20190221125242.153179182@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221125242.153179182@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 03:35:38PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.160 release.
> There are 20 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Feb 23 12:52:16 UTC 2019.
> Anything received after that time might be too late.
> 
Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 315 pass: 315 fail: 0

Guenter
