Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45392C31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1072821726
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="CgSJ7cdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfAUScc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:32:32 -0500
Received: from mail-eopbgr50086.outbound.protection.outlook.com ([40.107.5.86]:18602
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727507AbfAUScb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:32:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK/Uyn5TLXYmuFWzRen6dPj47ymv6TkMpNiiWOr0S1U=;
 b=CgSJ7cdpWVKR9JvIDHMxhI3N1ZQfJK4LPDGcR0waKmclPp7JvTHSC2ZXqDg0Hee20XM6iHTxqGFUMblPtOOska55B7+7/RqNhcaQSAfQWezHsBK0IA8SKq+A3uzIaVszRIKPki+pVx9Jhc9LUTqvqbKI4aRVvM8Zw/MOtcp5Tpw=
Received: from HE1PR05MB4601.eurprd05.prod.outlook.com (20.176.163.138) by
 HE1PR05MB4586.eurprd05.prod.outlook.com (20.176.163.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Mon, 21 Jan 2019 18:32:26 +0000
Received: from HE1PR05MB4601.eurprd05.prod.outlook.com
 ([fe80::75a0:a89d:1227:7ed3]) by HE1PR05MB4601.eurprd05.prod.outlook.com
 ([fe80::75a0:a89d:1227:7ed3%5]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 18:32:26 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jack@suse.de" <jack@suse.de>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 6/6] drivers/IB,core: reduce scope of mmap_sem
Thread-Topic: [PATCH 6/6] drivers/IB,core: reduce scope of mmap_sem
Thread-Index: AQHUsbDMh0ebXA3HPUuZayCivnBqHaW6C+UA
Date:   Mon, 21 Jan 2019 18:32:26 +0000
Message-ID: <20190121183218.GK25149@mellanox.com>
References: <20190121174220.10583-1-dave@stgolabs.net>
 <20190121174220.10583-7-dave@stgolabs.net>
In-Reply-To: <20190121174220.10583-7-dave@stgolabs.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:102:2::20) To HE1PR05MB4601.eurprd05.prod.outlook.com
 (2603:10a6:7:99::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR05MB4586;6:yLHymjfS/Gsjjx+TcIdsKPwPihg2nOnqfvANv2lTU20Um5hvbraAS7bm2Hs4Ql9WMCeN1fsYASMWUlJVuu+ogNzdvJ+dtyvAyUkhDsAvfpZ0m/9QStCqvZTsxL0jDInXa7zxM8zrIi23dvePO8TRYZVOcQx/Yp7GT2ppZ51pO+NH3DF1v+MpWnayptm+X36LO+KeWan9r7tCPvzGV/ciyqwkWTg2gsOHtubQrfaHduUgDSmbghV0A1gBd2otRX67K0oL5Lbf7E9KdSyekIMWrTznePj5tpeX+5wbJCZzkaAAMxkKgzRg35TPNi9aw/WxK5vlLKaPTsFO7OE+rheDQMkL6ptECnBITmLg+O2w49hEfx0fMBe/O+KUfZ1c/PjT86UmraoUfn7+PaiDK8Tgj1Ow0k5yVbsIr4jJoC1P0+WFe+nFWj9inl80N8YNFyb4KQxuaIWkaaF6ffo9WqQdEw==;5:nBeIT48M7Kr9Xe9I69tbHcSCm/trnMcU5pPxOGpJ+Qc9nJ2bZp7j+5yrCx/D+mcIrZrCZSYt/02kE4/X1C5hyT2k1NrUnjilX9kPf8E+DmqMtGu5Dqz2paRa2p/MFJQ1TQVXqQ2WpjVO5rZszZa2Dmd0tVd8egCdLwVdeI3pc3YNwQxGWOVkQgssLvZczV7WKsjRhsLseJp6ImBggf8qEg==;7:M6LhsyG6KNKEFbAZCQYYn2t9IhuzSMGQtEpw8lZxzsG1AxP3ZedXRoErA6d99r90HcV/sBurL+iM7b/ZqCIoPQWE6Vf/g6oGp2BFckMWOcay1XcbOdWRjOveHztVguQHIExA9ZHkRCUNmDLUhjudFA==
x-ms-office365-filtering-correlation-id: 451de1a3-86ca-46ce-1145-08d67fceca99
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB4586;
x-ms-traffictypediagnostic: HE1PR05MB4586:
x-microsoft-antispam-prvs: <HE1PR05MB4586C9D9DAB9312D80FAA22DCF9F0@HE1PR05MB4586.eurprd05.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(366004)(136003)(346002)(189003)(199004)(1076003)(3846002)(97736004)(446003)(36756003)(8936002)(86362001)(6506007)(6116002)(386003)(316002)(8676002)(7736002)(54906003)(81166006)(81156014)(66066001)(14444005)(305945005)(478600001)(71190400001)(6916009)(256004)(53936002)(71200400001)(25786009)(105586002)(6246003)(4744005)(2906002)(6436002)(2616005)(106356001)(52116002)(476003)(102836004)(14454004)(486006)(229853002)(26005)(99286004)(6486002)(4326008)(11346002)(186003)(33656002)(6512007)(76176011)(68736007)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB4586;H:HE1PR05MB4601.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 26jv0N31KbdjPVZQJO3GklSyiS32O14n5napSm+xy3HDC+2GnLuY4LMYRDLDa6j8f35eBMqAEHiyrwBjwfMpdTH8qQPhFLjtdqXvkt8GhHRwk38FcAZIBzX9eDOLTI66V7Wz6OY0gJJPl0igFt5LWzTTN8PJP9Qjv7PGW4V3ujX39uLmsT8tR4iZ3K6tjJT83j99LMJnbTahM6kCEgPHPRtqK7Ge3ZPJ/UHZ03XUZQY1uqUI4YRg/Te7a57HMpwsK9vau6BIsMvOKXUv+tE6+VLY9a/jhvVFm8Nd+HCnHpVFrg3dGP7SncE6q5pkrfuV+TqUKRUwNEkSst8il2pOLLv4QjIMfuOXJHMuyMmXL+R+gpvy9lTcTudBg4otDLJsC0DLOxtObff8pa5rS2IQbAZVivb32v73yfxWyaCqVEo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AF6C19A4E2A59848B1BBD303F838CD25@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 451de1a3-86ca-46ce-1145-08d67fceca99
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 18:32:25.8503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB4586
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 09:42:20AM -0800, Davidlohr Bueso wrote:
> ib_umem_get() uses gup_longterm() and relies on the lock to
> stabilze the vma_list, so we cannot really get rid of mmap_sem
> altogether, but now that the counter is atomic, we can get of
> some complexity that mmap_sem brings with only pinned_vm.
>=20
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  drivers/infiniband/core/umem.c | 41 ++----------------------------------=
-----
>  1 file changed, 2 insertions(+), 39 deletions(-)

I think this addresses my comment..

Considering that it is almost all infiniband, I'd rather it go it go
through the RDMA tree with an ack from mm people? Please advise..

Thanks,
Jason
