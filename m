Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/ywUKjfIozCkYez0rT5QjdcUSPF3FUn9HF+77VLOk2ktHy9t1ChfxY1voHv7M98SrAajAn
ARC-Seal: i=1; a=rsa-sha256; t=1523399713; cv=none;
        d=google.com; s=arc-20160816;
        b=EUjj3C+jaHwQIrWtxfYTLdTxc12wbxbm8VSkPODC/v/5SmQn7UsT3/DANjxS+QUdnx
         x1RzXC86Cndu+upJwpSUUX+DLhkRiA476YByW/NwK1PZM36NPr3FNbfdUujY61zk28Lm
         kO05+i98rQDTqVkIHuFNetmntf+5rdb/KlbIGVPAl4jRWeTeM9Pbmjn3jDKwy16t1iZR
         F/oS4L0Ly5DinttaJAqwFLWWffdDYRha1/Lg6+pBf8BDzYPk7+J9CfeTatiEIoDENRj6
         iDMTd9cRRoY0afOoW9HsBUjjOZpM1h3SzLmk/sltHcj2R/OL1XYKL3P+yamGlRfO5Rd1
         EG8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uiB8u3ZNJJJiBD++EpRz+8AV+ygpSnfoSulxKWT4JVY=;
        b=OEX+EdpUSZXHiDcCTReVjlc+fSRbuCeH3yIJ8uCq0G5YV1scwgcvQNIfcOq9t9wE+6
         t+t2nCWUG2yzY7+9S3x7/BApe4hAmLayoGYyaArrd0AdM6MSQuiQ0axCSg6iBIpodvJZ
         A2/Zrj0i+pn/muZBwwjAApypRAjFDoddVdYthV+etR9Kh1wffxXPKv4EoV2k/wWmYmb2
         OKl+pxc1P7khDPB/B+dCaPHOHEhiUsBKOmkEMtdHAiK5E1UDJq79tY7rjeUfzeNzLshy
         0nYbpj7BGrnCQ84Ngevfa1Q10mnRevzNQ0pSMHmwU1OC6t5D/c3K0klgbfpXgOxJsjpj
         hqYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
	Balbir Singh <bsingharora@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 037/138] powernv-cpufreq: Add helper to extract pstate from PMSR
Date: Wed, 11 Apr 2018 00:23:47 +0200
Message-Id: <20180410212906.396759934@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399927456097675?=
X-GMAIL-MSGID: =?utf-8?q?1597400377650613251?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>


[ Upstream commit ee1f4a7dafa997816ff3de96155c6f3edc21c1e6 ]

On POWERNV platform, the fields for pstates in the Power Management
Status Register (PMSR) and the Power Management Control Register
(PMCR) are 8-bits wide. On POWER8 the pstates are negatively numbered
while on POWER9 they are positively numbered.

The device-tree exports pstates as 32-bit entries. The device-tree
implementation sign-extends the 8-bit pstate values to obtain the
corresponding 32-bit entry.

Eg: On POWER8, a pstate value 0x82 [-126] is represented in the
device-tree as 0xfffffff82 while on POWER9, the same value 0x82 [130]
is represented in the device-tree as 0x00000082.

The powernv-cpufreq driver implementation represents pstates using the
integer type. In multiple places in the driver, the code interprets
the pstates extracted from the PMSR as a signed byte and assigns it to
a integer variable to get the sign-extention.

On POWER9 platforms which have greater than 128 pstates, this results
in the driver performing incorrect sign-extention, and thereby
treating a legitimate pstate (say 130) as an invalid pstates (since it
is interpreted as -126).

This patch fixes the issue by implementing a helper function to
extract Pstates from PMSR register, and correctly sign-extend it to be
consistent with the values provided by the device-tree.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/powernv-cpufreq.c |   37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -41,11 +41,9 @@
 #define POWERNV_MAX_PSTATES	256
 #define PMSR_PSAFE_ENABLE	(1UL << 30)
 #define PMSR_SPR_EM_DISABLE	(1UL << 31)
