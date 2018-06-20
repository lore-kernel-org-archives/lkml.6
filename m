Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0173BC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47BA20874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="X4UZDnX3";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Aty8/cBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47BA20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932591AbeFTXXg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 19:23:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33744 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932434AbeFTXXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 19:23:34 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KNJtPq020830;
        Wed, 20 Jun 2018 16:23:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=R0EEq99/re3ApHZRAGSYcBaMAhhT27TRsJVkF3mlo7U=;
 b=X4UZDnX3qM2dO/4ldXbVORM9WRmxkL97JXSxjoBXbg5t25dqQ2KyopzBXhJNzEQO+jVI
 qtjqhVOKhc3L7dbp9krLR2ut6OT2Nt7bqasMojEHgVvgqfOwXRl0BMrVJ5nm4rNCWEuu
 Z3XHOKbsjJFKGYQtalnfprWLrbFVpgVenyA= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jr05wg21p-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 20 Jun 2018 16:23:00 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.19) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 20 Jun 2018 16:22:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0EEq99/re3ApHZRAGSYcBaMAhhT27TRsJVkF3mlo7U=;
 b=Aty8/cBWq+JC6kIC1YrqDy5vnFotlyPCuUGb8viuLOPjgwUulUCbxBfYwUBuMd/Po+ZBCT3cBqLsH6QE51/3vziwfmgL4ZR6s0xgZpBaYohBAdVlxDuIkYJrDRklHPAFA7/MNWUwfYBOg9VhQAJQ6b964bWkQ6aknL2K1TAWWI0=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1357.namprd15.prod.outlook.com (10.173.232.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.17; Wed, 20 Jun 2018 23:22:52 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::7044:6139:1178:6ace]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::7044:6139:1178:6ace%8]) with mapi id 15.20.0863.016; Wed, 20 Jun 2018
 23:22:52 +0000
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
Subject: Re: [PATCH bpf-next 3/3] bpf: btf: json print map dump with btf info
Thread-Topic: [PATCH bpf-next 3/3] bpf: btf: json print map dump with btf info
Thread-Index: AQHUCNbfG0XxUHyV7kyBJllOQ764QaRpyYmA
Date:   Wed, 20 Jun 2018 23:22:52 +0000
Message-ID: <60109415-AE62-4E4A-BF7D-401F66245523@fb.com>
References: <20180620203051.223156973@fb.com>
 <20180620203703.208599277@fb.com>
