Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C27CC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE172083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PRi6EW9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE172083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbeJAH0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:26:48 -0400
Received: from mail-eopbgr690117.outbound.protection.outlook.com ([40.107.69.117]:44672
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729103AbeJAHOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZIV6k2VQMJXhp4PYaQvtI1BFWRN/reuiJBbHIwPA3g=;
 b=PRi6EW9zoGvLvy/rBHmKMx5T3TktmO20mEjgfVV8oRhBjgD6PrccFpvn46zidrH6lWh3r6ZkIb1yAhFBCjyIP0DKH9zosD9c2ELB/zzlUFxTnC7n8Qrvn34q74pWhHd/pAXuuoduAgK50eb6R5uqAYABzesqnSg0ZWBtqWspIxs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 00:38:56 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:56 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Netanel Belgazal <netanel@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 40/65] net: ena: fix surprise unplug NULL
 dereference kernel crash
Thread-Topic: [PATCH AUTOSEL 4.18 40/65] net: ena: fix surprise unplug NULL
 dereference kernel crash
Thread-Index: AQHUWR8RL4Dh8YrzvUOl+G+GmJgHvw==
Date:   Mon, 1 Oct 2018 00:38:27 +0000
Message-ID: <20181001003754.146961-40-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:Tq7npYI04PWsIqewusFbCyZ3sZPe6ch0Jwuc00BtsE6M1tJIsNqjcsZPv3ldbMS1b3X4wi/1kyTljnVeJIFLX00hGZPErkVwythiuAOSDbmmFdycmrapGj1eLo9ncttc2HqkuUMyPqIVf5anYiPy/A4ZDyjMhpmh5Ndr4Flqr/PtxbGt1/wFA2i/Y67UpkF1ky6XxiGFU6ULpdSGuvOH2Er0oMQdvlhDitYrvORiCe2rakB/PSh3ZzR/4a83by8LBAAS70gH0GPcDnETJI2C+NXVxDs6pgF6KWBmIiqilQtR5ZQDgAiRd5vx53W58dSdmtCWjrwAIAr6KcMQzspivjCZr+rn3SRc2LxgFv5r9I5islB2ctZI93ES0b40Nul9zUKIqkg5mwgwN9eK9dNHnxf/fdWlJfTTVZaDTsuPZVwAV55+9LKQy1FeTRwW5fR+IxrtNffmGmYsadqSgkrb2Q==;5:HgEoSWLQufRDqQ56aJPEzrE7gNAHF5h+EcPWNlEYqLpIoT+JHdQHG7iR5AfjeuybXEHRrcY2fnTGU+sFt/+naSTs4FZ0wlT/YJOHAvnOmmCr2XcfyTxHjLFB1lKwp3bnkc8l2mHQzQhTK+z0DWMxQViWCeuP3LMdliP7wHb59bA=;7:hQER1MvoIqtY0KpfQUoMSCDcKNQRJdFp5nfSPm257go9V2xEIrMCdKixyXvGS0sEq6kZk5w2YRb/J8CRjNoIeP/vAUFCcI5b2CrMZolWhVhp20UBcGmM3lpsXLG62eruFBXBXgTtvxrkIKhCR/an3nMEbdfBF+J/vnG3Zmm0R8nQQ0PDnU5a8cr9by08a8E0/GjD8flpHAmWwN/3q4yHuV7WFIMOTGaxxsQTY5ZyAzpzdYSMrhEBYmsnlRcOX3MS
x-ms-office365-filtering-correlation-id: ed7141b8-87d4-4182-8c7d-08d627364573
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01817EC65F138BFD737B9D56FBEF0@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(47284530071512)(33061846794335)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(6512007)(71200400001)(71190400001)(6116002)(3846002)(2906002)(6436002)(1076002)(34290500001)(446003)(7736002)(478600001)(11346002)(53936002)(6486002)(66066001)(25786009)(2616005)(4326008)(476003)(81166006)(106356001)(72206003)(102836004)(86612001)(486006)(10290500003)(2900100001)(6506007)(76176011)(256004)(8676002)(217873002)(97736004)(6666003)(107886003)(105586002)(81156014)(99286004)(54906003)(110136005)(5660300001)(2501003)(14454004)(5250100002)(22452003)(186003)(305945005)(26005)(68736007)(316002)(36756003)(8936002)(86362001)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vd2+3TA706ynqexxWj+Twn3Py0ngr6RIWEmkvigXYNEbiVj0L1/ohABampmJAO+l02L2RBf5V2b8N78+xz97UoAPU69o7DjRSJzbmUAkJBFV8O3RX1a7bNTPKxpsdeXUVn5r3pIgtyuaKiOFPo5LLsCgISE4fd+lQEuUfRzBxDAUFKFMt8Lr8xyutjCklpxcqtj7b4tc9cSfVWukflk7jYgfxe0uwwViXmPICCdI8Sl6LhzLXQCcUkDpnXRQPcAEIrfspdHbn8+PSNsemFus0GH2RdQ0qoQNVHUFFmQGmXnuMhx4NQaDrD3y7OKGJ83qBsJJSgQ0PeAr1XwqRRzWLHr3rFKvSH/AfWj5jadep7E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7141b8-87d4-4182-8c7d-08d627364573
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:27.5911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Netanel Belgazal <netanel@amazon.com>

[ Upstream commit 772ed869f535b4ec2b134645c951ff22de4d3f79 ]

Starting with driver version 1.5.0, in case of a surprise device
unplug, there is a race caused by invoking ena_destroy_device()
from two different places. As a result, the readless register might
be accessed after it was destroyed.

Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/eth=
ernet/amazon/ena/ena_netdev.c
index f2af87d70594..26686a21234e 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -3408,12 +3408,12 @@ static void ena_remove(struct pci_dev *pdev)
 		netdev->rx_cpu_rmap =3D NULL;
 	}
 #endif /* CONFIG_RFS_ACCEL */
-
-	unregister_netdev(netdev);
 	del_timer_sync(&adapter->timer_service);
=20
 	cancel_work_sync(&adapter->reset_task);
=20
+	unregister_netdev(netdev);
+
 	/* Reset the device only if the device is running. */
 	if (test_bit(ENA_FLAG_DEVICE_RUNNING, &adapter->flags))
 		ena_com_dev_reset(ena_dev, adapter->reset_reason);
--=20
2.17.1
