Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01699C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD87C208A6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZjEgr+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD87C208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbeHPWpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:45:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42293 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeHPWpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:45:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id e7-v6so5139590wrs.9;
        Thu, 16 Aug 2018 12:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tcoyi07QolO4+trVn64UXqvHEnOLX+r0WiBelCAeZI8=;
        b=NZjEgr+wbIXLzYkpp06GBKMp8xu3zYUzk3pZdmRChpEQfGRb7AjLDkjqpiGl4DHIFc
         TddUUlh5O71n+iPaTzTjfrhXI8AK75wyPj7gy/jMOT6XzTPLMaUDHM4/bTEcz50boJ8x
         jUk1LSYKfCc/HOUyod7KK6550XyCdbr9UKYAZfLhxxk29e75qkk/ChTSUBNtEkoB95fb
         SiePKytz/7FbVxgzFQOw3Nc/grzeixpC2CyxPjGAVglXB6Q/1KsUFtVSMaLsKQdFLP/L
         kKpH0N6bP88y3GkD4oSFwp+zajMZtwuX6bNqMlnQLbaInvnGlAvA52vujd1kSrOObDWY
         MTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tcoyi07QolO4+trVn64UXqvHEnOLX+r0WiBelCAeZI8=;
        b=IexJwQXpWd+5Df3WlfrfcHZGx62KTz4CNZG83X3y/A5Emia6Ccmg92pympCry1tVjf
         +5TIn0WE9clwnHGNGQfEAPzk7yDja8RzaI+fmBTi0XTBtu/V4Np3rTfRq1Z0BuVeoSNt
         7s1ymopKhX1EmHWNhih/Bw69LPy7SOFovYiYjkOh8sKW57D7upn6rbhFGfNEbAWOFjKl
         oZnucEuAnhpyUrnSBeCS8dyUEveu0s2CAOoufAzAor5j6hA045JxvV8OSLQU8A9kfvRK
         WTZwHOlVP4m6unMLMaBNihWfPTIHsI+NteG2SYqbKTqin60B0so88ylG7O1JZFpinvjH
         DXSQ==
X-Gm-Message-State: AOUpUlFYogAXa2tXp4BB9DHTlEO6w8jBcY3WKrwUMz1xfdVzjOX4k7fN
        f26scabLsYmXxtIqVdjLRoo=
X-Google-Smtp-Source: AA+uWPwSSI+mEqdeJZnMWOoUa5Antapr+bgBhl5Fm0Bcn77EfS+cNyQZwG3JOpy5UC3xCMOCw7Mqaw==
X-Received: by 2002:adf:c109:: with SMTP id r9-v6mr20606925wre.233.1534448683333;
        Thu, 16 Aug 2018 12:44:43 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id x7-v6sm153079wrr.95.2018.08.16.12.44.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 12:44:42 -0700 (PDT)
Date:   Thu, 16 Aug 2018 12:44:40 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/15] 3.18.119-stable review
Message-ID: <20180816194440.GA22905@flashbox>
References: <20180816171633.546734046@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816171633.546734046@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 08:41:37PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.119 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Aug 18 17:16:20 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.119-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed onto my Pixel XL.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
