Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE849C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6367620855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dWeZ+BfN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6367620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbeIBRWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:22:54 -0400
Received: from mail-eopbgr700112.outbound.protection.outlook.com ([40.107.70.112]:50336
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727712AbeIBRWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLJ36SmL7iIE/YLUrnv8FSPd4oiUE3i+gMKnhjkTvUw=;
 b=dWeZ+BfNyiL8IcikiT/vtCwOkK7ZtClWaS5A6zFDAnFQBrVJJOgagD1lHRHUlyeMLdUy3Mtk3DeTJGB3eUzdkRxEaKqPBcte5NOxrgn9vBUb/pU8YTVl1CEv4e0itdUrkAjSp3IrvE6gqgyT24wShBw22e1QVcpMQQg+AiOnbwI=
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
CC:     "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 23/89] Drivers: hv: vmbus: Cleanup synic memory
 free path
Thread-Topic: [PATCH AUTOSEL 4.14 23/89] Drivers: hv: vmbus: Cleanup synic
 memory free path
Thread-Index: AQHUQr3H361b0xVksUuPBH9GzMLZCw==
Date:   Sun, 2 Sep 2018 13:06:36 +0000
Message-ID: <20180902064918.183387-23-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:OcLwYvoS8yLctuM8o4R2u16tL3TY9V4PrJr2IJZOvPvrttJKaeuFcVWVq9jv1cxnq4iM+86JOW2xRE42xTDPxzxQv0m35SvxSwydM9pWKkJ5apsT62mcOE2gFru3LCIxFkxxthElGiPKCehy+Ga+NbscamZZDjZgEAc6k8+ZWBfVmI7Y0IvW2+znhXvnyUv7PmljFZWaITdbldPaMWGQGsZJsksKucQ3rPOKTfozeZ/UlZS+qVYUr1Aw+wAL4UOp5deMxq4BdTdAy66wcC42IGUJ7Ll2lQCBPw04lmUuPPDwh1wpTZgjKZWQIG+5TGEgBnsiQ8yjSKhj6IoeF2cA8JoyWMfmsbeg1nIhRMipMKMBVKj7/9PaXtUEmJMv8YN04QSAddjHy73k6ICYIi1vLnZuHVL0vt/gIJLoKQ0f+7vwqbPOR/KNhtK2PldeM+DSpreIt4bwmX/W66bHtsjgHw==;5:rAKeMEGa8c3bdLaKsJikki9XArL+JlP7nesEy/jttDLWOxoNDK1+itQIFEwkpojQwqG8rDzvbeZT0sivBduIX9XYNXdhrz0Yyvbc9UTLoKV46JmdgF4gficLb4sGxs9W/NNZ5AFTB5JRXvHCWjxoVT5CQwDJ/aCUHsoyzmX9xSA=;7:iPjTF2BjH66xwTOheR2c6KDT3RBOV6oCPeNHPpK5BBSN9BErbFyRS1vP7KJhI5SkB5JCGkmOJx/rfOTx/agtFBaq83diz1YRGuUY/n1G6517TcrshTMWGdTJ5hmJ7hiqhcJ84ItGlWE8CWIBSYLAX51PANBe9NdPufTVlZHv2USrcDEtv8X2HPDrUolsatR3KcHGHK4BPx3XiUsFNOStjlvNxwbeV/OngBYEWAJvYzdp1/rU6LTvdztWX19gdVEi
x-ms-office365-filtering-correlation-id: 4dde6136-5a51-420d-db95-08d610d4faa3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB085684B25C52832A807888EFFB0D0@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(39860400002)(366004)(189003)(199004)(53936002)(81166006)(11346002)(81156014)(446003)(476003)(4326008)(5660300001)(25786009)(86612001)(8936002)(26005)(6506007)(6486002)(102836004)(2616005)(86362001)(8676002)(6512007)(6436002)(107886003)(66066001)(256004)(10090500001)(217873002)(14454004)(3846002)(478600001)(1076002)(72206003)(6116002)(99286004)(305945005)(7736002)(22452003)(36756003)(76176011)(105586002)(486006)(106356001)(2900100001)(186003)(97736004)(68736007)(6666003)(316002)(10290500003)(2501003)(110136005)(54906003)(2906002)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +lxlKQ2agWo8mFlqsAe9e/Yo1lKvB/Npo9dSXKhSs0lWaceo155yx1vUh55Kem0yZ5TTF2vAds1LUngIFyRniVGtBryy77ZqhJ2kQ7ZmXZeLk/5B+E7vYSUjAALL4LywwFVg4rDWfMaDTmdXigoPCjZ1L2IrG8Z0MTgrcwLkVDtYZUKSijpWvbVWPPVLhz7YdTY9kl4UXUF+wYrsFNz09FOEr3/eEqGxQU3nMdkLwWltk8JPnVXP/K3T5Kll9/ebRtgHeLFozUt7Jh+hEgweoncz4aFaXWxdL7iz1t7YCi+E2Q0k55s3hH5Tq20Sqa2IYPOHAZb5lbeLvtBMH3GuZjyGsOgtaKCjZP/RzMsnXLs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dde6136-5a51-420d-db95-08d610d4faa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:36.2133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>

[ Upstream commit 572086325ce9a9e348b8748e830653f3959e88b6 ]

clk_evt memory is not being freed when the synic is shutdown
or when there is an allocation error.  Add the appropriate
kfree() call, along with a comment to clarify how the memory
gets freed after an allocation error.  Make the free path
consistent by removing checks for NULL since kfree() and
free_page() already do the check.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hv/hv.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 8267439dd1ee..d8101cd28dfa 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -196,6 +196,10 @@ int hv_synic_alloc(void)
=20
 	return 0;
 err:
+	/*
+	 * Any memory allocations that succeeded will be freed when
+	 * the caller cleans up by calling hv_synic_free()
+	 */
 	return -ENOMEM;
 }
=20
@@ -208,12 +212,10 @@ void hv_synic_free(void)
 		struct hv_per_cpu_context *hv_cpu
 			=3D per_cpu_ptr(hv_context.cpu_context, cpu);
=20
-		if (hv_cpu->synic_event_page)
-			free_page((unsigned long)hv_cpu->synic_event_page);
-		if (hv_cpu->synic_message_page)
-			free_page((unsigned long)hv_cpu->synic_message_page);
-		if (hv_cpu->post_msg_page)
-			free_page((unsigned long)hv_cpu->post_msg_page);
+		kfree(hv_cpu->clk_evt);
+		free_page((unsigned long)hv_cpu->synic_event_page);
+		free_page((unsigned long)hv_cpu->synic_message_page);
+		free_page((unsigned long)hv_cpu->post_msg_page);
 	}
=20
 	kfree(hv_context.hv_numa_map);
--=20
2.17.1
