Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EDCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153452184A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="ZImJM7vH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbfB0SHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 13:07:54 -0500
Received: from esa8.dell-outbound.iphmx.com ([68.232.149.218]:41351 "EHLO
        esa8.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726397AbfB0SHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 13:07:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1551290873; x=1582826873;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=4wLTAArmrxDrUF8k4UYqATpS1Omcy/GZtedgtcCtxJA=;
  b=ZImJM7vHqe9n6nEFcNIas4JEanCfW13Of3vM1SBzcvmX+n4qFpJt7ieg
   UGTdBqszCLATxgbF2FrykM2/gM0KQkjfEdBDNejmaTcmICChWxbLxcYIv
   UGsuT/ToD/Y4Wmwpf0F9vpYGwOTtGLFBCPyEovI6cCqklbS0JR56PXYhl
   w=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GhAAA30XZchieV50NkGwEBAQEDAQE?=
 =?us-ascii?q?BBwMBAQGBZYJagRQxjHeMfJobCwEBLIRAhBAiOBIBAwEBAgEBAgEBAhABAQE?=
 =?us-ascii?q?KCQsIKS+COiKCcAEBBBIoPxACAQgYHhBXAgQODRqCfoFzn2c9Am2BAYkHAQE?=
 =?us-ascii?q?Bgh6KK4xIghaDdS6FAU2FFAKMEpdYCQWSXSGBZAGRN4dvlQUCBAIEBQIUgV6?=
 =?us-ascii?q?BeHCDPYI1jidBgVmPfwGBHgEB?=
X-IPAS-Result: =?us-ascii?q?A2GhAAA30XZchieV50NkGwEBAQEDAQEBBwMBAQGBZYJag?=
 =?us-ascii?q?RQxjHeMfJobCwEBLIRAhBAiOBIBAwEBAgEBAgEBAhABAQEKCQsIKS+COiKCc?=
 =?us-ascii?q?AEBBBIoPxACAQgYHhBXAgQODRqCfoFzn2c9Am2BAYkHAQEBgh6KK4xIghaDd?=
 =?us-ascii?q?S6FAU2FFAKMEpdYCQWSXSGBZAGRN4dvlQUCBAIEBQIUgV6BeHCDPYI1jidBg?=
 =?us-ascii?q?VmPfwGBHgEB?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa8.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Feb 2019 12:07:52 -0600
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1RHwIg8168405
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 13:07:52 -0500
Received: from esa5.dell-outbound2.iphmx.com (esa5.dell-outbound2.iphmx.com [68.232.153.203])
        by mx0a-00154901.pphosted.com with ESMTP id 2qwvth145h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 13:07:51 -0500
Received: from ausxipps310.us.dell.com ([143.166.148.211])
  by esa5.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 28 Feb 2019 00:07:39 +0600
X-LoopCount0: from 10.166.135.138
X-IronPort-AV: E=Sophos;i="5.58,420,1544508000"; 
   d="scan'208";a="324356052"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <kbusch@kernel.org>
CC:     <torvalds@linux-foundation.org>, <axboe@fb.com>,
        <sagi@grimberg.me>, <linux-kernel@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <keith.busch@intel.com>,
        <mr.nuke.me@gmail.com>, <hch@lst.de>, <jonathan.derrick@intel.com>
Subject: Re: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
Thread-Topic: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
Thread-Index: AQHUyksMhaVeVw7H30qZ9nZ8VEPxSQ==
Date:   Wed, 27 Feb 2019 18:07:49 +0000
Message-ID: <3f79c82de9844fb6b2e9d31d044f98de@ausx13mps317.AMER.DELL.COM>
References: <20190222010502.2434-1-jonathan.derrick@intel.com>
 <CAHk-=wjmjHyovjtzaq=HSegEpiO2SXWaYfJ6qsJrZhXg_YSx5g@mail.gmail.com>
 <2b7d8f45d11c47e69f56ad1bc3324dd1@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wg_e5M0b5aJJf8V_UYaqX12YYA9MEg=gHNp6ALE5fK23w@mail.gmail.com>
 <cbe2ed1562a64609be6538f5816ec1b6@ausx13mps321.AMER.DELL.COM>
 <20190225155501.GI10237@localhost.localdomain>
 <b35ebf928ed743cca6649a191c76957b@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wgRdATtsBzo-LDkWn_sW-PJvq95SahZcsTxxDMPzLWxKA@mail.gmail.com>
 <940d608e1a044a54abcb9d65923951f3@ausx13mps317.AMER.DELL.COM>
 <20190227175119.GB19455@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.11.234]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=982 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902270123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/19 11:51 AM, Keith Busch wrote:=0A=
> I can't tell where you're going with this. It doesn't sound like you're=
=0A=
> talking about hotplug anymore, at least.=0A=
=0A=
We're trying to fix an issue related to hotplug. However, the proposed =0A=
fixes may have unintended consequences and side-effects. I want to make =0A=
sure that we're aware of those potential problems.=0A=
=0A=
Alex=0A=
=0A=
=0A=
