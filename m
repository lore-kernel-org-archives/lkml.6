Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C790DC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A7C20842
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="F9sdU4k4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A7C20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932695AbeGILug (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:50:36 -0400
Received: from services.gouders.net ([141.101.32.176]:51162 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754468AbeGILue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:50:34 -0400
Received: from localhost ([193.175.198.193])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id w69BddEI005408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Jul 2018 13:39:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1531136381; bh=Hu4mv6WXYIsO5b8fPnT6fYj3l9+xi6Zq/ww2z0AEKjs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date;
        b=F9sdU4k45TepIyRHaosyiE7CgBDVIxlhEKc8wH1zWveDHrebBWwnWuxG76zHyHIyE
         2ppVBFstn9LXKI//U5mhCKUTfDS+NpN8cNw1SmvwWkON88WEG6o4Nzd44nIimY70X0
         rfECc4soK7YnLUrqP+Pkjb8UEEhJ1Z/H6BiCfumM=
From:   Dirk Gouders <dirk@gouders.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, Ulf Magnusson <ulfalizer@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 05/12] kconfig: make syncconfig update .config regardless of sym_change_count
In-Reply-To: <ghbmbk0wbj.fsf@quad.gouders.net> (Dirk Gouders's message of
        "Sat, 07 Jul 2018 01:38:08 +0200")
References: <1530758389-30862-1-git-send-email-yamada.masahiro@socionext.com>
        <1530758389-30862-6-git-send-email-yamada.masahiro@socionext.com>
        <ghva9simch.fsf@lena.gouders.net> <ghbmbk0wbj.fsf@quad.gouders.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
Date:   Mon, 09 Jul 2018 13:39:36 +0200
Message-ID: <ghwou4prif.fsf@lena.gouders.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Dirk Gouders <dirk@gouders.net> writes:

