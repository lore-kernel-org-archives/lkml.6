Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F588C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AA420862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0AA420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbeGaIj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:39:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46626 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726591AbeGaIj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:39:28 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6V6xJIk134392
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 03:00:37 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kjg2pe52g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 03:00:37 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <khandual@linux.vnet.ibm.com>;
        Tue, 31 Jul 2018 08:00:35 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 31 Jul 2018 08:00:32 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6V70VeW10027010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 31 Jul 2018 07:00:31 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8AB611C05B;
        Tue, 31 Jul 2018 10:00:42 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05DFC11C066;
        Tue, 31 Jul 2018 10:00:32 +0100 (BST)
Received: from [9.202.14.95] (unknown [9.202.14.95])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jul 2018 10:00:31 +0100 (BST)
Subject: Re: [RFC 2/4] virtio: Override device's DMA OPS with
 virtio_direct_dma_ops selectively
To:     Christoph Hellwig <hch@infradead.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180720035941.6844-3-khandual@linux.vnet.ibm.com>
 <20180730092551.GB26245@infradead.org>
Cc:     robh@kernel.org, srikar@linux.vnet.ibm.com, mst@redhat.com,
        aik@ozlabs.ru, jasowang@redhat.com, linuxram@us.ibm.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, paulus@samba.org,
        joe@perches.com, linuxppc-dev@lists.ozlabs.org,
        elfring@users.sourceforge.net, haren@linux.vnet.ibm.com,
        david@gibson.dropbear.id.au
From:   Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date:   Tue, 31 Jul 2018 12:30:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180730092551.GB26245@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18073107-4275-0000-0000-000002A11C00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18073107-4276-0000-0000-000037A92B60
Message-Id: <1e197586-4e11-48e1-a0dd-c2c440c64f9e@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-31_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=840 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807310076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/30/2018 02:55 PM, Christoph Hellwig wrote:
>> +const struct dma_map_ops virtio_direct_dma_ops;
> 
> This belongs into a header if it is non-static.  If you only
> use it in this file anyway please mark it static and avoid a forward
> declaration.

Sure, will make it static, move the definition up in the file to avoid
forward declaration.
 
> 
>> +
>>  int virtio_finalize_features(struct virtio_device *dev)
>>  {
>>  	int ret = dev->config->finalize_features(dev);
>> @@ -174,6 +176,9 @@ int virtio_finalize_features(struct virtio_device *dev)
>>  	if (ret)
>>  		return ret;
>>  
>> +	if (virtio_has_iommu_quirk(dev))
>> +		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);
> 
> This needs a big fat comment explaining what is going on here.

Sure, will do. Also talk about the XEN domain exception as well once
that goes into this conditional statement.

> 
> Also not new, but I find the existance of virtio_has_iommu_quirk and its
> name horribly confusing.  It might be better to open code it here once
> only a single caller is left.

Sure will do. There is one definition in the tools directory which can
be removed and then this will be the only one left.

