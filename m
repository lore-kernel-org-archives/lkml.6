Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753218AbeCQXNV (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 19:13:21 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33850 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751849AbeCQXNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 19:13:19 -0400
X-Google-Smtp-Source: AG47ELtdMtUV8Qr+ZHVR2enAwYM1OBqgI9p6OYwPNkVj1IBZn+0SRPS6plvPFRT4trhdI+ANBQLmRaxrfNH/7QmryTY=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3Vf-ubqgdH67HE6LEfR=Vg6ZCf6+77qE+ZrwUocLCWTQ@mail.gmail.com>
References: <20180316132529.45126501@canb.auug.org.au> <CABeXuvrFkASp1g5LDW0MsENqtHRiT=Vp=F5GN3XdhGzaXkHNsw@mail.gmail.com>
 <CAK8P3a3Vf-ubqgdH67HE6LEfR=Vg6ZCf6+77qE+ZrwUocLCWTQ@mail.gmail.com>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Sat, 17 Mar 2018 16:13:18 -0700
Message-ID: <CABeXuvpoXWx3ndJ93aKA0ARQqdx4iJXn9FN4MnceYC3RTsAvvA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the y2038 tree
To: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I posted the patch.

The patch has simple changes. Let me know if maybe posting a new
version makes sense.

I also needed this patch to build linux-next:

commit b784c76bb7c1c440a4ce06a18f4b3a936f33967d
Author: Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Fri Mar 16 20:57:10 2018 -0700

    i40iw: add missing irq.h include

    iwarp driver began using irq_get_affinity_mask in commit 7e952b19eb638.
    Add the needed include irq.h to get the definition.

    This was found while trying allmodconfig for arm64, s390, and sparc.

    Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>

diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index a51798578f27..506b10e8ea4e 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -32,6 +32,7 @@
 *
 *******************************************************************************/

+#include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/random.h>

-Deepa

On Fri, Mar 16, 2018 at 1:14 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Mar 16, 2018 at 6:23 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>> Hi Arnd,
>>
>> Do you want me to send the fix as a patch or should I re-post the series?
>
> Please send a fix relative to linux-next. Due to my travel next week, I might
> not be able to apply it right away but maybe Stephen can add it on top until
> I get back.
>
>       Arnd
>
>> On Thu, Mar 15, 2018 at 7:25 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>> Hi Arnd,
>>>
>>> After merging the y2038 tree, today's linux-next build (s390 allnoconfig)
>>> failed like this:
>>>
>>> In file included from include/linux/elf.h:5:0,
>>>                  from include/linux/module.h:15,
>>>                  from init/main.c:16:
>>> arch/s390/include/asm/elf.h:138:1: error: unknown type name 's390_compat_regs'
>>>
>>> Caused by commit
>>>
>>>   f00689038f71 ("include: Move compat_timespec/ timeval to compat_time.h")
>>>
