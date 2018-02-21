Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224mT8p848xniANgMczM496MTmBgsX+SBJ89j9iB2LUc8mdneEOsqUoTVGiW9xDlqy2S8RM/
ARC-Seal: i=1; a=rsa-sha256; t=1519218672; cv=none;
        d=google.com; s=arc-20160816;
        b=u3yyV0aWNo9OZqe0TF2Ehp9JyUpdryNEU2jnMOzBCOn83/7XYvpfsNzWIP8SylC3nN
         k2V2I4qpRkGVmKtDCDdrhQ7S48FlIe0Kpio2k9VIQyO5fyWjwcZYg0jK1n3wXdw/tQLr
         GAn2+kwW0Q0LqaZNK05Gw4Mu7I56i0L++bubdrwqGprxhwrEjKTBEFnliDE+kd0Sdl+2
         8yOdidIPuFLs1olsdIwM1esh5hVB5KBwKjmP4rSwIHEtfxxyHHc2h8CQTG9ia+SEqoK5
         0eXSuQ7IR+zUOdLJtYt750QI4AYXIEIz7yDrFIbs255aMDoQSOIJ7xE09KpR8rjCY0n7
         XiAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Hs52wqfv9Kgdd2p7lNInWpTjfyaQaz4Wg0iusXZveSU=;
        b=0a/id48jqmqU5bcfx/KFyM0KUjtDHaxotOAGkfpyIdLqZThOHT2nerpfcInrd3aTOt
         d1sQ4J6w4+jwGwedTasUHwOrOy+McDUOHtokHLm3BYhK0wuAkHj/J3dNjjCP6YySMxSm
         W/oCrcW0slhEuiOQKe2QVmlaN+SZxIAUk5N8i+Pvph1XT9ldXS0ZRkxvAzDP8sLaT6cC
         wA2T963QXKeD56/GfOLXBLIg4ljDuqxPSOyk6sWZx4zoyRfyqb118OFRSFopiJUPqrc5
         mzJozzgTeN3rgV5uPXpPH24i5e0LsH4x+xzhEKAiSlmIvv+c1ALXs+5ckypgCNnasjG9
         jDMw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mathieu Malaterre <mathieu.malaterre@gmail.com>,
	Marcin Nowakowski <marcin.nowakowski@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org,
	Mathieu Malaterre <malat@debian.org>,
	James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.15 114/163] MIPS: Fix incorrect mem=X@Y handling
Date: Wed, 21 Feb 2018 13:49:03 +0100
Message-Id: <20180221124536.453895962@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015817295324421?=
X-GMAIL-MSGID: =?utf-8?q?1593016238866133241?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marcin Nowakowski <marcin.nowakowski@mips.com>

commit 67a3ba25aa955198196f40b76b329b3ab9ad415a upstream.

Commit 73fbc1eba7ff ("MIPS: fix mem=X@Y commandline processing") added a
fix to ensure that the memory range between PHYS_OFFSET and low memory
address specified by mem= cmdline argument is not later processed by
free_all_bootmem.  This change was incorrect for systems where the
commandline specifies more than 1 mem argument, as it will cause all
memory between PHYS_OFFSET and each of the memory offsets to be marked
as reserved, which results in parts of the RAM marked as reserved
(Creator CI20's u-boot has a default commandline argument 'mem=256M@0x0
mem=768M@0x30000000').

Change the behaviour to ensure that only the range between PHYS_OFFSET
and the lowest start address of the memories is marked as protected.

This change also ensures that the range is marked protected even if it's
only defined through the devicetree and not only via commandline
arguments.

Reported-by: Mathieu Malaterre <mathieu.malaterre@gmail.com>
Signed-off-by: Marcin Nowakowski <marcin.nowakowski@mips.com>
Fixes: 73fbc1eba7ff ("MIPS: fix mem=X@Y commandline processing")
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # v4.11+
Tested-by: Mathieu Malaterre <malat@debian.org>
Patchwork: https://patchwork.linux-mips.org/patch/18562/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/setup.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -375,6 +375,7 @@ static void __init bootmem_init(void)
 	unsigned long reserved_end;
 	unsigned long mapstart = ~0UL;
 	unsigned long bootmap_size;
+	phys_addr_t ramstart = (phys_addr_t)ULLONG_MAX;
 	bool bootmap_valid = false;
 	int i;
 
@@ -395,7 +396,8 @@ static void __init bootmem_init(void)
 	max_low_pfn = 0;
 
 	/*
-	 * Find the highest page frame number we have available.
+	 * Find the highest page frame number we have available
+	 * and the lowest used RAM address
 	 */
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
 		unsigned long start, end;
@@ -407,6 +409,8 @@ static void __init bootmem_init(void)
 		end = PFN_DOWN(boot_mem_map.map[i].addr
 				+ boot_mem_map.map[i].size);
 
+		ramstart = min(ramstart, boot_mem_map.map[i].addr);
+
 #ifndef CONFIG_HIGHMEM
 		/*
 		 * Skip highmem here so we get an accurate max_low_pfn if low
@@ -436,6 +440,13 @@ static void __init bootmem_init(void)
 		mapstart = max(reserved_end, start);
 	}
 
+	/*
+	 * Reserve any memory between the start of RAM and PHYS_OFFSET
+	 */
+	if (ramstart > PHYS_OFFSET)
+		add_memory_region(PHYS_OFFSET, ramstart - PHYS_OFFSET,
+				  BOOT_MEM_RESERVED);
+
 	if (min_low_pfn >= max_low_pfn)
 		panic("Incorrect memory mapping !!!");
 	if (min_low_pfn > ARCH_PFN_OFFSET) {
@@ -664,9 +675,6 @@ static int __init early_parse_mem(char *
 
 	add_memory_region(start, size, BOOT_MEM_RAM);
 
-	if (start && start > PHYS_OFFSET)
-		add_memory_region(PHYS_OFFSET, start - PHYS_OFFSET,
-				BOOT_MEM_RESERVED);
 	return 0;
 }
 early_param("mem", early_parse_mem);
