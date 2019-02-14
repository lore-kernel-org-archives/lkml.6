Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297D4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD7F21B68
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmhlTyAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405816AbfBNTRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:17:40 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41915 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405761AbfBNTRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:17:39 -0500
Received: by mail-pf1-f193.google.com with SMTP id b7so3566719pfi.8;
        Thu, 14 Feb 2019 11:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f2xsyUO7hJs9Xy2CBH0Kg+L+a/BFDFTYQC8R+tXpX0k=;
        b=LmhlTyAmC4AxmIEj2863fQ7x8HwUQNt2SZR1/lEgQ7GzingNsMLdJ8CaSUcA8y2Up6
         cJWXYrT9e2YBK/fAV8t+krSjD3zIFLSbeIX9gnego/KaGnxsXT9zfbx8gqx/sf1LW+AJ
         ZPAGnx+58ddyMTM6Fv9oPOY9jcZlToKmnJEt10iQH9NExp+Hyxppovesfc4mUFlBYmCG
         0fUgSjsT+80QEx6D5l2uybdVUxr3Bo2VQ9WOKptjvMFzjw13rBKsKT2ULfNlsjXrUXGK
         gMiqKS9GtIMkxcUM2LC1y0RliLS9Avf60HPpad5Zfl4DnN22Rk6Oq7gY9uxvIteFMfcq
         BpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=f2xsyUO7hJs9Xy2CBH0Kg+L+a/BFDFTYQC8R+tXpX0k=;
        b=RvjPACGzkLE/o7l8K7A6Cduw9NvktpFvny0rSn68x2mpLTZWhXxwqqTEVMER5JrdwT
         CXoGU3ZH4cQFeXuL8apvXFt+uVkpljMfkCNqAxC6p+FBwiz174BGClOADEDjM+GTUhDA
         MaUqeVX0fcQx1l3FszI91Ly2pwLY3uBcPdzdKRLj4fGkJrfvFvJa8XDfbDqELBPZr/zv
         16Y//nPCYJ9cMAxJs2BFA1Y+7ejSYINMwJaaW3gziu5tm8e15iToPWQWVwB3ryqjjc21
         SGS4fb72OFfR35uGuehgYOvewBbcpWBuQu6BtSXCXAc5lghCy6PCDUUMACky8xf1I0YY
         93eA==
X-Gm-Message-State: AHQUAuYEBixk1MK/JSPPKyaZBMtAQUR39LrGisXL3v6C5cXKc/vfeu+q
        X3kB/XImhqye/5K1LwC0fKM=
X-Google-Smtp-Source: AHgI3IaVPJ1fBGvnC02sROupXzFOl1zuIAhiTa4yp7YR8RK5fT3sikizK5nomE5FPCYWtx7N0XztcQ==
X-Received: by 2002:a63:5962:: with SMTP id j34mr1428156pgm.297.1550171859091;
        Thu, 14 Feb 2019 11:17:39 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f20sm3807629pfn.177.2019.02.14.11.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 11:17:38 -0800 (PST)
Date:   Thu, 14 Feb 2019 11:17:37 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/44] 4.19.22-stable review
Message-ID: <20190214191737.GC29429@roeck-us.net>
References: <20190213183651.648060257@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213183651.648060257@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 07:38:01PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.22 release.
> There are 44 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Feb 15 18:36:28 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 156 pass: 156 fail: 0
Qemu test results:
	total: 343 pass: 343 fail: 0

Guenter
