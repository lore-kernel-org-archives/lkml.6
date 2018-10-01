Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DFCC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23F720666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QhieipbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23F720666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbeJAHQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:16:46 -0400
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:26608
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730083AbeJAHQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oZZVT8FmPvmbMjGrp715cvVFb+nMb6oNm19y0+1EXA=;
 b=QhieipbPhlcSoJ9BAvwlmCSvugyfjZvZcieg6gunA0TEbATBrjU/3bsG8nnv+AWiqUBjhkA5HQF/UP2l9lfP5AJDJouKibKwI6YPipRX0ZIbMGlUnA6ozDzp7djIVHoBt22DSChEDrGfIcX5ZSrbUvs+sRgUv9wmNLldjBpypTs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0791.namprd21.prod.outlook.com (10.175.121.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:41:32 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:41:32 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 13/17] s390/qeth: don't dump past end of unknown
 HW header
Thread-Topic: [PATCH AUTOSEL 4.4 13/17] s390/qeth: don't dump past end of
 unknown HW header
Thread-Index: AQHUWR9/5LExO6njw0+kapDw3T9Smg==
Date:   Mon, 1 Oct 2018 00:41:32 +0000
Message-ID: <20181001004122.147276-13-alexander.levin@microsoft.com>
References: <20181001004122.147276-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004122.147276-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0791;6:NJi4rCE9RIQxtC+i2xbN8FCS8iDkL2JMgi3S6R52bPdAMy/TfpZEVrh/uJRPkul27WuWznnZo1dJwEIc6TY59HwP19JkHVKO79x/THuz+rEusPqKwbGkmcuJFdrn7kPIruiFX3G6bG3qazdjSntsz2XQHaRkGGoD54pzHZwtq38iYMfUxh/FOE5Gf6LxJve6+ybmLbGlCqOP3Kt43nMQ3ra7jwfpWpDpP/K+kK2GV/LWbpGk0l0l2+KracivCucqOJ/5ahqM3ERPj2RRNLv1RNf5WNwZOGmsfzRFOhp9TS/YaEvOg49SZO2v5MqQG6DD1t8ZlQ4+xgpwolSpgJGvHITMDg9rwdcZGQAqOm6/PUT33lUqWTjcetWASTGeoP6JqtUg39V6SIQpy5CtJ5GtwmbwLjicwFcVvhAN6yj4AggYkH6qwB6qvcw3WPp4eaOuBPOMDcyWFdwFhHGA5N9YKQ==;5:KOVmom8oDb658yCrc9O9K0+WFa2zLOUDb03ZtfXi8l6KUZUhNOKmYNV3qoOP315I/WNrCtGSn4frHMWkAJoI1kK15YEythjr8rwM/Bmx47jo5CoMAFqDmj+wRLJql++O6Zl+7dou3UheI/CYdZpEFZqFVSMdh4NSB0kb4fvJDr8=;7:Yl7rLX8T5O07xm2s4H6JUnBzYOJ/ye60AVSUk0Wsejelc1mUDoA5JiQyXA4rIn/VomOstAKe4EyERq6IvGSEHso5LU8Enpj4spbwdel/teDlpV++jKdgXU5Adt4/wiT0caGDFd4yWA/FuTxpBknikLpS/Jj7qDl6719B23y2wq5WaxF8r83VQvWHC2kTRGKfyrPlNyR4qMOBY1GoFk1/eBLrFscYHhws9Ey1feUO6/5cnDsNkKkMI9kAX0bqTgem
x-ms-office365-filtering-correlation-id: e515201d-b4bc-4709-e636-08d62736a281
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0791;
x-ms-traffictypediagnostic: CY4PR21MB0791:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB079102F3DC942DA750F3ABC2FBEF0@CY4PR21MB0791.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(104084551191319)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0791;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0791;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(366004)(376002)(39860400002)(189003)(199004)(72206003)(71190400001)(478600001)(316002)(110136005)(14454004)(2616005)(54906003)(105586002)(107886003)(106356001)(186003)(305945005)(26005)(34290500001)(71200400001)(22452003)(7736002)(256004)(14444005)(25786009)(10290500003)(99286004)(68736007)(53936002)(486006)(6512007)(446003)(66066001)(36756003)(6506007)(81166006)(81156014)(6486002)(5250100002)(575784001)(86362001)(2501003)(5660300001)(4326008)(11346002)(6116002)(476003)(3846002)(10090500001)(97736004)(1076002)(8676002)(8936002)(102836004)(217873002)(6436002)(76176011)(86612001)(2900100001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0791;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FGFAhqe2SyUy38f+J4eSxe4Xd7Hq93KfBfs+tNg3Pf2K9CdbwgPKcH7F9clCUgYJULDNdr6NQ4B3sH0MILMDiOvw5CoLtnsbGgoLSCC7XJbZAVLZDe7uoV9/DrJCj03y8fTraKEiNQcyw/3WE493UbioBiAZOLJMpflt6VbxJDCunUiF6sX4RPCjKhlfzITu9wSriMObpqrt1PM5oKSLTB/RXPT5crupy/VDAzqbGLrleJ3/gPhgR80gd9K+0k9mfBsorenRHRcy0Fpwkr4L2ZDfEpMGuH2YRNIP2PieuFWoloHW80zBZB1nay49sy3VTDrwcW386VXaAxZhhvud0P02GFVRREsDr4Rt7YBJKM4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e515201d-b4bc-4709-e636-08d62736a281
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:41:32.6602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0791
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit 0ac1487c4b2de383b91ecad1be561b8f7a2c15f4 ]

For inbound data with an unsupported HW header format, only dump the
actual HW header. We have no idea how much payload follows it, and what
it contains. Worst case, we dump past the end of the Inbound Buffer and
access whatever is located next in memory.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/s390/net/qeth_l2_main.c | 2 +-
 drivers/s390/net/qeth_l3_main.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_mai=
n.c
index acdb5ccb0ab9..34d3b7aff513 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -523,7 +523,7 @@ static int qeth_l2_process_inbound_buffer(struct qeth_c=
ard *card,
 		default:
 			dev_kfree_skb_any(skb);
 			QETH_CARD_TEXT(card, 3, "inbunkno");
-			QETH_DBF_HEX(CTRL, 3, hdr, QETH_DBF_CTRL_LEN);
+			QETH_DBF_HEX(CTRL, 3, hdr, sizeof(*hdr));
 			continue;
 		}
 		work_done++;
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_mai=
n.c
index bbdb3b6c54bb..2cc9bc1ef1e3 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1902,7 +1902,7 @@ static int qeth_l3_process_inbound_buffer(struct qeth=
_card *card,
 		default:
 			dev_kfree_skb_any(skb);
 			QETH_CARD_TEXT(card, 3, "inbunkno");
-			QETH_DBF_HEX(CTRL, 3, hdr, QETH_DBF_CTRL_LEN);
+			QETH_DBF_HEX(CTRL, 3, hdr, sizeof(*hdr));
 			continue;
 		}
 		work_done++;
--=20
2.17.1
