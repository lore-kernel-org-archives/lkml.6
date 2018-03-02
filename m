Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164747AbeCBIOf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 03:14:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53700 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1422721AbeCBIOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 03:14:33 -0500
Subject: Re: [RFC PATCH 3/3] tpm: tpm_msleep() with finer granularity improves
 performance
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, tpmdd@selhorst.net, jgunthorpe@obsidianresearch.com,
        patrickc@us.ibm.com
References: <20180228191828.20056-1-nayna@linux.vnet.ibm.com>
 <20180228191828.20056-3-nayna@linux.vnet.ibm.com>
 <20180301095840.GD29420@linux.intel.com>
From: Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Fri, 2 Mar 2018 13:43:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180301095840.GD29420@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18030208-0040-0000-0000-00000400EFF5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008609; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00997175; UDB=6.00507015; IPR=6.00776493;
 MB=3.00019813; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-02 08:14:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030208-0041-0000-0000-00000801F0FE
Message-Id: <e0de9d68-9d70-a437-3664-7404037e6744@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-02_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803020097
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/01/2018 03:28 PM, Jarkko Sakkinen wrote:
> On Wed, Feb 28, 2018 at 02:18:28PM -0500, Nayna Jain wrote:
>> When 'commit 9f3fc7bcddcb ("tpm: replace msleep() with  usleep_range()
>> in TPM 1.2/2.0 generic drivers")' was upstreamed, it replaced the
> "was upstreamed" is redundant information. If you speak about commit ID,
> it is expected to be in the mainline. Why there is "'" before the word
> 'commit'?
>
> Just write
>
>    In commit 9f3fc7bcddcb ("tpm: replace msleep() with  usleep_range()
>    in TPM 1.2/2.0 generic drivers")' msleep() was replaced with
>    usleep_range().
Yeah. Sure. Will do.
>
>> msleep() calls with usleep_range(), but did not change the
>> granularity of the calls. They're still defined in terms of msec.
>> Test results show that refining the granularity further improves
>> the performance. We're posting this patch as an RFC to show that there
>> needs to be another function which allows finer granularity.
>>
>> After this change, performance on a TPM 1.2 with an 8 byte
>> burstcount for 1000 extends improved from ~10.7sec to ~6.9sec.
> Environment where this result was achieved would be mandatory.
Sure.
It is an x86 based, locked down, single purpose closed system.
It has Infineon TPM 1.2 using LPC Bus.
>
>> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
>> ---
>>   drivers/char/tpm/tpm.h | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
>> index 7e797377e1eb..8cad6bfc5f46 100644
>> --- a/drivers/char/tpm/tpm.h
>> +++ b/drivers/char/tpm/tpm.h
>> @@ -522,8 +522,7 @@ int tpm_pm_resume(struct device *dev);
>>   
>>   static inline void tpm_msleep(unsigned int delay_msec)
>>   {
>> -	usleep_range((delay_msec * 1000) - TPM_TIMEOUT_RANGE_US,
>> -		     delay_msec * 1000);
>> +	usleep_range((delay_msec * 1000) / 10, (delay_msec * 1000) / 2);
> Shouldn't the max be 'delay_msec * 1000'? Where do these numbers
> come from?
We don’t expect the patch to be upstreamed as is with the /10 and /2. 
Our point in posting
this was to show that msec is the wrong granularity for polling. And so 
we suggest to have another
sleep() function which can take timeouts in usecs.

The way timeouts are used in the driver is to sleep between polling for 
a specified amount of time.
Since not all TPM commands take the same time to execute, some of them 
might return much
earlier than others. In such cases, having those TPM commands use a 
polling granularity of
msecs is wrong, and adds cumulative delays. Since the polling loops for 
a specified amount
of time, which is defined by TCG Specification for each command, 
changing the granularity for
polling should not cause problems.

To obtain the performance improvements in the specified environment, 
minimizing the minimum
value of usleep_range() wasn’t enough. We found that changing the 
maximum value by /2 gave a
dramatic improvement, and pointed us in the direction of using a smaller 
granularity.

Thanks & Regards,
      - Nayna

>
> /Jarkko
>
