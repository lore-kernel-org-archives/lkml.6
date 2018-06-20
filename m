Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA25C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841C420874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="FC/5yCXO";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ZW22NuPI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 841C420874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932707AbeFTXYg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 19:24:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52950 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932154AbeFTXYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 19:24:34 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KNNEmF027791;
        Wed, 20 Jun 2018 16:24:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=bAiQ4d4U8UT0luvWZFC4v+SVwXQH/napbotA3FQAAvI=;
 b=FC/5yCXOjwrxeVf0wVsEaOkfk5FiSrV+xI52uLEWGVwOcq13WrM/dwhdsZiT7XjpnFDp
 PgCfp+YoKJwlhCN2Vd5A2ZFFSJ3zM8w7h++30HuQlPDDHvsvHSnAMdga+zreLUQSNx+V
 noboIW9GfgFGrftpcdnEbLMKXW0q53XgZO0= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jqx67gdyb-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 20 Jun 2018 16:24:10 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 20 Jun 2018 19:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAiQ4d4U8UT0luvWZFC4v+SVwXQH/napbotA3FQAAvI=;
 b=ZW22NuPIZhemF8oeosan3VSWn+tvjRTWpQvfxNINm9hMOZ4eucSd9cQ5toGcs4zH+ldQrot0DeA2TwjHQZr6nV3C1jpfgWO0IvGsEqsVB6Ymsf+S+AkT4+/3d5zG6GtvrYcLOdZcnNbEv4A2Ym5SVTNXwMLtITA200/q2NF1YL0=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1357.namprd15.prod.outlook.com (10.173.232.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.17; Wed, 20 Jun 2018 23:24:00 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::7044:6139:1178:6ace]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::7044:6139:1178:6ace%8]) with mapi id 15.20.0863.016; Wed, 20 Jun 2018
 23:24:00 +0000
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
Thread-Index: AQHUCNbnxSXMFV+WbUWxh41B5ch9i6RpvaUAgAACYwCAAAnSgA==
Date:   Wed, 20 Jun 2018 23:24:00 +0000
Message-ID: <599DC237-386E-495A-B205-2C76A7AFEDFF@fb.com>
References: <20180620203051.223156973@fb.com>
 <20180620203702.996737905@fb.com>
 <AD663533-9EF3-47EE-A2BA-87E1938776BA@fb.com> <20180620224849.GA18488@w1t1fb>
