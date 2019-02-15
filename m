Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF12C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4565D206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="N/GLj9+q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731808AbfBOFtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 00:49:41 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:47789 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfBOFtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 00:49:41 -0500
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x1F5nJVM023436;
        Fri, 15 Feb 2019 14:49:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x1F5nJVM023436
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550209760;
        bh=tVAxSdg9mcIB14akyiYITF8sJZDJYZ/yGAgtXrx7G4E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N/GLj9+qRFzIbH76R5qN3zexuzH/4Dxk/oxydceaDZpuPgNhic7FP5c4B1YP3DPEl
         BJEue0Nhwzn0VzMUQkxGAsD4qPYJ6bQXB55+VpqB/Htpj8BT36NXDLnaAtKk2KYtde
         CB9O5nQxxJqepzkQqvQnNmkx6ZEOrfoHt0105wYu2boy5oLJnxEM8FpvplyRxx4a3g
         36dri+Ksa94pXzzJQWQsdSPEZgSHnqYpHWzCWDU5qVCTKUyQtnBiSG7+kbAIMMdjOQ
         BBThpUqsivbV/qok8fgQIOHDq9EXUnZxLcPbpmE5TJf6hDttckRHyveHgQaDdgErAz
         7AmrxoEB05NhA==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id z18so5135276vso.7;
        Thu, 14 Feb 2019 21:49:20 -0800 (PST)
X-Gm-Message-State: AHQUAuZSQKBBroENARTbJlMK4j+hqqdUsQ6SOzSO9fQZnlWnuRJlXwaS
        poOVrd9Cv1dvlxZw7Ip+WgOvC5hGrVycUtM22cI=
X-Google-Smtp-Source: AHgI3IbZe8cK0fXmXDfrIl5YdDaJHFstfrn3CtYMNiU8fZprjWAOUfjA1kJJgT8O+6XCxwYkchpjilHiJJmM00Cm90s=
X-Received: by 2002:a67:f759:: with SMTP id w25mr4035764vso.215.1550209759364;
 Thu, 14 Feb 2019 21:49:19 -0800 (PST)
MIME-Version: 1.0
References: <1549943095-10956-1-git-send-email-yamada.masahiro@socionext.com> <CAKv+Gu8yLY+c6jNmHYkvP3n=xiojF7dcKBHmeGibUW2FUrEczA@mail.gmail.com>
In-Reply-To: <CAKv+Gu8yLY+c6jNmHYkvP3n=xiojF7dcKBHmeGibUW2FUrEczA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 15 Feb 2019 14:48:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNASoyeFW=j9R=M2vaoLK_Gms1Z6hA_yKLyVSY=g5ALUi8A@mail.gmail.com>
Message-ID: <CAK7LNASoyeFW=j9R=M2vaoLK_Gms1Z6hA_yKLyVSY=g5ALUi8A@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: refactor cmd_stubcopy
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alistair Strachan <astrachan@google.com>,
        Laura Abbott <labbott@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 4:26 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Tue, 12 Feb 2019 at 04:45, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > It took me a while to understand what is going on in the nested
> > if-blocks.
> >
> > Simplify it by removing unneeded code.
> >
> >   - if_changed automatically adds 'set -e', so any failure in the
> >     series of commands makes it immediately fail as a whole.
> >     So, the outer if block is entirely redundant.
> >
> >   - Since commit 9c2af1c7377a ("kbuild: add .DELETE_ON_ERROR special
> >     target"), GNU Make automatically deletes the target on any failure
> >     in its recipe. The explicit 'rm -f $@' is redundant.
> >
> >   - surrounding commands with ( ) will spawn a subshell to execute them
> >     in it, but it is rarely useful to do so.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Assuming that it still works as expected:
>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> You can test this by adding a statically initialized global function
> pointer to any of the libstub source files that get built for ARM.
>
> Thanks!


I tried that, and it failed as expected.


$ git diff
diff --git a/drivers/firmware/efi/libstub/arm32-stub.c
b/drivers/firmware/efi/libstub/arm32-stub.c
index becbda4..5ad7bbd 100644
--- a/drivers/firmware/efi/libstub/arm32-stub.c
+++ b/drivers/firmware/efi/libstub/arm32-stub.c
@@ -28,6 +28,8 @@ efi_status_t
check_platform_features(efi_system_table_t *sys_table_arg)
        return EFI_SUCCESS;
 }

+void * foo = (void *)check_platform_features;
+
 static efi_guid_t screen_info_guid = LINUX_EFI_ARM_SCREEN_INFO_TABLE_GUID;

 struct screen_info *alloc_screen_info(efi_system_table_t *sys_table_arg)
$ make ARCH=arm  CROSS_COMPILE=arm-linux-gnueabihf- defconfig
drivers/firmware/efi/libstub/
*** Default configuration is based on 'multi_v7_defconfig'
#
# configuration written to .config
#
scripts/kconfig/conf  --syncconfig Kconfig
  CALL    scripts/checksyscalls.sh
  CC      drivers/firmware/efi/libstub/arm32-stub.o
  STUBCPY drivers/firmware/efi/libstub/arm32-stub.stub.o
00000000 R_ARM_ABS32       check_platform_features
drivers/firmware/efi/libstub/arm32-stub.stub.o: absolute symbol
references not allowed in the EFI stub
drivers/firmware/efi/libstub/Makefile:80: recipe for target
'drivers/firmware/efi/libstub/arm32-stub.stub.o' failed
make[3]: *** [drivers/firmware/efi/libstub/arm32-stub.stub.o] Error 1
make[3]: *** Deleting file 'drivers/firmware/efi/libstub/arm32-stub.stub.o'
Makefile:1705: recipe for target 'drivers/firmware/efi/libstub/' failed
make[2]: *** [drivers/firmware/efi/libstub/] Error 2
/home/masahiro/workspace/bsp/linux/Makefile:300: recipe for target
'__build_one_by_one' failed
make[1]: *** [__build_one_by_one] Error 2
Makefile:160: recipe for target 'sub-make' failed
make: *** [sub-make] Error 2





-- 
Best Regards
Masahiro Yamada
