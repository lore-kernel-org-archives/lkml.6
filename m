Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6547AC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B9D21545
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B9D21545
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeHOXa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:30:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41886 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726183AbeHOXa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:30:27 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7FKXjvw036712
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 16:36:43 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kvt88jd36-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 16:36:43 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Wed, 15 Aug 2018 14:36:42 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 15 Aug 2018 14:36:39 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7FKaaAY22479112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Aug 2018 13:36:36 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50845136055;
        Wed, 15 Aug 2018 14:36:36 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BB3013605D;
        Wed, 15 Aug 2018 14:36:33 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.85.175.5])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 15 Aug 2018 14:36:33 -0600 (MDT)
Subject: Re: [PATCH v9 17/22] s390: vfio-ap: zeroize the AP queues.
To:     Cornelia Huck <cohuck@redhat.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com,
        pbonzini@redhat.com, alex.williamson@redhat.com,
        pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-18-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180815182401.4cfa0a78.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Wed, 15 Aug 2018 16:36:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180815182401.4cfa0a78.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18081520-0004-0000-0000-000014771914
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009550; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01074019; UDB=6.00553444; IPR=6.00853978;
 MB=3.00022740; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-15 20:36:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081520-0005-0000-0000-0000887878A2
Message-Id: <59fddbc0-49f5-c83b-144f-7390b80dfc9f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-15_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808150209
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/15/2018 12:24 PM, Cornelia Huck wrote:
> On Mon, 13 Aug 2018 17:48:14 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
> Nit: please drop the leading period in the subject.

I assume you mean the ending period?

>
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> Let's call PAPQ(ZAPQ) to zeroize a queue:
>>
>> * For each queue configured for a mediated matrix device
>>    when it is released.
>>
>> Zeroizing a queue resets the queue, clears all pending
>> messages for the queue entries and disables adapter interruptions
>> associated with the queue.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>> Tested-by: Farhan Ali <alifm@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c     |   25 +++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_private.h |   25 +++++++++++++++++++++++++
>>   2 files changed, 50 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
>> index 3e8534b..34f982a 100644
>> --- a/drivers/s390/crypto/vfio_ap_private.h
>> +++ b/drivers/s390/crypto/vfio_ap_private.h
>> @@ -74,4 +74,29 @@ struct ap_matrix_mdev {
>>   extern int vfio_ap_mdev_register(void);
>>   extern void vfio_ap_mdev_unregister(void);
>>   
>> +static inline int vfio_ap_reset_queue(unsigned int apid, unsigned int apqi,
>> +				      unsigned int retry)
>> +{
>> +	struct ap_queue_status status;
>> +
>> +	do {
>> +		status = ap_zapq(AP_MKQID(apid, apqi));
>> +		switch (status.response_code) {
>> +		case AP_RESPONSE_NORMAL:
>> +			return 0;
>> +		case AP_RESPONSE_RESET_IN_PROGRESS:
>> +		case AP_RESPONSE_BUSY:
>> +			msleep(20);
>> +			break;
>> +		default:
>> +			pr_warn("%s: error zeroizing %02x.%04x: response code %d\n",
>> +				VFIO_AP_MODULE_NAME, apid, apqi,
>> +				status.response_code);
> How can we end up here? Does this mean that we just don't know what to
> do with this response, or is this something that should never happen?
> (How much sense does it make to print an error?)

There are additional response codes that could be returned; for example,
in the case of a catastrophic failure such as: The function can not be
performed because the AP was somehow deconfigured or the functiona
cannot be performed due to a machine check failure that caused the AP
path to be removed. It shouldn't happen, but all are possibilities.
I can get rid of the message and just return -EIO if you prefer.

>
>> +			return -EIO;
>> +		}
>> +	} while (retry--);
>> +
>> +	return -EBUSY;
>> +}
>> +
>>   #endif /* _VFIO_AP_PRIVATE_H_ */


