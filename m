Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D30C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F301215EB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F301215EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbeI1T0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 15:26:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38794 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728910AbeI1T0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 15:26:10 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8SCxYGo129300
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 09:02:28 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mskfgc5e3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 09:02:28 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Fri, 28 Sep 2018 09:02:27 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Sep 2018 09:02:23 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8SD2LA126214628
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Sep 2018 13:02:21 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5EB0AC059;
        Fri, 28 Sep 2018 09:01:44 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DA92AC066;
        Fri, 28 Sep 2018 09:01:43 -0400 (EDT)
Received: from oc8043147753.ibm.com (unknown [9.60.75.213])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 28 Sep 2018 09:01:43 -0400 (EDT)
Subject: Re: [PATCH v11 11/26] s390: vfio-ap: implement mediated device open
 callback
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
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
 <20180925231641.4954-12-akrowiak@linux.vnet.ibm.com>
 <20180928121429.7323d78b.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Fri, 28 Sep 2018 09:02:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180928121429.7323d78b.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18092813-0052-0000-0000-000003392F29
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009785; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01094877; UDB=6.00566007; IPR=6.00874912;
 MB=3.00023542; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-28 13:02:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092813-0053-0000-0000-00005E3A84BF
Message-Id: <a8f9b9c1-e59e-d467-1a36-170ffd487b9b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809280133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/28/2018 06:14 AM, Cornelia Huck wrote:
> On Tue, 25 Sep 2018 19:16:26 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> 
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> Implements the open callback on the mediated matrix device.
>> The function registers a group notifier to receive notification
>> of the VFIO_GROUP_NOTIFY_SET_KVM event. When notified,
>> the vfio_ap device driver will get access to the guest's
>> kvm structure. The open callback must ensure that only one
>> mediated device shall be opened per guest.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Acked-by: Halil Pasic <pasic@linux.ibm.com>
>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>> Tested-by: Farhan Ali <alifm@linux.ibm.com>
>> Tested-by: Pierre Morel <pmorel@linux.ibm.com>
>> Acked-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/kvm_host.h      |   1 +
>>   drivers/s390/crypto/vfio_ap_ops.c     | 159 ++++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_private.h |   5 +
>>   3 files changed, 165 insertions(+)
>>
> 
>> +static void vfio_ap_mdev_copy_masks(struct ap_matrix_mdev *matrix_mdev)
>> +{
>> +	int nbytes;
>> +	unsigned long *apm, *aqm, *adm;
>> +	struct kvm_s390_crypto_cb *crycb = matrix_mdev->kvm->arch.crypto.crycb;
>> +
>> +	switch (matrix_mdev->kvm->arch.crypto.crycbd & CRYCB_FORMAT_MASK) {
>> +	case CRYCB_FORMAT2:
>> +		apm = (unsigned long *)crycb->apcb1.apm;
>> +		aqm = (unsigned long *)crycb->apcb1.aqm;
>> +		adm = (unsigned long *)crycb->apcb1.adm;
>> +		break;
>> +	case CRYCB_FORMAT1:
>> +	case CRYCB_FORMAT0:
>> +	default:
> 
> That one looks a tad odd: the masking above should guarantee that we
> hit either the format 2, 1, or 0 cases, so the default case should
> never hit. Moreover, if the mask above will ever be changed, we don't
> know where we should look for the correct masks (what will a FORMAT<n>
> use: apcb1, apcb0, or something else?) Would it be better to moan in
> the default case and copy nothing?

It probably is a bit odd, but is not a problem now. If a new
format is added, one would hope the developer coding the change
would be smart enough to figure out what to do here.

> 
>> +		apm = (unsigned long *)crycb->apcb0.apm;
>> +		aqm = (unsigned long *)crycb->apcb0.aqm;
>> +		adm = (unsigned long *)crycb->apcb0.adm;
>> +		break;
>> +	}
>> +
>> +	nbytes = DIV_ROUND_UP(matrix_mdev->matrix.apm_max + 1, BITS_PER_BYTE);
>> +	memcpy(apm, matrix_mdev->matrix.apm, nbytes);
>> +	nbytes = DIV_ROUND_UP(matrix_mdev->matrix.aqm_max + 1, BITS_PER_BYTE);
>> +	memcpy(aqm, matrix_mdev->matrix.aqm, nbytes);
>> +	nbytes = DIV_ROUND_UP(matrix_mdev->matrix.adm_max + 1, BITS_PER_BYTE);
>> +	memcpy(adm, matrix_mdev->matrix.adm, nbytes);
>> +}
> 
> Anyway, that can be easily changed later on; in general,

true

> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

