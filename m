Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C561EC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D622083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="P3pqu9Ju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D622083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbeIGFPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:53 -0400
Received: from mail-eopbgr710095.outbound.protection.outlook.com ([40.107.71.95]:48060
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728038AbeIGFPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yA74/iDFsR8DO9gVasMBlFLXW1SupJ7342cB/YzuxoA=;
 b=P3pqu9JuxxC/OpSl9x0qtv+HRtU01dfhmDJ6uyFRPbygzktFOFk2Hrfl0Vau/FB+6ZbTcsfRaDp3gpvuc+RjwXY8ng+YBiloIoGqMAz7AeWEhJCfPWrkry/2FnvknWJw7IC4oxC4j5ue1CJE7UgkAc88rofNTyx2WBvU4AGTsMs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:37:39 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:37:39 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Hanna Hawa <hannah@marvell.com>, Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 83/88] dmaengine: mv_xor_v2: kill the tasklets
 upon exit
Thread-Topic: [PATCH AUTOSEL 4.18 83/88] dmaengine: mv_xor_v2: kill the
 tasklets upon exit
Thread-Index: AQHURkLdsjVipy01LUaWnR8GevzKCw==
Date:   Fri, 7 Sep 2018 00:36:50 +0000
Message-ID: <20180907003547.57567-83-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:z+9gpost/A/8QsQKZHu2KZkBibOmvTOO0sKsfnIhHmItWHEhFCRBryVTcIeetOriytHkiljr3x7Bd4PKrcFqtwyRUvwTyxyqX2SWexiDoG2q08Ci/qG6EE2EY5IXEk8rPm4BWX1bjECC1cAPCPlt9q/xsaQTRAyBuVj4r1JtmpqvGgBYvwFM/fG1r5LOq0CQ/FUP0r0bzXr/mJkzf95ATj6F/vEu5lhqthMlALkEJ3HoyPjY5i/WV4DSWo/C4ujSVhER/z6jTD5wtVkWJ+ZWt4L+LCVpJp7Inl7guB0H14OobkJQgC3pWGBFt8KY+AjX98ngCz/riP5LtluARgpuqjpsYHlohBKjea/ByT+HajF1LEs0E0PbAy0J6FcSfdpnl05pQLoe5VK+6qcNpzURY9rpQtY7MboHPuxcqrgA5bbgDJOfdBCpLU66fN77Ut5oJMpYej3e3xCAcgs2qIs0CA==;5:oMgB44M6cAOzzv9VsezqXytit6ClU/D6/EvE1aMVvuyRNeo4sBOiHKw8+6BfPnokwoxJKMjIMAUopoby5CSW7ir2Oi6TToizCYZ5aPJrBL1BDjZMSZB0c6R6gHPRcfdv+dvjOal8VhH/Q9vYUnC24DJpy8grZeKi8ly5jc4rNiU=;7:FocepbCOkv6kMuro5tVVqwrcJbE/IvgvruVC7U7ckSWWn3MG1y123UPN7VzoQk7Z7vu9RCAZOXY6Q0R3Y1vPFy9u9HJq9tNVZCBhHsym2HkyyGnrwkDaE+976I8Ba1mkJMAC2DYpaM9Wscm6EphfoHz12q5OQzOhpXgUsiRsxkh6B4x8H0WWL7jO6KM0z/rvVNafAALozdXnH5TXeRN7sWpNMd9eZVy+fr0pyNBHy9mF7g8PudUdQ6ko8UYcb0Ab
x-ms-office365-filtering-correlation-id: 10de7c44-98ce-4ff6-3fd9-08d6145a1d4b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB0839E61B74FC8DBC586879DFFB000@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(10290500003)(99286004)(10090500001)(105586002)(106356001)(102836004)(76176011)(97736004)(6512007)(53936002)(2900100001)(6346003)(316002)(54906003)(110136005)(256004)(26005)(6436002)(107886003)(2906002)(86362001)(186003)(478600001)(5660300001)(6486002)(446003)(476003)(68736007)(7736002)(86612001)(11346002)(8936002)(1076002)(22452003)(25786009)(2501003)(36756003)(2616005)(486006)(81166006)(81156014)(66066001)(6666003)(217873002)(4326008)(6506007)(5250100002)(6116002)(3846002)(305945005)(8676002)(72206003)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: hMixJ1eKJdQEp30d6BB8FWgPJ9vFz4568iRZgYydrBgxF4IryuLoFz0oIjFINU1JgB9DTm9E9ZloAQtp8TLNfPNlJJ1mL9rSlmDq6/zDWhSE77iP17TL7YTDhW2aNUGAN7ZW+joR7Lz+xGv8j2DQNxVsMzR8XU/8wWEYy0FN205nQw+9/kEPhJlArfaGV8zoF6KN6Niwzj/3r3elj7E/Kby8qvPQyZNUHrSogpNqoXxTZ0Ta65EHvblMvSDOg5A+/yyk5wsWDdrtCUi+9kOU1rVrE9Y6IEWI5ZeGU+05G47KQcnQesqBv9MtvcVMQmvK31phxkYb4NAK1Zrb3LJZWxcEdRmOahCzfBd0WBHbcH0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10de7c44-98ce-4ff6-3fd9-08d6145a1d4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:50.1167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hanna Hawa <hannah@marvell.com>

[ Upstream commit 8bbafed8dd5cfa81071b50ead5cb60367fdef3a9 ]

The mv_xor_v2 driver uses a tasklet, initialized during the probe()
routine. However, it forgets to cleanup the tasklet using
tasklet_kill() function during the remove() routine, which this patch
fixes. This prevents the tasklet from potentially running after the
module has been removed.

Fixes: 19a340b1a820 ("dmaengine: mv_xor_v2: new driver")

Signed-off-by: Hanna Hawa <hannah@marvell.com>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/dma/mv_xor_v2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index c6589ccf1b9a..d349fedf4ab2 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -899,6 +899,8 @@ static int mv_xor_v2_remove(struct platform_device *pde=
v)
=20
 	platform_msi_domain_free_irqs(&pdev->dev);
=20
+	tasklet_kill(&xor_dev->irq_tasklet);
+
 	clk_disable_unprepare(xor_dev->clk);
=20
 	return 0;
--=20
2.17.1
