Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1FCC43A1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 22:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443132146F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 22:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbSLivLS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443132146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390553AbeGKWYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 18:24:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35810 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733146AbeGKWYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 18:24:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6-v6so3285250pgv.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 15:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U9EUyXgdR20onsIBbN+E5yqZe7mZnjYqLMpGaHaTUC8=;
        b=DbSLivLS17K20CwZOO0FHZmbWWS6QEvMDUkF/gf0CyIbtLVxenTAacjWlEA2Jp91Kn
         cu+Q3EthEEOIwNuVT7DQ8rvssH+5qD3eXaOWn30oPx00usLmG6ay9wHsDdExHAnu4e8Z
         Id99FYJTsELUWhKcRd5zprO7bj0v0J1lOFSM53zm3IF/s1oQ0H0Sz2a+sPWqXxngsp6l
         FXnn1hd6FAI18sjvaszm9DCmQkczopsr2GZviA4g4wwVeTUxVolO4oUcW7nqfJWX/vbW
         /BkY+rWaPqemv/LVcoBvi302eWi2BGNmTdSrZxcorW0/fCTZoOFZDbXYG6XmZa6EQk8b
         9oBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=U9EUyXgdR20onsIBbN+E5yqZe7mZnjYqLMpGaHaTUC8=;
        b=RaWixK8dZPuGIIha39UYvLXFLLELPK/OKxIfLN7LPjwDbgLC7PtCk+gA0IDFgAIvCJ
         lTs5aNAyhnsgTZviMLWJFb+U94KUA4qDGWjY4aTdgSOFfiVFk9TFIsevuOfJX7Qi4cGq
         sp9hBsJ2YrNzHIfWDrJb8SX92bb8ZoDbonGf9g4Fya0jYP2p8wRtydjB6I9Q/Mb6zS46
         nR8wu+2Dh19v18hZlWXzFQCdy4UUdfcfU0u1+Oecekt2P3KLiuZbji4Y9UCvCHBZEZFx
         StwTD8W2s3b+7w4k+cv9SetydAZ8ntgWnN9jL7FKW/BDsq+cgzTxIWQGOz9D2og7e9q7
         0aqw==
X-Gm-Message-State: AOUpUlFsw6QTiBiEGpw/mtpCShQRiyCj7A9rm2xXzkxkwPN3dmDClEvm
        izk3vr96k8/jInX9NJhITxY2Tw==
X-Google-Smtp-Source: AAOMgpdOf2u1o1Dz6GFcfwVpBNn3NhfiHRlNhpo9DpeEf8sH6xiNCh0URDg4GQrgNxrO9EMc9puf3A==
X-Received: by 2002:a62:4bc6:: with SMTP id d67-v6mr387205pfj.175.1531347464688;
        Wed, 11 Jul 2018 15:17:44 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id a17-v6sm14598694pfg.106.2018.07.11.15.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 15:17:43 -0700 (PDT)
Date:   Wed, 11 Jul 2018 15:17:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [2/2] mm: Drop unneeded ->vm_ops checks
Message-ID: <20180711221742.GA9360@roeck-us.net>
References: <20180710134821.84709-3-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710134821.84709-3-kirill.shutemov@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 10, 2018 at 04:48:21PM +0300, Kirill A. Shutemov wrote:
> We now have all VMAs with ->vm_ops set and don't need to check it for
> NULL everywhere.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

This patch causes two of my qemu tests to fail:
	arm:mps2-an385:mps2_defconfig:mps2-an385
	xtensa:de212:kc705-nommu:nommu_kc705_defconfig

Both are nommu configurations.

Reverting the patch fixes the problem. Bisect log is attached for reference.

Guenter

---
# bad: [98be45067040799a801e6ce52d8bf4659a153893] Add linux-next specific files for 20180711
# good: [1e4b044d22517cae7047c99038abb444423243ca] Linux 4.18-rc4
git bisect start 'HEAD' 'v4.18-rc4'
# good: [ade30e73739a5174bcaee5860fee76c2365548c5] Merge remote-tracking branch 'crypto/master'
git bisect good ade30e73739a5174bcaee5860fee76c2365548c5
# good: [792be221c35d19a1c486789e5b5c91c05279b94d] Merge remote-tracking branch 'tip/auto-latest'
git bisect good 792be221c35d19a1c486789e5b5c91c05279b94d
# good: [1d66737ba99400ab9a79c906a25b2090f4cc8b18] Merge remote-tracking branch 'mux/for-next'
git bisect good 1d66737ba99400ab9a79c906a25b2090f4cc8b18
# good: [c02d5416bd8504866dd80d2129f4648747166b6f] Merge remote-tracking branch 'kspp/for-next/kspp'
git bisect good c02d5416bd8504866dd80d2129f4648747166b6f
# bad: [1e741337a9416010a48c6034855e316ba8057111] ntb: ntb_hw_switchtec: cleanup 64bit IO defines to use the common header
git bisect bad 1e741337a9416010a48c6034855e316ba8057111
# good: [205a106bac127145a4defae7d0d35945001fe924] kernel/memremap, kasan: make ZONE_DEVICE with work with KASAN
git bisect good 205a106bac127145a4defae7d0d35945001fe924
# good: [e87ebebf76c9ceeaea21a256341d6765c657e550] mm, oom: remove sleep from under oom_lock
git bisect good e87ebebf76c9ceeaea21a256341d6765c657e550
# bad: [1f927d8f894e116af625b2326b355f5292c89d2b] mm/page_owner: align with pageblock_nr pages
git bisect bad 1f927d8f894e116af625b2326b355f5292c89d2b
# bad: [cc8ce33f3475478af93a876e0cf4a99eabbe49e9] mm: revert mem_cgroup_put() introduction
git bisect bad cc8ce33f3475478af93a876e0cf4a99eabbe49e9
# bad: [1f989b6a333fc8d6bddd1552420bb97e3295468a] list_lru-prefetch-neighboring-list-entries-before-acquiring-lock-fix
git bisect bad 1f989b6a333fc8d6bddd1552420bb97e3295468a
# bad: [0454d28f4858b6c8b2606417d35e4e6868699130] mm, swap: fix race between swapoff and some swap operations
git bisect bad 0454d28f4858b6c8b2606417d35e4e6868699130
# bad: [7efeddad4bc281bf61f411a7fe9b19f3689cf62f] mm, swap: fix race between swapoff and some swap operations
git bisect bad 7efeddad4bc281bf61f411a7fe9b19f3689cf62f
# bad: [4a110365f1da9d5cabbd0a01796027c0a6d5e80b] mm: drop unneeded ->vm_ops checks
git bisect bad 4a110365f1da9d5cabbd0a01796027c0a6d5e80b
# first bad commit: [4a110365f1da9d5cabbd0a01796027c0a6d5e80b] mm: drop unneeded ->vm_ops checks
