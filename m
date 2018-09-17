Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0F5ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1DEB208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MTJSjBzX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DEB208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbeIQI0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:26:39 -0400
Received: from mail-eopbgr690129.outbound.protection.outlook.com ([40.107.69.129]:35844
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727668AbeIQI0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuZxA73rpOQhzNs0T2ba9DABKWF+XWmrzjCKEcpoXGI=;
 b=MTJSjBzXPTdczBbPcNoDf3rkHf0Kn2cKxV2b5F90UWYXNSnlLNRzj7CnTqV30SG6Crw1uwWYtiJkcm8EGiL7Le55G2cKu7Ciaujb0Bm69tLzMV9mQvuvf7nm3E5A1WrkpybiKN7x4WdV+Gs/CixCSKO0WCImPywL/XnqNSJhN8k=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:01:09 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:09 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bart Van Assche <bart.vanassche@wdc.com>,
        Venkata Sandeep Dhanalakota <venkata.s.dhanalakota@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 042/136] include/rdma/opa_addr.h: Fix an
 endianness issue
Thread-Topic: [PATCH AUTOSEL 4.18 042/136] include/rdma/opa_addr.h: Fix an
 endianness issue
Thread-Index: AQHUTjKcycr5NCP5m0iRLrjxcfD9Mg==
Date:   Mon, 17 Sep 2018 03:00:38 +0000
Message-ID: <20180917030006.245495-42-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:bQ2HJg+p/iICI+SriesRaUqgAHeUCtdhhOu7Zkm6B+Bn3HVoCoBRJ/A2Lt3bwSDtUsxCi/KzCsDI/7xrKxo8PZQx923e1B1LyVs8SpDGs0TV/BcMktjMuM/IgsWEUgCZI/EVQ0Kogp/Wpx0dFJlFA5jfj5t00iuDciE9eK0aKpm+lDIJeWyUhkq/dy+tXysIZmTU8CBIEgRfb26k5Og7f9Nk+e3+v3bghRFzBGnLzVJVJhAT4eXc8Duqy7nTBJMibq6TXYW6z3o9ldMj/HkKmFLS4fyZ+mIlIpDKcv0NVAKthBg+DEHdrmYWW/nhrQtp/YJbTD9+ZZ8tomqxoP3RSoBbjmD+q9USJ2hOXZOywRso5Q7Vy/qKvDV6279YEpsLi99Cs+SlBJtSq8Od0YEFZncyrsK3AjRXh49Z9VN7BxNrhP5eYUYbwJLtC4nO9PsYXZqjFtII6k//OcatF+1Wfg==;5:TrQkiAn98oyS2/m3Y91YHbIY6GLUVKKFYB0Y8EC+MCalRKA7kCTlvi714daKc8Rz6bxXo1S+JI2n+yxj6rc1F0YCQZ7acqY2cF7H/SqoIfrBuGvC54xFNscHXSG3yYsRRaUHS47FbrRbEkrJbv8ZPIdzgqwELnvmTYhC4wtA3Iw=;7:8YjnGTq8vIZ+edPqCwfu2x2WgrZDaqbDq5epbw/+idsvNgNeAp3Vl3klwDEHArycisLiWHIaxLtqwp2NlaVG2qcZXPID2m1Icj4CHb5CYxI/m4ZbyvUo9dscmmyO7LUwsOAqfwT+XH9lvGJ578J6lWh0QjlYh/VaS12EjuaMX3WKJ0EqpmWE4EXyiBxHlelwFPqsW9XvVJxARJBYDg3OfY8MkRp7SFvDTOH+jCz4zY8kwWkbhAbPazBrRm1FZfrE
x-ms-office365-filtering-correlation-id: 020ba93a-6536-4c95-862c-08d61c49d15d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB01678FD9EB7353E229A54F3CFB1E0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(346002)(136003)(39860400002)(199004)(189003)(6116002)(1076002)(86612001)(4326008)(97736004)(53936002)(2900100001)(7736002)(107886003)(106356001)(10290500003)(81166006)(105586002)(68736007)(3846002)(99286004)(305945005)(36756003)(8936002)(2906002)(217873002)(54906003)(86362001)(110136005)(25786009)(316002)(5660300001)(102836004)(66066001)(76176011)(478600001)(446003)(11346002)(2616005)(8676002)(486006)(476003)(6346003)(186003)(26005)(6666003)(6506007)(6512007)(5250100002)(6436002)(10090500001)(6486002)(72206003)(14454004)(256004)(2501003)(22452003)(81156014)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: eo79tahOV15jF9KE4fa0StqBhyA31y3KgYBzhUNfbfotufqeliko+ul6cJqor+HNJzme9opj5E61BuJPgao+w9eD9V6WJfLozIlomOTf3WFX5aM6CdS4zyemHDgNzA2XfJzX2AeCnPdfD9dGBYjFXuUyonyAin8Her/cf34KLO3v4b45kRkIEETs7Z7rUg35Qw7Hf0+DlbyRqaNkFNQ5Fv7ruE0In057LvOEIJhvPhYRWJVodqZKg4pmp2R95b/voTcQEdovvodXc6M6BM37eEK/sVpXOX9/N22Ux3utKruquLmfBW/PrdXM4ljOTj98dr/Rl7n27YnI/9zYo7y44WRRnvumUafRdz2mLHp0RaY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020ba93a-6536-4c95-862c-08d61c49d15d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:38.5733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bart.vanassche@wdc.com>

[ Upstream commit 4eefd62c17a9a5e7576207e84f3d2b4f73aba750 ]

IB_MULTICAST_LID_BASE is defined as follows:

  #define IB_MULTICAST_LID_BASE   cpu_to_be16(0xC000)

Hence use be16_to_cpu() to convert it to CPU endianness. Compile-tested
only.

Fixes: af808ece5ce9 ("IB/SA: Check dlid before SA agent queries for ClassPo=
rtInfo")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Venkata Sandeep Dhanalakota <venkata.s.dhanalakota@intel.com>
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/rdma/opa_addr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/rdma/opa_addr.h b/include/rdma/opa_addr.h
index 2bbb7a67e643..66d4393d339c 100644
--- a/include/rdma/opa_addr.h
+++ b/include/rdma/opa_addr.h
@@ -120,7 +120,7 @@ static inline bool rdma_is_valid_unicast_lid(struct rdm=
a_ah_attr *attr)
 	if (attr->type =3D=3D RDMA_AH_ATTR_TYPE_IB) {
 		if (!rdma_ah_get_dlid(attr) ||
 		    rdma_ah_get_dlid(attr) >=3D
-		    be32_to_cpu(IB_MULTICAST_LID_BASE))
+		    be16_to_cpu(IB_MULTICAST_LID_BASE))
 			return false;
 	} else if (attr->type =3D=3D RDMA_AH_ATTR_TYPE_OPA) {
 		if (!rdma_ah_get_dlid(attr) ||
--=20
2.17.1
