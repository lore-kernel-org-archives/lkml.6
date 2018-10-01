Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E5EC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111E620666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nP4f/ucm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111E620666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbeJAHOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:14:18 -0400
Received: from mail-eopbgr680138.outbound.protection.outlook.com ([40.107.68.138]:20182
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729159AbeJAHOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXCNCazkIxKBRSs6RA+fCF8VJ5oa3gmPc9DkIjfBZQU=;
 b=nP4f/ucmkeU12dOeHXnCb7ZqtIS78TVtKig/hLHYsjh0N5je06vPNT8Ft+4j49RNHmmwwv44xZObZ7UDU/QWoXgjnUjMWs/iR8iXrrG9MsZRVSQZtXqmWGBc3dG8JHsiQmhKkRZZVPHIjmtSNouPJUbLKWJboTIiYZhQ3yfLDSQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:38:59 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:59 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Netanel Belgazal <netanel@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 43/65] net: ena: fix potential double
 ena_destroy_device()
Thread-Topic: [PATCH AUTOSEL 4.18 43/65] net: ena: fix potential double
 ena_destroy_device()
Thread-Index: AQHUWR8Sgnzxz8c/y0eYSRwVlA9LaA==
Date:   Mon, 1 Oct 2018 00:38:29 +0000
Message-ID: <20181001003754.146961-43-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:Ui1KnmSnJPXbCmuWhpd3otT7p1cHxGsyvXofUjsZ2URR8kURCrXwnf7Z3V1FwHBk7h5f7cbngreBVtaG8IwIYFkofXVe/CwfEQgr0WyYRYosmi/HqRDETCFmRxdtJ6xB8tl1Z3XksKepgUhBeOp0M6QqnVNwazdGQUWqeTHrynLYlmPg+PH78jnA9eAJd63eH3gwfIfY1FwXr4K/GrzBUrUsCoU9bDJsxW19BtEsJIGwXgc8c0t+489FfigHBVDU8lE00JVSLegFBY8AONUPhDb1H3pNmpe0Usfs2D9z+G5hzfpFEGmKiLdgobFdJyk9zBeO0rtPxgO52UO8AeqzPGrV73PDTcKjAcNmUeeYDoqqJXQG8e00/fQZMKDAA2buyh9gpxGYPXLYZKGrVt2noX8LkVrgGkjyj4XwUgRQz5BfNy9aH29gjWA+lepPO0cyAIT4g+Hjye3bGkYDJjF0qQ==;5:MV+ZOJdi0/gRH3E6Cv0b46prJ/KgtN2kWeJQeoums9mL8YVwHytc71lsPwV/devHu4zPOFRjFkAE6d8eYW5AW2pZEAl2tno4yTObQjo64Be8BqH1rTe/ZlkwU461gu/MXUS4+XUyr/0EEh5lf5BwfuhG9MwoczESMifIzO22EZ0=;7:yHzgjTIz593C1UWfBvLTPFIst9qpK0CnzSIgUPhHWFafMIeBiOIhG2md9WzlUo2zZ6G/xAxqA3wJbDbj0OsTB7M+zP86GOvQWZgsSjRExkzaIgJ65TTWZm/5UGrOpkqad1ZMcYcrDrcgD3Bfw2gjEorNXAui6shWI7c0n6CnMNWxH6dw1iEk5lTnas5CX7r7FK9ulKlTJ2m77UZtCSgYhlWRindTFRyeYRQyh/ywA2dRjKTvRU2v74lSHADneYWU
x-ms-office365-filtering-correlation-id: faba1bf3-cbb0-4999-7352-08d62736472a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08247725C85486959E0D58B6FBEF0@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(47284530071512)(33061846794335)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(396003)(376002)(136003)(189003)(199004)(256004)(99286004)(86612001)(22452003)(2906002)(25786009)(2900100001)(8936002)(14454004)(5250100002)(36756003)(10290500003)(76176011)(2501003)(478600001)(316002)(68736007)(8676002)(72206003)(305945005)(81156014)(6506007)(110136005)(54906003)(7736002)(10090500001)(81166006)(107886003)(66066001)(486006)(86362001)(6486002)(105586002)(11346002)(476003)(446003)(2616005)(53936002)(4326008)(1076002)(6512007)(217873002)(6116002)(3846002)(6436002)(97736004)(34290500001)(102836004)(6666003)(5660300001)(14444005)(26005)(71200400001)(71190400001)(186003)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xZM4tsWfd16r81XqXHS7E2HYv3izO4YPfEMHtNfKvC7Tl1owTH6XU6PW0HZkB+M7+hR3lHVMlWb2pPbVBPY8mEmUjIiMsTf3eJyLSuyvEj7YsLuqD14c4qta3U34bA7uEoLm/x4Fjddg1cL5B6YIu9xVvMtpqbPFn3RNhn20hmmbDXcm2rGtjYgnJek0avzRNQ2PntowjrO0Jh/Ezq9bOInH6QR4qPdh1y0PllH0xwoHBYO95ZWqvvA/bKv1GGNVqOPJLxfD+zgQ4rB3CkHk89iAtc/xNtya76Ajw4cSEZsV/bneqqZ64mF2NW9OQBLKK8Jt28DHxjnfNr+WiFDek+Dt+iPbbUATpjObTi4HqMM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faba1bf3-cbb0-4999-7352-08d62736472a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:29.3555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Netanel Belgazal <netanel@amazon.com>

[ Upstream commit fe870c77efdf8682252545cbd3d29800d8379efc ]

ena_destroy_device() can potentially be called twice.
To avoid this, check that the device is running and
only then proceed destroying it.

Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/eth=
ernet/amazon/ena/ena_netdev.c
index 9cb2be501263..50d10820ef89 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -2555,6 +2555,9 @@ static void ena_destroy_device(struct ena_adapter *ad=
apter, bool graceful)
 	struct ena_com_dev *ena_dev =3D adapter->ena_dev;
 	bool dev_up;
=20
+	if (!test_bit(ENA_FLAG_DEVICE_RUNNING, &adapter->flags))
+		return;
+
 	netif_carrier_off(netdev);
=20
 	del_timer_sync(&adapter->timer_service);
@@ -2591,6 +2594,7 @@ static void ena_destroy_device(struct ena_adapter *ad=
apter, bool graceful)
 	adapter->reset_reason =3D ENA_REGS_RESET_NORMAL;
=20
 	clear_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags);
+	clear_bit(ENA_FLAG_DEVICE_RUNNING, &adapter->flags);
 }
=20
 static int ena_restore_device(struct ena_adapter *adapter)
@@ -2635,6 +2639,7 @@ static int ena_restore_device(struct ena_adapter *ada=
pter)
 		}
 	}
=20
+	set_bit(ENA_FLAG_DEVICE_RUNNING, &adapter->flags);
 	mod_timer(&adapter->timer_service, round_jiffies(jiffies + HZ));
 	dev_err(&pdev->dev, "Device reset completed successfully\n");
=20
--=20
2.17.1
