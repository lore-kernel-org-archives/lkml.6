Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F8EC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008EA2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QMdRbpNt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 008EA2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbeIBRaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:30:21 -0400
Received: from mail-co1nam03on0128.outbound.protection.outlook.com ([104.47.40.128]:55583
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728318AbeIBRaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EatQnt+nR1vPB+/SXt/wj1OO36BexTYAadLnOIWUy94=;
 b=QMdRbpNtU40sBzfiXhdFT9G7VNTjfMAPJe+NTa7V1JhyvhOVe04UKKXfW1KVBiyoHk7xsgLRCY4Hmc4+Y5iacpiEmMr4yQmrcnQrPUKNk0vsEC9/85cj8tL5r3o24jBeII0joUTxqkQc3oa3VGllEJPqKL+RBZNKLYKlh8Lol/0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:14:25 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:14:25 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sven Eckelmann <sven.eckelmann@openmesh.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 20/62] ath10k: prevent active scans on potential
 unusable channels
Thread-Topic: [PATCH AUTOSEL 4.9 20/62] ath10k: prevent active scans on
 potential unusable channels
Thread-Index: AQHUQr7fUooKWa3QE0CxJh6+qqL47A==
Date:   Sun, 2 Sep 2018 13:14:25 +0000
Message-ID: <20180902131411.183978-10-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:ko0EQf7QcI5FMioMu0ckW4FnXsZIq5JL26KDHSZk0HY4biOsZyokl6SiV4rK1c0XVZMDHU5yavavS+5ymCgZL2ZShi5DlSHugDqoIbHy4UlLm/qR0dl5wETCJIk9nRh0ZAxwrT30yhCvyoCXtow5zfKrqcW6rgssM0v1NPYxfRVJakz+hukT5VY6/eVFmTPY7b4sT8M//kIw729fEmM5DRI8ePMUNa9zxuZCk0rNrCg9SPFNenGMIlGQDGMwfFEoZoE7OCjaUIgP3exLKZdC6OANNejaJ/oYleH8E5hI2XaznvfYWD3OFbpOLeWQ1JG6RJzqEUBVER26eBNN73wjyBWnfD2iun6xzxjOZBWSGLmMXe0amebBqHKBo7hn4f3PZvzi3mFa834yzfsdooVH+JxPFRJfiJCwiJ3up5cGJ5TwxVC1Atgsn/cyNXdhUWsh+lE5U6rp+RbGoc05ZIQ+Gw==;5:JN9et6hB1GLvAiC7zg64nAPGQalyRGo9OQ+/Ce3aC/6t+POhtTv79p+E0GjuviUUTYTHxz2JygNvLQAdP1ZK5Otpba+NHBwK6HqjReBLDBFZx7jvKd5L6c4KWFZIotIx6ZAJux52gRxRoAVVycs1jsCELMWeP3pJMMauqezJoY0=;7:ruj9B9jgItau5QlGYKYyuJOYVyECJwla44HVWSCXXhn6CYcESIuWnRui5bTlGRTQrr4WMp3EkAuIvgKGRDk0kaEViK1MEr5lsev+oo8E+bWFagdkn0ckg8Z0YKq+slG/kfzZ1OguIw4PEwggGCwZay0OUwFAcFyg/FzrhL7A0pxt5kPjGldoHrC65d6+Ju/tdzv+PXE3MJ7TnSEB7a0cffrwP165M/c0neJy7M/mvsq9XB1l80FRcuGZ2zrBA13O
x-ms-office365-filtering-correlation-id: 56c83747-a25c-4c99-c148-08d610d601d2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0120D25452371D587E537154FB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(376002)(396003)(366004)(189003)(199004)(106356001)(53936002)(72206003)(5250100002)(22452003)(97736004)(6512007)(10090500001)(2616005)(2501003)(446003)(11346002)(478600001)(10290500003)(476003)(14454004)(81166006)(186003)(486006)(25786009)(4326008)(36756003)(102836004)(8676002)(81156014)(105586002)(8936002)(2900100001)(99286004)(66066001)(68736007)(110136005)(26005)(107886003)(6506007)(5660300001)(76176011)(14444005)(54906003)(316002)(1076002)(86612001)(3846002)(6116002)(256004)(7736002)(6486002)(86362001)(6436002)(305945005)(217873002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iN3f/ffdPTcuFZiiWktI+H5d2fre0Xn6nI8BfRxB44v4hOVYqJcCaeOt6bINaIUJBoLjQMBofhJitPMrSt5Ptg2JDtb5UB0svsIVF8ThppPMEo2vnLVW7f8gpFoxFKdKHwAayp+7gAB2b6a0DlHyPIGqyPbhq4Df2YaLPZnRHfG2B6adDKURKjIfWhnYmfZoWLSq7Aql8wtxy6Ioddqu4PrlUb+mYuDswZlsfYuHTLlv9vL73rRnSakPPYbtoeHb6glLBtjhQsFnwItPmt8N+3oTgP3vuQiwHimN3zkO3aAfRJzNMVLrGg8pT0H/36h3vMXhwpCXRagou3MM9EBRMY1VtOYHtKxd/T0guVkrzKo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c83747-a25c-4c99-c148-08d610d601d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:14:25.7407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Eckelmann <sven.eckelmann@openmesh.com>

[ Upstream commit 3f259111583801013cb605bb4414aa529adccf1c ]

The QCA4019 hw1.0 firmware 10.4-3.2.1-00050 and 10.4-3.5.3-00053 (and most
likely all other) seem to ignore the WMI_CHAN_FLAG_DFS flag during the
scan. This results in transmission (probe requests) on channels which are
not "available" for transmissions.

Since the firmware is closed source and nothing can be done from our side
to fix the problem in it, the driver has to work around this problem. The
WMI_CHAN_FLAG_PASSIVE seems to be interpreted by the firmware to not
scan actively on a channel unless an AP was detected on it. Simple probe
requests will then be transmitted by the STA on the channel.

ath10k must therefore also use this flag when it queues a radar channel for
scanning. This should reduce the chance of an active scan when the channel
might be "unusable" for transmissions.

Fixes: e8a50f8ba44b ("ath10k: introduce DFS implementation")
Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/ath10k/mac.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/a=
th/ath10k/mac.c
index d68f4f2965e0..5fe6841b8889 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -3003,6 +3003,13 @@ static int ath10k_update_channel_list(struct ath10k =
*ar)
 			passive =3D channel->flags & IEEE80211_CHAN_NO_IR;
 			ch->passive =3D passive;
=20
+			/* the firmware is ignoring the "radar" flag of the
+			 * channel and is scanning actively using Probe Requests
+			 * on "Radar detection"/DFS channels which are not
+			 * marked as "available"
+			 */
+			ch->passive |=3D ch->chan_radar;
+
 			ch->freq =3D channel->center_freq;
 			ch->band_center_freq1 =3D channel->center_freq;
 			ch->min_power =3D 0;
--=20
2.17.1
