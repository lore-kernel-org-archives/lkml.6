Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B62C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37F22174A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C37F22174A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbeHIJ4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 05:56:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33534 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728224AbeHIJ4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 05:56:46 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w797O17l039751
        for <linux-kernel@vger.kernel.org>; Thu, 9 Aug 2018 03:33:14 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2krdj6fp5n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 03:33:14 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 9 Aug 2018 08:33:11 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 Aug 2018 08:33:09 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w797X7wX41418906
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Aug 2018 07:33:07 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6065F42041;
        Thu,  9 Aug 2018 10:33:15 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89B374203F;
        Thu,  9 Aug 2018 10:33:14 +0100 (BST)
Received: from [9.152.224.92] (unknown [9.152.224.92])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Aug 2018 10:33:14 +0100 (BST)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v8 20/22] KVM: s390: Handling of Cypto control block in
 VSIE
To:     Janosch Frank <frankja@linux.ibm.com>,
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
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1533739472-7172-21-git-send-email-akrowiak@linux.vnet.ibm.com>
 <dc8b3e66-9ba4-2b78-1e49-12a35d5d234b@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Thu, 9 Aug 2018 09:33:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <dc8b3e66-9ba4-2b78-1e49-12a35d5d234b@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18080907-0028-0000-0000-000002E8420E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080907-0029-0000-0000-000023A14FE7
Message-Id: <a8f0c2f2-6e4c-3a06-0f89-aea3fcc0b985@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-09_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808090078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2018 08:20, Janosch Frank wrote:
> On 08.08.2018 16:44, Tony Krowiak wrote:
>> From: Pierre Morel <pmorel@linux.ibm.com>
>> +#define ECA_APIE 0x00000008
> That shouldn't be necessary, it's defined in kvm_host.h which vsie.c
> includes. Or is it not?

This was forgotten here for a long long time!
You are right I remove it.

>
>> +static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>> +{
>> +	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
>> +	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
>> +	const uint32_t crycbd_o = READ_ONCE(scb_o->crycbd);
>> +	const u32 crycb_addr = crycbd_o & 0x7ffffff8U;
>> +	int g2_fmt = vcpu->arch.sie_block->crycbd & CRYCB_FORMAT_MASK;
>> +	int g3_fmt = crycbd_o & CRYCB_FORMAT_MASK;
>> +	int g2_apie, g2_msa3, g3_apie, g3_msa3;
>> +	int size, ret;
>> +
>> +	/* crycb should not cross a page boundary */
>> +	size = (g3_fmt == CRYCB_FORMAT2) ? 0x100 : 0x80;
>> +	if ((crycb_addr & PAGE_MASK) != ((crycb_addr + size) & PAGE_MASK))
>> +		return set_validity_icpt(scb_s, 0x003CU);
>> +
>> +	g2_apie = vcpu->arch.sie_block->eca & ECA_APIE;
>> +	g3_apie = scb_o->eca & g2_apie;
>> +
>> +	g2_msa3 = test_kvm_facility(vcpu->kvm, 76);
>> +	g3_msa3 = (g3_fmt != CRYCB_FORMAT0) & g2_msa3;
>> +
>> +	scb_s->crycbd = 0;
>> +	/* If no AP instructions and no keys we just set crycbd to 0 */
>> +	if (!(g3_apie || g3_msa3))
>> +		return 0;
>> +
>> +	if (!crycb_addr)
>> +		return set_validity_icpt(scb_s, 0x0039U);
>> +
>> +	if (g3_apie) {
>> +		ret = copy_apcb(vcpu, vsie_page, g2_fmt, g3_fmt);
>> +		if (ret)
>> +			goto out;
> s/goto out;/return ret;/

better

Thanks

Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

