Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCBDECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6AB21521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GZx2Y7cX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6AB21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388702AbeITIcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:32:07 -0400
Received: from mail-sn1nam01on0108.outbound.protection.outlook.com ([104.47.32.108]:32896
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387736AbeITIbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgPylNMjhy1luvE1pl5w0YEgyGso4Zi+LBXh0rMZBPo=;
 b=GZx2Y7cXDfUWPtoGlyaQUHFq6mjAvov6wO27wy86Pdp/RpTvumR6/xe6epEWlL2ULpqTNWe/TsW8TACwp83vfyVHhlEPhAnv0ieuSwkjXYglMwkCbbICVfOvDYJTJn2AWUV4y+bs5F4MAMg4/LEg1KDUE1TEgHtgL+aR7YNqNKY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:50:04 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:50:04 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bo Chen <chenbo@pdx.edu>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 3/7] e1000: check on netif_running() before
 calling e1000_up()
Thread-Topic: [PATCH AUTOSEL 4.4 3/7] e1000: check on netif_running() before
 calling e1000_up()
Thread-Index: AQHUUIySkARkF59HtUCIgS7PwA5i8g==
Date:   Thu, 20 Sep 2018 02:49:37 +0000
Message-ID: <20180920024932.58727-3-alexander.levin@microsoft.com>
References: <20180920024932.58727-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024932.58727-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:mDkSNKT0Pyt2XQrxA479bllhU3shd35TOMZxlrayL1KDgv0+A93byOG6nOf4qchzymErHvELG66hu3wnhPdJeuARZz2vDZKFHGW6Ne63ydPRkwpx7lhRaCoV8fuvlColl8Fs1XvZqK1az0AvnEdVQY5I/nvE3MaXaxlmZmdExSGNghKTOEzEmBxjIsNj8HEYPbZecGVe6zanZQU0+gzappF7LCx6IVo5xEmj2PSZZZ8RVIOKacEzBdyTWq0Yc98BgcXCeJOVCS5TK+e2O/WsQuxndhdHQWAkG8F/u97f9psHvur4K8TdKYA4O1gXvcwTaxJh3MxkGXfvdtAd6qyy9KA8IVHF3fBsLym38ts5Ie2J7JgOoRqrDNmtbLIvc8Lw6d4SVM76/SokmsWG+YTSWm7gEhH/mp40hbGkhr4CWzdCLXMOpwMaw0p2M858z13M4vAjzEiPCioMNq7z8Xxulw==;5:EfdDViTSKepTTELOi7gWvj/m8svKqucBnUdA/iegz8+7Be5O3R+9wS1S91A127UpGSoVyMmHUMUOESB5RoLHOFwodcYNwFU01ZQqVmNzKQVs1wqXYqQQjMVki5A5aDw0rFsF8pFIn4rg0fNdY6g3mCGCbN74xTSERoIsoVhLaAU=;7:OarvHOm4oSCeLSFA9gLuhUo+HhKytdb8LVruaTImt+KIvWIthwPUsFzSJvyjyGu6Ud2Xx65jNoSNbOc4uLLXZ3mzQaeDMOoYZm5BiXV3pmRg4CyYe5JMWNjg98ioBLBaeUGa9Xnx7KFnzT5haMYopymEdSB4iAb5MKkznz83A4kFn340pSMjAQTVxVKyjuFvD+fXsd8OMTIbLb+KhMtO/+N7iMln/VlSGiIeJY4Exi09SY/EzpQMTAABw3MsqGZV
x-ms-office365-filtering-correlation-id: 39d9d77d-76f0-4e40-054b-08d61ea3c4c3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB0855CA11AE0EC1BD6179C06EFB130@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(240347492878265)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(136003)(396003)(376002)(189003)(199004)(2501003)(186003)(86612001)(10290500003)(478600001)(2906002)(86362001)(6666003)(106356001)(3846002)(5660300001)(2900100001)(6116002)(8936002)(105586002)(1076002)(53936002)(14454004)(7736002)(305945005)(81156014)(81166006)(8676002)(6512007)(68736007)(72206003)(6346003)(107886003)(102836004)(26005)(14444005)(256004)(6506007)(36756003)(446003)(476003)(2616005)(71200400001)(71190400001)(486006)(217873002)(66066001)(11346002)(97736004)(25786009)(22452003)(5250100002)(10090500001)(6436002)(316002)(6486002)(110136005)(54906003)(99286004)(4326008)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 22iHEq5p1MSdKAW5NulCborVGMkfHBupoI/OmcBCcQlPG1XhEmapOH6NysaNL8nyNh5wSejSJ8B70LblyEHFpiemcaoBkzAc76imZ1euTcNNvpabhSrdDOApe0OGiMI+zJg+aO0kbYWJOJVakNI21bf0Cx+OnSSKEnMEu7psF46+ue4m4BhaJmijG8+xB/tzHzSvQ6BKZujgTyhCYN4hGseHdSb/8y8EvEbUyoSDEgPdJrGlZBRyJJFfTImZ8luwil9Xdl/zb0Z8Gh+j8Ed5JkCXdFEc0YcozChcR84zXxcsr6c92SCjzD5yhts/dRLyNvkHsKzAVDYOVDdgq5mb1on0af1NFI+arqTZZqUa+mc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d9d77d-76f0-4e40-054b-08d61ea3c4c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:49:37.7718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bo Chen <chenbo@pdx.edu>

[ Upstream commit cf1acec008f8d7761aa3fd7c4bca7e17b2d2512d ]

When the device is not up, the call to 'e1000_up()' from the error handling=
 path
of 'e1000_set_ringparam()' causes a kernel oops with a null-pointer
dereference. The null-pointer dereference is triggered in function
'e1000_alloc_rx_buffers()' at line 'buffer_info =3D &rx_ring->buffer_info[i=
]'.

This bug was reported by COD, a tool for testing kernel module binaries I a=
m
building. This bug was also detected by KFI from Dr. Kai Cong.

This patch fixes the bug by checking on 'netif_running()' before calling
'e1000_up()' in 'e1000_set_ringparam()'.

Signed-off-by: Bo Chen <chenbo@pdx.edu>
Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net=
/ethernet/intel/e1000/e1000_ethtool.c
index 83e557c7f279..52129b214c09 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -665,7 +665,8 @@ static int e1000_set_ringparam(struct net_device *netde=
v,
 err_alloc_rx:
 	kfree(txdr);
 err_alloc_tx:
-	e1000_up(adapter);
+	if (netif_running(adapter->netdev))
+		e1000_up(adapter);
 err_setup:
 	clear_bit(__E1000_RESETTING, &adapter->flags);
 	return err;
--=20
2.17.1