> Dirk Gouders <dirk@gouders.net> writes:
>
>> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
>>
>>> syncconfig updates the .config only when sym_change_count > 0, i.e.
>>> any change in config symbols has been detected.
>>>
>>> Not only symbols but also comments are contained in the .config file.
>>> If only comments are updated, they are not fed back to the .config,
>>> then the stale comments are left-over.  Of course, this is just a
>>> matter of comments, but why not fix it.
>>
>> Hello Masahiro,
>>
>> I am currently looking at and testing this series.
>>
>> First: For this patch I would suggest to also edit the syncconfig
>>        section of "conf --help".
>>
>> Further, on a slow laptop, I was suspecting, this patch to cause full
>> rebuilds of everything, each time I ran "make syncconfig" followed by
>> "make" but could not verify this on another machine, so perhaps I am
>> just (for testing purposes) removing the wrong files (modules.builtin
>> for example) -- I am still testing.
>>
>> But, what irritates me with testing is that (also without your
>> patches) two consecutive "make" produce different output, one of them
>> always shows a warning and this is reproducable.  I just want to make
>> sure there is no other problem that influences my testing:
>>
>> $ make
>>   CALL    scripts/checksyscalls.sh
>>   DESCEND  objtool
>>   CHK     include/generated/compile.h
>>   DATAREL arch/x86/boot/compressed/vmlinux
>> Kernel: arch/x86/boot/bzImage is ready  (#15)
>>   Building modules, stage 2.
>>   MODPOST 211 modules
>>
>> $ make
>>   CALL    scripts/checksyscalls.sh
>>   DESCEND  objtool
>>   CHK     include/generated/compile.h
>>   LD      arch/x86/boot/compressed/vmlinux
>> ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-only section `.head.text'
>> ld: warning: creating a DT_TEXTREL in object.
>>   ZOFFSET arch/x86/boot/zoffset.h
>>   AS      arch/x86/boot/header.o
>>   LD      arch/x86/boot/setup.elf
>>   OBJCOPY arch/x86/boot/setup.bin
>>   OBJCOPY arch/x86/boot/vmlinux.bin
>>   BUILD   arch/x86/boot/bzImage
>> Setup is 15580 bytes (padded to 15872 bytes).
>> System is 8069 kB
>> CRC e01d75ec
>> Kernel: arch/x86/boot/bzImage is ready  (#15)
>>   Building modules, stage 2.
>>   MODPOST 211 modules
>
> I spent some more time with the behaviour described above and bisected
> to the commit after that two consecutive invocations of "make" (on an
> already compiled tree) seem to do different things.  That commit is
> 98f78525371b55cc (x86/boot: Refuse to build with data relocations), so I
> put Kees and Ingo on CC.
>
> I did the bisecting on another system, so I'll provide the output of two
> consecutive "make" on an already compiled tree on that machine:
>
> $ make
>   CALL    scripts/checksyscalls.sh
>   DESCEND  objtool
>   CHK     include/generated/compile.h
>   DATAREL arch/x86/boot/compressed/vmlinux
> Kernel: arch/x86/boot/bzImage is ready  (#48)
>   Building modules, stage 2.
>   MODPOST 165 modules
>
> $ make
>   CALL    scripts/checksyscalls.sh
>   DESCEND  objtool
>   CHK     include/generated/compile.h
>   LD      arch/x86/boot/compressed/vmlinux
>   ZOFFSET arch/x86/boot/zoffset.h
>   AS      arch/x86/boot/header.o
>   LD      arch/x86/boot/setup.elf
>   OBJCOPY arch/x86/boot/setup.bin
>   OBJCOPY arch/x86/boot/vmlinux.bin
>   BUILD   arch/x86/boot/bzImage
> Setup is 15644 bytes (padded to 15872 bytes).
> System is 6663 kB
> CRC 3eb90f40
> Kernel: arch/x86/boot/bzImage is ready  (#48)
>   Building modules, stage 2.
>   MODPOST 165 modules
>
> If I comment out $(call if_changed,check_data_rel) in
> arch/x86/boot/compressed/Makefile, two consecutive "make" produce
> identical output i.e. seem to not do different things:
>
> $ make
>   CALL    scripts/checksyscalls.sh
>   DESCEND  objtool
>   CHK     include/generated/compile.h
> Kernel: arch/x86/boot/bzImage is ready  (#49)
>   Building modules, stage 2.
>   MODPOST 165 modules
>
> $ make
>   CALL    scripts/checksyscalls.sh
>   DESCEND  objtool
>   CHK     include/generated/compile.h
> Kernel: arch/x86/boot/bzImage is ready  (#49)
>   Building modules, stage 2.
>   MODPOST 165 modules
>
> So, I guess this different behaviour of two consecutive "make" is not
> intentional but I am failing to understand why it happens.

I think, I solved the puzzle and perhaps, that saves others some time:

The problem is that "if_changed" was not designed for multiple use
inside a recipe and in the case of compressed/vmlinux, the 2-fold use
created a kind of flip-flop for situations when nothing has to be done
to build the target.

Because each of the two users of "if_changed" stores it's footprint in
.vmlinux.cmd but that file then isn't re-read, one of the two
"if_changed" calculates that nothing has to be done wheras the other one
recognizes a change in the commandline, because it sees the command-line
for the other part of the reciepe.

In the next make, the roles flip, because the previously satisfied
"if_changed" now sees the command-line of the other one.  And so on...

I am not a Kbuild expert but the attached patch fixes that problem by
introducing "if_changed_multi" that accepts two commands -- one whose
commandline should be checked and a second one that should be
executed.

Dirk


--=-=-=
Content-Disposition: inline; filename=flip-flop.patch
Content-Description: Fix flip-flop

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index fa42f895fdde..f39822fca994 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -107,8 +107,8 @@ define cmd_check_data_rel
 endef
 
 $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
-	$(call if_changed,check_data_rel)
-	$(call if_changed,ld)
+	$(call if_changed_multi,ld,check_data_rel)
+	$(call if_changed_multi,ld,ld)
 
 OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
 $(obj)/vmlinux.bin: vmlinux FORCE
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index b2d14f1136e8..3bf419319e09 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -265,6 +265,23 @@ if_changed = $(if $(strip $(any-prereq) $(arg-check)),                       \
 	$(echo-cmd) $(cmd_$(1));                                             \
 	printf '%s\n' 'cmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
 
+# echo command for command stored in $2
+# Short version is used, if $(quiet) equals `quiet_', otherwise full one.
+echo-cmd2 = $(if $($(quiet)cmd_$(2)),\
+	echo '  $(call escsq,$($(quiet)cmd_$(2)))$(echo-why)';)
+
+# Execute command arg2 if commandline for command arg1 or prerequisite(s) are
+# updated.
+#
+# This is safe for multiple use inside a recipe; arg1 and arg2 may be
+# identical.
+if_changed_multi = $(if $(strip $(any-prereq) $(arg-check)),                \
+	@set -e;                                                             \
+	$(echo-cmd2) : ; \
+	$(cmd_$(2));                                            \
+	printf '%s\n' 'cmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
+
+
 # Execute the command and also postprocess generated .d dependencies file.
 if_changed_dep = $(if $(strip $(any-prereq) $(arg-check) ),                  \
 	@set -e;                                                             \

--=-=-=--
