Return-Path: <schwidefsky@de.ibm.com>
X-Google-Smtp-Source: AH8x224QBcJR/3rnMbrGCamOcnfPL3UD144FGXtI5kfIdblvZf+6dKtNBScp4SbqxOySTrQ9n4pg
ARC-Seal: i=1; a=rsa-sha256; t=1517986825; cv=none;
        d=google.com; s=arc-20160816;
        b=ibtaztLZfk/CIkhZ2tcxjQDuqG563AHbQRAoO/kAloXxV9Hjr3S5lo7XaY5gDtL8Jl
         3aGrbZCE7qqwSf+/qYxwknsd9VQ9MYHPKZuwp4dgR43F38NKMO9VmBaUUt/QFwrUmGrx
         MO9KhOZ9tUfTokpRT9tBa8t4JgG9hEG04BdPXXXdwWk162bYLOLwK+4L2jz41xD5LtVm
         cQ0c8CTo4pdz5rZ18KizjxfTerkMzpVwaFRtewOFq35CNPIPAHuT8NFbmrTYHYaGYlw5
         guDREGNg1HFO4CzNfYbJDD64mGvM3ZuhqgikviNxoiNQTIKAY6B8qH+sVzs2bQzp+17o
         /HyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=h4V5FAKk3XQ57do0wIC1ssAAc4vkHTKa84NDoOo5q+c=;
        b=MWbrgUoh+GnHfgJPpEHFgreHH1qghMFdCgJZH7Q2fSWzMeu7TtnqYs4WovFXDM5xmD
         MvO8flGvu5OGgWb43n6zqUtmqET0uIph/AO2dKU9oi3VJJD1CyUetpHzMJZMP40iFua0
         7Ct8GFf7a1LoZ0hpuuqpt9nwSQNZSqGIXEcMPLWRp4PtKsjuRK+DUnduwVQXliqEkizf
         Pf3QTwqI/Mwt2pi4sJ6H3YQjRmS+9yWSO7P46UcmCIFSY1DZkeQHyu31xphTnquTbYvs
         EqiUMbjiczfzxhHn+b/UOTA+SiIsZ+gq9NeZDtTEV8/6vc+tACJbey2GTDDvi4KhANj3
         wKlw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of schwidefsky@de.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=schwidefsky@de.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of schwidefsky@de.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=schwidefsky@de.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>,
        Jiri Kosina <jkosina@suse.cz>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 3/6] s390/alternative: use a copy of the facility bit mask
Date: Wed,  7 Feb 2018 08:00:08 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517986811-27819-1-git-send-email-schwidefsky@de.ibm.com>
References: <1517986811-27819-1-git-send-email-schwidefsky@de.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18020707-0020-0000-0000-000003F31BEA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020707-0021-0000-0000-000042859545
Message-Id: <1517986811-27819-4-git-send-email-schwidefsky@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-07_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802070089
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591724553699834701?=
X-GMAIL-MSGID: =?utf-8?q?1591724553699834701?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

To be able to switch off specific CPU alternatives with kernel parameters
make a copy of the facility bit mask provided by STFLE and use the copy
for the decision to apply an alternative.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/include/asm/facility.h | 18 ++++++++++++++++++
 arch/s390/include/asm/lowcore.h  |  3 ++-
 arch/s390/kernel/alternative.c   |  3 ++-
 arch/s390/kernel/early.c         |  3 +++
 arch/s390/kernel/setup.c         |  4 +++-
 arch/s390/kernel/smp.c           |  4 +++-
 6 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/facility.h b/arch/s390/include/asm/facility.h
index fbe0c4b..99c8ce3 100644
--- a/arch/s390/include/asm/facility.h
+++ b/arch/s390/include/asm/facility.h
@@ -15,6 +15,24 @@
 
 #define MAX_FACILITY_BIT (sizeof(((struct lowcore *)0)->stfle_fac_list) * 8)
 
