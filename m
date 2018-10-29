Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B01FC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DDD20664
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26DDD20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbeJ2VGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:06:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48044 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729203AbeJ2VGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:06:43 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9TCEAVB057867
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 08:18:16 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ne1ewswqk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 08:18:15 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Mon, 29 Oct 2018 12:18:13 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 29 Oct 2018 12:18:10 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9TCI9Cj66650160
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Oct 2018 12:18:09 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A229B11C054;
        Mon, 29 Oct 2018 12:18:09 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A79F11C052;
        Mon, 29 Oct 2018 12:18:09 +0000 (GMT)
Received: from oc3784624756.ibm.com (unknown [9.152.212.21])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 29 Oct 2018 12:18:09 +0000 (GMT)
Subject: Re: [PATCH] perf/stat: Handle different PMU names with common prefix
To:     =?UTF-8?Q?S=c3=a9bastien_Boisvert?= <sboisvert@gydle.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, kan.liang@linux.intel.com,
        stable@vger.kernel.org
References: <20181023151616.78193-1-tmricht@linux.ibm.com>
 <7b3b23b7-1c73-66bf-611b-8dd9fb274694@gydle.com>
From:   Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM
Date:   Mon, 29 Oct 2018 13:18:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7b3b23b7-1c73-66bf-611b-8dd9fb274694@gydle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18102912-0012-0000-0000-000002BFA8B1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102912-0013-0000-0000-000020F3C9FD
Message-Id: <80512536-d668-489d-5f73-d7e4a4d54e2d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-29_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810290117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/2018 05:04 PM, Sébastien Boisvert wrote:
> On 2018-10-23 11:16 a.m., Thomas Richter wrote:
>> On s390 the CPU Measurement Facility for counters now supports
>> 2 PMUs named cpum_cf (CPU Measurement Facility for counters) and
>> cpum_cf_diag (CPU Measurement Facility for diagnostic counters)
>> for one and the same CPU.
>>
>> Running command
>>
>>  [root@s35lp76 perf]# ./perf stat -e tx_c_tend \
>> 	 -- ~/mytests/cf-tx-events 1
>>
> 
> Is tx_c_tend related to these ?
> 
>   tx-abort OR cpu/tx-abort/                          [Kernel PMU event]
>   tx-capacity OR cpu/tx-capacity/                    [Kernel PMU event]
>   tx-commit OR cpu/tx-commit/                        [Kernel PMU event]
>   tx-conflict OR cpu/tx-conflict/                    [Kernel PMU event]
>   tx-start OR cpu/tx-start/                          [Kernel PMU event]
> 
> 

Yes, these are the transaction counters on intel platforms, 
tx_c_tend is a transaction counter for s390.

>>  Measuring transactions
>>  TX_C_TABORT_NO_SPECIAL: 0 expected:0
>>  TX_C_TABORT_SPECIAL: 0 expected:0
>>  TX_C_TEND: 1 expected:1
>>  TX_NC_TABORT: 11 expected:11
>>  TX_NC_TEND: 1 expected:1
>>
>>  Performance counter stats for '/root/mytests/cf-tx-events 1':
>>
>>   2      tx_c_tend
>>
>>       0.002120091 seconds time elapsed
>>
>>       0.000121000 seconds user
>>       0.002127000 seconds sys
>>
>>  [root@s35lp76 perf]#
>>
>> displays output which is unexpected (and wrong):
>>
>>   2      tx_c_tend
>>
>> The test program definitely triggers only one transaction, as shown
>> in line 'TX_C_TEND: 1 expected:1'.
> 
> OK, something is done twice in perf stat, but should be done once.
> 

Correct

