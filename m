Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B98C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 08:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E861F20862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 08:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E861F20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbeG1KDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 06:03:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46872 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726168AbeG1KDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 06:03:14 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6S8UFip142760
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 04:37:31 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kgn1er5ss-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 04:37:31 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <khandual@linux.vnet.ibm.com>;
        Sat, 28 Jul 2018 09:37:29 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 28 Jul 2018 09:37:24 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6S8bNNZ24576014
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 28 Jul 2018 08:37:23 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1E694203F;
        Sat, 28 Jul 2018 11:37:36 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C3BB42047;
        Sat, 28 Jul 2018 11:37:34 +0100 (BST)
Received: from localhost.localdomain (unknown [9.122.224.197])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 28 Jul 2018 11:37:34 +0100 (BST)
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
To:     "Michael S. Tsirkin" <mst@redhat.com>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180720161541-mutt-send-email-mst@kernel.org>
 <8f51d2c6-cc0c-9e42-f0fd-a8a33acc8b83@linux.vnet.ibm.com>
 <20180723120511-mutt-send-email-mst@kernel.org>
 <4062dd48-2b5b-e454-e860-c6bfe321ebdc@linux.vnet.ibm.com>
 <20180727143008-mutt-send-email-mst@kernel.org>
Cc:     robh@kernel.org, srikar@linux.vnet.ibm.com, aik@ozlabs.ru,
        jasowang@redhat.com, linuxram@us.ibm.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, hch@infradead.org,
        paulus@samba.org, joe@perches.com, linuxppc-dev@lists.ozlabs.org,
        elfring@users.sourceforge.net, haren@linux.vnet.ibm.com,
        david@gibson.dropbear.id.au
From:   Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date:   Sat, 28 Jul 2018 14:07:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180727143008-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18072808-0016-0000-0000-000001ED39AA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072808-0017-0000-0000-0000324249BB
Message-Id: <986656ee-37e9-0d99-3d1f-a48466ffe0ed@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-28_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=781 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807280091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/27/2018 05:01 PM, Michael S. Tsirkin wrote:
> On Wed, Jul 25, 2018 at 08:56:23AM +0530, Anshuman Khandual wrote:
>> Results with and without the patches are similar.
> 
> Thanks! And another thing to try is virtio-net with
> a fast NIC backend (40G and up). Unfortunately
> at this point loopback tests stress the host
> scheduler too much.
> 

Sure. Will look around for a 40G NIC system. BTW I have been testing
virtio-net with a TAP device as back end.

ip tuntap add dev tap0 mode tap user $(whoami)
ip link set tap0 master virbr0
ip link set dev virbr0 up
ip link set dev tap0 up

which is exported into the guest as follows

-device virtio-net,netdev=network0,mac=52:55:00:d1:55:01 \
-netdev tap,id=network0,ifname=tap0,script=no,downscript=no \

But I have not run any network benchmarks on it though.

