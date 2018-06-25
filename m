Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8202EC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B2D25F87
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQGpX3CF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B2D25F87
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965055AbeFYRl4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:41:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965030AbeFYRly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:41:54 -0400
Received: from jouet.infradead.org (unknown [177.79.80.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18FCA25F81;
        Mon, 25 Jun 2018 17:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529948513;
        bh=ZgFcfeLWKEQnTIyJMqPEsYQ5JJTTJgJQhWyKN2ksCQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DQGpX3CF4Xw3WZRJ3VDhePwcvn/fnsWj/OSM6+v72Ctw5JLcqIDu1ReNtQwfanHVu
         p5g9BOw2phCJnWhkYIQ92YRNf+jAn7RKyEMAo5Lf/ayj98eFGatp3vjiu+uacFfxsw
         eMP5ywTiJxR+SA8Wsc1N+XeoId+uNAK9vXoJA80A=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 15/19] perf stat: Remove duplicate event counting
Date:   Mon, 25 Jun 2018 14:40:41 -0300
Message-Id: <20180625174045.25765-16-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180625174045.25765-1-acme@kernel.org>
References: <20180625174045.25765-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

'perf stat' shows a mismatch in perf stat regarding counter names on
s390:

Run command:

   [root@s35lp76 perf]# ./perf stat -e tx_nc_tend  -v --
                ~/mytesttx 1 >/tmp/111
   tx_nc_tend: 1 573146 573146
   tx_nc_tend: 1 573146 573146

   Performance counter stats for '/root/mytesttx 1':

                 3      tx_nc_tend

       0.001037252 seconds time elapsed

   [root@s35lp76 perf]#

shows transaction counter tx_nc_tend with value 3 but it was triggered
only once as seen by the output of mytesttx.

When looking up the event name tx_nc_tend the following function
sequence is called:

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

Function pmu_aliases_parse() and pmu_add_cpu_aliases() both use
__perf_pmu__new_alias() to add an alias to the PMU alias list. There is
no check if an alias already exist

So we end up with 2 entries for tx_nc_tend in the PMU alias list.

Having set up the PMU alias list for this PMU now
parse_events_multi_add_pmu() reads the complete alias list and adds each
alias with parse_events_add_pmu() to the global perfev_list.  This
causes the alias to be added multiple times to the event list.

Fix this by making __perf_pmu__new_alias() to merge alias definitions if
an alias is already on the alias list.  Also print a debug message when
the alias has mismatches in some fields.

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
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180615101105.47047-3-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index f321ce97d9ec..3ba6a1742f91 100644
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

