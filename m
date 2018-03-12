Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELvQctXZ7uF1edF0cAfo94+1x4C8a2ilfaXElr+nim/WlL4r9t6eD0klrNMktoG7EkrZqpq1
ARC-Seal: i=1; a=rsa-sha256; t=1520824089; cv=none;
        d=google.com; s=arc-20160816;
        b=uy8Ja7wPTFJwLnQJCoR63ceqR01KH7SNCKcKmrKkxNsFiOGqwgFlq8GSzko5euNjKb
         QpZRfw1x/GGmwIsnST1nRu8OfR5Dwwvn2InGJoq6RQC0QHp5FePiskJYBvmLfcof9eqh
         VH8Ly+XSbUUdmsjip4MsCbiThhYiiCe5O5hyA1IDdyih2Qwz32Oun8o119y09KYOMopb
         josooeR2qP08t0+74D/OJXjsftErJJWlMnchD4GhLhFAGJIGneh/USaUPo9MEIzID3ni
         Ldu0Ib3hXF61eFxE7UhlfTJ3oaJ55vH9aqRYsfDuQbKj6F2uqpxeR2hjoQINlilITmFl
         W4UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=+JvgRL3ugQHLcTNB1kYTASFF3sMaCkNK1Pl75MJZlOw=;
        b=nFc9CB+VZVx0eEjsAMMjgm5xCYEmNpeyUtgTq3/hpN72359AoDmocPtetYs4EjZiZw
         wWha511+0TwibDZKOwMdcxAAgOP+KIFA630TC0t3r0YMA2np8WoUu8Y08T5H2DuQqd0o
         d0oJWb5W51wcY6BFeO6IRqLVCyPSNyPuU288+ShMtikp/N996Ytf53dsRmURilCnV77s
         4eXZ9tbo6ouzKRoJEq3UZqwYz1ucu23BXpIe1pXcrdvPe3FvJUSm+3k25swWS/K+bzEW
         tfBBeLaU5uo2K8x0zULwl0hJAPy+eVUC3ygyTR5loDHbZJRQE7Uto7e6R5cDg1C34cFW
         8HaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Borislav Petkov" <bp@alien8.de>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Dan Williams" <dan.j.williams@intel.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Dave Hansen" <dave.hansen@intel.com>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Tom Lendacky" <thomas.lendacky@amd.com>,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "Paul Turner" <pjt@google.com>,
 "Reviewed-by: Borislav Petkov" <bp@suse.de>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Tim Chen" <tim.c.chen@linux.intel.com>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.855911650@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 17/76] x86/cpu/AMD: Make LFENCE a serializing instruction
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699640489456261?=
X-GMAIL-MSGID: =?utf-8?q?1594699640489456261?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Lendacky <thomas.lendacky@amd.com>

commit e4d0e84e490790798691aaa0f2e598637f1867ec upstream.

To aid in speculation control, make LFENCE a serializing instruction
since it has less overhead than MFENCE.  This is done by setting bit 1
of MSR 0xc0011029 (DE_CFG).  Some families that support LFENCE do not
have this MSR.  For these families, the LFENCE instruction is already
serializing.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Paul Turner <pjt@google.com>
Link: https://lkml.kernel.org/r/20180108220921.12580.71694.stgit@tlendack-t1.amdoffice.net
[bwh: Backported to 3.16: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/uapi/asm/msr-index.h |  2 ++
 arch/x86/kernel/cpu/amd.c             | 10 ++++++++++
 2 files changed, 12 insertions(+)

--- a/arch/x86/include/uapi/asm/msr-index.h
+++ b/arch/x86/include/uapi/asm/msr-index.h
@@ -223,6 +223,8 @@
 #define FAM10H_MMIO_CONF_BASE_MASK	0xfffffffULL
 #define FAM10H_MMIO_CONF_BASE_SHIFT	20
 #define MSR_FAM10H_NODE_ID		0xc001100c
+#define MSR_F10H_DECFG			0xc0011029
+#define MSR_F10H_DECFG_LFENCE_SERIALIZE_BIT	1
 
 /* K8 MSRs */
 #define MSR_K8_TOP_MEM1			0xc001001a
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -673,6 +673,16 @@ static void init_amd(struct cpuinfo_x86
 		set_cpu_cap(c, X86_FEATURE_K8);
 
 	if (cpu_has_xmm2) {
+		/*
+		 * A serializing LFENCE has less overhead than MFENCE, so
+		 * use it for execution serialization.  On families which
+		 * don't have that MSR, LFENCE is already serializing.
+		 * msr_set_bit() uses the safe accessors, too, even if the MSR
+		 * is not present.
+		 */
+		msr_set_bit(MSR_F10H_DECFG,
+			    MSR_F10H_DECFG_LFENCE_SERIALIZE_BIT);
+
 		/* MFENCE stops RDTSC speculation */
 		set_cpu_cap(c, X86_FEATURE_MFENCE_RDTSC);
 	}
