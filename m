Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D882BC43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D772084D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zc1pZuxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbfAHXHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 18:07:34 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37102 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbfAHXHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 18:07:34 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so2659399pfb.4;
        Tue, 08 Jan 2019 15:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pLppgP6zRS2vVztORJ7Ylvf7iS/iAoivnwwfQHAKPiM=;
        b=Zc1pZuxcsh0IuC5Q7STmqtWTRg1SZXbFwvw0ovUtCHKBXZ46EE+Ahku/8dBfAX8Rxf
         EH+PxpWL/BW2KufCU+8eEIlYINRPa0xL87oJN5q4F3HfYX+sLxYwfRrsZapPwUdp/Nd1
         l461B9Lmokc5703X1sW6e/7M63iKr/xB3BrX/vHQaZv2GCJXtkoo7sUhrRyB74sTHqPj
         vfjnsPceiRV0WRSnTsjF+GKnGZFdklfhHayjocdykIB9c1aS6DvD8ykdVnxCKKKJUfB2
         YehN86VkpOuQbPzowagQ5mKzZa88qk6rs5ItBG2l5pIPH+OcJmN3JKrtU4Pw8Fsr7Jks
         4p5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=pLppgP6zRS2vVztORJ7Ylvf7iS/iAoivnwwfQHAKPiM=;
        b=jPVbybkl+fvY9NtKCV9keR1L5h4Gz30bvAGzaNUyTWbO5LMoQr28/pFHWHrvX+D4XY
         D67heA/TVhZdZn6SGzdJEVOoAXzd3ew+u7JZEjF2OggZioRncvoNACg3eMcgvfRX3EFi
         zyJ3Kukz4ILAy60LhYFMYaMzqVazN/z7sFQBpFnXnmliwX+5BgBosZWzc5CNhJUlwcbF
         srPRg7xwk58gqo8B+h6+ouM325YfHQtb0TuK4a/W2goo07YJHuY78xlOTPxu5mcCpVgI
         HUsh2lpgbYSDc03FeiKsiIawhHozEbMa9hp/XZ1EqFLQw1YmcNeyhJRVo6V08OuZOAjB
         9SVw==
X-Gm-Message-State: AJcUukcO/vzp4Ji0OiWSFQRTqtxd+tt6wZcp/aM5u6CgKYHXBah1MIMq
        oXVvi11GulPTP4sYsXMTdgI=
X-Google-Smtp-Source: ALg8bN5g719oLTVFzbtbj1o/O+mH9/3qguekMiuauZzu8Jxhv5GazoXCpGJVRG/7sd4eKldATSr/TA==
X-Received: by 2002:a62:59c9:: with SMTP id k70mr3602676pfj.243.1546988853493;
        Tue, 08 Jan 2019 15:07:33 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m9sm82399282pgd.32.2019.01.08.15.07.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 15:07:32 -0800 (PST)
Date:   Tue, 8 Jan 2019 15:07:31 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/170] 4.19.14-stable review
Message-ID: <20190108230731.GC20519@roeck-us.net>
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

For v4.19.13-171-gc68ce175c3b8:

Build results:
	total: 155 pass: 152 fail: 3
Failed builds: 
	powerpc:ppc64e_defconfig 
	powerpc:cell_defconfig 
	powerpc:maple_defconfig 
Qemu test results:
	total: 332 pass: 319 fail: 13
Failed tests: 
	ppc64:mac99:ppc64_book3s_defconfig:nosmp:initrd 
	ppc64:mac99:ppc64_book3s_defconfig:smp:initrd 
	ppc64:mac99:ppc64_book3s_defconfig:smp:ide:rootfs 
	ppc64:mac99:ppc64_book3s_defconfig:smp:mmc:rootfs 
	ppc64:mac99:ppc64_book3s_defconfig:smp:nvme:rootfs 
	ppc64:mac99:ppc64_book3s_defconfig:smp:scsi[DC395]:rootfs 
	ppc64:mpc8544ds:ppc64_e5500_defconfig:nosmp:initrd 
	ppc64:mpc8544ds:ppc64_e5500_defconfig:smp:initrd 
	ppc64:ppce500:corenet64_smp_defconfig:e5500:initrd 
	ppc64:ppce500:corenet64_smp_defconfig:e5500:nvme:rootfs 
	ppc64:ppce500:corenet64_smp_defconfig:e5500:mmc:rootfs 
	ppc64:ppce500:corenet64_smp_defconfig:e5500:scsi[53C895A]:rootfs
	ppc64:ppce500:corenet64_smp_defconfig:e5500:sata-sii3112:rootfs

Failure as reported.

arch/powerpc/kernel/signal_64.c: In function ‘sys_rt_sigreturn’:
arch/powerpc/kernel/signal_64.c:761:21: error: ‘msr’ undeclared

Guenter
