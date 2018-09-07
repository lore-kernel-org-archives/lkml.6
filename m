Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7109BC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDF52083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="khS8F4Uk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FDF52083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730983AbeIGFTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:19:36 -0400
Received: from mail-dm3nam03on0102.outbound.protection.outlook.com ([104.47.41.102]:49926
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730499AbeIGFTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObjDwdKSmzGstu6BrEQGWa/QbjmqY+sbzJjFWAFNzJc=;
 b=khS8F4UkCwRveIGLfVXJ//21lawPdbJlXZ081kfWwp6yxs0NHh9gxCgbfrzR/oEmjkSLCv1xzKLxM81b7OkoL7818oPaGvonUOUsSaYw4NeLB5zSuvtQ581sNoJM5ifB1VCjVtsGgcH5TSjBQTwxtt0Bt1x5mLUlyCUkaQbrznM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0694.namprd21.prod.outlook.com (10.175.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:41:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:41:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 37/43] s390/qeth: fix race in used-buffer
 accounting
Thread-Topic: [PATCH AUTOSEL 4.9 37/43] s390/qeth: fix race in used-buffer
 accounting
Thread-Index: AQHURkMhGR4lc+hxb06be+WkM/1BSQ==
Date:   Fri, 7 Sep 2018 00:38:44 +0000
Message-ID: <20180907003816.57852-37-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0694;6:n/Ej5pn2KtSrABOAmg0LpoW1P+/atMcMbl090rnOmIfzrgLzUEyCNHLliyRzn4Wi7rXcL41x5mpTI7cAffWHldCB6TdnIE05g0lIrNPt83jGscKXb7hUBpVPZZH5/uNIeJQrAh5YSdV23w9QQgrHWz3qppyWWSszXVfVjCBY28xZZS8taJY9eWs/v1jEKFTSExVpA/AJY4IHwTXgnTA6CNt7tov6KRQGaY4++m9RhYJUIPzsL5ax4qwMuyO/Xh2oHpR9YsgaA3+8LJeKT5ejCyQD/xUPp9+3K2zzG/xwjKenYs3EgBLevo9y1Tem6OU/OekaI3aHS7iTavuS1zBe8iBQJYicetX69PZRGSf8lQzBuZjm6pwvRluvucrVlVz8Yr5VOBP3pAL3B+I9jFHLzwz8qndLYG/ZPTbdD6ZS5vvhVZJG0RjWnkk8YawpKEzy5hQSwQN0tVC4uZhtJJ3GYg==;5:io8wR9JAjJy07bHPVP1n39/yAoksXpwRErVvMUSogJLQQPNVE2JDyHvQ/ks3nFB/2HvbvczWiDV0PklgkViCxEQadb3yDPc2FCGTf4k22EUW943SfoPUf2bSFag6PIISSq9Lh+i7bx2xB0YOFTQcyJa+PMK/56yL6/km1DP8F7A=;7:nLLZr0mSU38WU0TXcvOcsFXGUN+mMt2G0ubiorQ51NPi5XbJWAQalI6DrmWeTLnpMB7+nhusZiNTdNZayNTTAtaIFLLO1kqn6gvfx0KWF71uC6+OM6i0tI6u90RjBHU62/t9KJ0Fxz/NQtuuS4A1V+2UJkWW0GNv+Sti+0NsE2zwIXEVlXSPX4l0iAwsi8rrPTV0uFWav/53MpgxBUWkyKi6ZQeV4M4SMh+3zf73PzSVEeNBTZLAG+iFA/edhRqy
x-ms-office365-filtering-correlation-id: f1eb4087-faeb-49be-25c4-08d6145aa208
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0694;
x-ms-traffictypediagnostic: CY4PR21MB0694:
x-microsoft-antispam-prvs: <CY4PR21MB06941591264E7B6647489F60FB000@CY4PR21MB0694.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0694;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0694;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(366004)(136003)(346002)(189003)(199004)(2906002)(575784001)(186003)(86362001)(6666003)(110136005)(107886003)(54906003)(36756003)(25786009)(4326008)(256004)(14444005)(2616005)(6506007)(6486002)(6346003)(6436002)(6512007)(446003)(476003)(11346002)(486006)(86612001)(2900100001)(5660300001)(102836004)(26005)(66066001)(53936002)(68736007)(7736002)(81166006)(81156014)(8676002)(10090500001)(8936002)(6116002)(3846002)(99286004)(105586002)(76176011)(106356001)(5250100002)(22452003)(14454004)(316002)(1076002)(2501003)(305945005)(217873002)(97736004)(10290500003)(72206003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0694;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: r6ckDZLO2FuUPBCgPVhctGiSE5KSLeZeafUCIAy6ctPmD/ODp/bEAjzT1xXNbQiXxL5a4XgIgSwaShFyERFDE9Ppp0VGMxNOvHf4IsF482beWjC3q9kKI41e30q3UCLTGcphf2oIeeaIRqW2zwZdios7QQ4hJJYJYqJODFrbMy3rfBrSmvoEMlpFHcF8uD+RElwSCi1ca/lOYf2Z/sD10RH+07wyjrhoLhDwXkU/DmhzSf3ntnNYnHKXhr2ycWPBKDh4BXybFc/vPdp8nwptAkZKoxA4R18hQfVhsBFoXxgAFqoT1WumqK5Sn8tKv2azUT08nrAqoeEN0MXy2dCQdWQ6AlLEAoWHSAtAoPKpKV8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1eb4087-faeb-49be-25c4-08d6145aa208
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:44.5208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0694
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
index 283416aefa56..258a72869f57 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3499,13 +3499,14 @@ static void qeth_flush_buffers(struct qeth_qdio_out=
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
