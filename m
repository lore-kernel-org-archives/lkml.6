Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162448AbeE1KiH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:38:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162404AbeE1KiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:38:01 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Frank Asseg <frank.asseg@objecthunter.net>,
        Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 263/329] tools/thermal: tmon: fix for segfault
Date: Mon, 28 May 2018 12:03:12 +0200
Message-Id: <20180528100303.831633396@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frank Asseg <frank.asseg@objecthunter.net>

[ Upstream commit 6c59f64b7ecf2bccbe73931d7d573d66ed13b537 ]

Fixes a segfault occurring when e.g. <TAB> is pressed multiple times in the
ncurses tmon application. The segfault is caused by incrementing
cur_thermal_record in the main function without checking if it's value reached
NR_THERMAL_RECORD immediately. Since the boundary check only occurred in
update_thermal_data a race condition existed, which lead to an attempted read
beyond the last element of the trec array.

The fix was implemented by moving the cur_thermal_record incrementation to the
update_thermal_data function using a temporary variable on which the boundary
condition is checked before updating cur_thread_record, so that the variable is
never incremented beyond the trec array's boundary.

It seems the segfault does not occur on every machine: On a HP EliteBook G4 the
segfault happens, while it does not happen on a Thinkpad T540p.

Signed-off-by: Frank Asseg <frank.asseg@objecthunter.net>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/thermal/tmon/sysfs.c |   12 +++++++-----
 tools/thermal/tmon/tmon.c  |    1 -
 2 files changed, 7 insertions(+), 6 deletions(-)

--- a/tools/thermal/tmon/sysfs.c
+++ b/tools/thermal/tmon/sysfs.c
@@ -486,6 +486,7 @@ int zone_instance_to_index(int zone_inst
 int update_thermal_data()
 {
 	int i;
+	int next_thermal_record = cur_thermal_record + 1;
 	char tz_name[256];
 	static unsigned long samples;
 
@@ -495,9 +496,9 @@ int update_thermal_data()
 	}
 
 	/* circular buffer for keeping historic data */
-	if (cur_thermal_record >= NR_THERMAL_RECORDS)
-		cur_thermal_record = 0;
-	gettimeofday(&trec[cur_thermal_record].tv, NULL);
+	if (next_thermal_record >= NR_THERMAL_RECORDS)
+		next_thermal_record = 0;
+	gettimeofday(&trec[next_thermal_record].tv, NULL);
 	if (tmon_log) {
 		fprintf(tmon_log, "%lu ", ++samples);
 		fprintf(tmon_log, "%3.1f ", p_param.t_target);
@@ -507,11 +508,12 @@ int update_thermal_data()
 		snprintf(tz_name, 256, "%s/%s%d", THERMAL_SYSFS, TZONE,
 			ptdata.tzi[i].instance);
 		sysfs_get_ulong(tz_name, "temp",
-				&trec[cur_thermal_record].temp[i]);
+				&trec[next_thermal_record].temp[i]);
 		if (tmon_log)
 			fprintf(tmon_log, "%lu ",
-				trec[cur_thermal_record].temp[i]/1000);
+				trec[next_thermal_record].temp[i] / 1000);
 	}
+	cur_thermal_record = next_thermal_record;
 	for (i = 0; i < ptdata.nr_cooling_dev; i++) {
 		char cdev_name[256];
 		unsigned long val;
--- a/tools/thermal/tmon/tmon.c
+++ b/tools/thermal/tmon/tmon.c
@@ -336,7 +336,6 @@ int main(int argc, char **argv)
 			show_data_w();
 			show_cooling_device();
 		}
-		cur_thermal_record++;
 		time_elapsed += ticktime;
 		controller_handler(trec[0].temp[target_tz_index] / 1000,
 				&yk);
