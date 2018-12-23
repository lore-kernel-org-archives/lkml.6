Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B157BC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BB321917
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="TbdpGcrG";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="Vk/3Yjmz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeLWJqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 04:46:06 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:37458 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725847AbeLWJqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 04:46:05 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBN9e3lX011914;
        Sun, 23 Dec 2018 01:44:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=wcyGKt6uaD41GgP+udegyJGkcibB7zysOJHFBKraRbE=;
 b=TbdpGcrGr/4lTE2p9GI4yjtG/GnFUw6RooA2ryYsq9RhcZuMLFCTf9l16iWsInP0yrZC
 maWuzYSilHzdeJWmXq7d7+fQuZI7ZzVrCuA5Ypfr9hyjESlFY+Gnk3cxgSE/SMzEMRnc
 74h4nT37Mi74f/CW8wlccu+kQqmCRKCXylJro3UUXxxZMq4achczmx2eoiCdGEXPUZkb
 S+SLsU9Deq/b7h9tWjhQ42Zw0prAIT7XSAKl4pMHlhY617fU9qZipHxF28z7bmQ5mURG
 v7txWQTC8TZrFTvRfiwb+7aktkLu9Yu78+Fh6Viq+jRtBtqu7kZwcpXjRC3EOoSt+j3K WQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2phnnqbevc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 23 Dec 2018 01:44:42 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Sun, 23 Dec
 2018 01:44:41 -0800
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (104.47.50.57) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sun, 23 Dec 2018 01:44:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcyGKt6uaD41GgP+udegyJGkcibB7zysOJHFBKraRbE=;
 b=Vk/3YjmzBXBbeifG3UiEghzo8PzbfQQuU9Pnl7JGG+fHykMaS8Xc+fB3/i368MC8F9rbFzLvfmf/QdU6V0HFWiwXJYy5L+Acv3YPnjcPF0m8TDET2xdzZTdMDBJVTmIVs/bZyhfrNOMe3I+5cf5oFJ5Gu8mhmwAdFBqm6JwmqPs=
Received: from BYAPR18MB2888.namprd18.prod.outlook.com (20.179.58.203) by
 BYAPR18MB2904.namprd18.prod.outlook.com (20.179.58.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Sun, 23 Dec 2018 09:44:40 +0000
Received: from BYAPR18MB2888.namprd18.prod.outlook.com
 ([fe80::c1de:fdbc:577e:ac65]) by BYAPR18MB2888.namprd18.prod.outlook.com
 ([fe80::c1de:fdbc:577e:ac65%3]) with mapi id 15.20.1446.026; Sun, 23 Dec 2018
 09:44:40 +0000
From:   Yuri Norov <ynorov@marvell.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC:     Yuri Norov <ynorov@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] bitmap_parselist: don't calculate length of the input
 string
Thread-Topic: [PATCH 1/4] bitmap_parselist: don't calculate length of the
 input string
Thread-Index: AQHUmqQfrA6xn2nAj0yLIRPgzAZ/tw==
Date:   Sun, 23 Dec 2018 09:44:39 +0000
Message-ID: <20181223094422.4849-2-ynorov@marvell.com>
References: <20181223094422.4849-1-ynorov@marvell.com>
In-Reply-To: <20181223094422.4849-1-ynorov@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P189CA0021.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::34) To BYAPR18MB2888.namprd18.prod.outlook.com
 (2603:10b6:a03:10d::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [212.58.114.41]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR18MB2904;20:a5m5xLhM0+qye7WqhL6sIh+Ycus6s9G9bJVaVds4y/nZ/dZPWaJyZUKYv9TAo0BBPkbLw+qGYPKaZvCjpAJ02Ls2KEreeiLnavvc32jBlc1M84Tz16E/TUpQcNgSSBI0ACfmPPqv/CLRU92IWMIuSLr3yIZu4qCIEQ8r0amCSVI=
x-ms-office365-filtering-correlation-id: 401f187d-5839-4122-25d6-08d668bb4218
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR18MB2904;
x-ms-traffictypediagnostic: BYAPR18MB2904:
x-microsoft-antispam-prvs: <BYAPR18MB2904790006F4E3B6A79677EDCBBA0@BYAPR18MB2904.namprd18.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(3002001)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR18MB2904;BCL:0;PCL:0;RULEID:;SRVR:BYAPR18MB2904;
x-forefront-prvs: 0895DF8FFD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39850400004)(376002)(136003)(396003)(199004)(189003)(71200400001)(53936002)(99286004)(71190400001)(5660300001)(86362001)(478600001)(97736004)(476003)(2616005)(1076003)(316002)(68736007)(11346002)(2906002)(446003)(36756003)(256004)(14454004)(66066001)(110136005)(305945005)(102836004)(8936002)(7736002)(386003)(6506007)(6486002)(186003)(105586002)(26005)(25786009)(6512007)(54906003)(8676002)(52116002)(106356001)(3846002)(6116002)(76176011)(81166006)(81156014)(486006)(6436002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR18MB2904;H:BYAPR18MB2888.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sDxQpRe2fHYOMPhimw3kV6kXk+gJBXZESTnKm80taJQ1bNOetiHbHiF5rNn06CMabktYZWIlKRCcEnV/iI4MnhKX32CNY082G4U9NQVF8dNj5vPoAujtkcVjkcBiX4iI6eNT9AG9sSIO6pl3hZHrj2+iMj1MewA6gqmiOJzMrvnf/woISzyf7fsAMK8oeXM0gfANOW0oqNaThdc8Z+t2VOwO5jiLS4p9Qfhl4W+VYJ0Ts/ixVtbD7huZM8+B5heZTYFL5B43zJPpnlU3LBYJHfwq3aGsH5f3eEatjzkk8hZ0bZfG7g3buwf36mfzx0GA
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 401f187d-5839-4122-25d6-08d668bb4218
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2018 09:44:40.0305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2904
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-23_07:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=657 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812230086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bitmap_parselist() calculates length of the input string before passing
it to the __bitmap_parselist(). But the end-of-line condition is checked
for every character in __bitmap_parselist() anyway. So doing it in wrapper
is a simple waste of time.

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 lib/bitmap.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index eead55aa7170..ad43ba397c58 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -614,10 +614,7 @@ static int __bitmap_parselist(const char *buf, unsigne=
d int buflen,
=20
 int bitmap_parselist(const char *bp, unsigned long *maskp, int nmaskbits)
 {
-	char *nl  =3D strchrnul(bp, '\n');
-	int len =3D nl - bp;
-
-	return __bitmap_parselist(bp, len, 0, maskp, nmaskbits);
+	return __bitmap_parselist(bp, UINT_MAX, 0, maskp, nmaskbits);
 }
 EXPORT_SYMBOL(bitmap_parselist);
=20
--=20
2.17.1

