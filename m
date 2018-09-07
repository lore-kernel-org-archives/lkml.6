Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8D5C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B73C2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="i//szg1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B73C2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbeIGFe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:34:57 -0400
Received: from mail-sn1nam02on0135.outbound.protection.outlook.com ([104.47.36.135]:30237
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729401AbeIGFPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fxoINJWynhTIRlZ3rR5dMmRh3cA2qd6P2VepS7LSfA=;
 b=i//szg1ZmxPK6mE1qSwzOPS/d/WIRjobQOHcjhSugnjOXhHn8XvCyJV4idR2IPRONiuRon614T5IHvd1qxaUKvhtiGk2zOC3n7EmOnU99gYVAGpCHQxDOKTmjL7WDQ5jPsERlKOmDv3cZ51DxCkdTe+pPRFuDNncWFMbkcxpdt0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0118.namprd21.prod.outlook.com (10.173.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:37:35 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:37:35 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 73/88] s390/qeth: fix race in used-buffer
 accounting
Thread-Topic: [PATCH AUTOSEL 4.18 73/88] s390/qeth: fix race in used-buffer
 accounting
Thread-Index: AQHURkLZjnnOPk4p20qHRgStkbctwg==
Date:   Fri, 7 Sep 2018 00:36:43 +0000
Message-ID: <20180907003547.57567-73-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0118;6:HO8tesc2Jtqw2shKESiyExwwXEVM7J8Jsa1ybPMIsOsqcWuPE1lVTZize+Q8mtW3k7dqYKddG7qDlDInDB/RmzN8QFqWQFndGS9OkmOtStqkrxY4/hM/Rj/cr9SCDiFuTwXDS3D7hOYyCgTYnITpu4aLWee77FSmYN+pjau3nGLc9bkTGpWh+Ojon5qeGOG8AtSTjGjjE2MP7BPx7rDu+1u6tLfyKTXlTJDXKweVGbZHdNexFNsY98y8tHopjW0W3/0+TigbxOp+Fj2pyXgUaqmPN1/bp8PAP7WBxbnbD1K2VYvTAOWSQZDo5LGzMXOm9GXBCmHCg8KAzXSND8LwZLcyMgiONToP7ELzK77Dx12E9zTSzkkJ19kjy7SFnRtkU/eanZVC6s6TOp5sq3MAh297efV8wW0wcWHKuZgQwD1tohsUxr8Yw1CY9uxeUEO/xzlpyVZkprnaPO+aNUj7nQ==;5:IT+v33/3E/ASwmO776Z2b7xxk6SIAxNwqgsgG5NW1lSj1MgWG7LgTJFksqsTzw2AQNrWIbmE7RsS5HcZx3PZOblw37oGWeVEGIx32umvuQe9mSO1SjWgMR6WqoiavPXfWIBcYHFz6RzYbRvIAZwtfD/Z4YUbzFV86qQeIaUs8A0=;7:MFWMwEbwbFJWuLi6XzyullEs6b8dwVYf9ldUiQ/aP16GAaSs9cTd09NI+cFitgel8TWkT8t2kDr1RfFWKL/mvPFscRxxmqcM9b4LsbdVu6z+jFg0DR0jTMBRQn0n3+PwRr0WlQeR0j1bnsE+n8vzEWTyTJf5xC7t4RBa2mNmc59/VxBsokRg2yeQPK2JSfOQzYom0pYetaO72h1ypQCFeRzsbCha9UUPuruGHKsJO3IlkSp++Cv5VcAiTQgXzEFV
x-ms-office365-filtering-correlation-id: 486df46c-874f-4404-2c7b-08d6145a1b0c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0118;
x-ms-traffictypediagnostic: CY4PR21MB0118:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01188A438DBBCB13DAA9B599FB000@CY4PR21MB0118.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0118;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0118;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(136003)(366004)(189003)(199004)(97736004)(2900100001)(53936002)(316002)(86612001)(25786009)(86362001)(575784001)(2906002)(6512007)(68736007)(110136005)(54906003)(107886003)(4326008)(10290500003)(14454004)(81156014)(81166006)(66066001)(8936002)(8676002)(478600001)(6116002)(3846002)(72206003)(305945005)(7736002)(1076002)(106356001)(105586002)(36756003)(99286004)(186003)(26005)(5250100002)(14444005)(446003)(6666003)(256004)(217873002)(10090500001)(76176011)(5660300001)(6436002)(11346002)(6486002)(6506007)(102836004)(2501003)(22452003)(476003)(486006)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0118;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6evCxSlE5ALTS/SPxxywJY7eT6EDnbLZ3/CfXNN7Iw/RmrcXEy2jvX8J/1QSGLDkzFAI32VSDdgoQR9xUDW6rbH8DIZ1E5NIAukG1NcHbnXE7PiJ4Zt019N01mCOxj8V1d8Tnp5lRH9ZA1l5kC3zWsmOVxrhKnAVZi3MsS606uzr/MwWFZtNLjh772DJrWWuOBxIpIIHp78Fgd5EL9LLEGpXpZIEK/Hw5TX1YQ4P20/qGimhNM+NFky/zMpuRy0q2wzFm0Q6O0ANZewXz+dfA5Y7MbJ6bwsgPzMzrJyjqWmJ5dCpJs25sYBsyjNPjx0b9TJpF1SvFADZyT7P0YBZFmDYuBDSSTT1YsHS7SE2SKo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486df46c-874f-4404-2c7b-08d6145a1b0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:43.8154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0118
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
index d01ac29fd986..ffdb78421a25 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3530,13 +3530,14 @@ static void qeth_flush_buffers(struct qeth_qdio_out=
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
