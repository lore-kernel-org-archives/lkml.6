Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751611AbeFDWDw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 18:03:52 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:56393 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbeFDWDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 18:03:50 -0400
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Shuah Khan <shuah@kernel.org>
Subject: [GIT PULL] cpupower update for Linux 4.18-rc1
Message-ID: <559de2f1-fdf6-7010-2e01-d20765551065@kernel.org>
Date: Mon, 4 Jun 2018 16:03:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------73ED410EA6EFE97E134D4DB7"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------73ED410EA6EFE97E134D4DB7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Rafael,

If it isn't too late, please pull this update. A fix came in last
week to refine the cpupower monitor command.

This cpupower update for 4.18-rc1 consists of two minor fixes.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------

The following changes since commit 75bc37fefc4471e718ba8e651aa74673d4e0a9eb:

  Linux 4.17-rc4 (2018-05-06 16:57:38 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-4.18-rc1

for you to fetch changes up to f9652d5cae04eb5e85303c087f5842d320499c65:

  cpupower : Fix header name to read idle state name (2018-05-29 10:48:33 -0600)

----------------------------------------------------------------
linux-cpupower-4.18-rc1

This cpupower update for 4.18-rc1 consists of two minor fixes.

----------------------------------------------------------------
Abhishek Goel (1):
      cpupower : Fix header name to read idle state name

Colin Ian King (1):
      cpupower: fix spelling mistake: "logilename" -> "logfilename"

 tools/power/cpupower/bench/parse.c                 |  2 +-
 .../cpupower/utils/idle_monitor/cpuidle_sysfs.c    | 15 ++++++++++
 .../cpupower/utils/idle_monitor/cpupower-monitor.c | 35 ++++++++++++----------
 .../cpupower/utils/idle_monitor/cpupower-monitor.h |  9 ++++++
 4 files changed, 45 insertions(+), 16 deletions(-)
----------------------------------------------------------------

--------------73ED410EA6EFE97E134D4DB7
Content-Type: text/x-patch;
 name="linux-cpupower-4.18-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-cpupower-4.18-rc1.diff"

diff --git a/tools/power/cpupower/bench/parse.c b/tools/power/cpupower/bench/parse.c
index 9b65f052081f..9ba8a44ad2a7 100644
--- a/tools/power/cpupower/bench/parse.c
+++ b/tools/power/cpupower/bench/parse.c
@@ -104,7 +104,7 @@ FILE *prepare_output(const char *dirname)
 			dirname, time(NULL));
 	}
 
-	dprintf("logilename: %s\n", filename);
+	dprintf("logfilename: %s\n", filename);
 
 	output = fopen(filename, "w+");
 	if (output == NULL) {
diff --git a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
index 5b3205f16217..5b8c4956ff9a 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
@@ -126,6 +126,20 @@ void fix_up_intel_idle_driver_name(char *tmp, int num)
 	}
 }
 
+#ifdef __powerpc__
+void map_power_idle_state_name(char *tmp)
+{
+	if (!strncmp(tmp, "stop0_lite", CSTATE_NAME_LEN))
+		strcpy(tmp, "stop0L");
+	else if (!strncmp(tmp, "stop1_lite", CSTATE_NAME_LEN))
+		strcpy(tmp, "stop1L");
+	else if (!strncmp(tmp, "stop2_lite", CSTATE_NAME_LEN))
+		strcpy(tmp, "stop2L");
+}
+#else
+void map_power_idle_state_name(char *tmp) { }
+#endif
+
 static struct cpuidle_monitor *cpuidle_register(void)
 {
 	int num;
@@ -145,6 +159,7 @@ static struct cpuidle_monitor *cpuidle_register(void)
 		if (tmp == NULL)
 			continue;
 
+		map_power_idle_state_name(tmp);
 		fix_up_intel_idle_driver_name(tmp, num);
 		strncpy(cpuidle_cstates[num].name, tmp, CSTATE_NAME_LEN - 1);
 		free(tmp);
diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
index 05f953f0f0a0..051da0a7c454 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
@@ -70,36 +70,43 @@ void print_n_spaces(int n)
 		printf(" ");
 }
 
-/* size of s must be at least n + 1 */
+/*s is filled with left and right spaces
+ *to make its length atleast n+1
+ */
 int fill_string_with_spaces(char *s, int n)
 {
+	char *temp;
 	int len = strlen(s);
-	if (len > n)
+
+	if (len >= n)
 		return -1;
+
+	temp = malloc(sizeof(char) * (n+1));
 	for (; len < n; len++)
 		s[len] = ' ';
 	s[len] = '\0';
+	snprintf(temp, n+1, " %s", s);
+	strcpy(s, temp);
+	free(temp);
 	return 0;
 }
 
+#define MAX_COL_WIDTH 6
 void print_header(int topology_depth)
 {
 	int unsigned mon;
 	int state, need_len;
 	cstate_t s;
 	char buf[128] = "";
-	int percent_width = 4;
 
 	fill_string_with_spaces(buf, topology_depth * 5 - 1);
 	printf("%s|", buf);
 
 	for (mon = 0; mon < avail_monitors; mon++) {
-		need_len = monitors[mon]->hw_states_num * (percent_width + 3)
+		need_len = monitors[mon]->hw_states_num * (MAX_COL_WIDTH + 1)
 			- 1;
-		if (mon != 0) {
-			printf("|| ");
-			need_len--;
-		}
+		if (mon != 0)
+			printf("||");
 		sprintf(buf, "%s", monitors[mon]->name);
 		fill_string_with_spaces(buf, need_len);
 		printf("%s", buf);
@@ -107,23 +114,21 @@ void print_header(int topology_depth)
 	printf("\n");
 
 	if (topology_depth > 2)
-		printf("PKG |");
+		printf(" PKG|");
 	if (topology_depth > 1)
 		printf("CORE|");
 	if (topology_depth > 0)
-		printf("CPU |");
+		printf(" CPU|");
 
 	for (mon = 0; mon < avail_monitors; mon++) {
 		if (mon != 0)
-			printf("|| ");
-		else
-			printf(" ");
+			printf("||");
 		for (state = 0; state < monitors[mon]->hw_states_num; state++) {
 			if (state != 0)
-				printf(" | ");
+				printf("|");
 			s = monitors[mon]->hw_states[state];
 			sprintf(buf, "%s", s.name);
-			fill_string_with_spaces(buf, percent_width);
+			fill_string_with_spaces(buf, MAX_COL_WIDTH);
 			printf("%s", buf);
 		}
 		printf(" ");
diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
index 9e43f3371fbc..2ae50b499e0a 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
+++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
@@ -15,7 +15,16 @@
 
 #define MONITORS_MAX 20
 #define MONITOR_NAME_LEN 20
+
+/* CSTATE_NAME_LEN is limited by header field width defined
+ * in cpupower-monitor.c. Header field width is defined to be
+ * sum of percent width and two spaces for padding.
+ */
+#ifdef __powerpc__
+#define CSTATE_NAME_LEN 7
+#else
 #define CSTATE_NAME_LEN 5
+#endif
 #define CSTATE_DESC_LEN 60
 
 int cpu_count;

--------------73ED410EA6EFE97E134D4DB7--
