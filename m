Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E116C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB861208A1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB861208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeHUQt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 12:49:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58798 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726679AbeHUQt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 12:49:26 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7LDO9s0131929
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 09:29:17 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m0hq7dejb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 09:29:16 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Tue, 21 Aug 2018 09:29:16 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 Aug 2018 09:29:11 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7LDT9ik6816048
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Aug 2018 13:29:09 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 678FFB2068;
        Tue, 21 Aug 2018 09:28:16 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47727B205F;
        Tue, 21 Aug 2018 09:28:15 -0400 (EDT)
Received: from oc8043147753.ibm.com (unknown [9.80.223.104])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 21 Aug 2018 09:28:15 -0400 (EDT)
Subject: Re: [PATCH v9 07/22] KVM: s390: refactor crypto initialization
To:     David Hildenbrand <david@redhat.com>,
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
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-8-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1ba9032d-963a-6ce1-0d10-11bebbaa315f@redhat.com>
 <9c44d7b2-792a-192d-83be-1fd636a2cd2f@linux.ibm.com>
 <4b3f91be-48ef-ba68-22ba-50088e5d3509@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Tue, 21 Aug 2018 09:29:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <4b3f91be-48ef-ba68-22ba-50088e5d3509@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18082113-0068-0000-0000-0000032CCBD1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009584; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01076741; UDB=6.00555085; IPR=6.00856711;
 MB=3.00022847; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-21 13:29:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082113-0069-0000-0000-000045773C95
Message-Id: <0527e2d7-503d-ca76-d373-e5fffcc2a889@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-21_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808210142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/20/2018 04:41 PM, David Hildenbrand wrote:
>>>> +	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_AP))
>>>> +		vcpu->arch.sie_block->eca |= ECA_APIE;
>>>>    
>>>> -	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
>>>> +	/* If MSAX3 is installed on the guest, set up protected key support */
>>>> +	if (test_kvm_facility(vcpu->kvm, 76)) {
>>>> +		if (vcpu->kvm->arch.crypto.aes_kw)
>>>> +			vcpu->arch.sie_block->ecb3 |= ECB3_AES;
>>>> +		if (vcpu->kvm->arch.crypto.dea_kw)
>>>> +			vcpu->arch.sie_block->ecb3 |= ECB3_DEA;
>>>> +	}
>>> As the feature can never change, and aes_kw/dea_kw are only set to 1 in
>>> case we have test_kvm_facility(vcpu->kvm, 76), this change is not needed.
>>>
>>> I think this function can be pretty much left alone. Just add the
>>> KVM_S390_VM_CPU_FEAT_AP handling.
>> I disagree, what about the case where the KVM_S390_VM_CPU_FEAT_AP is
>> configured for the guest but the MSAX3 facility (76) is not?
> Then aes_kw/dea_kw can never be set.
>
> kvm_s390_vm_set_crypto() and kvm_s390_crypto_init() correctly test for
> facility 76.
>
> Or am I missing a case?

I stand corrected, you are right. I'll remove the test.

>
>>>>    }
>>>>    
>>>>    void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu)
>>>>
>

