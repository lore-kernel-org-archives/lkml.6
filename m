Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBA1C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F09208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F09208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389471AbeHPKlk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 06:41:40 -0400
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:52888 "EHLO smtp2.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387888AbeHPKli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 06:41:38 -0400
Received: from math.ut.ee (unknown [IPv6:2001:bb8:2002:2400:5054:ff:fe3b:8db9])
        by smtp2.it.da.ut.ee (Postfix) with ESMTP id AC17C902C5;
        Thu, 16 Aug 2018 10:44:58 +0300 (EEST)
Received: by math.ut.ee (Postfix, from userid 1014)
        id 993472209A8; Thu, 16 Aug 2018 10:44:56 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by math.ut.ee (Postfix) with ESMTP id 9794822048D;
        Thu, 16 Aug 2018 10:44:56 +0300 (EEST)
Date:   Thu, 16 Aug 2018 10:44:56 +0300 (EEST)
From:   Meelis Roos <mroos@linux.ee>
To:     linux-powerpc@vger.kernel.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: ptrace compile failure with gcc-8.2 on 32-bit powerpc
Message-ID: <alpine.LRH.2.21.1808161041350.16413@math.ut.ee>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After upgrading my distro compiler to gcc-8.2, Linux fails to compile on 
32-bit powerpc (tested with 4.17, 4.18 and v4.18-7873-gf91e654474d4).


  CC      arch/powerpc/kernel/ptrace.o
In file included from ./include/linux/bitmap.h:9,
                 from ./include/linux/cpumask.h:12,
                 from ./include/linux/rcupdate.h:44,
                 from ./include/linux/rculist.h:11,
                 from ./include/linux/pid.h:5,
                 from ./include/linux/sched.h:14,
                 from arch/powerpc/kernel/ptrace.c:19:
In function ¡memcpy¢,
    inlined from ¡user_regset_copyin¢ at ./include/linux/regset.h:295:4,
    inlined from ¡vr_set¢ at arch/powerpc/kernel/ptrace.c:619:9:
./include/linux/string.h:345:9: error: ¡__builtin_memcpy¢ offset [-527, -529] is out of the bounds [0, 16] of object ¡vrsave¢ with type ¡union <anonymous>¢ [-Werror=array-bounds]
  return __builtin_memcpy(p, q, size);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/kernel/ptrace.c: In function ¡vr_set¢:
arch/powerpc/kernel/ptrace.c:614:5: note: ¡vrsave¢ declared here
   } vrsave;
     ^~~~~~
In file included from ./include/linux/bitmap.h:9,
                 from ./include/linux/cpumask.h:12,
                 from ./include/linux/rcupdate.h:44,
                 from ./include/linux/rculist.h:11,
                 from ./include/linux/pid.h:5,
                 from ./include/linux/sched.h:14,
                 from arch/powerpc/kernel/ptrace.c:19:
In function ¡memcpy¢,
    inlined from ¡user_regset_copyout¢ at ./include/linux/regset.h:270:4,
    inlined from ¡vr_get¢ at arch/powerpc/kernel/ptrace.c:572:9:
./include/linux/string.h:345:9: error: ¡__builtin_memcpy¢ offset [-527, -529] is out of the bounds [0, 16] of object ¡vrsave¢ with type ¡union <anonymous>¢ [-Werror=array-bounds]
  return __builtin_memcpy(p, q, size);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/kernel/ptrace.c: In function ¡vr_get¢:
arch/powerpc/kernel/ptrace.c:567:5: note: ¡vrsave¢ declared here
   } vrsave;
     ^~~~~~
cc1: all warnings being treated as errors
make[1]: *** [scripts/Makefile.build:311: arch/powerpc/kernel/ptrace.o] Error 1


-- 
Meelis Roos (mroos@linux.ee)
