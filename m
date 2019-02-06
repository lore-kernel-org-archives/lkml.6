Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6E5C282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CBBF218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ltAFFpbL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfBFAL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:11:28 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40206 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbfBFALZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:11:25 -0500
Received: by mail-ed1-f68.google.com with SMTP id g22so4470551edr.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 16:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2KAHuwMyTRGYsbaIYMKPkZFwX6bf1ZHNXqsnMyzH5hI=;
        b=ltAFFpbLX6riPpISMRsV4BK0E20frARTUcEw3DZnRSBEbplmWYR8/Tl43WzskkL0cY
         sLCC4Q9CAfdwcFZzKTlp15PXmnip5ccO1JEUc5TtMZ4spxQp2spebVSZ0GnL+AM90rWJ
         Dszfsl9x7DoVmfIAoxJk03N8w6663hLB6uZPS/bAWRf3pFnFBpEyTM5nEyrfJYP9ertX
         oKytzR93CvTbFmG0qRzVk4uPzl8Zl/TTlrHeTjez2YeAnrRo9DyfweuK3Lo5+/K3npkZ
         tI+HgjP2FPLtakxIwPi4NMnrsrNnlM/1U7RHf2SWYbZHs3JjGUdSY4yrkPLFteaZKNFe
         jN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2KAHuwMyTRGYsbaIYMKPkZFwX6bf1ZHNXqsnMyzH5hI=;
        b=qH1ySDMTK5js+QdLLk4Y9bqFl3te1gLKzpCqiyXhMM4xaleBrhd0D2e99zVa9pAsd3
         ooBBzXD/35YJl8QGJt355z+8DbcSC0qc5g7Cb6jcV0iOFR32biVYYbMB2uexYi7u357j
         L1LJUk4gvEw5g9knXMr2mXWx2FYs31Izz84/QFteR030rPKHajpnqc03ivY9kOmsQHzp
         3mjCB+79n1yIKjIE5nac0qTlagJhfRP2NlwKFFj0bWRExcRZY8as1Et3IFmbpJ9vNnRF
         AUeYStvjp58lbD5WvhIRcZtXNzCsBhpbdclR0HMYyDxP9MRA7cNEvjqG1cH/zqshcEyE
         m8hA==
X-Gm-Message-State: AHQUAuaAFrtzaR0rEZKCU1KOlun5jj3oMjZrEumCGa8CuMpTgJgQRLdS
        bHzKNPS+YrDn0kVPB/Pre1z+uwR2H+g=
X-Google-Smtp-Source: AHgI3IZPMMfUQL8e2mdHJ3xyqYq/ieMJhjiuAagotsX1Sebcy2rD7NPek9lnUS7foH1nNA/mRrGhUg==
X-Received: by 2002:aa7:c55a:: with SMTP id s26mr5962934edr.132.1549411884190;
        Tue, 05 Feb 2019 16:11:24 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p30sm5489594eda.68.2019.02.05.16.11.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 05 Feb 2019 16:11:23 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCH 11/32] x86/vdso/Makefile: Add vobjs32
Date:   Wed,  6 Feb 2019 00:10:45 +0000
Message-Id: <20190206001107.16488-12-dima@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206001107.16488-1-dima@arista.com>
References: <20190206001107.16488-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As for 64-bit vdso objects, handle ia32/i386 objects in array.
This is a preparation ground to avoid code duplication on introduction
of timens vdso.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/Makefile | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 5bfe2243a08f..bc0bdbf49397 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -18,6 +18,8 @@ VDSO32-$(CONFIG_IA32_EMULATION)	:= y
 
 # files to link into the vdso
 vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o
+vobjs32-y := vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
+vobjs32-y += vdso32/vclock_gettime.o
 
 # files to link into kernel
 obj-y				+= vma.o
@@ -31,10 +33,12 @@ vdso_img-$(VDSO32-y)		+= 32
 obj-$(VDSO32-y)			+= vdso32-setup.o
 
 vobjs := $(foreach F,$(vobjs-y),$(obj)/$F)
+vobjs32 := $(foreach F,$(vobjs32-y),$(obj)/$F)
 
 $(obj)/vdso.o: $(obj)/vdso.so
 
 targets += vdso.lds $(vobjs-y)
+targets += vdso32/vdso32.lds $(vobjs32-y)
 
 # Build the vDSO image C files and link them in.
 vdso_img_objs := $(vdso_img-y:%=vdso-image-%.o)
@@ -125,10 +129,6 @@ $(obj)/vdsox32.so.dbg: $(obj)/vdsox32.lds $(vobjx32s) FORCE
 CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
 VDSO_LDFLAGS_vdso32.lds = -m elf_i386 -soname linux-gate.so.1
 
-targets += vdso32/vdso32.lds
-targets += vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
-targets += vdso32/vclock_gettime.o
-
 KBUILD_AFLAGS_32 := $(filter-out -m64,$(KBUILD_AFLAGS)) -DBUILD_VDSO
 $(obj)/vdso32.so.dbg: KBUILD_AFLAGS = $(KBUILD_AFLAGS_32)
 $(obj)/vdso32.so.dbg: asflags-$(CONFIG_X86_64) += -m32
@@ -153,12 +153,7 @@ endif
 
 $(obj)/vdso32.so.dbg: KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
 
-$(obj)/vdso32.so.dbg: FORCE \
-		      $(obj)/vdso32/vdso32.lds \
-		      $(obj)/vdso32/vclock_gettime.o \
-		      $(obj)/vdso32/note.o \
-		      $(obj)/vdso32/system_call.o \
-		      $(obj)/vdso32/sigreturn.o
+$(obj)/vdso32.so.dbg: $(obj)/vdso32/vdso32.lds $(vobjs32) FORCE
 	$(call if_changed,vdso)
 
 #
-- 
2.20.1

