Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B19BC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B122075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="yMf+1mPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B122075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbeIESUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 14:20:30 -0400
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:61395 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726309AbeIESUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 14:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1536155411; x=1567691411;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i50JMyCrAfJjl3PTC8TJijXNz3RgIJWW+54HXoX8VUs=;
  b=yMf+1mPs94ivMy5i2BPkQjxx4hcNw5K76p8FiL5z6A0m4kjcW8TH3khu
   jqJhssZJPqnnu+xZpr7d8Lz+tzTq8yP+AlNXnze41eOKLptcWGJvGEC7t
   TshF5cTpsWL1egjlELeCjPhvyG4oqxK2iUomhKFVmH+tqP9uBLj/ATDIv
   Q=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FbAACX3o9bhyeV50NaGgEBAQEBAgE?=
 =?us-ascii?q?BAQEIAQEBAYMkgg4yi3pfi1KEA5Q5gXoLhGwCg04hNBgBAgEBAgEBAgEBAhA?=
 =?us-ascii?q?BAQEKCwkIKS+CNSKCYgIBAxIoPxACAQg2EFcCBAENDRqCNEuCApggiVcBAQG?=
 =?us-ascii?q?CG4oHiliCF4ESgxKKVgKbXAcCj3YfjmKTTQIEAgQFAhSBQYIOcIM9gjKOII1?=
 =?us-ascii?q?TgR0BAQ?=
X-IPAS-Result: =?us-ascii?q?A2FbAACX3o9bhyeV50NaGgEBAQEBAgEBAQEIAQEBAYMkg?=
 =?us-ascii?q?g4yi3pfi1KEA5Q5gXoLhGwCg04hNBgBAgEBAgEBAgEBAhABAQEKCwkIKS+CN?=
 =?us-ascii?q?SKCYgIBAxIoPxACAQg2EFcCBAENDRqCNEuCApggiVcBAQGCG4oHiliCF4ESg?=
 =?us-ascii?q?xKKVgKbXAcCj3YfjmKTTQIEAgQFAhSBQYIOcIM9gjKOII1TgR0BAQ?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa6.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Sep 2018 08:50:10 -0500
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w85Dh7G6094780
        for <linux-kernel@vger.kernel.org>; Wed, 5 Sep 2018 09:50:10 -0400
Received: from esa4.dell-outbound2.iphmx.com (esa4.dell-outbound2.iphmx.com [68.232.154.98])
        by mx0a-00154901.pphosted.com with ESMTP id 2m7n0qvxsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 09:50:10 -0400
From:   <Mario.Limonciello@dell.com>
Received: from ausc60ps301.us.dell.com ([143.166.148.206])
  by esa4.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Sep 2018 19:50:09 +0600
X-LoopCount0: from 10.166.132.198
X-IronPort-AV: E=Sophos;i="5.53,333,1531803600"; 
   d="scan'208";a="1189016041"
To:     <heikki.krogerus@linux.intel.com>, <whitequark@whitequark.org>,
        <mika.westerberg@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: RE: USB type-C altmode support for UCSI
Thread-Topic: USB type-C altmode support for UCSI
Thread-Index: AQHURRvNkCnRMgofNUaEjdqM0tpgmqThs/fg
Date:   Wed, 5 Sep 2018 13:50:03 +0000
Message-ID: <4df3faaee8904d81bf7737b5f2daaff5@ausx13mpc120.AMER.DELL.COM>
References: <1e8398f2c1790890f40b69f12e2934e3@whitequark.org>
 <20180903140623.GD15112@kuha.fi.intel.com>
 <28522bb57c5d8f49416b9174b19b1625@whitequark.org>
 <20180905132429.GB25121@kuha.fi.intel.com>
In-Reply-To: <20180905132429.GB25121@kuha.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=736 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809050145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > (There's also an UCSI bug where no notifications appear when connecting
> > a device, only when disconnecting and only once, but it can be worked
> > around by reloading the module, so it isn't critical. Not sure what's u=
p
> > with that either.)
>=20
> This is indeed a separate issue, and you are the second person that
> reports it. Either the (EC) firmware on those laptops is not
> generating the connection event as is should for some reason, or the
> EC driver in Linux kernel fails to deliver the event to the UCSI
> driver. I don't have XPS 13 that I could use to reproduce the issue
> unfortunately.
>=20
> Mario! Can you help with this?
>=20

I need to know which system this was and which BIOS FW package to try to re=
produce
if I can pass this to the right people, 9360/9370?  Current FW?

Is this happening with all type-C devices?  Or just Thunderbolt?  Or (worse=
) just that
TBT device?

