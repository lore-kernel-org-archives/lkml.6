Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADB4C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D2E2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="RtCUR3u/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D2E2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbeIKSBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:01:40 -0400
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:52010 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727578AbeIKSBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1536670940; x=1568206940;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9hqP4k+C2Xrla8TdvfwleG1A2HdmJByQ/ujB7rU70Yw=;
  b=RtCUR3u/CktRPHgGPx+AcDVhuUcVOh8Sfk69H+PbWqcrBM/wmLRFkawQ
   NeQCe9uNgKOhqPodweLqG+uI4uw6YAZQVhogUw5W6Av7l4ob2ZozCKNCL
   +GyJceuBDkeDM82KLKOWuEZYCFlVDpAFBiwQ4UoPjaR8BzwVhLVs7+J1g
   w=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2E/AACpvJdbhyWd50NcGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAYUgEigKi3tfjU2BdpQ+gXoLhGwChCw0GAECAQECAQECAQE?=
 =?us-ascii?q?CEAEBAQoLCQgpL4I1IoJiAQEBBBIoPwwEAgEIEQQBAQEeCQdGCQgCBA4FCBq?=
 =?us-ascii?q?Cf4ICmmGJVwEBAYIbigSMfIESgxKFS4ULApwIBwKPeh+OcJNmAgQCBAUCFIF?=
 =?us-ascii?q?Cgg5wgzyCJQ4JjhdvAYx8gR0BAQ?=
X-IPAS-Result: =?us-ascii?q?A2E/AACpvJdbhyWd50NcGQEBAQEBAQEBAQEBAQcBAQEBA?=
 =?us-ascii?q?YUgEigKi3tfjU2BdpQ+gXoLhGwChCw0GAECAQECAQECAQECEAEBAQoLCQgpL?=
 =?us-ascii?q?4I1IoJiAQEBBBIoPwwEAgEIEQQBAQEeCQdGCQgCBA4FCBqCf4ICmmGJVwEBA?=
 =?us-ascii?q?YIbigSMfIESgxKFS4ULApwIBwKPeh+OcJNmAgQCBAUCFIFCgg5wgzyCJQ4Jj?=
 =?us-ascii?q?hdvAYx8gR0BAQ?=
Received: from mx0b-00154901.pphosted.com (HELO mx0a-00154901.pphosted.com) ([67.231.157.37])
  by esa3.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Sep 2018 08:02:04 -0500
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8BCwDDk033359
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 09:02:06 -0400
Received: from esa4.dell-outbound2.iphmx.com (esa4.dell-outbound2.iphmx.com [68.232.154.98])
        by mx0b-00154901.pphosted.com with ESMTP id 2me8cpt1ne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 09:02:06 -0400
From:   <Mario.Limonciello@dell.com>
Received: from ausxipps301.us.dell.com ([143.166.148.223])
  by esa4.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 11 Sep 2018 19:02:03 +0600
X-LoopCount0: from 10.166.132.152
X-IronPort-AV: E=Sophos;i="5.53,360,1531803600"; 
   d="scan'208";a="228140250"
To:     <mika.westerberg@linux.intel.com>
CC:     <whitequark@whitequark.org>, <heikki.krogerus@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: RE: USB type-C altmode support for UCSI
Thread-Topic: USB type-C altmode support for UCSI
Thread-Index: AQHURRvNkCnRMgofNUaEjdqM0tpgmqThs/fggABa34CAAu/ZgIAE9GIwgAE7TID//+Z/QA==
Date:   Tue, 11 Sep 2018 13:02:00 +0000
Message-ID: <fd00612c1bb94f69820be2b1f1e171f9@ausx13mpc120.AMER.DELL.COM>
References: <1e8398f2c1790890f40b69f12e2934e3@whitequark.org>
 <20180903140623.GD15112@kuha.fi.intel.com>
 <28522bb57c5d8f49416b9174b19b1625@whitequark.org>
 <20180905132429.GB25121@kuha.fi.intel.com>
 <4df3faaee8904d81bf7737b5f2daaff5@ausx13mpc120.AMER.DELL.COM>
 <a2f79cc4d9a0aab4a832de31b7ddc52d@whitequark.org>
 <3a666f66d6e342e2971b800caae7c889@whitequark.org>
 <3b76178ca0de4990a38362cfd4836fdc@ausx13mpc120.AMER.DELL.COM>
 <20180911093239.GW14465@lahna.fi.intel.com>
In-Reply-To: <20180911093239.GW14465@lahna.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-11_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=719 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809110134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mika Westerberg [mailto:mika.westerberg@linux.intel.com]
> Sent: Tuesday, September 11, 2018 4:33 AM
> To: Limonciello, Mario
> Cc: whitequark@whitequark.org; heikki.krogerus@linux.intel.com; linux-
> kernel@vger.kernel.org
> Subject: Re: USB type-C altmode support for UCSI
>=20
> On Mon, Sep 10, 2018 at 09:25:48PM +0000, Mario.Limonciello@dell.com wrot=
e:
> > Also they had said it would be interesting to know if anything newer su=
ffers
> > this same fault (such as XPS 9370 or Precision 5530).
>=20
> I tried 9370 and it detects the adapter correctly. IIRC I did the same
> for 5530 and it worked as well.

Thanks for confirming that.  Hopefully the same change can be ported to PD =
controller
firmware then on other models, I'll inquire.
