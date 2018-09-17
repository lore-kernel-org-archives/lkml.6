Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097C6ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E4C2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YO5u3tdg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E4C2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbeIQIZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:25:43 -0400
Received: from mail-by2nam03on0137.outbound.protection.outlook.com ([104.47.42.137]:35861
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728537AbeIQIZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GF+EjkxdbfyK8NCkMh4798mkzh5luPfQm+MMuhyEzEE=;
 b=YO5u3tdgQVYS4Gh0q3rsLTWmEko9R0fih/WxvshW8PFAGzGn6Wy9CeggPy98rAw3WVjUQL/f+xgDb7W6wiuKHi8Hj2e7BthYHxHr0x4qpc7AHS1i/ol6igJxBmGM/YBjxlf2RRZUb7KqW6v0tUI64aKm4ksqF9mtoqSTG3EkyQg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0277.namprd21.prod.outlook.com (10.173.193.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:00:24 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:00:24 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 015/136] serial: sh-sci: Stop RX FIFO timer
 during port shutdown
Thread-Topic: [PATCH AUTOSEL 4.18 015/136] serial: sh-sci: Stop RX FIFO timer
 during port shutdown
Thread-Index: AQHUTjKRC9/QAkQ0kk29BFAxq4Wfkg==
Date:   Mon, 17 Sep 2018 03:00:20 +0000
Message-ID: <20180917030006.245495-15-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0277;6:7kQ9YK9gz7IcOiOCt3+OT/gdSTwZZKAspNvpzscEHAroFwBVpkAdIqdwxfDha5YlHVunEDAD1UFhGYADSkKz0s4Q8DLETq+RJCIX9Y5pLs8jL0ew+GW+Y9i0sd/Bb7BwDi+ZKOekN7SN25nYChT8CiViVL+2QZjmBygxWzg+NkH/40PECx7I1/FI9Rwznd0WEligZIADV9wt9dyjsF1YGd6TxdgzD+y+ZXSg7YKkSaNeE1EYVTokETvrXve7E3lNcmrezfWkk+D5ErYjl+kK6bi6SJNySBGqtlrh9EedZrlrV+4q3oYi1sZk/15C7ygAncp4UZBmqFtOetPwDth3T2WB363EbSuSlWcdpXuTMY/Ixb3I4Q99oNdyCRUrZ2G7FTa4WmXi9b0BO0vhl0UVVmwZ3LcpcZkqEVJU5uchPL9eCjK8EvpuaaLNy3DsxIh1cCZzyZKFMGGD+QjXZK8F3w==;5:vrWCA89yk77pIMniaLnGYpDojOBe1lGYeFL8aXP8T9Q/Rwg9VOdG8u2aannYc1P5QzYS++yddsEPEUeqQnRlORA9jSr6IsWnKlN5U2HN/hg40djbi6piKbBAAPC/oLb+rPDRev72FxuZnDTFy4BRWL067KNN4TSjIbAgObZWW2Q=;7:1y4pRNOkGOcQgpGq+lIfeuvuj4MVOhWRMl51eunjq164sKa0+RVqcBphT3QnGtzpJ47KKOCBKe9U97u/mSKimTFK7VrS3PUJuN3PE7zeOCJ1l2BJY4Si293bSQ6ylfPlbOaqQPgkqVceV/lD48qtDOlMheRCC+hpRKe1hlodTHwvvFyLcC/d6p1ZTjH2Rk8D7wtB1hD9nzAkgQLMnbx0UqLiCSgQU12qSIBiHCICu98T4ItOCpHhdZREuxq717U1
x-ms-office365-filtering-correlation-id: 912c972d-daa6-49cb-26ae-08d61c49b68b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0277;
x-ms-traffictypediagnostic: CY4PR21MB0277:
x-microsoft-antispam-prvs: <CY4PR21MB02773BA44DDA7C244BD9E087FB1E0@CY4PR21MB0277.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0277;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0277;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(199004)(189003)(446003)(4326008)(2616005)(53936002)(107886003)(11346002)(22452003)(68736007)(486006)(316002)(14454004)(106356001)(476003)(217873002)(25786009)(105586002)(10290500003)(97736004)(66066001)(6486002)(6436002)(5660300001)(256004)(5250100002)(6512007)(6666003)(2906002)(2501003)(6346003)(99286004)(72206003)(2900100001)(26005)(6116002)(186003)(1076002)(36756003)(81166006)(6506007)(10090500001)(81156014)(86612001)(102836004)(575784001)(86362001)(8676002)(54906003)(8936002)(110136005)(305945005)(76176011)(478600001)(7736002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0277;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: zW6yvkGCq5X8baQWSfTsfHJh9/o8b+TYqLEiAAHwt7tz0PPvSXTLRFgwTHqEUXzFgMzxJjxcPJ0BivaBNsT9vjVbJScOZ/o6bXSAtSGA7l1Sti37nKApMYBksg0y0aZvde1eTfquJeTQlQtK7n4Wd8920W/mCg61LAsUkWI9RVirPPYDvuII5A88mOOIrszMAOQjF/lWmk5TWyhUvGOiXIZKVoZEwqUEXnaN6w5DIcNyMLNELYkxHfQXufimVgTlqNQeV6FlwyVRnY2XXb5TML1u8mxUsfc2Z1iSF8IhPErAkk+/FTfCSb5GG2uLCttGDhMmliYwY0jwdjN//6sRFaCZhn4eeUVJdRXpzpVqwYo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912c972d-daa6-49cb-26ae-08d61c49b68b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:20.5111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0277
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
index c181eb37f985..3c55600a8236 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2099,6 +2099,8 @@ static void sci_shutdown(struct uart_port *port)
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
