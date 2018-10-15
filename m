Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279B3C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC58B208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlTWK/Bd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC58B208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbeJPDZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 23:25:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38025 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbeJPDZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 23:25:56 -0400
Received: by mail-pg1-f194.google.com with SMTP id f8-v6so9642128pgq.5;
        Mon, 15 Oct 2018 12:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qt1jXD7vfnfj8dmCX1h/qLhs3nEov44MG+ws6vTvbjs=;
        b=BlTWK/BdSaND+ARMyzpBNfGd439wN0Smm6nJ19KBL9DWR+4+fPwNveBbhzX483aBTH
         4VIYDyP8S1vQ6slO8VyCveLOqHhLFcmfcl0eCvRNK5/UivzebPrMXTnpuUYD7VNdPjaO
         Zs+dajnUVg7d55T8OSj4dAzpcI9QVQc6L+lPIXQoGM61RrWj+M3pHC3wDX+oP2+PIIWl
         8O5zFb05lm796ASoL0jg2WjsDCLVSkpSzBy8pUbgpKvEe+uExzmhSrLK9CveUHnD1ZO2
         j7Yxrgz8UuH+VvEKzT7pQHCB/inIbTByiD190grQXgNLI//D/RKjkzCn9sghoVP1JD0S
         hH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qt1jXD7vfnfj8dmCX1h/qLhs3nEov44MG+ws6vTvbjs=;
        b=sdoBKyK02xM5xpoXt0OTWgcIDAFXL3ydhgJ90DCRkehKrEwOR0VlHkfxC56gchFk0I
         sU2Lgombqi/jVtjsEbLnLnW4012Fye88jyuIDI5TFahKhgvfYKN65h+1TSfwaSDeCV6c
         ER7jaM6hPdXN4L3erGskAPempYOCLSFdk0vDKSXt+YwlyCuSUwdf9zduQmnisLoiSmla
         wteA3ncaGqD2gC/ykKbc9VOSvMM9i9B0Mv8asT8Txy6MQxhJ5asBRRWNuWiTK4ATcWuh
         RQy7k6EcFZoew6G2pw90YiAPoJzlHkrvwVjqEcGPJTlB/J6+pDtNr4g5Xo0kJnwih+ni
         nYIg==
X-Gm-Message-State: ABuFfogDTBJt/SwB//9fKgM+Ug3qzQI4UjgAqOeafhBTd0XBHnrZdgdo
        M7CL5/5o50H2U/8zaw/mpurotLyu
X-Google-Smtp-Source: ACcGV60idkpmrSUiAJgsMG+67LZ5brxONgs4pbj73tngYLSQQQoSYCQl+nd5QvYTPtWP3HW9XS82lw==
X-Received: by 2002:a62:241a:: with SMTP id r26-v6mr14399277pfj.74.1539632356806;
        Mon, 15 Oct 2018 12:39:16 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r65-v6sm15486901pfj.5.2018.10.15.12.39.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 12:39:15 -0700 (PDT)
Date:   Mon, 15 Oct 2018 12:39:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: linux-next: Tree for Oct 15
Message-ID: <20181015193914.GA9881@roeck-us.net>
References: <20181015192546.15faf3a1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015192546.15faf3a1@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 07:25:46PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20181012:
> 
> My qemu boots of a powerpc pseries_le_defconfig kernel failed today.
> 

Bisect log:

# bad: [774ea0551a2966c8fc29a6f675c3e28c5c6fa586] Add linux-next specific files for 20181012
# good: [0238df646e6224016a45505d2c111a24669ebe21] Linux 4.19-rc7
git bisect start 'HEAD' 'v4.19-rc7'
# good: [dfbf78faefa3c26d94208398e62bf25ea798e7f2] Merge remote-tracking branch 'spi-nor/spi-nor/next'
git bisect good dfbf78faefa3c26d94208398e62bf25ea798e7f2
# good: [3f296bb430327676912966c56d2f078f74e6b4ab] Merge remote-tracking branch 'tip/auto-latest'
git bisect good 3f296bb430327676912966c56d2f078f74e6b4ab
# good: [056ff0c45d1780f7bac1b54bd4160647efc500ad] Merge remote-tracking branch 'staging/staging-next'
git bisect good 056ff0c45d1780f7bac1b54bd4160647efc500ad
# good: [d7946b50c21a7d88af6c8e88d976ba3dfca651cc] Merge remote-tracking branch 'pinctrl/for-next'
git bisect good d7946b50c21a7d88af6c8e88d976ba3dfca651cc
# good: [72b5ca3121d5352fbb8fe3e1abaa86748205c0cb] Merge remote-tracking branch 'xarray/xarray'
git bisect good 72b5ca3121d5352fbb8fe3e1abaa86748205c0cb
# good: [e3895cf23a25da6dea2c8e986d4f6c24fafe5448] hugetlb: introduce generic version of prepare_hugepage_range
git bisect good e3895cf23a25da6dea2c8e986d4f6c24fafe5448
# good: [627f8833ac26e66d4b50676a0251499474bb4ee4] reiserfs: propagate errors from fill_with_dentries() properly
git bisect good 627f8833ac26e66d4b50676a0251499474bb4ee4
# good: [e38910adf47ba1d0b5a5a573cc26bde1ec533147] memblock: replace alloc_bootmem_pages_node with memblock_alloc_node
git bisect good e38910adf47ba1d0b5a5a573cc26bde1ec533147
# bad: [f89bdd2c52666d9da4bf4ef3a97a7188586ba0fb] dma-direct: fix up for the removal of linux/bootmem.h
git bisect bad f89bdd2c52666d9da4bf4ef3a97a7188586ba0fb
# good: [3108d998dfc36eb7f6b7f2917fc561258f742094] mm: nobootmem: remove bootmem allocation APIs
git bisect good 3108d998dfc36eb7f6b7f2917fc561258f742094
# good: [1f94dacb1d0ed0d1068b89ad867a198d3eca7bf2] memblock: rename __free_pages_bootmem to memblock_free_pages
git bisect good 1f94dacb1d0ed0d1068b89ad867a198d3eca7bf2
# good: [c3954ade0c1b499ae587f3edb813876216212836] memblock: replace BOOTMEM_ALLOC_* with MEMBLOCK variants
git bisect good c3954ade0c1b499ae587f3edb813876216212836
# bad: [cde1c7f7e92aef241f1c1a09a4d1f1f06fd565b6] mm: remove include/linux/bootmem.h
git bisect bad cde1c7f7e92aef241f1c1a09a4d1f1f06fd565b6
# first bad commit: [cde1c7f7e92aef241f1c1a09a4d1f1f06fd565b6] mm: remove include/linux/bootmem.h

Reverting this patch together with its fix-up "powerpc: fix up for removal of
linux/bootmem.h" fixes the problem. This also fixes the traceback seen with all
other ppc64 images.

Guenter
