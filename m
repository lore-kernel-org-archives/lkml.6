Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5091AC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB5B20652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="rDwyJc31";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Q/pUoJI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAB5B20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754259AbeFTXPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 19:15:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59752 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754071AbeFTXPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 19:15:01 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KNEElL019871;
        Wed, 20 Jun 2018 16:14:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Ly0Eoj+5T5tRpbd9C3ZYM902mV4Cvr1lak1IP+Y2qV8=;
 b=rDwyJc319HbBnbqWfl/gMbb6Qi1lJQPdGPnc8anmojPwgMCs27pKcv/NDMCF/+cCsUus
 ouKbFPYNRc/1Gl4/HilGQvr26mjVOm/EkTjQvSnjSRIrVJZM6M4gM0tOSu8WGXi1SsDF
 i+Ky777yYWVZUl/7aAVBORtL5Ij9Srs2hks= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jqwprgg4w-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 20 Jun 2018 16:14:37 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.26) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 20 Jun 2018 19:14:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ly0Eoj+5T5tRpbd9C3ZYM902mV4Cvr1lak1IP+Y2qV8=;
 b=Q/pUoJI76vAeFsXkc4ezYOtTO1dKHBJT+L9/W9kRuZd2k4mJftJoJvloxyLg/xARe/8IdraAuwPG1Ub/Wt27ekvtiWSkAYGklhrZY9weuy5i9xsfG6JIA10xcWBLtrvBP3Hdop2NR84TzxJ2uey9Zex4mSAazA0VnoNE2fdDfWc=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1279.namprd15.prod.outlook.com (10.175.3.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Wed, 20 Jun 2018 23:14:33 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::7044:6139:1178:6ace]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::7044:6139:1178:6ace%8]) with mapi id 15.20.0863.016; Wed, 20 Jun 2018
 23:14:33 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Okash Khawaja <osk@fb.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@fb.com>,
        "Alexei Starovoitov" <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: btf: add btf json print functionality
Thread-Topic: [PATCH bpf-next 2/3] bpf: btf: add btf json print functionality
Thread-Index: AQHUCNbpU62yBE7bRkiOmLHhXAVRLaRpxzYA
Date:   Wed, 20 Jun 2018 23:14:33 +0000
Message-ID: <CB2174F3-11DA-496B-A3AF-9FA857C37DB1@fb.com>
References: <20180620203051.223156973@fb.com>
 <20180620203703.101156292@fb.com>
