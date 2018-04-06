Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbeDFScb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 14:32:31 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44293 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752454AbeDFSc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 14:32:29 -0400
X-Google-Smtp-Source: AIpwx49QZPJejNoyvgd/AABJfNv1Jf/98UTiH6ri7BbRKnLsa9qr+d0RYPmMxsx8m3/BvVOzYFqPcv1EwyHrHNnwibU=
MIME-Version: 1.0
In-Reply-To: <20180406173335.Horde.Qgml03BtHOxSl6SzIPgQLA9@messagerie.si.c-s.fr>
References: <20180322202007.23088-4-malat@debian.org> <20180405202648.2836-1-malat@debian.org>
 <20180406173335.Horde.Qgml03BtHOxSl6SzIPgQLA9@messagerie.si.c-s.fr>
From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 6 Apr 2018 20:32:08 +0200
X-Google-Sender-Auth: lOt1o4CN70_d710soptom7mBh5I
Message-ID: <CA+7wUswhZHNabB6kAcX8Cu8zMai15RzGn9euwdKau8kY48i-CA@mail.gmail.com>
Subject: Re: [PATCH v4 03/19] powerpc: Mark variable `l` as unused, remove `path`
To: LEROY Christophe <christophe.leroy@c-s.fr>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w36IWbT8021633

On Fri, Apr 6, 2018 at 5:33 PM, LEROY Christophe
<christophe.leroy@c-s.fr> wrote:
> Mathieu Malaterre <malat@debian.org> a écrit :
>
>> Add gcc attribute unused for `l` variable, replace `path` variable
>> directly
>> with prom_scratch. Fix warnings treated as errors with W=1:
>>
>>   arch/powerpc/kernel/prom_init.c:607:6: error: variable ‘l’ set but not
>> used [-Werror=unused-but-set-variable]
>>   arch/powerpc/kernel/prom_init.c:1388:8: error: variable ‘path’ set but
>> not used [-Werror=unused-but-set-variable]
>>
>> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>> ---
>> v4: redo v3 since path variable can be avoided
>> v3: really move path within ifdef DEBUG_PROM
>> v2: move path within ifdef DEBUG_PROM
>>
>>  arch/powerpc/kernel/prom_init.c | 11 +++++------
>>  1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/prom_init.c
>> b/arch/powerpc/kernel/prom_init.c
>> index f8a9a50ff9b5..4b223a9470be 100644
>> --- a/arch/powerpc/kernel/prom_init.c
>> +++ b/arch/powerpc/kernel/prom_init.c
>> @@ -604,7 +604,7 @@ static void __init early_cmdline_parse(void)
>>         const char *opt;
>>
>>         char *p;
>> -       int l = 0;
>> +       int l __maybe_unused = 0;
>
>
> Instead of hiding the problem with __maybe_unused, I think we could replace
> the
> #ifdef CONFIG_CMDLINE
> by a
> if (IS_ENABLED(CONFIG_CMDLINE_BOOL))
>
> This is recommanded by Linux codying style

Neat. I was not aware of this trick. Does not work in this case though:

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 7925f64fefde..19634739b279 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -604,17 +604,16 @@ static void __init early_cmdline_parse(void)
        const char *opt;

        char *p;
-       int l __maybe_unused = 0;
+       int l = 0;

        prom_cmd_line[0] = 0;
        p = prom_cmd_line;
        if ((long)prom.chosen > 0)
                l = prom_getprop(prom.chosen, "bootargs", p,
COMMAND_LINE_SIZE-1);
-#ifdef CONFIG_CMDLINE
-       if (l <= 0 || p[0] == '\0') /* dbl check */
-               strlcpy(prom_cmd_line,
-                       CONFIG_CMDLINE, sizeof(prom_cmd_line));
-#endif /* CONFIG_CMDLINE */
+       if (IS_ENABLED(CONFIG_CMDLINE_BOOL))
+               if (l <= 0 || p[0] == '\0') /* dbl check */
+                       strlcpy(prom_cmd_line,
+                               CONFIG_CMDLINE, sizeof(prom_cmd_line));
        prom_printf("command line: %s\n", prom_cmd_line);

 #ifdef CONFIG_PPC64


leads to:

  CC      arch/powerpc/kernel/prom_init.o
../arch/powerpc/kernel/prom_init.c: In function ‘early_cmdline_parse’:
../arch/powerpc/kernel/prom_init.c:616:5: error: ‘CONFIG_CMDLINE’
undeclared (first use in this function)
     CONFIG_CMDLINE, sizeof(prom_cmd_line));
     ^~~~~~~~~~~~~~
../arch/powerpc/kernel/prom_init.c:616:5: note: each undeclared
identifier is reported only once for each function it appears in
../scripts/Makefile.build:312: recipe for target
'arch/powerpc/kernel/prom_init.o' failed
make[6]: *** [arch/powerpc/kernel/prom_init.o] Error 1


> Christophe
>
>
>>
>>         prom_cmd_line[0] = 0;
>>         p = prom_cmd_line;
>> @@ -1386,7 +1386,7 @@ static void __init reserve_mem(u64 base, u64 size)
>>  static void __init prom_init_mem(void)
>>  {
>>         phandle node;
>> -       char *path, type[64];
>> +       char type[64];
>>         unsigned int plen;
>>         cell_t *p, *endp;
>>         __be32 val;
>> @@ -1407,7 +1407,6 @@ static void __init prom_init_mem(void)
>>         prom_debug("root_size_cells: %x\n", rsc);
>>
>>         prom_debug("scanning memory:\n");
>> -       path = prom_scratch;
>>
>>         for (node = 0; prom_next_node(&node); ) {
>>                 type[0] = 0;
>> @@ -1432,9 +1431,9 @@ static void __init prom_init_mem(void)
>>                 endp = p + (plen / sizeof(cell_t));
>>
>>  #ifdef DEBUG_PROM
>> -               memset(path, 0, PROM_SCRATCH_SIZE);
>> -               call_prom("package-to-path", 3, 1, node, path,
>> PROM_SCRATCH_SIZE-1);
>> -               prom_debug("  node %s :\n", path);
>> +               memset(prom_scratch, 0, PROM_SCRATCH_SIZE);
>> +               call_prom("package-to-path", 3, 1, node, prom_scratch,
>> PROM_SCRATCH_SIZE - 1);
>> +               prom_debug("  node %s :\n", prom_scratch);
>>  #endif /* DEBUG_PROM */
>>
>>                 while ((endp - p) >= (rac + rsc)) {
>> --
>> 2.11.0
>
>
>
