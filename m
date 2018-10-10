Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C4DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A3192087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3192087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeJKCVq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:21:46 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:11494 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726734AbeJKCVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:21:46 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w9AIsUxl018220;
        Wed, 10 Oct 2018 20:58:13 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2n0se6rpbm-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 10 Oct 2018 20:58:13 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7120531;
        Wed, 10 Oct 2018 18:58:12 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4DC80A603;
        Wed, 10 Oct 2018 18:58:12 +0000 (GMT)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 10 Oct
 2018 20:58:11 +0200
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1347.000; Wed, 10 Oct 2018 20:58:11 +0200
From:   Loic PALLARDY <loic.pallardy@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     "ohad@wizery.com" <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "s-anna@ti.com" <s-anna@ti.com>
Subject: RE: [PATCH v4 12/17] remoteproc: modify vring allocation to rely on
 centralized carveout allocator
Thread-Topic: [PATCH v4 12/17] remoteproc: modify vring allocation to rely on
 centralized carveout allocator
Thread-Index: AQHUJavkKiQgZmDpyUyOATXoSlfNXqUYSEoAgAA60UA=
Date:   Wed, 10 Oct 2018 18:58:11 +0000
Message-ID: <89f3d4bbbc484c5fb5d85f03b1325103@SFHDAG7NODE2.st.com>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
 <1532697292-14272-13-git-send-email-loic.pallardy@st.com>
 <20181010053206.GA20016@builder>
In-Reply-To: <20181010053206.GA20016@builder>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-10_11:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Bjorn Andersson [mailto:bjorn.andersson@linaro.org]
> Sent: mercredi 10 octobre 2018 07:32
> To: Loic PALLARDY <loic.pallardy@st.com>
> Cc: ohad@wizery.com; linux-remoteproc@vger.kernel.org; linux-
> kernel@vger.kernel.org; Arnaud POULIQUEN <arnaud.pouliquen@st.com>;
> benjamin.gaignard@linaro.org; s-anna@ti.com
> Subject: Re: [PATCH v4 12/17] remoteproc: modify vring allocation to rely on
> centralized carveout allocator
> 
> On Fri 27 Jul 06:14 PDT 2018, Loic Pallardy wrote:
> >  int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
> > diff --git a/drivers/remoteproc/remoteproc_virtio.c
> b/drivers/remoteproc/remoteproc_virtio.c
> [..]
> > @@ -114,6 +122,10 @@ static struct virtqueue *rp_find_vq(struct
> virtio_device *vdev,
> >  	rvring->vq = vq;
> >  	vq->priv = rvring;
> >
> > +	/* Update vring in resource table */
> > +	rsc = (void *)rproc->table_ptr + rvdev->rsc_offset;
> > +	rsc->vring[id].da = mem->da;
> > +
> 
> This would now happen after we've started the remoteproc. Don't we need
> to do this in-between allocating the carveouts and booting the
> remoteproc?

Yes da is updated after coprocessor boot, but before vdev status in resource table is set to DRIVER_OK and kick.
Coprocessor should not parse this resource before as vrings not initialized yet.
If coprocessor needs to get some information about vring carveout at boot time, carveout resources named vdev"x"vring"y" should be added to firmware resource table.
In that case information will be filled before coprocessor boot.

Regards,
Loic
> 
> Regards,
> Bjorn
