Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FCFECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA11E208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FjB7vGEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA11E208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730856AbeIQIk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:40:59 -0400
Received: from mail-by2nam01on0102.outbound.protection.outlook.com ([104.47.34.102]:24891
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730901AbeIQIbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+jTRIAVeVhgD/AkDW6xRtUZ8wceZUO6NoIXuSleg4w=;
 b=FjB7vGEjbrB8BGKYhsStv/26VL3Ikvrca87UzoKYBaeO8aOFyTGh1XjWliJHf3as8PwjS0BX4CHqh+JqnzHjQWMGLxuAgpnj5XH/YVtkHKDZzp2ep81JiKrQaZQiE/Hhm7gotW0X0cyvo8+mN5+4gj9+ILhAUz+ztax/u89fapc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.6; Mon, 17 Sep 2018 03:06:20 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:06:20 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ben Greear <greearb@candelatech.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 40/57] ath10k: protect ath10k_htt_rx_ring_free
 with rx_ring.lock
Thread-Topic: [PATCH AUTOSEL 4.9 40/57] ath10k: protect
 ath10k_htt_rx_ring_free with rx_ring.lock
Thread-Index: AQHUTjMZMC0XGQIKq0SCSBHsKQJK3Q==
Date:   Mon, 17 Sep 2018 03:04:07 +0000
Message-ID: <20180917030340.378-40-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:bWeDM5dCk8uqU3b6XGg3EIFqLrv6aX9cs2rv0oMtMhWiSdF6nEzvNqqhj3JUFUcj3PZOlZRvVT5ffBcUYMRqIU2xmsJSxS2s5D4798wr/W3gR4oHnOopHEw/gyE5RAZjClp2w3z9ixqjjTQPUW3kHUho/RLoMeVSLvyqlTHBOn2LUGJrPdQqTt3qI0/tcoqnd2xpynZr8UYgSzHC55fA8VUYyHvaMn2+THZtWlCXOnqQ6VrOdVJmVsrxZG1sKODpiRry0eAPgDJUZTKzl6l2OMoC7CcGDjm7CKbVuqa1U5VQm3TD5kMgbmr6I1qH6rAAqAuX7lz4HuR+hqkJhxjFpUvnE8eRKf2ve+KmYBL7OFu2yqYSv026HICMKsqQ3xE95krgkUsVmcIWkf/eV+IBPR90lphQGb9w1V4NIjRNGW6odDIKVZayrQaRXlzgmF8pDB4jVWzWDgpCbhSXoygEAA==;5:XsNWU2NVwbjZjzT+p3tpfRoZUpGXdcnOtkuvDoeximfEi3nGFyD6geQGQ8D7230avzZiTB6ncdVpq+aZB35BU8Wbrl+BKwPFOsu7awLS+d+iyJTU2XG4zfmEoFFspkbpeiJnjwiWv+JBAKS46O1vzul8TZUfAT2vAww54MtozO8=;7:8j7b5dL1Um1qf+io8B3Avj0y3RjKAqQHisxNMBASp4Q9ZO0HmtGirwtqaoc0EcIaN52tFUcVQnB81S+hCMF+6I5FRlbKm4Cwacfi3CO0kttnS1STAayt/AmHEkWcOrlf7o4rY62HcS0k3Unl8/ci3RrrFqYqB//IW1SaUXT39Hckc16egERCy5sKzhoZNpQ5UqQ/L48sAzBjvsjz/6cBVTPlSLa+Xw8+T+gKkRjNSYyjWYyV4xjvxB9RvPcpl5+Z
x-ms-office365-filtering-correlation-id: 8313f8a6-32c9-4876-91a6-08d61c4a8b3d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB0757175EB4182BD74337C3A4FB1E0@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(8936002)(68736007)(476003)(575784001)(10290500003)(446003)(53936002)(11346002)(6512007)(486006)(86612001)(6436002)(1076002)(256004)(6486002)(2616005)(14444005)(81156014)(81166006)(7736002)(8676002)(217873002)(478600001)(305945005)(3846002)(6116002)(86362001)(4326008)(106356001)(66066001)(186003)(36756003)(99286004)(76176011)(102836004)(107886003)(26005)(2906002)(5660300001)(110136005)(54906003)(10090500001)(22452003)(72206003)(2900100001)(316002)(14454004)(97736004)(105586002)(6506007)(15760500003)(25786009)(6346003)(6666003)(5250100002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: wz7hrtFYmh15A6M/iz4zFEtrNlg9D0pir6A5EKUgXHTDJlPMXmn9Y5IxhFVY27sE6MoVbSnOomaT/jqLcYSa8NcgaKZPCgiOx47tAFwqFn8pVntpJcXibP0d27grZBd2V1G19mvrK5xyB4VYsI2HQHCen1pEz2nQp0vDq3A4v+vh5ArLyLyyLlm6WjUxzxfD+yNMlffSHCluvZeOoBnq2vDLN+1oB6Mzq04jyBp8G6oebNUa++LZojV5M3kMErYEmFjfkUcqvfAEfsTaNY9CVvsE5BRh6XGjgNafhmg+ACUSy73WOYKHWLTqHNnhtaxGJDOQaTPkKfLGN8qhSK760NfI3QnAiyIMYKNRKHP2Kvo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8313f8a6-32c9-4876-91a6-08d61c4a8b3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:07.9146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

[ Upstream commit 168f75f11fe68455e0d058a818ebccfc329d8685 ]

While debugging driver crashes related to a buggy firmware
crashing under load, I noticed that ath10k_htt_rx_ring_free
could be called without being under lock.  I'm not sure if this
is the root cause of the crash or not, but it seems prudent to
protect it.

Originally tested on 4.16+ kernel with ath10k-ct 10.4 firmware
running on 9984 NIC.

Signed-off-by: Ben Greear <greearb@candelatech.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireles=
s/ath/ath10k/htt_rx.c
index ba1fe61e6ea6..a3c218047597 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -214,11 +214,12 @@ int ath10k_htt_rx_ring_refill(struct ath10k *ar)
 	spin_lock_bh(&htt->rx_ring.lock);
 	ret =3D ath10k_htt_rx_ring_fill_n(htt, (htt->rx_ring.fill_level -
 					      htt->rx_ring.fill_cnt));
-	spin_unlock_bh(&htt->rx_ring.lock);
=20
 	if (ret)
 		ath10k_htt_rx_ring_free(htt);
=20
+	spin_unlock_bh(&htt->rx_ring.lock);
+
 	return ret;
 }
=20
@@ -230,7 +231,9 @@ void ath10k_htt_rx_free(struct ath10k_htt *htt)
 	skb_queue_purge(&htt->rx_in_ord_compl_q);
 	skb_queue_purge(&htt->tx_fetch_ind_q);
=20
+	spin_lock_bh(&htt->rx_ring.lock);
 	ath10k_htt_rx_ring_free(htt);
+	spin_unlock_bh(&htt->rx_ring.lock);
=20
 	dma_free_coherent(htt->ar->dev,
 			  (htt->rx_ring.size *
--=20
2.17.1
