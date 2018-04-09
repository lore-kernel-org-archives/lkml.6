Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeDINDl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 09:03:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48252 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751902AbeDINDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 09:03:39 -0400
Subject: Re: [PATCH] perf list: Add s390 support for detailed/verbose pmu
 event description
To: Mark Rutland <mark.rutland@arm.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
References: <20180409110015.20793-1-tmricht@linux.ibm.com>
 <20180409113732.6k3plpp6pqdcbzrh@lakrids.cambridge.arm.com>
From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Organization: IBM LTC
Date: Mon, 9 Apr 2018 15:03:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180409113732.6k3plpp6pqdcbzrh@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18040913-0008-0000-0000-000004E85B51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040913-0009-0000-0000-00001E7B7FB5
Message-Id: <975962f2-3d85-2325-da31-b74951863cbe@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-09_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804090140
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2018 01:37 PM, Mark Rutland wrote:
> Hi,
> 
> On Mon, Apr 09, 2018 at 01:00:15PM +0200, Thomas Richter wrote:
>> From: Thomas Richter <tmricht@linux.vnet.ibm.com>
>>
>> Perf list with flags -d and -v print a description (-d) or
>> a very verbose explanation (-v) of CPU specific counter events.
>> These descriptions are provided with the json files in
>> directory pmu-events/arch/s390/*.json.
>>
>> Display of these descriptions on s390 requires the
>> corresponding json files.
>>
>> On s390 this does not work because function is_pmu_core()
>> does not detect the s390 directory name where the
>> CPU specific events are listed. On x86 it is
>>   /sys/bus/event_source/devices/cpu
>> whereas on s390 it is
>>   /sys/bus/event_source/devices/cpum_cf
>>   /sys/bus/event_source/devices/cpum_sf
>>
>> Fix this by adding s390 directory name testing to
>> function is_pmu_core(). This is the same approach as taken for
>> arm platform.
> 
> I don't think this is quite right.
> 
> On arm, we specifically look for PMU directories which have a
> file called CPUs. e.g.
> 
>   /sys/bus/event_source/devices/arm_pmuv3/cpus
> 
> ... where "arm_pmuv3" is the PMU name.
> 
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 1111d5bf15ca..8675ddf558c6 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -562,6 +562,12 @@ static int is_pmu_core(const char *name)
>>  	if (stat(path, &st) == 0)
>>  		return 1;
>>  
>> +	/* Look for cpu sysfs (specific to s390) */
>> +	scnprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s",
>> +		  sysfs, name);
>> +	if (stat(path, &st) == 0)
>> +		return 1;
> 
> IIUC here we return true if the PMU has a sysfs directory, but all PMUs
> (including uncore PMUs) should have such a directory, so this will make
> is_pmu_core() always return true.
> 
> Can you match the "cpum_" prefix specifically, instead?
> 
> Thanks,
> Mark.
> 

I am sorry, I don't follow you.
When I look at the code function sequence

perf_pmu__scan()
+---> pmu_read_sysfs()
      This functions scans directory /sys/bus/event_source/devices/
      and calls for each entry in this directory. For s390 these entries exist:
      cpum_sf cpum_cf tracepoint and software
      +---> perf_pmu__find();
            +---> pmu_lookup()
                  +---> pmu_format()
                        Looks for file /sys/bus/event_source/devices/cpum_cf/format/event
                        and parses its contents. This returns 0 on s390.
                  +---> pmu_type() 
                        Looks for file /sys/bus/event_source/devices/cpum_cf/type and
                        and parses its contents. This returns 0 on s390.
                  +---> pmu_aliases() 
                        Looks for directory /sys/bus/event_source/devices/cpum_cf/events and
                        reads out every entry name which is treated as a event name and added
                        to the list of PMU-Aliases together with the file contents. For example
                        /sys/bus/event_source/devices/cpum_cf/events/SF_CYCLES_BASIC with the
                        file contents event=0xb0000. This is the raw event number.
                        +----> pmu_aliases_parse() + perf_pmu__new_alias()
                               Check and add alias name to a list.
                  +---> pmu_cpumask()
                        This tests for files /sys/bus/event_source/devices/cpum_cf/cpus or
                        /sys/bus/event_source/devices/cpum_cf/cpumask which do not exist on
                        s390.
                  +---> pmu_add_cpu_aliases() adds the list of aliases such as cpum_sf/SF_CYCLES_BASIC/
                        to the global list of aliases. But ths happens only when
                        +---> is_pmu_core()
                              function returns true.
                              And for s390 it needs to test for /sys/bus/event_source/devices/cpum_sf/ and
                              /sys/bus/event_source/devices/cpum_cf/
                              directories.
                              These directories are used to read the alias names in function
                              pmu_aliases() above.
                        
Maybe I misunderstand this whole scheme, but with this patch the perf list commands works...

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
