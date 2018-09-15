Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA14FECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892B221477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NgWmeiXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892B221477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbeIOGrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:47:48 -0400
Received: from mail-eopbgr700137.outbound.protection.outlook.com ([40.107.70.137]:63424
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728441AbeIOGrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3Quer/TrEnu13nvf090v3Tobg/fPzIuPuJADYuz/lQ=;
 b=NgWmeiXIt5/Qcp0tRRd/Z+G2EHfI3xNcaNyzMibHwu+vU5P7xM7jDTKswTlUhc0J5rPLYJUnH+KPne+OO0O2OO/uuEDqAODU+UcNjW+kqFSnOyA2cXCgcn6afKYUOgzkxXCZa85wui2xBLylJKKlOGwJnuKP/hdbaZiQb2lTaMQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.6; Sat, 15 Sep 2018 01:30:46 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:46 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stefan Agner <stefan@agner.ch>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 39/92] mmc: tegra: prevent HS200 on Tegra 3
Thread-Topic: [PATCH AUTOSEL 4.18 39/92] mmc: tegra: prevent HS200 on Tegra 3
Thread-Index: AQHUTJOofJJWJ3o+aUaomLBqID5DJw==
Date:   Sat, 15 Sep 2018 01:30:16 +0000
Message-ID: <20180915012944.179481-39-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:VoWKJRRbEhlM1D+HDo0QiKhTNMfd5IxnYV82jVW4fVyfY8CorN20/TxhZfEeyGOZH1uRKuTQMMZ29LuP+xwvOjDWK3vHj9zU+iLE5Df6gpzmaPX8rJ0nGpSbd3Z8GBiuPgPYZRkdZC2wv6L88yd8TLKgTctmkRe6s/2LOutp+vU+J0IyHeReMA6FFKHy4y/Lsu2pq+D+Lp72gxVMix8h3e4hzgFOYsyJWikpGvnzTKvwDNmMZrbP1TBLjBCAA4TDp5ohYveD5dgRVj9MWdwEfxae8fgOIXnsOz75Yo4yp1MCl59dsUHAIPYekFvNB3ijMXXYcSeDNmNgTxREvM7tcj3Lvgi8c42gZGRsbzgEsPzV2AxF9oHnFAoc3LBfgxzLMFjZzAUazQwL64pKGnGuwH7KzIrK6NucFmiR1XZjJ8iegMnsjtHF5ta7+OW8yPLBQ1J4qat6BisTlbrbRxMOSg==;5:5HLRwu/+AITMGJywnUreMg+46yuIh/k8/G9EdIpZApWAXN0QYqtPFFSTbbbTTJe5QQNppldwcDakQN2axrn/qtjmaFLbsry1ehCpGCfvSBaO3dTnPboO4k/0pSSFged5hKuIlUwd7tLR2s6Ln/U7rjqBfNF3VyfSxBhUy+02dQw=;7:brcLlujDfZF0r0rugtI0mPASxwiTt2jKR8CYGe13Y3LSTazGUjTQEpagkHo4dcQthLxP8DiYtcxCKaRPpF3+Qqy7By8yTs/vfvi6kxiqpSEtYn21qu38x9ts2yFiDPf929KSTEczUAJRzeeHYmG1J+e4oC8IM+Y8GIrHx3lOjy8h5HMJH3MLz3rWPR1oVY+PNT7u2ZnNIm1hITDwirzuKZ9afbglcorv1xHMU7QSyJZQg6iJmikfHHt65fHvUetm
x-ms-office365-filtering-correlation-id: c5154a9e-d115-416a-6963-08d61aaadc75
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
x-microsoft-antispam-prvs: <CY4PR21MB085626D0175E6F5C2E6776D4FB180@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(346002)(376002)(199004)(189003)(36756003)(6116002)(486006)(316002)(3846002)(8936002)(22452003)(446003)(11346002)(2906002)(476003)(2616005)(6512007)(107886003)(53936002)(54906003)(1076002)(110136005)(25786009)(102836004)(66066001)(4326008)(217873002)(99286004)(14444005)(76176011)(68736007)(6666003)(86362001)(5660300001)(6346003)(8676002)(86612001)(256004)(186003)(81156014)(81166006)(6506007)(26005)(2900100001)(10290500003)(478600001)(7736002)(72206003)(305945005)(97736004)(10090500001)(14454004)(106356001)(105586002)(5250100002)(2501003)(6436002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: hGhprSP4BA6G1STx03yWmX605x732B303faKw0k3vORV+8uqNEIgkaKy0EHSz9FEEjGexHSFMixrwc8cgGtNsEqVuzDqknVzcNj331Hy0KHP8NHc9Is6GZGuaTuLfqrMNO4kndmvqxdNr4tozvct0jY4fxZUIUviXzyC1yW+XY4DxV7YqGYxqwmpYZSDtH5ZjjMNJUIc0oProjiSHSvGl8IFI/QiYf26OdcHe8ZvJX+jnxW3V9Z39HafONvWqZ82UPu6OGJMB1j/dJFG6jPemwuyPyK1q4FbaaFWKTaFPBvqXA7FmsfvOkVqukMFSV7u2phuCtJz2N81bkuxPwScIOfNIYQHfbRIsA75Fh1NGHQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5154a9e-d115-416a-6963-08d61aaadc75
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:16.8544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan@agner.ch>

[ Upstream commit 127407e36f4fe3a1d5e8b9998b479956ce83a7dc ]

The stack assumes that SDHC controller which support SD3.0 (SDR104) do
support HS200. This is not the case for Tegra 3, which does support SD
3.0
but only supports eMMC spec 4.41.

Use SDHCI_QUIRK2_BROKEN_HS200 to indicate that the controller does not
support HS200.

Note that commit 156e14b126ff ("mmc: sdhci: fix caps2 for HS200") added
the tie between SD3.0 (SDR104) and HS200. I don't think that this is
necessarly true. It is fully legitimate to support SD3.0 and not support
HS200. The quirk naming suggests something is broken in the controller,
but this is not the case: The controller simply does not support HS200.

Fixes: 7ad2ed1dfcbe ("mmc: tegra: enable UHS-I modes")
Signed-off-by: Stefan Agner <stefan@agner.ch>
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mmc/host/sdhci-tegra.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.=
c
index 970d38f68939..137df06b9b6e 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -334,7 +334,8 @@ static const struct sdhci_pltfm_data sdhci_tegra30_pdat=
a =3D {
 		  SDHCI_QUIRK_NO_HISPD_BIT |
 		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
-	.quirks2 =3D SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 =3D SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_BROKEN_HS200,
 	.ops  =3D &tegra_sdhci_ops,
 };
=20
--=20
2.17.1
