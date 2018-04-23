Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754391AbeDWILy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:11:54 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:50841 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754345AbeDWILu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:11:50 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] powerpc: rtas: clean up time handling
Date: Mon, 23 Apr 2018 10:10:26 +0200
Message-Id: <20180423081114.1813726-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180423081114.1813726-1-arnd@arndb.de>
References: <20180423081114.1813726-1-arnd@arndb.de>
X-Provags-ID: V03:K1:oCKfqueQc3BahMQdSsnDhtmP/NVQMfoZj4fVyZdspBrbMZjxtnF
 kSUZ3PP2F8cFPYm0x2uY/0Dsb8t9bbkHtkzDA8ZzhIBX43qPEaVsHtp/8KWKSLBUwudC+lV
 vaGpB0u4N9GMNKz2wJyhjwkdihtEUI6ScjwWtMbolffFmzlgQ6sy7ahKH5sc6At7cNDcw8C
 /b43GW0Ebgh+OyzLvBuwg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T4pgU5xuv2I=:6UwH8dApn5hiJ3rp+LXcxX
 VK6ti9OnriFfpSLFliJkyiFB8GFtxQedBkc4b4Mjm54QuSqSghCAy1YT+g7+rTl12KZgYfkeX
 kH2UNtyLcCfKlH/QfyyDXjibjcogpzy1095RdQ2OoJ4Ie/UzJoxn+Gu9jX74bI4tIEiVeDLyl
 MCs6DV2YV77BqFQdb/vPk3cU7e/EHJCCeXVxw0l87NyF0c1EHo69IPaUBARIB5P5xmWPYSiXO
 LUHW1AUBYb+H5JNTMQok0qeBebBa5MRnNmyDOTDJZR6F3PxGAo7gxHVxrlJsHXpolqSS4vvWQ
 LZ5nQvrlMK6f+FkgOPQ8b/6V1CuKM54vm7Pl1uCM52muMV4n7aA6MLIUYeiHyOZuQ4I70zb/I
 SSvqq73p5E27CI3yLln+PKC0nTNPLghsHFtAfAkzg7Vxjq/+eeADZyOiNBVY28MpuxSkQ1mid
 LTNmNNfz9/QZdkXbjCVkN3INj2dy2URf7RoWRIk03HA/h77x8f6YqVpZMQ0QbPzPFhEYfOkpe
 UQ8eHx7rZpdgoFsO2lCHQib6/JC4soFvl57UkYb6k2Ta6EOaoznxw1xi7cgmrK4p98LiJ2o5k
 MIbOY7zkyPj4mS04rAH+htWB7/69ZYVCvUYbBjCr8wenWJZb9O0kSEFEhO1PUCgo0FCzVSiLi
 A1aCe4S3ps1CD/VQl5f2j5QMrm0YFjbdTLCXZ6wmGhSteKLcWoM37k1CWOpxURRjnVFdawhya
 nu6BAEggFRqcMFplJPWQzCXRKNoopD1iLdmfZw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The to_tm() helper function operates on a signed integer for the time,
so it will suffer from overflow in 2038, even on 64-bit kernels.

Rather than fix that function, this replaces its use in the rtas
procfs implementation with the standard rtc_time64_to_tm() helper
that is very similar but is not affected by the overflow.

In order to actually support long times, the parser function gets
changed to 64-bit user input and output as well. Note that the tm_mon
and tm_year representation is slightly different, so we have to manually
add an offset here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/kernel/rtas-proc.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/rtas-proc.c b/arch/powerpc/kernel/rtas-proc.c
index fb070d8cad07..80864b787745 100644
--- a/arch/powerpc/kernel/rtas-proc.c
+++ b/arch/powerpc/kernel/rtas-proc.c
@@ -280,7 +280,7 @@ static int __init proc_rtas_init(void)
 
 __initcall(proc_rtas_init);
 
-static int parse_number(const char __user *p, size_t count, unsigned long *val)
+static int parse_number(const char __user *p, size_t count, u64 *val)
 {
 	char buf[40];
 	char *end;
@@ -293,7 +293,7 @@ static int parse_number(const char __user *p, size_t count, unsigned long *val)
 
 	buf[count] = 0;
 
-	*val = simple_strtoul(buf, &end, 10);
+	*val = simple_strtoull(buf, &end, 10);
 	if (*end && *end != '\n')
 		return -EINVAL;
 
@@ -307,17 +307,17 @@ static ssize_t ppc_rtas_poweron_write(struct file *file,
 		const char __user *buf, size_t count, loff_t *ppos)
 {
 	struct rtc_time tm;
-	unsigned long nowtime;
+	time64_t nowtime;
 	int error = parse_number(buf, count, &nowtime);
 	if (error)
 		return error;
 
 	power_on_time = nowtime; /* save the time */
 
-	to_tm(nowtime, &tm);
+	rtc_time64_to_tm(nowtime, 0, &tm);
 
 	error = rtas_call(rtas_token("set-time-for-power-on"), 7, 1, NULL, 
-			tm.tm_year, tm.tm_mon, tm.tm_mday, 
+			tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
 			tm.tm_hour, tm.tm_min, tm.tm_sec, 0 /* nano */);
 	if (error)
 		printk(KERN_WARNING "error: setting poweron time returned: %s\n", 
@@ -373,14 +373,14 @@ static ssize_t ppc_rtas_clock_write(struct file *file,
 		const char __user *buf, size_t count, loff_t *ppos)
 {
 	struct rtc_time tm;
-	unsigned long nowtime;
+	time64_t nowtime;
 	int error = parse_number(buf, count, &nowtime);
 	if (error)
 		return error;
 
-	to_tm(nowtime, &tm);
+	rtc_time64_to_tm(nowtime, 0, &tm);
 	error = rtas_call(rtas_token("set-time-of-day"), 7, 1, NULL, 
-			tm.tm_year, tm.tm_mon, tm.tm_mday, 
+			tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
 			tm.tm_hour, tm.tm_min, tm.tm_sec, 0);
 	if (error)
 		printk(KERN_WARNING "error: setting the clock returned: %s\n", 
@@ -401,8 +401,8 @@ static int ppc_rtas_clock_show(struct seq_file *m, void *v)
 		unsigned int year, mon, day, hour, min, sec;
 		year = ret[0]; mon  = ret[1]; day  = ret[2];
 		hour = ret[3]; min  = ret[4]; sec  = ret[5];
-		seq_printf(m, "%lu\n",
-				mktime(year, mon, day, hour, min, sec));
+		seq_printf(m, "%lld\n",
+				mktime64(year, mon, day, hour, min, sec));
 	}
 	return 0;
 }
@@ -731,7 +731,7 @@ static void get_location_code(struct seq_file *m, struct individual_sensor *s,
 static ssize_t ppc_rtas_tone_freq_write(struct file *file,
 		const char __user *buf, size_t count, loff_t *ppos)
 {
-	unsigned long freq;
+	u64 freq;
 	int error = parse_number(buf, count, &freq);
 	if (error)
 		return error;
@@ -756,7 +756,7 @@ static int ppc_rtas_tone_freq_show(struct seq_file *m, void *v)
 static ssize_t ppc_rtas_tone_volume_write(struct file *file,
 		const char __user *buf, size_t count, loff_t *ppos)
 {
-	unsigned long volume;
+	u64 volume;
 	int error = parse_number(buf, count, &volume);
 	if (error)
 		return error;
-- 
2.9.0
