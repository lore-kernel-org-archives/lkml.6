Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5020FC282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A59520823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJnyHaEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfBDVtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:49:14 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46162 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbfBDVtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 16:49:14 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so496961pgp.13;
        Mon, 04 Feb 2019 13:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jlnTCNdjHiWqH1N4Bff3N4l3ovk0E1U1xsZfHAb1huk=;
        b=vJnyHaEswfro4umZqgNLKvhMvumZf53nxvXzzS1mqCqigYu0F9Lw2mk4B6cCengw6j
         JX/Zr2zdKG1zHKkGIIC+IKFr2vCj7VVWHkFoBhjQEyoOnpxdSYj4xdK/GVWbG8PK1I0u
         zFV2o0XWoFyIhBQbP77z4qNqLUpf4P4UCjnYdHr5I9PZZ6Kqe/V1U7ybwzJfkLyXsp0Y
         o2PHgMi5c3HbS3f79zFPIqxhF+wKQkU4hxvVMiInpjsnzkqOFqVusAD6meuPTTpMXq5m
         aaQEEkuKpvXwq7D+CfMf+8p2V7UX3OcmIlkMwhVLDHJG1amqxjXDONFyZu96XV9DflBq
         Y5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jlnTCNdjHiWqH1N4Bff3N4l3ovk0E1U1xsZfHAb1huk=;
        b=cdllDkXQ8G0lC+WfzQ8e/OsZG8QT/erXqpZcYkGBGJC0SatgAXUb63IMYNi8mNGzlT
         Z5q/9p/JQZkFahz8c+e6JCaRdzU30vJ/OYP9VFiTxtOd5B6zNjM96bLWAjSMkJlsOKvY
         JOVudVmi4s4NiAEVzEzzgJIsuBJXlILEinB24e7i0PdMz8bKQmBgyU6Gb2Ekb3hZstwt
         F+etyayDX/UhKgnMJHtfhdlYnf933HgrFJCiZUM6RJw+3HitYp10LN+QTxxnfMYJlmsB
         JH4yL4JktCYtS9mZn+9fmP9WxxwEvF896xBiqZ9NAQId768tQFzmvArdC3tFDVCTu7Wm
         CQ4Q==
X-Gm-Message-State: AHQUAuYaMTm7ecnv2gitCn9PNyqZqlC5wWkbRX/HSSc22/8XaoB72vD3
        wInso1NZUlOswq4sWOhFPlE=
X-Google-Smtp-Source: AHgI3IYeLX1vBhSPU+NgGr5VJqSeQ3nbpdyFEeNSEkcOC0Kgx8pYQd0ITFjgIG94HUowSHoShHOi/w==
X-Received: by 2002:a63:4611:: with SMTP id t17mr1374078pga.119.1549316953500;
        Mon, 04 Feb 2019 13:49:13 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f6sm1306952pfg.188.2019.02.04.13.49.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 13:49:12 -0800 (PST)
Date:   Mon, 4 Feb 2019 13:49:12 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/46] 4.14.98-stable review
Message-ID: <20190204214912.GD18895@roeck-us.net>
References: <20190204103608.651205056@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204103608.651205056@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 11:36:31AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.98 release.
> There are 46 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb  6 10:35:31 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 328 pass: 328 fail: 0

Guenter
