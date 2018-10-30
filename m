Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02338C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A180920664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jcKtztE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A180920664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbeJaHZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 03:25:40 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:44488 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbeJaHZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 03:25:40 -0400
Received: by mail-ua1-f67.google.com with SMTP id i30so5150811uae.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 15:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bImqfsi8wLzHdpxcSUnzMo8Inz8+K2mhWJsVdXrdeuE=;
        b=jcKtztE2YqHIN/ivS3T1ZCw84PseggOPg6ZMa6O+Xwi3o8ePR9CuItoF1UQkA4p71Q
         AGZsRypdJ3G1dlog6rYXRUmhTbTueRGExx76PbPoqNk4VZEgIpuWOJayPkTqJ742AM58
         KK7v5W/wbozKkaVztZ4jBMT+ZKckAgfW1zzOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bImqfsi8wLzHdpxcSUnzMo8Inz8+K2mhWJsVdXrdeuE=;
        b=YkMmUZIAkMxAOWQlytXJKDx9xO1F9AYlkbaD21sLDjd3S5iTx0TUDlnF5wkVwYUyAj
         HDebU/iYuJ5eqUy0hmTB/yihi+64Y7AgXhcpznuz0lhgZ5FJUlsXbX1tUoczZ7S8TnjV
         5mj+Us8u2HZu2n83IrhpswamYs35n7J24UcaK5EwqM+CydDauznDRegnMzZMkVOOweji
         5HjaFPGSN2rPEu0Tje28+ns2HvBP9CnqJV/lD91xwstWhNr2VD1Qz6EGyDKM3txRCIwn
         9/zeEFEm7zobXUX9ss4YSAQgYcS/NLXlyPEYk7YiZRQAGhYS3C0kGiQ9gR58F/iEtnWt
         FX4Q==
X-Gm-Message-State: AGRZ1gKLSDBbQXpjyI8Ow+kNN+a6t9xwqSMZW2uzYoURzBacOmYnUCsp
        bcAMkh87HlDPHwoWr35uXKZ5kori78A=
X-Google-Smtp-Source: AJdET5fOZCq6fnosNGsr9b8GSbXNUDnYB46Nv1gYjHQXYxyYe7jhBV/6mnnNP6H1SBdTcyM6g5UFAA==
X-Received: by 2002:ab0:5b51:: with SMTP id v17mr273755uae.105.1540938619301;
        Tue, 30 Oct 2018 15:30:19 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id 131sm642238vko.28.2018.10.30.15.30.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 15:30:19 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id y14so748588vkd.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 15:30:18 -0700 (PDT)
X-Received: by 2002:a1f:8ac6:: with SMTP id m189mr251182vkd.79.1540938171170;
 Tue, 30 Oct 2018 15:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181029180707.207546-1-dianders@chromium.org>
 <20181029180707.207546-8-dianders@chromium.org> <20181030114603.xdvyvayzw2an5c3q@holly.lan>
In-Reply-To: <20181030114603.xdvyvayzw2an5c3q@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 30 Oct 2018 15:22:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WxoJ2LgUyR7Jm=xJHTqWGMvan7o18gOK-qPKdCrRRQtw@mail.gmail.com>
Message-ID: <CAD=FV=WxoJ2LgUyR7Jm=xJHTqWGMvan7o18gOK-qPKdCrRRQtw@mail.gmail.com>
Subject: Re: [PATCH 7/7] kgdb: Remove irq flags and local_irq_enable/disable
 from roundup
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, kstewart@linuxfoundation.org,
        linux-mips@linux-mips.org, dalias@libc.org,
        linux-sh@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>, mhocko@suse.com,
        paulus@samba.org, "H. Peter Anvin" <hpa@zytor.com>,
        sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        ysato@users.sourceforge.jp, mpe@ellerman.id.au, x86@kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>, jhogan@kernel.org,
        linux-snps-arc@lists.infradead.org, ying.huang@intel.com,
        rppt@linux.vnet.ibm.com, bp@alien8.de,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        christophe.leroy@c-s.fr, pombredanne@nexb.com,
        Ralf Baechle <ralf@linux-mips.org>, rkuo@codeaurora.org,
        paul.burton@mips.com, Vineet Gupta <vgupta@synopsys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 30, 2018 at 4:46 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Oct 29, 2018 at 11:07:07AM -0700, Douglas Anderson wrote:
> > The function kgdb_roundup_cpus() was passed a parameter that was
> > documented as:
> >
> > > the flags that will be used when restoring the interrupts. There is
> > > local_irq_save() call before kgdb_roundup_cpus().
> >
> > Nobody used those flags.  Anyone who wanted to temporarily turn on
> > interrupts just did local_irq_enable() and local_irq_disable() without
> > looking at them.  So we can definitely remove the flags.
>
> On the whole I'd rather that this change...
>
>
> > Speaking of calling local_irq_enable(), it seems like a bad idea and
> > it caused a nice splat on my system with lockdep turned on.
> > Specifically it hit:
> >   DEBUG_LOCKS_WARN_ON(current->hardirq_context)
>
> ... and fixes for this this were in separate patches. They don't appear
> especially related.

Agreed that this is cleaner.  Done for v2.

-Doug
