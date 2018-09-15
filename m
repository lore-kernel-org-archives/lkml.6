Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11350ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0AD021477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IxFxKCkZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0AD021477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbeIOHFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:05:40 -0400
Received: from mail-eopbgr700137.outbound.protection.outlook.com ([40.107.70.137]:63424
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728571AbeIOGr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLeN3bGojyEqJBKF/bUxEAgxwYKPbvr5Z+JDPqojaog=;
 b=IxFxKCkZUbaJdcVXaDgaLXdWnzSe99yCBeohasXvCiP/3ix0nHRDdCKEbIRdvQDOd8trVgreABBJd7raL5OkJ7wvIxFpZEetyE/HbIhe9+IMHSKcB0Uy36NUN+RWy1kMPx/ajYNId+dUDE2t1rMKTXBdsuW3Po+TegIFPiqGd4w=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.6; Sat, 15 Sep 2018 01:30:54 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:54 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 53/92] ASoC: qdsp6: q6afe-dai: fix a range check
 in of_q6afe_parse_dai_data()
Thread-Topic: [PATCH AUTOSEL 4.18 53/92] ASoC: qdsp6: q6afe-dai: fix a range
 check in of_q6afe_parse_dai_data()
Thread-Index: AQHUTJOuc/PXLGdlokC0WpN0Q5/Gww==
Date:   Sat, 15 Sep 2018 01:30:26 +0000
Message-ID: <20180915012944.179481-52-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:RILk6B6OOUjDYxj5ZQe0dZ77N9+OjtbK9fYnAUS+S0rjO4AcBOEg2el0MazL7CIPCGI1Tyxt5xP1/hR+6QtpSoAqSwfwrTx7MqCF0UvHu9gx6I8QR8jhJV1gUpzvu5PBl+MxEKbZjk7iQc5JUW7FSEi50cFgeFXz03vlvtYeokxdKt3ftqKMA0OIDqUS151tB9ny9fvTVo9kDSx++kDYfkSYDVRcSI0gb7ofOtfyS4Jd2aU13ILLXOeRqzNZffanHv/dRWwnA6z6IE0L0ojZ3PHnRfgw3q7ylLEQlPGIrKZzHC0PFtcs5U6F3cSZWCaddlxiw2JOxXCsomutDdZctMwKm6SIQkdlF2TA7VOtZWUt/eeVYw62+qQBc0iBm8/jdJDQR8d8J4YoV4wlTcqRdaSF4WJX5RBBy55PZPD4/1ItTrOJs9WqEo1rhnd+uvc5L2sIUEpH2SHRkMy9ZlwDYg==;5:0Rk7ia5QkWaucyg+duQsMaTSOHRuQBkaxRpq/kRMr/RINQPKTrkrZq3u/h5jfFCAqlzd9ola3rNYshndl31HUhu92dRoP9jIYjCO4kna0WgzP9EYwRsDmjmQhCcoBWf8Us7dvIBtBzGuIi2Y9Dd8bx3iaW5lGEcJioen6Zn5fkA=;7:LEI3UMEqqliNXp07vs3QQ23C2y9tzKDEaOboGZkpjBH2yXLrMG9a3K65VzZQWFI4hJVffG59HiWH0o3J8yt5JCCDPJthsqoYdbK1tpqSdgheAKwfSYtDgfyzDH+V+escda9KUVVrQFUZEsszq9IN9GyE2mxFTAEQfJqXiiGuMiAxzTT+cV1LBl5n25kR3Ev4GabhZY5DZNy4v0wSCtodWBe6ZvpmDWyTFE3gQAyQFQ/bjq6g6/Hr+6PcErUdNelH
x-ms-office365-filtering-correlation-id: 3436e749-18b5-4768-32fd-08d61aaae0f0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
x-microsoft-antispam-prvs: <CY4PR21MB085679EFFD3C5767D6F8C918FB180@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(131327999870524)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(346002)(376002)(199004)(189003)(36756003)(6116002)(486006)(316002)(3846002)(8936002)(22452003)(446003)(11346002)(2906002)(476003)(2616005)(6512007)(107886003)(53936002)(54906003)(1076002)(110136005)(25786009)(102836004)(66066001)(4326008)(217873002)(99286004)(14444005)(15760500003)(76176011)(68736007)(6666003)(86362001)(5660300001)(6346003)(8676002)(86612001)(256004)(186003)(81156014)(81166006)(6506007)(26005)(2900100001)(10290500003)(478600001)(7736002)(72206003)(305945005)(97736004)(10090500001)(14454004)(106356001)(105586002)(5250100002)(2501003)(6436002)(6486002)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 8WUebGUjqnVg4VUKIaZPaYYeFLJ1P90530JN52aJOq0ZfxUTr6Oicv3K2cJk3u/s4j7AKKn+NIVu4V2tw7J1prpzwq//kW4sKi3oXT0ax4hQz2W54Xx1sbmsUpRNacVwMGOON8hqYl04NSfZDC5xTxczi2F8v16LH9DpBYR8F7hduY0NC0lXIKCuw3LxOv5rG1S9SWARh1StkJ5d8ZF54+o3BqcFSG8VhVsE8OkxR+6HT+myzlr++UNGPpHkuLIMAM6vrJTxjPw+8t63LPN+mYx25UpSvsEZzJVb8SREEWcPm2psUS/cbo2BK2Li7c5rw1duyczIoNeXL5EgNQgt4cPAZ+WsDXfwXZINjdXWzhY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3436e749-18b5-4768-32fd-08d61aaae0f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:26.7605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit b8110a87b75f948d978c06e130cc68026645c4a1 ]

The main thing is that the data->priv[] array has AFE_PORT_MAX elements
so the > condition should be >=3D.  But we may as well check for negative
values as well just to be safe.

Fixes: 24c4cbcfac09 ("ASoC: qdsp6: q6afe: Add q6afe dai driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-=
dai.c
index 5002dd05bf27..f8298be7038f 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -1180,7 +1180,7 @@ static void of_q6afe_parse_dai_data(struct device *de=
v,
 		int id, i, num_lines;
=20
 		ret =3D of_property_read_u32(node, "reg", &id);
-		if (ret || id > AFE_PORT_MAX) {
+		if (ret || id < 0 || id >=3D AFE_PORT_MAX) {
 			dev_err(dev, "valid dai id not found:%d\n", ret);
 			continue;
 		}
--=20
2.17.1
