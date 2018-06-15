Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 522C4C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071E7208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071E7208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965580AbeFOKLW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 06:11:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35052 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934900AbeFOKLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 06:11:20 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5FA9U8P057867
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 06:11:19 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jmb0hh8nt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 06:11:19 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Fri, 15 Jun 2018 11:11:17 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 15 Jun 2018 11:11:14 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5FABDxC36765906
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Jun 2018 10:11:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF98252049;
        Fri, 15 Jun 2018 10:00:38 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A207D52041;
        Fri, 15 Jun 2018 10:00:38 +0100 (BST)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 3/3 v2] perf stat: Remove duplicate event counting
Date:   Fri, 15 Jun 2018 12:11:05 +0200
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180615101105.47047-1-tmricht@linux.ibm.com>
References: <20180615101105.47047-1-tmricht@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18061510-0020-0000-0000-0000029B267E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061510-0021-0000-0000-000020E75C87
Message-Id: <20180615101105.47047-3-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-15_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806150110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf stat shows a mismatch in perf stat regarding counter names
on s390:

Run command
   [root@s35lp76 perf]# ./perf stat -e tx_nc_tend  -v --
                ~/mytesttx 1 >/tmp/111
   tx_nc_tend: 1 573146 573146
   tx_nc_tend: 1 573146 573146

   Performance counter stats for '/root/mytesttx 1':

                 3      tx_nc_tend

       0.001037252 seconds time elapsed

   [root@s35lp76 perf]#

shows transaction counter tx_nc_tend with value 3 but it
was triggered only once as seen by the output of mytesttx.

When looking up the event name tx_nc_tend the following
function sequence is called:

parse_events_multi_pmu_add()
+--> perf_pmu__scan() being called with NULL argument
     +--> pmu_read_sysfs() scans directory ../devices/ for
                           all PMUs
          +--> perf_pmu__find() tries to find a PMU in the
                           global pmu list.
               +--> pmu_lookup() called to read all file
                                 entries when not in global
                                 list.

pmu_lookup() causes the issue. It calls
+---> pmu_aliases() to read all the entries in the PMU directory.
                    On s390 this is named
                    /sys/devices/cpum_cf/events.
      +--> pmu_aliases_parse() reads all files and creates an
                       alias for each file name.

                       So we end up with first entry created by
                       reading the sysfs file
                       [root@s35lp76 perf]# cat /sys/devices/cpum_cf
                                                /events/TX_NC_TEND
                       event=0x008d
                       [root@s35lp76 perf]#

                       Debug output shows this entry
                       tx_nc_tend -> 'cpum_cf'/'event=0x008d
                       '/
                       After all files in this directory have been
                       read and aliases created this function is called:
      +--> pmu_add_cpu_aliases()
                       This function looks up the CPU tables
                       created by the json files.
                       With json files for s390 now available all
                       the aliases are added to
                       the PMU alias list a second time.
                       The second entry is added by
                       reading the json file converted by jevent
                       resulting in file pmu-events/pmu-events.c:

                       {
                         .name = "tx_nc_tend",
                         .event = "event=0x8d",
                         .desc = "Unit: cpum_cf Completed TEND \
                                  instructions \
                                  in non-constrained TX mode",
                         .topic = "extended",
                         .long_desc = "A TEND instruction has \
                                       completed  in a \
                                       non-constrained \
                                       transactional-execution mode",
                         .pmu = "cpum_cf",
                        },

                        Debug output shows this entry
                        tx_nc_tend -> 'cpum_cf'/'event=0x8d'/

Function pmu_aliases_parse() and pmu_add_cpu_aliases()
both use __perf_pmu__new_alias() to add an alias to the
PMU alias list. There is no check if an alias already exist

So we end up with 2 entries for tx_nc_tend in the
PMU alias list.

Having set up the PMU alias list for this PMU now
parse_events_multi_add_pmu() reads the complete alias
list and adds each alias with parse_events_add_pmu()
to the global perfev_list.  This causes the alias to
be added multiple times to the event list.

Fix this by making __perf_pmu__new_alias()
to merge alias definitions if an alias is already on the
alias list.
Also print a debug message when the alias has mismatches
in some fields.

