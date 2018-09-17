Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3508BECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67D520693
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Bv0983WU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A67D520693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbeIQIck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:32:40 -0400
Received: from mail-eopbgr690120.outbound.protection.outlook.com ([40.107.69.120]:6882
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730361AbeIQIcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ls2IBexs5ZXEZBOIBitLq0g/h+ExtdLDprJpqEsCBmg=;
 b=Bv0983WUG6isH2Sd7AntdpWsA3KeWPUPYfzwob9lHJGDtzyqonYeimsCGDqZ5QccxxEoatZ/PH5Mw0ScwtRhMAzpsMzGtNI+/zly4xaeXQbVr8uWxTl6xbhTadCa2oBDQVvLgg70e///6Id57gxOvVwTUZe9PlZugsxd93BM+tE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0166.namprd21.prod.outlook.com (10.173.192.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:07:04 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:04 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Michael Scott <michael@opensourcefoundries.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 10/43] 6lowpan: iphc: reset mac_header after
 decompress to fix panic
Thread-Topic: [PATCH AUTOSEL 4.4 10/43] 6lowpan: iphc: reset mac_header after
 decompress to fix panic
Thread-Index: AQHUTjM1jGOeUQoBV0W+sJaCXPE8BA==
Date:   Mon, 17 Sep 2018 03:04:54 +0000
Message-ID: <20180917030445.484-10-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0166;6:FQ3X6zAyC+OsnvjW4/55briHdoI2SINF/4sPL4Ht66585210o2DQfS2+ezUcBkfTqy/qfNlVEZiYM7lr8dSZ48FXopFuQ7VDY7OFb/cj009oLaratJM1Z8/63SQr0OnIOgBIKW1qZjwuDymCmOwgJx3aVsS4hZgQLR5/e3ywxk2LXA4aReRAzU7dh276CBdUW8ah77tb6qBt6H4kdUIK8BUP+AtDV2Jb8abh7BAvcdEBrANroAk13u2c1UWwYHSuQ2B4jRfFogGjFPok/zxXAeQ3NnE9iuoof8EO2rBeJkjJuWX9eiMO3OYouXRbwOyK4ghSYij+eAOPa7OwVoVnl1OOUGT9GG3XsA/Bhcsw9j1Yj0INVg7wxUkgEs+/iY/V3G1ZyPmBanNQob4KyQAwAnEVl/ePhTorYHdIbEPyxT/GfOFkvh0zIIyUL+HegJe6/8zWiEiMaFrG4aQfBp4w5g==;5:QB4uRx+CaWFeepGPydgQUNX9dPWN7Hzzdnn/6K3nlHbaPMf2SWOPHUC4Ut+fccqSQWkuRNz6x9VwqOadKG09OjRZ9rsXad5T6xNMsqZ9pq6oo+aW99w41E9D1tkRyit6+1yLGmWPdjG34eXLA2qn4ScPkhdgEVVAuxTm//hNh+Y=;7:NtZtXausI+0olorqZQ8uX34lJ5R6IpfIyYNRjXWcSOuTTq8q48RRz/+LHS+huoBwqYRt9KuuNRN41Vvy/CvLyDj23IGG3lZdn80Aj4nkDonoGjQ+kZpvXcYmUb6VfFw60HvWx0XFPULgjwPE0rPi20xdIU2DhBbDNJL+mYJoz6OMgjmrNVHhSpXEMxsu37eJZnqUFbw6NEP+4K6qgCHL8vNTXXVrWsCMTFXjq3jJ3qKty0KluI57j1qkeCtIUy1/
x-ms-office365-filtering-correlation-id: 56df7b5f-b4cf-40e9-63e9-08d61c4aa539
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0166;
x-ms-traffictypediagnostic: CY4PR21MB0166:
x-microsoft-antispam-prvs: <CY4PR21MB01660F84CD50B2C924FECE90FB1E0@CY4PR21MB0166.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0166;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0166;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(366004)(39860400002)(396003)(189003)(199004)(305945005)(256004)(14444005)(217873002)(486006)(186003)(86612001)(66066001)(7736002)(6486002)(102836004)(6512007)(2900100001)(25786009)(14454004)(6666003)(2616005)(476003)(1076002)(97736004)(86362001)(6436002)(5660300001)(6346003)(316002)(2501003)(6116002)(76176011)(6506007)(105586002)(8676002)(478600001)(3846002)(106356001)(53936002)(68736007)(72206003)(446003)(22452003)(5250100002)(81156014)(8936002)(36756003)(10090500001)(107886003)(4326008)(110136005)(11346002)(99286004)(81166006)(2906002)(26005)(54906003)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0166;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: jePrtSUaApDH7k7KCrrsWvFyt0wqI44T52gVdbEi/Ds9Kpqg95/tpa6CFDIPZvAqCjVrUEJK9BS0zy5UGPTeKSxQmPzOnM2C3K3LtDve2GNgZJVw3Qx5txA7GE0JojC/+gblJHOguy42qT2paqN1dYOeU/Vj4aO8S+SJ0XYbDz0Q/3yQz+QgS3Hy/hMKfJRRPTpWpxmOmsPY3Kq0B60CtP9+tnAiIr+PLb5/N9fNgYo3/QTl88C5fYReg53fOQzbAKBB93b2iWpJuui19hozVDx7WlZvamLHTWxC+CaHrwciBjVcITGyWE25Dwwo5wphO1dxyYC1IcqDQfeDiHFrYJu+Ocymnz7rfW+JJybZq0o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56df7b5f-b4cf-40e9-63e9-08d61c4aa539
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:54.6018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Scott <michael@opensourcefoundries.com>

[ Upstream commit 03bc05e1a4972f73b4eb8907aa373369e825c252 ]

After decompression of 6lowpan socket data, an IPv6 header is inserted
before the existing socket payload.  After this, we reset the
network_header value of the skb to account for the difference in payload
size from prior to decompression + the addition of the IPv6 header.

However, we fail to reset the mac_header value.

Leaving the mac_header value untouched here, can cause a calculation
error in net/packet/af_packet.c packet_rcv() function when an
AF_PACKET socket is opened in SOCK_RAW mode for use on a 6lowpan
interface.

On line 2088, the data pointer is moved backward by the value returned
from skb_mac_header().  If skb->data is adjusted so that it is before
the skb->head pointer (which can happen when an old value of mac_header
is left in place) the kernel generates a panic in net/core/skbuff.c
line 1717.

This panic can be generated by BLE 6lowpan interfaces (such as bt0) and
802.15.4 interfaces (such as lowpan0) as they both use the same 6lowpan
sources for compression and decompression.

Signed-off-by: Michael Scott <michael@opensourcefoundries.com>
Acked-by: Alexander Aring <aring@mojatatu.com>
Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/6lowpan/iphc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 346b5c1a9185..c40eb04dd856 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -569,6 +569,7 @@ int lowpan_header_decompress(struct sk_buff *skb, const=
 struct net_device *dev,
 		hdr.hop_limit, &hdr.daddr);
=20
 	skb_push(skb, sizeof(hdr));
+	skb_reset_mac_header(skb);
 	skb_reset_network_header(skb);
 	skb_copy_to_linear_data(skb, &hdr, sizeof(hdr));
=20
--=20
2.17.1
