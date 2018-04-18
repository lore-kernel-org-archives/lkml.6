Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752999AbeDROKE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 10:10:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55024 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752707AbeDROKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 10:10:03 -0400
Subject: Re: [PATCH v2] perf list: Add s390 support for detailed/verbose pmu
 event description
To: Mark Rutland <mark.rutland@arm.com>, acme@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>
References: <20180416132314.33249-1-tmricht@linux.ibm.com>
 <20180416144334.zkzxyhhnlm3ia5gy@lakrids.cambridge.arm.com>
From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM LTC
Date: Wed, 18 Apr 2018 16:09:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180416144334.zkzxyhhnlm3ia5gy@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18041814-0008-0000-0000-000004ECB53A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041814-0009-0000-0000-00001E80C062
Message-Id: <a6aefb3d-08c7-7d12-e087-428245ae399b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-18_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804180128
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/16/2018 04:43 PM, Mark Rutland wrote:
> On Mon, Apr 16, 2018 at 03:23:14PM +0200, Thomas Richter wrote:
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
>> +	if (stat(path, &st) == 0 && !strncmp(name, "cpum_", 5))
>> +		return 1;
>> +
> 
> This shouldn't adversely affect ARM, so FWIW:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 

Arnaldo,

with Mark Acked-by can you please apply the patch.

Thanks a lot.
-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