In-Reply-To: <20180620203703.208599277@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.6.18)
x-originating-ip: [2620:10d:c090:200::5:f975]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1357;7:Via0sKhP6GAJba2tIuUg3K/UQosPYmQyZWjuTkOoOYVPi+7E7ml9pwBfz65FeEiFIGZQKqsl9yDqoylJ/aYqa/bY0Ue85Z0M6BYv0MKDZJARFueN5iYajwWuAWG3I4DxIaFlmXsmFv1ya2MRJu4ZD7UkEfftIiiAJSIotpxc1gdHgg/Vfh687pD6N1CNBNsyhlW9bxmpRWjSVl04BXpS5ssOhh9KXMKLtbCYvQhGW+Q80nu8oD3IrYrdx5mYqusV;20:eu5g/ohI9Py3eFWt6JAhFFYxk2seB9xPZyNxQjSminUDiUpTtr+gUwRiiowE7sZ1/vaSd7lMFihfua4OiTIekW0+wChdEV/QM6H8FEua4tSdB2Rd16bBsmPIF8fObUMqKmJICzImUY5tcF/8XSjgUsuwO1eA2ACoM0K0F5SjGSI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: ffe8c151-dc39-43f2-a6b6-08d5d704bece
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1357;
x-ms-traffictypediagnostic: MWHPR15MB1357:
x-microsoft-antispam-prvs: <MWHPR15MB1357B8FE810904687CB658D1B3770@MWHPR15MB1357.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR15MB1357;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1357;
x-forefront-prvs: 070912876F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(396003)(376002)(199004)(189003)(97736004)(6862004)(33656002)(305945005)(6486002)(82746002)(229853002)(50226002)(8936002)(106356001)(3660700001)(7736002)(81166006)(81156014)(2906002)(8676002)(3280700002)(25786009)(105586002)(6436002)(6512007)(5250100002)(6246003)(4326008)(39060400002)(2900100001)(53936002)(6116002)(11346002)(5660300001)(478600001)(486006)(446003)(2616005)(36756003)(6636002)(14454004)(316002)(37006003)(57306001)(83716003)(54906003)(99286004)(102836004)(76176011)(46003)(476003)(6506007)(86362001)(53546011)(68736007)(59450400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1357;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RoWwhuPy5w8+d1IH6YCZYVcsHM2tLDR8agexJx5JS/+oZjUeW6S8WGdKW3w3TcoqaS/3qNoKVGBBl8NlQIDs5ThuY04QOYz89W79pknZk6thPfJ1IyH0vkvxKT9ckMpKgqpIDAQpaoPruXQScjckrnMa0kO0G7NmITkznD+X/kKbbRTvFk7II4Q5ZJZUGw9vi0Dbv1tYwVcI8TPZGooHJ2IgeadbBSZ8KzEmcX7ETvNrhJjSG7Hnyuise56+SRjnULqLR9OL1tWkQT/Bs52lB3vns0UTYyOSpd9M6mFfcL/sQIL7e7afa9lII0V+D1oD
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B43306B28838C544AD8A5158FC5E455C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe8c151-dc39-43f2-a6b6-08d5d704bece
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2018 23:22:52.2076
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



> On Jun 20, 2018, at 1:30 PM, Okash Khawaja <osk@fb.com> wrote:
>=20
> This patch modifies `bpftool map dump [-j|-p] id <map-id>` to json-
> print and pretty-json-print map dump. It calls btf_dumper introduced in
> previous patch to accomplish this.
>=20
> The patch only prints debug info when -j or -p flags are supplied. Then
> too, if the map has associated btf data loaded. Otherwise the usual
> debug-less output is printed.
>=20
> Signed-off-by: Okash Khawaja <osk@fb.com>
> Acked-by: Martin KaFai Lau <kafai@fb.com>
>=20
> ---
> tools/bpf/bpftool/map.c |   94 ++++++++++++++++++++++++++++++++++++++++++=
++++--
> 1 file changed, 91 insertions(+), 3 deletions(-)
>=20
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -43,9 +43,13 @@
> #include <unistd.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> +#include <linux/err.h>
>=20
> #include <bpf.h>
>=20
> +#include "json_writer.h"
> +#include "btf.h"
> +#include "btf_dumper.h"
> #include "main.h"
>=20
> static const char * const map_type_name[] =3D {
> @@ -508,6 +512,83 @@ static int do_show(int argc, char **argv
> 	return errno =3D=3D ENOENT ? 0 : -1;
> }
>=20
> +
> +static int do_dump_btf(struct btf *btf, struct bpf_map_info *map_info,
> +		void *key, void *value)
> +{
> +	int ret;
> +
> +	jsonw_start_object(json_wtr);
> +	jsonw_name(json_wtr, "key");
> +
> +	ret =3D btf_dumper_type(btf, json_wtr, map_info->btf_key_type_id, key);
> +	if (ret)
> +		goto out;
> +
> +	jsonw_end_object(json_wtr);
> +
> +	jsonw_start_object(json_wtr);
> +	jsonw_name(json_wtr, "value");
> +
> +	ret =3D btf_dumper_type(btf, json_wtr, map_info->btf_value_type_id,
> +			value);
> +
> +out:
> +	/* end of root object */
> +	jsonw_end_object(json_wtr);
> +
> +	return ret;
> +}

Please add some tests for do_dump_btf(), including some invalid data type/k=
ind.=20

> +
> +static struct btf *get_btf(struct bpf_map_info *map_info)
> +{
> +	int btf_fd =3D bpf_btf_get_fd_by_id(map_info->btf_id);
> +	struct bpf_btf_info btf_info =3D { 0 };
> +	__u32 len =3D sizeof(btf_info);
> +	uint32_t last_size;
> +	int err;
> +	struct btf *btf =3D NULL;
> +	void *ptr =3D NULL, *temp_ptr;
> +
> +	if (btf_fd < 0)
> +		return NULL;
> +
> +	btf_info.btf_size =3D 4096;

Is btf_size always a constant of 4096?=20

> +	do {
> +		last_size =3D btf_info.btf_size;
> +		temp_ptr =3D realloc(ptr, last_size);
> +		if (!temp_ptr) {
> +			p_err("unable allocate memory for debug info.");
> +			goto exit_free;
> +		}
> +
> +		ptr =3D temp_ptr;
> +		bzero(ptr, last_size);
> +		btf_info.btf =3D ptr_to_u64(ptr);
> +		err =3D bpf_obj_get_info_by_fd(btf_fd, &btf_info, &len);
> +	} while (!err && btf_info.btf_size > last_size && last_size =3D=3D 4096=
);
> +
> +	if (err || btf_info.btf_size > last_size) {
> +		p_info("can't get btf info. debug info won't be displayed. error: %s",
> +				err ? strerror(errno) : "exceeds size retry");
> +		goto exit_free;
> +	}
> +
> +	btf =3D btf__new((uint8_t *) btf_info.btf,
> +			btf_info.btf_size, NULL);
> +	if (IS_ERR(btf)) {
> +		printf("error when initialising btf: %s\n",
> +				strerror(PTR_ERR(btf)));
> +		btf =3D NULL;
> +	}
> +
> +exit_free:
> +	close(btf_fd);
> +	free(ptr);
> +
> +	return btf;
> +}
> +
> static int do_dump(int argc, char **argv)
> {
> 	void *key, *value, *prev_key;
> @@ -516,6 +597,7 @@ static int do_dump(int argc, char **argv
> 	__u32 len =3D sizeof(info);
> 	int err;
> 	int fd;
> +	struct btf *btf =3D NULL;
>=20
> 	if (argc !=3D 2)
> 		usage();
> @@ -538,6 +620,8 @@ static int do_dump(int argc, char **argv
> 		goto exit_free;
> 	}
>=20
> +	btf =3D get_btf(&info);
> +
> 	prev_key =3D NULL;
> 	if (json_output)
> 		jsonw_start_array(json_wtr);
> @@ -550,9 +634,12 @@ static int do_dump(int argc, char **argv
> 		}
>=20
> 		if (!bpf_map_lookup_elem(fd, key, value)) {
> -			if (json_output)
> -				print_entry_json(&info, key, value);
> -			else
> +			if (json_output) {
> +				if (btf)
> +					do_dump_btf(btf, &info, key, value);
> +				else
> +					print_entry_json(&info, key, value);
> +			} else
> 				print_entry_plain(&info, key, value);
> 		} else {
> 			if (json_output) {
> @@ -584,6 +671,7 @@ exit_free:
> 	free(key);
> 	free(value);
> 	close(fd);
> +	btf__free(btf);
>=20
> 	return err;
> }
>=20

