Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BFBC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD0720861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WOFZ2uzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD0720861
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731405AbeIGFVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:21:00 -0400
Received: from mail-bl2nam02on0097.outbound.protection.outlook.com ([104.47.38.97]:7296
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730521AbeIGFU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1uW/J6Osz4fEsX3Ue8OJ51zRPdC76+rSSVlIcvK7Co=;
 b=WOFZ2uzZk1uvwMYA0GsECVmB8XOH5VH5RRN0Y/TztYDRE6mADmAHxvLagCm5stb/+LmV7tBqNLINlEHlahFO9gLSBVwkannUWbg1tJ8zmB6JH6oagzx68EHeNuFPhzN5eBSQTf2Pc+WWncdjn+obwatgQDT/5sZCbQTIsSV9hDs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0631.namprd21.prod.outlook.com (10.175.115.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:42:46 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:46 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 17/19] s390/qeth: fix race in used-buffer
 accounting
Thread-Topic: [PATCH AUTOSEL 3.18 17/19] s390/qeth: fix race in used-buffer
 accounting
Thread-Index: AQHURkNBY5f3C9JwnECz+Jc/nq69pw==
Date:   Fri, 7 Sep 2018 00:39:37 +0000
Message-ID: <20180907003923.58019-17-alexander.levin@microsoft.com>
References: <20180907003923.58019-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003923.58019-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0631;6:KDFj78sC8ZsZQIaTVsI0hlLJWMzMLQv6ixNGE8+GnBGTZduQ0dfxTZmd9cXjL4BPbRArczLYzdN599FQYqQIgAcGvFld31fAM9NenhXKBBf8JaRtBD+cNPhG1WA3OqADBGNaoKr9NruSJQFL2AnkktudikFENMOFbX4dkEth/BLXGyT//paFS53hMQCOBAuDkSdA+edVlsQJDaAHnwlvEb6tl+tMwG0C6urFGc55glNdPn+k44wXSCxb7mJQGv3dp9SQbgDpj0G+C34Dz8G8Vkqz8xs0wFv5c64tkO/dphspoGxhY0/X1RjfYx0GpZ6gYzmYA/I/QBtCrxU4r9R/u80GmiFZjrbzzr1y21Sb6681SIHcIHa0rk3qGsAp5a5flwraImtPxfIkjlhyVHYzkrNd41EiSxlfOvAca384sSIHrpf62TiEsiqy7DUGMeU3M9OKUyhHAjYG5qlp3nogtg==;5:vP1oxBFKs/kSpcuK4BF5MgAIFj2I9+OeaRbEP5dvi09uVf5TadCyQ3lVeRjypWO4PwhDQKG7YV4dZmlD5LF5GhoTYgtiadt8UwmpzwN+nRth/euBC283//Y9CN3wQY1ky92vuEfxROh55o8i/rjV6xWNK8P3m5wjbbJULHWoR0Y=;7:N3l1kfAUy2ilc+6DglA8KZnU29EX81xzfcYDaV2ZnVDU+ikH031qQChQbi9JdCsB6ciYJp5rn4G77eJ8aT1OafO3e8eKqIZZembuVgGtUIQZPLw7oood6FsBxRpELIv/QtgnH8ebLQLmyBiw91aDgXz9B5dDTMbSydLBp+laU6jB2qb28R6yiCascORbZF7aIpdv6iUMcZaKF7zM8cQBy8AyZAifFI2tU12TXOO0JYSKL8uNUoONR5HGWdTeLZ9W
x-ms-office365-filtering-correlation-id: aa0d8966-d097-4c0e-03a8-08d6145ad47c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0631;
x-ms-traffictypediagnostic: CY4PR21MB0631:
x-microsoft-antispam-prvs: <CY4PR21MB063192514188871DD0FED66AFB000@CY4PR21MB0631.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0631;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0631;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(346002)(376002)(396003)(189003)(199004)(8676002)(72206003)(5660300001)(26005)(66066001)(6486002)(2501003)(14454004)(8936002)(6506007)(81166006)(36756003)(97736004)(10290500003)(81156014)(478600001)(22452003)(6346003)(4326008)(217873002)(10090500001)(102836004)(1076002)(107886003)(6436002)(256004)(68736007)(106356001)(14444005)(110136005)(486006)(11346002)(6666003)(186003)(6512007)(99286004)(2900100001)(105586002)(7736002)(305945005)(6116002)(2616005)(3846002)(316002)(5250100002)(54906003)(2906002)(86612001)(25786009)(476003)(76176011)(446003)(53936002)(86362001)(575784001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0631;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: /fBlH0ujHqi2f7y34mZSV/NMf2X56gpywMB/IOUcpAH8DATWGfOI5UVyYduRI7v+VcN0fXB+Px7IW3rtD1GC/S7E49Dcm21hE9XlWORQwNLeVES3vXEhlBkwLv+0twcmpdfio5dWjrA9SSLxLSSbZec+Pwwo9NjvbEB42jkg7fO+K0eBCiwZMxqrUk1h42R0MNccp3v3xj1WJVXHWIQRUdCSTd8EG1pNOF6eFQLGAfspoUOJ9ICoCOwE7DESuFaMwTc02ESr2WHE0iJmIr8Rgk+TJbX8v4MbzIoWkONWOL36JGGKkAjz19uStZBwEvVI497OUwRXnRoho88Gid5BesCkS1JWJll+6vM+wHenpTw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0d8966-d097-4c0e-03a8-08d6145ad47c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:37.6707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0631
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit a702349a4099cd5a7bab0904689d8e0bf8dcd622 ]

By updating q->used_buffers only _after_ do_QDIO() has completed, there
is a potential race against the buffer's TX completion. In the unlikely
case that the TX completion path wins, qeth_qdio_output_handler() would
decrement the counter before qeth_flush_buffers() even incremented it.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/s390/net/qeth_core_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core=
_main.c
index 906e8014ebb9..595c140cc79c 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3489,13 +3489,14 @@ static void qeth_flush_buffers(struct qeth_qdio_out=
_q *queue, int index,
 	qdio_flags =3D QDIO_FLAG_SYNC_OUTPUT;
 	if (atomic_read(&queue->set_pci_flags_count))
 		qdio_flags |=3D QDIO_FLAG_PCI_OUT;
+	atomic_add(count, &queue->used_buffers);
+
 	rc =3D do_QDIO(CARD_DDEV(queue->card), qdio_flags,
 		     queue->queue_no, index, count);
 	if (queue->card->options.performance_stats)
 		queue->card->perf_stats.outbound_do_qdio_time +=3D
 			qeth_get_micros() -
 			queue->card->perf_stats.outbound_do_qdio_start_time;
-	atomic_add(count, &queue->used_buffers);
 	if (rc) {
 		queue->card->stats.tx_errors +=3D count;
 		/* ignore temporary SIGA errors without busy condition */
--=20
2.17.1
