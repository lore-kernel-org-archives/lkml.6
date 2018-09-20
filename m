Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FF3ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87BF21521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="c6yCAjSW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87BF21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388345AbeITIaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:30:30 -0400
Received: from mail-eopbgr710099.outbound.protection.outlook.com ([40.107.71.99]:10496
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388295AbeITIa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6pZK6l6tEZWd78W1oI19t2eaCvCCmpme80FpzdpqjI=;
 b=c6yCAjSW3kHW9p72YX/dLeS+Ey/EkxI3mkr4nviyfhJEV99V7mh9Lg316DmDDxQt+++hepbX3b9+RMQa3SvPS4E8+K83sI2waSkDrRwhrncGuTtUOQujMxnJ4a9zbaM8wHSxx06S9obRVhroWreIi+4sPoqj883+WwyMQrqqWnQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.9; Thu, 20 Sep 2018 02:49:23 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:23 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bo Chen <chenbo@pdx.edu>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 06/14] e1000: check on netif_running() before
 calling e1000_up()
Thread-Topic: [PATCH AUTOSEL 4.9 06/14] e1000: check on netif_running() before
 calling e1000_up()
Thread-Index: AQHUUIxzCgcvqRtk0UGzRIrA96FIrw==
Date:   Thu, 20 Sep 2018 02:48:46 +0000
Message-ID: <20180920024838.58666-6-alexander.levin@microsoft.com>
References: <20180920024838.58666-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024838.58666-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:M9uUZb0vMJ7sDShQRcl/a9xzX3A1ZbBzUD2TUEUMGFtHYaE4Fn6PRO7ryuPp1uFrRG1ZcKTSdELYeIOBxUIzaVzK1rGzemPOZQ5bucKj00LCh7KoHXeaxvyKQDaYjSYZpBaKW+9utUpQow1eNxf922OaNfREWQfBJnLwnE9dUtKN79EFT6dGuagNBRicJmQxqQfHFEOpYpUf78k6uxPej+hN7d5klXsEAVSVRqdFKGIxQTFyv/dZ/5sqWbTpm+cQ9FhpB9PxAc5zkudlpNweRQgBrAVGI+psfLQ3iHhSeQ4a6JLUOFqWetlp8WtySmB00xMw3Gw1O4OX9K1oXoFYEYwbzS+7xZgdx3y6w/gDVYqkIT3uaBp1OC+BNNbnY1g+aojlAUdE8hIto8Y4ATSPuROipza/1xKOV9xDeZtblC8CORbIlk7vGJJ86f9M2rujTNLIEAUnSVCEjcqWahVRDw==;5:PVM8jyPosgzCZEyhvt+yzXaZX/XbAuch7bZfqxOt2V4LNZm7vyiqzX8DDN18fQcWziAC/0BO+z3qUM2WSg/VPe6BofaRQE5sN539bKByZFksKDsjbdApXVLfhjqDX6dIG1pmIFFF1CLExxnI8gHnx7+xGu6q5Pq9Y+F1Ko/32jQ=;7:6VABSZLCEGDmX6ff4fgZLAU2OSk25PVg5Rt5MYti+BWLrwvtjvlhld9bDFlkgaW3UdbASgFuSMI7/qaQ3JI5R1TKk8HsgvLKWFvA+DeWhPZsMnLyfPFPIYFNWxLEkvQ/LILG56OV/XgXKmD83W4DR/Q1Yh0czPk3V9Tha0/cr7qnV+cBxnB8wageBri/ODeGOoZkdhzrxpBD1J8nvY7qerfjiAr2IS9I4OmGcg7VUYZVscJzYq04wNKWx5mifB+u
x-ms-office365-filtering-correlation-id: 703ecb55-b777-4db7-b479-08d61ea3abe7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
x-microsoft-antispam-prvs: <CY4PR21MB0469752CB6BA1C97A9F3DE6EFB130@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(240347492878265)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(136003)(39860400002)(346002)(199004)(189003)(6506007)(53936002)(2906002)(10290500003)(6512007)(478600001)(97736004)(8676002)(2501003)(68736007)(305945005)(99286004)(14454004)(81166006)(106356001)(7736002)(36756003)(76176011)(186003)(5250100002)(105586002)(476003)(8936002)(72206003)(486006)(2616005)(11346002)(6486002)(6436002)(446003)(6346003)(81156014)(26005)(102836004)(86362001)(54906003)(22452003)(86612001)(6666003)(3846002)(6116002)(25786009)(4326008)(5660300001)(316002)(10090500001)(107886003)(14444005)(1076002)(66066001)(217873002)(2900100001)(256004)(110136005)(71190400001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Ad+CUeEVpNTSVkPspvf9dMC+RTrDG8q6hnSIwTXdjj59mNpC49FT1xYGjgj05450wo5Z4nAeNKyi/IDKucl+4/y/J8K71YT4If5A7BRVMtjvHOMD5oo92nkBELaPoUIFv0FnmpeDAL1HagWCTrL8zqhVBLzfM+ged1BDqL+aE6+ubTaHjnx6pU33bmU/j2b8qiSLiU/XNh/iXFqLZRWS4bAN2Y8yktYfpMeouNBS/VfFLgZ9Yo+Rq59MVs6StuHDiBgsjtokCYlAvyni9yBskQR87b0UMRAbfcJscbmVhZyQ/mnPjVZPkB4FbOEN56SWLNzm85bXAIz7jJKRkTH9hK0icTZ+kTtl2FYlC61AP4s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 703ecb55-b777-4db7-b479-08d61ea3abe7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:46.1006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
index 975eeb885ca2..bdb85282137b 100644
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
