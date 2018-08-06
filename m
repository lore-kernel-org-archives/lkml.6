Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB24C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5647219EB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5647219EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbeHFLKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:10:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56344 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726468AbeHFLKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:10:46 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w768xTti099252
        for <linux-kernel@vger.kernel.org>; Mon, 6 Aug 2018 05:02:41 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kphw7udky-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 05:02:41 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <khandual@linux.vnet.ibm.com>;
        Mon, 6 Aug 2018 10:02:38 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Aug 2018 10:02:34 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7692X2J41812140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Aug 2018 09:02:33 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8AC9AE057;
        Mon,  6 Aug 2018 12:02:28 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38D24AE061;
        Mon,  6 Aug 2018 12:02:25 +0100 (BST)
Received: from [9.202.14.95] (unknown [9.202.14.95])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 Aug 2018 12:02:24 +0100 (BST)
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180802235332-mutt-send-email-mst@kernel.org>
 <b31d2162-884c-0ed4-00df-e7debe0cc0e7@redhat.com>
 <20180803220812-mutt-send-email-mst@kernel.org>
 <01c74680c4b3aa25d9b4375a9ab5e10046b7c71b.camel@kernel.crashing.org>
 <20180805032355-mutt-send-email-mst@kernel.org>
Cc:     robh@kernel.org, srikar@linux.vnet.ibm.com, aik@ozlabs.ru,
        Jason Wang <jasowang@redhat.com>, linuxram@us.ibm.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, hch@infradead.org,
        paulus@samba.org, joe@perches.com, david@gibson.dropbear.id.au,
        linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net,
        haren@linux.vnet.ibm.com
From:   Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date:   Mon, 6 Aug 2018 14:32:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180805032355-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18080609-0028-0000-0000-000002E61743
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080609-0029-0000-0000-0000239E3834
Message-Id: <74a1e1b8-81e0-84db-6d0d-d8bd9caebb4a@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2018 05:54 AM, Michael S. Tsirkin wrote:
> On Fri, Aug 03, 2018 at 08:21:26PM -0500, Benjamin Herrenschmidt wrote:
>> On Fri, 2018-08-03 at 22:08 +0300, Michael S. Tsirkin wrote:
>>>>>> Please go through these patches and review whether this approach broadly
>>>>>> makes sense. I will appreciate suggestions, inputs, comments regarding
>>>>>> the patches or the approach in general. Thank you.
>>>>>
>>>>> Jason did some work on profiling this. Unfortunately he reports
>>>>> about 4% extra overhead from this switch on x86 with no vIOMMU.
>>>>
>>>> The test is rather simple, just run pktgen (pktgen_sample01_simple.sh) in
>>>> guest and measure PPS on tap on host.
>>>>
>>>> Thanks
>>>
>>> Could you supply host configuration involved please?
>>
>> I wonder how much of that could be caused by Spectre mitigations
>> blowing up indirect function calls...
>>
>> Cheers,
>> Ben.
> 
> I won't be surprised. If yes I suggested a way to mitigate the overhead.

Did we get better results (lower regression due to indirect calls) with
the suggested mitigation ? Just curious.

