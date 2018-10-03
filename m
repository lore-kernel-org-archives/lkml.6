Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE5EC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848F720652
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cbtbq3si"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848F720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbeJCSIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:08:10 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38055 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeJCSIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:08:10 -0400
Received: by mail-qt1-f196.google.com with SMTP id l9-v6so5413606qtf.5;
        Wed, 03 Oct 2018 04:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=64RzwtB7e2uj2EjRCEk6rJ3pykZdZ1J0Bh28PpfHk5I=;
        b=Cbtbq3si4fj/YnVnlb2dcMhvGaUEnx21y0R4DkCh7+SYGTt0jKWgcLSKc94NWFNa3Q
         SsBMjmbhpaUH7uuiWyOKtHEzKAflNWf09xpFRgb2DlZci8b635gyTVys83YQ0q1fW9oK
         SCMPTDBAHjseBobG3t1SDvJiyZKQJMh5DocjvhriLXJ1oR6jscE6IA8fKtLIP3fkaZaq
         x/bHQjSGX1TkWkiEO/vyZugL1f/OWZOyn7JIYfxkhfTaZVJJBfFOoTz2uw0sP+QA6G3e
         I1ZHH1F/e1TJBmJE2OXntkO0Q+65xAPR8zaJ11Sp5Ha7GCH2/hCq/4TFFFuCXVRtQNU9
         5opg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=64RzwtB7e2uj2EjRCEk6rJ3pykZdZ1J0Bh28PpfHk5I=;
        b=R/8BOGkrKi+6j/D9BLNLj1Bx64ndnohpmsBrMZvaGfysCpSH3FrmoJ032y3OkeTvRf
         BIsodYW6GVoe3mEaqh4dBdOjkucDdJjatSQ5MJ+i6v2i+FsQuVg8Nu907cgsOv7Y++aF
         3byaC06x4m3U87xXacV/COBRWGAzlZ31xtJYz/fUdDOBZHKW3EY0Rp/GbzFsZQL5Y43b
         oYn+mP2DrnUnWurIMJF7AmCYdmAbyJyGEs6FaX0/XjFZSn8kaID/jiry6JXBwmWk24TV
         Ij2FkuN8U6pB9z8QnphiIbL/vIjjX4s6UWjMYEbCInwcMMPdOAonvl6yK5WQbxKiMlHO
         vz1A==
X-Gm-Message-State: ABuFfohSrza/CV3fdBq2vIViOao4YPhqgKB/YZ5dh4JA1LJBAqLYfSo0
        i2sZp0mEu6OJd5BXNthn/1bart97plxobMxyEd8=
X-Google-Smtp-Source: ACcGV63T9KpbCw9EWazj9kVA2Ro45vEtuH6dKnhrGkhJAO9DMxeJgA9SbbJ1b5ajBe3FQPQvJWvh1zzs7FrGhmP5QgU=
X-Received: by 2002:a0c:aa06:: with SMTP id d6-v6mr760754qvb.26.1538565612481;
 Wed, 03 Oct 2018 04:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181002211651.2804717-1-arnd@arndb.de>
In-Reply-To: <20181002211651.2804717-1-arnd@arndb.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 3 Oct 2018 14:20:01 +0300
Message-ID: <CAHp75VfJCZM8Ho3DLB1-xkhJJ=i+BACuvUY-6W-GuFa=iyZzcw@mail.gmail.com>
Subject: Re: [PATCH] firmware: dcdbas: include linux/io.h
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 12:17 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> memremap() is declared in linux/io.h, not in asm/io.h, so we should
> include that header to avoid build errors:
>
> drivers/platform/x86/dcdbas.c: In function 'dcdbas_check_wsmt':
> drivers/platform/x86/dcdbas.c:572:15: error: implicit declaration of function 'memremap'; did you mean 'ioremap'? [-Werror=implicit-function-declaration]
>   eps_buffer = memremap(eps->smm_comm_buff_addr, remap_size, MEMREMAP_WB);
>                ^~~~~~~~
>                ioremap
> drivers/platform/x86/dcdbas.c:572:61: error: 'MEMREMAP_WB' undeclared (first use in this function)
>   eps_buffer = memremap(eps->smm_comm_buff_addr, remap_size, MEMREMAP_WB);
>                                                              ^~~~~~~~~~~
> drivers/platform/x86/dcdbas.c:572:61: note: each undeclared identifier is reported only once for each function it appears in
> drivers/platform/x86/dcdbas.c: In function 'dcdbas_exit':
> drivers/platform/x86/dcdbas.c:748:3: error: implicit declaration of function 'memunmap'; did you mean 'vm_munmap'? [-Werror=implicit-function-declaration]
>

Pushed to for-next, sorry for inconveniences and thanks for the quick fix!

> Fixes: 12c956c4f32e ("firmware: dcdbas: Add support for WSMT ACPI table")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/platform/x86/dcdbas.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/dcdbas.c b/drivers/platform/x86/dcdbas.c
> index ae28e48ff7dc..daa7e3574568 100644
> --- a/drivers/platform/x86/dcdbas.c
> +++ b/drivers/platform/x86/dcdbas.c
> @@ -37,7 +37,7 @@
>  #include <linux/string.h>
>  #include <linux/types.h>
>  #include <linux/mutex.h>
> -#include <asm/io.h>
> +#include <linux/io.h>
>
>  #include "dcdbas.h"
>
> --
> 2.18.0
>


-- 
With Best Regards,
Andy Shevchenko
