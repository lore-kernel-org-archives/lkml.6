Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB3CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E5920C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="R308N/sI";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Yzouun/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbfB0R3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:29:11 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35970 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725854AbfB0R3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:29:11 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1RHOtAh017756;
        Wed, 27 Feb 2019 09:28:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=a5dLQ/FhyEca5Yk6RJyV+xmnxQjrRvS/YZL8RtBJ3IQ=;
 b=R308N/sIG2RWtgXfGci+CjzClV/G56s+0QnQYUw/Qs83BqexnURCwWg6thVMs4I1fxqG
 Q90emp1zt+6i7e2yhK+gRR6HKJz0cY6m7T09A20Hqf1CaCA+/vyrYCRZ1hdWWMfvjXQ2
 NFVAZDajlWOE0dS1dVVy+eocKcxIMCJjZ8U= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qwwhfraw3-18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Feb 2019 09:28:27 -0800
Received: from frc-hub05.TheFacebook.com (2620:10d:c021:18::175) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 27 Feb 2019 09:28:09 -0800
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 27 Feb 2019 09:28:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5dLQ/FhyEca5Yk6RJyV+xmnxQjrRvS/YZL8RtBJ3IQ=;
 b=Yzouun/RKzxGdNVv2kK5zgXU6hustPlU+B2nPjGCsU9Rqm2QurVBChl6gwMubKsJ/ydbPLzj6VsnYimRgyrF8i239yY7z8CRsxV9GOAj/KdpyFHbYdS4qqkynJeZPY7lLyoeFE0z/0HY/WEhayntNUsWSrFcZpAcGX4DJiYiigY=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1152.namprd15.prod.outlook.com (10.175.2.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Wed, 27 Feb 2019 17:28:06 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 17:28:06 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v4 perf,bpf 07/15] perf, bpf: save bpf_prog_info
 information as headers to perf.data
Thread-Topic: [PATCH v4 perf,bpf 07/15] perf, bpf: save bpf_prog_info
 information as headers to perf.data
Thread-Index: AQHUzWkth4oYVgGV7E+/y+IDXwPQeqXzo/6AgABEx4A=
Date:   Wed, 27 Feb 2019 17:28:06 +0000
Message-ID: <6D86D79B-6E72-4E42-86F8-41D1357229BF@fb.com>
References: <20190226002019.3748539-1-songliubraving@fb.com>
 <20190226002019.3748539-8-songliubraving@fb.com>
 <20190227132155.GI18893@krava>
In-Reply-To: <20190227132155.GI18893@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:180::eed9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07f22b14-bfba-47b3-7863-08d69cd8efb3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1152;
x-ms-traffictypediagnostic: MWHPR15MB1152:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1152;20:Qq+d5N2elwi7QWFyoWFgvE4DBzVTpm+FRZnkqBUO2ZB1dVbDurBGvpwxaibXujIi12a70FoTbjk/tLGyvDzZaFE22kxh1810RUFYQxIFJ6A6FY5Ug+dp9WKSimeHjito+xYgLgg35ZdVXZvzYETM1JZc76WFituYRnaBT4IstJA=
x-microsoft-antispam-prvs: <MWHPR15MB1152F82CFDFA4AAD1D404391B3740@MWHPR15MB1152.namprd15.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(39860400002)(366004)(346002)(199004)(189003)(99286004)(229853002)(305945005)(86362001)(11346002)(2616005)(83716004)(6916009)(476003)(316002)(81166006)(54906003)(7736002)(57306001)(97736004)(6506007)(81156014)(68736007)(14454004)(186003)(478600001)(53546011)(76176011)(5660300002)(36756003)(102836004)(82746002)(106356001)(71190400001)(105586002)(50226002)(46003)(6486002)(446003)(33656002)(8936002)(25786009)(256004)(14444005)(8676002)(6116002)(4326008)(53936002)(6512007)(486006)(6246003)(2906002)(71200400001)(6436002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1152;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3WZXA+TbTMz+ygSJLJPqf6tukLbaGgqtJ0Sx5KHc++ngyStLb8LkcerI7IQd45oyD+Tp5wAESmSjVIzxkDxvVFYrY9tUNql7Xe1ZiVFjr1DMCb3hQ30KzCy4POcJhjHzAf+/QrGL7J6lB+DgB/efO4/il8nz6IveuWCT/2dkagcwW4EeMmaIiwi4uiiatTfmFfKiVMUTQ0aMblHyLfbHanyNkEVtnI7LnfzXH8y1o3of/jYxvR+Nq6FV5rryLhMwqAH9CmsmySPJla6OgP0Kk2SpCd1DixzVliZ9epuk8OiKSni60RdWbf10Mnta+1qkJUW2H0qxOSWeqhPlQCMS//+uK5+mm6O2h1ug18D3U96MsYsl/MZlWjjVrPwmoHv7OA96XuCPdv4UTijwnWLBm2TAoA4e46za/6QIFrOMhX0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <67CDE2C52745AF4E98074A96CB247C98@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f22b14-bfba-47b3-7863-08d69cd8efb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 17:28:06.6638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1152
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 27, 2019, at 5:21 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Mon, Feb 25, 2019 at 04:20:11PM -0800, Song Liu wrote:
>=20
> SNIP
>=20
>> +		if (info_len > sizeof(struct bpf_prog_info)) {
>> +			pr_warning("detected invalid bpf_prog_info\n");
>> +			goto out;
>> +		}
>> +
>> +		info_linear =3D malloc(sizeof(struct bpf_prog_info_linear) +
>> +				     data_len);
>> +		if (!info_linear)
>> +			goto out;
>> +		info_linear->info_len =3D sizeof(struct bpf_prog_info);
>> +		info_linear->data_len =3D data_len;
>> +		if (do_read_u64(ff, (u64 *)(&info_linear->arrays)))
>> +			goto out;
>> +		if (__do_read(ff, &info_linear->info, info_len))
>> +			goto out;
>> +		if (info_len < sizeof(struct bpf_prog_info))
>> +			memset(((void *)(&info_linear->info)) + info_len, 0,
>> +			       sizeof(struct bpf_prog_info) - info_len);
>> +
>> +		if (__do_read(ff, info_linear->data, data_len))
>> +			goto out;
>> +
>> +		/* endian mismatch, drop the info, continue */
>=20
> so there's no way we can swap the data? why?
>=20
> jirka

Yes, we can swap the data. OTOH, the set is big enough. How about we=20
implement the swap later? Running perf-report on a system of with=20
different endianness is a relatively rare case.=20

Thanks,
Song



>> +		if (ff->ph->needs_swap) {
>> +			free(info_linear);
>> +			continue;
>> +		}
>=20
> SNIP

