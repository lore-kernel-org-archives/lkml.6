Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26920C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08B1218FF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbfBANgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 08:36:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52820 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726330AbfBANgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 08:36:16 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x11DTcWU102898
        for <linux-kernel@vger.kernel.org>; Fri, 1 Feb 2019 08:36:15 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qcpsb176t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 08:36:15 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 1 Feb 2019 13:36:13 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 1 Feb 2019 13:36:09 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x11Da8Xp5505412
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Feb 2019 13:36:08 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 501FFA4054;
        Fri,  1 Feb 2019 13:36:08 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD2CCA405B;
        Fri,  1 Feb 2019 13:36:07 +0000 (GMT)
Received: from [9.145.32.190] (unknown [9.145.32.190])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 Feb 2019 13:36:07 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v1] KVM: s390: vsie: fix Do the CRYCB validation first
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     borntraeger@de.ibm.com, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com
References: <1549014725-28216-1-git-send-email-pmorel@linux.ibm.com>
 <1549014725-28216-2-git-send-email-pmorel@linux.ibm.com>
 <20190201115041.04797c4c.cohuck@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Fri, 1 Feb 2019 14:36:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190201115041.04797c4c.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19020113-0020-0000-0000-000003104D85
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020113-0021-0000-0000-0000216150C5
Message-Id: <ce0c6def-fc2f-4490-2566-38ccbbd958fa@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902010102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2019 11:50, Cornelia Huck wrote:
> On Fri,  1 Feb 2019 10:52:05 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> The case when the SIE for guest3 is not setup for using
>> encryption keys nor Adjunct processor but the guest2
>> does use these features was not properly handled.
>>
>> This leads SIE entry for guest3 to crash with validity intercept
>> because the guest2, not having the use of encryption keys nor
>> Adjunct Processor did not initialize the CRYCB designation.
>>
>> In the case where none of ECA_APIE, ECB3_AES or ECB3_DEA
>> are set in guest3 a format 0 CRYCB is allowed for guest3
>> and the CRYCB designation in the SIE for guest3 is not checked
>> on SIE entry.
>>
>> Let's allow the CRYCD designation to be ignored when the
> 
> s/CRYCD/CRYCB/
> 
>> SIE for guest3 is not initialized for encryption key usage
>> nor AP.
>>
>> Fixup: d6f6959 (KVM: s390: vsie: Do the CRYCB validation first)
> 
> I think the canonical format is
> 
> Fixes: d6f6959ac587 ("KVM: s390: vsie: Do the CRYCB validation first")
> 
>>
> 
> CC: stable@vger.kernel.org # 4.20+
> 
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reported-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>> ---
>>   arch/s390/kvm/vsie.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>> index a153257..a748f76 100644
>> --- a/arch/s390/kvm/vsie.c
>> +++ b/arch/s390/kvm/vsie.c
>> @@ -300,6 +300,9 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>   	if (!apie_h && !key_msk)
>>   		return 0;
>>   
>> +	if (!(scb_o->eca & ECA_APIE) && !(scb_o->ecb3 & (ECB3_AES | ECB3_DEA)))
>> +		return 0;
>> +
>>   	if (!crycb_addr)
>>   		return set_validity_icpt(scb_s, 0x0039U);
>>   
> 
> Looks sane to me, but I'll let vsie experts comment.
> 

Thanks
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

