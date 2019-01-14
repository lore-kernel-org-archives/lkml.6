Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA672C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E322206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="Wzwm2lzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfANQ3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:29:32 -0500
Received: from mail-eopbgr760057.outbound.protection.outlook.com ([40.107.76.57]:10368
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726708AbfANQ3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:29:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSa5scxaMo5ij54ao1V4vaacC/wq7j2KKAiOSKWSETE=;
 b=Wzwm2lzCh08pXsl/VJ5SljHnU5I7vvXC82GZgrN9LWZa/vZs62W4nHguAn68BVFkyGDy5Gr8fLixp1AhG6DgMmNTdvbbb8qqksYSHB9eK2x79FMeHctOqY/I9FFCcJCZUNVg4AZsgk15hamAiqUytTSL+EzslRh0QimkLtaUHks=
Received: from MWHPR06MB2896.namprd06.prod.outlook.com (10.175.138.137) by
 MWHPR06MB2830.namprd06.prod.outlook.com (10.175.138.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Mon, 14 Jan 2019 16:29:29 +0000
Received: from MWHPR06MB2896.namprd06.prod.outlook.com
 ([fe80::d992:bb7d:56ec:8946]) by MWHPR06MB2896.namprd06.prod.outlook.com
 ([fe80::d992:bb7d:56ec:8946%8]) with mapi id 15.20.1516.019; Mon, 14 Jan 2019
 16:29:29 +0000
From:   "Harrosh, Boaz" <Boaz.Harrosh@netapp.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mike Kravetz <mike.kravetz@oracle.com>
CC:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Toshi Kani <toshi.kani@hpe.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] mm: align anon mmap for THP
Thread-Topic: [RFC PATCH] mm: align anon mmap for THP
Thread-Index: AQHUqeoAUFTCAIIvn0CcxSCAmIzKA6WqnMwAgAAaIICABBVXAIAADyei
Date:   Mon, 14 Jan 2019 16:29:29 +0000
Message-ID: <MWHPR06MB2896ACD09C21B2939959C8A8EE800@MWHPR06MB2896.namprd06.prod.outlook.com>
References: <20190111201003.19755-1-mike.kravetz@oracle.com>
 <20190111215506.jmp2s5end2vlzhvb@black.fi.intel.com>
 <ebd57b51-117b-4a3d-21d9-fc0287f437d6@oracle.com>,<20190114135001.w2wpql53zitellus@kshutemo-mobl1>
In-Reply-To: <20190114135001.w2wpql53zitellus@kshutemo-mobl1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Boaz.Harrosh@netapp.com; 
x-originating-ip: [207.232.55.62]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR06MB2830;6:S9qiKsi0xGcMZ+CL7PY/puIBIdBoIMu3O/07IpKXQyv3zifdS23dvl/1nV+ImseAV92Uvy6gSMX0buckH54zARP1hob7QL5QcQ9Z8VUIEpTZV3DFQajSMP6y662N4JsvisUk4CxgRzGHvZE9zJ9JXcy9X8/6zQObo5JF/DFafj1ZWpaE9M+Sacx30LHPCG78AhsIpWWMPq0zZz0SaRY4v4gnWSai4M5lMWjzFWfuJTD9huW/+DSWZI5tPEnzp4taybkh6eV/9yuicfoVjf7Ll4W1pba3b3D9AUPaiJW/reHfoxzGrpBgef3VyHVWk8PmBTjD+9ZBY2D97SlUXDU42xTOE9EB6IanU2wTLmLcQjmzczbVQ+UslNgylwmQz9Npbp4oJlWiResc5AFyjJBci3+d09x2oMylWpgzO8NJpYzzUcNTw9yRvvnQkzd1DrCUeI94c0L5TXsovsJCakHtww==;5:cGaaoEA+cUw1Pln5mHAS/p65RmY3v2Qsc+ZWnIAUoe7d6ysUs7RhGquLCM1BoKGatFavW7TItXHtPGycKGbDcoYYp1LKYwZ8xsRzKX3Z9qZ7cHoPwSVwHSDmfq+UvMMlQ4+XKYXg3Ae3qZuwI7qt5BXCoPVL4su5/tmA1wmaB2bR8os2tpsKVyBSEPZgbMPtQfOoY8UDJKdRQJDNEELefQ==;7:il6TNT18WSbBbJPc88OJbFuNiPEflHT58nxJ7Z4faGVNxmBZP+j3PW0TA82gAwcNctAj6tALXTwLs0GtFoMd73fnY/3tmns1HGokk96S/c+0AVSDjD0GlIAUNtxsQT7Ym8QlBFifgE6Bw2oLhhMopg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6b1409d2-4315-446e-e937-08d67a3d74ea
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7193020);SRVR:MWHPR06MB2830;
x-ms-traffictypediagnostic: MWHPR06MB2830:
x-microsoft-antispam-prvs: <MWHPR06MB2830966B91F6EDC367A888CBEE800@MWHPR06MB2830.namprd06.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(366004)(346002)(199004)(189003)(76176011)(7696005)(102836004)(6506007)(186003)(26005)(66066001)(8676002)(81156014)(81166006)(7736002)(8936002)(305945005)(106356001)(229853002)(14444005)(256004)(68736007)(316002)(86362001)(93886005)(105586002)(54906003)(110136005)(486006)(99286004)(476003)(6246003)(4326008)(5660300001)(478600001)(14454004)(9686003)(72206003)(11346002)(53936002)(446003)(25786009)(2906002)(7416002)(55016002)(33656002)(3846002)(6116002)(6436002)(71190400001)(97736004)(71200400001)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR06MB2830;H:MWHPR06MB2896.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xdOwvh/tqtpZb96MF+jJddlSDGxxEUM0HKUg7yVTmr+JFzJA4ksQN/BHeIl+q6h1HbhDHo3czEZP2WUxDqxpU0hCyefqzvQODJ1SEQtREPkc5134Z9TqC8cO4ZSma8SSXQ5q0bNQOWinvRKtX4UgVPfh2jjzXCJK35oVL3xEgARJ7LuLOE7h03ytnBwfNI4dD1ZkBiWikdK6CYqtkyDxNTGfpsmNR0fjW6fOeHt/9gOTO6WLUCrV0aJUbf80Zl2QuVVuwYRKcm5xEXBQ1HQdao7DAEkBy0g0LNnEwt5mRaV1piLlYiW7i/OywK5tVdUGU31FJ23NC8TdcDhYqylVmE/ZGJd7y517Ahd4RBvzzp+lnCWsfobkISyA3idhxaHfeRFi0ySOQOzH8Q5OezMC6n1VBWh3YgoR6+78mYfCenI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1409d2-4315-446e-e937-08d67a3d74ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 16:29:29.0306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR06MB2830
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Kirill A. Shutemov <kirill@shutemov.name> wrote:
> On Fri, Jan 11, 2019 at 03:28:37PM -0800, Mike Kravetz wrote:
>> Ok, I just wanted to ask the question.  I've seen application code doing
>> the 'mmap sufficiently large area' then unmap to get desired alignment
>> trick.  Was wondering if there was something we could do to help.
>
> Application may want to get aligned allocation for different reasons.
> It should be okay for userspace to ask for size + (alignment - PAGE_SIZE)
> and then round up the address to get the alignment. We basically do the
> same on kernel side.
>

This is what we do and will need to keep doing for old Kernels.
But it is a pity that those holes can not be reused for small maps, and mos=
t important
that we cannot have "mapping holes" around the mapping that catch memory
overruns

> For THP, I believe, kernel already does The Right Thing=99 for most users=
.
> User still may want to get speific range as THP (to avoid false sharing o=
r
> something).

I'm an OK Kernel programmer.  But I was not able to create a HugePage mappi=
ng
against /dev/shm/ in a reliable way. I think it only worked on Fedora 28/29
but not on any other distro/version. (MMAP_HUGE)

We run with our own compiled Kernel on various distros, THP is configured
in but mmap against /dev/shm/ never gives me Huge pages. Does it only
work with unanimous mmap ? (I think it is mount dependent which is not
in the application control)

Just a rant. One day I will figure this out. Meanwhile I do this ugly
user mode aligns the pointers, and try to sleep at night ...

> But still I believe userspace has all required tools to get it
> right.
>

I still wish that if I ask for an mmap size aligned on 2M that I would auto=
matically
get a 2M pointer. I don't see how the system can benefit from having both e=
nds
of the VMA cross Huge page boundary.

> --
> Kirill A. Shutemov

Thanks
Boaz
