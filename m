Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B26C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C50320883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbfAIKoH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:44:07 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:42731 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfAIKoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:44:07 -0500
Received: by mail-ua1-f67.google.com with SMTP id d21so2250082uap.9;
        Wed, 09 Jan 2019 02:44:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G1pCiW36zaxkBCzG068LcsfEwgVZ6EEzarrfo6rvOkI=;
        b=HFy8nJGzOeTc3GcUFPIAM3zAn9rrIY84+rKJ9XH+SvZNtlPJXubh9L2khLUQmnvxuK
         Qp8d0JDIiBOvnl/TKkIOxYrI+2KF4WlwpGSdso6jq+duo4oudyJNLM8QcmGoBpAocnw+
         koSpR9M8gUEgPUFaGP9xHSv1V80prgKLFLSmr3ZFsymQNR9K9T2mkE3W9TA8KOo0EoB8
         MjvjSzmuOZvK4bXMHCmleQ9DcGI/6GsGmjlySyNYWLzVWUmx2bJrTa+11gOclEnnw8kv
         eivcn5S5lUqdgR9b/Lk+D6lKVhieM8kMfl/nbQSgPCJkt91yno2qkmZfjWbo1yxwk5gC
         81Fg==
X-Gm-Message-State: AJcUukcnBpqFw8dC34njJ9AoEgpDI/jfJ/Ue4tiVSc0A7NSqm7YZnvfs
        Mlx/kwgiTgZm6Q/K4FwWaDmUNuv4thLGSDWn2f4=
X-Google-Smtp-Source: ALg8bN5DGjjSfaeyqBQuhDr67ZrrYc9UBi2On9Vj51E003s6SVwTqASgvsbZ7V+9Z0oaqpiAbPc5Jb1FQ9JJag3mJUs=
X-Received: by 2002:ab0:210e:: with SMTP id d14mr2002147ual.20.1547030645329;
 Wed, 09 Jan 2019 02:44:05 -0800 (PST)
MIME-Version: 1.0
References: <20181127103312.19368-1-murphyt7@tcd.ie>
In-Reply-To: <20181127103312.19368-1-murphyt7@tcd.ie>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Jan 2019 11:43:52 +0100
Message-ID: <CAMuHMdWX=5CE=vhazBSOEbzJYyAwiK2PSDryCrA67yXRVb0m3w@mail.gmail.com>
Subject: Re: [PATCH] fix dma-buf/udmabuf selftest
To:     Tom Murphy <murphyt7@tcd.ie>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Tue, Nov 27, 2018 at 7:53 PM Tom Murphy <murphyt7@tcd.ie> wrote:
> This patch fixes the udmabuf selftest. Currently the selftest is broken.
> I fixed the selftest by setting the F_SEAL_SHRINK seal on the memfd
> file descriptor which is required by udmabuf and added the test to
> the selftest Makefile.
>
> Signed-off-by: Tom Murphy <murphyt7@tcd.ie>

This is now commit 6edf2e3710f4ef25 ("fix dma-buf/udmabuf selftest").

> --- a/tools/testing/selftests/drivers/dma-buf/udmabuf.c
> +++ b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
> @@ -4,7 +4,7 @@
>  #include <unistd.h>
>  #include <string.h>
>  #include <errno.h>
> -#include <fcntl.h>
> +#include <linux/fcntl.h>

Not including <fcntl.h> means we get

udmabuf.c:30:10: warning: implicit declaration of function ‘open’; did
you mean ‘popen’? [-Wimplicit-function-declaration]
  devfd = open("/dev/udmabuf", O_RDWR);
udmabuf.c:42:8: warning: implicit declaration of function ‘fcntl’; did
you mean ‘fcvt’? [-Wimplicit-function-declaration]
   ret = fcntl(memfd, F_ADD_SEALS, F_SEAL_SHRINK);

However, we need <linux/fcntl.h> for F_ADD_SEALS, F_SEAL_SHRINK.

Including both leads to lots of redefinition warnings.

Can we fix that?

>  #include <malloc.h>
>
>  #include <sys/ioctl.h>
> @@ -33,12 +33,19 @@ int main(int argc, char *argv[])
>                 exit(77);
>         }
>
> -       memfd = memfd_create("udmabuf-test", MFD_CLOEXEC);
> +       memfd = memfd_create("udmabuf-test", MFD_ALLOW_SEALING);
>         if (memfd < 0) {
>                 printf("%s: [skip,no-memfd]\n", TEST_PREFIX);
>                 exit(77);
>         }
>
> +       ret = fcntl(memfd, F_ADD_SEALS, F_SEAL_SHRINK);
> +       if (ret < 0) {
> +               printf("%s: [skip,fcntl-add-seals]\n", TEST_PREFIX);
> +               exit(77);
> +       }
> +
> +
>         size = getpagesize() * NUM_PAGES;
>         ret = ftruncate(memfd, size);
>         if (ret == -1) {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
