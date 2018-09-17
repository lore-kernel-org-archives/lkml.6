Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CF4ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF5D2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nt+KoW0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF5D2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbeIQIa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:30:27 -0400
Received: from mail-eopbgr690116.outbound.protection.outlook.com ([40.107.69.116]:54124
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730502AbeIQIa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAWDwN+LC+dOL5gT0mknHOpkk4CKs5llMJbh1kRlsgM=;
 b=nt+KoW0H0HKVc6TPn4PbIURS2ebIepM5kdU56wXIcd1ND+DmOk6Ha9mRKbSbrmPtA1yWVaee1ynvzRmnisOxCqjB9sk3OkEH6PCU4YHFJsenO13NllYBz1UgzzCIfwwObc50XwYgi6GVIIzIO80vWw0Enat5D+CJtdMNRg0hDTU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0133.namprd21.prod.outlook.com (10.173.189.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:05:02 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:02 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jessica Yu <jeyu@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 79/87] module: exclude SHN_UNDEF symbols from
 kallsyms api
Thread-Topic: [PATCH AUTOSEL 4.14 79/87] module: exclude SHN_UNDEF symbols
 from kallsyms api
Thread-Index: AQHUTjL6AdFnEvE7jUuIxJiiUczqFQ==
Date:   Mon, 17 Sep 2018 03:03:15 +0000
Message-ID: <20180917030220.245686-79-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0133;6:gOiAtEhTZib2RXOV49sHPCyyuigUrc1wC8nib2yvRWj9IAPU1NffsrR8IwtipES6LNDQnJT4H8jK7DCR9vD76GRoKyZzT6zABv9jco+cRrcaOO+CIMTKkLrGPv7SlpYu6SaEKh9Ui2QjV5Ty8+b3fYtDQxB6dXgJ3SAKVwTCCW7lGKxCL3k+E5FlaJ8Pp1JwjO9MU79LCCn83STW6UFQYggSRIdvpcg8PJ5WG+/4Gl0gPN4p78Hn7u9IEXXPqns5GbpgQIm5l5/1Aw7Pk1H+HK+4UKTVqHAmZvqlP6XpX6R1W+YO5fPIiaKLn2REzty+LT5O6hoFtord3pOKgjxqoElZC3kBYAUgRQDK4R9GhX8JE2QWBKWxss66wDJXriuiKsrL8S7Xlz0rT0jpSvV/bOtXgG80a8X57zW4qinNthVDKps3yjtLJE1auPFJh+FmFKOFe36Z8/de/zxsqth5oQ==;5:92WHsGuS+YO0Ai7tszfQF+NOMoMkyLCyNIFQe23A+DWQJaaMBgVmk+lvq604dYsvOr1xboRnyEmxnZD88N5C5YhHgwOIQa3CXc9VE6aA8MJRQ4wXBUIBISzCc2vf83tsRA6f9/yXhXiUfeSp5H1IQtWyQX4dhI14RehOPKsKwps=;7:ui4Z8GiFabvp32bbBbdU738c2HAaujQ2Q9GAMa3ITQTYPrcia3IbGcm1KBLDjZsOq3mQ5hN3HzK5qeiHW+LgzGR3aV51l1+k5zK37yJtmGyyI98RIJyZPIuVLBowCvX/gZwYqZTl+Sxw52/SWkzinJgs0KmQ6L8+gQdztmGAKA6V2FfPxltPhrA4Y0P0V6UKtUQTg6UIM1s14G7iQcOW3OgxLVdqW+zxpI/7DWck6tkl42iaYHSptPhiRDKWw6qx
x-ms-office365-filtering-correlation-id: 894b7c9e-ad9d-4dae-91ce-08d61c4a5c53
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0133;
x-ms-traffictypediagnostic: CY4PR21MB0133:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0133C89FF9DD3A4260C5AC34FB1E0@CY4PR21MB0133.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0133;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0133;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(376002)(346002)(189003)(199004)(102836004)(53936002)(8676002)(486006)(476003)(3846002)(6116002)(76176011)(10290500003)(97736004)(217873002)(256004)(5660300001)(107886003)(6506007)(478600001)(110136005)(2501003)(10090500001)(14444005)(305945005)(7736002)(446003)(11346002)(36756003)(2906002)(1076002)(22452003)(5250100002)(2616005)(26005)(316002)(106356001)(25786009)(68736007)(86362001)(575784001)(14454004)(72206003)(105586002)(99286004)(6486002)(6436002)(6512007)(86612001)(6666003)(81166006)(81156014)(186003)(2900100001)(54906003)(8936002)(4326008)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0133;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: o0LOL/gzx6oTgsMQOGY1bzYZ58WonFfA7iDTlJvQSHkl8aRl5J4AOgR++hHDvTMlArcIwsGkwgwNI8Z4i0gklR61vX5H7VwLyYFitofGdjMOoa1SjkCZu8ePGzwG4DeJ4So6txQB1V0/1EgUdkwSEJI2OVKt5Rv7E8toa9yY0a2RKZI1MP64LdR4YoVJJVxMHuICZd8MLK+W6aqRu37TdU7KzUOQgT83AgVknBLVV6HK4V9aLw+HarGxRKRAa9FvQBrqYLyygPo5Acr5nGQk/xH0m2719QCmoibpIX0ChRVp/RMnhcAhGELLI1BlRIWTnra9ljTXybNmXeC+xAHmgAdS9tgCKnduIY32lzlMg1E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894b7c9e-ad9d-4dae-91ce-08d61c4a5c53
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:15.1808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0133
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
index 321b0b1f87e7..2a44c515f0d7 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4058,7 +4058,7 @@ static unsigned long mod_find_symname(struct module *=
mod, const char *name)
=20
 	for (i =3D 0; i < kallsyms->num_symtab; i++)
 		if (strcmp(name, symname(kallsyms, i)) =3D=3D 0 &&
-		    kallsyms->symtab[i].st_info !=3D 'U')
+		    kallsyms->symtab[i].st_shndx !=3D SHN_UNDEF)
 			return kallsyms->symtab[i].st_value;
 	return 0;
 }
@@ -4104,6 +4104,10 @@ int module_kallsyms_on_each_symbol(int (*fn)(void *,=
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
