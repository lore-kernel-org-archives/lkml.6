Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F10EC43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CED5214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2imSKPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbfAHXFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 18:05:11 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:47059 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbfAHXFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 18:05:10 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so2626150pfe.13;
        Tue, 08 Jan 2019 15:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DU6YXgpJA2UqPDNob0/gv6gT/+P6KHZXMw7cnVkgZ0Q=;
        b=i2imSKPjmzKP6DpILMidjQvD4cqXrFBsX1XE8KCLwcbpgSF/g9fT7AtWQPzVYtao1b
         MXGbnSOr1i9oJ5BOIGt3B4E0SC0aTdWJxh1nmGtt9qXU6wBaMOkKj5WW52WnPohCO03t
         kmPnrjv68xwXRtpJuiCJWk0RY9LRD+7HDGMTIyU9eDxMLOJWf2sWlxzgEZ/rx2vuaO8m
         PEFXwHZRmyW6bK4YTlLD7mALhVFjth7XtKF5Z/zEwq1yM90vH6UVdApC6w6mYsFblVTG
         Vwbimx9CcY5zG3p6ABO0QfNK247jeu/aUtqiLFr9ndXZXldX/XOJ8E+NkRW+T1dTdyw6
         D40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DU6YXgpJA2UqPDNob0/gv6gT/+P6KHZXMw7cnVkgZ0Q=;
        b=CkOzDnsYnFwP/NvQ+QvfsrboVTj4GAGq2wBBmZXARXdH8wjQzyI5p3G8XyH8vG90CJ
         Eum6GybtqB4rlqeMUmYdznS4Bc6+hkLScxILk2cx2knvpVM2b0ebIfGCA/oJj34s0os2
         /r0RUKWk0dLZdgnYqaoxYlykzW2neDurKtRfcicAsbu9u/P/pHk3eYNWDsWz128+YQkc
         56bQGLLKMhmPY5R04sDDT0OCq5NsW1Ofi1gce+KmTtXoOiUCoY88BYtiMtyBztKTpOwV
         /xaSo6LDpUZ0WdeHX0h1FJ6U5oOk76p7itWav5EIhTbbKfwzBswmPVNewniBujf17Gp6
         jt2A==
X-Gm-Message-State: AJcUukc//2a4UKZKNGFRuV0Umg5FbkS6jR7wZ6wFOphzamRxdzLC7D0O
        lgK49ZdKJyVruHMKcjnqkEw=
X-Google-Smtp-Source: ALg8bN51SX2LecHKP1R37q3PFUpK/d9CvKg3Y5dASYUXk6mz2yi6ifexWkTzS6BuORTtwO0+Z5TS1Q==
X-Received: by 2002:a62:7086:: with SMTP id l128mr3606173pfc.68.1546988710159;
        Tue, 08 Jan 2019 15:05:10 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r80sm118528447pfa.111.2019.01.08.15.05.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 15:05:09 -0800 (PST)
Date:   Tue, 8 Jan 2019 15:05:08 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/71] 4.9.149-stable review
Message-ID: <20190108230508.GA20519@roeck-us.net>
References: <20190107105330.280153213@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107105330.280153213@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 01:32:29PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.149 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jan  9 10:53:04 UTC 2019.
> Anything received after that time might be too late.
> 

For v4.9.148-68-g8af94cd8ec70:

Build results:
	total: 171 pass: 171 fail: 0
Qemu test results:
	total: 305 pass: 305 fail: 0

Guenter
