Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C37C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B7520685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="s3Pz0e23";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="cKc5GQaV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfAIRQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:16:39 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:50950 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726292AbfAIRQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:16:39 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x09HFUf6017229;
        Wed, 9 Jan 2019 09:16:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=HMZkPphTDZSuW8avJ3Z/l0o+v6WKzFOs4h5VAne6w+g=;
 b=s3Pz0e23oCSoC6Qs0zhHBC1WIGUbvobf/MMnB6hpk4mEpeJPna3ZHvk8L/xxbSHfH1sr
 P7WAV0DmmzZzzrLLMf0rRcDWCgGN/yuSHUmm/uzH3wbi9sjxj2QeRk6Q6zSxwjO8/W7N
 aSTwES3sezDxXvGU0u8Wf2gmDTzWHMdLdcqTMyOlB+BSFqg6WdRK7ouZEqUkKKUTP1wA
 KbAPGk4G66FrfrU706lALCODr0b38MeuYWiqjNXwxvXQaT19AlxuV5tbn9x+67RqQc3t
 /91Pwpsoe7RJ5+7ko1mcEQ4S2wx1qWXbuPpcMohh3v8V6nfnafpQyTB7Flpbwd7gI25r mQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2pw18fcr1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 09 Jan 2019 09:16:19 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 9 Jan
 2019 09:16:17 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.58) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 9 Jan 2019 09:16:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMZkPphTDZSuW8avJ3Z/l0o+v6WKzFOs4h5VAne6w+g=;
 b=cKc5GQaVAGxTITJLjl0Frl9eg2MAL2xk0tZsnmy77oq/4oVhyq+obRwVlokcXHbUvCx6gy3XaXm3JnMHz8Omd31O5Y8xZXtntK65fXS94hXbgpEbOnaJppjbQsILT4gem5q4PUQ5BcTq+7Cm96zqCgCQovmlch+4Qbe5t31zKqE=
