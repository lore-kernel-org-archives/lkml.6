Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BA5C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390442077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="axKv0zRZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390442077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeIBRvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:51:43 -0400
Received: from mail-dm3nam03on0090.outbound.protection.outlook.com ([104.47.41.90]:39552
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727763AbeIBRTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYy5L4URGEHrV+99Fq9Syz724ynEmchn9bkTDup3UYA=;
 b=axKv0zRZ7WeEKjlQ3xDqrjZm6ePSs3hHNh0Gu81U3Zc/Q29WRke47BCecVWRRpN0veCkl8BY2BV6tnq65GLCipYVELRJQ1gjIfzznSXmM2R0PVxLeJlBxuIXJBOZap3aucfD5u9ByyDkdxyWQ4UCxt09Bw14HP6QdnLYsBTimxM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0135.namprd21.prod.outlook.com (10.173.189.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:08 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:08 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Denis Drozdov <denisd@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 035/131] IB/IPoIB: Set ah valid flag in multicast
 send flow
Thread-Topic: [PATCH AUTOSEL 4.18 035/131] IB/IPoIB: Set ah valid flag in
 multicast send flow
Thread-Index: AQHUQr1fjuLgdoktXkO6dn2F9eeAoA==
Date:   Sun, 2 Sep 2018 13:03:41 +0000
Message-ID: <20180902064601.183036-35-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0135;6:ST9Aj2XwBFMYGMhRVv1TanRXVxn5SFckrHCvasw+sOuoWzGlRc9jyJnNXns+AZ7nrrZ+Wybiq/5OE//4OC1OfofxNA3UfVQYJOc4AiGAGAhUYy0wmzuls3Z3+IthMH6aLKbJTow1I8ynZiloQ+cymsdp8tfjoB1o6eSdRRpwvkxzLdLJW03xw/RDQ5T8P+LUa50CxiIPq2+gf5sKDmASVIT4XMZjhZxQF0Jxay7lH86KbhApTY/v1RG+jAIBZsg1Z/szRP8PtiuSfrxsrzpjTvX9kNmEBuzzWbxdVwZVxDQmvhGZNQKZ+J0fVb9/6hag1RUxvqAqa5SslnVKIk8kx7DwjfjCexm6/+QMDR8ppf1JG2wCzyFa/WYNL44mimiaLE7/kXjTIXUpRpg+/79ELdjQL2t2jzyQPooivwZo/3IHVqkRFSwvch99Hz6d7W2daKynBEdl4X0JJAkIYrQJrA==;5:+rh7SUlq4qw9jFw3wdBltdzx4n0iIcg0HEzycRqQxpTwl2YqJj83yJNXeFtQQXXrzYVLtceY/fVnMhXfMsjgyYpNkNO30tQO+iE1NTmBSuyOKYC3a/6pdXjpj6u6vw0gL49M7t8NQPUG75ZhCVO36MsCnNDsQp2SoRKtY83n1ck=;7:+6O5gElkjEMH5c6Lolk2lTZ7dPof5vv55HSKAeosHGFeAn0Y6Dm59rN4hgmrIT8hPyZOM5rm1I9WAQ8KXDnLKbJnu220qVKc9T6qffVJM7hnwVMnMhqWkULlZK5yXb6jKFQvJJ2Wh+2zcmJZvKFdAH5H7kS7f5hq6ozJ7LN0vc0X2iQb+gFHxUw3glOXOzUYO2Hyioo1kya84BHvV4M8V09oM5Ym3E9/i9n9ZvSvR3Z/OMnKg7OnWX7+kDXI5tBs
x-ms-office365-filtering-correlation-id: 1e547389-1bf1-4175-e47b-08d610d491d5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0135;
x-ms-traffictypediagnostic: CY4PR21MB0135:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0135B496374B60133DE65F5CFB0D0@CY4PR21MB0135.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0135;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0135;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(376002)(346002)(189003)(199004)(478600001)(76176011)(53936002)(2616005)(6512007)(476003)(446003)(11346002)(36756003)(486006)(106356001)(305945005)(6486002)(6436002)(97736004)(102836004)(6506007)(5250100002)(2906002)(14444005)(256004)(72206003)(2501003)(10290500003)(14454004)(86612001)(186003)(26005)(217873002)(99286004)(86362001)(2900100001)(22452003)(81156014)(81166006)(10090500001)(316002)(107886003)(8676002)(105586002)(6116002)(8936002)(25786009)(4326008)(7736002)(5660300001)(6666003)(110136005)(54906003)(1076002)(68736007)(66066001)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0135;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +uk8D2SJvTiRJ2wFCMXv7PG9XK3J4mcA0N/XZzt9XENNHDKR/HhuKl9amUq5FDnDsHkV2SSZjzmsMYlt2W5CvgUJxccI347Tnqfk+0cl912IVtIeyQMy18pUjfMHaFb2HVhmVTC4ArLoPm38MBdpztAKFreZf4XhR/HNseIuwa4h+N7dtyTr64YzGmgILVMkfD2queMji6w7xAw+IyurY5P/KoGHBeRR+5RviHs/oeuVUCOL42hMNtmDca8KN+WKuqy3JCOvscq70tY4TG6Cdka1GtDM4WeJeA4RVos6CE48y5O1Pnx+ILlTDFu5w/3rDTQASUSpQV6rM1nM1oU9CbrzyCNQGMboigCNUpZBIzY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e547389-1bf1-4175-e47b-08d610d491d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:41.6647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Drozdov <denisd@mellanox.com>

[ Upstream commit 75da96067ade4e7854379ec2f7834f3497652b1a ]

The change of ipoib_ah data structure with adding "valid" flag and
checks of ah->valid in ipoib_start_xmit affected multicast packet flow.

Since the multicast flow doesn't invoke path_rec_start, "ah->valid" flag
remains unset, so that ipoib_start_xmit end up with neigh_refresh_path
instead of sending the packet using neigh.

"ah->valid" has to be set in multicast send flow. As a result IPoIB
starts sending packets via neigh immediately and eliminates 60sec delay
of neigh keep alive interval.

The typical example of this issue are two sequential arpings:

arping 11.134.208.9 -> got response (mcast_send)
arping 11.134.208.9 -> no response  (ah->valid =3D 0)

Fixes: fa9391dbad4b ("RDMA/ipoib: Update paths on CLIENT_REREG/SM_CHANGE ev=
ents")
Signed-off-by: Denis Drozdov <denisd@mellanox.com>
Reviewed-by: Erez Shitrit <erezsh@mellanox.com>
Reviewed-by: Feras Daoud <ferasda@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infin=
iband/ulp/ipoib/ipoib_multicast.c
index 6709328d90f8..c7e034963738 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -822,6 +822,7 @@ void ipoib_mcast_send(struct net_device *dev, u8 *daddr=
, struct sk_buff *skb)
 			if (neigh && list_empty(&neigh->list)) {
 				kref_get(&mcast->ah->ref);
 				neigh->ah	=3D mcast->ah;
+				neigh->ah->valid =3D 1;
 				list_add_tail(&neigh->list, &mcast->neigh_list);
 			}
 		}
--=20
2.17.1