In-Reply-To: <20180620224849.GA18488@w1t1fb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.6.18)
x-originating-ip: [2620:10d:c090:200::5:f975]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1357;7:5kTcI5iPVRga1Gsb2m3yjmQywiI2u53zI1tKJ4eMteOLfNsYx/AW5+zydgVaeseMv+fgqIMLI8pZ9W/mnZNJw93LN3T9x5e3QyMwj1aK4PTfaB/PHtCrPEHt35c210SQca44AS9JVH/6o815nFyuSlT6IZcXL/L893Nmmld2OIlxPRIeS3I/HIdq3dgrJ+NoY5QfYzqtGCr2aW8cbHqIpSXDGm2SUCYdH6T5/wx+xDf0jBbyTyf7mdKOV+y8ZDT3;20:nXRCLHvQwg7Ailr6c2O19z3O9JftMrAWEGtMF1XAp5uhKGUbTnIwL4q/gnSeYO8sfBnbESMzD1tvD1sz2AGaL1df3um2HfgJ9ugh4ltPMIAIzH9+ZvuiK9RbS3oPt/lwBhbwtMdFAewAObAiZDpDF+3zbclpQMi/hy9AMzY+Rc4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 16bc9940-5590-4766-f529-08d5d704e74f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1357;
x-ms-traffictypediagnostic: MWHPR15MB1357:
x-microsoft-antispam-prvs: <MWHPR15MB1357889B2344EA06A93567B5B3770@MWHPR15MB1357.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR15MB1357;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1357;
x-forefront-prvs: 070912876F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(396003)(376002)(57704003)(199004)(189003)(97736004)(6862004)(33656002)(305945005)(6486002)(82746002)(229853002)(50226002)(8936002)(106356001)(3660700001)(7736002)(81166006)(81156014)(2906002)(8676002)(3280700002)(25786009)(105586002)(6436002)(6512007)(5250100002)(6246003)(4326008)(39060400002)(2900100001)(53936002)(6116002)(11346002)(5660300001)(478600001)(486006)(446003)(2616005)(36756003)(6636002)(14454004)(316002)(37006003)(57306001)(83716003)(54906003)(99286004)(102836004)(76176011)(46003)(476003)(6506007)(86362001)(53546011)(68736007)(93886005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1357;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: B79RgtrnmxN5xB2riQG5UCfFgC2LIegXiio87x5HKDY6Hm3NBg7q9XE+9W496/V9HSK23O+IEGvFMpVq+zgWBPEVMIgMkpU4f/I0dtIvB0aT7pdjzgtChZwl7M9zvJJR86mlPusLS08p9o85U4o0kA7MBqznvMAEqmGKHaGUlO3HKAVJzoTJWPFfswN5+2n4dMtrt4WpxSs0O5bUBWFYJI7bvgjaHSrQOFj+/CZ5werNBGYpHxaodtL+7V4RNA5T9uDsvf5tGUBL5reeS4ch34jNtUdF0aHlTkVErvjHmxjaS9oVKj/IEukZ8DLLoBWx7gi3Mw4kBJjtnXsJfdKJ3Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F8B2845C035900449331B3793A03CCFC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 16bc9940-5590-4766-f529-08d5d704e74f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2018 23:24:00.2260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1357
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-20_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 20, 2018, at 3:48 PM, Okash Khawaja <osk@fb.com> wrote:
>=20
> On Wed, Jun 20, 2018 at 11:40:19PM +0100, Song Liu wrote:
>>=20
>>=20
>>> On Jun 20, 2018, at 1:30 PM, Okash Khawaja <osk@fb.com> wrote:
>>>=20
>>> This patch introduces btf__resolve_type() function and exports two
>>> existing functions from libbpf. btf__resolve_type follows modifier
>>> types like const and typedef until it hits a type which actually takes
>>> up memory, and then returns it. This function follows similar pattern
>>> to btf__resolve_size but instead of computing size, it just returns
>>> the type.
>>>=20
>>> These  functions will be used in the followig patch which parses
>>> information inside array of `struct btf_type *`. btf_name_by_offset is
>>> used for printing variable names.
>>>=20
>>> Signed-off-by: Okash Khawaja <osk@fb.com>
>>> Acked-by: Martin KaFai Lau <kafai@fb.com>
>>>=20
>>> ---
>>> tools/lib/bpf/btf.c |   65 ++++++++++++++++++++++++++++++++++++--------=
--------
>>> tools/lib/bpf/btf.h |    3 ++
>>> 2 files changed, 48 insertions(+), 20 deletions(-)
>>>=20
>>> --- a/tools/lib/bpf/btf.c
>>> +++ b/tools/lib/bpf/btf.c
>>> @@ -17,6 +17,11 @@
>>>=20
>>> #define BTF_MAX_NR_TYPES 65535
>>>=20
>>> +#define IS_MODIFIER(k) (((k) =3D=3D BTF_KIND_TYPEDEF) || \
>>> +		((k) =3D=3D BTF_KIND_VOLATILE) || \
>>> +		((k) =3D=3D BTF_KIND_CONST) || \
>>> +		((k) =3D=3D BTF_KIND_RESTRICT))
>>> +
>>> static struct btf_type btf_void;
>>>=20
>>> struct btf {
>>> @@ -33,14 +38,6 @@ struct btf {
>>> 	int fd;
>>> };
>>>=20
>>> -static const char *btf_name_by_offset(const struct btf *btf, uint32_t =
offset)
>>> -{
>>> -	if (offset < btf->hdr->str_len)
>>> -		return &btf->strings[offset];
>>> -	else
>>> -		return NULL;
>>> -}
>>> -
>>> static int btf_add_type(struct btf *btf, struct btf_type *t)
>>> {
>>> 	if (btf->types_size - btf->nr_types < 2) {
>>> @@ -190,15 +187,6 @@ static int btf_parse_type_sec(struct btf
>>> 	return 0;
>>> }
>>>=20
>>> -static const struct btf_type *btf_type_by_id(const struct btf *btf,
>>> -					     uint32_t type_id)
>>> -{
>>> -	if (type_id > btf->nr_types)
>>> -		return NULL;
>>> -
>>> -	return btf->types[type_id];
>>> -}
>>=20
>> nit: Why do we need to move these two functions to later of the file?=20
> No real reason. It looked like this file was following a convention of
> keeping statics together. I'll put them back in place if no one objects.

I see. Let's keep this patch as-is then.=20

Thanks,
Song

>=20
>>=20
>> Other than this,
>>=20
>> Acked-by: Song Liu <songliubraving@fb.com>
> Thanks
>=20
>>=20
>>> -
>>> static bool btf_type_is_void(const struct btf_type *t)
>>> {
>>> 	return t =3D=3D &btf_void || BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_FW=
D;
>>> @@ -234,7 +222,7 @@ int64_t btf__resolve_size(const struct b
>>> 	int64_t size =3D -1;
>>> 	int i;
>>>=20
>>> -	t =3D btf_type_by_id(btf, type_id);
>>> +	t =3D btf__type_by_id(btf, type_id);
>>> 	for (i =3D 0; i < MAX_RESOLVE_DEPTH && !btf_type_is_void_or_null(t);
>>> 	     i++) {
>>> 		size =3D btf_type_size(t);
>>> @@ -259,7 +247,7 @@ int64_t btf__resolve_size(const struct b
>>> 			return -EINVAL;
>>> 		}
>>>=20
>>> -		t =3D btf_type_by_id(btf, type_id);
>>> +		t =3D btf__type_by_id(btf, type_id);
>>> 	}
>>>=20
>>> 	if (size < 0)
>>> @@ -271,6 +259,26 @@ int64_t btf__resolve_size(const struct b
>>> 	return nelems * size;
>>> }
>>>=20
>>> +int32_t btf__resolve_type(const struct btf *btf, uint32_t type_id)
>>> +{
>>> +	const struct btf_type *t;
>>> +	int depth =3D 0;
>>> +
>>> +	t =3D btf__type_by_id(btf, type_id);
>>> +	while (depth < MAX_RESOLVE_DEPTH &&
>>> +			!btf_type_is_void_or_null(t) &&
>>> +			IS_MODIFIER(BTF_INFO_KIND(t->info))) {
>>> +		type_id =3D t->type;
>>> +		t =3D btf__type_by_id(btf, type_id);
>>> +		depth++;
>>> +	}
>>> +
>>> +	if (depth =3D=3D MAX_RESOLVE_DEPTH || btf_type_is_void_or_null(t))
>>> +		return -EINVAL;
>>> +
>>> +	return type_id;
>>> +}
>>> +
>>> int32_t btf__find_by_name(const struct btf *btf, const char *type_name)
>>> {
>>> 	uint32_t i;
>>> @@ -280,7 +288,7 @@ int32_t btf__find_by_name(const struct b
>>>=20
>>> 	for (i =3D 1; i <=3D btf->nr_types; i++) {
>>> 		const struct btf_type *t =3D btf->types[i];
>>> -		const char *name =3D btf_name_by_offset(btf, t->name_off);
>>> +		const char *name =3D btf__name_by_offset(btf, t->name_off);
>>>=20
>>> 		if (name && !strcmp(type_name, name))
>>> 			return i;
>>> @@ -371,3 +379,20 @@ int btf__fd(const struct btf *btf)
>>> {
>>> 	return btf->fd;
>>> }
>>> +
>>> +const char *btf__name_by_offset(const struct btf *btf, uint32_t offset=
)
>>> +{
>>> +	if (offset < btf->hdr->str_len)
>>> +		return &btf->strings[offset];
>>> +	else
>>> +		return NULL;
>>> +}
>>> +
>>> +const struct btf_type *btf__type_by_id(const struct btf *btf,
>>> +					     uint32_t type_id)
>>> +{
>>> +	if (type_id > btf->nr_types)
>>> +		return NULL;
>>> +
>>> +	return btf->types[type_id];
>>> +}
>>> --- a/tools/lib/bpf/btf.h
>>> +++ b/tools/lib/bpf/btf.h
>>> @@ -17,6 +17,9 @@ void btf__free(struct btf *btf);
>>> struct btf *btf__new(uint8_t *data, uint32_t size, btf_print_fn_t err_l=
og);
>>> int32_t btf__find_by_name(const struct btf *btf, const char *type_name)=
;
>>> int64_t btf__resolve_size(const struct btf *btf, uint32_t type_id);
>>> +int32_t btf__resolve_type(const struct btf *btf, uint32_t type_id);
>>> int btf__fd(const struct btf *btf);
>>> +const char *btf__name_by_offset(const struct btf *btf, uint32_t offset=
);
>>> +const struct btf_type *btf__type_by_id(const struct btf *btf, uint32_t=
 type_id);
>>>=20
>>> #endif