>>
>> This is caused by the following call sequence:
>>
>> pmu_lookup() scans and installs a PMU.
>> +--> pmu_aliases() parses all aliases in directory
>> 		.../<pmu-name>/events/* which are file names.
>>      +--> pmu_aliases_parse() Read each file in directory and create
>>                       an new alias entry. This is done with
>>           +--> perf_pmu__new_alias() and
>> 	       +--> __perf_pmu__new_alias() which also check for
>> 	                   identical alias names.
>>
>> After pmu_aliases() returns, a complete list of event names
>> for this pmu has been created. Now function
>>
>> pmu_add_cpu_aliases()   is called to add the events listed in the json
>> |                       files to the alias list of the cpu.
>> +--> perf_pmu__find_map()  Returns a pointer to the json events.
>>
>> Now function pmu_add_cpu_aliases() scans through all events listed
>> in the JSON files for this CPU.
> 
> Are these JSON files temporary in nature ?

No they are not, they are part of the perf tool, directory

[root@s35lp76 linux]# ls tools/perf/pmu-events/arch/s390/cf_z14/*
tools/perf/pmu-events/arch/s390/cf_z14/basic.json
tools/perf/pmu-events/arch/s390/cf_z14/crypto.json
tools/perf/pmu-events/arch/s390/cf_z14/extended.json
tools/perf/pmu-events/arch/s390/cf_z14/transaction.json
[root@s35lp76 linux]# 


>> Each json event pmu name is compared with the current PMU being
>> built up and if they mismatch, the json event is added to the
>> current PMUs alias list.
>> To avoid duplicate entries the following comparison is done:
>>
>> 	if (!is_arm_pmu_core(name)) {
>> 	     pname = pe->pmu ? pe->pmu : "cpu";
>> 	     if (strncmp(pname, name, strlen(pname)))
>> 		     continue;
>>      }
> 
> Is this the test to know whether a PMU event must be added or not ?

Correct.

> 
>>
>> The culprit is the strncmp() function.
>>
>> Using current s390 PMU naming, the first PMU is 'cpum_cf'
>> and a long list of events is added, among them 'tx_c_tend'
>>
>> When the second PMU named 'cpum_cf_diag' is added, only one event
>> named 'CF_DIAG' is added by the pmu_aliases()  function.
>>
>> Now function pmu_add_cpu_aliases() is invoked for PMU 'cpum_cf_diag'.
>> Since the CPUID string is the same for both PMUs, json file events
>> for PMU named 'cpum_cf' are added to the PMU 'cpm_cf_diag'
>>
>> This happens because the strncmp() actually compares:
>>>      strncmp("cpum_cf", "cpum_cf_diag", 6);
> 
> I fail to see how these argument values can be generated by this code:
> 
>  	     pname = pe->pmu ? pe->pmu : "cpu";
>  	     if (strncmp(pname, name, strlen(pname)))
> 
> The 3rd argument is the length of the first argument, pname.
> 
> With "cpum_cf", it should be 7, not 6.

Yes, mistake on my side...
but it is the same type of error , regardless if 6 or 7 characters are 
compared:

      strncmp("cpmu_cf", "cpum_cf_diag", 7) 

returns 0 when it should not. The device names of both PMUs are different.

> 
> 
> 
>>
>> The first parameter is the pmu name taken from the event in
>> the json file. The second parameter is the pmu name of the PMU
>> currently being built.
>> They are different, but the length of the compare only tests the
>> common prefix and this returns 0(true) when it should return false.
>>
> 
> The 6 comes from strlen(pname). In that case, it is neither the length of
> "cpum_cf" (7) or "cpum_cf_diag" (12).

Correct as said above, can not count to 7...

> 
>> Now all events for PMU cpum_cf are added to the alias list for pmu
>> cpum_cf_diag.
>>
>> Later on in function parse_events_add_pmu() the event 'tx_c_end' is
>> searched in all available PMUs and found twice, adding it two
>> times to the evsel_list global variable which is the root
>> of all events. This results in a counter value of 2 instead
>> of 1.
> 
> The counter value of 2 is 1 + 1 since both PMU events 'tx_c_end' that
> were added got a +1.

Correct, the transaction counter is 2 becauses it was connected to PMUs,
but only one has the counter.

> 
>>
>> Output with this patch:
>>
>>  [root@s35lp76 perf]# ./perf stat -e tx_c_tend \
>> 			-- ~/mytests/cf-tx-events 1
>>  Measuring transactions
>>  TX_C_TABORT_NO_SPECIAL: 0 expected:0
>>  TX_C_TABORT_SPECIAL: 0 expected:0
>>  TX_C_TEND: 1 expected:1
>>  TX_NC_TABORT: 11 expected:11
>>  TX_NC_TEND: 1 expected:1
>>
>>  Performance counter stats for '/root/mytests/cf-tx-events 1':
>>
>>                   1      tx_c_tend
>>
> 
> OK, now that's 1, like in your expected test value:
> 
>   TX_C_TEND: 1 expected:1
> 
>>       0.001815365 seconds time elapsed
>>
>>       0.000123000 seconds user
>>       0.001756000 seconds sys
>>
>>  [root@s35lp76 perf]#
>>
>> Fixes: 292c34c10249 ("perf pmu: Fix core PMU alias list for X86 platform")
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
>> Cc: Kan Liang <kan.liang@linux.intel.com>
>> Cc: <stable@vger.kernel.org> # 4.18+
>> ---
>>  tools/perf/util/pmu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 7799788f662f..7e49baad304d 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -773,7 +773,7 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
>>  
>>  		if (!is_arm_pmu_core(name)) {
>>  			pname = pe->pmu ? pe->pmu : "cpu";
>> -			if (strncmp(pname, name, strlen(pname)))
>> +			if (strcmp(pname, name))
>>  				continue;
>>  		}
>>  
>>
> 


-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

