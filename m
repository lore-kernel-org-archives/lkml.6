Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933690AbeBLKdx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 05:33:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39218 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932558AbeBLKdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 05:33:52 -0500
Subject: Re: [PATCH] cpufreq: powernv: Check negative value returned by
 cpufreq_table_find_index_dl()
To: Viresh Kumar <viresh.kumar@linaro.org>
References: <1518430876-24464-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20180212102900.GU28462@vireshk-i7>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Date: Mon, 12 Feb 2018 16:03:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20180212102900.GU28462@vireshk-i7>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18021210-0040-0000-0000-0000040ECDD4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021210-0041-0000-0000-000026128C05
Message-Id: <14e2fe70-7628-4377-664d-3c4b0071e08d@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802120136
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02/12/2018 03:59 PM, Viresh Kumar wrote:
> On 12-02-18, 15:51, Shilpasri G Bhat wrote:
>> This patch fixes the below Coverity warning:
>>
>> *** CID 182816:  Memory - illegal accesses  (NEGATIVE_RETURNS)
>> /drivers/cpufreq/powernv-cpufreq.c: 1008 in powernv_fast_switch()
>> 1002     					unsigned int target_freq)
>> 1003     {
>> 1004     	int index;
>> 1005     	struct powernv_smp_call_data freq_data;
>> 1006
>> 1007     	index = cpufreq_table_find_index_dl(policy, target_freq);
>>>>>     CID 182816:  Memory - illegal accesses  (NEGATIVE_RETURNS)
>>>>>     Using variable "index" as an index to array "powernv_freqs".
>> 1008     	freq_data.pstate_id = powernv_freqs[index].driver_data;
>> 1009     	freq_data.gpstate_id = powernv_freqs[index].driver_data;
>> 1010     	set_pstate(&freq_data);
>> 1011
>> 1012     	return powernv_freqs[index].frequency;
>> 1013     }
>>
>> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
>> ---
>>  drivers/cpufreq/powernv-cpufreq.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
>> index 29cdec1..69edfe9 100644
>> --- a/drivers/cpufreq/powernv-cpufreq.c
>> +++ b/drivers/cpufreq/powernv-cpufreq.c
>> @@ -1005,6 +1005,9 @@ static unsigned int powernv_fast_switch(struct cpufreq_policy *policy,
>>  	struct powernv_smp_call_data freq_data;
>>  
>>  	index = cpufreq_table_find_index_dl(policy, target_freq);
>> +	if (unlikely(index < 0))
>> +		index = get_nominal_index();
>> +
> 
> AFAICT, you will get -1 here only if the freq table had no valid
> frequencies (or the freq table is empty). Why would that happen ?

I agree too. There is no way we can get -1 with initialized cpu frequency table.
We don't initialize powernv-cpufreq if we don't have valid CPU frequency
entries. Is there any other way to suppress the Coverity tool warning apart from
ignoring it?

Thanks and Regards,
Shilpa

> 
>>  	freq_data.pstate_id = powernv_freqs[index].driver_data;
>>  	freq_data.gpstate_id = powernv_freqs[index].driver_data;
>>  	set_pstate(&freq_data);
>> -- 
>> 1.8.3.1
> 
