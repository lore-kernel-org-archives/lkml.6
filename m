Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751874AbeDFIfN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 04:35:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55914 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751678AbeDFIfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 04:35:09 -0400
Subject: Re: [PATCH] tpm: moves the delay_msec increment after sleep in
 tpm_transmit()
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, tpmdd@selhorst.net, jgunthorpe@obsidianresearch.com
References: <20180402162006.5030-1-nayna@linux.vnet.ibm.com>
 <20180405101210.GA21636@linux.intel.com>
From: Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Fri, 6 Apr 2018 14:03:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180405101210.GA21636@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18040608-0012-0000-0000-000016016C85
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008812; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000256; SDB=6.01013855; UDB=6.00516823; IPR=6.00793115;
 MB=3.00020446; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-06 08:35:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040608-0013-0000-0000-0000522C9FD5
Message-Id: <95af65a1-e618-5cdf-fb81-56434f1aa973@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804060092
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/05/2018 03:42 PM, Jarkko Sakkinen wrote:
> On Mon, Apr 02, 2018 at 09:50:06PM +0530, Nayna Jain wrote:
>> Commit e2fb992d82c6 ("tpm: add retry logic") introduced a new loop to
>> handle the TPM2_RC_RETRY error. The loop retries the command after
>> sleeping for the specified time, which is incremented exponentially in
>> every iteration. This patch fixes the initial sleep to be the default
>> sleep time.
> I think I understand the code change but do not understand what the
> long description.

It tells that the first sleep is delay_msec * 2 and not delay_msec.

>
>> Fixes: commit e2fb992d82c6 ("tpm: add retry logic")
>> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
>> Reviewed-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
>> ---
>>   drivers/char/tpm/tpm-interface.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
>> index c43a9e28995e..6201aab374e6 100644
>> --- a/drivers/char/tpm/tpm-interface.c
>> +++ b/drivers/char/tpm/tpm-interface.c
>> @@ -587,7 +587,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
>>   		 */
>>   		if (rc == TPM2_RC_TESTING && cc == TPM2_CC_SELF_TEST)
>>   			break;
>> -		delay_msec *= 2;
>> +
> Extra whitespace

I left just for clarity, but if not needed then I can remove it.

Thanks & Regards,
    - Nayna

>
>>   		if (delay_msec > TPM2_DURATION_LONG) {
>>   			if (rc == TPM2_RC_RETRY)
>>   				dev_err(&chip->dev, "in retry loop\n");
>> @@ -597,6 +597,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
>>   			break;
>>   		}
>>   		tpm_msleep(delay_msec);
>> +		delay_msec *= 2;
>>   		memcpy(buf, save, save_size);
>>   	}
>>   	return ret;
>> -- 
>> 2.13.6
>>
> /Jarkko
>