Received: from BN8PR18MB2881.namprd18.prod.outlook.com (20.179.75.28) by
 BN8PR18MB2609.namprd18.prod.outlook.com (20.179.66.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Wed, 9 Jan 2019 17:16:13 +0000
Received: from BN8PR18MB2881.namprd18.prod.outlook.com
 ([fe80::a536:44ee:bcc7:a5a3]) by BN8PR18MB2881.namprd18.prod.outlook.com
 ([fe80::a536:44ee:bcc7:a5a3%4]) with mapi id 15.20.1495.011; Wed, 9 Jan 2019
 17:16:13 +0000
From:   Yuri Norov <ynorov@marvell.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yury.norov@gmail.com" <yury.norov@gmail.com>
Subject: Re: [PATCH 3/4] bitmap_parselist: rework input string parser
Thread-Topic: [PATCH 3/4] bitmap_parselist: rework input string parser
Thread-Index: AQHUqD8F6SGWppBU7EKQYWUAdbDKHg==
Date:   Wed, 9 Jan 2019 17:16:12 +0000
Message-ID: <20190109171606.GA13789@yury-thinkpad>
References: <20181223094422.4849-1-ynorov@marvell.com>
 <20181223094422.4849-4-ynorov@marvell.com>
 <20190109160146.GG9170@smile.fi.intel.com>
In-Reply-To: <20190109160146.GG9170@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR0101CA0064.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::32) To BN8PR18MB2881.namprd18.prod.outlook.com
 (2603:10b6:408:a4::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [212.58.114.230]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN8PR18MB2609;20:rPdZSZWXoD2hZL3PoLvjw4tCLSGGzVDAn+tYvKFTKLlATuSRUuKdKl5OmVE7wzVyTEaMH0zwntwSHC1DMYb62itG70lOkoRa7zZn60G9H3z1c4S5BHYhutL8MOqqjoggte3vPxtTYjIhaK/gjaaWmTjmaFtgQHg8x2uri7rB2/U=
x-ms-office365-filtering-correlation-id: f540e150-5d50-4bfa-0eb1-08d6765627d5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BN8PR18MB2609;
x-ms-traffictypediagnostic: BN8PR18MB2609:
x-microsoft-antispam-prvs: <BN8PR18MB260987CA54F94CC926815CCFCB8B0@BN8PR18MB2609.namprd18.prod.outlook.com>
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(136003)(39860400002)(366004)(396003)(346002)(376002)(199004)(189003)(229853002)(478600001)(81156014)(54906003)(71200400001)(8676002)(6916009)(99286004)(106356001)(102836004)(33656002)(33896004)(305945005)(486006)(9686003)(386003)(5660300001)(68736007)(97736004)(316002)(81166006)(66066001)(6506007)(6512007)(105586002)(8936002)(33716001)(2906002)(76176011)(39060400002)(6246003)(256004)(6116002)(25786009)(52116002)(11346002)(446003)(14444005)(3846002)(186003)(14454004)(86362001)(53936002)(26005)(6436002)(4326008)(71190400001)(6486002)(476003)(1076003)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR18MB2609;H:BN8PR18MB2881.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Yu4c88qWtRC4e7oJWJKPHR4GCK8utaJBcOS0YXkCnKiR5AshcRgsDC7VFoTu+GvlptrXYpAJCtfY2Yg+4z88G4Z6POAd8J8+BCdd1TH3D0eioJb+NsK+m2rYdwlTXsAHEGahEWK+GCU55WM5BHito94zNeSqbU0AIm7kLINmlf6jSi1ZFI319DYoz6he6X0Ol2SYyiZGmkpRzZoF4t5DSHFg+YpvaCUT0TDbAhrvrRd90ijRxdWXAP1cWVftdSPv7qE1zfGApwQggP/5KBbqGrxFvuxP1ahMn0tGAyIbNxjMb6KHORxOG7I+iZT1oe4k
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1DBC804B6B19D744ADB9DA5ECF7BB7BD@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f540e150-5d50-4bfa-0eb1-08d6765627d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 17:16:12.9795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR18MB2609
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_09:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 06:01:46PM +0200, Andy Shevchenko wrote:
> On Sun, Dec 23, 2018 at 09:44:55AM +0000, Yuri Norov wrote:
> > The requirement for this rework is to keep the __bitmap_parselist()
> > copy-less and single-pass but make it more readable and maintainable by
> > splitting into logical parts and removing explicit nested cycles and
> > opaque local variables.
> >=20
> > __bitmap_parselist() can parse userspace inputs and therefore we cannot
> > use simple_strtoul() to parse numbers.
>=20
> I see two issues with this patch:
> - you are using IS_ERR() but ain't utilizing PTR_ERR(), ERR_PTR() ones

OK. Will use them in v2.

> - you remove lines here which you added in the same series.
>
> Second one shows ordering issue of logical changes.

Do you mean this chunk?

> > -		r.start =3D a;
> > -		r.off =3D used_size;
> > -		r.grlen =3D group_size;
> > -		r.end =3D b;

It's because I split refactoring into 2 parts for the sake of
readability. Patch #2 may be applied independently if #3 will
be considered inappropriate, that's why I ordered it prior to
#3, and it caused the need for removing that lines. I don't
think it's too ugly though, and I'd prefer to keep 2 and 3
separated with the cost of this little mess.

Reversing the order looks tricky at the first glance, but I'm
OK to join #2 and #3 if it will be considered worthy. Would
work both ways.

> > Signed-off-by: Yury Norov <ynorov@marvell.com>
> > ---
> >  lib/bitmap.c | 247 ++++++++++++++++++++++++++++++---------------------
> >  1 file changed, 148 insertions(+), 99 deletions(-)
> >=20
> > diff --git a/lib/bitmap.c b/lib/bitmap.c
> > index a60fd9723677..edc7068c28a6 100644
> > --- a/lib/bitmap.c
> > +++ b/lib/bitmap.c
> > @@ -513,6 +513,140 @@ static int bitmap_check_region(const struct regio=
n *r)
> >  	return 0;
> >  }
> > =20
> > +static long get_char(char *c, const char *str, int is_user)
> > +{
> > +	if (unlikely(is_user))
> > +		return __get_user(*c, str);
> > +
> > +	*c =3D *str;
> > +	return 0;
> > +}
> > +
> > +static const char *bitmap_getnum(unsigned int *num, const char *str,
> > +			    const char *const end, int is_user)
> > +{
> > +	unsigned int n =3D 0;
> > +	const char *_str;
> > +	long ret;
> > +	char c;
> > +
> > +	for (_str =3D str, *num =3D 0; _str <=3D end; _str++) {
> > +		ret =3D get_char(&c, _str, is_user);
> > +		if (ret)
> > +			return (char *)ret;
> > +
> > +		if (!isdigit(c)) {
> > +			if (_str =3D=3D str)
> > +				return (char *)-EINVAL;
> > +
> > +			goto out;
> > +		}
> > +
> > +		*num =3D *num * 10 + (c - '0');
> > +		if (*num < n)
> > +			return (char *)-EOVERFLOW;
> > +
> > +		n =3D *num;
> > +	}
> > +
> > +out:
> > +	return _str;
> > +}
> > +
> > +static const char *bitmap_find_region(const char *str,
> > +			const char *const end, int is_user)
> > +{
> > +	long ret;
> > +	char c;
> > +
> > +	for (; str < end; str++) {
> > +		ret =3D get_char(&c, str, is_user);
> > +		if (ret)
> > +			return (char *)ret;
> > +
> > +		/* Unexpected end of line. */
> > +		if (c =3D=3D 0 || c =3D=3D '\n')
> > +			return NULL;
> > +
> > +		/*
> > +		 * The format allows commas and whitespases
> > +		 * at the beginning of the region, so skip it.
> > +		 */
> > +		if (!isspace(c) && c !=3D ',')
> > +			break;
> > +	}
> > +
> > +	return str;
> > +}
> > +
> > +static const char *bitmap_parse_region(struct region *r, const char *s=
tr,
> > +				 const char *const end, int is_user)
> > +{
> > +	long ret;
> > +	char c;
> > +
> > +	str =3D bitmap_getnum(&r->start, str, end, is_user);
> > +	if (IS_ERR(str))
> > +		return str;
> > +
> > +	ret =3D get_char(&c, str, is_user);
> > +	if (ret)
> > +		return (char *)ret;
> > +
> > +	if (c =3D=3D 0 || c =3D=3D '\n') {
> > +		str =3D end + 1;
> > +		goto no_end;
> > +	}
> > +
> > +	if (isspace(c) || c =3D=3D ',')
> > +		goto no_end;
> > +
> > +	if (c !=3D '-')
> > +		return (char *)-EINVAL;
> > +
> > +	str =3D bitmap_getnum(&r->end, str + 1, end, is_user);
> > +	if (IS_ERR(str))
> > +		return str;
> > +
> > +	ret =3D get_char(&c, str, is_user);
> > +	if (ret)
> > +		return (char *)ret;
> > +
> > +	if (c =3D=3D 0 || c =3D=3D '\n') {
> > +		str =3D end + 1;
> > +		goto no_pattern;
> > +	}
> > +
> > +	if (isspace(c) || c =3D=3D ',')
> > +		goto no_pattern;
> > +
> > +	if (c !=3D ':')
> > +		return (char *)-EINVAL;
> > +
> > +	str =3D bitmap_getnum(&r->off, str + 1, end, is_user);
> > +	if (IS_ERR(str))
> > +		return str;
> > +
> > +	ret =3D get_char(&c, str, is_user);
> > +	if (ret)
> > +		return (char *)ret;
> > +
> > +	if (c !=3D '/')
> > +		return (char *)-EINVAL;
> > +
> > +	str =3D bitmap_getnum(&r->grlen, str + 1, end, is_user);
> > +
> > +	return str;
> > +
> > +no_end:
> > +	r->end =3D r->start;
> > +no_pattern:
> > +	r->off =3D r->end + 1;
> > +	r->grlen =3D r->end + 1;
> > +
> > +	return (char *)str;

This cast looks unneeded.

> > +}
> > +
> >  /**
> >   * __bitmap_parselist - convert list format ASCII string to bitmap
> >   * @buf: read nul-terminated user string from this buffer
> > @@ -534,113 +668,28 @@ static int bitmap_check_region(const struct regi=
on *r)
> >   *
> >   * Returns: 0 on success, -errno on invalid input strings. Error value=
s:
> >   *
> > - *   - ``-EINVAL``: second number in range smaller than first
> > + *   - ``-EINVAL``: wrong region format
> >   *   - ``-EINVAL``: invalid character in string
> >   *   - ``-ERANGE``: bit number specified too large for mask
> > + *   - ``-EOVERFLOW``: integer overflow in the input parameters
> >   */
> > -static int __bitmap_parselist(const char *buf, unsigned int buflen,
> > +static int __bitmap_parselist(const char *buf, const char *const end,
> >  		int is_user, unsigned long *maskp,
> >  		int nmaskbits)
> >  {
> > -	unsigned int a, b, old_a, old_b;
> > -	unsigned int group_size, used_size;
> > -	int c, old_c, totaldigits, ndigits;
> > -	const char __user __force *ubuf =3D (const char __user __force *)buf;
> > -	int at_start, in_range, in_partial_range, ret;
> >  	struct region r;
> > +	long ret;
> > =20
> > -	totaldigits =3D c =3D 0;
> > -	old_a =3D old_b =3D 0;
> > -	group_size =3D used_size =3D 0;
> >  	bitmap_zero(maskp, nmaskbits);
> > -	do {
> > -		at_start =3D 1;
> > -		in_range =3D 0;
> > -		in_partial_range =3D 0;
> > -		a =3D b =3D 0;
> > -		ndigits =3D totaldigits;
> > -
> > -		/* Get the next cpu# or a range of cpu#'s */
> > -		while (buflen) {
> > -			old_c =3D c;
> > -			if (is_user) {
> > -				if (__get_user(c, ubuf++))
> > -					return -EFAULT;
> > -			} else
> > -				c =3D *buf++;
> > -			buflen--;
> > -			if (isspace(c))
> > -				continue;
> > -
> > -			/* A '\0' or a ',' signal the end of a cpu# or range */
> > -			if (c =3D=3D '\0' || c =3D=3D ',')
> > -				break;
> > -			/*
> > -			* whitespaces between digits are not allowed,
> > -			* but it's ok if whitespaces are on head or tail.
> > -			* when old_c is whilespace,
> > -			* if totaldigits =3D=3D ndigits, whitespace is on head.
> > -			* if whitespace is on tail, it should not run here.
> > -			* as c was ',' or '\0',
> > -			* the last code line has broken the current loop.
> > -			*/
> > -			if ((totaldigits !=3D ndigits) && isspace(old_c))
> > -				return -EINVAL;
> > -
> > -			if (c =3D=3D '/') {
> > -				used_size =3D a;
> > -				at_start =3D 1;
> > -				in_range =3D 0;
> > -				a =3D b =3D 0;
> > -				continue;
> > -			}
> > -
> > -			if (c =3D=3D ':') {
> > -				old_a =3D a;
> > -				old_b =3D b;
> > -				at_start =3D 1;
> > -				in_range =3D 0;
> > -				in_partial_range =3D 1;
> > -				a =3D b =3D 0;
> > -				continue;
> > -			}
> > -
> > -			if (c =3D=3D '-') {
> > -				if (at_start || in_range)
> > -					return -EINVAL;
> > -				b =3D 0;
> > -				in_range =3D 1;
> > -				at_start =3D 1;
> > -				continue;
> > -			}
> > =20
> > -			if (!isdigit(c))
> > -				return -EINVAL;
> > -
> > -			b =3D b * 10 + (c - '0');
> > -			if (!in_range)
> > -				a =3D b;
> > -			at_start =3D 0;
> > -			totaldigits++;
> > -		}
> > -		if (ndigits =3D=3D totaldigits)
> > -			continue;
> > -		if (in_partial_range) {
> > -			group_size =3D a;
> > -			a =3D old_a;
> > -			b =3D old_b;
> > -			old_a =3D old_b =3D 0;
> > -		} else {
> > -			used_size =3D group_size =3D b - a + 1;
> > -		}
> > -		/* if no digit is after '-', it's wrong*/
> > -		if (at_start && in_range)
> > -			return -EINVAL;
> > +	while (buf && buf < end) {
> > +		buf =3D bitmap_find_region(buf, end, is_user);
> > +		if (buf =3D=3D NULL)
> > +			return 0;
> > =20
> > -		r.start =3D a;
> > -		r.off =3D used_size;
> > -		r.grlen =3D group_size;
> > -		r.end =3D b;
> > +		buf =3D bitmap_parse_region(&r, buf, end, is_user);
> > +		if (IS_ERR(buf))
> > +			return (long)buf;
> > =20
> >  		ret =3D bitmap_check_region(&r);
> >  		if (ret)
> > @@ -649,14 +698,14 @@ static int __bitmap_parselist(const char *buf, un=
signed int buflen,
> >  		ret =3D bitmap_set_region(&r, maskp, nmaskbits);
> >  		if (ret)
> >  			return ret;
> > +	}
> > =20
> > -	} while (buflen && c =3D=3D ',');
> >  	return 0;
> >  }
> > =20
> >  int bitmap_parselist(const char *bp, unsigned long *maskp, int nmaskbi=
ts)
> >  {
> > -	return __bitmap_parselist(bp, UINT_MAX, 0, maskp, nmaskbits);
> > +	return __bitmap_parselist(bp, (char *)SIZE_MAX, 0, maskp, nmaskbits);
> >  }
> >  EXPORT_SYMBOL(bitmap_parselist);
> > =20
> > @@ -683,7 +732,7 @@ int bitmap_parselist_user(const char __user *ubuf,
> >  	if (!access_ok(VERIFY_READ, ubuf, ulen))
> >  		return -EFAULT;
> >  	return __bitmap_parselist((const char __force *)ubuf,
> > -					ulen, 1, maskp, nmaskbits);
> > +					ubuf + ulen - 1, 1, maskp, nmaskbits);
> >  }
> >  EXPORT_SYMBOL(bitmap_parselist_user);
> > =20
> > --=20
> > 2.17.1
> >=20
>=20

Thanks,
Yury
