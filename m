Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885D4C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48CD420851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="DVemv9NI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48CD420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbeLLXkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:40:31 -0500
Received: from mail-eopbgr690047.outbound.protection.outlook.com ([40.107.69.47]:15481
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726214AbeLLXka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 18:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7lUIV+PNkOtdzWOzWWSd4BgU7Pp75pv4v+Peu6Hk0c=;
 b=DVemv9NI6fSodv/viZ/INdYOQ3urrELFj0rqAkWFbamIgXbYzq7kcx5rWN/4x4fcfG31Wb++72kyRYeDX/H8AH0Ygih8thfKQsYy9LTuLQYJdoO/RlEOKWMU/eQBxbvWIboXsEmqUP6mvTMUjDihnUklkTqhbQDaOx//f6/tum4=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5496.namprd05.prod.outlook.com (20.177.186.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.9; Wed, 12 Dec 2018 23:40:25 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7%4]) with mapi id 15.20.1446.006; Wed, 12 Dec 2018
 23:40:25 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jessica Yu <jeyu@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "deneen.t.dock@intel.com" <deneen.t.dock@intel.com>
Subject: Re: [PATCH v2 2/4] modules: Add new special vfree flags
Thread-Topic: [PATCH v2 2/4] modules: Add new special vfree flags
Thread-Index: AQHUka9VVa9O1a3XNkKRZw/OZUeHJqV7xLuA
Date:   Wed, 12 Dec 2018 23:40:25 +0000
Message-ID: <3AD9DBCA-C6EC-4FA6-84DC-09F3D4A9C47B@vmware.com>
References: <20181212000354.31955-1-rick.p.edgecombe@intel.com>
 <20181212000354.31955-3-rick.p.edgecombe@intel.com>
In-Reply-To: <20181212000354.31955-3-rick.p.edgecombe@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5496;20:tiXxtNV2zd23REaHADyFeG2SPoh95BU69EAk7FoiNPo8Fwt4IWu0uAfipP3HKCfjCi+iiLVDzHWmEeDbsS+q73z4d7tUqBqOFa5Oednc4CNJ+lG/MMcOP8T0X6uZdjep0tJKJeJQG4rDGEr4MIISVje7NfSSdD8klHS6n9fy4gM=
x-ms-office365-filtering-correlation-id: a5b51b72-9c37-47ab-044f-08d6608b30c6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5496;
x-ms-traffictypediagnostic: BYAPR05MB5496:
x-microsoft-antispam-prvs: <BYAPR05MB54966491913422F0A36DEEB8D0A70@BYAPR05MB5496.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230020)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5496;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5496;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(396003)(136003)(376002)(189003)(199004)(305945005)(316002)(478600001)(25786009)(6116002)(3846002)(2906002)(54906003)(5660300001)(99286004)(7416002)(97736004)(14454004)(66066001)(33656002)(186003)(26005)(7736002)(229853002)(36756003)(102836004)(476003)(6436002)(486006)(68736007)(2616005)(81156014)(11346002)(81166006)(82746002)(6486002)(6246003)(53936002)(71190400001)(86362001)(71200400001)(83716004)(8676002)(4326008)(105586002)(106356001)(6512007)(6916009)(76176011)(446003)(6506007)(53546011)(256004)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5496;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hK+dXmkUzSZqBTgxLKvlQst8b6Rr2Wx5VvBu8vEtKQoMyEf3CiLGNLei/zMbmlCi0cz7cmtF5wvNxhkWWwX7PWT+AYg2Zanzu2p0JyZMM5i496Bh8MQhk8hq7T6nCznIp8dak7t577h8rbLTEaIWJXNJDEF3O5IOzBAKrGeCCSGh6U1hBfsS17Z7XOYHKzeonNzGPIf/GCoc6hBe0EtxJjAMMENVAp8wyKSyQkF1MPxGyxOMOAyIvnIQw+meXc1yfgvLOboWNQfqwZee4HH4UiebyTEqORXjzCoEex0tx2UK54bjd2oWaP3okJzaYQ71
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ADD48BCB096691449093B6E0F0AE63DE@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b51b72-9c37-47ab-044f-08d6608b30c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 23:40:25.0915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5496
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Dec 11, 2018, at 4:03 PM, Rick Edgecombe <rick.p.edgecombe@intel.com> =
wrote:
>=20
> Add new flags for handling freeing of special permissioned memory in vmal=
loc,
> and remove places where the handling was done in module.c.
>=20
> This will enable this flag for all architectures.
>=20
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
> kernel/module.c | 43 ++++++++++++-------------------------------
> 1 file changed, 12 insertions(+), 31 deletions(-)
>=20

I count on you for merging your patch-set with mine, since clearly they
conflict.

