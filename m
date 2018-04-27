Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZomN2PrdFLxwWrWVjOoxDDUaHGdXQLg7IDikY5YyJqzIt3JOzJLHZz5fxRigyM+tXLDGwyE
ARC-Seal: i=1; a=rsa-sha256; t=1524837741; cv=none;
        d=google.com; s=arc-20160816;
        b=WhBIcpVT/FqFHx2oiVjWMJtWVGQVbaH7w29AIssKn23eFb+jfWMPe59kwVNN0+VVkP
         bRfOJIDVObFx/EKbSosIUkJfymxaDNcnm+ii5E/1Xck2qqqBX1rkbfN+gB991eA2/tNw
         3Lh99h3WtlKRGof8JpLsYJo92P93iKaD/cp+BkxwZncBjmwEHMx/uvpsdv4HHooDE/YO
         nVbRKAatxk6yycEvlbf7+LVWyA1+C9rq2wxJybPk2XBDJ2v5fxVGmJAoMh4wiBSR35nC
         F2BxuRDgivjb6b6KWzseyfkSmRicMyl7hFUsRYrq5GA1HfLarxckJEJPZrr1jM/LituY
         nIBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=LEE6KQOEIdKaIKoYUxuprUr0qGbWqVjGZaUcyvC4MgY=;
        b=sZJNgHysWhox+wY+Nu7gsRb2XESWYwrySWmcKtdXdHSZMaDi6ZsWoR9uasl82AM8GE
         ENHTSiz4ZhxX9SjcvNimn0QA5uyhYO0MNHre0VWRSP8CZP8ryLVyCCyuhGWZ9ldUAwWu
         hcecNNrfBSW+VJkPH9IhXs5sLu5c5WZdnzOYEu2SiWBA77mhSIoEp5r65LV5UZkw6WJ2
         93N7F6siwAvWmuYjHPE+9bgCq7M5Ck9C3gZA8gtFxHKy8LkykiSDxXmq8Ps4OVog2J2M
         q+qi2iMLIq/uGuxb70H0ZMK6yvdDTfv1IShqAINIjCcnngptAz0gW5pnknvJbYZO7Jvx
         Xdqw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08FAE21897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 4.4 15/50] s390/alternative: use a copy of the facility bit mask
Date: Fri, 27 Apr 2018 15:58:17 +0200
Message-Id: <20180427135656.637526548@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908260011997733?=
X-GMAIL-MSGID: =?utf-8?q?1598908260011997733?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>


[ Upstream commit cf1489984641369611556bf00c48f945c77bcf02 ]

To be able to switch off specific CPU alternatives with kernel parameters
make a copy of the facility bit mask provided by STFLE and use the copy
for the decision to apply an alternative.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/include/asm/facility.h |   18 ++++++++++++++++++
 arch/s390/include/asm/lowcore.h  |    3 ++-
 arch/s390/kernel/alternative.c   |    3 ++-
 arch/s390/kernel/early.c         |    3 +++
 arch/s390/kernel/setup.c         |    4 +++-
 arch/s390/kernel/smp.c           |    4 +++-
 6 files changed, 31 insertions(+), 4 deletions(-)

--- a/arch/s390/include/asm/facility.h
+++ b/arch/s390/include/asm/facility.h
@@ -13,6 +13,24 @@
 
 #define MAX_FACILITY_BIT (256*8)	/* stfle_fac_list has 256 bytes */
 
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
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -170,7 +170,8 @@ struct _lowcore {
 	__u8	pad_0x0e20[0x0f00-0x0e20];	/* 0x0e20 */
 
 	/* Extended facility list */
-	__u64	stfle_fac_list[32];		/* 0x0f00 */
+	__u64	stfle_fac_list[16];		/* 0x0f00 */
+	__u64	alt_stfle_fac_list[16];		/* 0x0f80 */
 	__u8	pad_0x1000[0x11b0-0x1000];	/* 0x1000 */
 
 	/* Pointer to vector register save area */
--- a/arch/s390/kernel/alternative.c
+++ b/arch/s390/kernel/alternative.c
@@ -74,7 +74,8 @@ static void __init_or_module __apply_alt
 		instr = (u8 *)&a->instr_offset + a->instr_offset;
 		replacement = (u8 *)&a->repl_offset + a->repl_offset;
 
-		if (!test_facility(a->facility))
+		if (!__test_facility(a->facility,
+				     S390_lowcore.alt_stfle_fac_list))
 			continue;
 
 		if (unlikely(a->instrlen % 2 || a->replacementlen % 2)) {
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -279,6 +279,9 @@ static noinline __init void setup_facili
 {
 	stfle(S390_lowcore.stfle_fac_list,
 	      ARRAY_SIZE(S390_lowcore.stfle_fac_list));
+	memcpy(S390_lowcore.alt_stfle_fac_list,
+	       S390_lowcore.stfle_fac_list,
+	       sizeof(S390_lowcore.alt_stfle_fac_list));
 }
 
 static __init void detect_diag9c(void)
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -334,7 +334,9 @@ static void __init setup_lowcore(void)
 	lc->machine_flags = S390_lowcore.machine_flags;
 	lc->stfl_fac_list = S390_lowcore.stfl_fac_list;
 	memcpy(lc->stfle_fac_list, S390_lowcore.stfle_fac_list,
-	       MAX_FACILITY_BIT/8);
+	       sizeof(lc->stfle_fac_list));
+	memcpy(lc->alt_stfle_fac_list, S390_lowcore.alt_stfle_fac_list,
+	       sizeof(lc->alt_stfle_fac_list));
 	if (MACHINE_HAS_VX)
 		lc->vector_save_area_addr =
 			(unsigned long) &lc->vector_save_area;
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -250,7 +250,9 @@ static void pcpu_prepare_secondary(struc
 	__ctl_store(lc->cregs_save_area, 0, 15);
 	save_access_regs((unsigned int *) lc->access_regs_save_area);
 	memcpy(lc->stfle_fac_list, S390_lowcore.stfle_fac_list,
-	       MAX_FACILITY_BIT/8);
+	       sizeof(lc->stfle_fac_list));
+	memcpy(lc->alt_stfle_fac_list, S390_lowcore.alt_stfle_fac_list,
+	       sizeof(lc->alt_stfle_fac_list));
 }
 
 static void pcpu_attach_task(struct pcpu *pcpu, struct task_struct *tsk)
