Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40E3C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38922083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jTbkEI9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38922083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbeIGF3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:29:38 -0400
Received: from mail-sn1nam02on0101.outbound.protection.outlook.com ([104.47.36.101]:49984
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729307AbeIGFRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obTGJ1WnCfyUnRLMah/aSsBWn7vu9jlfjGRqe1atGOs=;
 b=jTbkEI9CUO/brPMpXTrRhwC4cQFxZ4o7YQGtvdRwbSgJaIO2GB1BxkxQFSdDDLImfvN2CM2V9RTeryJwiy7k68jc97Sgbjq+roNQeYQT73l5L7igRXG18oZKh8v2P/Mk2Lexy0MvdL3ys6Gpxsv5MQ76ml5DiSeC5pEzggevwmQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0840.namprd21.prod.outlook.com (10.173.192.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:38:58 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:58 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 40/67] nvme-rdma: unquiesce queues when deleting
 the controller
Thread-Topic: [PATCH AUTOSEL 4.14 40/67] nvme-rdma: unquiesce queues when
 deleting the controller
Thread-Index: AQHURkMChtvWyN92/kimFfoHnZuaJw==
Date:   Fri, 7 Sep 2018 00:37:51 +0000
Message-ID: <20180907003716.57737-40-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0840;6:3Gb+mopoWEMOSGrIJEKdI9YRCSOti3iLQvAvvI+8bmgri2wHXR1fxSKL3mCQFQamGKpFPidTIqpvxhY+ItCSraR7E0zs8BaJjH7Z8S1d4l57hIG8XHH7QBM/ZpS1QBrnl2Zjv34kif3jneGijt5yZ5jk41Awy8KN2bcvj6N0Tf3v7uNmGTaXchiI/NNEtP0m6j9pZwxZ2GawvbGn80D3tsg8mcQuwTXRznpH3VCDx6rWXcsPlqbxa/mCKe1KyFRqfNaGqcc9B8+dpnlkaz/o7kFld5gNmOcouu2f2LaPy9lekAVtExTy51rsNWCcWy3v30zUE3/WstmSxuCXznfu3lS3JYkULXbQC177RKWjiFpZ2vkg/xlFIbYPmr7iNkP/PWSQuSngn3UvRpGDGn1eh2A6KIqsY8CNRMoeY1ROeRnUcCvQCHWJee1gTD/1JYp5bsnJjJO549Nu2EP5v8DOMA==;5:DWEpKXhgnTZLXN+4wkG4RC56gEaXaP1H5dcXVM49MqOW1ndhhFqI8h6Po0eykZMzCzAxuMwak8YUcq0wvL35va4ZfQpEgttHJzWThWYeuq7gebys5/Hz5WC501zctMLX1UNvbSJ8fVwqp7hBp2sV/IWHliIS2M9OAJ0aNHn6MGM=;7:5aHlAKn6DJbI4RvqVIoMjv8U/DkIaibpYdywYrba99entKQAWZuD6Hv6SwvZM1KJe0wyFJ/c9mTko6q0NCdzwLfgE0LRnbDXmUXIUTQypT8VDKKaH3/9gLPlW5kYK6JVvPGj0Wa6WeVrxDasmqOJqtF6/xfcSOFTHhVJksCjWpzGb4vYoRyiYIkfUElqxASVQeZB6Y3Pypx48DluN30MINx4Z/Z4kqUwh26zWfAJqg4GMtA0SRK9M1MJd0fsxB1N
x-ms-office365-filtering-correlation-id: 12b0fa3f-b74c-4750-366b-08d6145a4cef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0840;
x-ms-traffictypediagnostic: CY4PR21MB0840:
x-microsoft-antispam-prvs: <CY4PR21MB084020E077A47029A09B6AACFB000@CY4PR21MB0840.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0840;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0840;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(39860400002)(396003)(136003)(189003)(199004)(66066001)(186003)(99286004)(26005)(8936002)(76176011)(102836004)(81166006)(81156014)(5250100002)(54906003)(6506007)(110136005)(11346002)(446003)(316002)(476003)(2616005)(106356001)(6486002)(86362001)(6436002)(105586002)(86612001)(97736004)(486006)(6346003)(53936002)(6512007)(68736007)(10090500001)(2501003)(1076002)(22452003)(6116002)(3846002)(36756003)(4326008)(8676002)(10290500003)(2900100001)(25786009)(256004)(14444005)(305945005)(72206003)(7736002)(478600001)(14454004)(217873002)(6666003)(5660300001)(107886003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0840;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: OAshr4LaNJRpVrGU3UdZznooBVLffg0u0DfkB8pz04WOwRMYUEkYTXws9oDiZs6hKiZRC8KbC/Fr25Dcb63DqUtTWCLxIbSMYy86MnUnQeugjB4CljtfK+e9RCn6FAFw9Z817hFwiq0oL8N1GpLLjiX0w648x2+0SJm+WzAkYfAK7cFo/KmHR4PdcxMp9BT8vjUZdKaxNH3tTWBpDqiRFxnB5Rhs2I9OgnsBL+E8fBw2S6BqkwBn9/pjJJX9d3E3Li8tfClx17+1alG71ggNhgxhlSOJK7MwOBEg1QssYxiJj+O4KdqXcY8rx1Ti2PQkAKj6vNJIAVCtnmRevTqBKniCFs9fSMJ0by7yXo79lYM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b0fa3f-b74c-4750-366b-08d6145a4cef
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:51.3349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0840
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 90140624e8face94207003ac9a9d2a329b309d68 ]

If the controller is going away, we need to unquiesce the IO queues so
that all pending request can fail gracefully before moving forward with
controller deletion. Do that before we destroy the IO queues so
blk_cleanup_queue won't block in freeze.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/nvme/host/rdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 48a831d58e7a..9fffe41ead50 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1728,6 +1728,8 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_=
ctrl *ctrl, bool shutdown)
 		nvme_stop_queues(&ctrl->ctrl);
 		blk_mq_tagset_busy_iter(&ctrl->tag_set,
 					nvme_cancel_request, &ctrl->ctrl);
+		if (shutdown)
+			nvme_start_queues(&ctrl->ctrl);
 		nvme_rdma_destroy_io_queues(ctrl, shutdown);
 	}
=20
--=20
2.17.1
