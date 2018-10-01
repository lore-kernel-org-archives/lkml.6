Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEA2C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8808920666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CZ7GiMgs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8808920666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbeJAHO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:14:28 -0400
Received: from mail-eopbgr680138.outbound.protection.outlook.com ([40.107.68.138]:20182
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729024AbeJAHO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieqtXvIVINHCKmp0rzi9HAPowdoXnmdP6oKQi5GuDbo=;
 b=CZ7GiMgssIg/y9G9rZ5oiObFo4Y3uXVgyvr9ePusVXHRrAW2+U2hSfaB+ft5G0H8B843tHHdEDXUs7MlDTP0UEwVLagBAD4iThzsBBh5Hn1pV2J43lMCxb6lx82ad+/BI7NMOmy1TFjrL2qYZR5dwQGqhdtgXK9ZTG67UYdr0F8=
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
Subject: [PATCH AUTOSEL 4.18 42/65] net: ena: fix device destruction to
 gracefully free resources
Thread-Topic: [PATCH AUTOSEL 4.18 42/65] net: ena: fix device destruction to
 gracefully free resources
Thread-Index: AQHUWR8SeSm95UJpfE6BTblbZkAgBw==
Date:   Mon, 1 Oct 2018 00:38:28 +0000
Message-ID: <20181001003754.146961-42-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:mY23z3WDb9kU/Ut4m+djdubt8G7pD9Rao1Puo/7MYtIJ+CZdJ5IfFCaKvDw2hz0rVuxXmSdq/hEckjMDHJ3AYmNv0oL+k8nJfbsHqPwkQbSEVgx7vpfBc1ArWNeCqribXQZGZ4zOlhJH7Hu7CyYFtpzwFL4HPannK0qNMn1zu95s1YVs91HZW7toqEG2+D64i27TTOvexBAuYiyOGJSteR4KUAjJNZCgOLIWcGgazZ+Y59zKusahaLkJBqMbmsQr1qbuScSgE0TjTyKZbCOzqBQrodkw7fClNP7cDohhZnpie2HhE7Y9Pm0UiyajBudLZBHq1UhH5N3BEO+LeZbSCd4MbfMjOJJ0Y8eQ+oinwududsbqH1/sPhx8WaLi6ZWhTK+NBm7I+hHgoeV+J2XA7ebVmOEBGAnvSs62ut1M7Fsl/S71jzoh8WokG9uXnmUistPMkirc4UmPoCSsTqVc1g==;5:n5G2lIDK5RDe3U997IfHpjNz2AAVSb7mmVoihExcxdViKvxyJAtE/03AeSh/6piCtaeB89x4JlaJpWyuQmmd3erWYc59gdnvoyWEl1IqzCLO8bxJ/oHrdCcVcdB3vT+aAJQ/ICgXbD3jCRdbM4zLSuYD1lvkgVxRs1y4DjzDlSY=;7:VvNg7g8Y0Map9/SD3LfcmvOTUZrAKHJlq7oMKVomJvALvO/pTSq0QzMA8zEB+KV3ZqmTjcFXf4xalfvy1mqNCVk1z5jXdaqK7zG/Nq1qSOwXGLLKufvV1B+aN0u75jo1H2BHdPc0+2y0mo1gTz/jkl9YEncNw6jiullsEdIT9aqf+ky7B/2XDz7btuxPac27P3M4o5fRR9HwngzyMS4MLzljz4ED6l4CagD7hmJgS//9XD53JNgkiy85e/d/Lqeq
x-ms-office365-filtering-correlation-id: 384fb90c-8983-4b26-c751-08d6273646f3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0824F4C3D912A0F098108808FBEF0@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(47284530071512)(33061846794335)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(396003)(376002)(136003)(189003)(199004)(256004)(99286004)(86612001)(22452003)(2906002)(25786009)(2900100001)(8936002)(14454004)(5250100002)(36756003)(10290500003)(76176011)(2501003)(478600001)(316002)(68736007)(8676002)(72206003)(305945005)(81156014)(6506007)(110136005)(54906003)(7736002)(10090500001)(81166006)(107886003)(66066001)(486006)(86362001)(6486002)(105586002)(11346002)(476003)(446003)(2616005)(53936002)(4326008)(1076002)(6512007)(217873002)(6116002)(3846002)(6436002)(97736004)(34290500001)(102836004)(6666003)(5660300001)(14444005)(26005)(71200400001)(71190400001)(186003)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eUVwiqcBwSDyWKgbiiO9v44iTo09KQdv9k9ztaRhW4jm2HDZGZ8LD2KF3W03dgYeF7pVOl122pyI3e+THTY4i4JBIAd32IqSve9hyTj5Fij1uX+BUC8QHUawcnX+wSLVzecfUeZzAW3AzIw+AYUmBGtxA7FlGSLAv+O6h1HLS8lKcOuIQAbV0wxJsD1vGoXgRMP3YPn9JgHc2OXiVPT4t5VEBTPxjdOZZ9/5L0MucIhUKgifpcb1PF0LqYT8/daGmjUrTYwVTngH/dMtn/8R3mzeEkqJFiPsgNB2t4+8ixqMqcGJLoJ4PbZX4xo0OYIlWXHY8HX55vBnmJ/dzdx3EfSI8dtJMdYzEuvsFRehEPY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 384fb90c-8983-4b26-c751-08d6273646f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:28.7710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Netanel Belgazal <netanel@amazon.com>

[ Upstream commit cfa324a514233b28a6934de619183eee941f02d7 ]

When ena_destroy_device() is called from ena_suspend(), the device is
still reachable from the driver. Therefore, the driver can send a command
to the device to free all resources.
However, in all other cases of calling ena_destroy_device(), the device is
potentially in an error state and unreachable from the driver. In these
cases the driver must not send commands to the device.

The current implementation does not request resource freeing from the
device even when possible. We add the graceful parameter to
ena_destroy_device() to enable resource freeing when possible, and
use it in ena_suspend().

Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/eth=
ernet/amazon/ena/ena_netdev.c
index e6537d35408c..9cb2be501263 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -76,7 +76,7 @@ MODULE_DEVICE_TABLE(pci, ena_pci_tbl);
=20
 static int ena_rss_init_default(struct ena_adapter *adapter);
 static void check_for_admin_com_state(struct ena_adapter *adapter);
-static void ena_destroy_device(struct ena_adapter *adapter);
+static void ena_destroy_device(struct ena_adapter *adapter, bool graceful)=
;
 static int ena_restore_device(struct ena_adapter *adapter);
=20
 static void ena_tx_timeout(struct net_device *dev)
@@ -1900,7 +1900,7 @@ static int ena_close(struct net_device *netdev)
 			  "Destroy failure, restarting device\n");
 		ena_dump_stats_to_dmesg(adapter);
 		/* rtnl lock already obtained in dev_ioctl() layer */
