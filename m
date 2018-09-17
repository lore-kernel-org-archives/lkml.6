Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27DEECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61503214C3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SiMpxDQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61503214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731717AbeIQIeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:34:06 -0400
Received: from mail-bn3nam01on0135.outbound.protection.outlook.com ([104.47.33.135]:35136
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731099AbeIQIeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTI0qkdGM/nWOJB7k8MKaiQQnSjhNarqTnE71u6ugD0=;
 b=SiMpxDQOq7fbfzdobFfIy5jFXshmcw+ogb7FEqOM2RUaL+7+UVk0gRBkhXnwYXbeKOVgtDNf5q7myCau5vDn0pkS3hkoe49v5Hzi9VFMKKFuL1P5E7Uhf/1hwbbio0gpQn2ztApAaX65mznldrsvzK8j6LPPd/GsGjvVCAn9Dmo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.13; Mon, 17 Sep 2018 03:08:28 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:08:28 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jessica Yu <jeyu@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 28/29] module: exclude SHN_UNDEF symbols from
 kallsyms api
Thread-Topic: [PATCH AUTOSEL 3.18 28/29] module: exclude SHN_UNDEF symbols
 from kallsyms api
Thread-Index: AQHUTjNZ8ymDdhrARUm2Vka8aQrGUQ==
Date:   Mon, 17 Sep 2018 03:05:54 +0000
Message-ID: <20180917030533.592-28-alexander.levin@microsoft.com>
References: <20180917030533.592-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030533.592-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:hKKDW2OeEv/Y6pEQlFuYIKj4WkE6cjwRW2NReVa4+UnbW+f7OPTHlI6PjmeGyfaKwlE7JU09rkvksgryz8r+e1W3WJP0Xbwhm3hvdL2dA07D4f5+o24MCEYMp97gGs+z0nx7YNGwclsrSdJS4JnP/Yv4X7ztzPiAwJDsPs1HZIdGNXdDAtTsl8Im14mCXNvyz6HJQajm0kFcfxA/YjE7TXcXECk2xxP3G/TJ48ySGlkg2qhOu2tMCDluLIAExEUk3zFpL0xJekH4L2KDQvt1DtXjc258tBXD90P8IdlShFLD8mwiunSLSz7kly8Q8V4edYbZ1ANNsQbhXcOspwVbq9vFkTBEHr7ahScJ5p5ygzc5MWm5fUeca9Pc+KSHugPTEQdIqTt+2WtqlbGueGJiaHosaYtD0JOUZG1mu3TUOz859muxZ5k++1LPfg4pc+BOZ02PUMLymjodFr64T38JVQ==;5:0AVebNCjOqpF/BsC2im+NPlEqp4AW+j0ZfQjb/0sEY/adLvB+fuDX1p9N/q7kFimu28fpT5YcqnE/EZQ3tpHjzU3kRiVzjDcbcR9V01Ph2nh2lhNDZkz97GznaFWCj/vU/VOj/Ls2e0jqlqQOYOiCakU88fsB2kBrfXwhFmt1JI=;7:CmauEpD4C3HKwzWg/wB/ww2oLM0SvxnFZOP69HJZrwDNwO9m8h39/61eU0GlzG+qqTMLOzjebYZPslhlv4LNYxOaWNnbrRMeCx92jenCkMNUvMQtiwWu9Z/jUd0ljIZH/aHuAArJioFyPT9HfFNxLLGOq4LRsCS3Qj5MTEtlePj5rAFf+l5qVP83UrmjlwZ1ZS/AgV/WctaXMNTGD/oq2exkPlNVkVZa+AEU03FZmnllclhKOVj1u1Lp12UQuwBC
x-ms-office365-filtering-correlation-id: bd0ef6fd-77f6-4901-7a2e-08d61c4ad76e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB08211A4349A7494A8D8CF1ACFB1E0@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(396003)(376002)(136003)(366004)(189003)(199004)(5250100002)(53936002)(14454004)(10090500001)(6436002)(97736004)(68736007)(7736002)(8936002)(305945005)(105586002)(106356001)(36756003)(10290500003)(81166006)(81156014)(72206003)(6486002)(8676002)(99286004)(6512007)(478600001)(2501003)(2906002)(446003)(217873002)(14444005)(256004)(2616005)(66066001)(6666003)(2900100001)(4326008)(107886003)(86612001)(5660300001)(3846002)(86362001)(110136005)(54906003)(186003)(316002)(22452003)(102836004)(6506007)(25786009)(26005)(11346002)(476003)(76176011)(486006)(6116002)(6346003)(1076002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Qx69eYHr3av+kvrNDIjeY5kg5NXp2K8DAbUaajAb7fCXwVojm0TyRoVmrenjZJT9Z9FDAzOiwhBFvkDkxAKo7gRMiYb0VrwaGoOrCK4TiXatG/JAnuE+fMJ9GrYep0Uo4xiGePcT9rsSvIBh1yXZKFXGoYOdctJmOQbsSN2YOEM5bL3BgpFgE3qPVbEIm2sCNh9kbTVXDAzlAthWzaKR5Jr5TrnrB0Ppk1iJkPG4mfPivRVp73vqwgO+Cb4NjTkAbFCMvtVtjSgEvt3s+o2WcuxAR4BDHdeuodl2e8N4oAnvE48IB4IgnC1EcEFVkNx9p3YaA4ZqGtoEBUpccB2CU7bl5qmIc+70K/tx4HurGLo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0ef6fd-77f6-4901-7a2e-08d61c4ad76e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:54.5138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jessica Yu <jeyu@kernel.org>

[ Upstream commit 9f2d1e68cf4d641def734adaccfc3823d3575e6c ]

Livepatch modules are special in that we preserve their entire symbol
tables in order to be able to apply relocations after module load. The
unwanted side effect of this is that undefined (SHN_UNDEF) symbols of
livepatch modules are accessible via the kallsyms api and this can
confuse symbol resolution in livepatch (klp_find_object_symbol()) and
cause subtle bugs in livepatch.

Have the module kallsyms api skip over SHN_UNDEF symbols. These symbols
are usually not available for normal modules anyway as we cut down their
symbol tables to just the core (non-undefined) symbols, so this should
really just affect livepatch modules. Note that this patch doesn't
affect the display of undefined symbols in /proc/kallsyms.

Reported-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Jessica Yu <jeyu@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/module.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/module.c b/kernel/module.c
index 737d53099360..bc417377930b 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3592,7 +3592,7 @@ static unsigned long mod_find_symname(struct module *=
mod, const char *name)
=20
 	for (i =3D 0; i < kallsyms->num_symtab; i++)
 		if (strcmp(name, symname(kallsyms, i)) =3D=3D 0 &&
-		    kallsyms->symtab[i].st_info !=3D 'U')
+		    kallsyms->symtab[i].st_shndx !=3D SHN_UNDEF)
 			return kallsyms->symtab[i].st_value;
 	return 0;
 }
@@ -3636,6 +3636,10 @@ int module_kallsyms_on_each_symbol(int (*fn)(void *,=
 const char *,
 		if (mod->state =3D=3D MODULE_STATE_UNFORMED)
 			continue;
 		for (i =3D 0; i < kallsyms->num_symtab; i++) {
+
+			if (kallsyms->symtab[i].st_shndx =3D=3D SHN_UNDEF)
+				continue;
+
 			ret =3D fn(data, symname(kallsyms, i),
 				 mod, kallsyms->symtab[i].st_value);
 			if (ret !=3D 0)
--=20
2.17.1
