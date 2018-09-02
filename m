Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F64C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E140204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BBIGkfc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E140204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbeIBRWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:22:55 -0400
Received: from mail-eopbgr700112.outbound.protection.outlook.com ([40.107.70.112]:50336
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729041AbeIBRWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hl5weV+Wpd+BqjY5MrqROOeJQJoSoZWxN9nBHNaZT0s=;
 b=BBIGkfc9PnL7EHEVEYz+3cynJOE/JSLwA2FQlbvqiLOgXWqmaNg21/ifeNS1BMCM6NoeLZZ+0tyYEZEzJiNBuoOHK8BPSe/wKe1RJNy37wtzQCr+4FhGwV5cCRxEIrK/SB/MfztTNLLP9leWNGyq790h+DAqjwkEBOcbpNf6ASE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Sun, 2 Sep 2018 13:07:04 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:04 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 24/89] tty: rocket: Fix possible buffer overwrite
 on register_PCI
Thread-Topic: [PATCH AUTOSEL 4.14 24/89] tty: rocket: Fix possible buffer
 overwrite on register_PCI
Thread-Index: AQHUQr3HqPkv8OE1Bky7lMpI23dy/A==
Date:   Sun, 2 Sep 2018 13:06:37 +0000
Message-ID: <20180902064918.183387-24-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:vv/yXJiARfJOY8aaD9YMAhwzfQtb/2cBjS+FdeH5taaVz7seF8Q/++PreS85TT5LTy7L9CiVoCbr15Rllq5CInob2gkmHYn3mTTLkV0mK4+4NzLOHxr0zcNA6Lv20W3RfRmx0CPiOPubIB1oAFIqWmYJWQqM+e3KO7l+FqlwQIGpYIOSuu75d0eP93+7IXY3s99NATjPOvDgeo0ve1EmuxlFs9gnyYQy2m1pu87cYviYqYDnrxI2R/ZGrmzc98evfzIsWWIqeoGpyVw8Xorwr3qSGUprkjLhcee+OAHvatPUI7BiIiuWxliG01lgNIcCOiCqP51x1PdANQchNop+TGG6PhZen5kA3VVZf0+w5gZ5YGJrimzFLtNi+23Dgusbw5pDHkdSmUrLC7PryhKkCgalb6diFF/6lSS8bYjIC0tZWiZxMWbjQb2dzaJuDlEc/z3+ErG1i8Br6gCc4EoAHg==;5:/AOotNzyng9auPW/HKt+xr2ErvOUxtG6k2upOjkjNkoyB22ngqO6UMH9iD8X3b59Z0k4MWVObjvP/f2t5BAUikIuRqt5YebO0hLBGMB0novpAU7350zTYOuM+J/utGAnjPbORsW0mmoVtu84Ua+xgZTZO9iBruMoGzpkqo5mspM=;7:UKDQ00SE+6WeTNrLLN+plSHJ4R3VcPC4aUO0VbXEMS0rlAOAGwmyffwustWAK1b68GuMzK0aF13nu0vLurAI/PdIb6s7FoW63+PIV+vrlWvba2vfcv+8aD1osBzrwtlPLkW7+b8mxq1MGon9n62CI4FNJ6r4w7/JYhRRs6KTa8/3UdCsrzzDUjVVetsJru0Iarowii/1cDU2ew54/GhwnXdmcjtxp3u9BpLIV+u4ofv+7rlLpHkLTeaOKPnRMMAB
x-ms-office365-filtering-correlation-id: 43201a25-39b9-4e3e-2e17-08d610d4fae0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08568CD629A79F77E55CDC55FB0D0@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(39860400002)(366004)(189003)(199004)(53936002)(81166006)(11346002)(81156014)(446003)(476003)(4326008)(5660300001)(25786009)(86612001)(8936002)(26005)(6506007)(6486002)(102836004)(2616005)(86362001)(8676002)(6512007)(14444005)(6436002)(107886003)(66066001)(256004)(10090500001)(217873002)(14454004)(3846002)(478600001)(1076002)(72206003)(6116002)(4477795004)(99286004)(305945005)(7736002)(22452003)(36756003)(76176011)(105586002)(486006)(106356001)(2900100001)(186003)(97736004)(68736007)(6666003)(316002)(10290500003)(2501003)(110136005)(54906003)(2906002)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mM7CdBAPByzzjLAUwXzKE/Q2knSNxQuL76sZxZ+sDUSN+1dTUjc0Fdo6fhriH0LB/6aXX/oJemHZGj01jn+tXyQ346zSeSxMm3eK1uBMD0aFn82SYlW0J/AM8YNQ7MQ9KjAJZ0r+c/4VHqukYpiR5Pj3yKZq9T6+ZjlkyEl+PixEHwPTi46/3x2ItK7CVPerW3ObOdSYjgCXpJF+WelJxUTr/RF2Mr1vaNoHgSR0ki7+AwGsR492t5ePdKsFT2X/PC/OMFyOA1qvxhqF3GvD+MPxODuK9OFyDzBXpTeE/m4kEF+WEuTXP9LnHSIoAjJEvZp7iPMyg4/TYmqcqdkZdCI2K2ScABwoNobaRlX2A0s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43201a25-39b9-4e3e-2e17-08d610d4fae0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:37.2182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Vasilyev <vasilyev@ispras.ru>

[ Upstream commit 0419056ec8fd01ddf5460d2dba0491aad22657dd ]

If number of isa and pci boards exceed NUM_BOARDS on the path
rp_init()->init_PCI()->register_PCI() then buffer overwrite occurs
in register_PCI() on assign rcktpt_io_addr[i].

The patch adds check on upper bound for index of registered
board in register_PCI.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/tty/rocket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
index 20d79a6007d5..070733ca94d5 100644
--- a/drivers/tty/rocket.c
+++ b/drivers/tty/rocket.c
@@ -1894,7 +1894,7 @@ static __init int register_PCI(int i, struct pci_dev =
*dev)
 	ByteIO_t UPCIRingInd =3D 0;
=20
 	if (!dev || !pci_match_id(rocket_pci_ids, dev) ||
-	    pci_enable_device(dev))
+	    pci_enable_device(dev) || i >=3D NUM_BOARDS)
 		return 0;
=20
 	rcktpt_io_addr[i] =3D pci_resource_start(dev, 0);
--=20
2.17.1
