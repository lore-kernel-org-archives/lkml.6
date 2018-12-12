Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BE8C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E082086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bFHiet2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E082086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbeLLNLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:11:07 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:30073 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbeLLNLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:11:07 -0500
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id wBCDAmkV003541;
        Wed, 12 Dec 2018 22:10:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com wBCDAmkV003541
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544620249;
        bh=r24wrdaiuHeXrRPjDih1A9mHAIjWu5bO2qeWaSowhdQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bFHiet2sa+pHIuqLv99zCP3RfOojgYMpMdsnZZWYG0wOUeS8ayOuOC67rdZL4ZN53
         ZQs6+vdn0PJK9RMZMEPDCN0UqsPfdSlnS1XMTP9Cz5dhjdxv/YzNI9Crc0n5TSq0na
         82ZbjG7b+TZlllqXQ14aQ/+OpJ9SK+M64MoESnVIFZ6h2lRy2+6YuCfILHXUqoarg1
         0FLJo3C4UV3AMokVQwwY+XwHcGNhf/2ebrUs0cgg/QOPiQK1Ks94/JzrdJE8RuwqcF
         LePS241LVgpOXcl2iKTjS2RVTAbvi0QrrYkNMD+AV/671lCPQuogbvlqHW6kondnvz
         LTg/1CR7D4kAg==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id h18so11006242vsj.4;
        Wed, 12 Dec 2018 05:10:48 -0800 (PST)
X-Gm-Message-State: AA+aEWbdydqJXrBtB81C1gc9sMNtZAQJoUbi/rC5F3/Z8426J/eMzg6r
        wP55A9BmvQsQO3dkPqMW/DtItWqd0rh71bCrp9c=
X-Google-Smtp-Source: AFSGD/WAui6Rb6TJ/VxBOQLX4CzlYS06+OnuCGiIwe6BkESuBXPGpOBxWU01LtpdZbb2pVQhzuUKvkDDR05KMGn6Lh8=
X-Received: by 2002:a67:5f03:: with SMTP id t3mr9379327vsb.155.1544620247691;
 Wed, 12 Dec 2018 05:10:47 -0800 (PST)
MIME-Version: 1.0
References: <20181210163725.95977-1-chao.wang@ucloud.cn>
In-Reply-To: <20181210163725.95977-1-chao.wang@ucloud.cn>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 12 Dec 2018 22:10:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNARcgRUzd+yvKjadaAx2JTyP=3nZ8g5LOfvZ0n6uAecg2g@mail.gmail.com>
Message-ID: <CAK7LNARcgRUzd+yvKjadaAx2JTyP=3nZ8g5LOfvZ0n6uAecg2g@mail.gmail.com>
Subject: Re: [PATCH] treewide: replace RETPOLINE with CONFIG_RETPOLINE
To:     chao.wang@ucloud.cn
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        zhenzhong.duan@oracle.com, Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Borislav Petkov <bp@suse.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "H. Peter Anvin" <hpa@zytor.com>, konrad.wilk@oracle.com,
        Andy Lutomirski <luto@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        srinivas.eeda@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 2:17 AM WANG Chao <chao.wang@ucloud.cn> wrote:
>
> Since commit 4cd24de3a098 ("x86/retpoline: Make CONFIG_RETPOLINE depend
> on compiler support"), RETPOLINE has been replaced by CONFIG_RETPOLINE.
>
> Fixes: 4cd24de3a098 ("x86/retpoline: Make CONFIG_RETPOLINE depend on compiler support")
> Signed-off-by: WANG Chao <chao.wang@ucloud.cn>
> ---



Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>




-- 
Best Regards
Masahiro Yamada
