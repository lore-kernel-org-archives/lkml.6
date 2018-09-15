Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33812ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4511208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="lLzGebkf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4511208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbeIOGr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:47:28 -0400
Received: from mail-by2nam01on0094.outbound.protection.outlook.com ([104.47.34.94]:11650
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728273AbeIOGr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FHQvdkeIWT4KZVduSJ1O4cDmVZST6VfPgX3wHlcGeQ=;
 b=lLzGebkfUV3DBflK3usHEIecpWki0X48whWm1Cr+27SogxBpV1r3dUSYk+Bfd90Ua9wB0BtAhRePC3BlmRWwHYVo92brx2U/MEX7EMI0X0dfipQnPeghbtHaWUeXPy8vWKPgjJk7d9zZjTJ2J114f0lTf7J5KUqrnnAOR//+/Mc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:30:10 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:10 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Huazhong Tan <tanhuazhong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 29/92] net: hns3: Fix return value error in
 hns3_reset_notify_down_enet
Thread-Topic: [PATCH AUTOSEL 4.18 29/92] net: hns3: Fix return value error in
 hns3_reset_notify_down_enet
Thread-Index: AQHUTJOkn+6kidBRJEG602vYKhnKKA==
Date:   Sat, 15 Sep 2018 01:30:10 +0000
Message-ID: <20180915012944.179481-29-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:JIQHu0YFXVyRZS+GVTT9ksqsGO8BChP/mcAQF+OiaSIdjEKFEYmZibNlFhE3z4H4uEKjItr0n5WfK3bRxJ8b8HFAKgH2rexUg9FKeouIGxMQVchL+SvHohi12j5vAZovkcFnOKSNVfXKNhGVz3s1SW+r65g9mdvR21DEWiRnDTNz2/hmSRIz/KK6u7w0hpj+s8YPAx0K8slkLo1CqhcvW0g9A8ZcWQ+Odgq3TPFsuFbjZoTA24aPD/HTBaxfJ7/5iJ09Z03iA2jkk31peYFB1wK67734cnFa1Zjjok623RYtZd2njf8g5jIsjSGwF7jTOm6XNQq6p9gMa8KyI0zhjCt+nZNX/Bx/g1dTdAH9GapzOO886a0s/sgpuec5QyiJKgQZzDQAky4Lz3gXDzC19seOi7mMcM9EZ3hlsfKbyksY9vaDON/ujSBc5q2SOShOMY2Rj9xwAgbVkbI99U6k3w==;5:wt9BXExQxMVAHCZZ9wr08VF7TYN4qgREI3kFO72FcGUw0hY/MIrw4V03I4HrKHoa53AcsouFphJXf1MJYTMkqrpR/OZDEfhHkeR+Z2eaWO8CuIWy9vIkU+THbKg2+Dtadn+LuXmV1iJhInJ7nklTqiCRcksp3x4Tw4xtIv8jCPc=;7:PqkDrjIF8JzXb63SD5UwRdw9Q8KvRv4bWUJePUggHhNstpaJsBrADEfw62EIySbuDkGHbEBvvi/GGhGTo7rexSq85urETFs2XSZTqLXcZ89zAfDUwM/bb4st8SgaoxZur7Qii8AMyxITDeHYRp+iIvgxUvsRuhTpsEA9Xh8NlgspVRmM/CFnTwCT+Ua1QjyZ7wJUp6rZ2iPf3i+81k02QHa142K1oizL70D20slfWc1M+szFkNL9e4dgt4rbwDqM
x-ms-office365-filtering-correlation-id: 3203fe95-c2b1-417b-31b7-08d61aaac72b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
x-microsoft-antispam-prvs: <CY4PR21MB0741843DAAA48C8A31FD09E9FB180@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(376002)(396003)(346002)(189003)(199004)(186003)(106356001)(25786009)(6346003)(6486002)(6436002)(476003)(102836004)(11346002)(5660300001)(2616005)(26005)(217873002)(105586002)(486006)(446003)(4326008)(53936002)(5250100002)(14454004)(10090500001)(14444005)(2900100001)(256004)(2501003)(10290500003)(6512007)(22452003)(72206003)(8676002)(478600001)(110136005)(97736004)(68736007)(66066001)(81156014)(81166006)(2906002)(99286004)(86362001)(86612001)(575784001)(6506007)(76176011)(8936002)(6116002)(3846002)(1076002)(54906003)(305945005)(36756003)(15760500003)(7736002)(316002)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: WthEqoQ97bUjP5pIKv4Ag67OvdwiIvv6VI5+/gCoCnE2Xv6bH9+6j7nHBpJZfN4IJ2Y7/hOW/C4XuNYHgRY4Yj+iZLRPl38NnyEIxAdZOlsAa9moOkSVjIqsNSmoWvI+mXY5p6orfuWMZ4fpCj3FKB4pxuZ+NRdIBVzOrRha9a6PAbmwFopbKIsiqjYIu1NznauLUShNnPzE//wLgz5KvHRRAniH1kYBAAInJC4226lTNrJPQuhrIgaddniOi7HA5vuvavCau25KLAE2E6VeQeRkjUzBycd36BRhmv63Q8+z3ccnvwBmmWQa7svxRbtNE18GclJz1jpRm8lMd797zkWnSeo+pJs6dMFTEy1Ij8k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3203fe95-c2b1-417b-31b7-08d61aaac72b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:10.6825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

[ Upstream commit 6b1385cc251ae9f26b720fa5c8c00bf19af336ae ]

When doing reset, netdev has not been brought up is not an error,
it means that we do not need do the stop operation, so just return
zero.

Fixes: 76ad4f0ee747 ("net: hns3: Add support of HNS3 Ethernet Driver for hi=
p08 SoC")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/=
ethernet/hisilicon/hns3/hns3_enet.c
index bcec3a779407..9d69621f5ab4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3422,7 +3422,7 @@ static int hns3_reset_notify_down_enet(struct hnae3_h=
andle *handle)
 	struct net_device *ndev =3D kinfo->netdev;
=20
 	if (!netif_running(ndev))
-		return -EIO;
+		return 0;
=20
 	return hns3_nic_net_stop(ndev);
 }
--=20
2.17.1
