Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D17C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E242084D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="ajTzVlB9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbfBLROH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:14:07 -0500
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:48416 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727903AbfBLROH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:14:07 -0500
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1CHBaPI027585;
        Tue, 12 Feb 2019 11:13:53 -0600
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2055.outbound.protection.outlook.com [104.47.38.55])
        by mx0b-00010702.pphosted.com with ESMTP id 2qhvq127sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Feb 2019 11:13:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XksUYprki6nADSZ117haZo2ckmWykYQ/aWPVQ6hPbyk=;
 b=ajTzVlB9ZnK4P33qIrlipklalO8XPI6MZGE0RGOtF8oD0mo40hRSY1FuszGWSPMB/7SOSkIllsftjUomLdFln9qeAGpxW+RcziYRNZMGAK4+OKLlZJPCyirnHxIq8NWc62FSkd03d2hzfBj64OjwqahRDv825kpstRIwV74U5nA=
Received: from BN6PR04MB0963.namprd04.prod.outlook.com (10.174.233.163) by
 BN6PR04MB0501.namprd04.prod.outlook.com (10.173.202.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Tue, 12 Feb 2019 17:13:52 +0000
Received: from BN6PR04MB0963.namprd04.prod.outlook.com
 ([fe80::c98f:5fe:e801:6c2f]) by BN6PR04MB0963.namprd04.prod.outlook.com
 ([fe80::c98f:5fe:e801:6c2f%7]) with mapi id 15.20.1622.016; Tue, 12 Feb 2019
 17:13:52 +0000
From:   Julia Cartwright <julia@ni.com>
To:     Julien Grall <julien.grall@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
Thread-Topic: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
Thread-Index: AQHUwvZT+u5+kYL9Lk22jUl9JqQNCQ==
Date:   Tue, 12 Feb 2019 17:13:51 +0000
Message-ID: <20190212171350.GB1002@jcartwri.amer.corp.natinst.com>
References: <20190208165513.8435-1-julien.grall@arm.com>
In-Reply-To: <20190208165513.8435-1-julien.grall@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0083.namprd04.prod.outlook.com
 (2603:10b6:805:f2::24) To BN6PR04MB0963.namprd04.prod.outlook.com
 (2603:10b6:405:43::35)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [130.164.62.151]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7964376e-d4e2-4753-f6e4-08d6910d75cc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR04MB0501;
x-ms-traffictypediagnostic: BN6PR04MB0501:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BN6PR04MB0501;23:I6RTTq+HtMOuC9nt/sx8e3Z0dT2cRuq7EfMw9RnNz?=
 =?us-ascii?Q?UtPnHd6B2WJ9sJ3uRmYVpwnnsQKBipLyzarmTLhCZPCL3HSkvKKR2q3umOBh?=
 =?us-ascii?Q?+hY0EEoQWvOHru1quVT8ruBCx6XyiNRBtXTCl3EfxHV8nnAWDaD53PsSvgan?=
 =?us-ascii?Q?4MUs5DSgf966OkcDs3iVYnVlGTBZczneMi8Cr+N7VWoNfnkddTopbCABXqRG?=
 =?us-ascii?Q?ey2Bd9rKHxjPKY/EqDrNOpo4DQ1Luqwp3EwlCmxoFhLVqC+n2cayAr/P3Nlh?=
 =?us-ascii?Q?BKYSo+r75BG22XZCLLWMVP6MSzw7Matqh7LCvK+MuN1a4YLvGW0PQ5FlzrJq?=
 =?us-ascii?Q?6eNqjJK9PdWgd0nSsy2zHuqoVobGkBHqAFcuKNqhkSco4NY9TqOQtBC1GGV9?=
 =?us-ascii?Q?a/s+o5YBTi7eb0Xh414HtkQpblorx25zKd+xocHNFTucGevFZ4fnBFsBKxmD?=
 =?us-ascii?Q?TbakxPajeT5Pp3D1FsgGTkGYD8A+mMbjDUsF9gZMZGW+dbdXFrF7o37kWqO5?=
 =?us-ascii?Q?SHD3du+K2ytBc5HAjXVHTSmA/LaY0FUy7FRMJ8UBFTIkWcdlQ7zN5hGj/6/b?=
 =?us-ascii?Q?2NxU7ZtPm1Zt100ruxmx3cN45UM2eqizCKrLR3bwPTf58pOf1BGbHiKDQzG6?=
 =?us-ascii?Q?wmDSsyH14eZLxQ5GgAlh4mAVWUTbXh2kj9/xAfhM/HkjZQJgAKZx3WF9MY99?=
 =?us-ascii?Q?B5rURF7QvhvwaW3Yst5CuiOc/4NSSgbVe9mkh/bgcNxllr6eF1W/724ua+jA?=
 =?us-ascii?Q?o+Eaxh2vq/TSV+fB2ScAkT7RiX+5e/LOUNok9tLnr/NRoz8mjRHrJcMBlvfS?=
 =?us-ascii?Q?oKIamQrPdAlYg4K4nA+shTZCmkv+UpECHn1ur3vU+h1eXr6Y8VOzAIm71bd7?=
 =?us-ascii?Q?Y/guxR+UZhYFtHj+n/jV5sbsnEfmdM+RC8pROnI6ilm1CosaMGlLPCDi8Zz7?=
 =?us-ascii?Q?Jefl+pruyoOblTC4rQWnBaX13GNO4bwyhgmr9YevhCVyPPzteprMmtj91IdT?=
 =?us-ascii?Q?+WP9eX9D8hoTeTjWlXsDUZqF1k28IDbge7J6T5TBoGtgndhy01JD7vwL9NJw?=
 =?us-ascii?Q?Yamd4OHGkvLZpeplOaQY5Y9dJKv+VX6eiME38DHLtFOqCU0sNnsUuxHLanzF?=
 =?us-ascii?Q?88QwZc/mMLUqRjHHt/MXnLmbC3bRg4k96FKvebYwAK9dqHN71nJLSvhJpAxq?=
 =?us-ascii?Q?glvib5eBKZo7n8ogn9YmwETjvwp2PohD7XK?=
x-microsoft-antispam-prvs: <BN6PR04MB050164B47727501D31001CF4F4650@BN6PR04MB0501.namprd04.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(396003)(366004)(136003)(199004)(189003)(6116002)(6916009)(386003)(6506007)(106356001)(305945005)(3846002)(105586002)(33656002)(316002)(54906003)(6436002)(7736002)(53936002)(6486002)(6246003)(229853002)(66066001)(25786009)(14444005)(2906002)(102836004)(26005)(9686003)(6512007)(33896004)(486006)(476003)(97736004)(186003)(256004)(4326008)(11346002)(446003)(1076003)(71190400001)(99286004)(68736007)(8936002)(478600001)(81156014)(81166006)(14454004)(71200400001)(8676002)(52116002)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR04MB0501;H:BN6PR04MB0963.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EP3p/YIpj+sp+F+LPr1J/u7UKOYUP/EGq7ev/cGnA06t428lDB7eykT30rmg3ky55URpyHd7FjthCAFR32EfOgSRycIgaes57D0ssduO9chl4Az7ODggW5AIZeHuAOqVt1g5Ag7FPgcT9ZXob+9pdI/S6Wbd6v6DyOea4RrjVvYUL1As2EW+7o5XR0csq2sU4ZgHLqr5biNmFHRU8DFoVhQSL8taRFsvjPaMl3S3npKt3m0M2L4OnOwdNeJ2BSMDgcgaLK19GNrcRzdZrQYfmyE1cBYlEjS4eehjyjcSfrh84kJAKpY5d98u96Qq4YVzP1/H08m4AmT5QY0d60IhGl8KawaUhH3pMIkghUyaTaW5cKyrw4biqn1ey4Usi9hD3Hnevgv2oGU5n3rbe/E7QeRHrFcg5D+X7UI02Au9pI4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6941E45E7C585249A46385C75F22405D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7964376e-d4e2-4753-f6e4-08d6910d75cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 17:13:51.5972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0501
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-12_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=544 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902120122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Julien-

On Fri, Feb 08, 2019 at 04:55:13PM +0000, Julien Grall wrote:
> When the kernel is compiled with CONFIG_KERNEL_MODE_NEON, some part of
> the kernel may be able to use FPSIMD/SVE. This is for instance the case
> for crypto code.
>=20
> Any use of FPSIMD/SVE in the kernel are clearly marked by using the
> function kernel_neon_{begin, end}. Furthermore, this can only be used
> when may_use_simd() returns true.
>=20
> The current implementation of may_use_simd() allows softirq to use
> FPSIMD/SVE unless it is currently in used (i.e kernel_neon_busy is true).
> When in used, softirqs usually fallback to a software method.
>=20
> At the moment, as a softirq may use FPSIMD/SVE, softirqs are disabled
> when touching the FPSIMD/SVE context. This has the drawback to disable
> all softirqs even if they are not using FPSIMD/SVE.
>=20
> As a softirq should not rely on been able to use simd at a given time,
> there are limited reason to keep softirq disabled when touching the
> FPSIMD/SVE context. Instead, we can only disable preemption and tell
> the NEON unit is currently in use.
>=20
> This patch introduces two new helpers kernel_neon_{disable, enable} to
> mark the area using FPSIMD/SVE context and use them in replacement of
> local_bh_{disable, enable}. The functions kernel_neon_{begin, end} are
> also re-implemented to use the new helpers.
>=20
> Signed-off-by: Julien Grall <julien.grall@arm.com>
>=20
> ---
>=20
> I have been exploring this solution as an alternative approach to the RT
> patch "arm64: fpsimd: use preemp_disable in addition to local_bh_disable(=
)".
>=20
> So far, the patch has only been lightly tested.
>=20
> For RT-linux, it might be possible to use migrate_{enable, disable}. I
> am quite new with RT and have some trouble to understand the semantics
> of migrate_{enable, disable}. So far, I am still unsure if it is possible
> to run another userspace task on the same CPU while getting preempted
> when the migration is disabled.

Yes, a thread in a migrate_disable()-protected critical section can be
preempted, and another thread on the same CPU may enter the critical
section.

If it's necessary to prevent this from happening, then you need to also
make use of a per-CPU mutex.  On RT, this would do the right thing
w.r.t. priority inheritance.

   Julia
