Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E271FECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF1720867
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WkpqEJ6N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF1720867
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388035AbeITI3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:29:34 -0400
Received: from mail-dm3nam03on0093.outbound.protection.outlook.com ([104.47.41.93]:53376
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387928AbeITI3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHS17MiYLZJGuUGLsqP7Atv4DhmpnOvfd/5lWldrVPY=;
 b=WkpqEJ6NDX0Tmzke3fFM32L4o9KMV4bJ4Pm7EUp8hOI3M531tJpk/j4Bh/sU1Jo2ou1WwTjS0LZfXpXV7WD3MqKKY9izktwmz/R9uQoA6csaEgYyQ/c9NXCp7q5FLVMSB0Y5BQSIj8Sj7dBwqvE9LxAqFgmOImUkXohp5QttxlE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:48:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:48:22 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bo Chen <chenbo@pdx.edu>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 37/56] e1000: ensure to free old tx/rx rings in
 set_ringparam()
Thread-Topic: [PATCH AUTOSEL 4.18 37/56] e1000: ensure to free old tx/rx rings
 in set_ringparam()
Thread-Index: AQHUUIxTSWOfIhpCh0ixdCxyUaZd+Q==
Date:   Thu, 20 Sep 2018 02:47:53 +0000
Message-ID: <20180920024716.58490-37-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:/QTth5HlornuPwl7HXL5sGO1iE36SGCyeVjefgm4vnbp3euAbynEgqH5XfZzZHTjudki1tS7JPfbORsMbQ41vA+Xi8e4eTAD3yFPN0F/WW2z+p4YQTG0kyg2MYYg1Hm9E+oZzxSZL5ltaB9tnZBN2yIBFYQisM3fEgWNqzF0VaD5UL2ILfZjoTTZKJnAP1zQ1ULk+dQBYqtcMwx5V/LrajC9Sud1f72ObPapkuy4ulxSgJck8bPGWHqO9mSsCPeLC29eCzLCKxVER2chR8pMMTuUANGNk+d08jfSSu1MpmAUqDfTxaXGgYAKcY5ALNDg4KemK35/G5g9CaRwn0N66rArIU7FLQ+rGR+9fDoF/AETTUquQL9XTON0kYimc71FGwM7xkX/j+5QtF9jH7+2EI8uPSf8ctIAEeeetOB7Gpk1rBe/H+kMUye6WJuxxKQjISrVP6iKi98c+9Bjsn1pvQ==;5:kygpzljSlpp9UvvgfI4OLY041yF3HiVil99RQa3wUH7nf9TS2F97GNt7cMhRtum1/V576ugoywK6FLYJkTDKDnNbjdhpmEaAVMu7rjY54/ScszQmv949DcmgNAwV7XsOfk40zNVZYr5yNfgZ9/pLC6ZJdxyzgsbc3x9tI/04lgA=;7:St2fJYP7eFs/ylPoX0HO5LJ4Xfol03MyfLjQeASKXY7Z0hQVN3Q4yrSW3xatDbaxcdxy1UuDe7WNZZW7VzbBw1FP6Hgl1Ufr4jokq3DOItG7JxAE59uqR0RyEw+abIaaBf3MmKEw9eMVGAwC7zPSsK6RYdaWVQn63zQUqKDpjtkx0ZcnBtdIPnwMSERRrM5l0rx+it/U4bPlv4Iqp1cTR9okSEGd0z+qI3LB7RLQA+g8tuxIokpU2SPdsrZM/aXw
x-ms-office365-filtering-correlation-id: a5450fab-fa45-48b1-0429-08d61ea387dd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB016501496BDA4772746C6474FB130@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(240347492878265)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(71190400001)(71200400001)(22452003)(53936002)(66066001)(6436002)(72206003)(97736004)(6512007)(478600001)(1076002)(36756003)(5250100002)(217873002)(10090500001)(6116002)(2501003)(14454004)(3846002)(106356001)(256004)(105586002)(2906002)(99286004)(8676002)(81156014)(81166006)(86362001)(8936002)(316002)(2900100001)(5660300001)(76176011)(7736002)(305945005)(446003)(11346002)(2616005)(486006)(86612001)(476003)(68736007)(102836004)(6506007)(107886003)(10290500003)(6486002)(6666003)(110136005)(54906003)(186003)(6346003)(25786009)(4326008)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: zmkIO4kD9qWWvWRwu12p1wMCBF/uG5AO1u26qMth/OClANFGoDni9mQAelXR/03oSw9M5K5LpEMWoLvSQRC7okrSORrEpca6eU94Dp1ze77wIrXYNqy2eeHyEl2WrjFudHCO+5wCV4TI00ZjL8QkmpiY0VZjn3VoM9tXvCm3WNSLbyC8pGcJVPatn3QVLgFoOwWUbH8NX3ja0vnsdDo2kMtdupr1mzJw/9XL7iuyBCPCvW0Y3iTkx5uLGFXDnhBQzK/byOJX6DqsSgxx3XUCaZy+0d+X922cSvnN0ltFyc9++qn/Yc68ZZiBVrgc+dLTuJ7LQKt3BmiQiwyTuPkS6pl95IjOU8PnyMv6o4yc/vw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5450fab-fa45-48b1-0429-08d61ea387dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:53.2731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bo Chen <chenbo@pdx.edu>

[ Upstream commit ee400a3f1bfe7004a3e14b81c38ccc5583c26295 ]

In 'e1000_set_ringparam()', the tx_ring and rx_ring are updated with new va=
lue
and the old tx/rx rings are freed only when the device is up. There are res=
ource
leaks on old tx/rx rings when the device is not up. This bug is reported by=
 COD,
a tool for testing kernel module binaries I am building.

This patch fixes the bug by always calling 'kfree()' on old tx/rx rings in
'e1000_set_ringparam()'.

Signed-off-by: Bo Chen <chenbo@pdx.edu>
Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net=
/ethernet/intel/e1000/e1000_ethtool.c
index c1e4e94f100f..2569a168334c 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -624,14 +624,14 @@ static int e1000_set_ringparam(struct net_device *net=
dev,
 		adapter->tx_ring =3D tx_old;
 		e1000_free_all_rx_resources(adapter);
 		e1000_free_all_tx_resources(adapter);
-		kfree(tx_old);
-		kfree(rx_old);
 		adapter->rx_ring =3D rxdr;
 		adapter->tx_ring =3D txdr;
 		err =3D e1000_up(adapter);
 		if (err)
 			goto err_setup;
 	}
+	kfree(tx_old);
+	kfree(rx_old);
=20
 	clear_bit(__E1000_RESETTING, &adapter->flags);
 	return 0;
--=20
2.17.1
