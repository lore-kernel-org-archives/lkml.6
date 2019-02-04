Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEDEC282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7958D2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbfBDSQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:16:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37394 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729540AbfBDSP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 13:15:57 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x14IAekI073387
        for <linux-kernel@vger.kernel.org>; Mon, 4 Feb 2019 13:15:56 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qercreeqq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 13:15:55 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Mon, 4 Feb 2019 18:15:55 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 4 Feb 2019 18:15:51 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x14IFoeH21299298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Feb 2019 18:15:50 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49A35AC05F;
        Mon,  4 Feb 2019 18:15:50 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B7F0AC060;
        Mon,  4 Feb 2019 18:15:47 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.235.178])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Mon,  4 Feb 2019 18:15:46 +0000 (GMT)
References: <87zhrj8kcp.fsf@morokweng.localdomain> <87womn8inf.fsf@morokweng.localdomain> <20190129134750-mutt-send-email-mst@kernel.org> <6c68f7f7-1b28-6eba-9b8b-2c32efac9701@redhat.com> <20190129213137-mutt-send-email-mst@kernel.org> <20190130074427.GA29516@lst.de>
User-agent: mu4e 1.0; emacs 26.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        David Gibson <david@gibson.dropbear.id.au>,
        Alexey Kardashevskiy <aik@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
In-reply-to: <20190130074427.GA29516@lst.de>
Date:   Mon, 04 Feb 2019 16:15:41 -0200
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19020418-0072-0000-0000-000003F491EC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010536; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01156339; UDB=6.00603145; IPR=6.00936798;
 MB=3.00025434; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-04 18:15:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020418-0073-0000-0000-00004B0F3C0F
Message-Id: <875ztzxvw2.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-04_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=927 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902040140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph Hellwig <hch@lst.de> writes:

> On Tue, Jan 29, 2019 at 09:36:08PM -0500, Michael S. Tsirkin wrote:
>> This has been discussed ad nauseum. virtio is all about compatibility.
>> Losing a couple of lines of code isn't worth breaking working setups.
>> People that want "just use DMA API no tricks" now have the option.
>> Setting a flag in a feature bit map is literally a single line
>> of code in the hypervisor. So stop pushing for breaking working
>> legacy setups and just fix it in the right place.
>
> I agree with the legacy aspect.  What I am missing is an extremely
> strong wording that says you SHOULD always set this flag for new
> hosts, including an explanation why.

My understanding of ACCESS_PLATFORM is that it means "this device will
behave in all aspects like a regular device attached to this bus". Is
that it? Therefore it should be set because it's the sane thing to do?

--
Thiago Jung Bauermann
IBM Linux Technology Center

