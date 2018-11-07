Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5174C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6020220862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="LnvuWkUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6020220862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeKHHgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:36:11 -0500
Received: from mail-eopbgr730056.outbound.protection.outlook.com ([40.107.73.56]:17664
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727790AbeKHHgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:36:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcQINiNVc8Uhdwk5x/VRP//r9Jm7EmAM+Er+Ce2Oyvw=;
 b=LnvuWkUO3FqymVx/LDsX062yOjq55wxtlCtrpm+jDtD5Fy5xiNhWtHDWSREVFqVh2yQm/FmTTALGlxx/ImTQNRLzxfXfLxK/cqh0HFiUF64sHT9vC8YnqB6X5F3HGKafKh7py6SapD1L5o13wFapqvccMUyJLm2iF9QjOqSuxP4=
Received: from SN6PR07MB5326.namprd07.prod.outlook.com (52.135.105.33) by
 SN6PR07MB5232.namprd07.prod.outlook.com (52.135.120.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.22; Wed, 7 Nov 2018 22:03:28 +0000
Received: from SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::f0b9:acf9:7513:c149]) by SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::f0b9:acf9:7513:c149%5]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 22:03:28 +0000
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
        "Richter, Robert" <Robert.Richter@cavium.com>
Subject: [PATCH 06/10] irqchip/gic-v3-its: Initialize its nodes in probe order
Thread-Topic: [PATCH 06/10] irqchip/gic-v3-its: Initialize its nodes in probe
 order
Thread-Index: AQHUduW2QuQef2Qx6k+rWXI5dg3fTA==
Date:   Wed, 7 Nov 2018 22:03:28 +0000
Message-ID: <20181107220254.6116-7-rrichter@cavium.com>
References: <20181107220254.6116-1-rrichter@cavium.com>
In-Reply-To: <20181107220254.6116-1-rrichter@cavium.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR03CA0033.eurprd03.prod.outlook.com (2603:10a6:20b::46)
 To SN6PR07MB5326.namprd07.prod.outlook.com (2603:10b6:805:73::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Robert.Richter@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.180.181.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR07MB5232;6:f2rmJRhoyrEwNtPw/sAEMq/JiiJY5vR5+U/g1Y8m3gUrC45twngMWspMQGyQpJgT7uysslhisOwXxQ76v/SP1eJLPkI7932c4htnK2vQT4VcLbqIMwqi+FTkuxTP/o5IXpiHapw92De2t2GLzSxJezJhFzZYLaHcdxXD4K0P7Ysn0YTFpWZzm4WC4z4aAdoL6J9cZDtnJHtX9ZTW0/Y1ijm8FX2i4omzX3k7JxKRBm4ZPK9nQNGR20GNUc29bzbVG1+ljPCxgkKfkfhorYJZdxORQFB3YTmOO1qWfwVVdvyFrIpiPAVFkmOVarFoOw7E4DBPUrRVOYnlqWQUftnFWsJeMjY/rYmflYUeXjSD70Q5bD2agnVc3wp3fhaCynhJ7EDXr3bCP27WumLsFnKm+w1K84uhACj2Rw1y3Pc3m+SIo9eAPYddn194sloj6kcxRRmvlyAvUx2T5USuuQ/iPg==;5:ZNDhDW+9FNF65pknhdXGICtZ9W4AfQayV+sxDxxBsDAqU20cNtA9U6q1+s8UX7y9DCQIc/JM/ily+gaWQGI37u+rbdQI/Cw5hzr48PXVxm9p4D/0xc9OnuhUwNDLExx52z9jiBTpfmT86K0O845WXO12b0mZQEZKnB4mEFKxUNs=;7:yrkUkpfljj4YUnF0UlPjvcchXyQaOQ/FAfb0cztujNGJNLrchPEFG8RGDkeC6WX2165h9ycVMeuCYiUQdY9grWPZf5vIoEM4535iIJVr+8vSQvLcaSUgXaFn6/qjwmfDmW/9lh0B0BdKVw+NDlqbdw==
x-ms-office365-filtering-correlation-id: 126cbd01-a25c-44c2-c705-08d644fcd8a8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB5232;
x-ms-traffictypediagnostic: SN6PR07MB5232:
x-microsoft-antispam-prvs: <SN6PR07MB5232A8C2070CFCE2B9A969D1F1C40@SN6PR07MB5232.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:SN6PR07MB5232;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB5232;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(71200400001)(7736002)(71190400001)(39060400002)(6486002)(3846002)(66066001)(6436002)(186003)(36756003)(476003)(478600001)(2616005)(53936002)(256004)(14444005)(446003)(305945005)(11346002)(6512007)(54906003)(1076002)(316002)(107886003)(25786009)(110136005)(6116002)(2906002)(97736004)(4326008)(6506007)(386003)(72206003)(105586002)(99286004)(486006)(5660300001)(7416002)(8936002)(102836004)(106356001)(68736007)(8676002)(14454004)(81156014)(76176011)(81166006)(2900100001)(52116002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB5232;H:SN6PR07MB5326.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 13vc0D9VT5Ksk+GnBPR1IYcE5dmovyv1NpFCvPVUpkbXfZ1g/l7GZq17WnQeJCF22ygX3bHDCYBo5USCYOvy0w3GG7ePu73zRPfWyONm5yk0fqK+IycHk8p8xNl07/J8tTdDob1wfJV2P2W9j/GxC859m0Fe20f/7CT+oRjCwpMyt2dYEF49OVm2P0sD4KuSZGBkHtANYNb7/0FNeq4ugXcbF+KqS/eAMHinhQvcgl84HgV53nSKqJyrpZWq3TVqy9f8/xRIinFSvnhD9y9QnzBbKT6VuFPL0lcd/s83MaGVOxtEn6U5Nim7GfM4ZtzV4oh0+5TqQdmhTPCL62YqMZIcghM1B8ol2xVA9tl1lu0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 126cbd01-a25c-44c2-c705-08d644fcd8a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 22:03:28.0733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5232
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

