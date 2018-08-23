Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D9BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4643A2152D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4643A2152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731949AbeHWPLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 11:11:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40934 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731921AbeHWPLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 11:11:42 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7NBYgNb089794
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 07:42:21 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m1urbhdgr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 07:42:20 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 23 Aug 2018 12:42:18 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Aug 2018 12:42:15 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7NBgDMm42991800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Aug 2018 11:42:13 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 133C74C046;
        Thu, 23 Aug 2018 14:42:15 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A52664C04E;
        Thu, 23 Aug 2018 14:42:14 +0100 (BST)
Received: from [9.152.224.92] (unknown [9.152.224.92])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Aug 2018 14:42:14 +0100 (BST)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v3 2/3] KVM: s390: vsie: Do the CRYCB validation first
To:     David Hildenbrand <david@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-kernel@vger.kernel.org, cohuck@redhat.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
References: <1535019956-23539-1-git-send-email-pmorel@linux.ibm.com>
 <1535019956-23539-3-git-send-email-pmorel@linux.ibm.com>
 <b7c0b0eb-c750-caeb-41b5-d6593791a6ef@de.ibm.com>
 <cb8adf11-2bb3-4e00-ceab-f9d55c4d4f44@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Thu, 23 Aug 2018 13:42:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cb8adf11-2bb3-4e00-ceab-f9d55c4d4f44@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18082311-0028-0000-0000-000002EEAC35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082311-0029-0000-0000-000023A7F253
Message-Id: <c4a38dfb-6c78-268c-54b9-4581a292ee1a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=907 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808230125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2018 13:19, David Hildenbrand wrote:
> On 23.08.2018 13:17, Christian Borntraeger wrote:
>>
>>
>> On 08/23/2018 12:25 PM, Pierre Morel wrote:
>>> When entering the SIE the CRYCB validation better
>>> be done independently of the instruction's
>>> availability.
>>
>> Maybe something like
>>
>> We need to handle the validity checks for the crycb, no matter what the
>> settings for the keywrappings are. So lets move the keywrapping checks
>> after we have done the validy checks.
>>
>> ?
> 
> With that
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> 

Thanks, I use the description proposed by Christian.

regards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

