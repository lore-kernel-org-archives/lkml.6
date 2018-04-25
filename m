Return-Path: <kys@linuxonhyperv2.linuxonhyperv.com>
X-Google-Smtp-Source: AB8JxZoTp3qaEqqYN89FpCu2iXROWI3QUy/Ogi4iOr2kIZjSinQeyOUXw3cF9+U5G9Utxc9YkxOU
ARC-Seal: i=1; a=rsa-sha256; t=1524680034; cv=none;
        d=google.com; s=arc-20160816;
        b=hXETQqipB1JOfDRbZ75iIWZnLsqgCqql5vCQsyAb+mM8rfZLeFDpvnbMw7vPlXQuWG
         Sb1vKwYY38Sdxc/hKXlnU7o5VUr1jHcEC2clWXeV/bqBsmC4lrY6NDUwn8BNcE5HEwNg
         tu4X2sMuUrc6kGrYBrAAyvIPh+nfYNYEmCcHfeyd9ZTRpZmiH97lSfcMhtO3tiYSD0n0
         NO67eaQJftGuqexwxB0fJtN2R3koBQ59HMqOZgVntizCVpNUs92widzRC0sw/JaHynZJ
         MRcJv3zOOek/5+CGDsR9H1NnjIq9WhudOU90J9ZxUUbSz3aOWjVzO5Mwm6HF1EZFJ0gK
         6uVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=reply-to:references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=GgsQYcGLYQvssyiFNNV2ixinoyvBCwcwIqtBZA6BFFA=;
        b=tZ4A61I985BV8RXJVoGyZ+pbKYm5zk61iVX/YVlA2E7BoDRglCOzO3LRqLP1HV2le+
         zDneMWXoaBXuF5+5gVZsb5M8xThPPVC7SW/CUvSu05vYR64ih74Q+AP3Shgkdh19OW+S
         uEkycI/awoT4LBt36ZBGvw0+ZPfwOkL+g7f1DuJN1d0aTkrvHZx2HZ5nt+Enh6yWnxa/
         pkER8EVlzkZn+OgUbJgJMu/3RHeLPip52NUXPOZCoXX2V0DBFxesgwumECnRhvXTF/TL
         Vb6Zlg02aKTswDnyQqT2Xo34iPyns+S0R7BZu25jbnmJ3L04bnA1X+BO5Ih9JkzACxVA
         9THw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 198.71.225.49 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 198.71.225.49 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com
x-originating-ip: 107.180.71.197
From: kys@linuxonhyperv.com
To: x86@kernel.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org,
	olaf@aepfle.de,
	apw@canonical.com,
	jasowang@redhat.com,
	tglx@linutronix.de,
	hpa@zytor.com,
	sthemmin@microsoft.com,
	Michael.H.Kelley@microsoft.com,
	vkuznets@redhat.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 4/5] X86: Hyper-V: Consolidate code for converting cpumask to vpset
Date: Wed, 25 Apr 2018 11:12:49 -0700
Message-Id: <20180425181250.8740-4-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180425181250.8740-1-kys@linuxonhyperv.com>
References: <20180425181110.8683-1-kys@linuxonhyperv.com>
 <20180425181250.8740-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfI1DU+7SxRvHjDdvlxPmKjsOKU26kPFEo2L9KMzpWv6MA9tS9nQqvEdyPiYaLduP0tWDIT2Oq8iy466kSRjOiBWec5LPVE/sD9Jz3Mhu8VT+cHweO2r1
 NXMERw9Kf2qhqPyxhPFiSVGxtsLH3TgGBjSH7wwIqYFlLZfw0r5+akIWXKqPYF/V28iwbqpxWJ/bwVlfACdHrLcCmoKRGRTcLEI8Go4lynEyBQ1kaHfcIU2h
 3I2H2OELF3J9Qk6u0fwmi+5kot3gK79Dolk139I1H3MQpmCCXlW0ylaniz2Ye2PAtcuC/NjfrZvgYJkMBYyuiD4HNpePKrQ/ApDT6Vl+2EpuFBm8Imo5hVRp
 9ftH0aOkXo0eb4JrPsjQriC1OfoJ4fLinrYiuxVWULeRxYGzsDZN/TgpUOIMesyFPPfCb0s2VonhADssSS0hkwprjY2f0G82/7mERuIYl3G7Bpdjya8SvMw1
 /R+qn4Wc1lSBXeRExUGCJ/3XB9VbbIevlun96k34xGcjog4aQCQB/gxNltsJjeYudDOHc6KwkS19SvyBcA9/NfoB6v07vjC5W1CB/FgUjATbF5TPpoqQHf7O
 qvOw/Sdvh2gwpNPKUSSy26yx
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598742891180804464?=
X-GMAIL-MSGID: =?utf-8?q?1598742891180804464?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "K. Y. Srinivasan" <kys@microsoft.com>

