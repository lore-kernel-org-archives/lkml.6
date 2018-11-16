Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3073C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964FA2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="lNNhsuzu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964FA2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbeKQGbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 01:31:02 -0500
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:49506 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725819AbeKQGbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 01:31:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1542399399; x=1573935399;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q9rr5wDASznNv+VIvUkbahSjY7vRiRq+kazY61dM4eQ=;
  b=lNNhsuzu3pKJGLGnhNlm+M9JtmylImlqvJ1RsNYZBVYVoGKzPXZw8Bj3
   FPPCiWGKYCLOL3GSJ0hXK306M8OhdfAjxPThZWMtOrrCtXFer9q+s2xA8
   259ciYD+r7904iAG8y/5mOf36+DE/ecEAjEuLlfs3KnBHHiWxzRvIdIEy
   s=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EYAAC7JO9bhiWd50NlHQEBBQEHBQG?=
 =?us-ascii?q?BUQgBCwGBVYIWJwqMBl+LH4INlzYUgWYLAQGEbAKDVSI0CQ0BAwEBAgEBAgE?=
 =?us-ascii?q?BAhABAQEKCQsIKS+CNiKCZQEBAQMBEig/BQsCAQg2EFcCBAENBQgagn+Begi?=
 =?us-ascii?q?dPAKBEIlYAQEBgh2KIowFghaBEYMShGeFcgKBKgGHTCAElk8GAQKRHyCBWIU?=
 =?us-ascii?q?HihuXaQIEAgQFAhSBRoIOcIFugU6CNRuOCkABMYsYKYEFgR8BAQ?=
X-IPAS-Result: =?us-ascii?q?A2EYAAC7JO9bhiWd50NlHQEBBQEHBQGBUQgBCwGBVYIWJ?=
 =?us-ascii?q?wqMBl+LH4INlzYUgWYLAQGEbAKDVSI0CQ0BAwEBAgEBAgEBAhABAQEKCQsIK?=
 =?us-ascii?q?S+CNiKCZQEBAQMBEig/BQsCAQg2EFcCBAENBQgagn+BegidPAKBEIlYAQEBg?=
 =?us-ascii?q?h2KIowFghaBEYMShGeFcgKBKgGHTCAElk8GAQKRHyCBWIUHihuXaQIEAgQFA?=
 =?us-ascii?q?hSBRoIOcIFugU6CNRuOCkABMYsYKYEFgR8BAQ?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa3.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2018 14:16:38 -0600
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAGK7udk003828;
        Fri, 16 Nov 2018 15:17:10 -0500
Received: from esa2.dell-outbound2.iphmx.com (esa2.dell-outbound2.iphmx.com [68.232.153.202])
        by mx0b-00154901.pphosted.com with ESMTP id 2nsv69jxpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Nov 2018 15:17:09 -0500
From:   <Justin.Lee1@Dell.com>
Received: from ausxippc101.us.dell.com ([143.166.85.207])
  by esa2.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Nov 2018 02:16:48 +0600
X-LoopCount0: from 10.166.135.94
X-IronPort-AV: E=Sophos;i="5.56,241,1539666000"; 
   d="scan'208";a="1162006700"
To:     <sam@mendozajonas.com>, <netdev@vger.kernel.org>
CC:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>
Subject: RE: [PATCH net-next v4 0/6] net/ncsi: Allow enabling multiple
 packages & channels
Thread-Topic: [PATCH net-next v4 0/6] net/ncsi: Allow enabling multiple
 packages & channels
Thread-Index: AQHUfWg1dcgy1q1MWUOagrTe9pjUGqVS0K7Q
Date:   Fri, 16 Nov 2018 20:17:06 +0000
Message-ID: <f41bcc1c06da4f0ead13cc97fc13d68e@AUSX13MPS302.AMER.DELL.COM>
References: <20181116045159.4980-1-sam@mendozajonas.com>
In-Reply-To: <20181116045159.4980-1-sam@mendozajonas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-16_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=808 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811160179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

I have reviewed/tested it. It works well. Thanks for supporting these featu=
res!

Justin


Reviewed-by: Justin Lee <justin.lee1@dell.com>
Tested-by: Justin Lee <justin.lee1@dell.com>


> This series extends the NCSI driver to configure multiple packages and/or=
 channels simultaneously. Since the RFC series this includes a few extra ch=
anges to fix areas in the driver that either made this harder or were roadb=
locks due to deviations from the NCSI specification.
>=20
> Patches 1 & 2 fix two issues where the driver made assumptions about the =
capabilities of the NCSI topology.
> Patches 3 & 4 change some internal semantics slightly to make multi-mode =
easier.
> Patch 5 introduces a cleaner way of reconfiguring the NCSI configuration =
and keeping track of channel states.
> Patch 6 implements the main multi-package/multi-channel configuration, co=
nfigured via the Netlink interface.
>=20
> Readers who have an interesting NCSI setup - especially multi-package wit=
h HWA - please test! I think I've covered all permutations but I don't have=
 infinite hardware to test on.
>=20
> Changes in v2:
> - Updated use of the channel lock in ncsi_reset_dev(), making the channel=
 invisible and leaving the monitor check to ncsi_stop_channel_monitor().
> - Fixed ncsi_channel_is_tx() to consider the state of channels in other p=
ackages.
> Changes in v3:
> - Fixed bisectability bug in patch 1
> - Consider channels on all packages in a few places when multi-package is=
 enabled.
> - Avoid doubling up reset operations, and check the current driver state =
before reset to let any running operations complete.
> - Reorganise the LSC handler slightly to avoid enabling Tx twice.
> Changes in v4:
> - Fix failover in the single-channel case
> - Better handle ncsi_reset_dev() entry during a current config/suspend op=
eration.
>=20
> Samuel Mendoza-Jonas (6):
>   net/ncsi: Don't enable all channels when HWA available
>   net/ncsi: Probe single packages to avoid conflict
>   net/ncsi: Don't deselect package in suspend if active
>   net/ncsi: Don't mark configured channels inactive
>   net/ncsi: Reset channel state in ncsi_start_dev()
>   net/ncsi: Configure multi-package, multi-channel modes with failover
>=20
>  include/uapi/linux/ncsi.h |  15 ++
>  net/ncsi/internal.h       |  19 +-
>  net/ncsi/ncsi-aen.c       |  75 ++++--
>  net/ncsi/ncsi-manage.c    | 522 +++++++++++++++++++++++++++-----------
>  net/ncsi/ncsi-netlink.c   | 233 ++++++++++++++---
>  net/ncsi/ncsi-rsp.c       |   2 +-
>  6 files changed, 660 insertions(+), 206 deletions(-)
>=20
> --
> 2.19.1

