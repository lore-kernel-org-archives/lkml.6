Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754702AbeDWIiy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:38:54 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:39929 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754573AbeDWIhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:37:07 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        y2038@lists.linaro.org, arnd@arndb.de
Subject: [PATCH 2/5] powerpc: rtas: clean up time handling
Date: Mon, 23 Apr 2018 10:36:39 +0200
Message-Id: <20180423083642.2608886-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180423083642.2608886-1-arnd@arndb.de>
References: <20180423083642.2608886-1-arnd@arndb.de>
X-Provags-ID: V03:K1:xg6gifUpz3iHQyaagOz/+XeacsBkJfVuUIIR2Trz+8G+K6IlXx2
 tCktSwQ9NW7yJppi7VrIqGtz4+ZzdNtL2+K3o7cN6oI45lxkZgJuqGrfCZoDPy4lf+SW5G3
 FJ+5EDRI/YllAmPhuz6qUGpdTH5eTnBwDtoBtp74twTmk88l1Eh1voviZcNKbrz8/h1jHQe
 AkKjIQh51tFdSoBNRJVNQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JfwvQUd5ijw=:aunA74VsFa1n1pEZOBHTON
 t2wQUTmJ/K5hFur1B/xT1ukAW8hMWUoDQSw91BfEnYw+4Y7IQSlP48ocbmbVcncbLpkEWyRAa
 I4v65YER7x6IEBQ39xncH+ecsLm93h3MOQW08/b00Umjpo1HSnJTeniKmGYKCg3qr2IB2FOVb
 fPDroVf3Yq4g9uu+C2hU18YZi4ZV1bfWFehQn3tYCHdz869A+MBTIVUDE6sgybFYDKEwSDSRf
 MFu0J4U5Y6rd7HPTmk/CPWyNY1V3/ul75YgmoM6m89PXKdL/7Sx6fUbc3pw/Z3Fu5A9x5abGo
 izUosoMdLSZQ8nwrVqF0+6Ev9OOXKpSrIja5+OqCpmCY05FhHLiFfMBssK2EMgWWnTiF3P6Tl
 UF/9JPLalL9EwU0aboThawUFybj/qGF3WCuoq+X4XctdvwV0jBMCVEPxco8dTcATsCr+O0hvn
 kZ9ghSUA9XiJikebvhPzd4E9WjU+xPWMbYt4g2h+1L6TDsoJRrBy9S/jlRYFUqXjlQhW4vjtE
 lNUVXK5J7D1APU5Bz2QLmkTuAn06CkQxbU9EKM7D0WhYGkRJvj+1w94r0oR4EfEhwziQv7n2J
 aDizQ+wVo6kAycxkOh5Ho0hFLZcqFz0sLKrg/BB5X11e+FGaIWWSOh1u12I1+pfQHxb7uNs5B
 Dnf2WpEips/loK6TSaxsSbvJyUmBWWZCHkt9m1iGd/YDN6eGrBAzUClHCd3Y+WjDIif6LiDyN
 jcmF9tvkP5cYWRXDNCcbuc/xTvW4P44IG2futQ==
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
v2: fix up rtc_time64_to_tm() calling conventions
---
 arch/powerpc/kernel/rtas-proc.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/rtas-proc.c b/arch/powerpc/kernel/rtas-proc.c
index fb070d8cad07..815027476600 100644
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
+	rtc_time64_to_tm(nowtime, &tm);
 
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
+	rtc_time64_to_tm(nowtime, &tm);
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
