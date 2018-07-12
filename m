Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27032C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47882147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47882147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732585AbeGLOrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:47:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732385AbeGLOrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:47:15 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6CEYrGB058352
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 10:37:24 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k66ft7ffk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 10:37:24 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Thu, 12 Jul 2018 08:37:23 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Jul 2018 08:37:19 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6CEbGJp12976498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Jul 2018 07:37:16 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0F65C6059;
        Thu, 12 Jul 2018 08:37:16 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD982C6055;
        Thu, 12 Jul 2018 08:37:12 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.152.224.124])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 12 Jul 2018 08:37:12 -0600 (MDT)
Subject: Re: [PATCH v6 15/21] s390: vfio-ap: configure the guest's AP matrix
To:     Halil Pasic <pasic@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-16-git-send-email-akrowiak@linux.vnet.ibm.com>
 <fb3480f2-2cdb-d8fb-c92e-4af49e74327d@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Thu, 12 Jul 2018 16:37:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <fb3480f2-2cdb-d8fb-c92e-4af49e74327d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18071214-0020-0000-0000-00000E3D0246
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009357; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01060298; UDB=6.00544246; IPR=6.00838216;
 MB=3.00022117; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-12 14:37:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071214-0021-0000-0000-00006241CF1F
Message-Id: <f937b6c6-e655-cf8a-c00b-22bdc2b98093@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-12_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=983 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807120153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2018 03:28 PM, Halil Pasic wrote:
>
>
> On 06/29/2018 11:11 PM, Tony Krowiak wrote:
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> Configures the AP adapters, usage domains and control domains for the
>
> [..]
>
>> +static inline void kvm_ap_clear_crycb_masks(struct ap_matrix_mdev 
>> *matrix_mdev)
>> +{
>> + memset(&matrix_mdev->kvm->arch.crypto.crycb->apcb0, 0,
>> + sizeof(matrix_mdev->kvm->arch.crypto.crycb->apcb0));
>> + memset(&matrix_mdev->kvm->arch.crypto.crycb->apcb1, 0,
>> + sizeof(matrix_mdev->kvm->arch.crypto.crycb->apcb1));
>> +}
>> +
>> +static void kvm_ap_set_crycb_masks(struct ap_matrix_mdev *matrix_mdev)
>> +{
>> +    int nbytes;
>> +    unsigned long *apm, *aqm, *adm;
>> +
>> +    kvm_ap_clear_crycb_masks(matrix_mdev);
>> +
>> +    apm = kvm_ap_get_crycb_apm(matrix_mdev);
>> +    aqm = kvm_ap_get_crycb_aqm(matrix_mdev);
>> +    adm = kvm_ap_get_crycb_adm(matrix_mdev);
>> +
>> +    nbytes = KVM_AP_MASK_BYTES(matrix_mdev->matrix.apm_max + 1);
>> +    memcpy(apm, matrix_mdev->matrix.apm, nbytes);
>> +
>> +    nbytes = KVM_AP_MASK_BYTES(matrix_mdev->matrix.aqm_max + 1);
>> +    memcpy(aqm, matrix_mdev->matrix.aqm, nbytes);
>> +
>> +    /*
>> +     * Merge the AQM and ADM since the ADM is a superset of the
>> +     * AQM by agreed-upon convention.
>> +     */
>> +    bitmap_or(adm, matrix_mdev->matrix.adm, matrix_mdev->matrix.aqm,
>> +          matrix_mdev->matrix.adm_max + 1);
>> +}
>> +
>
> [..]
>
>> +
>> +static int kvm_ap_configure_matrix(struct ap_matrix_mdev *matrix_mdev)
>> +{
>> +    int ret = 0;
>> +
>> +    mutex_lock(&matrix_mdev->kvm->lock);
>> +
>> +    ret = kvm_ap_validate_queue_sharing(matrix_mdev);
>> +    if (ret)
>> +        goto done;
>> +
>> +    kvm_ap_set_crycb_masks(matrix_mdev);
>> +
>> +done:
>> +    mutex_unlock(&matrix_mdev->kvm->lock);
>> +
>> +    return ret;
>> +}
>> +
>> +void kvm_ap_deconfigure_matrix(struct ap_matrix_mdev *matrix_mdev)
>> +{
>> +    mutex_lock(&matrix_mdev->kvm->lock);
>> +    kvm_ap_clear_crycb_masks(matrix_mdev);
>
> The guest may be running at this point of time, or?
>
> I think you need our safe update operation that we used to use for the
> initial set too, but then somebody was like it ain't necessary because
> we don't support hotplug (yet).

I agree.

>
>
>
> Regards,
> Halil
>
>> + mutex_unlock(&matrix_mdev->kvm->lock);
>> +}
>> +


