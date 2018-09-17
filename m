Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D15DECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D31B208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="f6JZgK/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D31B208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbeIQIvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:51:52 -0400
Received: from mail-by2nam03on0130.outbound.protection.outlook.com ([104.47.42.130]:60384
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729163AbeIQI2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWr03d3IbpI/QP8VyiCFJgq4Lm8/xO+E1ZRH0Qw+fb0=;
 b=f6JZgK/vSna1SaugxgU8kBul7cmv4+3HWk30CmkwBDokJC9jLHByJ186Ym63WRKjrH5nK1o5jZXWFtaO/w/vDZKkVed97FdOpOF27nn5x2Yv4UNvM4N1hwBZ+MEZp7/vtzk126gdgjEMRzmMuYxdXJYsKvLJU915hX5fZTuCpsc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:03:33 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:33 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 10/87] uwb: hwa-rc: fix memory leak at probe
Thread-Topic: [PATCH AUTOSEL 4.14 10/87] uwb: hwa-rc: fix memory leak at probe
Thread-Index: AQHUTjLfpI3HIRoZPUKBzDDzLoLDDQ==
Date:   Mon, 17 Sep 2018 03:02:31 +0000
Message-ID: <20180917030220.245686-10-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:Flt5IpkNypbuFnANGH5/8iEKhTq2sLbgBjkr2VARYKP0triktTrynL6t3jd6+Fto3eVlJpK6bg19zlWY7ZPsGGv7lVX860npW7Y1iRLXV0kKG8LWB127jDfk9NHKwWaa30eXM3jFmQIQlvptztUj6ZylsDtCZVLz8WmCb6UMoAgL+1hxJukMRQ1Rf1rUUvO4itGhtt8wyuROZBN6b2B7JaHjy/PrjYGEtSC/Jey916x2y6ukRtlGu6dqc37aPAiaJjN9n1pjb8JahJeVOmZKCCr3eVbHmfTC5DvEVzhn+k2qWG97TRkmtrLV1TV2CAoLIJxvR9JogaUD8R88Yu6pKjnn82inq/mnSTEgeRdKmXr9c7fYJ7Sni+fPgw00JqC90ebj+CCvvlyRj4pggAHXsOr6lV5gg1CvY2dHmihwJx8WmFx8n1nik/Jui5XGYFkQsQiYibhqcNkGzW+2cleS8w==;5:+O6r/5Yxv3RBPXCr0SnAM0UKfRZqY2V3q3rknkZX1XRfYe9XPyNMx4ulz+6dtK2i5cjBsvFQmURf4UHxZruCVB3bNMi4ERXlrEAtA1FeUrP3oYyDHF79XkC6yu+Akk6Xocp/QhkppXPNqhSxW/FWPs1pnkqTEcuDLUpNiuwVRA4=;7:bAz9vKCHyQ4eLCvH+6PbDC3hIhtWqSuBmB2hhLUVAAuWmK4Po101DgA8XMwvRisE16kLfswZxlGfYGzDarYbggy9beS4fqk+9Z0b/w/j75nzhU86D40zxqUEa7WOyA8ES2IiJxGTZnKIKj7IA7+GTvc/4tMmmHRECDGgnxaDJqtoR/JlIk43MazxDlemaFOICdqb2f9AoZhh9fPjtJF9oPWdNTeUXKbaAAoLcMFkdzCdMFk8yw9Xn+nNvtXpNy73
x-ms-office365-filtering-correlation-id: fe21505f-0179-4e1c-4d39-08d61c4a2734
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB0855B6DE7DCF8BC9A9A471E0FB1E0@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6436002)(99286004)(7736002)(110136005)(54906003)(97736004)(5660300001)(66066001)(446003)(72206003)(76176011)(86362001)(86612001)(81166006)(81156014)(2906002)(478600001)(305945005)(4477795004)(68736007)(105586002)(2616005)(106356001)(476003)(11346002)(22452003)(6486002)(10090500001)(10290500003)(8676002)(36756003)(6346003)(6116002)(6506007)(3846002)(102836004)(107886003)(6512007)(1076002)(25786009)(217873002)(4326008)(14454004)(26005)(256004)(14444005)(486006)(186003)(316002)(2900100001)(8936002)(53936002)(5250100002)(2501003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: B0Ue4v0wFnLtXB7Sk1LARK1YXRw06tPpQ9NKDwcrrRtnfj+A8K6TmDArJEkn9/aURrd4UO5LUxzSmJkTs/7t2YFjQ6VhfI5dW92ZCGc2x0VvKSHUhFoLi2VN0jcVaF20EMfS19XLXuaGDtlwgTTTRPytnGyu3vbZi0J96YdajJecS8JiV4IxmZJ8wJIxMOjDndhXOqJVU5IqgEKu54Irt4XTQr5pYdruNLo6LM8QuUrZB9L3f3JzJZEh+eTQRyu6iesqZW7aGaCH9e5wVE4muaJ3mc2iZvtrRKI5c6d/UF4dY8FF4BJa4O+4KgedGnaL8mtuNP+vC3e/9ny7vOBoZf1SDMRTZKIlOfiy+eEtFrg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe21505f-0179-4e1c-4d39-08d61c4a2734
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:31.1970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Vasilyev <vasilyev@ispras.ru>

[ Upstream commit 11b71782c1d10d9bccc31825cf84291cd7588a1e ]

hwarc_probe() allocates memory for hwarc, but does not free it
if uwb_rc_add() or hwarc_get_version() fail.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/uwb/hwa-rc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/uwb/hwa-rc.c b/drivers/uwb/hwa-rc.c
index 9a53912bdfe9..5d3ba747ae17 100644
--- a/drivers/uwb/hwa-rc.c
+++ b/drivers/uwb/hwa-rc.c
@@ -873,6 +873,7 @@ static int hwarc_probe(struct usb_interface *iface,
 error_rc_add:
 	usb_put_intf(iface);
 	usb_put_dev(hwarc->usb_dev);
+	kfree(hwarc);
 error_alloc:
 	uwb_rc_put(uwb_rc);
 error_rc_alloc:
--=20
2.17.1