+static inline void __set_facility(unsigned long nr, void *facilities)
+{
+	unsigned char *ptr = (unsigned char *) facilities;
+
+	if (nr >= MAX_FACILITY_BIT)
+		return;
+	ptr[nr >> 3] |= 0x80 >> (nr & 7);
+}
+
+static inline void __clear_facility(unsigned long nr, void *facilities)
+{
+	unsigned char *ptr = (unsigned char *) facilities;
+
+	if (nr >= MAX_FACILITY_BIT)
+		return;
+	ptr[nr >> 3] &= ~(0x80 >> (nr & 7));
+}
+
 static inline int __test_facility(unsigned long nr, void *facilities)
 {
 	unsigned char *ptr;
diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
index ec6592e..c63986a 100644
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -151,7 +151,8 @@ struct lowcore {
 	__u8	pad_0x0e20[0x0f00-0x0e20];	/* 0x0e20 */
 
 	/* Extended facility list */
-	__u64	stfle_fac_list[32];		/* 0x0f00 */
+	__u64	stfle_fac_list[16];		/* 0x0f00 */
+	__u64	alt_stfle_fac_list[16];		/* 0x0f80 */
 	__u8	pad_0x1000[0x11b0-0x1000];	/* 0x1000 */
 
 	/* Pointer to the machine check extended save area */
diff --git a/arch/s390/kernel/alternative.c b/arch/s390/kernel/alternative.c
index 574e776..1abf4f3 100644
--- a/arch/s390/kernel/alternative.c
+++ b/arch/s390/kernel/alternative.c
@@ -75,7 +75,8 @@ static void __init_or_module __apply_alternatives(struct alt_instr *start,
 		instr = (u8 *)&a->instr_offset + a->instr_offset;
 		replacement = (u8 *)&a->repl_offset + a->repl_offset;
 
-		if (!test_facility(a->facility))
+		if (!__test_facility(a->facility,
+				     S390_lowcore.alt_stfle_fac_list))
 			continue;
 
 		if (unlikely(a->instrlen % 2 || a->replacementlen % 2)) {
diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index 497a920..510f218 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -193,6 +193,9 @@ static noinline __init void setup_facility_list(void)
 {
 	stfle(S390_lowcore.stfle_fac_list,
 	      ARRAY_SIZE(S390_lowcore.stfle_fac_list));
+	memcpy(S390_lowcore.alt_stfle_fac_list,
+	       S390_lowcore.stfle_fac_list,
+	       sizeof(S390_lowcore.alt_stfle_fac_list));
 }
 
 static __init void detect_diag9c(void)
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 793da97..bcd2a4a 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -340,7 +340,9 @@ static void __init setup_lowcore(void)
 	lc->preempt_count = S390_lowcore.preempt_count;
 	lc->stfl_fac_list = S390_lowcore.stfl_fac_list;
 	memcpy(lc->stfle_fac_list, S390_lowcore.stfle_fac_list,
-	       MAX_FACILITY_BIT/8);
+	       sizeof(lc->stfle_fac_list));
+	memcpy(lc->alt_stfle_fac_list, S390_lowcore.alt_stfle_fac_list,
+	       sizeof(lc->alt_stfle_fac_list));
 	nmi_alloc_boot_cpu(lc);
 	vdso_alloc_boot_cpu(lc);
 	lc->sync_enter_timer = S390_lowcore.sync_enter_timer;
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index a919b2f..fc28c95 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -266,7 +266,9 @@ static void pcpu_prepare_secondary(struct pcpu *pcpu, int cpu)
 	__ctl_store(lc->cregs_save_area, 0, 15);
 	save_access_regs((unsigned int *) lc->access_regs_save_area);
 	memcpy(lc->stfle_fac_list, S390_lowcore.stfle_fac_list,
-	       MAX_FACILITY_BIT/8);
+	       sizeof(lc->stfle_fac_list));
+	memcpy(lc->alt_stfle_fac_list, S390_lowcore.alt_stfle_fac_list,
+	       sizeof(lc->alt_stfle_fac_list));
 	arch_spin_lock_setup(cpu);
 }
 
-- 
2.7.4
