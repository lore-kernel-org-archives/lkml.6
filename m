Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbeDEF6D convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 01:58:03 -0400
Received: from ozlabs.org ([103.22.144.67]:39249 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750835AbeDEF6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 01:58:02 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: LEROY Christophe <christophe.leroy@c-s.fr>,
        Mathieu Malaterre <malat@debian.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "Paul Mackerras" <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 03/19] powerpc: Mark variables as unused
In-Reply-To: <20180329181422.Horde.4gvIQbpSZkuyC4Yzg06PKw2@messagerie.si.c-s.fr>
References: <20180322202007.23088-4-malat@debian.org> <20180328193307.978-1-malat@debian.org> <20180329181422.Horde.4gvIQbpSZkuyC4Yzg06PKw2@messagerie.si.c-s.fr>
Date: Thu, 05 Apr 2018 15:57:59 +1000
Message-ID: <87fu4atct4.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LEROY Christophe <christophe.leroy@c-s.fr> writes:

> Mathieu Malaterre <malat@debian.org> a écrit :
>
>> Add gcc attribute unused for two variables. Fix warnings treated as errors
>> with W=1:
>>
>>   arch/powerpc/kernel/prom_init.c:1388:8: error: variable ‘path’ set  
>> but not used [-Werror=unused-but-set-variable]
>>
>> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>> ---
>> v2: move path within ifdef DEBUG_PROM
>>
>>  arch/powerpc/kernel/prom_init.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/prom_init.c  
>> b/arch/powerpc/kernel/prom_init.c
>> index acf4b2e0530c..4163b11abb6c 100644
>> --- a/arch/powerpc/kernel/prom_init.c
>> +++ b/arch/powerpc/kernel/prom_init.c
>> @@ -603,7 +603,7 @@ static void __init early_cmdline_parse(void)
>>  	const char *opt;
>>
>>  	char *p;
>> -	int l = 0;
>> +	int l __maybe_unused = 0;
>>
>>  	prom_cmd_line[0] = 0;
>>  	p = prom_cmd_line;
>> @@ -1385,7 +1385,7 @@ static void __init reserve_mem(u64 base, u64 size)
>>  static void __init prom_init_mem(void)
>>  {
>>  	phandle node;
>> -	char *path, type[64];
>> +	char *path __maybe_unused, type[64];
>
> You should enclose that in an ifdef DEBUG_PROM instead of hiding the warning

I disagree, the result is horrible:

 static void __init prom_init_mem(void)
 {
	phandle node;
-	char *path, type[64];
+#ifdef DEBUG_PROM
+	char *path;
+#endif
+	char type[64];
	unsigned int plen;
	cell_t *p, *endp;
	__be32 val;


The right fix is to move the debug logic into a helper, and put the path
in there, eg. something like (not tested):

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index f9d6befb55a6..b02fa2ccc70b 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1389,6 +1389,18 @@ static void __init reserve_mem(u64 base, u64 size)
 	mem_reserve_cnt = cnt + 1;
 }
 
+#ifdef DEBUG_PROM
+static void prom_debug_path(phandle node)
+{
+	char *path;
+	path = prom_scratch;
+	memset(path, 0, PROM_SCRATCH_SIZE);
+	call_prom("package-to-path", 3, 1, node, path, PROM_SCRATCH_SIZE-1);
+	prom_debug("  node %s :\n", path);
+}
+#else
+static void prom_debug_path(phandle node) { }
+#endif /* DEBUG_PROM */
 /*
  * Initialize memory allocation mechanism, parse "memory" nodes and
  * obtain that way the top of memory and RMO to setup out local allocator
@@ -1441,11 +1453,7 @@ static void __init prom_init_mem(void)
 		p = regbuf;
 		endp = p + (plen / sizeof(cell_t));
 
-#ifdef DEBUG_PROM
-		memset(path, 0, PROM_SCRATCH_SIZE);
-		call_prom("package-to-path", 3, 1, node, path, PROM_SCRATCH_SIZE-1);
-		prom_debug("  node %s :\n", path);
-#endif /* DEBUG_PROM */
+		prom_debug_path(node);
 
 		while ((endp - p) >= (rac + rsc)) {
 			unsigned long base, size;


Although that also begs the question of why the hell do we need path at
all, and not just use prom_scratch directly?

cheers
