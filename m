Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EAEECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798732147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="oQQrC0tf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798732147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbeIQI1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:27:54 -0400
Received: from mail-eopbgr710116.outbound.protection.outlook.com ([40.107.71.116]:59328
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727664AbeIQI1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBxEwjAOMtGwCpEK/9iEbCZDmnGSaZIdmXSZlgg8mHY=;
 b=oQQrC0tflX7PCvrB6N/Dqp13eF1YP2iQCADrlQdRmOQ/UzSlDWtnh1/5n48AqW3PG/9UPoVTti4lZi+Iz9c8k3bp1xJJGIUoa/qy4K4OA7UEo+8ubBKOLYtWbJVVEXAicprST5yoynA8kGBcB3im41Jhu05bpY+3X5Inz/8/pP4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0790.namprd21.prod.outlook.com (10.175.121.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Mon, 17 Sep 2018 03:02:35 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:35 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stefan Agner <stefan@agner.ch>,
        Tobias Regnery <tobias.regnery@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 093/136] brcmsmac: fix wrap around in conversion
 from constant to s16
Thread-Topic: [PATCH AUTOSEL 4.18 093/136] brcmsmac: fix wrap around in
 conversion from constant to s16
Thread-Index: AQHUTjKvFCQqeMGH0ESnZJjifDs0Kg==
Date:   Mon, 17 Sep 2018 03:01:10 +0000
Message-ID: <20180917030006.245495-93-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0790;6:zmJMcpEC/ugbR/dSD3agJKasfmWi6T0o5xqkduHzxyuFimQdKzjHJOeR4UL+DyKzKIKK+eT9BA/Y4hpG8CTEmHw4ITiJT6pK6SSEI5SUhf6ZymlB20ISLTv+ThfSuGpLf1hY7G9iCZD5X6abVJrZ3CVommmJoaamtR2o1T7yjbINQ20cwOjo0PQrugRHwpCpT4/NhjzPyMoRQfMHM/67HEi+zQil943kqiYjK8/UfP8/emgmzWbSxpcAVtoiUgeKIt6BR9bCGazM6Bq0+O/qstUTpjrA4KuzOITxe0iWaupnuHnOmyLfbBUfPP9myzMuFbuLJVheTxYGnQb2aBkjAqmWWbgDLl5F5OszazboGeUcpqYZn+dYzIRXadcMXRyeAukuAgG+F8VO8qk77nFKfFyuSPP/R5HTY6ThHRV5PoB7/RjLSu2cAlvmZ6V0T1DzWQp50HSmX+BmUvN223shxQ==;5:88ZFUy2Mv3xzcTiU2F9f9C5wqzn7MSnUpW5eUFbWzhVxu4HKWHyjCN0TiWtPk5fUiA24Uj+n6JTuEgdnSj9sSxms1tFP0U9LEfF+ZIk6gO+A65t/1GoIm4g/08Cjfm0Ry8iAGFpQCMopRknBKKLXRc3WV+4QS7ye7PIDJmTVZjo=;7:sOHQMt0+Mk7tqSEgUnuSX7buPU2HpjQ4qLkRSNbAAl9lO/bTq7GKFpuPC5y81SHNdm32fSzT0cmIiatcoF9RfzQns27w+yQ0/d7BlO+N8oKvS0qYGKtLlP+Wq8L2JqVqNaY5eikLvVktqTLwSZPPbmRPfRNflFRbVMHsSMBDfg8UT9mOv/8I1ay8pWe7rEpdNcIjnG1MjRCD4obEWqsd1q9y7/sQnTrSlO4pkP2hjz+CwkAuwiZ5ZImYXiA7ddtq
x-ms-office365-filtering-correlation-id: 883bb2b1-3cad-4f9e-1402-08d61c4a04a7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0790;
x-ms-traffictypediagnostic: CY4PR21MB0790:
x-microsoft-antispam-prvs: <CY4PR21MB07903482D82907D8CCEE1D2AFB1E0@CY4PR21MB0790.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0790;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0790;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(189003)(76176011)(22452003)(6666003)(110136005)(99286004)(6436002)(6486002)(2900100001)(2906002)(54906003)(6346003)(10090500001)(5660300001)(7736002)(6512007)(14444005)(217873002)(316002)(256004)(53936002)(36756003)(6506007)(25786009)(106356001)(26005)(86612001)(10290500003)(1076002)(68736007)(476003)(6116002)(3846002)(478600001)(5250100002)(11346002)(446003)(72206003)(2501003)(81156014)(81166006)(8676002)(14454004)(102836004)(107886003)(186003)(2616005)(575784001)(97736004)(86362001)(66066001)(305945005)(486006)(39060400002)(8936002)(4326008)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0790;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: FgI+zkbn+QoCQb9CJaLk7zvwZsbCiy7+gh9Pi8nQ97vJbG9nx30tWiJfxYImu0smKlqPPIbX67B51FgO8Gq38lefBJ5GFhEA5IivQSOicB4Eb9i6Q0eWivyz7PLtGEwI25wgJ0/7DtIHhIjyDycWbMWbmPrTZRqouKfwFYTOeK8UMgv9WDITowuT1PLvx1QwxbCSM9t0Aw/k9BK8gzV/hEiv+dNw/5CX7ZGC8KfOmi8CbGqunZ9kyuhsDZ+acwJm4LxqfUhkKs7suFf7LUIi11Hb3nn5YEG8sGc8ISXpR1F7yP/tJFbnEzB+4cBK8KqTTgtktahM6V6PWgcMTpG+PASO175yAlo79TbDlKYtZYc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 883bb2b1-3cad-4f9e-1402-08d61c4a04a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:10.8230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0790
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
