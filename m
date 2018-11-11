Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E49C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7C220818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="l72bhPxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7C220818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbeKLGVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:21:05 -0500
Received: from mail-eopbgr810048.outbound.protection.outlook.com ([40.107.81.48]:64280
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729569AbeKLGVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+Te3xIUl54XZNd+gbtVEMEoU9B6LfblLGAW+fb/NQ0=;
 b=l72bhPxoDDJrspJNdxslxUrZsCUOr4iZTKjFY26ZAePEQ5kDT9VPc33lgc4WC/p646uBSrq/X0vAaNDakgdQLKgzl57w7dZfAKT755wrQQv6nPt3IGwONOKhADTgO/tCKi11JyvXIX/aAOAiUsro1oC2Hl1ib7maoU87A8eaAnM=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4968.namprd05.prod.outlook.com (20.177.229.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.12; Sun, 11 Nov 2018 20:31:30 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d%4]) with mapi id 15.20.1339.018; Sun, 11 Nov 2018
 20:31:29 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4 09/10] x86/jump-label: remove support for custom poker
Thread-Topic: [PATCH v4 09/10] x86/jump-label: remove support for custom poker
Thread-Index: AQHUeYjk7FAtWS1/GUKZtF+dnLuv0qVKrQKAgABa9oA=
Date:   Sun, 11 Nov 2018 20:31:29 +0000
Message-ID: <24530A8D-6646-4746-8056-8C1D7CF4ED69@vmware.com>
References: <20181110231732.15060-1-namit@vmware.com>
 <20181110231732.15060-10-namit@vmware.com> <20181111150553.GB3021@worktop>
In-Reply-To: <20181111150553.GB3021@worktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4968;20:bAHvqdwfJCeVPkpYVpVS2dJhiFWRuF0zC348ZKEZPL/40i0g0huttrZB8OhfLdX+9wUFSsJa2nAEg7IgKk1bsr4dTyVDUlm9QAiVtYS4KUx8/IeXPc+8wtwESAKmRkNA+B3V0375NdmEws2SivV5Defq8KcG7azG9INogsOZZGA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bdc38c3d-a2b4-40a1-4840-08d64814a97d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4968;
x-ms-traffictypediagnostic: BYAPR05MB4968:
x-microsoft-antispam-prvs: <BYAPR05MB49686FAF33AF0C34A5A5B17AD0C00@BYAPR05MB4968.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231382)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4968;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4968;
x-forefront-prvs: 08534B37A7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(376002)(136003)(346002)(199004)(189003)(8936002)(76176011)(83716004)(6916009)(71190400001)(71200400001)(3846002)(26005)(6116002)(102836004)(4326008)(53546011)(14454004)(5660300001)(68736007)(8676002)(478600001)(316002)(6246003)(6506007)(53936002)(82746002)(106356001)(105586002)(66066001)(7416002)(186003)(97736004)(81156014)(6486002)(6436002)(81166006)(229853002)(54906003)(6512007)(36756003)(25786009)(99286004)(305945005)(2900100001)(7736002)(33656002)(86362001)(476003)(256004)(11346002)(446003)(2906002)(486006)(2616005)(147763002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4968;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jzR5XuhAqZOJ8bwNXuMjk4UeOLfXRuO7lPu6nqPUahVrKgBzNRTLRKQBycj150shfbR6SUZC20eUAZuufhmf+Vj0Gn1sN+R+F+DutLjo7CTF5ApEOTAtI/aBKzmu4NiGQW6+2LqNNTd1fTmuM87AFhGpNzIV5Iebx0P05b4Mi+JGr0rLSaI104OWKwf9OlB0kgfYiAMzFdiACmg8Rt7R9tAqR0rbYLCxYXaPRfclsvJxIToLP9hz9y8DQ7+mDr37heSEusDcp6FKzqaJNKBQ/RkrEc93WGoxcYDsElg67Hl1R1xNTYw3xjqYybwxM0CbncmjOJkKCF243rggvgLC4EXIeO9dqdnJ25KSIJi4FC4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <387EB33F13153F4A8A7A7515721DA3B4@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc38c3d-a2b4-40a1-4840-08d64814a97d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2018 20:31:29.5859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4968
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra
Sent: November 11, 2018 at 3:05:53 PM GMT
> To: Nadav Amit <namit@vmware.com>
> Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@ker=
nel.org, H. Peter Anvin <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.d=
e>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.co=
m>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, D=
ave Hansen <dave.hansen@intel.com>, Masami Hiramatsu <mhiramat@kernel.org>
> Subject: Re: [PATCH v4 09/10] x86/jump-label: remove support for custom p=
oker
>=20
>=20
> On Sat, Nov 10, 2018 at 03:17:31PM -0800, Nadav Amit wrote:
>> There are only two types of poking: early and breakpoint based. The use
>> of a function pointer to perform poking complicates the code and is
>> probably inefficient due to the use of indirect branches.
>=20
> Right; we used to have a 3rd way, but that is long gone.
>=20
> Nice cleanup!

Thanks, but I actually should have got rid of the early_poking variable.
I will do it for v5.