-#define PMSR_MAX(x)		((x >> 32) & 0xFF)
+#define MAX_PSTATE_SHIFT	32
 #define LPSTATE_SHIFT		48
 #define GPSTATE_SHIFT		56
-#define GET_LPSTATE(x)		(((x) >> LPSTATE_SHIFT) & 0xFF)
-#define GET_GPSTATE(x)		(((x) >> GPSTATE_SHIFT) & 0xFF)
 
 #define MAX_RAMP_DOWN_TIME				5120
 /*
@@ -93,6 +91,7 @@ struct global_pstate_info {
 };
 
 static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
+u32 pstate_sign_prefix;
 static bool rebooting, throttled, occ_reset;
 
 static const char * const throttle_reason[] = {
@@ -147,6 +146,20 @@ static struct powernv_pstate_info {
 	bool wof_enabled;
 } powernv_pstate_info;
 
+static inline int extract_pstate(u64 pmsr_val, unsigned int shift)
+{
+	int ret = ((pmsr_val >> shift) & 0xFF);
+
+	if (!ret)
+		return ret;
+
+	return (pstate_sign_prefix | ret);
+}
+
+#define extract_local_pstate(x) extract_pstate(x, LPSTATE_SHIFT)
+#define extract_global_pstate(x) extract_pstate(x, GPSTATE_SHIFT)
+#define extract_max_pstate(x)  extract_pstate(x, MAX_PSTATE_SHIFT)
+
 /* Use following macros for conversions between pstate_id and index */
 static inline int idx_to_pstate(unsigned int i)
 {
@@ -277,6 +290,9 @@ next:
 
 	powernv_pstate_info.nr_pstates = nr_pstates;
 	pr_debug("NR PStates %d\n", nr_pstates);
+
+	pstate_sign_prefix = pstate_min & ~0xFF;
+
 	for (i = 0; i < nr_pstates; i++) {
 		u32 id = be32_to_cpu(pstate_ids[i]);
 		u32 freq = be32_to_cpu(pstate_freqs[i]);
@@ -437,17 +453,10 @@ struct powernv_smp_call_data {
 static void powernv_read_cpu_freq(void *arg)
 {
 	unsigned long pmspr_val;
-	s8 local_pstate_id;
 	struct powernv_smp_call_data *freq_data = arg;
 
 	pmspr_val = get_pmspr(SPRN_PMSR);
-
-	/*
-	 * The local pstate id corresponds bits 48..55 in the PMSR.
-	 * Note: Watch out for the sign!
-	 */
-	local_pstate_id = (pmspr_val >> 48) & 0xFF;
-	freq_data->pstate_id = local_pstate_id;
+	freq_data->pstate_id = extract_local_pstate(pmspr_val);
 	freq_data->freq = pstate_id_to_freq(freq_data->pstate_id);
 
 	pr_debug("cpu %d pmsr %016lX pstate_id %d frequency %d kHz\n",
@@ -521,7 +530,7 @@ static void powernv_cpufreq_throttle_che
 	chip = this_cpu_read(chip_info);
 
 	/* Check for Pmax Capping */
-	pmsr_pmax = (s8)PMSR_MAX(pmsr);
+	pmsr_pmax = extract_max_pstate(pmsr);
 	pmsr_pmax_idx = pstate_to_idx(pmsr_pmax);
 	if (pmsr_pmax_idx != powernv_pstate_info.max) {
 		if (chip->throttled)
@@ -644,8 +653,8 @@ void gpstate_timer_handler(unsigned long
 	 * value. Hence, read from PMCR to get correct data.
 	 */
 	val = get_pmspr(SPRN_PMCR);
-	freq_data.gpstate_id = (s8)GET_GPSTATE(val);
-	freq_data.pstate_id = (s8)GET_LPSTATE(val);
+	freq_data.gpstate_id = extract_global_pstate(val);
+	freq_data.pstate_id = extract_local_pstate(val);
 	if (freq_data.gpstate_id  == freq_data.pstate_id) {
 		reset_gpstates(policy);
 		spin_unlock(&gpstates->gpstate_lock);
