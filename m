Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27928C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEDC0206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYyGvonp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfAHRZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:25:08 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43973 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbfAHRZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:25:06 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so2007246pgk.10;
        Tue, 08 Jan 2019 09:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=k2DECF9Z1/RbZZyvwYEcnyrofLE6V58SwNDftQ2UV2E=;
        b=EYyGvonp63Y4b4GIlZxsVbphB1WRsZLfi740SVzfKB9eRPUYj5lRLruK10Kbvg/U93
         TQp34L10EiAvmbsux0U5b2dumPt8VrGuJ6EBY/pKr6kclzys+II0R6Ch+lE3oUEREYgm
         HFXRCGGIr8cSpbCyZdHL/UUyIhXtdrkwHUL6Y6RiGYl+DnAVT/tgPhqjAYNmoguqnpo3
         sYOZTCw14jmoPq6wJ66SSf5Fx8FyaJs50RkaYaUIfpHHdMU5LsLB5eJcpqNFZ79Ea35h
         wOTGLeAd3YjxT1j4ltikzMHZL8ywFwUa66aaaHpV+a0r3XvMB742BdfN68aqdyA98nZn
         QOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=k2DECF9Z1/RbZZyvwYEcnyrofLE6V58SwNDftQ2UV2E=;
        b=U+5niO1WF1WqkRy03XkzFa02kMhrZRtJw7MlEZwmx/yKbSXXMsMAhNnlu7w7OK9W0B
         voBC/tTw0RKgV4pEi3QOkVQCsL87gpCi/dPcc0LUEdEUw/Sh0r+NjNW3xUd5XdYPJVX+
         wJFaYAA2AP6jk28xY6x6wk9waRStxn5NjVIYRpFxO2lPZKNkIjc+ssXXtZZbAaSPg5W3
         8Vd6oA5F0dfqE/dLr7kMtbcLZJUldRRzVf9tcSmlmm9i1/I0deZ9IG2zngvDgK6+vEui
         9bWx9beoO934lT0NoGB/QV3MjdrUeDwhaZGPjsVxMCd80EbzeI//Q8du+nWbxjrnlcII
         3rjw==
X-Gm-Message-State: AJcUukdFf3ukG/olQZS13LvEtKf0cn3l+vTVtT4oUNk9RhEnRei/Kdq8
        vk4PCsDYb6SfHNzB/DkcFJY=
X-Google-Smtp-Source: ALg8bN6p2ORy8G6EigXohPGYRPVOU0HrEvxIG7eltRpbvY2y5HPUsg/v950AALRpxmx7X6U3yS+A5A==
X-Received: by 2002:a63:441e:: with SMTP id r30mr77407pga.128.1546968305584;
        Tue, 08 Jan 2019 09:25:05 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r187sm222910479pfc.63.2019.01.08.09.25.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 09:25:04 -0800 (PST)
Date:   Tue, 8 Jan 2019 09:25:03 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/170] 4.19.14-stable review
Message-ID: <20190108172503.GA28031@roeck-us.net>
References: <20190107104452.953560660@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 01:30:27PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.14 release.
> There are 170 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jan  9 10:43:54 UTC 2019.
> Anything received after that time might be too late.
> 

Still (for v4.19.13-171-gc68ce175c3b8):

arch/powerpc/kernel/signal_64.c: In function ‘sys_rt_sigreturn’:
arch/powerpc/kernel/signal_64.c:761:21: error: ‘msr’ undeclared 

AFAICS commit 5c784c8414fba ("powerpc/tm: Remove msr_tm_active()") is missing.

Guenter
