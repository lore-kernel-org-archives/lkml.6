Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C05ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935C120693
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cu9p8kkh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 935C120693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbeIQIjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:39:11 -0400
Received: from mail-cys01nam02on0126.outbound.protection.outlook.com ([104.47.37.126]:15104
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731028AbeIQIb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aVCMsnAlczn7w2Psoo4zYvPXn7AGP4xkPstCH8YIos=;
 b=cu9p8kkhBvalXrQG7BkMY7swoR9LDU1whF2jCv/yLPX4CUEq70YkVJUnclWafuP8w6gMOgj0IJTW5Zha46BSa5r5log/9cIoRydUd9gkec+2SymYtMkCpaN8ucmRVe85gGF+I6hjNMPEEkFsDTXVd2QVNcriZ+NV53/htZde34U=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0742.namprd21.prod.outlook.com (10.173.189.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Mon, 17 Sep 2018 03:06:27 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:06:27 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jessica Yu <jeyu@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 53/57] module: exclude SHN_UNDEF symbols from
 kallsyms api
Thread-Topic: [PATCH AUTOSEL 4.9 53/57] module: exclude SHN_UNDEF symbols from
 kallsyms api
Thread-Index: AQHUTjMeKYxDwsDqj0CEyvCfoLnYYw==
Date:   Mon, 17 Sep 2018 03:04:16 +0000
Message-ID: <20180917030340.378-53-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0742;6:GnnHkgiNsLLooms9adV5QS87l1EhtzB4CH6w6G10yGx4ZJoHRV1RUJGJ8XTlkEcnaAJ0NujFllNWHCyPwmE/0mDIDJo1hvvhCtRvznTPJpVmsCXMg4U19cDDNKvwBujr+7plLsLCOB9bCObGnUUbHkMPBOhJ4FcT7VHZWJQA4HHFk4LHjwp9uDJ9dstH/HQ/sa25GWAr8qP9htxLEE9BPzuvRnOl/27HSAKhPYdOZoCOQZHZ+ZlgZGr9Df7u/kupDDJZcpsxLXxubvN6sroHHxsT57XhI3HcOLTQmYPGuWUdWGTvJThmkfiC8/q/3pvF0oVeiyAYfw/OeI56VmiC+rIsPBHV6CpbMgNBkRPUn+jRiuzgnL9FgPw0efWcLolx13HU4C7mkiSxgzqqzbB/5pMSYrUIscpNq10B68+k3oRKL2q6cZHix3C0UvSi8gSRU5WMLz1LF0EVf72tQ0Bx/A==;5:2geZk6Zk9NTZupsbmnhVTMaBgX51XD4dKjrDCXkIaq35GaHLH71VEkJl+oC3ZyBqYZoxIfr+DZdR7N5V15qcXK/r75Xn8yPtEVwxI2r7AXlnjg4xCcYv7EpPogscCV8UQYJIsbAXIUgHujF/daFKOjFjbTvFBbM8EFrqLl1voxQ=;7:QFh1tYGizycB47n2szBodqRFeNOCk7RCu41h0Ow7HdTpHUD4+Rv48744N/2SNKHZfUtkBjxs1EBkB4/igPjPCEkjfSLuXODMBqge9X9xG4WWoEVtI0kH2lb7+vTj+6atO3JvjeL2MBdCGT2gyn7fpmAfKLmvmgVTOpSOhvpiwY/AMJfvLhCwe3QADDFsc75p+QmWRnaQkpLpzXP3YE0UqlpiYvGedixG7LXqrHrn2IQexaA9uvCc8k12/LQlV/+s
x-ms-office365-filtering-correlation-id: a93afe15-e785-4f51-ed4a-08d61c4a8ee8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0742;
x-ms-traffictypediagnostic: CY4PR21MB0742:
x-microsoft-antispam-prvs: <CY4PR21MB07423C5EA1C4BACBEDB15B8EFB1E0@CY4PR21MB0742.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0742;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0742;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(366004)(396003)(376002)(199004)(189003)(6486002)(6436002)(6512007)(53936002)(4326008)(3846002)(217873002)(25786009)(2616005)(1076002)(14444005)(6506007)(186003)(6346003)(11346002)(446003)(26005)(2900100001)(6116002)(486006)(102836004)(256004)(107886003)(476003)(86612001)(86362001)(2501003)(14454004)(97736004)(66066001)(76176011)(6666003)(316002)(54906003)(110136005)(99286004)(68736007)(10090500001)(22452003)(81156014)(2906002)(36756003)(8676002)(8936002)(81166006)(7736002)(305945005)(105586002)(5660300001)(106356001)(10290500003)(478600001)(72206003)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0742;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: sdX18GJD+Hw6zoBlthbQnMUDgm2hDsMlIaAB/s0nvnmfS3TB16lE2dSTenwDMD7ZwYo1SdR9MNC8Qge2Y2gLNJaPjORxMFANAW2ds5Gg1/u0s8f/LiA12izxqdH0GdZvFtKDAhVZIH1knRcWlS/NDir1zTzTbspHiSV868sPumR1AeVWQn8w+eXPV1y7odqtq/cKeGL9iD4hqxJtDPu9nK+rIN4ob7jPqYNhrjyVAglV6wy7JmwX05noK+dvWDikTDCYMyZjrchwhHK+qis810oXRLk7J8WjOvr62ePeUHYtSvhrI1S51N+KAwVpcjsWjsWgQmIZo/DKSoC6qRznMyaurReVC3QBYPNa06E9crQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a93afe15-e785-4f51-ed4a-08d61c4a8ee8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:16.3520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0742
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
index 0651f2d25fc9..2325c9821f2a 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4011,7 +4011,7 @@ static unsigned long mod_find_symname(struct module *=
mod, const char *name)
=20
 	for (i =3D 0; i < kallsyms->num_symtab; i++)
 		if (strcmp(name, symname(kallsyms, i)) =3D=3D 0 &&
-		    kallsyms->symtab[i].st_info !=3D 'U')
+		    kallsyms->symtab[i].st_shndx !=3D SHN_UNDEF)
 			return kallsyms->symtab[i].st_value;
 	return 0;
 }
@@ -4057,6 +4057,10 @@ int module_kallsyms_on_each_symbol(int (*fn)(void *,=
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
