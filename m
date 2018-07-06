Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB14C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA07321480
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BrQvMdw2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA07321480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933666AbeGFQfD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:35:03 -0400
Received: from mail-eopbgr690071.outbound.protection.outlook.com ([40.107.69.71]:38144
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933305AbeGFQfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtKtP+TxhhYBKnymYJqfXiHPU+nrXs/DRzBV+yF2LS0=;
 b=BrQvMdw2dcdwc7yHNNlYXLaqISB0bPEdAXC60svuQQLQZQ7EfQUi3RgXrpgL2i7juBz2TFKw04hAWm3uUkm1+rfflSGmQD+TnWPAJTlSH+iJlPl9pQu7cwPLEnymaMTWTbTc1mdfn5ykx3IOTm9hcVQf0b142G/pFQ80yFqEVkw=
Received: from CY4PR12MB1557.namprd12.prod.outlook.com (10.172.69.23) by
 CY4PR12MB1943.namprd12.prod.outlook.com (10.175.82.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Fri, 6 Jul 2018 16:35:00 +0000
Received: from CY4PR12MB1557.namprd12.prod.outlook.com
 ([fe80::f12d:d6e:3e65:94e8]) by CY4PR12MB1557.namprd12.prod.outlook.com
 ([fe80::f12d:d6e:3e65:94e8%4]) with mapi id 15.20.0930.016; Fri, 6 Jul 2018
 16:34:59 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>, KVM <kvm@vger.kernel.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        =?iso-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] x86/kvm: Enable MCE injection in the guest v2
Thread-Topic: [PATCH 0/2] x86/kvm: Enable MCE injection in the guest v2
Thread-Index: AQHUDwbQVJASIuAAi0qqgMVkBCBVzqSCb5ew
Date:   Fri, 6 Jul 2018 16:34:59 +0000
Message-ID: <CY4PR12MB15577E48D6CCF6DAF3AF538CF8470@CY4PR12MB1557.namprd12.prod.outlook.com>
References: <20180628173808.25885-1-bp@alien8.de>
In-Reply-To: <20180628173808.25885-1-bp@alien8.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [2601:345:301:c593:91ac:c631:500f:be6]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR12MB1943;7:VgK+SyVdjX1djGyIOmY9UorPhNvGtAC4QEO+1e6nl2n1YCi3kOPpzOBcfoY02o1t3Bl+FVvmyhHvDsMOZa7TPxsRiLozKVBDlKGQqxmqYyXSfgrHvBRhEMEiYLXvGOQCe4EIT87fUIgzrggSYxsM+iG38dx86yl7lH6hhbJnvuCjFCXJ/lUYh/wEFywzyHqVbOYndo4Y5B2Aqza126h6IRkNqNGu5HZsIPjHA3x7/iPeA7iyTIF2QgWpJALaCMNs;20:zmuGqfDf7n+lLssxmGE2QPpg/XfiqDUQ0xrr4QEQ3pzyLO2XrmM/lv3pfXSxAFxJRUt/ztvbXvh3M2j1zWaiMNwlljG/2v1YaYuNDsYuqziYMpeTI0ub5kBzMtISECVX6TyZyN65hAnCWis/Zl0fD6VZdF0SfVwzyjwbPBetzmsGlvqTpDl+IEGHUFRMyBtOnEA4az/uQZ8DDzGN64e3IZX/yZEeITqbVePXMScodO8iYvEwr3cnJVGKdfrXeXTo
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(376002)(366004)(199004)(189003)(13464003)(53754006)(486006)(446003)(11346002)(305945005)(25786009)(316002)(476003)(99286004)(33656002)(186003)(110136005)(54906003)(2906002)(74316002)(46003)(6116002)(8936002)(5660300001)(2900100001)(229853002)(55016002)(9686003)(6436002)(6246003)(4326008)(102836004)(7736002)(106356001)(105586002)(6506007)(53546011)(8676002)(53936002)(7696005)(76176011)(97736004)(81166006)(81156014)(14454004)(5250100002)(478600001)(72206003)(256004)(68736007)(86362001)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1943;H:CY4PR12MB1557.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 120891e8-678e-4279-c17e-08d5e35e6a7e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1943;
x-ms-traffictypediagnostic: CY4PR12MB1943:
x-microsoft-antispam-prvs: <CY4PR12MB1943D96234D120FFB5E93795F8470@CY4PR12MB1943.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231291)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CY4PR12MB1943;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1943;
x-forefront-prvs: 0725D9E8D0
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: b6VxO/oA1VUOB54gXhinHb2B/4DYhgkphOVkd/R6iT0UcxyFiTgFk3C6NtPA+uP7qxafYr8nRGSsOyXsBiIAOs6PWd23iJwP7wGx/V683gOpsrliQo88ZXSL1H7t9aLFbR7d3GIgz3VQxEeUKp6baOmGAcOf9b5/7CXHPMwqwCtTtqbrHIDjlQV38xgT4e4WHZOuHvyAjTteIqSZzvrqCTnxHcfvIK0kQz3jsNsxy6TuUScTLnDeWk3dViIoCFbDhFHJsYctCMzYI4jV04AUMaGliI1GvJgt5H74XtiR/o4x1awpnHNAhGzCMUXsYXiH9/YYFuJfpe7mC+TA5klGLbVo/wSVg1dJu2FnKuxu7gA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 120891e8-678e-4279-c17e-08d5e35e6a7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2018 16:34:59.4666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1943
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Thursday, June 28, 2018 1:38 PM
> To: KVM <kvm@vger.kernel.org>
> Cc: Joerg Roedel <joro@8bytes.org>; Radim Kr=E8m=E1=F8 <rkrcmar@redhat.co=
m>;
> Lendacky, Thomas <Thomas.Lendacky@amd.com>; Tony Luck
> <tony.luck@intel.com>; Ghannam, Yazen <Yazen.Ghannam@amd.com>; LKML
> <linux-kernel@vger.kernel.org>
> Subject: [PATCH 0/2] x86/kvm: Enable MCE injection in the guest v2
>=20
> From: Borislav Petkov <bp@suse.de>
>=20
> Hi all,
>=20
> here's v2, dropping patch 3 and incorporating hopefully all of Radim's
> feedback.
>=20
> Thx.
>=20
> v1 cover letter:
>=20
> there's this mce-inject.ko module in the kernel which allows for
> injecting real MCEs and thus test the MCE handling code.
>=20
> It is doubly useful to be able to inject same MCEs in a guest so that
> testing of the MCE handling code can happen even easier/faster. In order
> to be able to do that on an AMD guest, we need to emulate some bits
> and pieces like the HWCR[McStatusWrEn] bit which allows writes to the
> MCi_STATUS registers without a #GP.
>=20
> The below does that and with it I'm able to properly inject MCEs in said
> guest.
>=20
> Borislav Petkov (2):
>   kvm/x86: Move MSR_K7_HWCR to svm.c
>   x86/kvm: Implement MSR_HWCR support
>=20
>  arch/x86/kvm/svm.c | 20 ++++++++++++++++++++
>  arch/x86/kvm/x86.c | 46 +++++++++++++++++++++++++++++++---------------
>  2 files changed, 51 insertions(+), 15 deletions(-)
>=20

Tested-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks!

-Yazen
