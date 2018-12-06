Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405D0C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0729B20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107650;
	bh=HdSskfssIl18xMwTKzi7LjT5G8u/h01kPL4foRsMkhc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=igojnf0xNd7nBA0EudO6UP1lkRTZoYiLRA/QE3RUNwcyx5K0yB+WRwK+dnrGIzeMF
	 AqYIpFd6CnpaS5Sk5lL/LXJPUbu3qHvLlvqAqAK1s9LQQsqKJVyRgw8xcrhjdVvyy2
	 dlt0XKbjaHrWimvBEGFL26R2LofHGKiTodXX+Hdc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0729B20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731414AbeLFOr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:47:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:52406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730249AbeLFOrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:47:23 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20DF2215E5;
        Thu,  6 Dec 2018 14:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107642;
        bh=HdSskfssIl18xMwTKzi7LjT5G8u/h01kPL4foRsMkhc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OMLID9Wt79hzanLzk+lLc7sv2MDeWcWD3bq+tvwuUAr12dgS5V5CWfPf+uJVdeZVt
         9u7CICbPgJzJiaw3y63yjx74mqpIje3GPh+FJ7IXk94+TRgp3aslGxUGrbbfmuLTpu
         jmxlVDsOf/VCPFmRMxLV0XH/NWENkr0r5GoZ/R+8=
Received: by mail-qt1-f173.google.com with SMTP id y20so721885qtm.13;
        Thu, 06 Dec 2018 06:47:22 -0800 (PST)
X-Gm-Message-State: AA+aEWbyTG1oMaKEg8qqmO4YoV8C0ykGN25qA+x870CaAqFjeV+Mpj0Y
        DBUSZkARXhJjzgVsmOtI8oCy4+tjSiz+yhFLPw==
X-Google-Smtp-Source: AFSGD/Xp8meM97qTpKa9DbSEVeCe0BNe9keZMHZ72aJRp1X7x/5xHzrSPezR5Jnpvv14zyI7B/aRLbNUXKh977bQD/k=
X-Received: by 2002:a0c:c389:: with SMTP id o9mr27889568qvi.90.1544107641259;
 Thu, 06 Dec 2018 06:47:21 -0800 (PST)
MIME-Version: 1.0
References: <20181115055254.2812-1-takahiro.akashi@linaro.org> <20181115055254.2812-7-takahiro.akashi@linaro.org>
In-Reply-To: <20181115055254.2812-7-takahiro.akashi@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 6 Dec 2018 08:47:04 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL4_Z5pVfoB3opjL7eTzZvhBJW7_aQS443quAAR0gGH1w@mail.gmail.com>
Message-ID: <CAL_JsqL4_Z5pVfoB3opjL7eTzZvhBJW7_aQS443quAAR0gGH1w@mail.gmail.com>
Subject: Re: [PATCH v16 06/16] lib: fdt: add a helper function for handling
 memory range property
To:     "AKASHI, Takahiro" <takahiro.akashi@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>, dyoung@redhat.com,
        Baoquan He <bhe@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        prudo@linux.ibm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>, bhsharma@redhat.com,
        kexec@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 11:52 PM AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> Added function, fdt_setprop_reg(), will be used later to handle
> kexec-specific property in arm64's kexec_file implementation.
> It will possibly be merged into libfdt in the future.

You generally can't modify libfdt files. Any changes will be blown
away with the next dtc sync (there's one in -next now). Though here
you are creating a new location with fdt code. lib/ is just a shim to
the actual libfdt code. Don't put any implementation there. You can
add this to drivers/of/fdt_address.c for the short term, but it still
needs to go upstream.

Otherwise, the implementation looks fine to me.

> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: devicetree@vger.kernel.org
> ---
>  include/linux/libfdt.h | 26 ++++++++++++++++++++
>  lib/Makefile           |  2 +-
>  lib/fdt_addresses.c    | 56 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 83 insertions(+), 1 deletion(-)
>  create mode 100644 lib/fdt_addresses.c
