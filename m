Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40879C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E313A21521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZPy0qTDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E313A21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387853AbeITI26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:28:58 -0400
Received: from mail-bl2nam02on0137.outbound.protection.outlook.com ([104.47.38.137]:41534
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387719AbeITI25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpG/8vTG2zfdcOzckIYUQZjVCxAZNM4IfsxA+bRWPIs=;
 b=ZPy0qTDfvo4S1BhsK/NPPosmhXexdzD4XAs00Wuks7aEOS25SrJY5IP260wRqLo8DaczfiU/Kuw2bJDrfl/gujnj9852jq2FYVRBXS2y+O6AXn+ZXEIPVHfQj/Zg4i87m7GTej40S9fUqYCOt7+/go9avcgRKnX0KvOw6NvZoko=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:47:45 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:47:45 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Kevin Yang <yyd@google.com>, Neal Cardwell <ncardwell@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 23/56] tcp_bbr: in restart from idle, see if we
 should exit PROBE_RTT
Thread-Topic: [PATCH AUTOSEL 4.18 23/56] tcp_bbr: in restart from idle, see if
 we should exit PROBE_RTT
Thread-Index: AQHUUIxNZo/VJhL9ykObkf5agwTUcg==
Date:   Thu, 20 Sep 2018 02:47:43 +0000
Message-ID: <20180920024716.58490-23-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:qwSqDRI5kC3J4GpjTpPbhGLLyVMZcCUQM3FYN2slMzxN4aJySzLCkSxC5p1BuvyGuSkszZPz2eYYjXS7kY1CtYAQYak/vXiZKni06XOAa+24ya1AGHPJqjQgwDzKH3zBXc7a4N0VmWqbcI3BNEJuj89Fyikx+Q7foV6cHCgklgMa4RP/kFtscQKPLWIFJba1jTIbzfY2+z2yuAX6ajkGAYEGQeKNJz9RpWrM/4jMJ5gyRlejCKmhFEKYOf5Dl4+DgziVMa9gOZ/f4DYeFekaQFTzoOhxbupqz6MzNwPVobV1QV5gIK/k6CIXG/6h4I5xjw8YYz/bpXe5Iy7yjGvzGTRL5TUJZbFUQRXOxf1mZ3p7QYwoT0aejx8LTWSRu6B1VNLSHMyi36JSM+i71yuOuGFhyQn7nEuoShU5fBXk9BOY5UxvEufEF0lQkNxuDdMbPRcDdOweWl26rCUHwoAWVA==;5:8Oe+ngvRropLBnbE+ao+uO9xt9hBxtBUqCUv/GgeJTACxcmBKpusuCMecvtHwMybXb762ue+CBubuoXBmAmp9w+72cMbf3POLPDyY66olLR5+qPTgrRCjjkOc4IGmdXgDu29oIT/ovBpmGmiYYlSKPKoiQzWHwc6tY1hZpzFamg=;7:/hmngeD2F3OY7SwojWvvYb2veM7NV8wqNzkQvFsrxRvRFn9ZU6uTptU/rgLUvP87MfH7jB2V/M6E2oDNZD2EMmdxLVnCS/Va3O7H1bCzWJFKCnKdmilaghmyH/9vE1d3A2wXnRzrjacIerudC1HJ7ZjU8//cfs+9Lk4LbC3Fc95ktEjH0E2CEiVOcMQwXa/p5bWN5+lp3zvYxyBhOecAJkxMObXtXURVfPkKja1nw5kbHQyelMqzWf6uFl77zl8b
x-ms-office365-filtering-correlation-id: 0a1992ea-2362-4412-94d5-08d61ea3716d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB082239F3C339FF277BFA235BFB130@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211936372134217)(153496737603132)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(136003)(39860400002)(199004)(189003)(10290500003)(6512007)(54906003)(110136005)(2501003)(2900100001)(86612001)(446003)(6116002)(316002)(81156014)(81166006)(1076002)(26005)(8936002)(22452003)(86362001)(2906002)(107886003)(2616005)(486006)(256004)(14444005)(99286004)(66066001)(5660300001)(6506007)(217873002)(5250100002)(102836004)(186003)(3846002)(4326008)(6436002)(11346002)(25786009)(68736007)(71190400001)(71200400001)(8676002)(476003)(6346003)(6486002)(36756003)(14454004)(106356001)(10090500001)(53936002)(305945005)(72206003)(76176011)(7736002)(97736004)(478600001)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 9HnnfQeaRwTzY6jExKMySa40xIZYEqA0/erVfGrW5ZNefp+W2OHf0JgC//YET9eWUIPa5gl+vadZ7C0RwPytXwDvVaSa4xyttR/WwgUjgGaSKHQcaSvRWTnk5dw9Hk9TAT0CU9jxX4QLK/LvAwRuwPH551jT5gOCgTTz4PZyw0RMckBs3YhSCsa75D2F/Q0+MYLY154IaNytYa+SVxsfzwbTvKPixDYJgY0XJVj41f4gv9+rOr/QhlFpTVFP0PxPnbJr+YnmYl2c1x557mZTzhYfYyPvC5bqz4PNlcygr0X1c6nMNHKhm/xcoIraXg/pYHyYZ2+F8gddMqbdaSv6g++sf9R8ffELwgKInuKrzZ0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1992ea-2362-4412-94d5-08d61ea3716d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:43.2263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Yang <yyd@google.com>

[ Upstream commit 5490b32dce6932ea7ee8e3b2f76db2957c92af6e ]

This patch fix the case where BBR does not exit PROBE_RTT mode when
it restarts from idle. When BBR restarts from idle and if BBR is in
PROBE_RTT mode, BBR should check if it's time to exit PROBE_RTT. If
yes, then BBR should exit PROBE_RTT mode and restore the cwnd to its
full value.

Fixes: 0f8782ea1497 ("tcp_bbr: add BBR congestion control")
Signed-off-by: Kevin Yang <yyd@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Reviewed-by: Yuchung Cheng <ycheng@google.com>
Reviewed-by: Soheil Hassas Yeganeh <soheil@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv4/tcp_bbr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv4/tcp_bbr.c b/net/ipv4/tcp_bbr.c
index 5880015dee36..e99d6afb70ef 100644
--- a/net/ipv4/tcp_bbr.c
+++ b/net/ipv4/tcp_bbr.c
@@ -174,6 +174,8 @@ static const u32 bbr_lt_bw_diff =3D 4000 / 8;
 /* If we estimate we're policed, use lt_bw for this many round trips: */
 static const u32 bbr_lt_bw_max_rtts =3D 48;
=20
+static void bbr_check_probe_rtt_done(struct sock *sk);
+
 /* Do we estimate that STARTUP filled the pipe? */
 static bool bbr_full_bw_reached(const struct sock *sk)
 {
@@ -304,6 +306,8 @@ static void bbr_cwnd_event(struct sock *sk, enum tcp_ca=
_event event)
 		 */
 		if (bbr->mode =3D=3D BBR_PROBE_BW)
 			bbr_set_pacing_rate(sk, bbr_bw(sk), BBR_UNIT);
+		else if (bbr->mode =3D=3D BBR_PROBE_RTT)
+			bbr_check_probe_rtt_done(sk);
 	}
 }
=20
--=20
2.17.1
