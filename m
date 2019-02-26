Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004A1C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BDE217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJQ1vjfs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbfBZSSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:18:49 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42371 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbfBZSSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:18:49 -0500
Received: by mail-pl1-f193.google.com with SMTP id v11so1200310plg.9;
        Tue, 26 Feb 2019 10:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7Q3NakejPr9ILxbZuZ1xJvpen1pWJGhfyMkPoLSvZxY=;
        b=cJQ1vjfsT/XJRJujkEsujboeriCBoutLgzfhkwTwsTsLtscnuwG2ZXjjo5lJjveggD
         +S3ge5DWWlLl5UxngJPCRbwJg1PQecvv+NKT8ciu5wCzEI2NhFfgloeLURR2L+jwSL53
         M2CfzP1thnsr9bsGTsRsmxWFivYvDNShRyf7wTdp7JLWjdFztrUT4KYG51LPGLgbDIRi
         bwOXQKSlu0qFqx7yNhQ65A0mj6JjEQr8744YVxzVjaN3AqesmaCUtmR8CT5/r2hQBKaP
         fhCL09H1m5oq6YjxyxDK7uKvForpfI9RS7hmC/I34HgyW3B8EptNRoDJtpBo2WnULP33
         PHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=7Q3NakejPr9ILxbZuZ1xJvpen1pWJGhfyMkPoLSvZxY=;
        b=O4L0+SA0OiOtVyZnJMiPuyvcnMlprVODVhAVTk8bUaO+ab4fKxU0lT9wnDcWYWUfGH
         DUbFxoAfx/2cEb3ytvuR4Xpifh4bsvTeJhzVMUwkyFk94Pg2ip9QH2YW+X+wg5nBdMD5
         qi9Br/tRa1uyteGIYZ4AlgrCoAr90mxMFKJMoBjgGG44DsF/Q9gwb7GygtZtAMOfajUP
         /tv2O8JBGGsmGihkVZ4KbO6ArKDzqWhyrGMNNIsDnYvjqbgmrB3Jk1d8bGeE0ufrotjX
         NYW4RzUwv+O9K0YM6ptrVY1QJ6x/8Bbjz060Tz4JzgTirmVx1UxwlKyesZlEnljc5ADe
         SXXw==
X-Gm-Message-State: AHQUAuYEt3yzRTxvqZ5ujXHXfL7kCEr7pOskwhfG+mqFit3vDPBILRpg
        uLiSF4gqgLqhsE6ZEsEM9Kg=
X-Google-Smtp-Source: AHgI3IZ46TWMCh7+CLDdSyz7VJJvMqI9FFtiDy4o9E/W+bpxuXwzN17pW0Bc1GTTO1WYyX7WJGwG6A==
X-Received: by 2002:a17:902:9307:: with SMTP id bc7mr27281156plb.234.1551205128400;
        Tue, 26 Feb 2019 10:18:48 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u28sm20224974pgn.32.2019.02.26.10.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 10:18:47 -0800 (PST)
Date:   Tue, 26 Feb 2019 10:18:45 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 4.9 00/63] 4.9.161-stable review
Message-ID: <20190226181845.GA2568@roeck-us.net>
References: <20190225195035.713274200@linuxfoundation.org>
 <20190226174109.GA8682@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190226174109.GA8682@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 09:41:09AM -0800, Guenter Roeck wrote:
> On Mon, Feb 25, 2019 at 10:11:00PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.9.161 release.
> > There are 63 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Feb 27 19:50:06 UTC 2019.
> > Anything received after that time might be too late.
> > 
> Build results:
> 	total: 172 pass: 170 fail: 2
> Failed builds: 
> 	powerpc:defconfig 
> 	powerpc:ppc6xx_defconfig
> Qemu test results:
> 	total: 315 pass: 315 fail: 0
> 
> Same build error as with v4.4.y, plus:
> 
> arch/powerpc/platforms/pseries/hotplug-memory.c: In function ‘dlpar_memory’:
> arch/powerpc/platforms/pseries/hotplug-memory.c:782:9: error:
> 	‘rc’ may be used uninitialized in this function
> 
> which I completely fail to understand. It doesn't seeem to affect
> any other kernel version, and it looks like it is another compiler bug.
> I'll see if I can find out how to avoid it (other than reverting
> to an older version of gcc). Not a concern for now.
> 
The problem seems to be related to dependencies. It is addressed upstream
with commit 2b800f7c0c6c ("powerpc/cell: Drop select of MEMORY_HOTPLUG").
After this patch is applied, MEMORY_HOTPLUG is no longer enabled with
powerpc:defconfig, and the problem is no longer seen.

Copying Michael to see if there is any concern about having this patch
applied to v4.9.y.

Guenter
