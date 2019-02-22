Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE72C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E896F2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfBVOCh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:02:37 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:56359 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726090AbfBVOCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 09:02:37 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1ME1wJ6000795;
        Fri, 22 Feb 2019 15:02:24 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qpc75k1tv-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 22 Feb 2019 15:02:24 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B372138;
        Fri, 22 Feb 2019 14:02:20 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag7node3.st.com [10.75.127.21])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C911B5348;
        Fri, 22 Feb 2019 14:02:20 +0000 (GMT)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG7NODE3.st.com
 (10.75.127.21) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 22 Feb
 2019 15:02:20 +0100
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1347.000; Fri, 22 Feb 2019 15:02:20 +0100
From:   Loic PALLARDY <loic.pallardy@st.com>
To:     Christoph Hellwig <hch@lst.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: linux-next: build failure after merge of the rpmsg tree
Thread-Topic: linux-next: build failure after merge of the rpmsg tree
Thread-Index: AQHUym4KrK9haDF6O0m4TBapWT3oEKXrtNUAgAAks1A=
Date:   Fri, 22 Feb 2019 14:02:20 +0000
Message-ID: <e643b3be45d342adb331d5c07139b505@SFHDAG7NODE2.st.com>
References: <20190222161817.32e35462@canb.auug.org.au>
 <20190222125046.GB29125@lst.de>
In-Reply-To: <20190222125046.GB29125@lst.de>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-22_10:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes in remoteproc have been introduced to associate dedicated dma coherent memory pool to each virtio device.
It is needed when we have several virtio devices for which buffers can't be allocated from the same memory region.
Patch introduces support in both ways:
- memory region declared thanks to reserved memory and associated thanks to of_reserved_mem_device_init_by_idx(): mainly used for regions located in DDR.
- memory region specified in rproc driver itself and defined as dma coherent thanks to dma_declare_coherent_memory(): These regions are generally located in coprocessor/SoC internal memories and declared in different ways by the different rproc drivers (regs in DT, hard coded values in drivers...).

For me, dma_declare_coherent_memory based solution is there to allow a smooth transition from current rproc drivers implementations to a cleaner and unified one based on reserved memory declaration.

Regards,
Loic

> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: vendredi 22 février 2019 13:51
> To: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>; Christoph Hellwig
> <hch@lst.de>; Linux Next Mailing List <linux-next@vger.kernel.org>; Linux
> Kernel Mailing List <linux-kernel@vger.kernel.org>; Loic PALLARDY
> <loic.pallardy@st.com>
> Subject: Re: linux-next: build failure after merge of the rpmsg tree
> 
> FYI, can I please get an explanation for the remoteproc changes?
> 
> We really should avoid adding new callers of
> dma_declare_coherent_memory,
> which is a rather badly designed interface.
