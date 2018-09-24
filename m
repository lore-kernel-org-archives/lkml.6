Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B95C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94022214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Tw65y5Yr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94022214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733265AbeIXUvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:51:42 -0400
Received: from mail-eopbgr690114.outbound.protection.outlook.com ([40.107.69.114]:33005
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733120AbeIXUvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnV6NyMHgof1eAcNwZnENyYgl3qyu6UMaBP3BQL9S6s=;
 b=Tw65y5YrHN/zwwQRO1epvkdYvbfx97LYKd5mgycojM4C48rK8gzbO91MVzBfBKxtB0aHQSNOxQ33ySSkee/xawT9mfEEMVlliBZ8czEzeH1EpGGjp6/dIW9zEfwJVjW7Tr5lBVE5EhVV4Go0NggLancH9VvdGGFAV6sIeHPq0nQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Mon, 24 Sep 2018 14:49:02 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:02 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Dreyfuss, Haim" <haim.dreyfuss@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 59/76] mac80211: fix WMM TXOP calculation
Thread-Topic: [PATCH AUTOSEL 4.18 59/76] mac80211: fix WMM TXOP calculation
Thread-Index: AQHUVBWsVWyHquSJqEOz9CPWyjpU+w==
Date:   Mon, 24 Sep 2018 14:48:37 +0000
Message-ID: <20180924144751.164410-58-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:y+bLg+an4COxvCgm7CdEC/YQaxrFUpyVzj5yzpjEiwFXGR14RKAy+mTErHmzRhpYpEfuiLLUaSjWAlhyxL1n3y0Ry7U+g71Pd3WV+UUOZjfy1Czg9AykKDnujXN3mvzpqlhL8iHxKZogqmAJ0UlI2sARfjnG06+pJBvsw+NZTaucq/bIykYy6BDJfntmuhWkPLC++5R8UshyUaXXN8sa83QjHrx7hidMborkFYgRWTH6ES0qjkj6CU0klAuMLy5yI40y8sP/KfVjOwtkpaH9/M03Wbr5KfbYXNBXWme2x5vOZLsFp3h8htbOXmxPxqVrkABkFSQTTVk30bar2kUEv4qgKp02EyNnCef2Sj2HTsc9hcPf6VgkWNqnMEQpcv5EQQWzRyCNUDB+eLBpNQIg4VlGde4306vZ6ToCqHxUNfpLSBDgTskVCRojyLG4yQj1z2oJaJ8TS9QHwhTiZ6GL1g==;5:GhkFhrGBeQETZnLEhj/MgYF7gb6thQji9MOnH7LyvAegtL9zJ7A5y6ImOnVsI+HuRbMaD8w73u9WOrfJ9fob7f9WxDuxeME6U+HQk6dIf99iH+S+XFzl/ymvVcRqbrUhPOhg2StdRQV5lp7Xd5JQ/UR4H+BZJgaGlidJlDaWJcA=;7:v+yNyrRPRBLmZyARBtHHAnCZeoyX/QAlBpn39MhWW4lWHDgSg7/nbujT5M/eyBz/ordV1gq9qeHYWOeNyjfNO0dvCVqcQDp33bfuexFYdXEwaqHC4U3O9C4asTgOYq4A49pD0lnPSYIyYiCL2NPLlk8p6bcEv+rPt9hHlCLu1JvS8Jii5BvAiBTLgzCCc9vYglXFWGbv5RRU3XyC7x0padd0saT0WYDPWI1+n7HVVVGExV0MQ0f41JZUi6ABfF7s
x-ms-office365-filtering-correlation-id: 8ef93f9f-8c00-4694-464f-08d6222cde77
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0744B3D2A7DC054B15BCA382FB170@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(39860400002)(376002)(366004)(189003)(199004)(11346002)(446003)(476003)(86362001)(186003)(81166006)(6506007)(8676002)(81156014)(6666003)(5660300001)(486006)(99286004)(53936002)(305945005)(6512007)(6436002)(2616005)(71200400001)(71190400001)(68736007)(6486002)(102836004)(10090500001)(7736002)(36756003)(97736004)(86612001)(316002)(3846002)(6116002)(1076002)(217873002)(14444005)(256004)(54906003)(110136005)(107886003)(10290500003)(4326008)(478600001)(22452003)(5250100002)(26005)(8936002)(2906002)(2501003)(2900100001)(66066001)(72206003)(105586002)(14454004)(76176011)(25786009)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: e11RL2ZPBq8xTAWnk9nuriu3P420szKwI7nZpBE62Rb7t3oQgMfBeOtqaROACvxTKsGYxgKSc1/RefPJ9WcCO2A74CQ8PXqoMIpCYtnnQok0mrdWIWZH6oJfJL5NHLjnnzn37taA95NpljigQB3/qMRUvEB6Y8KhOI4+q7LAQh6KPeyWs48Yl1OPbY03viHQ9PzoJL6yeepWReCKioRwdwjW8ocYvzIFTexTa6uA1F5q6QWs+tQbnkTrU+UrEJ+/LTSpGGqNDpfKHyNJ4e79VPaHvgNcwUrREaE2QOvFnsOqTU3PIolqrWLBEpTNeqjSLxhq5LWB9HZr30El//j43tlwLQ9S4nSGQP/zYtgEdJk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef93f9f-8c00-4694-464f-08d6222cde77
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:37.1128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dreyfuss, Haim" <haim.dreyfuss@intel.com>

[ Upstream commit abd76d255d69d70206c01b9cb19ba36a9c1df6a1 ]

In commit 9236c4523e5b ("mac80211: limit wmm params to comply
with ETSI requirements"), we have limited the WMM parameters to
comply with 802.11 and ETSI standard.  Mistakenly the TXOP value
was caluclated wrong.  Fix it by taking the minimum between
802.11 to ETSI to make sure we are not violating both.

Fixes: e552af058148 ("mac80211: limit wmm params to comply with ETSI requir=
ements")
Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/mac80211/util.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index c80187d6e6bb..93b5bb849ad7 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1151,8 +1151,7 @@ void ieee80211_regulatory_limit_wmm_params(struct iee=
e80211_sub_if_data *sdata,
 	qparam->cw_min =3D max_t(u16, qparam->cw_min, wmm_ac->cw_min);
 	qparam->cw_max =3D max_t(u16, qparam->cw_max, wmm_ac->cw_max);
 	qparam->aifs =3D max_t(u8, qparam->aifs, wmm_ac->aifsn);
-	qparam->txop =3D !qparam->txop ? wmm_ac->cot / 32 :
-		min_t(u16, qparam->txop, wmm_ac->cot / 32);
+	qparam->txop =3D min_t(u16, qparam->txop, wmm_ac->cot / 32);
 	rcu_read_unlock();
 }
=20
--=20
2.17.1
