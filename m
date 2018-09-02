Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E7CC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4348120835
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jQEyqV5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4348120835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbeIBRwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:52:06 -0400
Received: from mail-cys01nam02on0094.outbound.protection.outlook.com ([104.47.37.94]:40784
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727628AbeIBRTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ph3P/wmAfs1L8TvjDoryjrF9gSKcXXv2ouyLY+kc9rI=;
 b=jQEyqV5K6zVVToK4tiyjd5BgPm3ESt4ogus9bYAI1pYhLD70ysifqnJ7K8LElF6VsSu4N06UI90xsS+786vRGRO6u+FV2GdkyNrmXz/yIafD7z+553XNroGP23253g9lBTjhdEt1BkxE4Qi+sYHKzBcyVDFe7AyygHmElxoaLyM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0150.namprd21.prod.outlook.com (10.173.189.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.4; Sun, 2 Sep 2018 13:03:35 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:03:35 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 030/131] firmware: vpd: Fix section enabled flag
 on vpd_section_destroy
Thread-Topic: [PATCH AUTOSEL 4.18 030/131] firmware: vpd: Fix section enabled
 flag on vpd_section_destroy
Thread-Index: AQHUQr1bZFUdhs6p00CAiBHfkdmZ6g==
Date:   Sun, 2 Sep 2018 13:03:35 +0000
Message-ID: <20180902064601.183036-30-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0150;6:Pq2xxgSPS+XIHZLFaL1SlmTRez6wJPhuz2dJnJ9MYHypjRCp7DkggYYSFA0R1pBzXhKbYt+pvJ9I6QoyPLLAHhJwxeFJqmfDq22VpP09euSOokOP6aKPCkqxwDc8TbUxojqRt8IZj83t+0wn8mhJ+FnvcaZNuS8GneCoXjnGZu3Yi3egElupUbWGvCyWEFuLz0GZeAr64L98Pjixi/MV+r4mZazFBIozMoVgq8Nd9fJTX33qEUuEl6CXKeTMzouVOBW2XjrwCPVDuBs4Tp78wI+EMNYKOzHvFTuvCeTULftEnqVTU6q+7AbfJzguRzEVo0LzXnTo2oA6EAvAerWQdVKlrCoRbrvUlqZrDyqaojZL+ptkVFmFboLUOEcLCWAlI60ikOrlDri33ZkgoDMFCRuLOf+AshWex0jNPTpbUkOGUcoG6dWL4AcDOrwntSJRQWm0euWBtdYzkXxX4crv4g==;5:35JKQGePMxCvsIDboOZHQtV4iAEIyuNwU92GtLuKfxryBa4C/YtlacbHl/E/B8dKQHMMm6+HaLZwjMqCZd8Tv2CZSHxRtQUaRilDabS7RBd+x//WomCim/eiF0oM0E8j5v3SOUGodhBrCrYXJ5koFdfFBq7IvgTCA7goKbWm/5M=;7:4JWUDarWJdWsdNtDKxw7PoCM/8GtW/OyN7pmllORommYIF7mEIEJfNIdTbabWxkS+icf0eNY95ktwOTITHUTrtkfHDPNFW1mf3cIzuzUnhHtCiCvabkEqWbK+MCkfJ3eRZKF7t+8FIk9i6w2bSJXdi/Vd4xm5ZmrKHsfx3khyKiFXvJ98Pd3XgJx5QFaPpTXXcEnLotedi0Ry7CbwOMySWMgnm72tZVJU1WrsTIPM2vJRtW95q4W1Rt79Y6FDzjG
x-ms-office365-filtering-correlation-id: 46a8a6f6-24fc-4a8c-4877-08d610d47e4d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0150;
x-ms-traffictypediagnostic: CY4PR21MB0150:
x-microsoft-antispam-prvs: <CY4PR21MB0150215BAAB1C3830353FA74FB0D0@CY4PR21MB0150.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0150;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0150;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(256004)(22452003)(2906002)(217873002)(3846002)(68736007)(10090500001)(6506007)(6116002)(1076002)(6436002)(102836004)(486006)(53936002)(76176011)(106356001)(105586002)(14444005)(7736002)(305945005)(8676002)(316002)(5660300001)(6512007)(99286004)(36756003)(4326008)(97736004)(5250100002)(2616005)(4477795004)(476003)(2900100001)(11346002)(186003)(2501003)(81166006)(26005)(8936002)(81156014)(110136005)(54906003)(107886003)(66066001)(478600001)(86612001)(14454004)(6346003)(6486002)(10290500003)(86362001)(72206003)(25786009)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0150;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: YBbEwy4OKgPK7Ej3JEBWC04g68+DoGrntOkINsQHXwb3G/ZPePOtsDjchycnJauaXhrCQpVvMaRCUfbr/adRE4Z0vsPafbK+rT8BZ3Wtl3uA/MHSzQj/YDsmdrKVFseZZdbBpXBCDLDXXX38rdPMvyWvTUk2ebq6YkX7ri8qU+K/mOX3e4X5XemMF5sX7IbNjIB43du6xLlQ4+tyTeA5I0kyN8Tmb6SA/GplxgNfmkFD97c0bJpfH4xJu33EjRR4uNv+QcM5+kpxRvTa2o5xfpS5M3t5/Xw6VvZKCn6ev0PuEChZEQ+ruolHuJebA4wV/mEZqCXfNpF0c18P8v7nJLpKx5Lncnq6uZv1/7teOtw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a8a6f6-24fc-4a8c-4877-08d610d47e4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:35.6157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Vasilyev <vasilyev@ispras.ru>

[ Upstream commit 45ca3f76de0507ecf143f770570af2942f263812 ]

static struct ro_vpd and rw_vpd are initialized by vpd_sections_init()
in vpd_probe() based on header's ro and rw sizes.
In vpd_remove() vpd_section_destroy() performs deinitialization based
on enabled flag, which is set to true by vpd_sections_init().
This leads to call of vpd_section_destroy() on already destroyed section
for probe-release-probe-release sequence if first probe performs
ro_vpd initialization and second probe does not initialize it.

The patch adds changing enabled flag on vpd_section_destroy and adds
cleanup on the error path of vpd_sections_init.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/firmware/google/vpd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
index e9db895916c3..1aa67bb5d8c0 100644
--- a/drivers/firmware/google/vpd.c
+++ b/drivers/firmware/google/vpd.c
@@ -246,6 +246,7 @@ static int vpd_section_destroy(struct vpd_section *sec)
 		sysfs_remove_bin_file(vpd_kobj, &sec->bin_attr);
 		kfree(sec->raw_name);
 		memunmap(sec->baseaddr);
+		sec->enabled =3D false;
 	}
=20
 	return 0;
@@ -279,8 +280,10 @@ static int vpd_sections_init(phys_addr_t physaddr)
 		ret =3D vpd_section_init("rw", &rw_vpd,
 				       physaddr + sizeof(struct vpd_cbmem) +
 				       header.ro_size, header.rw_size);
-		if (ret)
+		if (ret) {
+			vpd_section_destroy(&ro_vpd);
 			return ret;
+		}
 	}
=20
 	return 0;
--=20
2.17.1
