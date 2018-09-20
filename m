Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CF6C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9560121521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="lLcwbN2l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9560121521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388458AbeITIey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:34:54 -0400
Received: from mail-eopbgr710099.outbound.protection.outlook.com ([40.107.71.99]:10496
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387609AbeITIa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EimbZVDcPzqHK0xcaA2wdJejSnqTDLUPfMSOGHw3AWk=;
 b=lLcwbN2lp53RV8xEhRN3u1hSgPrxPY0UKTufnLYibWnj9fWuaOPxdoHjlXeIkxecjjAn8K/3bqEwyVf3NxbOkxBLkIYX9Rq2a47El+aRBhEb8FSyW8QKNt9wA3LQDEdgzkt1fBpP+N3EiEz6kYGz/vfF38wI0mSQfQeDbPqbFuA=
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
Subject: [PATCH AUTOSEL 4.9 07/14] e1000: ensure to free old tx/rx rings in
 set_ringparam()
Thread-Topic: [PATCH AUTOSEL 4.9 07/14] e1000: ensure to free old tx/rx rings
 in set_ringparam()
Thread-Index: AQHUUIxzy4/LYUqBvECuXx0wbbAK7A==
Date:   Thu, 20 Sep 2018 02:48:46 +0000
Message-ID: <20180920024838.58666-7-alexander.levin@microsoft.com>
References: <20180920024838.58666-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024838.58666-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:mjgUTqyPnJV3CEjbAYy6gG4WnYbYEWUehThsjGlXspF374nykAUUayby9Rr21TE06DK1uARH00lbVqw3AOHYOQwxcmP7V9Yi6EoU3IBdTikjsrw1AO1QKbrR7GHX7Sb0bLUEiqzOfn7OQ8hS5+2EKLk5ElsXEFjJrWVtvDJlYz3mR61lwwgqSULp1zmzieUQ+yqOotc9rXVZ4kaR8neUlWEJSf6WokvOCBqvkxlyU34eXqWqU+qn7X+55zpvhCVAhkRPkL+ffblW2KxkEgOyvxZ+pwPTQ7zeXZP7j/hdNqRmQE2vRvtEbU7BH6HpaBwbUKsVyG8pa41S42OJ4uwBv51KORq94FPM8hTI6Q2D91+ATh4vtKvpJiF++wdE4PJHMS9sJxVz7G5IXTDnxw1VFzfNGH8GuuZtCSQxJYPLnN9SPLRBHhIRVdBh34KTcohfKcw+8/Jrxz9M0l8Yg2FlGA==;5:bmK0q82+C2ON7r/BB42blUvGwfYh+9N3WUTyCHb1Pv1MxeqCocaODqkTlgZ/oG+swUWNHDEJ2b/Oqi/Sc4drnuTGWqXSdd0STzKTTilnShRQ9vvmu4ZXBX0bAHZ43+ciQyb5uW7X+idewJPrJwaJtDpFZVhuNKhehuBmqH9YHqE=;7:4Qr2SfmoYhq316VnWIRzy+PMWaT8s0/+AevGI8V5eYtpp1eCDroAX2Jt5Ozv33d8m3JZobumtSEtqd1hLsQBd4wlqhenk2jOMBvfwZpysZXGLHaFXNyxYe4nmbOXxqUrNadsgcm1L0qwnxiUB2IYDlVPMjUMn/NbA6UZNeqanFrJXx/Xm8fblBQdP5VrUd8FicQEoGTkqkve+35ailuWhuiBHEr6XcO2ivIcDXRp9q1TOLb+R8ak/IpeyQBzWij7
x-ms-office365-filtering-correlation-id: 6ac6c65c-4d1e-41cb-13c5-08d61ea3ac28
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
x-microsoft-antispam-prvs: <CY4PR21MB0469AF745E032D1922563DB0FB130@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(240347492878265)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(136003)(39860400002)(346002)(199004)(189003)(6506007)(53936002)(2906002)(10290500003)(6512007)(478600001)(97736004)(8676002)(2501003)(68736007)(305945005)(99286004)(14454004)(81166006)(106356001)(7736002)(36756003)(76176011)(186003)(5250100002)(105586002)(476003)(8936002)(72206003)(486006)(2616005)(11346002)(6486002)(6436002)(446003)(6346003)(81156014)(26005)(102836004)(86362001)(54906003)(22452003)(86612001)(6666003)(3846002)(6116002)(25786009)(4326008)(5660300001)(316002)(10090500001)(107886003)(1076002)(66066001)(217873002)(2900100001)(256004)(110136005)(71190400001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Vvhd5qH7NjFIItkCRuAOkyE2diAljMOekYVe+l1B2KbFX7HctMAwaZdzm7cIK5EwyWlgmYwyqG/lUoZe98fl0C57tKhHIsSSJ9GkftwvD+nNahIFgeLBZTafGUuPFZiRsZRqA3RwyHkKkLDQZtx9an/V4Q4YW25tIXAaq/qBPukLi0dw1N8VDUaGWF3v/DCrEbQ6wJXfzRodysidMnmGlx0rgBqemPstTZA6DcdRgclnI0rLvN2HQ0AzM2YMRiE/oWySuW1+T8K9y/LMxmYf8Z07WJKeTRa+NBrhLcKZF6K1Uo+MncRoRYvqc26XPivcZRrTs1zZdmJPdd1YJvu+3JE4RL1Q5Ixut4lOnxnhV8k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac6c65c-4d1e-41cb-13c5-08d61ea3ac28
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:46.6787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bo Chen <chenbo@pdx.edu>

[ Upstream commit ee400a3f1bfe7004a3e14b81c38ccc5583c26295 ]

In 'e1000_set_ringparam()', the tx_ring and rx_ring are updated with new va=
lue
and the old tx/rx rings are freed only when the device is up. There are res=
ource
leaks on old tx/rx rings when the device is not up. This bug is reported by=
 COD,
a tool for testing kernel module binaries I am building.

This patch fixes the bug by always calling 'kfree()' on old tx/rx rings in
'e1000_set_ringparam()'.

Signed-off-by: Bo Chen <chenbo@pdx.edu>
Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net=
/ethernet/intel/e1000/e1000_ethtool.c
index bdb85282137b..e84574b1eae7 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -645,14 +645,14 @@ static int e1000_set_ringparam(struct net_device *net=
dev,
 		adapter->tx_ring =3D tx_old;
 		e1000_free_all_rx_resources(adapter);
 		e1000_free_all_tx_resources(adapter);
-		kfree(tx_old);
-		kfree(rx_old);
 		adapter->rx_ring =3D rxdr;
 		adapter->tx_ring =3D txdr;
 		err =3D e1000_up(adapter);
 		if (err)
 			goto err_setup;
 	}
+	kfree(tx_old);
+	kfree(rx_old);
=20
 	clear_bit(__E1000_RESETTING, &adapter->flags);
 	return 0;
--=20
2.17.1
