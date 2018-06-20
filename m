Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F630C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D907B20652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="EyzbchOO";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Y0UZYIMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D907B20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933808AbeFTWkz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 18:40:55 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39622 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933764AbeFTWkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 18:40:52 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KMdl7c022912;
        Wed, 20 Jun 2018 15:40:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=lAnAT+Cc8jcnd3RetT8dHYPiuog0WKO6G6UbJhBsqLI=;
 b=EyzbchOOhwA252DpXCKHI+F8Di09A6sTaI2t52EBzPn5YpTTcwVKakEhasIadugGaxH7
 m+fqFkHP+MudflOg2hF/6pwEVlvgPc4dTtEytlTqZ00IPjbY0VHdhVaY5K4Kz0M7IfNu
 NkNmom4HDloSCJGPoWJGqXK2diZsg0xhiiQ= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jqy5ag4mr-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 20 Jun 2018 15:40:27 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.19) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 20 Jun 2018 15:40:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAnAT+Cc8jcnd3RetT8dHYPiuog0WKO6G6UbJhBsqLI=;
 b=Y0UZYIMoYP/vH5q12uDDjMHLKaJHAZdnXZu2YDb56Oz86aI324jFQzDoUaia7+ueSnBgOn95OwMJALD7Ns0pXiAEyamOISAHszZ3rUwP3o8zlngI4z/qNJChSFQursHirj6e2WcYB1twORLBxdle4X/Ydng0fIspS0ThDbB/y8M=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1405.namprd15.prod.outlook.com (10.173.234.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Wed, 20 Jun 2018 22:40:19 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::7044:6139:1178:6ace]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::7044:6139:1178:6ace%8]) with mapi id 15.20.0863.016; Wed, 20 Jun 2018
 22:40:19 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Okash Khawaja <osk@fb.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@fb.com>,
        "Alexei Starovoitov" <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/3] bpf: btf: export btf types and name by
 offset from lib
Thread-Topic: [PATCH bpf-next 1/3] bpf: btf: export btf types and name by
 offset from lib
Thread-Index: AQHUCNbnxSXMFV+WbUWxh41B5ch9i6RpvaUA
Date:   Wed, 20 Jun 2018 22:40:19 +0000
Message-ID: <AD663533-9EF3-47EE-A2BA-87E1938776BA@fb.com>
References: <20180620203051.223156973@fb.com>
 <20180620203702.996737905@fb.com>
