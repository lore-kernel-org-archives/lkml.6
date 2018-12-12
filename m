Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A74C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89A92084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QPUotTRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B89A92084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbeLLV0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 16:26:44 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:33684 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbeLLV0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 16:26:43 -0500
Received: by mail-yb1-f196.google.com with SMTP id c67so918729ybf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 13:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+BEnt5TG3QOBL/f8mAJzw3vK7N3jl5vCJSfFl08wQY=;
        b=QPUotTRVuRp9KxDZx+5x+wBVFbeT04GHuk4L3BknKaVJKmddGfZqdq/rTjvIWER3OJ
         3PCnXgXdxeDcAI664xzlmEf8wPfLtGiXdciZgtuHqFIB+39SSWll0r7bhFlJmJINTEV6
         0vlpX33NvjWOeMmRFXp1Q9vGPqFa/9kgbYWTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+BEnt5TG3QOBL/f8mAJzw3vK7N3jl5vCJSfFl08wQY=;
        b=cigSrNPqmt0uLbSs3lzPRIEcCw61bZzU6s23o0+Nw/tnxBQSkDNVBTTiDxi4dpQrZQ
         kB66f6UrMLBY60dRwKDlVLLQZW4kkkec99X4wlPacAe5bH9MC1sNIK1/uSQczErF6Jyb
         SXyxw6MDVAkVmQ7MmUv8bq9zC7ss/E1II2W3PPYR5ij0EXERFeVeQW9XwZPjJ5Wxln2g
         Fsfc7cN+nbRJq1Sjc1OBCR1nCu8jBwEam26zi7x5TaqifgZFMwuqacmTZ7b7J55Bc28t
         XS2l5vWGbgRrwdRNSG8bWtELHJLjiBo/Y35yLYKp8QulrOAhv8zrBM6BwFSuoBVBZbh6
         Z0Fg==
X-Gm-Message-State: AA+aEWbt03aedke9wmVtu33t8DTT6uVisPToRwonH2EJ+rnL/Q2LScOR
        OHndmgol2cOYU6HvzPFZlEoYXY3v7nU=
X-Google-Smtp-Source: AFSGD/Vz8FQlBoW+LsDNdgkYv0i2OsmHuU12ZufJGmbod6bh+9gIWmB2JIqVnUSH2EGiWTnRTMaYiw==
X-Received: by 2002:a25:ad1d:: with SMTP id y29mr3656010ybi.80.1544650002314;
        Wed, 12 Dec 2018 13:26:42 -0800 (PST)
Received: from mail-yw1-f47.google.com (mail-yw1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id j6sm6297201ywi.110.2018.12.12.13.26.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 13:26:40 -0800 (PST)
Received: by mail-yw1-f47.google.com with SMTP id f65so7607104ywc.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 13:26:40 -0800 (PST)
X-Received: by 2002:a81:98e:: with SMTP id 136mr22076490ywj.47.1544650000024;
 Wed, 12 Dec 2018 13:26:40 -0800 (PST)
MIME-Version: 1.0
References: <20181206083257.9596-1-ard.biesheuvel@linaro.org>
 <201812091807.4emRkZ7L%fengguang.wu@intel.com> <20181209103740.GB30658@n2100.armlinux.org.uk>
 <CAGXu5j+WLpjNq0p41eu+VeZxV3yeTB19uNYxCQevbcDYkv7gJw@mail.gmail.com>
In-Reply-To: <CAGXu5j+WLpjNq0p41eu+VeZxV3yeTB19uNYxCQevbcDYkv7gJw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 12 Dec 2018 13:26:26 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+FzZ7FuhLvfR6Lm_d7dN2Pc3qn7xaqV6HLp6xtGy+kGg@mail.gmail.com>
Message-ID: <CAGXu5j+FzZ7FuhLvfR6Lm_d7dN2Pc3qn7xaqV6HLp6xtGy+kGg@mail.gmail.com>
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

On Mon, Dec 10, 2018 at 2:34 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Sun, Dec 9, 2018 at 2:38 AM Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> >
> > On Sun, Dec 09, 2018 at 06:28:11PM +0800, kbuild test robot wrote:
> > > Hi Ard,
> > >
> > > I love your patch! Perhaps something to improve:
> >
> > Hi,
> >
> > This looks to me like a false warning - how can a patch touching arch
> > code affect the result of lib/test_ubsan.c?  Please can you double-
> > check this result?
>
> Yeah, no idea. Do you want me to toss this into the ARM patch queue?
> If not, I can this through the gcc-plugin tree.

Since the ARM changes are relatively small, and it adds a new plugin,
I'll take this via the gcc-plugins tree for -next now. Please yell if
this should be done differently.

Thanks!

-- 
Kees Cook
