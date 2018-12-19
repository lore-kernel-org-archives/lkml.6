Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17EBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6D2217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CNZl4Hpe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbeLSSkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 13:40:53 -0500
Received: from mail-eopbgr700135.outbound.protection.outlook.com ([40.107.70.135]:1625
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727171AbeLSSkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 13:40:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zVnuwNqYXEb94+524iZl66MloOnfn8CbOZSVV14ZTU=;
 b=CNZl4Hpewu5fL9xSBDZ4ONZZydhdnIb2HUgBj9T04CGJPBEn/y6ybJ6cvTwCFlbEf8pBfmnHUf8H1N7dfMzO4trVRrAbpVbzDnNpY7NFEpuBlspBtONil7U9egVpRHJlqDMqNfcF9h7sjhM9V6ckLriY1MQ4+SL2uGW/DmQOjz4=
Received: from BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144) by
 BN6PR21MB0129.namprd21.prod.outlook.com (10.173.199.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.4; Wed, 19 Dec 2018 18:40:49 +0000
Received: from BN6PR21MB0466.namprd21.prod.outlook.com
 ([fe80::d516:404c:b10a:bdb6]) by BN6PR21MB0466.namprd21.prod.outlook.com
 ([fe80::d516:404c:b10a:bdb6%3]) with mapi id 15.20.1471.011; Wed, 19 Dec 2018
 18:40:49 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Long Li <longli@microsoft.com>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "emilne@redhat.com" <emilne@redhat.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH 1/1] scsi: storvsc: Always use blk-mq
Thread-Topic: [PATCH 1/1] scsi: storvsc: Always use blk-mq
Thread-Index: AQHUl8pcTX2j7yQIskug7vKP1nmz5w==
Date:   Wed, 19 Dec 2018 18:40:49 +0000
Message-ID: <1545243282-10573-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR06CA0004.namprd06.prod.outlook.com
 (2603:10b6:301:39::17) To BN6PR21MB0466.namprd21.prod.outlook.com
 (2603:10b6:404:b2::16)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [131.107.159.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR21MB0129;6:YxN1lmiJKk0YEmyQ/KdQ2DB9YFYg8yzg5YWX7wt1MpWLa20uw1+DiJvr+EsPcRkAmWFI9agxrqMramZnskf+knJ8E6pUdX7peK2M6DjmLznvLAdlFEEhRFSb8rYULNEhi9oje5IAfYm+OhBM2z3CAF+kzsL7gzzAjD72wQzAwIBW3Iv2dxB1FeKAtv/hp6vDY5no9MM9AyrlNmmnQixzxKdXyc7G3DGqYLwFGQBk0m6CWesVtJz65uEbKob5OeZVkQDMvLSxAgim73vAW2Zr+4BSWsTaSUb0pKQi6f/ZHTR9j/o26GIxb5soQbDW1rxLhKDRY5gAvZMWch5maAB/KUDKk0AXh/efXaETL59lP8aul0kNB9id92ZWrUq96+S9VUNEC7HkHRv9weqD2ZpOkzZaFcn3N32gtABKKqKYXokj6cjg2XCvkVF6O3Qz7bzC/YacJ66GDMv7x6tPVsaxHw==;5:TGVgIEzsPWnlgY1ORC25epD4rn18Nl8unL6YYLt1DulIb68AUAzJvLmyuwtHMCt+TAt7E8FitkdrPYaLR+lxUpR5ZXkuzF4X4BjNoqbuGn4AFvJ5WLJQVUQFBJAvrpfnjFM1A8fL9mUE0v9erIHFuM/A4eVBMmPmKlz3LWA+EtU=;7:OSqMRK2jN8GoI9TmIam1nXRvhvKsRNubyRQMP2iC6KXZF+5dGhQthzYhuo+F4Hf1G5e/myrRycwDznGyfrYvm+RfdWismPCUGdBwR1NNfHLB0oJxaHwd0EYOS+yF64T0ciZ27iZuEGZ51v/3cmwpUw==
x-ms-office365-filtering-correlation-id: d558c43f-53bf-4e17-0d41-08d665e17ebf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BN6PR21MB0129;
x-ms-traffictypediagnostic: BN6PR21MB0129:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-o365ent-eop-header: Message processed by -  O365_ENT: Allow from ranges
 (Engineering ONLY)
x-microsoft-antispam-prvs: <BN6PR21MB01292947E4E3884E075CAEA1D7BE0@BN6PR21MB0129.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(8220035)(2401047)(8121501046)(3002001)(10201501046)(3231475)(944501520)(2018427008)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN6PR21MB0129;BCL:0;PCL:0;RULEID:;SRVR:BN6PR21MB0129;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(39860400002)(396003)(136003)(189003)(199004)(36756003)(1511001)(6436002)(99286004)(6486002)(305945005)(4720700003)(52116002)(14454004)(7736002)(2906002)(6512007)(102836004)(53936002)(2201001)(66066001)(6506007)(386003)(26005)(107886003)(6116002)(71200400001)(71190400001)(486006)(10090500001)(186003)(81156014)(2501003)(86362001)(316002)(478600001)(10290500003)(110136005)(25786009)(81166006)(8676002)(4326008)(86612001)(106356001)(105586002)(50226002)(5660300001)(22452003)(3846002)(68736007)(8936002)(476003)(256004)(97736004)(14444005)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0129;H:BN6PR21MB0466.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ms8fvoJOE8gKAs3zg6GCGGGjftaPCTr4y49koTeCIYeeTfkFXNnttPiRtR0YFwEny8Xy6YTLIijlFvGUHZAdnfSoHPKzFTeNPJfGywYEbSN2pXKuxsChsfAwaxywbCMYc+PHgvxdSLthMS01a/VnbQIxbP1gKTjJMxbNlssmzRpFtriDHeFRAoMVdUmuGOf+O34WL0JJmSadt/FAnrALZQB4ipwRSj7uTfeFhKohVhofxBLbP8wYVDqzlnOsAe4N/7eocnzTO4XCl5Vi5ppxnZr9VXPjlxIgrkM3ZoVC2L4RhK+FTJMctBh4x/Ek/geZ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d558c43f-53bf-4e17-0d41-08d665e17ebf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 18:40:47.8743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With high IOPS storage being increasingly prevalent for guests
on Hyper-V and in Azure, make blk-mq the default so that the
full performance of the storage can be realized without having
to tweak other configuration settings.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index f03dc03..3dbbd14 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1703,6 +1703,7 @@ static int storvsc_queuecommand(struct Scsi_Host *hos=
t, struct scsi_cmnd *scmnd)
 	.dma_boundary =3D		PAGE_SIZE-1,
 	.no_write_same =3D	1,
 	.track_queue_depth =3D	1,
+	.force_blk_mq =3D		1,
 };
=20
 enum {
--=20
1.8.3.1