In-Reply-To: <20180620203702.996737905@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.6.18)
x-originating-ip: [2620:10d:c090:200::5:f975]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1405;7:NICKc0OjBJIkDeJxXhPgjhNdpnu2Ybh1pFCswIOzsGmIhvF8mCosw9hzupPqeIImi0f/2D84DpxCy2bAkq+sLPsvdha8nEzkOQZdN6LaOGy5bQpu6O3+Y5eyn867NS+Ovq5S+2N0lwUswcOYqnpvMCfpKt5AFLHLv8QOlnv594Fznsi3NRZaDD4YrYa8tmD0MsopSUi5Crs4ANY3E/HyYGleAeWvEVrOytk3OFZuMFf1uc4STRRVz3dxjRpgTrVO;20:905cld081rtcpCfBTnAdB2xUB/IXqqWrcZvraJHUq+3JQQJ0aXt1psyd+Dx9U6mDZLk7ErveM0M9rP4eNKWKdZSCXMSlluvT2PyQQ5RkuQDWK6uoIEiGcI8v0aa6OaLIaBN8Qut1i/fim2ttNpIW290kgluG0F4Abtum8j9UG64=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: f4918358-b88f-4903-04ac-08d5d6fecd56
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1405;
x-ms-traffictypediagnostic: MWHPR15MB1405:
x-microsoft-antispam-prvs: <MWHPR15MB14055E959D6BBFAE2A851DE0B3770@MWHPR15MB1405.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR15MB1405;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1405;
x-forefront-prvs: 070912876F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(39860400002)(39380400002)(396003)(57704003)(189003)(199004)(54906003)(2616005)(229853002)(97736004)(50226002)(68736007)(3660700001)(86362001)(76176011)(6636002)(446003)(2900100001)(476003)(3280700002)(36756003)(99286004)(8676002)(82746002)(2906002)(6116002)(81166006)(37006003)(8936002)(25786009)(11346002)(486006)(81156014)(46003)(6486002)(5660300001)(14454004)(316002)(6246003)(102836004)(478600001)(106356001)(53936002)(57306001)(4326008)(6862004)(39060400002)(7736002)(83716003)(5250100002)(33656002)(6512007)(53546011)(6436002)(6506007)(305945005)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1405;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uDOBVey50eI1Nj/t+GkUNL5LNXuXS9M9YGlJGExkb24Z/LK3nMcvuXCIlcSdFWQipLjYcRL8z2M1EHQOf95lfN4TzbMx7zRJ3aKxYn6GJP3yJNFWCST/203roLyaQeyRJfxl13ktGfmJMbw8pQL3VyCbRyjI41sANImdbZ6bzs2U7Y2q2drqCO86/VvCO5+3f5ycWNrfpuEKiG8oCsSbFjt3E2LJ7pLWdlUbXbHu8/iIMWVrT8hIaPOoJBeS63iem2WvnX1aqw8ZcDlKkc9H2bkQ8BhFcX89DwjbJqMAaFIgxDqlcmxAWiTTMuZqj9ChwGMcrGMgi8oAPhzsHkG9nQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D067B62FBABBF3419EF94C4F496AFA25@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f4918358-b88f-4903-04ac-08d5d6fecd56
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2018 22:40:19.5435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1405
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-20_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 20, 2018, at 1:30 PM, Okash Khawaja <osk@fb.com> wrote:
>=20
> This patch introduces btf__resolve_type() function and exports two
> existing functions from libbpf. btf__resolve_type follows modifier
> types like const and typedef until it hits a type which actually takes
> up memory, and then returns it. This function follows similar pattern
> to btf__resolve_size but instead of computing size, it just returns
> the type.
>=20
> These  functions will be used in the followig patch which parses
> information inside array of `struct btf_type *`. btf_name_by_offset is
> used for printing variable names.
>=20
> Signed-off-by: Okash Khawaja <osk@fb.com>
> Acked-by: Martin KaFai Lau <kafai@fb.com>
>=20
> ---
> tools/lib/bpf/btf.c |   65 ++++++++++++++++++++++++++++++++++++----------=
------
> tools/lib/bpf/btf.h |    3 ++
> 2 files changed, 48 insertions(+), 20 deletions(-)
>=20
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -17,6 +17,11 @@
>=20
> #define BTF_MAX_NR_TYPES 65535
>=20
> +#define IS_MODIFIER(k) (((k) =3D=3D BTF_KIND_TYPEDEF) || \
> +		((k) =3D=3D BTF_KIND_VOLATILE) || \
> +		((k) =3D=3D BTF_KIND_CONST) || \
> +		((k) =3D=3D BTF_KIND_RESTRICT))
> +
> static struct btf_type btf_void;
>=20
> struct btf {
> @@ -33,14 +38,6 @@ struct btf {
> 	int fd;
> };
>=20
> -static const char *btf_name_by_offset(const struct btf *btf, uint32_t of=
fset)
> -{
> -	if (offset < btf->hdr->str_len)
> -		return &btf->strings[offset];
> -	else
> -		return NULL;
> -}
> -
> static int btf_add_type(struct btf *btf, struct btf_type *t)
> {
> 	if (btf->types_size - btf->nr_types < 2) {
> @@ -190,15 +187,6 @@ static int btf_parse_type_sec(struct btf
> 	return 0;
> }
>=20
> -static const struct btf_type *btf_type_by_id(const struct btf *btf,
> -					     uint32_t type_id)
> -{
> -	if (type_id > btf->nr_types)
> -		return NULL;
> -
> -	return btf->types[type_id];
> -}

nit: Why do we need to move these two functions to later of the file?=20

Other than this,

Acked-by: Song Liu <songliubraving@fb.com>

> -
> static bool btf_type_is_void(const struct btf_type *t)
> {
> 	return t =3D=3D &btf_void || BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_FWD;
> @@ -234,7 +222,7 @@ int64_t btf__resolve_size(const struct b
> 	int64_t size =3D -1;
> 	int i;
>=20
> -	t =3D btf_type_by_id(btf, type_id);
> +	t =3D btf__type_by_id(btf, type_id);
> 	for (i =3D 0; i < MAX_RESOLVE_DEPTH && !btf_type_is_void_or_null(t);
> 	     i++) {
> 		size =3D btf_type_size(t);
> @@ -259,7 +247,7 @@ int64_t btf__resolve_size(const struct b
> 			return -EINVAL;
> 		}
>=20
> -		t =3D btf_type_by_id(btf, type_id);
> +		t =3D btf__type_by_id(btf, type_id);
> 	}
>=20
> 	if (size < 0)
> @@ -271,6 +259,26 @@ int64_t btf__resolve_size(const struct b
> 	return nelems * size;
> }
>=20
> +int32_t btf__resolve_type(const struct btf *btf, uint32_t type_id)
> +{
> +	const struct btf_type *t;
> +	int depth =3D 0;
> +
> +	t =3D btf__type_by_id(btf, type_id);
> +	while (depth < MAX_RESOLVE_DEPTH &&
> +			!btf_type_is_void_or_null(t) &&
> +			IS_MODIFIER(BTF_INFO_KIND(t->info))) {
> +		type_id =3D t->type;
> +		t =3D btf__type_by_id(btf, type_id);
> +		depth++;
> +	}
> +
> +	if (depth =3D=3D MAX_RESOLVE_DEPTH || btf_type_is_void_or_null(t))
> +		return -EINVAL;
> +
> +	return type_id;
> +}
> +
> int32_t btf__find_by_name(const struct btf *btf, const char *type_name)
> {
> 	uint32_t i;
> @@ -280,7 +288,7 @@ int32_t btf__find_by_name(const struct b
>=20
> 	for (i =3D 1; i <=3D btf->nr_types; i++) {
> 		const struct btf_type *t =3D btf->types[i];
> -		const char *name =3D btf_name_by_offset(btf, t->name_off);
> +		const char *name =3D btf__name_by_offset(btf, t->name_off);
>=20
> 		if (name && !strcmp(type_name, name))
> 			return i;
> @@ -371,3 +379,20 @@ int btf__fd(const struct btf *btf)
> {
> 	return btf->fd;
> }
> +
> +const char *btf__name_by_offset(const struct btf *btf, uint32_t offset)
> +{
> +	if (offset < btf->hdr->str_len)
> +		return &btf->strings[offset];
> +	else
> +		return NULL;
> +}
> +
> +const struct btf_type *btf__type_by_id(const struct btf *btf,
> +					     uint32_t type_id)
> +{
> +	if (type_id > btf->nr_types)
> +		return NULL;
> +
> +	return btf->types[type_id];
> +}
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -17,6 +17,9 @@ void btf__free(struct btf *btf);
> struct btf *btf__new(uint8_t *data, uint32_t size, btf_print_fn_t err_log=
);
> int32_t btf__find_by_name(const struct btf *btf, const char *type_name);
> int64_t btf__resolve_size(const struct btf *btf, uint32_t type_id);
> +int32_t btf__resolve_type(const struct btf *btf, uint32_t type_id);
> int btf__fd(const struct btf *btf);
> +const char *btf__name_by_offset(const struct btf *btf, uint32_t offset);
> +const struct btf_type *btf__type_by_id(const struct btf *btf, uint32_t t=
ype_id);
>=20
> #endif
>=20

