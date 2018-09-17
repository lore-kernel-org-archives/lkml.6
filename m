Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F812ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5382147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OdnPfNf2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5382147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbeIQIbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:31:03 -0400
Received: from mail-eopbgr690131.outbound.protection.outlook.com ([40.107.69.131]:27472
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730105AbeIQIbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBtckhLsJh/6IoRgjxg6z9I4aZgWreMdx4dFFBMoJqE=;
 b=OdnPfNf25XI61h52tKYo4Pc9yUgkrHjQB3+wardDEPwPvrTUPZC4MZI6PkmK8/FNzEentxGGLTZ6/ZEIqBZsY8GgsW+z8I8fmwhamg5yW4s2oir+sODF3wH1HG8rJPWsp/rG+E3TaMrRInrLPr+Ka9mfjRX3ifnYeZxmg97v0g0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:05:39 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:39 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Michael Scott <michael@opensourcefoundries.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 11/57] 6lowpan: iphc: reset mac_header after
 decompress to fix panic
Thread-Topic: [PATCH AUTOSEL 4.9 11/57] 6lowpan: iphc: reset mac_header after
 decompress to fix panic
Thread-Index: AQHUTjMP8VK+Jzex8kOb4pF1XGNIpw==
Date:   Mon, 17 Sep 2018 03:03:50 +0000
Message-ID: <20180917030340.378-11-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:yrSNtPz2a3EW+S5OxInSPiEUj9+W+jCahQCnFi2iTvMjyDunvGtHGd/MUMWx2zpeIwT81EEJjjZ0DWVVUMmV+4CLXw5lzbFbNrfTGXJfuFNGIqeQSG0KaYJQwcodg7meLyLJXu/1+j/s3yJVlV4HtgG+H/zDLXXi2S96Cg3sze6ZLLvzmZI4gQsTSBEE8xE74WJCxlxh8e3ZS/aSBxHGrWRTAn8Jfaqn0+Re/MNkDcoJtDNCmrD2lc8je7UV5Pcop2/4Kioj1/JzJJIJd4hg2mS3JFrcqsN31OSnMik3aR6AiGCwhnmYJdbD8/OM4FCubkFVMF71+Zhkf9PqJCdhcLSBwyz7nxQtXsnqd2OdW3Ub1Hvrfhn0NjJRIpTD30gmxV+Z0sLiZTLwFS0JGu3Kf1Hlz0+pSeFrSFRL7cuQVVwcwT1sngDDYs3N0iKT4kATrc6nw/R+mdYgvV5Fao3z5A==;5:bH25dR5Jrd6sXqCtVXUsuvwhS9IzVVMCADg/4jwknjjdjzwTkXkHzettQymlcDjugYyJSEoi8L7jd9KYtV/HbuNmQjnOcMz+GZzMXVH6Q/8peoPWpB6HHCjgDbi7eK5hkCXswC6DshhzHUG9jyN727VatldVb2fP5KVsF2ElphU=;7:8nI0cF5GX0nDGRRCA8F3Ez1F92JMulfQfkbk3vMy1TtVJGn6IjrBmt37Y+FatjNKtpo04I4l1rFqiSERBj6E3KGLfESy9Fje0y8OTxvagAngM7071Dx0yj+8sADFhuzqfGHgO7Vn7C2sfVFmyPoGEXU3rsx2l5wasJPmMl2S15vxZ9lXnPJpM3t+K7ExByX06Wjz6Wt3oWEhzA8A/IHLr+MfnjbKplFkJUrujMGsnCjVyXbFeTyUnIN/oX4d7goE
x-ms-office365-filtering-correlation-id: 3ee0ab31-f461-4d9a-7c1f-08d61c4a725d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB012090AB5718362CDFFF188BFB1E0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(54906003)(26005)(110136005)(446003)(2906002)(6346003)(99286004)(316002)(86362001)(25786009)(102836004)(10090500001)(2616005)(2900100001)(76176011)(97736004)(36756003)(11346002)(72206003)(478600001)(10290500003)(3846002)(6116002)(1076002)(22452003)(107886003)(5250100002)(2501003)(86612001)(4326008)(217873002)(105586002)(106356001)(6486002)(14444005)(14454004)(256004)(6436002)(8676002)(305945005)(8936002)(6506007)(81156014)(81166006)(7736002)(476003)(486006)(68736007)(186003)(66066001)(6512007)(53936002)(5660300001)(6666003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: qH9Cxno/O3zdN5pZAItTV8+Etm5dPu55EQAFBYkm/RJzgJBq1/3rjFh4lq3NvxEy5LbN0Ld7svIGmoBfMslCRNQ0XvwXyqGQTF4yw7ot9Ebm2HWSyhTv/5y5fE/MnACG81Dq5x7+AAiXD/RwEPLExqpWaWYBXcWo7eIshcHgp96ZZC0Vjn66GfxFsOrTUc6JjZDGJTP9yHhJk7Ha0L7CsBtbub+SZvo6BVtnAD04ap68NSQQWMtSWWjSjZD6KlK/ovPYLMx6nhlavflfxl2f/16dTueXrxQhcQOZZEzPybjE2II3ld8GYHAOYbgjUIUcw5WhvSe7hS1VZD6KceFAZx2h036QVoCFH/K8m5TY2dU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee0ab31-f461-4d9a-7c1f-08d61c4a725d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:50.3992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
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
index 79f1fa22509a..23654f1902f3 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -745,6 +745,7 @@ int lowpan_header_decompress(struct sk_buff *skb, const=
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
