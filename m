Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D1DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D042186A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="AzyfAZuN";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Fcke2ISE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbfB0RnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:43:03 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38534 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726397AbfB0RnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:43:03 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1RHdIxw004166;
        Wed, 27 Feb 2019 09:42:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=1uAWVXXcHjDD5sIfvGGnvdDE5FPx+PKvzVYB8W8hX0E=;
 b=AzyfAZuNJyBz+npIOSm5twfMKRC+jFYyDSKDL9CdhiDkvaXUUBDn2+VcFoJWsLnjVjyY
 p0vZdGCDanSeFk9FmiqyNux5E/oKzv3veRsiO6RiftBy1bucwe8wCWxS9MZHKITd866Z
 5QSLFTxPT47eNbCN7DlQj5iQ7X/27fs0bUo= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qwx31r9r6-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Feb 2019 09:42:36 -0800
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 27 Feb 2019 09:42:22 -0800
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 27 Feb 2019 09:42:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uAWVXXcHjDD5sIfvGGnvdDE5FPx+PKvzVYB8W8hX0E=;
 b=Fcke2ISEdI1Lsap4wnmnjTlZ5EC8O6P8AbrcI6g/kSRw4rXgNVS6J/FxlmOFmho7Dn6V9hh09I9MQOaazof2cowAJncr632+4nKysU+aDTh22Utd1q7IvkSxW4qbutF83w5OW59JiGsXAlH5CitcDkdfUoLTVQcg565RO2HIvNk=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1615.namprd15.prod.outlook.com (10.175.135.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Wed, 27 Feb 2019 17:42:14 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 17:42:14 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v4 perf,bpf 15/15] perf, bpf: save information about short
 living bpf programs
Thread-Topic: [PATCH v4 perf,bpf 15/15] perf, bpf: save information about
 short living bpf programs
Thread-Index: AQHUzWlIn3tcaXeZv02hEUq3YMx05aXzo9AAgABI6IA=
Date:   Wed, 27 Feb 2019 17:42:14 +0000
Message-ID: <ABB76EC1-01B7-4B4C-81DC-6C7155D512D8@fb.com>
References: <20190226002019.3748539-1-songliubraving@fb.com>
 <20190226002019.3748539-16-songliubraving@fb.com>
 <20190227132116.GD18893@krava>
In-Reply-To: <20190227132116.GD18893@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:180::eed9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: daf8611e-97a9-488f-ba86-08d69cdae8e4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1615;
x-ms-traffictypediagnostic: MWHPR15MB1615:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1615;20:4lJm0HhhkjXIrbIvHprviatC6OtKRjy7+5gmddSSNa5UmwvxFIwiSPyg6+ctnEV+9ZXT4UpCGsxIXVdUhxGP+lhuDmea0u9M++Ah1/aiqK7t9vBcspENCQUWCsdWnAADPKwjx0cnkKJA9plcUqU6nUFS5sQCUKWXrKs5FbszyEs=
x-microsoft-antispam-prvs: <MWHPR15MB1615C6EE2F7D5DE20E48CA8DB3740@MWHPR15MB1615.namprd15.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(366004)(376002)(39860400002)(199004)(189003)(54534003)(229853002)(105586002)(76176011)(6116002)(106356001)(50226002)(53936002)(6486002)(8676002)(6512007)(6246003)(33656002)(81156014)(6436002)(81166006)(71190400001)(71200400001)(99286004)(83716004)(4744005)(82746002)(68736007)(6916009)(186003)(478600001)(46003)(57306001)(7736002)(446003)(97736004)(305945005)(256004)(8936002)(4326008)(25786009)(476003)(6506007)(53546011)(14454004)(86362001)(54906003)(316002)(2906002)(102836004)(486006)(11346002)(36756003)(5660300002)(2616005)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1615;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: k5YmhsmTcX/IVe8MbA2LLpsrccFolwMA62YEGXt58m2Oa+nTWVre2sAZYc4MySc5l68AcFnNF29FGB3ifrF3KOzL8JwwNNvOd+W8Glk6gwz39xXfP6opSfby4gKvFS4HZdUfG4opNJduuc6/y16J5Nm+C/MQ2E5jTgfYNf4V48hnb0EfnmjFEgLk6xjDgOnbnnu9bfEd1K43+nWqczjuRKJVCqJCx548RM5iNle97g9BZoISZt7YW6u33OVJysNuLVpBP2jjCmchuw8a6qy8tR+HuvgaOSWTn7kuSVlgR9y/fN4Dxv9CO+AufP4QFCdMjNLuNNgnqHUUUR2rmtpP/MdYIJ+udcdEE4Fxx3nldQJqSZ0RgVyJJmUhw4MK81DjLXFBZnVd9okLHgLFPzS3yknvNwG0YWGEQ6uaDEZKgQo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <712300FF7AD09A4D88400BC5E6A56550@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: daf8611e-97a9-488f-ba86-08d69cdae8e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 17:42:14.2860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1615
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 27, 2019, at 5:21 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Mon, Feb 25, 2019 at 04:20:19PM -0800, Song Liu wrote:
>=20
> SNIP
>=20
>> +	btf_id =3D info_linear->info.btf_id;
>> +
>> +	info_node =3D malloc(sizeof(struct bpf_prog_info_node));
>> +	if (info_node) {
>> +		info_node->info_linear =3D info_linear;
>> +		perf_env__insert_bpf_prog_info(env, info_node);

Getting bpf_prog_info here.=20

>> +	} else
>> +		free(info_linear);
>> +
>> +	if (btf_id =3D=3D 0)
>> +		goto out;
>> +
>> +	if (btf__get_from_id(btf_id, &btf)) {
>> +		pr_debug("%s: failed to get BTF of id %u, aborting\n",
>> +			 __func__, btf_id);
>> +		goto out;
>> +	}
>> +	perf_env__fetch_btf(env, btf_id, btf);
>=20
> so is this the main reason we are doing this? getting the btf
> data for bpf prog ids and store them?

We are getting both bpf_prog_info (see above) and btf.=20

>=20
> please describe the whole bpf events/features data flow in
> changelog as I asked in previous email

I will add more details to the change log.=20

Thanks,
Song

>=20
> thanks,
> jirka

