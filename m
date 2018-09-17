Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEE1ECE564
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF95B2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="csLBd2wP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF95B2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731643AbeIQIdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:33:21 -0400
Received: from mail-eopbgr720091.outbound.protection.outlook.com ([40.107.72.91]:17664
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731111AbeIQIdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tLGlFI2pPVPA8yZ7oq/wnJ5i6LtjTJ8JQ9+ygdk0lw=;
 b=csLBd2wPwDiEo+lJcDbhR0jUJHB1lJ8XfURRnwirnmKQVXOsYsC2+t0NIPkQQfNmQO5VD4KLtqnA64zxsXwFBd2gepmIz7EJDpB+Bl2QH3XLrB0b5N15RncBAkmwsAfGkSO/7FKZHHwfKSzMYnx7o10KT4Q2wMFp+qih44g5yh8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0150.namprd21.prod.outlook.com (10.173.189.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:07:55 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:55 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 21/29] rndis_wlan: potential buffer overflow in
 rndis_wlan_auth_indication()
Thread-Topic: [PATCH AUTOSEL 3.18 21/29] rndis_wlan: potential buffer overflow
 in rndis_wlan_auth_indication()
Thread-Index: AQHUTjNWlQTiPQIRj0qRSqTuN0dPJw==
Date:   Mon, 17 Sep 2018 03:05:50 +0000
Message-ID: <20180917030533.592-21-alexander.levin@microsoft.com>
References: <20180917030533.592-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030533.592-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0150;6:auuALIkNtB8lsWNf+frzGnJZVL0vwNIET9GuVndl6TLT34lr4T0ADAZZW9tw5x25KUcQxb9rUD7Y2Fvz/jgTv6ZQGlxpqjlZLQjMT1xwluvJ/J7aBj+p3w2sDVyhTqv3GmeQcMfJIMOmV/BpoIkwCfnXSKu5UWNMe7tX3IVJ6Hxdhlax0m3X+VdBOWzQOGuewj1vQzLT2LiKGYIhJdbaajeO/iL6n7IY9wjzugsoVd2MSB6i9JjKEl9ntVSzcUlKfZIqZnuGwoqSBqt6un3qK5ilDu0eDdXoc3Bl0h8/HLG2PPxIc7qoZqy13jFhnjO5M/GqZ3wtxYRJUkYMPbdO6xIfkVwFr+b8Fw+j1JdtjWP92Xms1watk9MD7zx8QdRBL7IowhOEwZHVN8kK/x0PUfAMmqQaHvn3PvtxLHEeNlqRtg0hiZbocFgjzBH1Dbf818l9jzN4cfPmGAufaGCH9Q==;5:myM/W2wLKcQD3PDRx4oqfVwk7bmnuz0PVza7LdUjxnvR3dqQp/bb/KTMIM1mAXGLFwSOxvz1rIZ8vfVLEXCXmvjzw6E356EZX/9Wusdsi8DTcsQpxYc3bc5E5HEhbbtHHvkeaHxzNofEAIenE0T/KnnDfauFvg3w9ZJzLWVKPyw=;7:YATY5GId7ZBWjMXOHHWUaLg0brsEENQxPDO+5mAFaymGvNYZz14Ybs6Bxn9Drcxqz4JeXxCL4YdEMibgA92TQNSzW0NQGoACwoscLJGhebltDfMKSR9oPgwvmHdl6VHt3/SfNsDr++MenUSzvkdi1mUc+S37b6lHw73FGiaxxaZshLQWMSl3XsI1n6+LoCjIT3m3qUcusp9kPeXKiiA2BmcrFtPWLyh1MGSDOPvbd1sRH5h+AQFDmLY+agi0cBFp
x-ms-office365-filtering-correlation-id: 16594a2d-75c4-43ee-3f24-08d61c4ac3e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0150;
x-ms-traffictypediagnostic: CY4PR21MB0150:
x-microsoft-antispam-prvs: <CY4PR21MB015089E146DC1E79037CE95EFB1E0@CY4PR21MB0150.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0150;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0150;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(346002)(366004)(39860400002)(199004)(189003)(478600001)(2900100001)(2501003)(6666003)(11346002)(107886003)(5250100002)(14454004)(26005)(10290500003)(36756003)(217873002)(7736002)(99286004)(305945005)(102836004)(72206003)(2616005)(86612001)(476003)(6346003)(186003)(486006)(54906003)(110136005)(446003)(6436002)(5660300001)(4326008)(256004)(86362001)(10090500001)(2906002)(6486002)(316002)(6512007)(53936002)(22452003)(66066001)(97736004)(76176011)(81156014)(81166006)(8676002)(3846002)(6116002)(8936002)(25786009)(6506007)(68736007)(105586002)(106356001)(1076002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0150;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: nrhZbOo6tdkabGiz233FIGIVgRj0mqdA56XQvMmNuo4MWTeq7tS0vrMoyT/cXwfqV+JEndNdZQay/VIGO7vn13voSOGiDmdJ9TRcKaEr8IQ/P7BMTsUzEJ6OkK4IGC4xND16P0nGEq0ammEfsntZEQJFQYYldE8vorTz7CXE+tXpMNEBwnn3iitlA5kxUQpYtbp44685aRrsq6ixLb9+fXkqkV4f5cl8uXEyUiFa6OVKlwxwlahdtr8iY4b6efa3IorIT8gJF4WxdgJukxDMjA7YQ/lIiaUqDtYS+ejXsw3lK+6kPmRUcewF5rZJB7T2wbysJW6EP0ul7q7k4D8Lfc6Z0zQPUdGCYhFxi8eo8ds=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16594a2d-75c4-43ee-3f24-08d61c4ac3e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:50.5764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit ae636fb1554833ee5133ca47bf4b2791b6739c52 ]

This is a static checker fix, not something I have tested.  The issue
is that on the second iteration through the loop, we jump forward by
le32_to_cpu(auth_req->length) bytes.  The problem is that if the length
is more than "buflen" then we end up with a negative "buflen".  A
negative buflen is type promoted to a high positive value and the loop
continues but it's accessing beyond the end of the buffer.

I believe the "auth_req->length" comes from the firmware and if the
firmware is malicious or buggy, you're already toasted so the impact of
this bug is probably not very severe.

Fixes: 030645aceb3d ("rndis_wlan: handle 802.11 indications from device")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/rndis_wlan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/rndis_wlan.c b/drivers/net/wireless/rndis=
_wlan.c
index 46dda22cec15..ebe762bf01dd 100644
--- a/drivers/net/wireless/rndis_wlan.c
+++ b/drivers/net/wireless/rndis_wlan.c
@@ -2919,6 +2919,8 @@ static void rndis_wlan_auth_indication(struct usbnet =
*usbdev,
=20
 	while (buflen >=3D sizeof(*auth_req)) {
 		auth_req =3D (void *)buf;
+		if (buflen < le32_to_cpu(auth_req->length))
+			return;
 		type =3D "unknown";
 		flags =3D le32_to_cpu(auth_req->flags);
 		pairwise_error =3D false;
--=20
2.17.1
