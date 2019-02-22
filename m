Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8753DC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE062070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nk+WC92N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfBVXcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:32:21 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38505 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBVXcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:32:21 -0500
Received: by mail-pg1-f195.google.com with SMTP id m2so1794762pgl.5;
        Fri, 22 Feb 2019 15:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AgsfVdP2g0RvEUIDcFVAqWHGWD+bpi1fUR1vyI5Vo+o=;
        b=Nk+WC92NnXCsIp/81qehtbWGG+rlkTzp3SBUYhYZgFcvye1wjKou65atD0IYwL3q1L
         u3cqLTlcRrH1lcHlTaDdyDqS460xC/GyuaG47ONaSG4CgtGCleYLKhGkSsuHoQhfT76V
         5DOiNi4XfAXB3nAepM5TGOMtMOGFIB8f/AuRX0HBMhKeyfIOU1EpD6LYhqFr4yWUpNMQ
         XvIjhu2hRcU321BbKiP9QGpt9GCkXEdSrYZ66JGqG+FBd0AmWcfNvEOB0AbG2TR6UYBR
         fi1+vCsWYR0xM8dr48AO83q1szfaXNn9sAMEnH9BfGsaQdqnEQ4ROZH2G5rgxSQ/WxPA
         ByLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AgsfVdP2g0RvEUIDcFVAqWHGWD+bpi1fUR1vyI5Vo+o=;
        b=aNav3jhYJGSNLnpvUveFETafruUtlxlnOh+ST1d7fL8uCqoDC4a6B5O1Lx13gzYIKG
         n8mua19XfaytlcbeaB3OwJthHrzNbP331xaFMwSEDYnoZY9GKoOoKgDtM7Im9wdkzQC1
         p6nr1vXGoCG6JSd+JClWUQJNcsnm4xv8lMNXdMiF7nGxQRe7Y1X4UPhBrWCV6QT3rClW
         RZ2zLIHJ5yCaWKAo5lvlpXlr1WE/gTG8FQXQhTg7Ww7xgjK+YsKyqvGaPpQ4tl8MxkXc
         bJtImURYI9W88ANx1jwH8dQhrOKLbmiLxVc8OfFIcw891Wetmvkj0YmSvzhW+apbeDbi
         U24g==
X-Gm-Message-State: AHQUAuaThztvgBpL2Upt9BIaaBtq4gajmPIsB7QeLuyfsZXi9jeoHsjL
        mSXy45mnFmEfVSCvAJywu30=
X-Google-Smtp-Source: AHgI3Ib7gs9rMiij8M64mIKRjcU9/nVXw1PLrOy3x+CLHweuzQDpaxGTx4BEFybxD6FuZaGUeTQjJw==
X-Received: by 2002:a65:40c5:: with SMTP id u5mr6258559pgp.275.1550878340768;
        Fri, 22 Feb 2019 15:32:20 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p6sm3906248pfp.15.2019.02.22.15.32.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 15:32:20 -0800 (PST)
Date:   Fri, 22 Feb 2019 15:32:19 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.20 00/32] 4.20.12-stable review
Message-ID: <20190222233219.GF25975@roeck-us.net>
References: <20190221125250.855065214@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221125250.855065214@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 03:35:48PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.20.12 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Feb 23 12:52:26 UTC 2019.
> Anything received after that time might be too late.
> 
Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 343 pass: 343 fail: 0

Guenter
