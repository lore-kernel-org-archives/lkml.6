Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90BBECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66AD9208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="X1K8ZP00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66AD9208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbeIQIpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:45:52 -0400
Received: from mail-dm3nam03on0099.outbound.protection.outlook.com ([104.47.41.99]:12736
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730423AbeIQIaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBxEwjAOMtGwCpEK/9iEbCZDmnGSaZIdmXSZlgg8mHY=;
 b=X1K8ZP00q66fAMmDo+I43YUOb6D8mMydNi0foedA8N2EBO0+eJm7mrb4V89Cv4wmOzoSJBcobvWniQi4ghOWJusBsZbp0VITI0m58OZGHWrBMM4g1/OFgv/cVoaYoijMiY1oAt9zTqzDKg5t1dthY8sAYkFuhm/Uss+f7Bo3wwk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0774.namprd21.prod.outlook.com (10.173.192.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:56 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:56 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stefan Agner <stefan@agner.ch>,
        Tobias Regnery <tobias.regnery@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 66/87] brcmsmac: fix wrap around in conversion
 from constant to s16
Thread-Topic: [PATCH AUTOSEL 4.14 66/87] brcmsmac: fix wrap around in
 conversion from constant to s16
Thread-Index: AQHUTjL1RTDPyJypeEKn+smEQLNKPA==
Date:   Mon, 17 Sep 2018 03:03:07 +0000
Message-ID: <20180917030220.245686-66-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0774;6:Sn66PePDIvC+ixg3U8ONg4nsuScRZoYqL7v19cTBqiwpf7vmjBxWQypAmFypiUpktBKSPtplP4MYNNq1HPR1OcXzF8huMWrsT0yqKMzAb/8khng/RsSeTNoWjJeRAmA+pmAfXFlqxGNjI0aIc6Q2//LhrAMnbVnncL2mZ9ViaAExj3vQBan5ADl8DZdt3W17kDW/JRu14cJRbsVmhBo0PLvH8Kkwcu090LEMkkhU+Xhde/FvMy+q7GR/DKO0yUKZlabuYCrZ+NlkzJ+Qoon9bU2aIsSu17ojSFzjb6UAFedUmD2sKtCvNgq4uLjAUHIf4kekHOX226KVBzrkwa97wflNY8xBG6AhWyI3G1XOYrxG6d1L3loyPysQNHgpBu95aRSYvVBuPbi9TvOhtI3i/FEZAE+X2OCwqM4aifnm7R8BAApClxTwFeoX6fZmjxj4xkSxh9mE8L9N1AUV6oHPMg==;5:aTTj5QB+WWS9PZVJxjGq2E/B6fY9GKrEdtCgGVm968zIvqCtqKffvZje5fOy2ymBu9R0f/saDeovH9msGXHYMm5cC3fxaK2H/vHvS+BhZrzC+DnV3SdXG9ZK5VzsfTEVMZeyp4xCe0RDOqx3de9dLLaN3lDqbgukdd8prFiE76w=;7:YGKz/j5SRXlYEdyl2iAO3mmpC2yt/Y9w6Zt6e6LZPxKjtZ7zjU1RvZd8nnkyXb7j5wAeMDsalMi0MwI8MrmTEHiNcUurPu58CQkjsXmm1+s7VKRiRE4/gxin0WR04/7Wf7vwU6xf7TBz4AVcmhigwPiDntd6nBCg1jy1WXViF1Y/Lyj5KLC97O7n0n2vQi+LvNy6+Kepz6zyDPyQQKm1XD9FxOoKCp/SXvONy/VTbRPpefZlW+crzVAVEMwu9Q/N
x-ms-office365-filtering-correlation-id: cba39bd4-c0b2-4bcc-d251-08d61c4a58c4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0774;
x-ms-traffictypediagnostic: CY4PR21MB0774:
x-microsoft-antispam-prvs: <CY4PR21MB07746EDFF9BA6EA8A132461BFB1E0@CY4PR21MB0774.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0774;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0774;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(396003)(39860400002)(346002)(199004)(189003)(54906003)(105586002)(316002)(4326008)(6116002)(1076002)(14454004)(305945005)(7736002)(22452003)(81156014)(66066001)(81166006)(99286004)(8936002)(8676002)(3846002)(478600001)(72206003)(53936002)(10290500003)(68736007)(106356001)(6512007)(25786009)(76176011)(110136005)(11346002)(476003)(2616005)(446003)(6436002)(486006)(39060400002)(6506007)(86612001)(10090500001)(102836004)(575784001)(86362001)(6346003)(186003)(26005)(36756003)(97736004)(2906002)(256004)(14444005)(2900100001)(6486002)(217873002)(107886003)(2501003)(6666003)(5250100002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0774;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: jKfGkDWUU2+SwN8Elq9n97LRhKnNdNP9a12fXjOYWE5Rn9zZZ5gopT8riYn/G4ZQCpnIqXYF2sHqP9h/4/x3IryJivuL//UcvYLVW2gdt6zUPJVma2Ffz9dwyEhgeWpQrPJmZ2mGg3q0CTOz9ct5LJ85A09323llhejQdWCBWigEp14RCBjboj2TmQOcQaG6Xc/d6ksvUjoxU3NRRNqlxsf2gIYmKD133lKzO/IlOR0J8qBWw+bFGorrPJYdkMj+0QS4cmlUHxH4EKIoGE0/4rWLcbrZay7hqHAwPpjCuk0FZlg1Z0Dn+X2ZJbMTarMBuyYphlX6sBKLVoi7MFtHIEusKdXC2u/tjpnvSkIbK5A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cba39bd4-c0b2-4bcc-d251-08d61c4a58c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:07.0403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0774
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan@agner.ch>

[ Upstream commit c9a61469fc97672a08b2f798830a55ea6e03dc4a ]

The last value in the log_table wraps around to a negative value
since s16 has a value range of -32768 to 32767. This is not what
the table intends to represent. Use the closest positive value
32767.

This fixes a warning seen with clang:
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_qmath.c:216:2: war=
ning:
      implicit conversion from 'int' to 's16' (aka 'short') changes
value from 32768
      to -32768 [-Wconstant-conversion]
        32768
        ^~~~~
1 warning generated.

Fixes: 4c0bfeaae9f9 ("brcmsmac: fix array out-of-bounds access in qm_log10"=
)
Cc: Tobias Regnery <tobias.regnery@gmail.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 .../net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_qmath.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_qmath=
.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_qmath.c
index b9672da24a9d..b24bc57ca91b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_qmath.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_qmath.c
@@ -213,7 +213,7 @@ static const s16 log_table[] =3D {
 	30498,
 	31267,
 	32024,
-	32768
+	32767
 };
=20
 #define LOG_TABLE_SIZE 32       /* log_table size */
--=20
2.17.1