-		ena_destroy_device(adapter);
+		ena_destroy_device(adapter, false);
 		ena_restore_device(adapter);
 	}
=20
@@ -2549,7 +2549,7 @@ static int ena_enable_msix_and_set_admin_interrupts(s=
truct ena_adapter *adapter,
 	return rc;
 }
=20
-static void ena_destroy_device(struct ena_adapter *adapter)
+static void ena_destroy_device(struct ena_adapter *adapter, bool graceful)
 {
 	struct net_device *netdev =3D adapter->netdev;
 	struct ena_com_dev *ena_dev =3D adapter->ena_dev;
@@ -2562,7 +2562,8 @@ static void ena_destroy_device(struct ena_adapter *ad=
apter)
 	dev_up =3D test_bit(ENA_FLAG_DEV_UP, &adapter->flags);
 	adapter->dev_up_before_reset =3D dev_up;
=20
-	ena_com_set_admin_running_state(ena_dev, false);
+	if (!graceful)
+		ena_com_set_admin_running_state(ena_dev, false);
=20
 	if (test_bit(ENA_FLAG_DEV_UP, &adapter->flags))
 		ena_down(adapter);
@@ -2664,7 +2665,7 @@ static void ena_fw_reset_device(struct work_struct *w=
ork)
 		return;
 	}
 	rtnl_lock();
-	ena_destroy_device(adapter);
+	ena_destroy_device(adapter, false);
 	ena_restore_device(adapter);
 	rtnl_unlock();
 }
@@ -3466,7 +3467,7 @@ static int ena_suspend(struct pci_dev *pdev,  pm_mess=
age_t state)
 			"ignoring device reset request as the device is being suspended\n");
 		clear_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags);
 	}
-	ena_destroy_device(adapter);
+	ena_destroy_device(adapter, true);
 	rtnl_unlock();
 	return 0;
 }
--=20
2.17.1
