Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B0AC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B9D205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KZ37XEZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B9D205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbeIBRXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:23:17 -0400
Received: from mail-eopbgr700118.outbound.protection.outlook.com ([40.107.70.118]:63159
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728127AbeIBRXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSvESSbCTo9tPgCiwjdlqBawM3Gp5Yk00U/h1Rva9Ao=;
 b=KZ37XEZEbbCd+OWDUIarEKvPR3Wyhijn8/eoWhB2wjuVMR3kEz6CDc+WtVNUELYyY3ZlY3prKTffrRDl/ZNG3oXhGi688jT/vKge7X3sLNhN2lcnlqL5QCDQt9X7Dfq3JGl6VjkbfXVqe8+RBEc4AMA4EZxqhgJm4oKXmQB70jc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Sun, 2 Sep 2018 13:07:09 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:09 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sven Eckelmann <sven.eckelmann@openmesh.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 37/89] ath10k: prevent active scans on potential
 unusable channels
Thread-Topic: [PATCH AUTOSEL 4.14 37/89] ath10k: prevent active scans on
 potential unusable channels
Thread-Index: AQHUQr3RiVqiQCqIyke8eQfTlZX2Cw==
Date:   Sun, 2 Sep 2018 13:06:52 +0000
Message-ID: <20180902064918.183387-37-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:/VvBz7WpEzitt+HqpDULxSQ8qHmzGZq+dYIF+5Hczjz5eg05d07crSKaut2gZCliJkpfg3FRS/1YtYqa8YnSRujfv/T/i6BbRPhrWq4SpNsGRdXuzUya7gThuNI7Ae5upGEa4pj4EuEqtmtN8nMvuUfUT70fSu+MQTSA1WEf1xpBL8oggKkVbBjogo+qCeMeAMilIcyRF2VCKGzxPRq41txxWRhNUowHH28Ag5s9ITcDByG5EgGxwvixdovIEmwTIdHcdkZ8vsAvEvrhcycbfekU5G+32pT3kOiAmzMf/C7uyp3nWK5JNI96CFsqD7jLSLhJOu87iK36olXxj7vAbNkvSFMNmsIAtMHdQkISS3SuHABnnq3ggUyJrRN0tyjSbs/chbZi+J7sp3aE5WKClJD9SPXDoJgwWOnAh6Ij+gg/GhWitYD526ioZ3U7feizEaGui+ga2VPYSUey/AfJcQ==;5:SqeZkpitimVe/xGH3uhzEK7O7b5utecw5boTHAqZuyx8tNfcRsNDJOG+pl5aL0+VX/g9izBKO/iIVgHEBHF6GbZqh7R3SjTCLyTZoVLgEpKKASnYWmH7DJyA+x3ExATOiGeWENzuQ0Wy0Y6+p1K71VGL91Pu9cG6XpDqHB6oyGc=;7:ptu4wn+eAk3fmhhHSo2sry9mdaJ+DCU3v2vB2HSC/adyrAa23TCA/ReNuqwktB/ek0Wq9sLE4xw9A+hhKwOxcWpPvJa92KlnuZM/u1PkoGAisFmbK7dBbW4O5s5zUGV9QfX4GQYQl0UL/oxnIzlO65RZB5DI7mudOtmU790p4wm5xOtV/AQq3sdxLtyC/vvKII+QydT3rXMPOQhHapcpYoD1qE2a6X0OVeudDu2izzaUjzZOMgQ5xRCbd9lHIWx0
x-ms-office365-filtering-correlation-id: df903221-a25b-4182-5fd1-08d610d4fdc6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB085607F5818398B29B787223FB0D0@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(39860400002)(366004)(189003)(199004)(53936002)(81166006)(11346002)(81156014)(446003)(476003)(4326008)(5660300001)(25786009)(86612001)(8936002)(26005)(6506007)(6486002)(102836004)(2616005)(86362001)(8676002)(6512007)(14444005)(6436002)(107886003)(66066001)(256004)(10090500001)(217873002)(14454004)(3846002)(478600001)(1076002)(72206003)(6116002)(99286004)(305945005)(7736002)(22452003)(36756003)(76176011)(105586002)(486006)(106356001)(2900100001)(186003)(97736004)(68736007)(6666003)(316002)(10290500003)(2501003)(110136005)(54906003)(2906002)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qsjvaTxoVMjzRApCjkrmZDxEULTbUO/kh7bG5ypHsl1Oe9L7+GhXaGcWz5S0fVZ15M1DqjXKoMKbpPbzSUCTPTC8nMPIBSxxnJq9clYnn7RPl1Xpu4TH9vWZv3ox8kVCS8GfEIwzZYF5imyc304IUtxBnABw+WtB+38YZRhkSYHYgVxmXSgz3t8BrcCs1ZvXVxYS580v0FZHtCml6TMenDBJOO8rlzumqnmKMHk5fYGTS7NrFgCIHymrmwRcBVPE6exHME8YXkJezvRUStx15l8xBwQvINU8Ffqn1SFtK4ajxrF6gITeHI5dEZ/KS2hulkhQLcb1L3Hk+jfzRtbp8EAB/S4f5tsWfWJNg0i0vc4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df903221-a25b-4182-5fd1-08d610d4fdc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:52.4868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
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
index 52ebed1f55a1..6fa9c223ff93 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -3074,6 +3074,13 @@ static int ath10k_update_channel_list(struct ath10k =
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
