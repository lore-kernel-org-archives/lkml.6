Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9856C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 10:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91EDC20675
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 10:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbfALKAh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 05:00:37 -0500
Received: from mail.accesssoftek.com ([12.202.173.242]:47677 "EHLO
        mail.accesssoftek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfALKAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 05:00:37 -0500
Received: from vm-mail2k13.accesssoftek.com (172.16.0.242) by
 vm-mail2k13.accesssoftek.com (172.16.0.242) with Microsoft SMTP Server (TLS)
 id 15.0.1395.4; Sat, 12 Jan 2019 02:00:36 -0800
Received: from vm-mail2k13.accesssoftek.com ([::1]) by
 vm-mail2k13.accesssoftek.com ([::1]) with mapi id 15.00.1395.000; Sat, 12 Jan
 2019 02:00:36 -0800
From:   George Rimar <grimar@accesssoftek.com>
To:     Tri Vo <trong@android.com>, "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>
CC:     "dima@golovin.in" <dima@golovin.in>,
        "morbo@google.com" <morbo@google.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "matz@suse.de" <matz@suse.de>, "ruiu@google.com" <ruiu@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] x86_64: Add "-m elf_i386" when linking i386 object
 files.
Thread-Topic: [PATCH v3] x86_64: Add "-m elf_i386" when linking i386 object
 files.
Thread-Index: AQHUqemzjPdoQZ+FoUOJC0WuWoOLa6WrZ3sx
Date:   Sat, 12 Jan 2019 10:00:36 +0000
Message-ID: <1547286899727.75112@accesssoftek.com>
References: <CAKwvOdkR=1AzePbuFBcCW32shAK_cvR1iPiTGqHF=7MRH_oAjA@mail.gmail.com>,<20190111201012.71210-1-trong@android.com>
In-Reply-To: <20190111201012.71210-1-trong@android.com>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [95.174.98.187]
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: George Rimar <grimar@accesssoftek.com>

Best regards,
George | Developer | Access Softek, Inc

________________________________________
От: Tri Vo <trong@android.com>
Отправлено: 11 января 2019 г. 23:10
Кому: x86@kernel.org; tglx@linutronix.de; mingo@redhat.com; bp@alien8.de; hpa@zytor.com
Копия: George Rimar; dima@golovin.in; morbo@google.com; ndesaulniers@google.com; matz@suse.de; ruiu@google.com; linux-kernel@vger.kernel.org; Tri Vo
Тема: [PATCH v3] x86_64: Add "-m elf_i386" when linking i386 object files.

CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.  If you suspect potential phishing or spam email, report it to ReportSpam@accesssoftek.com

From: George Rimar <grimar@accesssoftek.com>

Linux kernel uses OUTPUT_FORMAT in it's linker scripts. Most of the time
-m option is passed to the linker with correct architecture, but
sometimes (at least for x86_64) the -m option contradicts OUTPUT_FORMAT
directive. Specifically, arch/x86/boot and arch/x86/realmode/rm modules
have i386 object files, but are linked with -m elf_x86_64 linker flag
when building for x86_64.

"man ld" doesn't explicitly state any tie-breakers between -m and
OUTPUT_FORMAT. BFD and Gold linkers override -m value with
OUTPUT_FORMAT. But LLVM lld has a different behavior. When supplied with
contradicting -m and OUTPUT_FORMAT values it fails with the following
error message:

  ld.lld: error: arch/x86/realmode/rm/header.o is incompatible with elf_x86_64

Suggested fix: just add correct -m after incorrect one (it overrides
it), so the linker invocation looks like this: ld -m elf_x86_64 -z
max-page-size=0x200000 -m elf_i386 --emit-relocs -T realmode.lds
header.o trampoline_64.o stack.o reboot.o -o realmode.elf

This is not a functional change for GNU ld, because (although not
explicitly documented) it already overrides -m EMULATION with
OUTPUT_FORMAT.

Tested by building x86_64 kernel with GNU gcc/ld toolchain and booting
it in QEMU.

Suggested-by: Dmitry Golovin <dima@golovin.in>
Signed-off-by: George Rimar <grimar@accesssoftek.com>
Signed-off-by: Tri Vo <trong@android.com>
Tested-by: Tri Vo <trong@android.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
---
v2: updated commit message to clarify that ld documentation is ambiguous w.r.t
    -m vs OUTPUT_FORMAT behavior.
v3: fixed/added SOB and "Tested-by" fields.

 arch/x86/boot/Makefile        | 2 +-
 arch/x86/realmode/rm/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 9b5adae9cc40..e2839b5c246c 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -100,7 +100,7 @@ $(obj)/zoffset.h: $(obj)/compressed/vmlinux FORCE
 AFLAGS_header.o += -I$(objtree)/$(obj)
 $(obj)/header.o: $(obj)/zoffset.h

-LDFLAGS_setup.elf      := -T
+LDFLAGS_setup.elf      := -m elf_i386 -T
 $(obj)/setup.elf: $(src)/setup.ld $(SETUP_OBJS) FORCE
        $(call if_changed,ld)

diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
index 4463fa72db94..96cb20de08af 100644
--- a/arch/x86/realmode/rm/Makefile
+++ b/arch/x86/realmode/rm/Makefile
@@ -47,7 +47,7 @@ $(obj)/pasyms.h: $(REALMODE_OBJS) FORCE
 targets += realmode.lds
 $(obj)/realmode.lds: $(obj)/pasyms.h

-LDFLAGS_realmode.elf := --emit-relocs -T
+LDFLAGS_realmode.elf := -m elf_i386 --emit-relocs -T
 CPPFLAGS_realmode.lds += -P -C -I$(objtree)/$(obj)

 targets += realmode.elf
--
2.20.1.97.g81188d93c3-goog

