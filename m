Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B297ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B751421477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZPaTaH0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B751421477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbeIOGrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:47:04 -0400
Received: from mail-eopbgr680131.outbound.protection.outlook.com ([40.107.68.131]:36298
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727999AbeIOGrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjwRnbtu1pl47+wCBz/1dia1PDHYLWSKHbbZgDqyVqg=;
 b=ZPaTaH0bt77B8fqbPu+JxaRs9MnxaCBarMF0z0823RrMeNmY+0xTNpOa9jzdjy7SSXayf7wBJu4n/BO2Eeek5FOd2TTI4/X675j+jqgTOkduSzcb/3UNrW7rRQVwhl4KgnrdNec0vAGlc8mb7bj7Ym3HRKWrqLHrH7NGwzOKjPU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0840.namprd21.prod.outlook.com (10.173.192.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:29:58 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:29:58 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Eric Biggers <ebiggers@google.com>,
        James Morris <James.Morris@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 14/92] security: check for kstrdup() failure in
 lsm_append()
Thread-Topic: [PATCH AUTOSEL 4.18 14/92] security: check for kstrdup() failure
 in lsm_append()
Thread-Index: AQHUTJOdaTRtbm+dMEquWzIy0NLyhg==
Date:   Sat, 15 Sep 2018 01:29:58 +0000
Message-ID: <20180915012944.179481-14-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0840;6:1hw3/2yBwCMwihhUhmjGYPQx4QQp69qX2aPiYZbJd2wIOF3eR9MgrXo/DKMkSSP+YzfAGAWWCmR08elYXKs+qkcXiUlhI3D7c8/Zy6bzJP5A3ugQ6KFEISQLV206aWVmlqMeB36GHWbEP91n3+LLCSIw9IjgpLKxpQgRoSK0hFgO7emHamjraCE8jDhGLQ7IxW6DhTXZx2lbwOoMCy8bsH4v60YfAJ7V4nkyyLq9LchkBr60v4cIwpKCXC+oSuObg+zNBtC558mbkHfRGYacAidqHuATLiPpnAHxbKiBV2TZIsjlbPIXvPDQ7ZYiSYaYVC4OyVxU21iqkI5JG5MK8Xe+pX7SOIavOEpgk3igAe9HmngUO8dQ9Ut1s/awieSb8H1qKyUiQ9aCCS2PksfEARPLUHDa5snIlpK9iGH6vCs3CECN8iuGVMesZJOXYpbVmi6FkGorXeRyvjTqOOAmVA==;5:BwWpALO7iCTH001X4023uhBoWa01wVN0UjZH9vkVTCCerNPPgHejfcgKyOw92gptAiCfDtw8J9ocRHR5cwI4kbbXWNnrhomG7Fe9DvjBgO4BK6vOIg5r8UE/RkOOBeTMdEDcEWRHsKCxhkn89YBnNdbjiA1ow1ghnJ4zkGAyYyE=;7:ulkRcRje6qf1N+cvbQOo4+oImatToO5/Tf2Ufts0qxBHFOA9GxRcWVQfP/npsZwAgF1Mzg/U3NjwJIS7+X4rQ5oF0f+GHua6XwDWl3erMUb8IRG+8xfHUTQmTF7Q1kHXepZQUTngxatNPPPFTUYZZbnzDtzTSEZoLiOYsjuVJh1KEgV9O3Sc87e6/HzUNbb4QfnEv8i+WtKWYIOWC/p7rkc9wbR59EPFNjykdOsm/7yaixxfZm1H50vtzUXgvAmx
x-ms-office365-filtering-correlation-id: 8243b649-eb1e-462e-7741-08d61aaabfd4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0840;
x-ms-traffictypediagnostic: CY4PR21MB0840:
x-microsoft-antispam-prvs: <CY4PR21MB0840EE748F0656355ED8E886FB180@CY4PR21MB0840.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705)(211936372134217)(153496737603132);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0840;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0840;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(39860400002)(396003)(376002)(189003)(199004)(14444005)(6116002)(81166006)(2906002)(446003)(478600001)(3846002)(8676002)(106356001)(105586002)(10090500001)(22452003)(8936002)(486006)(2616005)(72206003)(36756003)(11346002)(81156014)(186003)(26005)(14454004)(6506007)(217873002)(4326008)(25786009)(256004)(107886003)(102836004)(6346003)(476003)(1076002)(10290500003)(86362001)(66066001)(6436002)(6486002)(86612001)(53936002)(54906003)(2900100001)(15650500001)(97736004)(7736002)(6512007)(305945005)(76176011)(99286004)(2501003)(5660300001)(316002)(110136005)(5250100002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0840;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: w/DCEfOQlxxtlcmSVmn/2YQRKVmIPwaPouLxCRoVVFj7slpUyT27brpKj75QLYCfeN7eWUTKY4ZRiCZ578M5IgyvotZpPSOa5jzJACH1qe36YaHztZP8fPNZj0YgztttPCg4TzYaW7UzkOnuYIPa+GX9eNlCPim6m4YTCZT4/1YoPvdgi5mdu0yapUUu8h0jhWXY7mskj/SZLvCYhAnHxo7WBSV5NEd0oebTQgQkkO/vqmVGuOD86tc+TKevf6Q12ORIUcrXsYV3xffn163DJa2hFfnr811Fx0xMza2ArfpXyR+MhT+3KmUGetlkWB/OyuXwOX5uBdfSXFFZrXHCnpm3tXYiVowmV1hvTy3B3ao=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8243b649-eb1e-462e-7741-08d61aaabfd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:29:58.3701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0840
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit 87ea58433208d17295e200d56be5e2a4fe4ce7d6 ]

lsm_append() should return -ENOMEM if memory allocation failed.

Fixes: d69dece5f5b6 ("LSM: Add /sys/kernel/security/lsm")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: James Morris <james.morris@microsoft.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 security/security.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/security.c b/security/security.c
index 68f46d849abe..4e572b38937d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -118,6 +118,8 @@ static int lsm_append(char *new, char **result)
=20
 	if (*result =3D=3D NULL) {
 		*result =3D kstrdup(new, GFP_KERNEL);
+		if (*result =3D=3D NULL)
+			return -ENOMEM;
 	} else {
 		/* Check if it is the last registered name */
 		if (match_last_lsm(*result, new))
--=20
2.17.1
