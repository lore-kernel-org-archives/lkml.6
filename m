Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A95AC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B192084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nExYkwuj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B192084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbeLJWfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:35:07 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44806 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeLJWfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 17:35:06 -0500
Received: by mail-yw1-f67.google.com with SMTP id i22so4652889ywa.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 14:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hmD+rcKv+QmbxvfADc4Evrghh2JGTcEKcQK2aSTrd5w=;
        b=nExYkwujOf7mDx3KK2ciS82CfEOMemoFIAyLw/Cc61FCleuhtFnp2vArJEMQlHsgsi
         jJg5dhJ2R5TeWOhPjIEpJVyb9xJ1ONrOxn3vwFLLjcDVFgDgHQ+p/Uj8YtJGvEeqrvlV
         S/U6KJsCX/ytia2RRJRVxDTpMoWbO2+YQyI64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hmD+rcKv+QmbxvfADc4Evrghh2JGTcEKcQK2aSTrd5w=;
        b=SbGnAgyFSp40uGMwZmBYAnTJB7dXzz7AxqWMqoVXlIEWxxS2m8VRQkYvwmm3iTkuq1
         9ehWtleT25lDpVxZAq3LNxwPHCm73Prcj7frt77FEnbODTvS2Z9bCCKgltCWtlL54fSl
         tPlluzVEvAX/CAgjriQBsLRi5VP0VNGxawwImVNQCbaJp/WkAj5RmBmZG3TIA0o4aEqs
         R8vWkLBdDlx2hw4PKXRArGIueho4zN75Wd7eUeLrhn4uWA6CQ4oeEVo5Q6P81u7T4Y6O
         5Ovd1h/hoRl+cTIHwuxviYzmZ1bjrwdpBI/E0LfnsjyVDvEy+5QrW6oYPMxMTQBfHf0j
         0L9A==
X-Gm-Message-State: AA+aEWaqF5Hu8eGpwB0PCniGIELB777VlOqaOVv7aSQhPHPotqL0E7iJ
        nxYH0gX9db/clnR93aAxe2f09Vew5Wk=
X-Google-Smtp-Source: AFSGD/WdwaJGlmsKgs3xx8hcRlFYhCVHUuW7F4HU3Dj8+HSVA3jdDQDIPSQrI4XKP3p1h6xrCFLG3g==
X-Received: by 2002:a81:a988:: with SMTP id g130mr13991244ywh.307.1544481305683;
        Mon, 10 Dec 2018 14:35:05 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id o14sm5964207ywo.52.2018.12.10.14.35.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 14:35:02 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id k136so2249958ybk.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 14:35:01 -0800 (PST)
X-Received: by 2002:a25:2347:: with SMTP id j68mr13910924ybj.137.1544481301490;
 Mon, 10 Dec 2018 14:35:01 -0800 (PST)
MIME-Version: 1.0
References: <20181206083257.9596-1-ard.biesheuvel@linaro.org>
 <201812091807.4emRkZ7L%fengguang.wu@intel.com> <20181209103740.GB30658@n2100.armlinux.org.uk>
In-Reply-To: <20181209103740.GB30658@n2100.armlinux.org.uk>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 10 Dec 2018 14:34:49 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+WLpjNq0p41eu+VeZxV3yeTB19uNYxCQevbcDYkv7gJw@mail.gmail.com>
Message-ID: <CAGXu5j+WLpjNq0p41eu+VeZxV3yeTB19uNYxCQevbcDYkv7gJw@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: smp: add support for per-task stack canaries
To:     Russell King <linux@armlinux.org.uk>
Cc:     kbuild test robot <lkp@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, kbuild-all@01.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Emese Revfy <re.emese@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Laura Abbott <labbott@redhat.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 9, 2018 at 2:38 AM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Sun, Dec 09, 2018 at 06:28:11PM +0800, kbuild test robot wrote:
> > Hi Ard,
> >
> > I love your patch! Perhaps something to improve:
>
> Hi,
>
> This looks to me like a false warning - how can a patch touching arch
> code affect the result of lib/test_ubsan.c?  Please can you double-
> check this result?

Yeah, no idea. Do you want me to toss this into the ARM patch queue?
If not, I can this through the gcc-plugin tree.

-Kees

-- 
Kees Cook
