Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B65C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1887B20892
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rz6ELrPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1887B20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbeKJFWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 00:22:35 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37480 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725758AbeKJFWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 00:22:34 -0500
Received: by mail-pf1-f193.google.com with SMTP id u13-v6so1375458pfm.4;
        Fri, 09 Nov 2018 11:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P7rvvdt4a53MXkqe0TV6Fu/JNeFWsry2tmREoRdk8gA=;
        b=rz6ELrPS6ttHdYBrnAI1sxDeVIs8RFQkwD5jXdpwjM7P/IRIewxKp6soGbcy9wMXIS
         hLb1lZz0fB6PRIVZTIZ/g6crVjiFBczmSMA/1Eq9py5ccUNwEHaJ1XWVwQ455/fpxJYp
         Tv+XuOSqXp3AJvBdkEX+ezVWcJP2sE4LKDDGILz3M6z0rKeOzoyMEFqhQ8l6WQMmlyix
         v/zfJSVHmsKNH76YgMZr0kvLGxdFnNl92qsDOH4bWlOFpiPSJuPF3srMUALsXzFLKqMB
         lNnhk70mA17H0JOdi4XrlN/ilpqRZOaUTizUCtXGLedUl6+XnfoExa8cZ1rGGc08NtxZ
         VcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=P7rvvdt4a53MXkqe0TV6Fu/JNeFWsry2tmREoRdk8gA=;
        b=FOk6CS+5tgCIl6LPo4l+V/fcZwGX6QyYy4mYsD8lnkdDlLfAScZc5LrJw3tAXx7xFt
         3DmhYKNIb+t/psW3UJeOYJc5pooLs2eszoi+QP81MbaXXvqKO+vLyRwJfda8y7rnbPvz
         05mXyY7jj05jIDA3n3qv84Z8N4dLdoilcrnPsXDyRJaOWuKJ1wDGlsYxyLEd+HBSMJxN
         zpdWARGp2HFLVTW57Nnf+jddsl372aK5lwr4CmTPRU4s8AtTW4oMCKS9SM2e3vknbxND
         i1G7DlXi87lJ/DaGQ6CStjzy6RuNiv3uk/5WKsepkEaWkob6O/SPRM7VEaaAnsyxHh0U
         p1pw==
X-Gm-Message-State: AGRZ1gKghf4Slxf3HWxi3qXxxLAa3v62zScb2GaddSdjQCE4CeTsUSkC
        r6/50WaPWeFKTB+SgdQLx5s=
X-Google-Smtp-Source: AJdET5ev+VBaGwYiTEMC6dQoVj373+3eA+QOqf30zWmZWtOAoEUDJ9NTMkbaOIWDve2WHhUnIW5JVw==
X-Received: by 2002:a63:6704:: with SMTP id b4mr8685356pgc.100.1541792433788;
        Fri, 09 Nov 2018 11:40:33 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b5-v6sm7578644pfe.60.2018.11.09.11.40.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 11:40:33 -0800 (PST)
Date:   Fri, 9 Nov 2018 11:40:32 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 000/171] 4.9.136-stable review
Message-ID: <20181109194032.GB27564@roeck-us.net>
References: <20181108215127.257643509@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 01:49:30PM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.136 release.
> There are 171 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Nov 10 21:50:40 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 150 pass: 150 fail: 0
Qemu test results:
	total: 282 pass: 282 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
