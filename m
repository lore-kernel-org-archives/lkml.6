Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3981C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADFB520880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADFB520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbeILWsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:48:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51486 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726992AbeILWsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:48:30 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8CHd4KY126072
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 13:42:54 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mf47s99fc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 13:42:54 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Wed, 12 Sep 2018 11:42:53 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Sep 2018 11:42:49 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8CHgkZY16580670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Sep 2018 10:42:46 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34B09136053;
        Wed, 12 Sep 2018 11:42:46 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78F83136055;
        Wed, 12 Sep 2018 11:42:42 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.80.213.181])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 12 Sep 2018 11:42:42 -0600 (MDT)
Subject: Re: [PATCH v9 21/22] KVM: s390: CPU model support for AP
 virtualization
To:     Cornelia Huck <cohuck@redhat.com>,
        David Hildenbrand <david@redhat.com>
Cc:     Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
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
 <1534196899-16987-22-git-send-email-akrowiak@linux.vnet.ibm.com>
 <2c2c4859-ed3e-a492-dd59-78529c7768b2@redhat.com>
 <8f3f3f41-a052-1975-69e2-49e1a662ecab@linux.ibm.com>
 <38b87fc4-9344-70d8-4602-bf8e114769ef@redhat.com>
 <20180823102447.05430368.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Wed, 12 Sep 2018 13:42:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180823102447.05430368.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18091217-0036-0000-0000-00000A35F074
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009709; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01087330; UDB=6.00561464; IPR=6.00867343;
 MB=3.00023256; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-12 17:42:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091217-0037-0000-0000-000048EA91FD
Message-Id: <1e0fc615-101c-7b9d-6dd1-de9a43fae734@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-12_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809120177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/23/2018 04:24 AM, Cornelia Huck wrote:
> On Thu, 23 Aug 2018 09:48:48 +0200
> David Hildenbrand <david@redhat.com> wrote:
>
>>> Migration of AP devices is not supported by this patch series, so this
>>> should
>>> not be an issue.
>> Might not be a problem now, but could be later. As I said in a different
>> reply, the CPU model in QEMU does not care about KVM.
>>
>> I want the QEMU CPU model and the KVM interfaces to be clean and future
>> proof. That's why my opinion is to handle PQAP(QCI) just like all the
>> other "feature blocks" we already have.
> +1 to that sentiment.
>
> It's better to try to get this correct now than having to hack around
> should we want to implement things in the future.

Just so we're on the same page here as far as what to expect for v10 of
this patch series, let me summarize the the very long series of private
exchanges as well as this thread:

* The APXA facility indicated by a bit returned in the response to the
   PQAP(QCI) function indicates only whether the APXA facility is available
   on one or more APs installed on the system.
* The only way to change the bit returned from PQAP(QCI) is to intercept the
   instruction and emulate it, so it makes no sense for passthrough devices.
* The AP(s) with APXA installed may not necessarily even be in the 
configuration.
* The only way to determine whether APXA is installed in a given AP is to
   query it using the PQAP(TAPQ) instruction.

It was decided that APXA is better modeled as device configuration. If 
and when
emulation is implemented, APXA can be configured for any AP devices assigned
to a guest. Since AP instructions will be intercepted when emulating AP,
the PQAP(QCI) instruction can return the APXA bit according to whether any
AP is configured with APXA installed. That matches the real architecture 
much
more closely. So, the bottom line is that we will not introduce a new 
CPU model
feature for APXA in v10 of this series.

>

