Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB50C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5841A20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3GL/V/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfBDVtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:49:36 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33514 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfBDVtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 16:49:35 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so528374pgu.0;
        Mon, 04 Feb 2019 13:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nAed5r2P6/zjuNmvcC7NpGrw/3YGxZaCg8p/56m0TzE=;
        b=c3GL/V/p9UvH+RYP9Xr7JVRbswvk626gT3ieHIhYMIhRWGeDCikygcbFO1h/r2X2ka
         L63KqYhEkOJBzxxkymKVGMC6+GzNNDK5SzsMNpOF5QGuacZ3MXYrhUBYrdlgWUXLyRIC
         5TvJYs8liupGWhOY2qu5n+BWg/yVfgI5wIHv8fDli70xpMrAdXCp8DJro2nXfyrt9z48
         74Dyqj2YT8+IcrMY/4GajM94HpjrnxSo1xhee7hCrUcr6ySS3XE/4e76f2yui29XKqOw
         TUhbSQ8K4ki4mCqq7J8fvU1wA0g99gfu/o2KUf7cj8ouPGOYuULiydyp4Q2aZckuh26n
         4aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nAed5r2P6/zjuNmvcC7NpGrw/3YGxZaCg8p/56m0TzE=;
        b=OadYeWRxB+UB0ahBiULtINW8UCkDRwGb/Lbw8jnkaw/LjFnvxN8wmBFX/aJBLdLdFW
         AffvOqs/B+HYt/I4+TvDBMg6k7Wiu8vgwJsgZRbJc3Dz3MvBzOHH26aVUPNaQkPqmQd7
         M+7jmKWm+YwgtHWV4JcNmNFXZMR2hmtqmbdkjt9LnvduI5ALxWQ4Pbnckc12rWnJbApO
         8GErtAOCO4fYXx+puL3DDSJlGmIFLH11YkDxdvCBxjXOyn2N1zEXL/0g/ZJ0dL72R3FJ
         H9xPG72Z5UJ9boyc7xNsKPLmIOym7vRW+OtpWcqqkZ4mzz7+khja47aHL+GyUJkRTSMi
         FBbQ==
X-Gm-Message-State: AHQUAuZ6KMR+NlwPjqMwizuYo14ZZSeMecdWQQr8I4c38K/scYKM00KT
        F0jrT7/2wLYtq6xeGmaMYYI=
X-Google-Smtp-Source: AHgI3IYzTr7h6ivTge/7RH29NS96jJtJwEknSONHfTE/K9j/WWftCGksWJnG1d2WSYEuHrJ8uFHDEw==
X-Received: by 2002:a62:5dd1:: with SMTP id n78mr1507105pfj.58.1549316974705;
        Mon, 04 Feb 2019 13:49:34 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a17sm1157172pgm.26.2019.02.04.13.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 13:49:34 -0800 (PST)
Date:   Mon, 4 Feb 2019 13:49:33 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/74] 4.19.20-stable review
Message-ID: <20190204214933.GE18895@roeck-us.net>
References: <20190204103619.714714157@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 11:36:13AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.20 release.
> There are 74 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb  6 10:35:34 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 156 pass: 156 fail: 0
Qemu test results:
	total: 343 pass: 343 fail: 0

Guenter
