Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFDFECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D174214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bjT4jE+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D174214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbeIQI3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:29:40 -0400
Received: from mail-eopbgr710114.outbound.protection.outlook.com ([40.107.71.114]:1680
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730193AbeIQI3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=br/hESsQ6LehJSj4L/zA0gVom5taHqtZ924ktzd/bXQ=;
 b=bjT4jE+kAXC5kSvk2ZzzIdMQ+1HF8X+x+YC6CSzPyKGrMzjYjdUQ/jCU7c09ap/bSaYoyWYNqDs5IMca0YCzFr3QNzqoELMx9IpsZ/2qSd0okTR3T4xzGZvPH5qJLwAtFE60JasiMwsR8m7EPKdyGAQHssBytIQI+XPE4dgy8j0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:17 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:16 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Vasily Gorbik <gor@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 44/87] s390/dasd: correct numa_node in
 dasd_alloc_queue
Thread-Topic: [PATCH AUTOSEL 4.14 44/87] s390/dasd: correct numa_node in
 dasd_alloc_queue
Thread-Index: AQHUTjLrUHZPSTOFMEiLxQLhHcOm0g==
Date:   Mon, 17 Sep 2018 03:02:51 +0000
Message-ID: <20180917030220.245686-44-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0776;6:aaQcYVIjnnw29aZTMXBe/CH0rmkgPz93VCqId1IutCANGbpy4xASbKI2hWJvpmnJDcU3Mw+IEdtYTzo0bdp9gC20HL3wiIX/82WpgIUVqgTyTM6dPSeFTQgO+mZ+1mw1r6m7AlFWDtEu3B+2K0pVlkrItc8YHnGBTJlf0aEKIbEVWSornXOls34HHYv4Z8C34Xfm6QrPKI5fU+zCCDYpOKHdxC5xLNVaNKJ6Hl3ECikLssR1FkLXxnaNggUxm3Tvio2EQ8+SjhAhdMpsunyqn0HSzPa9ez/0HO/EqpiQ8KmknGbO6KYIiImwMoHg9GiDMZQvuyi5G0Oi4Ugwpt4RP+EJNxrvxX24298am8etPNZxEIJe/qXtHNHS2HliZeJDHYD/oDiyXf2bKm15sJMkHqYI6ncr5LFymBuGywnvF1yfG4/1qiW46Donj0sKOMBRxF3un62hWYj5LhLmM8zXEA==;5:u2M2pznnWnFxJ4Wi/2fCZaNmFtepkpcz6Cyz+Uxy8/p/YXFqHH711rphXJ+qli7sXJexSAWe83mBKnSN6AXoT4PNUQvz2UD/xUEB0jdBxA0HjZcSs7rRqQ6Hw7WleqME95RdGgkKlfhfQdalLddQ/OSUVWHO7bZ3dltrm5nqUQw=;7:TNiIMGtOy8mHawsAQafvGMzVSwiZntffXH4O+7O29p94jfIKj1+vfCl2G2Ljy2dTEGanP1LPfgy3V4zR+61QVP3p3Pf2hpZvx6zdqUdpEGkE4JQKhnoeGpXjF9hyEU+BNhn+JfaaZT0IvMBjJkM4bGCIHrsHfsHkJZBzpYy/Pj+2MDcieIe5em5MKmsU0/iQ2BxZNydinqlff2xkFoEHlmh4+KP8a2+PeDKweDn7xlCtsjeSO3CQCaRWITybYh3C
x-ms-office365-filtering-correlation-id: 0f84ad9c-bd54-4c8e-2af6-08d61c4a4162
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0776;
x-ms-traffictypediagnostic: CY4PR21MB0776:
x-microsoft-antispam-prvs: <CY4PR21MB0776C00DFB9F209D760F6CE6FB1E0@CY4PR21MB0776.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(104084551191319)(190383065149520)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0776;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0776;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(5250100002)(53936002)(72206003)(14454004)(102836004)(478600001)(4326008)(6346003)(2501003)(25786009)(6666003)(10290500003)(110136005)(54906003)(6436002)(66066001)(8936002)(316002)(107886003)(76176011)(2906002)(217873002)(6116002)(3846002)(22452003)(14444005)(6506007)(486006)(5660300001)(7736002)(2616005)(11346002)(446003)(97736004)(476003)(6486002)(105586002)(81166006)(99286004)(186003)(81156014)(575784001)(2900100001)(8676002)(86612001)(68736007)(86362001)(26005)(36756003)(305945005)(256004)(106356001)(6512007)(1076002)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0776;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: j8FlqikjyENZt0TlRnk6A6srRq55dbYq3xSuzOzI604euZrSU/F+MwXdoc0PppaLTdO7wOxLRiqcuhAzazNX/wYNlpWtWC3C6RkXc5LQQQuu4LPaoSF2M1HC1TqPHX0jZVIdqSBx9ufKoLiGKpOH3UPIhndY4Y2y2675COWXnVCY02LFTBglNFLWVAoTgkFgcRHFC5WjisFggVyRAjPEBFk3vKyVr2l2ZniNY67O9ziKReS/5yTax0cpk04XTDOJyuT0SOQwa1VkSWbRoQzgbx9P+ehqsh/JUVnApAmWpp4y3G2KFvzw/qRS0JckxLrgHil0PyjaoUEETqV5D5XdHYEPCROaV8iOjemW9wkNZPA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f84ad9c-bd54-4c8e-2af6-08d61c4a4162
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:51.3218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0776
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
index d072f84a8535..92c4f5180ad0 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3190,6 +3190,7 @@ static int dasd_alloc_queue(struct dasd_block *block)
 	block->tag_set.nr_hw_queues =3D DASD_NR_HW_QUEUES;
 	block->tag_set.queue_depth =3D DASD_MAX_LCU_DEV * DASD_REQ_PER_DEV;
 	block->tag_set.flags =3D BLK_MQ_F_SHOULD_MERGE;
+	block->tag_set.numa_node =3D NUMA_NO_NODE;
=20
 	rc =3D blk_mq_alloc_tag_set(&block->tag_set);
 	if (rc)
--=20
2.17.1
