Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50484ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6FC214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Iq48syVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6FC214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbeIQI26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:28:58 -0400
Received: from mail-cys01nam02on0116.outbound.protection.outlook.com ([104.47.37.116]:31712
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729070AbeIQI25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fs8lAEEU1cx49PqbKWtLGGHyesiwwaVIgcJauAd0EqY=;
 b=Iq48syVWUtKk7OdEwQS9wY/e5pf3Rb7vN3GtykX/EGDUBz/v9uk38OuOajzRPfyjHSQJKRCyWYDhbAiXjLsJyfgVbuw+cTJZKydyZICVvKgMEGUZkPDlYhAZWqQGMhDkPgFZtvZraApBsYywU9hN4nch+t4hoex63h4MwPMWsJI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0118.namprd21.prod.outlook.com (10.173.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:03:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:22 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Colin Ian King <colin.king@canonical.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 128/136] ath10k: fix memory leak of tpc_stats
Thread-Topic: [PATCH AUTOSEL 4.18 128/136] ath10k: fix memory leak of
 tpc_stats
Thread-Index: AQHUTjK8id8UlEV2hUOpu8nunVukZg==
Date:   Mon, 17 Sep 2018 03:01:32 +0000
Message-ID: <20180917030006.245495-128-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0118;6:bnb/XUS6kBrnZOe1OFg/i+JNE5kO/9UzVZhy1WEky8Uujg0vQ9ABj4kTHpXiFvCzR0SgkhQEdqzCwVen92EmpLubSZZP2xJLzTv2fs7N7u4fde9vsApxB6f5fqMH5WBIYcOVlhKD5IlJBmpoUm0TSJHFZIIPWgAaJZSwjDYykL1m+7cyEGVTo83/u+LYPYLF1GvGjAZnLj6QIijBtJStsqIp7jn4XvjsbVnbhLy7CLEr+eM5gYj88NU3sFNs3inBllCqKvIpsg23zR7ij2pnc2mY9GJE6E/MoJI9Nbws6yq8nd0nkYs9NEk9BX2G51cu3kd3Ud6RshLNJGxuULR9uksYi6E56FNJPvcIOUnn8u4PX9O4rpyIMITvEEyG8qtKbCvXyaLzUs1A0u39EGyS6Z5tcRvJ9/cp4ZucWi8p0+ig38JnYq7pwKcAnyHWZci+yQe2BJcW5uo67ifE5VeZfg==;5:ckNCVWihwOSmlFTqD0XwPuKE+OikGr5bDN9BvIYJnnbssr9IeJvcQfNAJGijHEKf0PffaJDfihjHBTT5ifytb6ktp1x0DdFYeVfmD9rMznM9cdSzzznu6zdXSRymWTHLcqeb9JC635eptxvMbZ6NgTg1m7V/1QvhtHJdhw+IDcg=;7:iDkkPoVpuBPObikSFq87VPzMR85Kwb2MTlcGL0oL9aSdwP9FNQMy7hkt/p/wG3D/FcAo2i4uVvwd04L8oVQWlr+Lc6PTvuNiHZaglHziTnksvb72RAanGoxb+hjqqrYrjTQw0t2M10ECJXq42VmM+beN+dNxXw4i3nRPXIKr/4Chr3VZqX2MEcSkNQyHea6pNQCmkpP6jwUV99I6diP7AxDSFGn/kutGKoGHqgdnz2q1JmEAEXBT+ELxWPBccPOk
x-ms-office365-filtering-correlation-id: 3fca2c50-e645-4262-62ae-08d61c4a20ce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0118;
x-ms-traffictypediagnostic: CY4PR21MB0118:
x-microsoft-antispam-prvs: <CY4PR21MB0118E3E03C4F465CA545467FFB1E0@CY4PR21MB0118.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(198206253151910)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0118;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0118;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(2616005)(186003)(8936002)(10290500003)(66066001)(97736004)(102836004)(36756003)(5250100002)(256004)(3846002)(6116002)(2900100001)(476003)(2501003)(14454004)(54906003)(446003)(217873002)(110136005)(486006)(11346002)(6346003)(8676002)(86362001)(26005)(72206003)(81166006)(81156014)(86612001)(478600001)(25786009)(105586002)(2906002)(99286004)(68736007)(6666003)(6486002)(305945005)(7736002)(76176011)(6506007)(6512007)(53936002)(22452003)(1076002)(4326008)(6436002)(316002)(107886003)(10090500001)(106356001)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0118;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: dHjv86vUNefjhsmInAVdpy7Sjl78nveP90MfXIShdYDhCrLVb4+zen9ue1xX7jhVYsqi+NZza1agpLvIAkHhb5OF3sXshfCb+R7cpuseEXPzR9LpmcvJCihOM1BbwcU0g3tX67V30tRp/7KJylxFhMRNVHkEUIE06ZmOXXus+zCpdvNMjSr+Dc67UekWVaB94MV3c6WO14QdObfWA/NcoHMdU3n7UBQs9rVAMNrhKxC0lDC0v/cgX2xqXQ+mWihObgj5tv3AwIECp1p4ZZyrqiQnyt7PdEsokPo+zqlblYgIYR0KPUAgNw9KfzHAiT6y6UqFQIt/KYl+rPiBzhwclMpundTRq0+t9Z41ygfho80=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fca2c50-e645-4262-62ae-08d61c4a20ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:32.5258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 260e629bbf441585860e21d5e10d2e88437f47c8 ]

Currently tpc_stats is allocated and is leaked on the return
path if num_tx_chain is greater than WMI_TPC_TX_N_CHAIN. Avoid
this leak by performing the check on num_tx_chain before the
allocation of tpc_stats.

Detected by CoverityScan, CID#1469422 ("Resource Leak")
Fixes: 4b190675ad06 ("ath10k: fix kernel panic while reading tpc_stats")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/ath10k/wmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/a=
th/ath10k/wmi.c
index f97ab795cf2e..2319f79b34f0 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -4602,10 +4602,6 @@ void ath10k_wmi_event_pdev_tpc_config(struct ath10k =
*ar, struct sk_buff *skb)
=20
 	ev =3D (struct wmi_pdev_tpc_config_event *)skb->data;
=20
-	tpc_stats =3D kzalloc(sizeof(*tpc_stats), GFP_ATOMIC);
-	if (!tpc_stats)
-		return;
-
 	num_tx_chain =3D __le32_to_cpu(ev->num_tx_chain);
=20
 	if (num_tx_chain > WMI_TPC_TX_N_CHAIN) {
@@ -4614,6 +4610,10 @@ void ath10k_wmi_event_pdev_tpc_config(struct ath10k =
*ar, struct sk_buff *skb)
 		return;
 	}
=20
+	tpc_stats =3D kzalloc(sizeof(*tpc_stats), GFP_ATOMIC);
+	if (!tpc_stats)
+		return;
+
 	ath10k_wmi_tpc_config_get_rate_code(rate_code, pream_table,
 					    num_tx_chain);
=20
--=20
2.17.1
