Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B70AC282CC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBFE2086C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fe+IMQ9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfBGS5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:57:34 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43391 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfBGS5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:57:34 -0500
Received: by mail-pl1-f194.google.com with SMTP id f90so109869plb.10;
        Thu, 07 Feb 2019 10:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=KrFidKrvtSRXZlUEK2zebgVMbmhIBSt2BC0t5dfIal0=;
        b=Fe+IMQ9ULUYBoLFLN/apq9VFQ7KNQwTGzkh0zPwxh1rNwgPHrZgQQqpA0qROAmJZ3r
         aUXEGcCfYmQLxphVsADcAs/M0BXW3CYB1vowwrkqBVsJVbqujYG8l/r7V5AWC4+Tk4H7
         gX5ZGcuIzQdWc/IZHsDlaJEL96cT7/fHftFebsHshqMb9RFoz4HZyxmGXzslMEyxTNm8
         inlcXsNvhca1RXlXtlD1DS1oj5gJjP/QOr/zXoQqCShqEXAITB5nqlwyFXHDwiLfa4Zh
         +kwtPmKeaqI1WNXSQFIKxywrxvbCQiap+xiF+dbPU4Bhp/+dEPKLBrdXO6S44pjvBNmA
         9Avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=KrFidKrvtSRXZlUEK2zebgVMbmhIBSt2BC0t5dfIal0=;
        b=RLIX3W6jPDPb80D7pQLlzpm0XNiQncV4u69YC18eKB7gEoa9JDOT1RpAGCUtd39mfZ
         q+jRpMWM7fpWyj3PWYGv5rfcXzx5S/zYBKfMd/dSdjhAl7HifR9B5YQTrc6bgEUtUJpk
         Zq230fxUpQHdsBzSV2ClFOM/x9foJxJC6eAZ83pbRuN6b/Z6bIuE2KBUnv5SUejfWAEO
         AZ7ExSRpOOz5utKXJbbFudGjqus29YXMcryRn/RFoDzbq4L0sMnrq3+3Focr9dMm34Yz
         MxdgfdAURWebzi8/WgTihuLi/C118yyMkndYYWcREGjkhn0R+wkrHqmKkBGsCVX0IqHf
         Uprg==
X-Gm-Message-State: AHQUAubBhg5IJ/SnBTTC8ffodwLt5JXs7yU1odr/iMklhF1m1rdoeI6i
        kfa+JnDApogqXg8vdSnBVVU=
X-Google-Smtp-Source: AHgI3IYNtJX35QHftb/MJWpjp233YEDa6+iLE073HU7prz6z1eymAQ5WJSwKkiqbh4IJ8fql+7tzaw==
X-Received: by 2002:a17:902:c23:: with SMTP id 32mr1508716pls.183.1549565853439;
        Thu, 07 Feb 2019 10:57:33 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l5sm13514773pgl.51.2019.02.07.10.57.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 10:57:32 -0800 (PST)
Date:   Thu, 7 Feb 2019 10:57:29 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/34] 4.4.174-stable review
Message-ID: <20190207185729.GA30122@roeck-us.net>
References: <20190207113025.552605181@linuxfoundation.org>
 <2780bab7-047c-33c2-e0dc-cdc0cec46400@roeck-us.net>
 <abf78f65-b3c4-de63-8d11-7d014bd1e42c@roeck-us.net>
 <20190207154653.GA7164@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190207154653.GA7164@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 04:46:53PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Feb 07, 2019 at 06:41:01AM -0800, Guenter Roeck wrote:
> > On 2/7/19 6:20 AM, Guenter Roeck wrote:
> > > On 2/7/19 3:41 AM, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 4.4.174 release.
> > > > There are 34 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Sat Feb  9 11:30:10 UTC 2019.
> > > > Anything received after that time might be too late.
> > > > 
> > > 
> > > Build results:
> > >      total: 171 pass: 170 fail: 1
> > > Failed builds:
> > >      x86_64:allyesconfig
> > > Qemu test results:
> > >      total: 291 pass: 291 fail: 0
> > > 
> > > The build failure is interesting.
> > > 
> > > Relocation offset doesn't fit in 32 bits
> > > make[3]: *** [arch/x86/boot/compressed/vmlinux.relocs] Error 1
> > > make[3]: *** Deleting file 'arch/x86/boot/compressed/vmlinux.relocs'
> > > make[3]: *** Waiting for unfinished jobs....
> > > make[2]: *** [arch/x86/boot/compressed/vmlinux] Error 2
> > > make[1]: *** [bzImage] Error 2
> > > make[1]: *** Waiting for unfinished jobs....
> > > make: *** [sub-make] Error 2
> > > 
> > > Unfortunately it doesn't tell me _which_ relocation doesn't fit.
> > > 
> > > I may have to revert to an older compiler. Wouldn't be the first time.
> > > Let me try...
> > > 
> > 
> > Confirmed. This builds fine with gcc-6.5.0 and binutils 2.26.1. Sigh :-(.
> 
> That's really really odd :(
> 
> Let me try this, I only normally build allmodconfig.
> 
Don't bother. I reverted to gcc 6.3.0, where it builds fine.

Matching compiler versions to kernel releases is always challenging.
This isn't the only case where I can not use the latest version 
of gcc.

Guenter
