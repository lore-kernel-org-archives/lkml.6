Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+cm1JN79MthJdz6FZIdUl9Rlds95rv3gBzaBLnwim0tXoAEkGpfjdt+RpYtO6173kzC6ai
ARC-Seal: i=1; a=rsa-sha256; t=1524405429; cv=none;
        d=google.com; s=arc-20160816;
        b=ems8c7qjgz8THiBhh2AHA6IYQqPe6iB84mWTTmk9TJyhxczHJNuHND01z6vPkbehbH
         pehTCfttP+hKLa1agvDpZe3JuQfGTlwHmYYQx8IMPKkczEK6txWGqCdWAVGY1hLMVvA2
         VXaQIboXimKQA/b2KruONUWS6Kr4YTpDkKkwytkAXo1Z41Q3TSxWkZWQobYGh4xbEgj7
         bCD9rTCSCmskJ7LHYA1Imb3pPIYgebor6M6TnZrNjZfNw5XmtN2qtx9Fvacjefljl0IV
         rueAfAnvTG1GuG40YVnM8Q3jV49KoM7km+XIRYCN6fnJ7eacIz9I6+gy2CJfZZn2zt+c
         bNMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LB8SN6CG2e0YxE3TpvEAOPnOA93FSzpyjR/I8ZloOaY=;
        b=mYzpjcDP0QSS19ZwHC7NBRosd0PObX9sAQsKKR4WUhemuHjtYmUwx3SfUJb49QOdNS
         J15uF2GO3Xv/2jghsn14KIFDM0nud4OvZarpVBsPREptK+xk8QpW+mk04pVLnlsHLy/L
         ESCy9Acr2JJ/IQFyoTcnOvp6mXwaePRqdb6iD6Q+JGApkIjkOctcChgK5Hr/Hka/k5oC
         B9IEyYWEsmw4/iFbKlAAYnuQBLbHCwBPTAISx/8vYSo13Wutjymgt1uNcyjA0x1G0b2h
         KhhYCtdzkNyuoOka2PB6ucqoo/vfRqP6HcByLhDAWhMe5bQPI9Y4FKQNmBeT6fw5DDn9
         nuFg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paul Mackerras <paulus@ozlabs.org>,
	Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.16 063/196] powerpc/64: Call H_REGISTER_PROC_TBL when running as a HPT guest on POWER9
Date: Sun, 22 Apr 2018 15:51:23 +0200
Message-Id: <20180422135107.505266885@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454948033894940?=
X-GMAIL-MSGID: =?utf-8?q?1598454948033894940?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Mackerras <paulus@ozlabs.org>

commit dbfcf3cb9c681aa0c5d0bb46068f98d5b1823dd3 upstream.

On POWER9, since commit cc3d2940133d ("powerpc/64: Enable use of radix
MMU under hypervisor on POWER9", 2017-01-30), we set both the radix and
HPT bits in the client-architecture-support (CAS) vector, which tells
the hypervisor that we can do either radix or HPT.  According to PAPR,
if we use this combination we are promising to do a H_REGISTER_PROC_TBL
hcall later on to let the hypervisor know whether we are doing radix
or HPT.  We currently do this call if we are doing radix but not if
we are doing HPT.  If the hypervisor is able to support both radix
and HPT guests, it would be entitled to defer allocation of the HPT
until the H_REGISTER_PROC_TBL call, and to fail any attempts to create
HPTEs until the H_REGISTER_PROC_TBL call.  Thus we need to do a
H_REGISTER_PROC_TBL call when we are doing HPT; otherwise we may
crash at boot time.

This adds the code to call H_REGISTER_PROC_TBL in this case, before
we attempt to create any HPT entries using H_ENTER.

Fixes: cc3d2940133d ("powerpc/64: Enable use of radix MMU under hypervisor on POWER9")
Cc: stable@vger.kernel.org # v4.11+
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/mm/hash_utils_64.c       |    6 ++++++
 arch/powerpc/platforms/pseries/lpar.c |    8 ++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -875,6 +875,12 @@ static void __init htab_initialize(void)
 		/* Using a hypervisor which owns the htab */
 		htab_address = NULL;
 		_SDR1 = 0; 
+		/*
+		 * On POWER9, we need to do a H_REGISTER_PROC_TBL hcall
+		 * to inform the hypervisor that we wish to use the HPT.
+		 */
+		if (cpu_has_feature(CPU_FTR_ARCH_300))
+			register_process_table(0, 0, 0);
 #ifdef CONFIG_FA_DUMP
 		/*
 		 * If firmware assisted dump is active firmware preserves
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -726,15 +726,18 @@ static int pseries_lpar_resize_hpt(unsig
 	return 0;
 }
 
-/* Actually only used for radix, so far */
 static int pseries_lpar_register_process_table(unsigned long base,
 			unsigned long page_size, unsigned long table_size)
 {
 	long rc;
-	unsigned long flags = PROC_TABLE_NEW;
+	unsigned long flags = 0;
 
+	if (table_size)
+		flags |= PROC_TABLE_NEW;
 	if (radix_enabled())
 		flags |= PROC_TABLE_RADIX | PROC_TABLE_GTSE;
+	else
+		flags |= PROC_TABLE_HPT_SLB;
 	for (;;) {
 		rc = plpar_hcall_norets(H_REGISTER_PROC_TBL, flags, base,
 					page_size, table_size);
@@ -760,6 +763,7 @@ void __init hpte_init_pseries(void)
 	mmu_hash_ops.flush_hash_range	 = pSeries_lpar_flush_hash_range;
 	mmu_hash_ops.hpte_clear_all      = pseries_hpte_clear_all;
 	mmu_hash_ops.hugepage_invalidate = pSeries_lpar_hugepage_invalidate;
+	register_process_table		 = pseries_lpar_register_process_table;
 
 	if (firmware_has_feature(FW_FEATURE_HPT_RESIZE))
 		mmu_hash_ops.resize_hpt = pseries_lpar_resize_hpt;
