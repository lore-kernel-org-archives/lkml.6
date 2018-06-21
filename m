Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70971C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E64821EB3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E64821EB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933164AbeFUUOx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 16:14:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46026 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932670AbeFUUOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 16:14:51 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5LKDrjb081737
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 16:14:51 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jrgkfnh1x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 16:14:51 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Thu, 21 Jun 2018 16:14:50 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 21 Jun 2018 16:14:47 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5LKEkwG56164484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Jun 2018 20:14:46 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A5F1112067;
        Thu, 21 Jun 2018 16:14:43 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17643112064;
        Thu, 21 Jun 2018 16:14:43 -0400 (EDT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 21 Jun 2018 16:14:43 -0400 (EDT)
Subject: Re: [PATCH v2 1/4] tpm: Implement tpm_chip_find() and tpm_chip_put()
 for other subsystems
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
References: <20180620204236.1572523-1-stefanb@linux.vnet.ibm.com>
 <20180620204236.1572523-2-stefanb@linux.vnet.ibm.com>
 <20180621171518.GI11859@linux.intel.com>
 <95b2970f-b71b-4cfc-c188-7ae7e8cb94c5@linux.vnet.ibm.com>
 <20180621175601.GC19270@ziepe.ca>
 <743f606f-b3eb-6917-33bb-5b080f76fe3f@linux.vnet.ibm.com>
 <20180621190620.GE19270@ziepe.ca>
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
Date:   Thu, 21 Jun 2018 16:14:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180621190620.GE19270@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 18062120-0068-0000-0000-0000030C7C3F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009234; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01050340; UDB=6.00538269; IPR=6.00829310;
 MB=3.00021791; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-21 20:14:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062120-0069-0000-0000-000044C3AD3D
Message-Id: <9fd8786e-f223-0b06-ce31-78c828348e83@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-21_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806210217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/21/2018 03:06 PM, Jason Gunthorpe wrote:
> On Thu, Jun 21, 2018 at 02:19:44PM -0400, Stefan Berger wrote:
>> On 06/21/2018 01:56 PM, Jason Gunthorpe wrote:
>>> On Thu, Jun 21, 2018 at 01:45:03PM -0400, Stefan Berger wrote:
>>>> On 06/21/2018 01:15 PM, Jarkko Sakkinen wrote:
>>>>> On Wed, Jun 20, 2018 at 04:42:33PM -0400, Stefan Berger wrote:
>>>>>> Implement tpm_chip_find() for other subsystems to find a TPM chip and
>>>>>> get a reference to that chip. Once done with using the chip, the reference
>>>>>> is released using tpm_chip_put().
>>>>>>
>>>>>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>>>> You should sort this out in a way that we don't end up with duplicate
>>>>> functions.
>>>> Do you want me to create a function *like* tpm_chip_find_get() that takes an
>>>> additional parameter whether to get the ops semaphore and have that function
>>>> called by the existing tpm_chip_find_get() and the new tpm_chip_find(). The
>>>> latter would then not get the ops semphore. I didn't want to do this since
>>>> one time the function returns with a lock held and the other time not.
>>> Another option, and I haven't looked, is to revise the callers of
>>> tpm_chip_find_get to not require it to hold the ops semaphore for
>>> them.
>> We have tpm_chip_unregister calling tpm_del_char_device to set the ops to
>> NULL once a chip is unregistered. All existing callers, if they pass in a
>> tpm_chip != NULL, currently fail if the ops are NULL. (If they pass in
>> tpm_chip = NULL, they shouldn't find a chip once ops are null and it has
>> been removed from the IDR). I wouldn't change that since IMA will call in
>> with a tpm_chip != NULL and we want to protect the ops. All existing code
>> within the tpm subsystem does seem to call tpm_chip_find_get() with a NULL
>> pointer, though. Also trusted keys seems to pass in a NULL pointer every
>> time.
>>
>>> Either by giving them an API to do it, or revising the TPM entry
>>> points to do it.
>>>
>>> I didn't look, but how did the ops semaphore get grabbed in your
>>> revised patches? They do grab it, right?
>> The revised patches do not touch the existing code much but will call
>> tpm_chip_find_get() and get that semaphore every time before the ops are
>> used. IMA is the only caller of tpm_chip_find() that now gets an additional
>> reference to the tpm_chip and these APIs get called like this from IMA:
>>
>> ima init: chip = tpm_chip_find()
>>
>> ima::tpm: tpm_chip_find_get(chip) ... tpm_put_ops(chip)
>>
>> ima::tpm: tpm_chip_find_get(chip) ... tpm_put_ops(chip)
>>
>> [repeat]
>>
>> ima shutdown: tpm_chip_put(chip)
> Maybe just change tpm_chip_find_get() into tpm_get_ops(chip) and
> convert all callers?

And then re-introduce tpm_chip_find_get() for IMA to call ?

