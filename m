Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1010CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5FEC2147D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qe++hhvU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5FEC2147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387924AbeKTDH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:07:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:41568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732866AbeKTDH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:07:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC65D2086A;
        Mon, 19 Nov 2018 16:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645796;
        bh=YRdQ526lVBSNq1NaPFax6qc45we582bqDqFQBFS2Hcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qe++hhvUI2Qs5715ULIXy2wT6ahcBLl+Ot3vYAaWBrau/85e32D7wpJg0YMW6O1tT
         TZ0XdxWUxa+s8mOBRRdgrmLE7LS6ai+jsjlLLSU+FG00kOwvpuIXls/DmZpsxoeKPz
         7A2FOUOf3YGWTrxkKRDt6JyDKEDsu5Va+UH8pXeY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Sebastien Boisvert <sboisvert@gydle.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.18 093/171] perf stat: Handle different PMU names with common prefix
Date:   Mon, 19 Nov 2018 17:28:09 +0100
Message-Id: <20181119162633.968247728@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Richter <tmricht@linux.ibm.com>

commit ea1fa48c055f833eb25f0c33188feecb7002ada5 upstream.

On s390 the CPU Measurement Facility for counters now supports
2 PMUs named cpum_cf (CPU Measurement Facility for counters) and
cpum_cf_diag (CPU Measurement Facility for diagnostic counters)
for one and the same CPU.

Running command

 [root@s35lp76 perf]# ./perf stat -e tx_c_tend \
	 -- ~/mytests/cf-tx-events 1

 Measuring transactions
 TX_C_TABORT_NO_SPECIAL: 0 expected:0
 TX_C_TABORT_SPECIAL: 0 expected:0
 TX_C_TEND: 1 expected:1
 TX_NC_TABORT: 11 expected:11
 TX_NC_TEND: 1 expected:1

 Performance counter stats for '/root/mytests/cf-tx-events 1':

  2      tx_c_tend

      0.002120091 seconds time elapsed

      0.000121000 seconds user
      0.002127000 seconds sys

 [root@s35lp76 perf]#

displays output which is unexpected (and wrong):

  2      tx_c_tend

The test program definitely triggers only one transaction, as shown
in line 'TX_C_TEND: 1 expected:1'.

This is caused by the following call sequence:

pmu_lookup() scans and installs a PMU.
+--> pmu_aliases() parses all aliases in directory
		.../<pmu-name>/events/* which are file names.
     +--> pmu_aliases_parse() Read each file in directory and create
                      an new alias entry. This is done with
          +--> perf_pmu__new_alias() and
	       +--> __perf_pmu__new_alias() which also check for
	                   identical alias names.

After pmu_aliases() returns, a complete list of event names
for this pmu has been created. Now function

pmu_add_cpu_aliases()   is called to add the events listed in the json
|                       files to the alias list of the cpu.
+--> perf_pmu__find_map()  Returns a pointer to the json events.

Now function pmu_add_cpu_aliases() scans through all events listed
in the JSON files for this CPU.
Each json event pmu name is compared with the current PMU being
built up and if they mismatch, the json event is added to the
current PMUs alias list.
To avoid duplicate entries the following comparison is done:

	if (!is_arm_pmu_core(name)) {
	     pname = pe->pmu ? pe->pmu : "cpu";
	     if (strncmp(pname, name, strlen(pname)))
		     continue;
     }

The culprit is the strncmp() function.

Using current s390 PMU naming, the first PMU is 'cpum_cf'
and a long list of events is added, among them 'tx_c_tend'

When the second PMU named 'cpum_cf_diag' is added, only one event
named 'CF_DIAG' is added by the pmu_aliases()  function.

Now function pmu_add_cpu_aliases() is invoked for PMU 'cpum_cf_diag'.
Since the CPUID string is the same for both PMUs, json file events
for PMU named 'cpum_cf' are added to the PMU 'cpm_cf_diag'

This happens because the strncmp() actually compares:

     strncmp("cpum_cf", "cpum_cf_diag", 6);

The first parameter is the pmu name taken from the event in
the json file. The second parameter is the pmu name of the PMU
currently being built.
They are different, but the length of the compare only tests the
common prefix and this returns 0(true) when it should return false.

Now all events for PMU cpum_cf are added to the alias list for pmu
cpum_cf_diag.

Later on in function parse_events_add_pmu() the event 'tx_c_end' is
searched in all available PMUs and found twice, adding it two
times to the evsel_list global variable which is the root
of all events. This results in a counter value of 2 instead
of 1.

Output with this patch:

 [root@s35lp76 perf]# ./perf stat -e tx_c_tend \
			-- ~/mytests/cf-tx-events 1
 Measuring transactions
 TX_C_TABORT_NO_SPECIAL: 0 expected:0
 TX_C_TABORT_SPECIAL: 0 expected:0
 TX_C_TEND: 1 expected:1
 TX_NC_TABORT: 11 expected:11
 TX_NC_TEND: 1 expected:1

 Performance counter stats for '/root/mytests/cf-tx-events 1':

                  1      tx_c_tend

      0.001815365 seconds time elapsed

      0.000123000 seconds user
      0.001756000 seconds sys

 [root@s35lp76 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Sebastien Boisvert <sboisvert@gydle.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: stable@vger.kernel.org
Fixes: 292c34c10249 ("perf pmu: Fix core PMU alias list for X86 platform")
Link: http://lkml.kernel.org/r/20181023151616.78193-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/pmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -779,7 +779,7 @@ static void pmu_add_cpu_aliases(struct l
 
 		if (!is_arm_pmu_core(name)) {
 			pname = pe->pmu ? pe->pmu : "cpu";
-			if (strncmp(pname, name, strlen(pname)))
+			if (strcmp(pname, name))
 				continue;
 		}
 


