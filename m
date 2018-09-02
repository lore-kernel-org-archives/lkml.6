Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B0FC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAF720652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jqPyQkTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EAF720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbeIBRcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:32:16 -0400
Received: from mail-cys01nam02on0107.outbound.protection.outlook.com ([104.47.37.107]:15264
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728716AbeIBRcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmlHpkE1l21QYM9hd9wUosSAHoQNQ2NUsc9CVlOeBhs=;
 b=jqPyQkTVO9ZB2h37qNpHdtW4l/09b7v62zLBrmyqu9m8+k0jG7MGGMWnzCG6nrj4phjJ5QgtQG96Nk8SvDPfwi0HR6imicSHhTXTHU8EDP3fY8yghINxtJX5oJpcGufuRgd16TflNNpdhbCQI1wVSih2aYsx5MhtppgCp4802F4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:16:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:16:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sven Eckelmann <sven.eckelmann@openmesh.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 15/47] ath10k: prevent active scans on potential
 unusable channels
Thread-Topic: [PATCH AUTOSEL 4.4 15/47] ath10k: prevent active scans on
 potential unusable channels
Thread-Index: AQHUQr8T9OsCX2oxSES72MJ9ylKebQ==
Date:   Sun, 2 Sep 2018 13:15:54 +0000
Message-ID: <20180902131533.184092-15-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:XMc4/rn4Vvi8qYXA4RU9tnV2MQq4HFacr76x+qVzxvqYufLIoQcXOfXKJ1uQxQX2PD3uVvRf/V59e64XQVopa72hQxdnueLV+ZiTqRg5Rgv7ifSPbWZELS3bcwbNCGPIwkXH6ruN6hsEtkn/oMbRqWrQB4weOdnmJkv3thCnQSk/+izvEG+cKS3ZoY43vm2UafBb/F/n0smxPDy5dXD63XuS/vc7u2C3iFu+12HUwEVVb/Kb9EY0fxfjwnHQC32zEtw18Dzof3PYuIbSUuKRg0PuGM1vtnLrWJo7+E5Mbx6sVDnUpbqvb7Wn1jS+oqt7CMg+jeKkPyA0bemjQL4vQRCGxvTDkH3hfi3Qva81Jv8fFEsVfxBeARpiQSWuwNYEunF7fxTOKFFgcMkhc5+sMX0iGQiMD4KnfhM4YmHJ+CfJ33ZbWzc3cIBoSD/wgVmE2qZ9zgvQnDBji0ME4ccKFg==;5:NlHfUzpUnClHmh8lPRNR7+/fcme1sDJNseui1JKMo3DmPLhrAepq86aGvEd6IfNzJl8BFZOKNboCaajo/qlj5khEL4H50/LEO00u2lyFUluBOau8sDeBLunLT4cZbPDiA7RL/CSvhwhoi0PaqJYVAKLCgs5gyEM/ArxO/iFembs=;7:5/rLAdX96g90Fg9Uq8uruqBk+RG41quVxQglFy+I24gnniENwZoUB46qNUgTs13qHEKh6QE9MOzC25dRsoK8Txff0gfR3EbnqNekGm4jxBD6lhVIteTFENyNrhzF2lYzDxB7+aZsDvyBd3MO5HEgt2TfgvsPK6XsoN63mxJCDSJvE67bXzws91f83f3isKdM+CEIMZCsWbpQEtSPRPdmdhlZ/NUgQr0//A7JnDftYJML54MF8bc6e91K/O+vhx0c
x-ms-office365-filtering-correlation-id: 07997a7a-cda7-4072-9fa5-08d610d646a7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB06292DBC100A0B2717291105FB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(8676002)(478600001)(10090500001)(14454004)(10290500003)(72206003)(476003)(5660300001)(5250100002)(106356001)(110136005)(54906003)(316002)(105586002)(86612001)(102836004)(14444005)(26005)(256004)(6506007)(2616005)(6116002)(217873002)(305945005)(446003)(1076002)(3846002)(2906002)(11346002)(97736004)(6346003)(81166006)(81156014)(7736002)(6436002)(66066001)(25786009)(86362001)(4326008)(186003)(53936002)(8936002)(6486002)(22452003)(6512007)(99286004)(2501003)(36756003)(68736007)(6666003)(2900100001)(486006)(107886003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: d2J+mg6HhzvZ7Ex0abg1dJXehoSuU4C983gMiaC9+kyioHA5zb8gcNK9CLdGyOJvkoN7qZ+QAiiWqjsXDTRRzNu2zMQPoEOcUG6I1FrvJifLDFTuNw9bE7emNi2ziyMspJb/YM5zFuy4VBiN0qiZ/c0egRi7E6M4UimFmJ/6b9rarY5OaNBi+4DejpHlLxA0mzLtsTX6iH2NBfPqy+eP8p4GguuXQslhsm8iRWesvBgE3vkKyz+KZjBScn8it2IdA3ZgqOiZMpHvavi5e4NFVkxbCdEQZaKPEsfdYc2egnXQNnwdFgvhiQmbyjqPuiV7v94dDEWzza230Ab8OgqLC2JLm9bFThzdDdMzsgpZK+I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07997a7a-cda7-4072-9fa5-08d610d646a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:54.0194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
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
index 916b9b12edd2..4644357d291a 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -2901,6 +2901,13 @@ static int ath10k_update_channel_list(struct ath10k =
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
