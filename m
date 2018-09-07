Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFCEC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE3020857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fdEv5BM9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE3020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbeIGFRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:17:05 -0400
Received: from mail-bn3nam01on0105.outbound.protection.outlook.com ([104.47.33.105]:63798
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726307AbeIGFRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxW6TXgIBI57HIUxzNDkaCGAzYdnEpUpUCSFXxNh0/Q=;
 b=fdEv5BM9bHhdJEef7X8CgNxpTV7TIglXCOFbpq5Z+kKdyqgtcUcxyqGORCznw8Pm6j+2CXrBHAsUcRnrQPMEXujvVfNXqWOwqYwolEDU/fZg5GrFHLTBJ9MiTCOkDDNSsRGNkJhwzajztMTkcZ9W/E6ykFjuOuCeWdST8982CiA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0696.namprd21.prod.outlook.com (10.175.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:38:56 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:55 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 33/67] video: goldfishfb: fix memory leak on
 driver remove
Thread-Topic: [PATCH AUTOSEL 4.14 33/67] video: goldfishfb: fix memory leak on
 driver remove
Thread-Index: AQHURkL+QJIIgjU0lES+/zLl7vX1jA==
Date:   Fri, 7 Sep 2018 00:37:45 +0000
Message-ID: <20180907003716.57737-33-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0696;6:gWs1+3hcLhhXwCT9UoJhLkBQXx/Ci23b768KZ1ms7YKGIhPiaF3jArqenRqaOAMuTg7muGafPT6+23lxkJk9CS50rwhfOaENoVePwq2W8enaGeOd8mgYEHmcFM5JOeoffB8Xl94nhw17ggvZEU9uRWf/YzAr0gmydnTnTLNFXA/Zw09ox3XsHrGLHmT8Vtd13+1DUWXZvNTVACzFnGAX7mOb9SDCKnB7xboW+g13KTF1eZRx9j1JAoP+r+BzaM1fmmljb9soTH+MbWCevzcwk/SqYI5FGVlRmuFesplbbWzpivEertpcLN1yJbXdRTgJYG1M8HK0OJrwD3RVj++8WODSrmLAKsvPLDRZ0/fnq9jzNKzo5iGPeh11IxryZpOYp5w8ebfVCmurjfWSb6PWpK/tNSfHe45x4h7heSOFSyWfmR89DBz+OkbYQX5n0gzQ1EmlNcsm77v1icDd3PfsaA==;5:TdjGme+i2tqUpQXEyhbAsftbmLfI7yMidc8NSVW1Fx0HkHoJCTFctzWIYY8/6Gw864s3AC/3UB0u8HclL2vsoaBG2KyR/89DOHPPZ6M8leiGEir9pfvgxwPHNd+xu6r4qtkI4wNnra/dk6l3MI7+xF7MG7NBTiIGyKZZrl2B4O8=;7:QC3yw4D3tt8HSKwiZZLyojKuemk6M/6xBuJW023a/w3u5OxcmtLMepmBfmu41zfSQW1xKMEwIbWnBM9yF/Qh/iwKsN9DRaIkfACGspLF40MHZwxTY+rX+0j3jkB3WAFDFrXaqmN3HB3nlk3NK1mdt7Y3dHl55ot4BGkJ/QOW7mOGNlueI2GcSY3DWYxwkr3G3Y7A8ENfCeo7hddp3HftOIbeZsRz8ZWJcRQYf5Y1MbSgbJliH3RuvYlBLAzLNZ4h
x-ms-office365-filtering-correlation-id: c05138b2-6149-438d-6133-08d6145a4b27
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0696;
x-ms-traffictypediagnostic: CY4PR21MB0696:
x-microsoft-antispam-prvs: <CY4PR21MB0696338DED8ECDEE2A84BDD2FB000@CY4PR21MB0696.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0696;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0696;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(366004)(376002)(396003)(189003)(199004)(107886003)(36756003)(99286004)(97736004)(14454004)(105586002)(256004)(14444005)(106356001)(10090500001)(2900100001)(4477795004)(4326008)(86362001)(72206003)(25786009)(2501003)(5250100002)(6346003)(54906003)(22452003)(26005)(186003)(110136005)(316002)(446003)(2616005)(476003)(76176011)(11346002)(66066001)(8936002)(68736007)(6506007)(102836004)(86612001)(2906002)(6486002)(486006)(53936002)(478600001)(10290500003)(305945005)(6666003)(1076002)(7736002)(5660300001)(6116002)(8676002)(217873002)(3846002)(6512007)(6436002)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0696;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 5WZ9XTfF0so6NpzE7HzDMKS+Q64ofIBxQE+Ohe1cCynBULzl+Y4kJedI8g19Nw+tHobHBdCDwaYt0Xs/SOLRxU0qCjtu+sckfZttdKv2lNUTdsG9WdAHjrajkGJCdoniS4l5eCsrtSyJOfDHi6PG+Fme7/kjH1mDt/Ub4vedjPk4vJPK5eEBlVIvFIT7b2khN20R4KQ3RwNBTp/xuT4I/ELs+rwdUf07GzT1tGz3/eSthlDtERlpBNfpd2/FcG/CGndPIA6D7s8VWpWXcWBB/Xi0ALZ17EwDAQC//ctQCdOeeUXjumnTYeBbPHnUULyfPaAJ/DcikgGWvWyhLAWuy7pX+he6LripZjtVzO9HHP0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c05138b2-6149-438d-6133-08d6145a4b27
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:45.1642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0696
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Vasilyev <vasilyev@ispras.ru>

[ Upstream commit 5958fde72d04e7b8c6de3669d1f794a90997e3eb ]

goldfish_fb_probe() allocates memory for fb, but goldfish_fb_remove() does
not have deallocation of fb, which leads to memory leak on probe/remove.

The patch adds deallocation into goldfish_fb_remove().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Cc: Aleksandar Markovic <aleksandar.markovic@mips.com>
Cc: Miodrag Dinic <miodrag.dinic@mips.com>
Cc: Goran Ferenc <goran.ferenc@mips.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/video/fbdev/goldfishfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/goldfishfb.c b/drivers/video/fbdev/goldfis=
hfb.c
index 7f6c9e6cfc6c..14a93cb21310 100644
--- a/drivers/video/fbdev/goldfishfb.c
+++ b/drivers/video/fbdev/goldfishfb.c
@@ -301,6 +301,7 @@ static int goldfish_fb_remove(struct platform_device *p=
dev)
 	dma_free_coherent(&pdev->dev, framesize, (void *)fb->fb.screen_base,
 						fb->fb.fix.smem_start);
 	iounmap(fb->reg_base);
+	kfree(fb);
 	return 0;
 }
=20
--=20
2.17.1
