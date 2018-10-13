Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57876C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 20:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BFA2077C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 20:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5BFA2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbeJNERL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 00:17:11 -0400
Received: from mx2.cyber.ee ([193.40.6.72]:58149 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725732AbeJNERL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 00:17:11 -0400
To:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From:   Meelis Roos <mroos@linux.ee>
Subject: 32-bit poweroc compile failure in v4.19-rc7-166-g7ec21823634d
Message-ID: <17d36e6c-f99a-abfb-12cd-fa4b14bc7e09@linux.ee>
Date:   Sat, 13 Oct 2018 23:38:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to test the fix to 32-bit poweroc boot hang but found that current git does not compile on 32bit poweroc at all for me:

   CC      arch/powerpc/kernel/ptrace.o
In file included from ./include/linux/bitmap.h:9,
                  from ./include/linux/cpumask.h:12,
                  from ./include/linux/rcupdate.h:44,
                  from ./include/linux/rculist.h:11,
                  from ./include/linux/pid.h:5,
                  from ./include/linux/sched.h:14,
                  from arch/powerpc/kernel/ptrace.c:19:
In function ‘memcpy’,
     inlined from ‘user_regset_copyin’ at ./include/linux/regset.h:295:4,
     inlined from ‘vr_set’ at arch/powerpc/kernel/ptrace.c:619:9:
./include/linux/string.h:345:9: error: ‘__builtin_memcpy’ offset [-527, -529] is out of the bounds [0, 16] of object ‘vrsave’ with type ‘union <anonymous>’ [-Werror=array-bounds]
   return __builtin_memcpy(p, q, size);
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/kernel/ptrace.c: In function ‘vr_set’:
arch/powerpc/kernel/ptrace.c:614:5: note: ‘vrsave’ declared here
    } vrsave;
      ^~~~~~
In file included from ./include/linux/bitmap.h:9,
                  from ./include/linux/cpumask.h:12,
                  from ./include/linux/rcupdate.h:44,
                  from ./include/linux/rculist.h:11,
                  from ./include/linux/pid.h:5,
                  from ./include/linux/sched.h:14,
                  from arch/powerpc/kernel/ptrace.c:19:
In function ‘memcpy’,
     inlined from ‘user_regset_copyout’ at ./include/linux/regset.h:270:4,
     inlined from ‘vr_get’ at arch/powerpc/kernel/ptrace.c:572:9:
./include/linux/string.h:345:9: error: ‘__builtin_memcpy’ offset [-527, -529] is out of the bounds [0, 16] of object ‘vrsave’ with type ‘union <anonymous>’ [-Werror=array-bounds]
   return __builtin_memcpy(p, q, size);
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/kernel/ptrace.c: In function ‘vr_get’:
arch/powerpc/kernel/ptrace.c:567:5: note: ‘vrsave’ declared here
    } vrsave;
      ^~~~~~
cc1: all warnings being treated as errors
make[1]: *** [scripts/Makefile.build:306: arch/powerpc/kernel/ptrace.o] Error 1
make: *** [Makefile:1052: arch/powerpc/kernel] Error 2

-- 
Meelis Roos <mroos@linux.ee>
