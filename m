Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5CDC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D0224156
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D0224156
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbeFVLkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 07:40:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33178 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751291AbeFVLko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 07:40:44 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5MBdxsx121294
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 07:40:44 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jrxynu2wj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 07:40:44 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Fri, 22 Jun 2018 07:40:40 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Jun 2018 07:40:38 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5MBeblW2294092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Jun 2018 11:40:37 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6435112065;
        Fri, 22 Jun 2018 07:40:33 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B07D1112064;
        Fri, 22 Jun 2018 07:40:33 -0400 (EDT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 22 Jun 2018 07:40:33 -0400 (EDT)
Subject: Re: [PATCH v2 3/4] ima: Use tpm_chip_find() and access TPM functions
 using it
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        linux-kernel@vger.kernel.org
References: <20180620204236.1572523-1-stefanb@linux.vnet.ibm.com>
 <20180620204236.1572523-4-stefanb@linux.vnet.ibm.com>
 <1529614425.23843.20.camel@linux.vnet.ibm.com>
 <f4af7347-a9dd-1683-5c2c-faeb45750e2e@linux.vnet.ibm.com>
 <20180622032536.GB19151@ziepe.ca>
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
Date:   Fri, 22 Jun 2018 07:40:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180622032536.GB19151@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 18062211-0068-0000-0000-0000030CC99C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009238; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01050649; UDB=6.00538454; IPR=6.00829619;
 MB=3.00021804; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-22 11:40:39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062211-0069-0000-0000-000044C588B8
Message-Id: <495fdcf7-b5b9-0341-796b-66fdf537811b@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-22_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806220133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/21/2018 11:25 PM, Jason Gunthorpe wrote:
> On Thu, Jun 21, 2018 at 04:59:55PM -0400, Stefan Berger wrote:
>> On 06/21/2018 04:53 PM, Mimi Zohar wrote:
>>> On Wed, 2018-06-20 at 16:42 -0400, Stefan Berger wrote:
>>>> Rather than accessing the TPM functions using a NULL pointer, which
>>>> causes a lookup for a suitable chip every time, get a hold of a tpm_chip
>>>> and access the TPM functions using this chip. We call the tpm_chip
>>>> ima_tpm_chip and protect it, once initialization is done, using a
>>>> rw_semaphore called ima_tpm_chip_lock.
>>>>
>>>> Use ima_shutdown to release the tpm_chip.
>>>>
>>>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>>>   security/integrity/ima/ima.h        |  3 +++
>>>>   security/integrity/ima/ima_crypto.c | 12 ++++++++++--
>>>>   security/integrity/ima/ima_init.c   | 19 ++++++++++++-------
>>>>   security/integrity/ima/ima_queue.c  |  7 +++++--
>>>>   4 files changed, 30 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>>>> index 354bb5716ce3..53a88d578ca5 100644
>>>> +++ b/security/integrity/ima/ima.h
>>>> @@ -24,6 +24,7 @@
>>>>   #include <linux/hash.h>
>>>>   #include <linux/tpm.h>
>>>>   #include <linux/audit.h>
>>>> +#include <linux/rwsem.h>
>>>>   #include <crypto/hash_info.h>
>>>>
>>>>   #include "../integrity.h"
>>>> @@ -56,6 +57,8 @@ extern int ima_policy_flag;
>>>>   extern int ima_used_chip;
>>>>   extern int ima_hash_algo;
>>>>   extern int ima_appraise;
>>>> +extern struct rw_semaphore ima_tpm_chip_lock;
>>>> +extern struct tpm_chip *ima_tpm_chip;
>>> ima_add_templatE_entry() synchronizes appending a measurement to the
>>> measurement list and extending the TPM by taking a lock.  Do we really
>>> need to introduce another lock?
>> This lock protects the ima_tpm_chip from going from != NULL to NULL in the
>> ima_shutdown function. Basically, a global pointer accessed by concurrent
>> threads should be protected if its value can change. However, in this case
>> ima_shutdown would be called so late that there shouldn't be concurrency
>> anymore. Though, I found it better to protect it. Maybe someone else has an
>> opinion?
> Why have a shutdown block? There is no harm in holding a kref if the
> machine is shutting down.

Looking around at other drivers' usage of the reboot notifier, I find 
other drivers as well that use spinlocks or mutexes during the shutdown. 
Besides that, we do have the shutdown block already when device_shutdown 
calls tpm_class_shutdown() and we get the ops_sem.

     Stefan
>
> Jason
>

