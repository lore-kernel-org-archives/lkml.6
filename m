Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D435C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D282083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RI2wo+rf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D282083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbeIGFP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:56 -0400
Received: from mail-bl2nam02on0092.outbound.protection.outlook.com ([104.47.38.92]:43727
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728038AbeIGFPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBqlNoYHRflk/qb9V74/VGC3Wy70A2vsnxqeqmIw5E4=;
 b=RI2wo+rfXS7MmnmnqOwUezMW9J2ug7nJVe31+BJnMa1/7o1jVsyQ/W0miav7q5vHzRvflQbcf0Q44ZtO/M+rIDsiSzXjtcNaXxe/mboKjJAbJstRpA6kYS0z2/UVOtm9YC6n6Pa96B6QgRkY7ubzTPZExOa0DPir/Xt1sh6e0/M=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:36:56 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:56 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 53/88] nvme-rdma: unquiesce queues when deleting
 the controller
Thread-Topic: [PATCH AUTOSEL 4.18 53/88] nvme-rdma: unquiesce queues when
 deleting the controller
Thread-Index: AQHURkLS4CVGd25HokezokRWI/ZtHw==
Date:   Fri, 7 Sep 2018 00:36:31 +0000
Message-ID: <20180907003547.57567-53-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:+U8YybjU5WXCR5sC/T7f2r97MBaAYhBEjswmydnzJzen3lcsh439Mlj2AGjCo40+hyMROs901066GIjxNKjcbxhDHDko7WT4JbnXPe6Lnysm3GeM20TDt7PvgVmDHSr0arc8nL+nNfOcKbz1xEoKsROE/sgZTXrQfoP+jLaY5TmCRpuvbqtmKf50iv2A+gKRweUf+Z5VBMRoR7zTn8TZWLB3aVE8vQAaPNAPU+JG9Y9C6UxRVE4EvqMZi8HisUtPFEjYEMVfiGqmaG2EBL6vfXt92Z30CBjvEWSZ3ZGvd6cEAlmSA1Wr5PkaRZ4R9+MMPoDm5Hk0H2HoCDtB6aZaUPzE0uw0Uwa/5lrU1ozOXl+fN6qgRka6m+QnFCbECM0H6ZYSoUsfjWmEERgJD8EbEHK3LORUyQ/b1qgq9ZRUCEsHbLERr6x99t2SYBtLW08b3dY20Wzf8NAgeqwtFKefhw==;5:efWudckLHBdxXfpbk+UTUOHNUw4jeEkSsvubA795wDgkcXAy4xFl+1gA1oWbXHRpxYrwQMZNjspZQYMvzE3W8aqTlCCc/vED/hjzhudxnFUjpn6O9UzpHGzhfXu+1uORPUe+aZeWF6BsFAgHe7O1qo5ctLtB//gwJCfMZWtmt+I=;7:FleKJ/7A4ta1yCQbnweOFYBcU3/8jQomzEn0WQ0IOFGJtYXjKkIEFjVIl0hpCq3N7FfPCR17Kqo8F9kMkQ3kbFslpPWixFN7FTqPY23v4wGg9vHrovfPacnDW8Bng/Fh96hmmK67j9cpdgj9m1n6dgVvyNhNQAOQArB1IA/isjD4s0TbHjPOSUlsCqY75r4hakeUEbOapyuaFdcKtEwp6Bhye3xt/v2GYY3H8tgC/NiN/s+fFL3Q8ZBGO/LEj9N6
x-ms-office365-filtering-correlation-id: 8f1dd7cf-7a63-4de6-4482-08d6145a03e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0773655AF66EB37E45DD7B55FB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(2616005)(476003)(4326008)(6666003)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(14444005)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dlZ5p9Y5nHXC8d3uLou7WJuFgPTLfNGEhqnbEt9st+7klPw8SRlYjOdhLQ8trmXve6Djv8WCwtzc2c9VAU51F5A5zid13YFgdRUWXhbhI1xUhZrWI7P1fmDJMbhjAId4U6WdNz75Vy8Qh/UwNSYF6Nl6zKq86uG491DTm2h73Djyf4UpCX0V9ZbdpOJdNn8hmxGeJmw+JlowYoDQDiYy86u6p7gCY6uPemvr8QJiyRJvKzgdr7bRufjosobSjp0IrJOT7EOdIgEopu8ahtXEL0ZgdzgF7lT0YGb/U1Wm31lx/MzSEtNYRqUevdiwTQaaJC5Ggp1z4Mr2NGQSpazX01IDmv5p1ykNuF1v7hze6Lo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1dd7cf-7a63-4de6-4482-08d6145a03e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:31.2880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
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
index 66ec5985c9f3..69fb62feb833 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1741,6 +1741,8 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_=
ctrl *ctrl, bool shutdown)
 		nvme_rdma_stop_io_queues(ctrl);
 		blk_mq_tagset_busy_iter(&ctrl->tag_set,
 					nvme_cancel_request, &ctrl->ctrl);
+		if (shutdown)
+			nvme_start_queues(&ctrl->ctrl);
 		nvme_rdma_destroy_io_queues(ctrl, shutdown);
 	}
=20
--=20
2.17.1