In-Reply-To: <20180620203703.101156292@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.6.18)
x-originating-ip: [2620:10d:c090:200::5:f975]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1279;7:EUGaAzo4S3m+lSf13268isjny29NZq7Stel1KFYTIsCa8/Rm1UVeQcyjDq6Ww7U5Skihw0wvWzUQCupafdWmQFlKwOBop9/wZaXJWMOYiNwV6prCf0bv6pf5OWoAmwS+fhWXh9rYa+3qP/7jdkhoUHO0r9SXUMUHAjQNtsO8IQCa133LLtjbJuseevLwOajuQmxcTmu+dsbZ21+gyz+RsCelIGjkQJI6IsB9DYxxVOcdoi1Xrt287V850Yh+M79O;20:vazHfcvVhbdQ/9AdYhp5iEKF9DSWcb4ydxJHnL8N2GWcGgaWkO3uOXF66demoMgxPLIonXltgQpoPm6FYHi2AI+WMgty9Lv+Q3yl0nHuikjY7dIJliO6N0xultJSu9UBTRxI6XdKaDT2jZZDMZJI/M4PkbiwQwLZkUnejIOCfTA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: f038d072-44ef-4f79-a6f2-08d5d703955e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1279;
x-ms-traffictypediagnostic: MWHPR15MB1279:
x-microsoft-antispam-prvs: <MWHPR15MB127906C76FC459D9D2302F7EB3770@MWHPR15MB1279.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484)(81227570615382);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MWHPR15MB1279;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1279;
x-forefront-prvs: 070912876F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(376002)(396003)(39380400002)(189003)(199004)(305945005)(2900100001)(102836004)(99286004)(36756003)(53546011)(3660700001)(6506007)(46003)(11346002)(446003)(476003)(2616005)(6116002)(2906002)(486006)(3280700002)(5250100002)(8936002)(6436002)(86362001)(229853002)(54906003)(83716003)(50226002)(6486002)(81156014)(37006003)(68736007)(81166006)(7736002)(8676002)(76176011)(6246003)(33656002)(39060400002)(6862004)(53936002)(106356001)(14454004)(105586002)(316002)(6512007)(4326008)(25786009)(5660300001)(97736004)(478600001)(82746002)(57306001)(6636002)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1279;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HlaR1azlwAXnAkM+j7C8/YXbmBJaICwvF4lpL/BQjT//B7V6rN34Gy+4e/hvkEtSIj9Cta/Muchb38Z/DlozKSgAFcUuelwElrcF3QDCXxvlx9HHaWD0W81pKwY7MJdSwiyyeY53Io0l9uh7CfyDcA5mWFkOcpLofyXJa1JOZGm6++ocpD6tNaVXdsQlUEnQFkOimDHkwIAnkbboz3UiTCpAV+ZJTEpn8VA6fBEM1vYjkXSf9S3qLX6XrK4WoiyRdXfBcOM0vVL8wkjk8t+PBWfeGaCuji83y0gxlOuRInyq8LTMfQWeSKucc6lO+PS0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <923B46EE0BFCE9478401B8BB6C5CA06E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f038d072-44ef-4f79-a6f2-08d5d703955e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2018 23:14:33.2073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1279
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
> This consumes functionality exported in the previous patch. It does the
> main job of printing with BTF data. This is used in the following patch
> to provide a more readable output of a map's dump. It relies on
> json_writer to do json printing. Below is sample output where map keys
> are ints and values are of type struct A:
>=20
> typedef int int_type;
> enum E {
>        E0,
>        E1,
> };
>=20
> struct B {
>        int x;
>        int y;
> };
>=20
> struct A {
>        int m;
>        unsigned long long n;
>        char o;
>        int p[8];
>        int q[4][8];
>        enum E r;
>        void *s;
>        struct B t;
>        const int u;
>        int_type v;
>        unsigned int w1: 3;
>        unsigned int w2: 3;
> };
>=20
> $ sudo bpftool map dump -p id 14
> [{
>        "key": 0
>    },{
>        "value": {
>            "m": 1,
>            "n": 2,
>            "o": "c",
>            "p": [15,16,17,18,15,16,17,18
>            ],
>            "q": [[25,26,27,28,25,26,27,28
>                ],[35,36,37,38,35,36,37,38
>                ],[45,46,47,48,45,46,47,48
>                ],[55,56,57,58,55,56,57,58
>                ]
>            ],
>            "r": 1,
>            "s": 0x7ffff6f70568,
>            "t": {
>                "x": 5,
>                "y": 10
>            },
>            "u": 100,
>            "v": 20,
>            "w1": 0x7,
>            "w2": 0x3
>        }
>    }
> ]
>=20
> This patch uses json's {} and [] to imply struct/union and array. More
> explicit information can be added later. For example, a command line
> option can be introduced to print whether a key or value is struct
> or union, name of a struct etc. This will however come at the expense
> of duplicating info when, for example, printing an array of structs.
> enums are printed as ints without their names.
>=20
> Signed-off-by: Okash Khawaja <osk@fb.com>
> Acked-by: Martin KaFai Lau <kafai@fb.com>
>=20
> ---
> tools/bpf/bpftool/btf_dumper.c |  247 +++++++++++++++++++++++++++++++++++=
++++++
> tools/bpf/bpftool/btf_dumper.h |   18 ++
> 2 files changed, 265 insertions(+)
>=20
> --- /dev/null
> +++ b/tools/bpf/bpftool/btf_dumper.c
> @@ -0,0 +1,247 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2018 Facebook */
> +
> +#include <linux/btf.h>
> +#include <linux/err.h>
> +#include <stdio.h> /* for (FILE *) used by json_writer */
> +#include <linux/bitops.h>
> +#include <string.h>
> +#include <ctype.h>
> +
> +#include "btf.h"
> +#include "json_writer.h"
> +
> +#define BITS_PER_BYTE_MASK (BITS_PER_BYTE - 1)
> +#define BITS_PER_BYTE_MASKED(bits) ((bits) & BITS_PER_BYTE_MASK)
> +#define BITS_ROUNDDOWN_BYTES(bits) ((bits) >> 3)
> +#define BITS_ROUNDUP_BYTES(bits) \
> +	(BITS_ROUNDDOWN_BYTES(bits) + !!BITS_PER_BYTE_MASKED(bits))
> +
> +static int btf_dumper_do_type(const struct btf *btf, uint32_t type_id,
> +		uint8_t bit_offset, const void *data, json_writer_t *jw);
> +
> +static void btf_dumper_ptr(const void *data, json_writer_t *jw)
> +{
> +	jsonw_printf(jw, "%p", *((uintptr_t *)data));
> +}
> +
> +static int btf_dumper_modifier(const struct btf *btf, uint32_t type_id,
> +		const void *data, json_writer_t *jw)
> +{
> +	int32_t actual_type_id =3D btf__resolve_type(btf, type_id);
> +	int ret;
> +
> +	if (actual_type_id < 0)
> +		return actual_type_id;
> +
> +	ret =3D btf_dumper_do_type(btf, actual_type_id, 0, data, jw);
> +
> +	return ret;
> +}
> +
> +static void btf_dumper_enum(const void *data, json_writer_t *jw)
> +{
> +	jsonw_printf(jw, "%d", *((int32_t *)data));
> +}
> +
> +static int btf_dumper_array(const struct btf *btf, uint32_t type_id,
> +		const void *data, json_writer_t *jw)
> +{
> +	const struct btf_type *t =3D btf__type_by_id(btf, type_id);
> +	struct btf_array *arr =3D (struct btf_array *)(t + 1);
> +	int64_t elem_size;
> +	uint32_t i;
> +	int ret;
> +
> +	elem_size =3D btf__resolve_size(btf, arr->type);
> +	if (elem_size < 0)
> +		return elem_size;
> +
> +	jsonw_start_array(jw);
> +	for (i =3D 0; i < arr->nelems; i++) {
> +		ret =3D btf_dumper_do_type(btf, arr->type, 0,
> +				data + (i * elem_size), jw);
> +		if (ret)
> +			return ret;

Shall we call jsonw_end_array() before return here?=20

> +	}
> +
> +	jsonw_end_array(jw);
> +
> +	return 0;
> +}
> +
> +static void btf_dumper_int_bits(uint32_t int_type, uint8_t bit_offset,
> +		const void *data, json_writer_t *jw)
> +{
> +	uint16_t total_bits_offset;
> +	uint32_t bits =3D BTF_INT_BITS(int_type);
> +	uint16_t bytes_to_copy;
> +	uint16_t bits_to_copy;
> +	uint8_t upper_bits;
> +	union {
> +		uint64_t u64_num;
> +		uint8_t u8_nums[8];
> +	} print_num;
> +
> +	total_bits_offset =3D bit_offset + BTF_INT_OFFSET(int_type);
> +	data +=3D BITS_ROUNDDOWN_BYTES(total_bits_offset);
> +	bit_offset =3D BITS_PER_BYTE_MASKED(total_bits_offset);
> +	bits_to_copy =3D bits + bit_offset;
> +	bytes_to_copy =3D BITS_ROUNDUP_BYTES(bits_to_copy);
> +
> +	print_num.u64_num =3D 0;
> +	memcpy(&print_num.u64_num, data, bytes_to_copy);
> +
> +	upper_bits =3D BITS_PER_BYTE_MASKED(bits_to_copy);
> +	if (upper_bits) {
> +		uint8_t mask =3D (1 << upper_bits) - 1;
> +
> +		print_num.u8_nums[bytes_to_copy - 1] &=3D mask;
> +	}
> +
> +	print_num.u64_num >>=3D bit_offset;
> +
> +	jsonw_printf(jw, "0x%llx", print_num.u64_num);
> +}
> +
> +static int btf_dumper_int(const struct btf_type *t, uint8_t bit_offset,
> +		const void *data, json_writer_t *jw)
> +{
> +	uint32_t *int_type =3D (uint32_t *)(t + 1);
> +	uint32_t bits =3D BTF_INT_BITS(*int_type);
> +	int ret =3D 0;
> +
> +	/* if this is bit field */
> +	if (bit_offset || BTF_INT_OFFSET(*int_type) ||
> +			BITS_PER_BYTE_MASKED(bits)) {
> +		btf_dumper_int_bits(*int_type, bit_offset, data, jw);
> +		return ret;
> +	}
> +
> +	switch (BTF_INT_ENCODING(*int_type)) {
> +	case 0:
> +		if (BTF_INT_BITS(*int_type) =3D=3D 64)
> +			jsonw_printf(jw, "%lu", *((uint64_t *)data));
> +		else if (BTF_INT_BITS(*int_type) =3D=3D 32)
> +			jsonw_printf(jw, "%u", *((uint32_t *)data));
> +		else if (BTF_INT_BITS(*int_type) =3D=3D 16)
> +			jsonw_printf(jw, "%hu", *((uint16_t *)data));
> +		else if (BTF_INT_BITS(*int_type) =3D=3D 8)
> +			jsonw_printf(jw, "%hhu", *((uint8_t *)data));
> +		else
> +			btf_dumper_int_bits(*int_type, bit_offset, data, jw);
> +		break;
> +	case BTF_INT_SIGNED:
> +		if (BTF_INT_BITS(*int_type) =3D=3D 64)
> +			jsonw_printf(jw, "%ld", *((int64_t *)data));
> +		else if (BTF_INT_BITS(*int_type) =3D=3D 32)
> +			jsonw_printf(jw, "%d", *((int32_t *)data));
> +		else if (BTF_INT_BITS(*int_type) =3D=3D  16)
> +			jsonw_printf(jw, "%hd", *((int16_t *)data));
> +		else if (BTF_INT_BITS(*int_type) =3D=3D  8)
> +			jsonw_printf(jw, "%hhd", *((int8_t *)data));
> +		else
> +			btf_dumper_int_bits(*int_type, bit_offset, data, jw);
> +		break;
> +	case BTF_INT_CHAR:
> +		if (*((char *)data) =3D=3D '\0')
> +			jsonw_null(jw);
> +		else if (isprint(*((char *)data)))
> +			jsonw_printf(jw, "\"%c\"", *((char *)data));
> +		else
> +			jsonw_printf(jw, "%hhx", *((char *)data));
> +		break;
> +	case BTF_INT_BOOL:
> +		jsonw_bool(jw, *((int *)data));
> +		break;
> +	default:
> +		/* shouldn't happen */
> +		ret =3D -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int btf_dumper_struct(const struct btf *btf, uint32_t type_id,
> +		const void *data, json_writer_t *jw)
> +{
> +	const struct btf_type *t =3D btf__type_by_id(btf, type_id);
> +	struct btf_member *m;
> +	int ret =3D 0;
> +	int i, vlen;
> +
> +	if (t =3D=3D NULL)
> +		return -EINVAL;
> +
> +	vlen =3D BTF_INFO_VLEN(t->info);
> +	jsonw_start_object(jw);
> +	m =3D (struct btf_member *)(t + 1);
> +
> +	for (i =3D 0; i < vlen; i++) {
> +		jsonw_name(jw, btf__name_by_offset(btf, m[i].name_off));
> +		ret =3D btf_dumper_do_type(btf, m[i].type,
> +				BITS_PER_BYTE_MASKED(m[i].offset),
> +				data + BITS_ROUNDDOWN_BYTES(m[i].offset), jw);
> +		if (ret)
> +			return ret;

Shall we call jsonw_end_object() before return here?=20

> +	}
> +
> +	jsonw_end_object(jw);
> +
> +	return 0;
> +}
> +
> +static int btf_dumper_do_type(const struct btf *btf, uint32_t type_id,
> +		uint8_t bit_offset, const void *data, json_writer_t *jw)
> +{
> +	const struct btf_type *t =3D btf__type_by_id(btf, type_id);
> +	int ret =3D 0;
> +
> +	switch (BTF_INFO_KIND(t->info)) {
> +	case BTF_KIND_INT:
> +		ret =3D btf_dumper_int(t, bit_offset, data, jw);
> +		break;
> +	case BTF_KIND_STRUCT:
> +	case BTF_KIND_UNION:
> +		ret =3D btf_dumper_struct(btf, type_id, data, jw);
> +		break;
> +	case BTF_KIND_ARRAY:
> +		ret =3D btf_dumper_array(btf, type_id, data, jw);
> +		break;
> +	case BTF_KIND_ENUM:
> +		btf_dumper_enum(data, jw);
> +		break;
> +	case BTF_KIND_PTR:
> +		btf_dumper_ptr(data, jw);
> +		break;
> +	case BTF_KIND_UNKN:
> +		jsonw_printf(jw, "(unknown)");
> +		break;
> +	case BTF_KIND_FWD:
> +		/* map key or value can't be forward */
> +		ret =3D -EINVAL;
> +		break;
> +	case BTF_KIND_TYPEDEF:
> +	case BTF_KIND_VOLATILE:
> +	case BTF_KIND_CONST:
> +	case BTF_KIND_RESTRICT:
> +		ret =3D btf_dumper_modifier(btf, type_id, data, jw);
> +		break;
> +	default:
> +		jsonw_printf(jw, "(unsupported-kind");

"(unsupported-kind)"   (missing ')').=20

> +		ret =3D -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +int32_t btf_dumper_type(const struct btf *btf, json_writer_t *jw,
> +		uint32_t type_id, const void *data)
> +{
> +	if (!jw)
> +		return -EINVAL;
> +
> +	return btf_dumper_do_type(btf, type_id, 0, data, jw);
nit: btf_dumper_do_type() returns int, while btf_dumper_type() returns int3=
2_t.=20
     This should not matter though.=20

> +}
> --- /dev/null
> +++ b/tools/bpf/bpftool/btf_dumper.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2018 Facebook */
> +
> +#ifndef BTF_DUMPER_H
> +#define BTF_DUMPER_H
> +
> +/* btf_dumper_type - json print data along with type information
> + * @btf: btf instance initialised via btf__new()
> + * @jw: json writer used for printing
> + * @type_id: index in btf->types array. this points to the type to be du=
mped
> + * @data: pointer the actual data, i.e. the values to be printed
> + *
> + * Returns zero on success and negative error code otherwise
> + */
> +int32_t btf_dumper_type(const struct btf *btf, json_writer_t *jw,
> +		uint32_t type_id, void *data);
> +
> +#endif
>=20

