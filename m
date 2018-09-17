Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A900ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00AF2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="V/OVGW14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00AF2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbeIQIZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:25:51 -0400
Received: from mail-by2nam03on0137.outbound.protection.outlook.com ([104.47.42.137]:35861
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727147AbeIQIZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8z/Y7qHVUsVEV1qWOl9LogvCTiwtUWZVraqouAtpm0=;
 b=V/OVGW14cDXq07EB2M87TWrHjnC6SA2p2HF3HRthQkJKnwg8yIJWzJfmyqLXr2nlZbZO6bm/IyqRjBXoPZtxgmDHz5ggWYCbXw+GJUoWgTn654UQXtfYJZJlaHJYiqme3ek0u9ClVvG0ZH6ICH9YXG3s9RTh5yo+0dKYY7R4WhM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0277.namprd21.prod.outlook.com (10.173.193.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:00:26 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:00:26 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Michael Scott <michael@opensourcefoundries.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 021/136] 6lowpan: iphc: reset mac_header after
 decompress to fix panic
Thread-Topic: [PATCH AUTOSEL 4.18 021/136] 6lowpan: iphc: reset mac_header
 after decompress to fix panic
Thread-Index: AQHUTjKUWmuIiN20nEadXJ59v/zSkw==
Date:   Mon, 17 Sep 2018 03:00:24 +0000
Message-ID: <20180917030006.245495-21-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0277;6:bgp3N7+t+sCj668njNM54UE25rhuEiGe4BZdzg4I9MdxCOSYtJgNPWF4FGvdlM1iFQGx4joThBtjuCVUYN1JrvwPDUY/8k+xkfWZRUixfDhtOPucU/L/j3eu7NSh+yuIvddPvG7pZkAo/RDcbGWm623QQFDncswfQ/SRXceAE6tZEJ6EKfU1uXYVzT0gFLSjVVsrh6i8pkaWfAmKoHB3ERYM/L3bezNgcVJCoiq5KzduPzteN1cMpBZ1XgtM275Rs6sGJbGZPuzbfu/4v0xTRsxTDmV/7UGUZsP3AqGgNdzR9VE07j7irna7qLBXdMgUDcgx6nUvIDCbNTDD+++Q+pVX7Q1l7lc/hW1HwQ+Eatr7zqhxzHKSd7loYOUudpslM8OAOEe2bWh72nyNSKandMjyZ0wqCfDMcrgNKWyCKpbt/LvylUQ7gtPAQPCAKe3eEi93oMbU4GX26Tp1FA8VOA==;5:1lPfaOzTCn3UrEps3aNtncfzab+kUVHxa8GwA/X3pwLWfpT0Azn/vgd++1gEtklyu2xZd6Nh6cKYxttwSuef+kDqvTLDApl+iyGzStw/XBcAJhlkwUFJD7PCjrpDBHp/o9OBLKQz0Y8E22uled1OLFrSvETaQQo9+/soyzxXkOU=;7:tJbHYT8zEZkqAlQuUcAacB3tQP1E8bugDXzfgZNGmw2aDtdA2/OE5Umx/e4OzM6AfBoFW3FEIFVgXZpYvZQYGUsI/h2l5wgO3/5/uy/QdcTaJ8IQUGz8uPqCoHpZv/wV46FFK8pcoHwOfJv+UrsM3x0N5sfAK3hY8npHPs15TpB3BFP+fTOkOtxqHPD4ncAyhbaZU8p2Op1UMtXOBB+Q96/zY887UmxPrrvmgWe/1GzX8apRmCqtFSGmj0g3QdnI
x-ms-office365-filtering-correlation-id: 0e1197a3-e0ab-453a-28aa-08d61c49b7f3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0277;
x-ms-traffictypediagnostic: CY4PR21MB0277:
x-microsoft-antispam-prvs: <CY4PR21MB0277B88FC7200634216B3E58FB1E0@CY4PR21MB0277.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0277;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0277;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(199004)(189003)(446003)(4326008)(2616005)(53936002)(107886003)(11346002)(22452003)(68736007)(486006)(316002)(14454004)(106356001)(476003)(217873002)(25786009)(105586002)(10290500003)(14444005)(97736004)(66066001)(6486002)(6436002)(5660300001)(256004)(5250100002)(6512007)(2906002)(2501003)(6346003)(99286004)(72206003)(2900100001)(26005)(6116002)(186003)(1076002)(36756003)(81166006)(6506007)(10090500001)(81156014)(86612001)(102836004)(86362001)(8676002)(54906003)(8936002)(110136005)(305945005)(76176011)(478600001)(7736002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0277;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: jFmUA1cqu6SUDSt9LbxwdBfyfnHBEM2Ferzi3CihoPxgeORXubLTpWCiuEZGPHp5bWNQT0yyoT7Eryt+vs9GzNIdQflvSjb6lwQE2XI1LO2eU0lFwn60mSXbUBeYG9OK0G+g1osgk9RWQSn03hVEK7npRbwXMTH7CmLUal/r5UgAfTYjbpJ+ZbrmFaTT3dy2ep6TLnN5IP/6RQ7cN1OGoZ1DfLrlknyeAgFjPn54iADqZKXMnUWTSVv8AjK6daoZ/CTIgibC9+7kGsd6p6AWaimkNsjRIy5NKVJgUIXlSEpukN4jYi3VAcBQGl4xzVR4WqKEWPRdzjkPlZTvZdVi2P56comfRKFdSFxt7VDIygs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1197a3-e0ab-453a-28aa-08d61c49b7f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:24.5110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0277
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
index 6b1042e21656..52fad5dad9f7 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -770,6 +770,7 @@ int lowpan_header_decompress(struct sk_buff *skb, const=
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
