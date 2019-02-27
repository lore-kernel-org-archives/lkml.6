Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A60C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A151921850
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="cP6OWgie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbfB0ULo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:11:44 -0500
Received: from esa8.dell-outbound.iphmx.com ([68.232.149.218]:59701 "EHLO
        esa8.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729825AbfB0ULo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 15:11:44 -0500
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Feb 2019 15:11:43 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1551298303; x=1582834303;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=oRghr+kzOZOQmF7DBO7GkAgWEIgkq1EONpUYdmkFyZ0=;
  b=cP6OWgiewLwBHssznEl4ufSrQS+9sFd3BnQ/1rjBTxtMblXUUUEMrkQC
   ZdGvKDGU5BWqWbS9zKqhw57koz2F6lMsmHYOH2j7/jkidUOZ0p4Qn8R6e
   mRoKDV6rAE6mitvNrNLRuEyiaZbbcmo5D9yYHtgib6sB2+Js5G+iiSUI6
   A=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2E5AABN7HZchieV50NkHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUwUBAQsBgVSBBYEUFRyMd4x8mCAUgWcLAQGEbIQQIjYHDQEDAQECAQE?=
 =?us-ascii?q?CAQECEAEBAQoJCwgpL4I6IoJwAQEEEig/EAIBCBgeEFcCBAENDRqCfoFzoBI?=
 =?us-ascii?q?9Am2BAYkHAQEBgh6KKoxIghaBEYJkLoRpAhaFYQKKCoIIl1gHApJiIZMch2+?=
 =?us-ascii?q?CbpIXAgQCBAUCFIFODYF7cIM9gjWOJ0ABkViBHwEB?=
X-IPAS-Result: =?us-ascii?q?A2E5AABN7HZchieV50NkHAEBAQQBAQcEAQGBUwUBAQsBg?=
 =?us-ascii?q?VSBBYEUFRyMd4x8mCAUgWcLAQGEbIQQIjYHDQEDAQECAQECAQECEAEBAQoJC?=
 =?us-ascii?q?wgpL4I6IoJwAQEEEig/EAIBCBgeEFcCBAENDRqCfoFzoBI9Am2BAYkHAQEBg?=
 =?us-ascii?q?h6KKoxIghaBEYJkLoRpAhaFYQKKCoIIl1gHApJiIZMch2+CbpIXAgQCBAUCF?=
 =?us-ascii?q?IFODYF7cIM9gjWOJ0ABkViBHwEB?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa8.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Feb 2019 14:04:38 -0600
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1RJvwLk065891
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 15:04:38 -0500
Received: from esa5.dell-outbound2.iphmx.com (esa5.dell-outbound2.iphmx.com [68.232.153.203])
        by mx0a-00154901.pphosted.com with ESMTP id 2qu19yawn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 15:04:38 -0500
From:   <Austin.Bolen@dell.com>
To:     <Austin.Bolen@dell.com>, <Alex_Gagniuc@Dellteam.com>,
        <torvalds@linux-foundation.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206])
  by esa5.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 28 Feb 2019 02:04:29 +0600
X-LoopCount0: from 10.166.134.82
X-IronPort-AV: E=Sophos;i="5.58,420,1544508000"; 
   d="scan'208";a="1367835837"
CC:     <keith.busch@intel.com>, <sagi@grimberg.me>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <axboe@fb.com>, <mr.nuke.me@gmail.com>, <hch@lst.de>,
        <jonathan.derrick@intel.com>
Subject: Re: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
Thread-Topic: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
Thread-Index: AQHUyksezlXXaxBLsUa+kQskBqUhAw==
Date:   Wed, 27 Feb 2019 20:04:35 +0000
Message-ID: <443262761d0e41fbb46a46dab28759c2@AUSX13MPC131.AMER.DELL.COM>
References: <20190222010502.2434-1-jonathan.derrick@intel.com>
 <CAHk-=wjmjHyovjtzaq=HSegEpiO2SXWaYfJ6qsJrZhXg_YSx5g@mail.gmail.com>
 <2b7d8f45d11c47e69f56ad1bc3324dd1@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wg_e5M0b5aJJf8V_UYaqX12YYA9MEg=gHNp6ALE5fK23w@mail.gmail.com>
 <cbe2ed1562a64609be6538f5816ec1b6@ausx13mps321.AMER.DELL.COM>
 <20190225155501.GI10237@localhost.localdomain>
 <b35ebf928ed743cca6649a191c76957b@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wgRdATtsBzo-LDkWn_sW-PJvq95SahZcsTxxDMPzLWxKA@mail.gmail.com>
 <940d608e1a044a54abcb9d65923951f3@ausx13mps317.AMER.DELL.COM>
 <f6704855445b44639f023a48f3003309@AUSX13MPC131.AMER.DELL.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902270133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/2019 11:56 AM, Bolen, Austin wrote:=0A=
> =0A=
> BTW, this patch in particular is complaining about an error for a=0A=
> removed device.  The Dell servers referenced in this chain will check if=
=0A=
> the device is removed and if so it will suppress the error so I don't=0A=
> think they are susceptible to this particular issue and I agree it is=0A=
> broken if they do.  If that is the case we can and will fix it in firmwar=
e.=0A=
> =0A=
=0A=
Confirmed this issue does not apply to the referenced Dell servers so I =0A=
don't not have a stake in how this should be handled for those systems. =0A=
It may be they just don't support surprise removal.  I know in our case =0A=
all the Linux distributions we qualify (RHEL, SLES, Ubuntu Server) have =0A=
told us they do not support surprise removal.  So I'm guessing that any =0A=
issues found with surprise removal could potentially fall under the =0A=
category of "unsupported".=0A=
=0A=
Still though, the larger issue of recovering from other types of PCIe =0A=
errors that are not due to device removal is still important.  I would =0A=
expect many system from many platform makers to not be able to recover =0A=
PCIe errors in general and hopefully the new DPC CER model will help =0A=
address this and provide added protection for cases like above as well.=0A=
=0A=
Thanks,=0A=
Austin=0A=