Output before:
[root@s35lp76 perf]# ./perf stat -e tx_nc_tend  -v \
                      -- ~/mytesttx 1 >/tmp/111
tx_nc_tend: 1 551446 551446

 Performance counter stats for '/root/mytesttx 1':

                 3      tx_nc_tend

       0.000961134 seconds time elapsed

[root@s35lp76 perf]#

Output after:
[root@s35lp76 perf]#  ./perf stat -e tx_nc_tend  -v \
                      -- ~/mytesttx 1 >/tmp/111
tx_nc_tend: 1 551446 551446

 Performance counter stats for '/root/mytesttx 1':

                 1      tx_nc_tend

       0.000961134 seconds time elapsed

[root@s35lp76 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
---
 tools/perf/util/pmu.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 208e427dc038..afd68524ffa9 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -234,6 +234,74 @@ static int perf_pmu__parse_snapshot(struct perf_pmu_alias *alias,
 	return 0;
 }
 
+static void perf_pmu_assign_str(char *name, const char *field, char **old_str,
+				char **new_str)
+{
+	if (!*old_str)
+		goto set_new;
+
+	if (*new_str) {	/* Have new string, check with old */
+		if (strcasecmp(*old_str, *new_str))
+			pr_debug("alias %s differs in field '%s'\n",
+				 name, field);
+		zfree(old_str);
+	} else		/* Nothing new --> keep old string */
+		return;
+set_new:
+	*old_str = *new_str;
+	*new_str = NULL;
+}
+
+static void perf_pmu_update_alias(struct perf_pmu_alias *old,
+				  struct perf_pmu_alias *newalias)
+{
+	perf_pmu_assign_str(old->name, "desc", &old->desc, &newalias->desc);
+	perf_pmu_assign_str(old->name, "long_desc", &old->long_desc,
+			    &newalias->long_desc);
+	perf_pmu_assign_str(old->name, "topic", &old->topic, &newalias->topic);
+	perf_pmu_assign_str(old->name, "metric_expr", &old->metric_expr,
+			    &newalias->metric_expr);
+	perf_pmu_assign_str(old->name, "metric_name", &old->metric_name,
+			    &newalias->metric_name);
+	perf_pmu_assign_str(old->name, "value", &old->str, &newalias->str);
+	old->scale = newalias->scale;
+	old->per_pkg = newalias->per_pkg;
+	old->snapshot = newalias->snapshot;
+	memcpy(old->unit, newalias->unit, sizeof(old->unit));
+}
+
+/* Delete an alias entry. */
+static void perf_pmu_free_alias(struct perf_pmu_alias *newalias)
+{
+	zfree(&newalias->name);
+	zfree(&newalias->desc);
+	zfree(&newalias->long_desc);
+	zfree(&newalias->topic);
+	zfree(&newalias->str);
+	zfree(&newalias->metric_expr);
+	zfree(&newalias->metric_name);
+	parse_events_terms__purge(&newalias->terms);
+	free(newalias);
+}
+
+/* Merge an alias, search in alias list. If this name is already
+ * present merge both of them to combine all information.
+ */
+static bool perf_pmu_merge_alias(struct perf_pmu_alias *newalias,
+				 struct list_head *alist)
+{
+	struct perf_pmu_alias *a;
+
+	list_for_each_entry(a, alist, list) {
+		if (!strcasecmp(newalias->name, a->name)) {
+			perf_pmu_update_alias(a, newalias);
+			perf_pmu_free_alias(newalias);
+			return true;
+		}
+	}
+	return false;
+}
+
 static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 				 char *desc, char *val,
 				 char *long_desc, char *topic,
@@ -310,7 +378,8 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 	alias->per_pkg = perpkg && sscanf(perpkg, "%d", &num) == 1 && num == 1;
 	alias->str = strdup(newval);
 
-	list_add_tail(&alias->list, list);
+	if (!perf_pmu_merge_alias(alias, list))
+		list_add_tail(&alias->list, list);
 
 	return 0;
 }
-- 
2.14.3