Consolidate code for converting cpumask to vpset.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 arch/x86/hyperv/hv_apic.c          |  2 +-
 arch/x86/hyperv/mmu.c              | 45 +++-----------------------------------
 arch/x86/include/asm/hyperv-tlfs.h |  2 +-
 3 files changed, 5 insertions(+), 44 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index fbb408b91e25..508889c8499e 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -123,7 +123,7 @@ static int __send_ipi_mask_ex(const struct cpumask *mask, int vector)
 	ipi_arg->vp_set.valid_bank_mask = 0;
 
 	if (!cpumask_equal(mask, cpu_present_mask)) {
-		ipi_arg->vp_set.format = HV_GENERIC_SET_SPARCE_4K;
+		ipi_arg->vp_set.format = HV_GENERIC_SET_SPARSE_4K;
 		nr_bank = cpumask_to_vpset(&(ipi_arg->vp_set), mask);
 	}
 	if (!nr_bank)
diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index 56c9ebac946f..c9cd28f0bae4 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -25,11 +25,7 @@ struct hv_flush_pcpu {
 struct hv_flush_pcpu_ex {
 	u64 address_space;
 	u64 flags;
-	struct {
-		u64 format;
-		u64 valid_bank_mask;
-		u64 bank_contents[];
-	} hv_vp_set;
+	struct hv_vpset hv_vp_set;
 	u64 gva_list[];
 };
 
@@ -70,41 +66,6 @@ static inline int fill_gva_list(u64 gva_list[], int offset,
 	return gva_n - offset;
 }
 
-/* Return the number of banks in the resulting vp_set */
-static inline int cpumask_to_vp_set(struct hv_flush_pcpu_ex *flush,
-				    const struct cpumask *cpus)
-{
-	int cpu, vcpu, vcpu_bank, vcpu_offset, nr_bank = 1;
-
-	/* valid_bank_mask can represent up to 64 banks */
-	if (hv_max_vp_index / 64 >= 64)
-		return 0;
-
-	/*
-	 * Clear all banks up to the maximum possible bank as hv_flush_pcpu_ex
-	 * structs are not cleared between calls, we risk flushing unneeded
-	 * vCPUs otherwise.
-	 */
-	for (vcpu_bank = 0; vcpu_bank <= hv_max_vp_index / 64; vcpu_bank++)
-		flush->hv_vp_set.bank_contents[vcpu_bank] = 0;
-
-	/*
-	 * Some banks may end up being empty but this is acceptable.
-	 */
-	for_each_cpu(cpu, cpus) {
-		vcpu = hv_cpu_number_to_vp_number(cpu);
-		vcpu_bank = vcpu / 64;
-		vcpu_offset = vcpu % 64;
-		__set_bit(vcpu_offset, (unsigned long *)
-			  &flush->hv_vp_set.bank_contents[vcpu_bank]);
-		if (vcpu_bank >= nr_bank)
-			nr_bank = vcpu_bank + 1;
-	}
-	flush->hv_vp_set.valid_bank_mask = GENMASK_ULL(nr_bank - 1, 0);
-
-	return nr_bank;
-}
-
 static void hyperv_flush_tlb_others(const struct cpumask *cpus,
 				    const struct flush_tlb_info *info)
 {
@@ -239,8 +200,8 @@ static void hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 	flush->hv_vp_set.valid_bank_mask = 0;
 
 	if (!cpumask_equal(cpus, cpu_present_mask)) {
-		flush->hv_vp_set.format = HV_GENERIC_SET_SPARCE_4K;
-		nr_bank = cpumask_to_vp_set(flush, cpus);
+		flush->hv_vp_set.format = HV_GENERIC_SET_SPARSE_4K;
+		nr_bank = cpumask_to_vpset(&(flush->hv_vp_set), cpus);
 	}
 
 	if (!nr_bank) {
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 53ea30d768d9..b32b87945538 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -370,7 +370,7 @@ struct hv_tsc_emulation_status {
 #define HV_FLUSH_USE_EXTENDED_RANGE_FORMAT	BIT(3)
 
 enum HV_GENERIC_SET_FORMAT {
-	HV_GENERIC_SET_SPARCE_4K,
+	HV_GENERIC_SET_SPARSE_4K,
 	HV_GENERIC_SET_ALL,
 };
 
-- 
2.15.1
