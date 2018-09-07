Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0918C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3212083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fihPDhv3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F3212083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbeIGFRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:17:25 -0400
Received: from mail-bl2nam02on0129.outbound.protection.outlook.com ([104.47.38.129]:33184
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728031AbeIGFRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5iMFgLrKdMkJod0kv/kOlitXYB4USaXC0gs64IKoC8=;
 b=fihPDhv3cFxhJOxMkMGIfklO9rNf0djey3kfAPWVjamxzJLuHZVvNq+vy8WaCPw7N35Tl6O+s2ocxXOaXWmRY3McZL9cVZkirLkTiS6A+r7Lsaujlu1+zHGm8UoleRfUP8hUytv/8sYw260jK9doEtZGjStQZTnpeVwbBxbS4/Q=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1143.1; Fri, 7 Sep 2018 00:39:08 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:39:08 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 57/67] s390/qeth: fix race in used-buffer
 accounting
Thread-Topic: [PATCH AUTOSEL 4.14 57/67] s390/qeth: fix race in used-buffer
 accounting
Thread-Index: AQHURkMISD0gmpnUIkKWBDwFWp9Z5Q==
Date:   Fri, 7 Sep 2018 00:38:02 +0000
Message-ID: <20180907003716.57737-57-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:Ob0CNpTvbMEQQ9MKZlzy9x7u4uHpu17jZdVuATM36hJ9xXF6D6EQSapwH9rqiQB5gOge/CemrPKzXteQy6Wx4OcZ++lRf8UMf9LJPEsH+Wdgl9q3Os3TWJtmVBKLETKsz7Bf67V3JVDlYoGVCg/466oF4sEBO6Ba0Yha6rlKmS5JcLn4qlEtUkEcJlVnRyupQ9/W/YKq0Nt4GIJ9oOJ+Nbm2AHIx4YKoMd4liKhW43sdW1qyzdfVJI0tsGMVPCKLQaC3KetDwm3kbNkENlxlFe66Zj74qukoPfXuw8I23SvLMYTrdCio2yHMUK9QXRAR+f6eOOM76+whoWmFDUpvnQBpoRYDZI1zuEJCX7Qy+rL/0D9oIazC0gBBoEmMB7I/F40vORcdPFu6N5vY+jI8AqDL7AGhFtVma76FYOAN3EvCOu6V705mra9D5AkDYnC+kwhXUiJBIAu2+Uraerh6BQ==;5:JTd0evklOKgLFeicX7ymruHoOG2cgJEMVypDMFEGyDXYETLwTt5/8VwlHzBmgWsWA5TfwAkWgmSdpCBhxOCohMRsPdLeg1HJ9B2/ztD2YNu6bWTiH+LEla8b3S+jHPoHM6tWqbHqjVb+/FXR7tRvzQsJMEqNoExZcv254F9/00M=;7:R1wd03jdgIRQhBxKQSQstzueQ4C+LMCq5CUYxZW2eFwN1U31d5siAiedsB4OfiAWE8JY7Q1c5+tuq6fql6vepOCmVQoKXz/Ivdgs7CfPZnAf1gw1qMzbQnmpAMqNCIcA7uZbnR75DgT0ag+qNWmsNDgLls8eG+CU03sM+TyATBXmNK7O1REzjpgJ7dKvKw+U++JrAD4e6vds7yCjjzoIaMkci32QggNbVwQC40qC1c7R8fvpCYgyv5/LAikC9Ajl
x-ms-office365-filtering-correlation-id: 132386b1-82e1-4e60-b655-08d6145a5265
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB07575EA86F1F955325CECD91FB000@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(8936002)(3846002)(81166006)(86612001)(6666003)(5250100002)(81156014)(486006)(99286004)(6486002)(106356001)(10290500003)(107886003)(256004)(14444005)(26005)(11346002)(14454004)(446003)(76176011)(6346003)(5660300001)(10090500001)(110136005)(2616005)(66066001)(186003)(476003)(72206003)(2501003)(54906003)(575784001)(316002)(6436002)(86362001)(97736004)(53936002)(22452003)(6506007)(102836004)(8676002)(6512007)(2900100001)(68736007)(305945005)(7736002)(217873002)(6116002)(1076002)(25786009)(2906002)(36756003)(4326008)(105586002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: /NNued+87hzUp5kw7kIFr0wqA6sT9t8bwfxr0VRS3I+rE2IXg7RyPFmSHas4gArfmA4Tc4F6ESn68jFsNHFv7g046XtWfkLvFQzvWg1q4y6Yi+EU5+seQ5GXLFy6IxPeynPniTFXo7vxjXgDdqof/h3BSd75nrjrUe8g7Q6B1W+SpUdhTFrpVwIhB/c1Yq1M30sq13t6GtlStQ0oBVZZRyExLDytfwlZoYq2xsRZs6Z4gg4QdkiQCSDPcFakCAjsWBo5tq1vhB5crhiHwoRkGNP18prActdL0ey9n1lyUU1gqW+RchBVvdUBDw4HQKpV9JDccfLMTa2DNyVpD1f2uUhXISX5CiQ1QJMValSNWVQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 132386b1-82e1-4e60-b655-08d6145a5265
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:02.6374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
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
index 939b5b5e97ef..0a6afd4b283d 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3507,13 +3507,14 @@ static void qeth_flush_buffers(struct qeth_qdio_out=
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
