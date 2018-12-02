Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC6AC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 15:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DF520851
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 15:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53DF520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbeLBPx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 10:53:27 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37019 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbeLBPx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 10:53:27 -0500
Received: by mail-qt1-f196.google.com with SMTP id z16so11156864qtq.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 07:53:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=92Prjp05/u4wWbtP/02mJndMIH06wvDkiC1JJ3za9Nw=;
        b=GFJhp80/vU5aB6wHDnHLr/aAeMi3GxZ/vTLZKaCnZ0hAOlmN+2dCZJOiX+PqUsfQJE
         7olxRB/vxOVryGP5vCLOokhTQmsQl/HO9PlWFwfGUMw/JilUDG3idWLmOGBduUNQmWr5
         XEpeKtQEq7mrZWzsnbOuTi+PnhfpRzMMWmuFhCFCxBNuDj6HYmU3FtbWXoYZWSy452gU
         UCKac+/zXeElR0mG/Ebtgh9+kEx5+c00gvdsNwGdPTHupyUd9dmLbzjjszRhQXuFFVik
         NoPUmofjxO6XlJ6tB2dB+Ln9FAgSrMviomAmof0ZgFPJEh60JUD0xwqsSZHWPLzld7+7
         jrsQ==
X-Gm-Message-State: AA+aEWbjvULmRC/CpDd6SvbyaYp/Rbd5dQjoDFgCw4sZ5qd9yR3oR1sZ
        s0cltiqqD26V+dIDec4YG6AmV7zFhqggOK/E7f8LqQ==
X-Google-Smtp-Source: AFSGD/WrJCr60l/IeFdMrjJbhNZllwG44gbHreQu648zmvpdOy6STapOT9kccnZFJRhhZvMjAjYrQ+E8eDwvQ+FEdLg=
X-Received: by 2002:a0c:dc0f:: with SMTP id s15mr12468283qvk.40.1543766004633;
 Sun, 02 Dec 2018 07:53:24 -0800 (PST)
MIME-Version: 1.0
References: <20181202111224.1450-1-lkundrak@v3.sk>
In-Reply-To: <20181202111224.1450-1-lkundrak@v3.sk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 2 Dec 2018 16:53:07 +0100
Message-ID: <CAK8P3a3rEuccqhAgpNR6tP1g826m8o-mWtM1vNmGMb_-H8YMoA@mail.gmail.com>
Subject: Re: [PATCH] ARM: mmp/mmp2: fix cpu_is_mmp2() on mmp2-dt
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, quozl@laptop.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 2, 2018 at 12:12 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> cpu_is_mmp2() was equivalent to cpu_is_pj4(), wouldn't be correct for
> multiplatform kernels. Fix it by also considering mmp_chip_id, as is
> done for cpu_is_pxa168() and cpu_is_pxa910() above.
>
> Moreover, it is only available with CONFIG_CPU_MMP2 and thus doesn't work
> on DT-based MMP2 machines. Enable it on CONFIG_MACH_MMP2_DT too.
>
> Note: CONFIG_CPU_MMP2 is only used for machines that use board files
> instead of DT. It should perhaps be renamed. I'm not doing it now, because
> I don't have a better idea.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Arnd Bergmann <arnd@arndb.de>

I'd suggest adding

Cc: stable@vger.kernel.org

since this fixes bugs on other platforms when CONFIG_MMP2 is enabled
in a multiplatform kernel.
