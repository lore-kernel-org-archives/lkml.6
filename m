Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DFEC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321E82170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yn3d060C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 321E82170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeI1ENh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:13:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36079 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbeI1ENh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:13:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id d1-v6so2903757pgo.3;
        Thu, 27 Sep 2018 14:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8DU3fQ8ps3+6ct/LX00PVrvJ8YnD9Y6c4PZXJyHM/WY=;
        b=Yn3d060Cz3nxxBGvNin/pwqLSHlDEWIlEZHW70cEXXlHHFJaNlQd/AK4nWlz9fd6mN
         9caJYsHnYRJ8JWnuWPAQbfyc8clcA3EhGpMQ2noX95sadxdeTZJ1m2Mw90ogrg1exex9
         HRrGbNZwqOGxU39cwV20UYa/zh2z32Ek3suc85y8E52VhCwpzovn+sjNGbNnG5C4RrTy
         aqSKCMUHOfMTTwb4bVMdOcTfP7QaZxek2PnzzuV6J8Jp1PEQDvR478gK2HAG3se33xvu
         SRV8LAnAe2j0aX8k1xgP2s6/RbbezJNL7vPR6Rml1O4/IMkU36yRhPPu4vHHnGL7WASc
         WBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8DU3fQ8ps3+6ct/LX00PVrvJ8YnD9Y6c4PZXJyHM/WY=;
        b=X6a3i3f2pC/6p4RrSKlIe8rMclw9Jaf4TFzLJ1SnkeAqsybmv3kG2s2mXvW48189tH
         MjIjFYA31oyZFvLX9K98eTOZ09IhxFX34Z/Vb0gbMpH1Z7iV9vvW1x9cXHzqWmn9wSCb
         u3EzzUFMD8HK7ViIpn43CuCS81yEDS6Z5fsRctYjPp3vf+xVjyzJbsJyfPsjjl15BH/Y
         CL0NxCPMp2Oy6Y9wfdBNCLLwagxUcDYiRK4mFFa+a5DiUJgKwGjkdC+KH3NR2WcEo3Qn
         BdIgWpOjWp7ikbs5B7HFDLVpwL7JOVsKm30bbJJ/I3OWAO0tUaZlW5Bc4HB0xM1SzuCa
         2xTw==
X-Gm-Message-State: ABuFfogDvOsswcsJi5y15zPdF+m/GR48+bUhGEYq4Gbfkw6rO7+HgrzJ
        9OshNmLtNZL1YD6KtzGEDyyHwAqr
X-Google-Smtp-Source: ACcGV60VVQ0rSpQivsIyiI7H/0rQmXweI4meVDz2iv7DIWTdXHjmljJq19Zqw2JnOS3/SU1FmrRqgw==
X-Received: by 2002:a17:902:64c2:: with SMTP id y2-v6mr12957984pli.35.1538085195083;
        Thu, 27 Sep 2018 14:53:15 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id s13-v6sm5189173pfj.105.2018.09.27.14.53.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 14:53:14 -0700 (PDT)
Date:   Thu, 27 Sep 2018 14:53:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.18 00/88] 4.18.11-stable review
Message-ID: <20180927215312.GA9198@roeck-us.net>
References: <20180927090300.631426620@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 11:02:41AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.18.11 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Sep 29 09:02:26 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 137 pass: 137 fail: 0
Qemu test results:
	total: 321 pass: 319 fail: 2
Failed tests: 
	arm:sabrelite:imx_v6_v7_defconfig:imx6dl-sabrelite 
	powerpc:g3beige:ppc_book3s_defconfig:nosmp:ide:rootfs

arm_sabrelite crashes in drm code. Presumably this is the same problem as
reported by others with v4.14.

powerpc:g3beige is the known problem. Patch should be available upstream
in the near future.

Details are available at https://kerneltests.org/builders/.

Guenter
