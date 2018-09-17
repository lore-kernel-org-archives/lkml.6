Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67254ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11839214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="kAmn9kzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11839214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbeIQI0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:26:51 -0400
Received: from mail-eopbgr690129.outbound.protection.outlook.com ([40.107.69.129]:35844
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729052AbeIQI0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HU78JTkHk29L8pBUcClLDIUcn5+cXI6m+01k4qeOAo=;
 b=kAmn9kzHRX+q6leBGkW00E/SyMYyHF+tU8JfaBxqE9T06BWThg0QSkrEVzw3BUF99H+dEGWTilv/7mei2EGpG1CIsHIIVK2ButNAS2p4CyjyRGcf1nnpozt1LzNvCysqSixZ0uy4ljIrR9rZIo8ZjLNTVeTFO7+/6kmZXNGetmI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:01:17 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:17 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Vasily Gorbik <gor@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 060/136] s390/dasd: correct numa_node in
 dasd_alloc_queue
Thread-Topic: [PATCH AUTOSEL 4.18 060/136] s390/dasd: correct numa_node in
 dasd_alloc_queue
Thread-Index: AQHUTjKjjtA3r8Xev0mE9/aN3l4L7w==
Date:   Mon, 17 Sep 2018 03:00:49 +0000
Message-ID: <20180917030006.245495-60-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:dFW3ra+/M0WYXmsdqvyjgJltBySK7afQey9fopjhZSQuM4dgBrmhcGQ5a5aV0MoAaMM01SvoD9H421ko+X8QckDwhORd+tKk7BQ0+y9wVstVa6sZbPxXIwvg2IIINFtVT8GMdgRDrjr5oRL1wPy/dfN2H64B3gFLSDjlg/JaSuGjmrqFcHVZjYahTMlhPpfgXVu4Fq63VRFYkUV/Qu2I5LKFGBGY17lWbMk315VzfD8iFI7EZh2J7wETv/jexBYABLNNDjkls0bP62yckIp5zqpw5PyfJAdllT66ZTf6ZlZLrqGKbXleVtIHifvf+OQH+zPG7jMOrXvZfs0llVkNM6vs0OGWdCjEJcU1S0MOL6MDHWLtOldZQS76DvuF/xHGbpF0nvndXsCY9NjiGCl40h7HrLOThJfplkFytNMjbK/XXOBUyVX5nxkthZWkhM8tPeKJzw3bRo2la4MOATtxsw==;5:YRhtpclwVIzlqUCYQC0Jh+JA/9eK7BWOgs0f9pltTzA/id8lt7yLn5KfYyWn/qbTSEGwMuSTQtTppXHyXZGgilTDyZRZEoUonM9M9SHY1vyKKrusAqnEUKH6pJryycgE7PILFQBaX1lUoaJLcXux3taUH7jkhqbtaxALodLYScM=;7:MS0XoQLtD/wG81zfgCHDWmSAuNWwGVkaAoutgJV12tHev02hvJEifGotPGSDG2HCAug5dGAtyvTsIPBx14Tu7nuWinVCUFMBuCz23Mq6f4LG6wj/uSN+N4KTBsvxP3p1fa7lECw/PdPjzNtdgmlY6QhXc+o47P1L7cRO+u/5DCSZnzK1tPzg3x0z8kD+tcdmtzoGUWXl7a6x2rB73hpScMTUWK852+F4Mzl5xbsRDjbiqmtk6OhvmGqrhPf4uXRQ
x-ms-office365-filtering-correlation-id: bff7e6c2-6dbd-49a9-bcbf-08d61c49d669
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB0167B644AF3023D42A902C3DFB1E0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(104084551191319)(190383065149520)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(346002)(136003)(39860400002)(199004)(189003)(6116002)(1076002)(86612001)(4326008)(97736004)(53936002)(2900100001)(7736002)(107886003)(106356001)(10290500003)(81166006)(105586002)(68736007)(3846002)(99286004)(305945005)(36756003)(8936002)(2906002)(217873002)(54906003)(575784001)(86362001)(110136005)(25786009)(316002)(5660300001)(102836004)(66066001)(76176011)(478600001)(446003)(11346002)(2616005)(8676002)(486006)(476003)(6346003)(186003)(26005)(6666003)(6506007)(6512007)(5250100002)(6436002)(10090500001)(6486002)(72206003)(14454004)(256004)(2501003)(22452003)(81156014)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: cuZQBc08FSHwTemW2VjufAGg7TEe7naOrOStWUTcD41P3pm1RMLZKbAye0zcfJ4cvNXTceItK8K2l/+9Fc9JUk4zllmHMAc8L5cnFbJ98aJvXVW3RDUbb4PNLo9mS4YVHbfwhnteuixWc9P7JoIidjRr4BMcPfxkyZoPiIx8WbtyyGZmDwB3kblEvEmSllNbOo5qPHR65c1KVc2kyNnwYl/QL8vv7NfqopTfA5hSbCzd1JKtl+/hkmhg/zkD+5zHwCC5JCEYIOAtbL3pEcLrRnMMl9p9RF1HGAk76/70V3ZCxvREqf15xwIrYSmZPBHzFLSS4EPwRQS9Wb+nUnfmd70bAE5uHW+k4VdYtpbPIlU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bff7e6c2-6dbd-49a9-bcbf-08d61c49d669
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:49.7451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit b17e3abb0af404cb62ad4ef1a5962f58b06e2b78 ]

The numa_node field of the tag_set struct has to be explicitly
initialized, otherwise it stays as 0, which is a valid numa node id and
cause memory allocation failure if node 0 is offline.

Acked-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/s390/block/dasd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index a9f60d0ee02e..7c732414367f 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3127,6 +3127,7 @@ static int dasd_alloc_queue(struct dasd_block *block)
 	block->tag_set.nr_hw_queues =3D nr_hw_queues;
 	block->tag_set.queue_depth =3D queue_depth;
 	block->tag_set.flags =3D BLK_MQ_F_SHOULD_MERGE;
+	block->tag_set.numa_node =3D NUMA_NO_NODE;
=20
 	rc =3D blk_mq_alloc_tag_set(&block->tag_set);
 	if (rc)
--=20
2.17.1
