Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19E7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB032086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="Ypmi5mho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB032086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbeK2BpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:45:19 -0500
Received: from mail-eopbgr690046.outbound.protection.outlook.com ([40.107.69.46]:13088
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728565AbeK2BpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:45:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcQINiNVc8Uhdwk5x/VRP//r9Jm7EmAM+Er+Ce2Oyvw=;
 b=Ypmi5mhogYk8Z+EhaDtzniOiKPqgf4y8w+7ghaeBMSWVfp4sfpsVDC8X+lWsqLoIC6OSq6aawLVcpFFrnLhwNfouuOsbpjFpE4FMGy7s5o/JMY90FTtuG1cdXbOo/ZrDqLa4hKOmoQhRyDVbk4tMX810rLUCfSDRqmBn81TDY8Y=
Received: from SN6PR07MB5326.namprd07.prod.outlook.com (52.135.105.33) by
 SN6PR07MB4269.namprd07.prod.outlook.com (52.135.89.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Wed, 28 Nov 2018 14:43:23 +0000
Received: from SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::ccc7:d111:7f3d:667d]) by SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::ccc7:d111:7f3d:667d%4]) with mapi id 15.20.1361.018; Wed, 28 Nov 2018
 14:43:22 +0000
From:   Robert Richter <rrichter@cavium.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "Richter, Robert" <Robert.Richter@cavium.com>,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v2 06/10] irqchip/gic-v3-its: Initialize its nodes in probe
 order
Thread-Topic: [PATCH v2 06/10] irqchip/gic-v3-its: Initialize its nodes in
 probe order
Thread-Index: AQHUhyi2YubiEyidEE20sokqXWnwxw==
Date:   Wed, 28 Nov 2018 14:43:22 +0000
Message-ID: <20181128144240.28727-7-rrichter@cavium.com>
References: <20181128144240.28727-1-rrichter@cavium.com>
In-Reply-To: <20181128144240.28727-1-rrichter@cavium.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P194CA0042.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::19) To SN6PR07MB5326.namprd07.prod.outlook.com
 (2603:10b6:805:73::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Robert.Richter@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.14.124.106]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR07MB4269;6:SvQe8/fH+P8+R3hE18M0VkYl+htpcVdEp6FL4mTGEI3zXAj7zWRBbU2AA42hWQGuklF3WFruP8UrcCqnyPayT0yobXqCmsMCE4LBENTFwlGyz5k3kpIyspwm6oU2ewK2jR+MQQqB/p8pgGUjBIwjglswH4ASOK2JDxrPvBoQYjqZTdrQV6ajqu0sh9CrO0u8TH9cIto+jwhClV2jZgz10kptMtLWEclS/4afEpbRdvIKPPxZsWbaet+rO2AqqolInuGh7y+wXqYSG+Y/qPTgmbf10zoEnXXDQYrxLeg3K9q0EAseWjNmia3KVtQQO6aa4SSK+YxRXixwSdjQCF0ekt9Wm5qZmRG78xhw5rrY1GoLxB9dEkF5RhmqYf+znVyToyel5OIF7Orf0NW1CjmLn8wvOXEKgondXMhDVncZw+3MhtgtA6wd2NHliSy0PmNLLv8VAKAz1Z5QcEiyDCwVIQ==;5:gmxR26aTe+scg8avx2o1HvIfVwdcVVfe7KwUsT6hBd5jQxLwzqLMCihtLYoZtTcJZbFQIbRdHPpEBzLmnLPIInezNdm63eP2olVVj8rFtEyQWEtIAkSNR63t7B7t21Uop5SMP8X+6JesuxNVPXQOy3kb6Vsmep/PTkkb2SQolk0=;7:hTpNwKRtQfZffBS9u+j4Fg3Pzv/5U3LAp7p+v9iLmsrPPux4gu/T4j9Y2BF6mYAC2uZhXuWsl59SdB28J1NzptPRj9hwhxvVIY0dco8K9PWRvB2w+T218IhVDuy5TqKgpAeRb3zJqbOjz45v9Ef/9Q==
x-ms-office365-filtering-correlation-id: 370bd765-198d-4095-36c4-08d6553fd88e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4269;
x-ms-traffictypediagnostic: SN6PR07MB4269:
x-microsoft-antispam-prvs: <SN6PR07MB4269AC1E5624EAE4621AEACCF1D10@SN6PR07MB4269.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231443)(999002)(944501410)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:SN6PR07MB4269;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4269;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(136003)(366004)(199004)(189003)(3846002)(4326008)(97736004)(14444005)(105586002)(106356001)(110136005)(8936002)(81156014)(66066001)(54906003)(71200400001)(81166006)(256004)(71190400001)(316002)(6486002)(14454004)(8676002)(2906002)(39060400002)(186003)(76176011)(52116002)(6116002)(6506007)(68736007)(7416002)(25786009)(72206003)(478600001)(1076002)(53936002)(6512007)(99286004)(446003)(26005)(11346002)(6436002)(476003)(102836004)(7736002)(36756003)(305945005)(5660300001)(386003)(2616005)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4269;H:SN6PR07MB5326.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0WsMFFyTpggisgmQ+kYyUdgU9tyDOCB51BeOv0FIP1rrln5nRCvqezTF4oaxklVVVZnH23LPt205vF8OpaEpNPnoKEdOc6olATN1HtTOM7n5x5RPusMEOaEPEekxISNmzo38TMu3RIYCO2oOcZvHnPPEz7iP17sdJW3Avcpf4Pc4GkA/bNRURjSWJqkBZy9+eR/9J64WCvGEcpy/5TeI+5XLBNAbZ9rEdAUmHT3kGZ9R5uBSRv4f+UVeoMe0Fx1uWLvf38UJPzsruCyW1M0u9xBYwDtXIHls0ARZiuZ6VBeYEplCcyiAkSGTznT7a1UYWz8uEy+Al5BL8b9AyIGhNjVAWJu2aWxLPF7XlPBJJh8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 370bd765-198d-4095-36c4-08d6553fd88e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 14:43:22.8846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4269
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ATM the last discovered node is initialized first. Though this order
should work too, change the initialization of nodes to probe order as
one would expect it.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-=
its.c
index db20e992a40f..4033f71f5181 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3602,7 +3602,7 @@ static int __init its_probe_one(struct resource *res,
 		goto out_free_tables;
=20
 	raw_spin_lock(&its_lock);
-	list_add(&its->entry, &its_nodes);
+	list_add_tail(&its->entry, &its_nodes);
 	raw_spin_unlock(&its_lock);
=20
 	return 0;
--=20
2.11.0

