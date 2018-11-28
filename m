Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C92EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BDF2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/h+if3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5BDF2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeK2ITq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:19:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:39372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbeK2ITp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 03:19:45 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 116D12133F;
        Wed, 28 Nov 2018 21:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543439806;
        bh=eToAFo4MzrP94ConyJkWrG02WSbR735hlb6Wlk7Jq3c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J/h+if3qpvhT6dcleEF1JzFNBfpx8jYf1F1XWHwDFFkx/pDnaP5Hw2AJaeNmIHLeT
         oz+6geOBMUN96SOgeIOF4uOQNPBG2ZalhyHJ913abCDj4vWiLde3ZoUD04YoSazIGK
         GhKNglxG/b09vgIovxQLSVhn4CQAegi3LYQd2Lgw=
Received: by mail-qk1-f182.google.com with SMTP id y78so6972467qka.12;
        Wed, 28 Nov 2018 13:16:46 -0800 (PST)
X-Gm-Message-State: AA+aEWZWmaMHxlAO0rrwSV1ti2j4EwF34XUpnxY7YeokV2S1XAQK3JyC
        arU3nn1iqGONIrrC6rQlPiBst9UfQRE8CCLbng==
X-Google-Smtp-Source: AFSGD/WdKPVi4YAcajAYtg7gGkf/z1T9haNO5LYX3vdPsFhlVy0Nm3KrTI3KsKRTBUGZ4yWf5psnFa+T4+mEPSMmTkg=
X-Received: by 2002:ae9:edd8:: with SMTP id c207mr34364085qkg.184.1543439805217;
 Wed, 28 Nov 2018 13:16:45 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com> <20181128193636.254378-17-brendanhiggins@google.com>
In-Reply-To: <20181128193636.254378-17-brendanhiggins@google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 28 Nov 2018 15:16:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK5cG=QzMBFSZ31_-3ujnxqxv=jj3XYajbRLT7yWYZbfw@mail.gmail.com>
Message-ID: <CAL_JsqK5cG=QzMBFSZ31_-3ujnxqxv=jj3XYajbRLT7yWYZbfw@mail.gmail.com>
Subject: Re: [RFC v3 16/19] arch: um: make UML unflatten device tree when testing
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, shuah@kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Frank Rowand <frowand.list@gmail.com>, knut.omang@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 1:38 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> Make UML unflatten any present device trees when running KUnit tests.
>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  arch/um/kernel/um_arch.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
> index a818ccef30ca2..bd58ae3bf4148 100644
> --- a/arch/um/kernel/um_arch.c
> +++ b/arch/um/kernel/um_arch.c
> @@ -13,6 +13,7 @@
>  #include <linux/sched.h>
>  #include <linux/sched/task.h>
>  #include <linux/kmsg_dump.h>
> +#include <linux/of_fdt.h>
>
>  #include <asm/pgtable.h>
>  #include <asm/processor.h>
> @@ -347,6 +348,9 @@ void __init setup_arch(char **cmdline_p)
>         read_initrd();
>
>         paging_init();
> +#if IS_ENABLED(CONFIG_OF_UNITTEST)
> +       unflatten_device_tree();
> +#endif

Kind of strange to have this in the arch code. I'd rather have this in
the unittest code if possible. Can we have an initcall conditional on
CONFIG_UM in the unittest do this? Side note, use a C if with
IS_ENABLED() whenever possible instead of pre-processor #if.

I'll take a fix separately as it was on my todo to fix. I've got the
unit tests running in a gitlab CI job now[1].

Rob

[1] https://gitlab.com/robherring/linux-dt-unittest/pipelines
