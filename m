Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6045C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DDA2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kpw2ZIFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732062AbfA3Qc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:32:29 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:32913 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731623AbfA3Qc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:32:27 -0500
Received: by mail-ot1-f66.google.com with SMTP id i20so164220otl.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 08:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=P3LJhH6cgW4upA2EWRXXc/wXQNtn/k7S03s//A6su1g=;
        b=kpw2ZIFeUCBxsDcxNjhh3Hy585LqG168l0ocOK2C3yTm+7PjfjeB2Q9f8RSc2L3iLV
         6I+wP22GZsEtZQ7fFBgZfot3EC5ReLs8CDvET93xlb5LMd2dc+pa5PJVr0XcnEzpYvjB
         DBsWam1wJ5r0GHiXNttNVDJaablE5HVhUuXKQn0zso8RoQtQyqhXRSobk6gkoytWgRT2
         SeUEnTahHzJjfyV3t+Mqp8DRTIFJXt8ViDm1+g/7fkTgvxK7TFeXNHgWiMXv0YDhBChC
         sqx2pq0xKl4GMeJWMiRtAw+jwf/snlqQnOlrP3wVCq4bdTSeX+dfwUNrht7x2xAyPa1q
         Og8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=P3LJhH6cgW4upA2EWRXXc/wXQNtn/k7S03s//A6su1g=;
        b=Dq6ACGc3z/SF9f+/7m/Xdmy05GxAXfbjTxBcYTproAqbg7wWU9oE+oP6Odr5sWDGnm
         CKCKAo4AdOeRiBHGlIK3b6c7LhietYKzpiVb42LfG3QEIKX/Xn/Q6MCCkOC1D25gNaoU
         hiMuPQweJcO2AbM/C4p7NmXJlz3zneYLSgIIPPdr0wolERta8coSFyC5oEj+0C3UwvoM
         3KemaG6QlieRG/eFD5mIaGTdIwDf/dj2xFR2oGEUcztLOQg3VNT5I1/lxFchepv8gCow
         PB53W//J5Q4pV5umCTESqLke9tdoSLtseGeCd6xKkf5nj9K2utIGOvS/EbaEdd5TvCoN
         WWZw==
X-Gm-Message-State: AJcUukdbeBCNIZc18B3bol1YiOk9+QhGOb+JmqezwTGLYT/ozTNaXB2+
        7Zhn1CCTO/dXiIhosCdiZlVdyybdHK4Ao4L2TeImdQ==
X-Google-Smtp-Source: ALg8bN45MHCQnyC0t7Ivu27C/GsFmiyhloUnQg4Wml8VU64GpqLrhQuMqastC/b7fXBQGxkJXTqTmdlwEcVj9i9lhCs=
X-Received: by 2002:a9d:4c01:: with SMTP id l1mr23359047otf.242.1548865946597;
 Wed, 30 Jan 2019 08:32:26 -0800 (PST)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Wed, 30 Jan 2019 17:32:00 +0100
Message-ID: <CAG48ez0QRmU9fGV3x7nceGqBGADNTb66MnG4PW_xu+xnGUqg=g@mail.gmail.com>
Subject: ARM64 suggestion: reduce the compat address limit (currently 0x100000000)?
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

At the moment, compat tasks running on ARM64 can allocate memory up to
0x100000000 (TASK_SIZE_32). Testing on an Android device (with an
admittedly somewhat old kernel):

===========
$ cat mmap_filler.c
#include <sys/mman.h>
#include <unistd.h>
#include <err.h>
#include <stdlib.h>
#include <fcntl.h>
int main(void) {
  unsigned long size = 1UL<<31;
  while (size >= 0x1000UL) {
    void *res = mmap(NULL, size, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0);
    if (res == MAP_FAILED) size >>= 1;
  }
  int fd = open("/proc/self/maps", O_RDONLY);
  if (fd == -1) err(1, "open");
  while (1) {
    char buf[0x1000];
    ssize_t res = read(fd, buf, sizeof(buf));
    if (res == -1) err(1, "read");
    if (res == 0) _exit(0);
    ssize_t wres = write(1, buf, res);
    if (wres != res) errx(1, "write failed");
  }
}
$ arm-linux-gnueabi-gcc -static -o mmap_filler mmap_filler.c && adb
push mmap_filler /data/local/tmp/ && adb shell
/data/local/tmp/mmap_filler
mmap_filler: 1 file pushed. 16.3 MB/s (587008 bytes in 0.034s)
00008000-00010000 rw-p 00000000 00:00 0
00010000-00089000 r-xp 00000000 103:1d 2080772
  /data/local/tmp/mmap_filler
00089000-00098000 rw-p 00000000 00:00 0
00098000-0009a000 rw-p 00078000 103:1d 2080772
  /data/local/tmp/mmap_filler
0009a000-0009b000 rw-p 00000000 00:00 0
0009b000-00752000 rw-p 00000000 00:00 0                                  [heap]
00752000-00774000 rw-p 00000000 00:00 0                                  [heap]
00774000-f081b000 rw-p 00000000 00:00 0                                  [heap]
f081b000-f081c000 r--p 00000000 00:00 0                                  [vvar]
f081c000-f081e000 r-xp 00000000 00:00 0                                  [vdso]
f081e000-ff710000 rw-p 00000000 00:00 0
ff810000-ff831000 rw-p 00000000 00:00 0                                  [stack]
ff831000-ffff0000 rw-p 00000000 00:00 0
ffff0000-ffff1000 r-xp 00000000 00:00 0
  [kuserhelpers]
ffff1000-100000000 rw-p 00000000 00:00 0
===========

This means that mmap() allocations do not adhere to section 6.5.8 of
C99 ("If the
expression P points to an element of an array object and the
expression Q points to the
last element of the same array object, the pointer expression Q+1
compares greater than
P.") if you treat mmap() allocations as returning an array.

In practice, I've also seen code that does things like computing a
pointer that is out of bounds by a few bytes and then comparing it
against the end of the array; while this is UB according to C99, it
probably makes sense to try to avoid breaking such code.

X86-64's compat code uses the limit 0xFFFFe000 (IA32_PAGE_OFFSET),
which I think makes more sense. Would it make sense to do something
like the following (untested)?

==============
diff --git a/arch/arm64/include/asm/processor.h
b/arch/arm64/include/asm/processor.h
index f1a7ab18faf3..a0c7eb1358dd 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -57,7 +57,7 @@
 #define TASK_SIZE_64           (UL(1) << vabits_user)

 #ifdef CONFIG_COMPAT
-#define TASK_SIZE_32           UL(0x100000000)
+#define TASK_SIZE_32           UL(0xFFFFe000)
 #define TASK_SIZE              (test_thread_flag(TIF_32BIT) ? \
                                TASK_SIZE_32 : TASK_SIZE_64)
 #define TASK_SIZE_OF(tsk)      (test_tsk_thread_flag(tsk, TIF_32BIT) ? \
==============
