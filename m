Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE903C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D65120857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iwonzaOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D65120857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731295AbeIGFU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:20:28 -0400
Received: from mail-by2nam01on0091.outbound.protection.outlook.com ([104.47.34.91]:29984
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731173AbeIGFUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epmufkZLX8cV4AfoYa/a/QFzH+OLfsUhZBKs2/xNbUE=;
 b=iwonzaORXajn2r5DPnAQ8sBF7CFJg9NnJ5L6JUEpS66yyU5aMn/Uk81TKWMd5ouVyJqNx7kn3Qh5LkcC3etOanM0jXq4m2VNZ/hlWP/Vhz5LDQbo4b0VcteqE/5CXn5FDZLcqfQgL2nEoRKsUDvD9rZmo/7qp9axUZMMeZ348BE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:42:06 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:06 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 27/30] s390/qeth: fix race in used-buffer
 accounting
Thread-Topic: [PATCH AUTOSEL 4.4 27/30] s390/qeth: fix race in used-buffer
 accounting
Thread-Index: AQHURkM1rA85eaUASkuk31gNJDwZiw==
Date:   Fri, 7 Sep 2018 00:39:17 +0000
Message-ID: <20180907003853.57942-27-alexander.levin@microsoft.com>
References: <20180907003853.57942-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003853.57942-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:39BFvbA/irZmGFj5PGm1EE6Vq7v4ERM9VTuSS7V3j1wBE7skUVqYWX7l8BozkDLfzr0Z78EFvfZe744WZeECoGgb5JOAlEh7fS4hcdY7yiMDnyFyJWEilURq7lRhTV9s+zx0cqnGPMuYVIxr4AwHKJvDJsl2vMfM5b17T/l6+x+DaaRA0YMYSb5IA+pmtUQ0feNHI0Sjl3iLs8eRgqlRic9WwmvwOuX4q9m+nhxpj2Fkh4quxiD7yI2jHh5lAQpKz2XRk0bQN9ZA493EeH/aJnnOIrVVw35ZEr53J/KT6LSQZkSDB31IyR/N5+9eHBI5melNwQWHSkcFw/fb7wtmWF4u1R66l3x+uDmbEGmkal8z5q/bngXY1Wd/NKDKYUpo6G1/qeOH9EYUjSHwxgmKKfV8vdI1yC3dgoft2j5LQYtPmKSDLaTwUwQQaxYeWETkwsHqbA6aTVGwmPAcJiDMeQ==;5:IbG8OJzSBDXXF1j3sHPvh+PO/bj5Zz6W0S9BmXfFyYo03j52Lo4KvQqmupRUxHt7c2U5C4jFZ6TVkg31/ApT0w604VlV2nd3ExCLU0EwIFj5YVS2ECFI2tz3n2XC9JJ8KgUdEsZ4RiuIB34K+3QdIiCvkjgAR+h6FRSiljU9Q78=;7:f1+a6zc3Dd3B3Eyzq4VAQTxMgsVdyfI+t+JeCU79df56Erdg+wEzKlwtK1uxdMfw7md0FrUIBwQ7p76Efu5oqgWs7sZw3mq+8oPJZU08FI/M8LigKnpSIERgZmstINaNYS2XDYrMzfEXU2VPEpvm7zoouyFEjxoKomK12uv7/F8HzNH43T8gM4w53wWWwSyrgL9aF5dClREM5HLadqfEIaPhijI/pElNRo7p9496JqASbQ2jpkDgDcp9si+KsKJu
x-ms-office365-filtering-correlation-id: 05349a1e-ff0e-4a34-366e-08d6145abc8e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08223E8B56AC7F3CA16BC991FB000@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6506007)(10290500003)(478600001)(102836004)(81166006)(14454004)(22452003)(6486002)(26005)(53936002)(186003)(6436002)(72206003)(2501003)(5250100002)(110136005)(6666003)(54906003)(3846002)(316002)(6512007)(36756003)(1076002)(97736004)(8676002)(81156014)(6116002)(5660300001)(10090500001)(76176011)(14444005)(2906002)(256004)(8936002)(2900100001)(99286004)(66066001)(305945005)(7736002)(486006)(217873002)(68736007)(4326008)(25786009)(476003)(106356001)(11346002)(107886003)(575784001)(446003)(105586002)(86362001)(86612001)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ihdDolC3cn01cc/pwLV1KcCRZc6yhhMOqwRgmml6fvVzy1H+8ZJS20OqApnGRdzuQLz/HSyvFIiwlhZFykmSxbHXvvryXihF6GUA5xLMfPmNo61wY3dQv5WQAWcQXtKaQL45EJI43s9yryjXomZY46l9/XGSMmfvKbPldaqZlacxqDC2Mr1jagnyFg0Cjiy0ecMvTy3gdbys6UoQKxfIPSTBCYM1Flj+t03hHUzxf1nJU33WVAuj/o/rdb5ignnXmR6D2Xpsh/HeOTS7Ywd+uwmwIyCslVCR44sQx1IbmBIGVIKZOxAi6Ba/bRgpvzkSB/YLXbFfbbvdT17iMis+Q/kQLBSnYJ4BRdtwySPLz40=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05349a1e-ff0e-4a34-366e-08d6145abc8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:17.0403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
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
index 95c631125a20..09ac56317f1b 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3505,13 +3505,14 @@ static void qeth_flush_buffers(struct qeth_qdio_out=
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
