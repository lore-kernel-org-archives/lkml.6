Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39449ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D393821521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bBQjZoFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D393821521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388212AbeITIaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:30:19 -0400
Received: from mail-bl2nam02on0106.outbound.protection.outlook.com ([104.47.38.106]:44649
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731709AbeITIaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Dr2lXdTwTexPrB4qUbK3oC0Me/31ssOo4XGylEqx7E=;
 b=bBQjZoFi+sYnm0edinTxYYWB3lvZL7ZLSIQEz8UT/Ffxf4NgeAF/O7Hw5Fj508I60pM/0jhDYB7b1XswxxTna5H1UAKNY9YLMYtbOwfcZB9JvR7aRn96qZVsT5Kvf0fnuV/R4qsub9uKspYNMoH1HsGE8cj238oviLr+HaEAgps=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:49:13 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:13 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bo Chen <chenbo@pdx.edu>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 12/25] e1000: ensure to free old tx/rx rings in
 set_ringparam()
Thread-Topic: [PATCH AUTOSEL 4.14 12/25] e1000: ensure to free old tx/rx rings
 in set_ringparam()
Thread-Index: AQHUUIxlRZ4E9W18+k20+HoLih0FhA==
Date:   Thu, 20 Sep 2018 02:48:23 +0000
Message-ID: <20180920024810.58594-12-alexander.levin@microsoft.com>
References: <20180920024810.58594-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024810.58594-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:5nNqv0IIsZL0DqqqpeZxCW76l+Hf9gcpPglNUYwVdXGgxsDRfm/ca2sS/wsovVbYnKkSbbnGEQgRZJ21VMcJwT/X7G63afZNJUxXvzH+Ko7lnWQRF/sZliy34s0WcJlYo2qRjfBfuXcQ+xGtHR9lPj4j946TZ3uMXz6RbF9qUffy6s1Ra8KGNBF8ujKYpche9DmILdAtgwZN7fnGIDymRQVLem+RSkoAY8Elb4GJSy8HPlYClWpQDHxupt9hLHQtHqsG3NM6q6ar8SVS39C7GToNQIXhcCZxm5lzzftbYnaygaWKp1Ks6DNNRnVL46gsjn/PbRxYWq+g2/bRynpM1iMBQMiMPDKNRT+3GpIjgYqkqEykDzf1rBZhgO/+KMNJxDoSxIPOCBWJ1E8s13pL5YtTQCWzbtjgLQW5tvAJYiI5BsCYbax28aZBFc5qEyJeVUs1uG/o/jpABsDNXE4aNA==;5:IJ4BEXSvm501YfIiEeMpcC6E22zKUt08+vFN+V57wRRQTxmKsrQFN/e9KUKkHViQMQwi7T4SsUTouHYtDKtezpxG1fj0O0jh7LF6q+nHfrrErI8it7ux+ytm7ZfW3VgHM3bHw8d1sTjrx2S4Mbfh9ir5gbS3jto7SDOZQ07D7Gs=;7:JCqQ1IkEE9YglYzt/Ar52RXz1dAjS65l9Hw9ewMfDqSlxuqmSt+12SidZ/2WeJmSxTX7xP7x/ilH8nvEddx4YVIOTODorV8NFH+oVSa4EpT6r8fGqYxvL3uO+92fU9HPO5jPJ2zYdRYOfDMFpjGw1mM2joGyfAILzm80cHFIFNo6cI16kjUt5cao0fhWB42GEc7jMaLYpW0Q9cE/wEFbaCiCAEwK/l2oSgEDydjiWbK3egbqnQWkMcHddyWRfjxx
x-ms-office365-filtering-correlation-id: 78b13c10-3adc-484a-983f-08d61ea3a653
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0744264F1994B52D8EEDAA3AFB130@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(240347492878265)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(8936002)(6436002)(10090500001)(110136005)(217873002)(54906003)(6512007)(53936002)(68736007)(5660300001)(256004)(6666003)(71190400001)(6486002)(316002)(446003)(11346002)(105586002)(476003)(106356001)(478600001)(2616005)(2906002)(186003)(25786009)(10290500003)(486006)(71200400001)(72206003)(66066001)(4326008)(14454004)(22452003)(36756003)(102836004)(86612001)(97736004)(8676002)(305945005)(7736002)(1076002)(86362001)(81156014)(26005)(76176011)(6506007)(5250100002)(107886003)(2900100001)(99286004)(3846002)(2501003)(81166006)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: n3CWEFKR4gH6oKFHtQQSYucGO07PDJXCv8r6WubKujTUTeAkdt7rMtveS+z48OpQUD0fdz6F0fk3GerVmJ5W6eVuMTBJxd8jMzu8iy+1yi4dgi6bZelnSkTZ2pZiHu8EiUTbxFhqpL29Kb7vlheGBFp2cnfCNc0b4dUvd9HWQpMj647BPr28uNsjEhgf/yMP2XBMjzH6mj9phVN3VxlsMiOBsj1P9sPRLTFwUFL7ljfc9Lnxqg2RNGMbm3TBF79kpINK3uOLlkrlSgRv0jw/GpTk/JFfIbm4AtkrISAjmmdqvbWwvJUaqGKDhVYj2eI8UDDjXxK/5f13t6v9UbKOy4XwYV3OF3zxe+9rChQgHhQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b13c10-3adc-484a-983f-08d61ea3a653
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:23.3977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bo Chen <chenbo@pdx.edu>

[ Upstream commit ee400a3f1bfe7004a3e14b81c38ccc5583c26295 ]

In 'e1000_set_ringparam()', the tx_ring and rx_ring are updated with new va=
lue
and the old tx/rx rings are freed only when the device is up. There are res=
ource
leaks on old tx/rx rings when the device is not up. This bug is reported by=
 COD,
a tool for testing kernel module binaries I am building.

This patch fixes the bug by always calling 'kfree()' on old tx/rx rings in
'e1000_set_ringparam()'.

Signed-off-by: Bo Chen <chenbo@pdx.edu>
Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net=
/ethernet/intel/e1000/e1000_ethtool.c
index d44d3643677d..10df2d60c181 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -644,14 +644,14 @@ static int e1000_set_ringparam(struct net_device *net=
dev,
 		adapter->tx_ring =3D tx_old;
 		e1000_free_all_rx_resources(adapter);
 		e1000_free_all_tx_resources(adapter);
-		kfree(tx_old);
-		kfree(rx_old);
 		adapter->rx_ring =3D rxdr;
 		adapter->tx_ring =3D txdr;
 		err =3D e1000_up(adapter);
 		if (err)
 			goto err_setup;
 	}
+	kfree(tx_old);
+	kfree(rx_old);
=20
 	clear_bit(__E1000_RESETTING, &adapter->flags);
 	return 0;
--=20
2.17.1
