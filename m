Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B08ECE564
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E262147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="erHgIBxt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E262147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbeIQI24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:28:56 -0400
Received: from mail-by2nam03on0130.outbound.protection.outlook.com ([104.47.42.130]:60384
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729888AbeIQI2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8z/Y7qHVUsVEV1qWOl9LogvCTiwtUWZVraqouAtpm0=;
 b=erHgIBxtUh/rkMBiZGdwbeKn4+vqB5md5zQ1vkWjzpTYUi9zklcKFb1pNThmrhlfA+jKkCGLMhR6fjEqbheMw2Oy/z9RludDfZTT6kw+ASL1SPWGGVHOX2vBxWd3Mu/fbv85LHhrOdrtW71zz73Zp0ciKnS3CrKFYDoEmpbl14I=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:03:34 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:34 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Michael Scott <michael@opensourcefoundries.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 15/87] 6lowpan: iphc: reset mac_header after
 decompress to fix panic
Thread-Topic: [PATCH AUTOSEL 4.14 15/87] 6lowpan: iphc: reset mac_header after
 decompress to fix panic
Thread-Index: AQHUTjLhCoy99osC2UCe8qKWu4ptnQ==
Date:   Mon, 17 Sep 2018 03:02:33 +0000
Message-ID: <20180917030220.245686-15-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:2M/xjrV7yuGOQn8AUwwWAwproiYzow6IesfSDHEIKfIEXWEWDkI9fPykjJ44H0CYBlvQfIOThsesgVZyliuXD6V2OQnZelCskBAh4lhqVM8aqDB/zQ9QbzzudnEys0GOWtbWp4VyfzAMcxJhCGXtXP+RTUEfXnK88569D+mijAn7GM+erGfCi32PBjGMDtJeU4QweUmYC1nwZ01xEy/6HGAtnKErOrBs4xJZVab2HbppNDKW7/CaPkFZQCA0n+iPeDuwMhH4oOkQbjnM/YJJtMrEUv2XUZ1uO+TF5TGeFZp377PHf4UH6Z2bKduk/b0+ycLhDm8zL71XlugATvH5u4FpRV7tCLgoBebaF2EOM4PKchCT2PoYkfaf6DKuijgkJzmLtGsMn94AdHIKqLu7tS4D0ugZ8n5x7Xuoyg2xBOOiiLpddKm3icTSNI1W1qJ5t37KOdnoEfKsPBSuqzo6Hg==;5:C5NDwkDfppCbKtged6KUmYXbSC3zZj6pi0dLKft9hFlr3qpSF21jLb99JcuxTXOCzgH8trfW2Vyuezg6H234cxcjx8Q9ewz0HCV6a42p/xSv0hW4bsaPSXOo966uO+51lhwvT9s0arceGD7NvVk563hseb7iXeB7mKHjEFzm9XE=;7:Mlo8tff/CluWhvP2rUBc1zvsnbNgoGs2ZETjjYUrvTi83okpvwgFGBb6CKVDCa8RtljW5oV1T/R0DEUirqqLF3iCUyxE8IcvjicG7ahA3gUYjoJnCYTVaiM1flrJr5K+gRX21kHipXIiQfROOyzUfefC4OxuHPkCoYt6GmxdghIhkHF0bTYTwL3/fvvwGx6iyEc0nz377SoSAwrjYgOGd31CH5LbhtEFvCsjJjTAdAEBQKO0zP4iYhLjyHIH3GCg
x-ms-office365-filtering-correlation-id: de9441b8-4a5f-4f37-6689-08d61c4a2852
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB085555FA10B24AF533D86B1BFB1E0@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6436002)(99286004)(7736002)(110136005)(54906003)(97736004)(5660300001)(66066001)(446003)(72206003)(76176011)(86362001)(86612001)(81166006)(81156014)(2906002)(478600001)(305945005)(68736007)(105586002)(2616005)(106356001)(476003)(11346002)(22452003)(6486002)(10090500001)(10290500003)(8676002)(36756003)(6346003)(6116002)(6506007)(3846002)(102836004)(107886003)(6512007)(1076002)(25786009)(217873002)(4326008)(14454004)(26005)(256004)(14444005)(486006)(186003)(316002)(2900100001)(8936002)(53936002)(5250100002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: l/Mu5kuJ/9L1+mLrF14DBJvXQI2+xBrq0Td44YrEmdLWoVgfREl9OP6AKb1LTTa7k3FpBtj9SDZdYuTjLoMBHSa6HNh1Nq5+SzP6ef/V4XXGKea/actzTvxQsQPnKZG7NycJNTt4zCfV1AJFjICp3hfULwy4bDp5DvOjMBrGapndo7uKE/ZyXR/ucn24MA2XAeFTuboUmDgDjqIaZj2eEOXCjQcix7ZOZz33JrvdQHmmvl1amaezvRbbW9oGsvn027mB82QAOO9R6irbE3nE50c8dlrASCoLY3+Xk+6F4NjxDkMqMrncBK6xViS/O9aQckQ0vH2NN1RXQnVtkVHMHPamI8/U8geK83i5HXzLeAw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de9441b8-4a5f-4f37-6689-08d61c4a2852
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:33.9782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
