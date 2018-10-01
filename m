Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C583C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0330120666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="F/r2FLnU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0330120666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbeJAHRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:17:19 -0400
Received: from mail-cys01nam02on0136.outbound.protection.outlook.com ([104.47.37.136]:43745
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729679AbeJAHRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mz3rn5eqG7Ev9ti2ZVAw2MngmP23dttPRNHpxFWaugQ=;
 b=F/r2FLnUzwtCCYkeHrnVbaHcsd/MQpY0toFgdWg3iFvarg6sYJi8B7XcqDg5LMJdBkvjmLbHAK62WRK4cqn8xa+nPlhsBkmnQCXGI9x0xtpWOYsw6TqzO0q0iTpgM+MSsvYVyNZvkBCVf5LGUVgCiAmsWv5HvwTunOCKAnDVbk0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0791.namprd21.prod.outlook.com (10.175.121.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:41:51 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:41:51 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 10/13] s390/qeth: don't dump past end of unknown
 HW header
Thread-Topic: [PATCH AUTOSEL 3.18 10/13] s390/qeth: don't dump past end of
 unknown HW header
Thread-Index: AQHUWR+LFjVVG7u4w0qsVcKuqW/mUw==
Date:   Mon, 1 Oct 2018 00:41:51 +0000
Message-ID: <20181001004139.147341-10-alexander.levin@microsoft.com>
References: <20181001004139.147341-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004139.147341-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0791;6:PJ79aq9XzS/HdCAE2Et7fp0eaA7V43B1BmvN7yOqkHzuZwUs89fcvZGWJaGk08ITshpstvh1z2jadDfG6NWC1ovK8yPzbhblYG8xa/yLBRnj2qpcIostzIUu8IEBNXHC4L1W4Gmhow70V/FpmGmvA5fpt95JmHSpPZOSRAjnSXyXzvB/2eJ2xkrtiSg6RDMXERgFWJFrdpl59riCZ1nPJUUePGBbPX7DDqOK9586aje8p7RGezSawO+kOCVktvwzCEcW0f/IrKr/Izj4n39pObHROMhFDU8KZ3/XTbcFhq9o4DhlY6ecNmjMI0OCAkMDGvke6NmsbkipVgzlQhjelAVc0qWgZBg45kG6apeHU/B5i+3MqaCAR0EjyR2/jMhjBFngBKhcKHufbv3Jq9FJxpuZcQUjV/ai2tFAiunSe48aQ2HMzRMDZETiWOuzjG1aLquATjlK3ippB+L8iEE+Qw==;5:W5KsqTsItxdj7mbAMYaog6KSbRTQor4d6SDlyUJU2Ym3pU70H+KwosHpnfQQLPdaiU3esxGKo70zu9s4nyzzFhqbefENcALmr4pXPafgzegV0xQrd16moyRc9jgEJdF+f1pJ4okY3+TWism3s4gUjMUSexbgkHfkyaaCfQziRnE=;7:nrf049h79YqG+vDAv8yBgQfenhoWN0wof4qlsLBP3F2HlV4uGoSUXATpnW7Lwo9AVxLrLyTF84M7glWfE0U7IcAS8CoKby9QQwdEemabNdWahLtASM8jPbpY28I5YMD10XiuZKXj7YfUN0Mf9Rc47zvrxNoqxj+Nvdmd8UrY+QqxaS02zhn6WJpIxu2rD+s3vVAoXVpjqcRuULtyDDDUx96eOQjMGaditI9OG9r7xdL0v16YSdXWhS8LIBmZmyrk
x-ms-office365-filtering-correlation-id: 01fbab24-4173-44d4-f5e1-08d62736adce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0791;
x-ms-traffictypediagnostic: CY4PR21MB0791:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0791AD3D622DE2E84EA9A0FCFBEF0@CY4PR21MB0791.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(104084551191319)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0791;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0791;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(366004)(376002)(39860400002)(189003)(199004)(72206003)(71190400001)(478600001)(316002)(110136005)(14454004)(2616005)(54906003)(105586002)(107886003)(106356001)(186003)(305945005)(26005)(34290500001)(71200400001)(22452003)(7736002)(256004)(14444005)(25786009)(10290500003)(99286004)(68736007)(53936002)(486006)(6512007)(446003)(66066001)(36756003)(6506007)(81166006)(81156014)(6486002)(5250100002)(575784001)(86362001)(2501003)(5660300001)(4326008)(11346002)(6116002)(476003)(3846002)(10090500001)(97736004)(1076002)(8676002)(8936002)(102836004)(217873002)(6436002)(76176011)(86612001)(2900100001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0791;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GjFhMDPz6tTNubKQ2wdeMMabjU6Z5hZqCyxjdO2tEG176UuGaAtreeNBxNaq6PKcz/N121nI7Kq1qx/2AX7kediKheuD4//W4IJmPnfMs8rgFl9UrYvERAaWeTjDidf8pwcn8A1cC2a6K2ICRpdhg2QBm4YaL+e/UeY9kLkcU2UNxA04R3l68bSjCzo0hJayPfWqLAj81OXnmjThw4qUIL48lbcCJyTpL9WwFf8GaU5hvgQsoYbwS2PXY62N8li9W54xpTIZxEB+wUgBlvkphDE8cZx9uD2LVh4L5NC0xlHDwKLZmQe+7Ao6Ng8SSizBTEADWlbr+lB979Pr/e0UxHtPhlk2AvYtWn0lgC7rdaU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01fbab24-4173-44d4-f5e1-08d62736adce
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:41:51.6292
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
index 1405fe4c0c96..da8d94b27ec9 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -452,7 +452,7 @@ static int qeth_l2_process_inbound_buffer(struct qeth_c=
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
index 908c294aebae..f3a765655072 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1993,7 +1993,7 @@ static int qeth_l3_process_inbound_buffer(struct qeth=
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
