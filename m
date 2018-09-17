Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51F5ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E513214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="kXBol9+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E513214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbeIQI2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:28:52 -0400
Received: from mail-dm3nam03on0101.outbound.protection.outlook.com ([104.47.41.101]:50080
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729820AbeIQI2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8Rm9PJBB0gBW9G2Mn99I+8RIJ7zozkQ/Suxcd3N4eg=;
 b=kXBol9+KUdB25/QquwtJvRI1DmvIHTNBuNVfMewX2BomKoOB5ApEQmvqQrk9jatC7fs6xsm4JyB2syfjsVIsZQyW7p2x2sPEEUh48noZWs/YNV1DmPoVVziPPJ3px4Db8hQa4a+lC42z13jw3vaJHE/2ckjyugezXPorx+4Vzso=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:03:32 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:32 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 09/87] serial: sh-sci: Stop RX FIFO timer during
 port shutdown
Thread-Topic: [PATCH AUTOSEL 4.14 09/87] serial: sh-sci: Stop RX FIFO timer
 during port shutdown
Thread-Index: AQHUTjLfS3g7FcN+f0alX6Hd9VD8SA==
Date:   Mon, 17 Sep 2018 03:02:30 +0000
Message-ID: <20180917030220.245686-9-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:4UV8PNRZ3HExID8oMJAearAGXaMDtjFHwrUos5FfG6HF4hcunGpAnMR0yWvM2ijRX616pW3ryW98MlFrg8YcQXu5dGNs3o17i2xJwaNROxnSoVULPk3KjMxgldO/rMOM4qwsdgpgE6rfeWEBLOuhK7D1ZZTPwEmS54gtvVYFhZ+KDZ6dI1+5tOMHDFeT4dmFrAhKnHEa/g6PJftnvXslN4NNMildFQWmku+2ef0W/4Z+fH8GtDxJpwqzeXRZ7o+EHp5x8FOsfMBRzm4eq7Gu9KFIv5bBZdnZZI6lhBdcEqPaFSE7aS+v5yKTDOXk8iOg+ayrdjhR7U9nU/Db+Hoi2zuGlCwpud4kw/h/QUPBgIZBNTuMUSXnOGIYhfVPFoYsb0Np5K0u0/FQwWYR83paIflTtCCGKGJMSRTVW3RcQKdhixpsP23hVwRE1mqlMyX8zZc4308yzOP+t7JkvPsDGA==;5:qhm/qJra/6HUVRFKWmr5Mi6B0nuTDipB/PgLKnTXWyjXfdL2Zbq2Jq6kvd6UyKC33Dyo0YUiFLsYjqZOdX4CcbgI8PEXhLiNvAaEuohLdAYZJ0K0cvB7qA7cRyhWOcy8pSyQa/l37zULT9vB1TBSI27L88oFg9q4P7RI0vJDVEQ=;7:83H0JchhsXJnC4HaCOd6MjU+a3Pj0rfWdCoE18Isvy9c9GvqdAcUuBih57MUs8y6QKq8tcs3UQjBNQl25yShu12xOnmJB5Pl/H6jHrmFKOjdrf7gJBG6FODPI78UE2HKqXRi/7PF33rqnNCaQIdW8YNltnI3YaOP5ihoYoA9NB/gFIFwzyupbItVl/7O0BQmOP/fGlTfkg6cjnDAbmtvdIdVTpOVTpk13t5JyKAyr/UWP04PsrGe1tPGe++IBy4N
x-ms-office365-filtering-correlation-id: 6930b25b-3767-4ca2-3c03-08d61c4a2702
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB0855FB4F8EC16F2203BF6083FB1E0@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6436002)(99286004)(7736002)(110136005)(54906003)(97736004)(5660300001)(66066001)(446003)(72206003)(76176011)(86362001)(86612001)(81166006)(81156014)(2906002)(478600001)(305945005)(68736007)(105586002)(2616005)(106356001)(476003)(11346002)(22452003)(575784001)(6486002)(10090500001)(10290500003)(8676002)(36756003)(6346003)(6116002)(6506007)(3846002)(102836004)(107886003)(6512007)(1076002)(25786009)(217873002)(4326008)(14454004)(26005)(256004)(486006)(186003)(316002)(2900100001)(8936002)(53936002)(5250100002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: sh2cY1//tyBaEV76ue2dmriNQmcS80VNYcMMRme4qCghSrwm1bqcSQP5u/aIfs5quop1+QYk1H4NyqorGWg5NFdmohSVzAGCmcLOV1BY4BSOCeJ3cgHowIskHQGWfwbuWdJsBxDRfwGyfS4Nxxp7lbyUm8pVAUtzqqwaa2hotSgt7iwQevrwH/Nl88etyLKn1LTmG1actynmYCW7KmvrlfqcKhx83DT9Z9RraPULYi2P17BbF4r1EmQRxlwp2xXf5kKojknTPyp6rEpzNHJdquL9FnMgeFfyeptU9eOU/x4N3UrlqkyS/h/A0u/h12LRyQVhgTv/mMQMccffxOmJl4CXjusis9HYMU42u0GpvHs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6930b25b-3767-4ca2-3c03-08d61c4a2702
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:30.6189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit c5a9262fa8bfed0dddc7466ef10fcd292e2af61b ]

The RX FIFO timer may be armed when the port is shut down, hence the
timer function may still be called afterwards.

Fix this race condition by deleting the timer during port shutdown.

Fixes: 039403765e5da3c6 ("serial: sh-sci: SCIFA/B RX FIFO software timeout"=
)
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/tty/serial/sh-sci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 8bc8fe2b75f7..37dba940d898 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2060,6 +2060,8 @@ static void sci_shutdown(struct uart_port *port)
 	}
 #endif
=20
+	if (s->rx_trigger > 1 && s->rx_fifo_timeout > 0)
+		del_timer_sync(&s->rx_fifo_timer);
 	sci_free_irq(s);
 	sci_free_dma(port);
 }
--=20
2.17.1
