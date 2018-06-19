Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929D4C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557852083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557852083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757240AbeFSO6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:58:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42646 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S937763AbeFSO6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:58:02 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5JEsIhs036667
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:58:02 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jq34eaurt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:58:01 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alifm@linux.ibm.com>;
        Tue, 19 Jun 2018 08:58:01 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Jun 2018 08:57:57 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5JEvus812255492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Jun 2018 07:57:56 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E568DC6059;
        Tue, 19 Jun 2018 08:57:55 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 251CFC6055;
        Tue, 19 Jun 2018 08:57:55 -0600 (MDT)
Received: from [9.56.58.93] (unknown [9.56.58.93])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 19 Jun 2018 08:57:54 -0600 (MDT)
Subject: Re: [PATCH v2 0/2] Detect & register virtio-crypto algos only if it
 can be supported by backend
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        qemu-devel@nongnu.org, arei.gonglei@huawei.com,
        longpeng2@huawei.com, pasic@linux.ibm.com, frankja@linux.ibm.com,
        Jason Wang <jasowang@redhat.com>, linux-crypto@vger.kernel.org
References: <cover.1528921468.git.alifm@linux.ibm.com>
 <44ccc5db-e1d4-27b7-8942-c77f467f422e@linux.ibm.com>
 <0c5d7e42-e6c5-6aa2-8c1b-487c8cc9eb21@de.ibm.com>
 <20180619143230.zjemmhhz7embs2li@gondor.apana.org.au>
From:   Farhan Ali <alifm@linux.ibm.com>
Date:   Tue, 19 Jun 2018 10:57:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180619143230.zjemmhhz7embs2li@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18061914-8235-0000-0000-00000DC456CD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009220; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01049281; UDB=6.00537634; IPR=6.00828254;
 MB=3.00021739; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-19 14:57:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061914-8236-0000-0000-0000419552E7
Message-Id: <4301ac2e-a8f5-7432-cdd9-f39d30a9fb5e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-19_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806190167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/19/2018 10:32 AM, Herbert Xu wrote:
> On Tue, Jun 19, 2018 at 04:08:05PM +0200, Christian Borntraeger wrote:
>> On 06/19/2018 03:26 PM, Farhan Ali wrote:
>>> A polite ping :)
>>>
>>> If no one has any more comments/feedback then I would like to how to merge these patches to the mainline kernel tree.
>>
>> I think it should go via Michael Tsirkin or Jason Wang (Adding Jason).
>> Also adding Herbert Xu as FYI.
>>
>>
>> I have not looked into the details of the patch, but I like the idea.
>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> Please post crypto patches to linux-crypto.
> 
> Thanks,
> 

I have cc'ed linux-crypto folks. Sorry I missed them

Thanks
Farhan

