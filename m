Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B1FC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E95214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Ddpw+jaz";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="j/bunE/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbfAHXiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 18:38:20 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58344 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727829AbfAHXiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 18:38:20 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x08NZ1Ev006881;
        Tue, 8 Jan 2019 15:37:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=UVCOLD/Px/1ovIPk3QIA+hdJuPyJeXj3X79gVeN+EVQ=;
 b=Ddpw+jaz+pa6HNQLe6vTswUpLJd8IHX4w0Ex1xA8OQlrW1a/rnQsCGGGxVA8B5BPUnvs
 KQ/CfEwskPkayn1gfO4w4JShd/sJhhzuij0s/jmlcAMAxt8jD1FnqNE33N7pKLRiG5oZ
 sa30jF6hbiH3NsqsROMrIX177wzyyVQhYs0= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pw33u0h6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 08 Jan 2019 15:37:50 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 8 Jan 2019 15:37:49 -0800
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Tue, 8 Jan 2019 15:37:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVCOLD/Px/1ovIPk3QIA+hdJuPyJeXj3X79gVeN+EVQ=;
 b=j/bunE/d0XPWDCTE/iHo8fhprcnXr2wbbwUpf6f7AS5nj9NIewd5ZKRuEyZ9BQTqPcR+fDbAEMuaVJtarasHDm9SEv6xUtBA2wXxqF/2zo4ympsmhlfvta52lZqoLfQKoUcSZicKkxN2ikOk7+XnZCOkhCDLjOvpHU3a58S+ppU=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1661.namprd15.prod.outlook.com (10.175.140.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Tue, 8 Jan 2019 23:37:44 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::78be:8c1:352b:6f6e]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::78be:8c1:352b:6f6e%6]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 23:37:44 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v5 perf, bpf-next 3/7] perf, bpf: introduce
 PERF_RECORD_BPF_EVENT
Thread-Topic: [PATCH v5 perf, bpf-next 3/7] perf, bpf: introduce
 PERF_RECORD_BPF_EVENT
Thread-Index: AQHUmJHygB8CuOaEkU2QMQ4A40UscaWl0lUAgAAIHwCAABJwgIAAOEWA
Date:   Tue, 8 Jan 2019 23:37:43 +0000
Message-ID: <4FC4ABBC-132B-4F1C-8882-66A6008FD319@fb.com>
References: <20181220182904.4193196-1-songliubraving@fb.com>
 <20181220182904.4193196-4-songliubraving@fb.com>
 <20190108184116.GC30894@hirez.programming.kicks-ass.net>
 <77A478D9-F36F-443A-BBFD-F0C1FFE0DD90@fb.com>
 <20190108201619.GG28965@kernel.org>
In-Reply-To: <20190108201619.GG28965@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::5:43fb]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1661;20:x9N0/WWIB0ERnzO0CEc8LGksgT/HDh8Wsb3lRSA1A9YcgE0pVpbVrRE2g/8oIghU/C969B0+gD4FvEdtm044TEAEcAZ87LzJljk8vqWj1SMHfV7gy2+4qjkarxXJfvhVzUF1zKS2itaG3WFNJWjgvJIxRhUmwuAt6ByFZDClDA8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2e650fc2-3cbf-464d-6fff-08d675c249ba
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1661;
x-ms-traffictypediagnostic: MWHPR15MB1661:
x-microsoft-antispam-prvs: <MWHPR15MB16614A7A9BC591E9C6E48912B38A0@MWHPR15MB1661.namprd15.prod.outlook.com>
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(136003)(39860400002)(199004)(189003)(102836004)(82746002)(76176011)(476003)(6506007)(93886005)(33656002)(2616005)(86362001)(53546011)(186003)(8936002)(14444005)(256004)(25786009)(4326008)(71200400001)(71190400001)(83716004)(99286004)(81156014)(8676002)(305945005)(50226002)(81166006)(7736002)(57306001)(6246003)(2906002)(229853002)(486006)(54906003)(6512007)(36756003)(6486002)(6916009)(53936002)(316002)(5660300001)(46003)(6436002)(11346002)(446003)(6116002)(106356001)(478600001)(97736004)(105586002)(68736007)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1661;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6pk85l7L/WaZZSwXSUOxc9Lk9fMaG1C0GHjTeWrk7kz1MLpDdytY3KpZZqHUE96/+Yls8Ehi6JqUh3yziDBGf1wSg6HCnDPK95eCQHeXHoe4KFgAPgKnp4hlbYTrzcooTRe799j2fWuHru4QS6jflojv2RdNXPCLjFMqsPjpYpxVAzgvwI8SIqOGQwFvVwK6+mATpg9qFtj5fZmBOVYjWF8f7tWYfOL5ZkSRadFEWLWDtdoyFBjG4WV5MLUPNpCNRPwrymGRp5Cb7w0OwrFdPoVcRbm7rjxSqhaMGveYjI7+fenwbqJpoA7+Ooxbl+yB
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EA39EDA2C62ED548B013308905860DDA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e650fc2-3cbf-464d-6fff-08d675c249ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 23:37:43.7982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1661
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-08_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 8, 2019, at 12:16 PM, Arnaldo Carvalho de Melo <acme@kernel.org> w=
rote:
>=20
> Em Tue, Jan 08, 2019 at 07:10:20PM +0000, Song Liu escreveu:
>>> On Jan 8, 2019, at 10:41 AM, Peter Zijlstra <peterz@infradead.org> wrot=
e:
>>> On Thu, Dec 20, 2018 at 10:29:00AM -0800, Song Liu wrote:
>>>> @@ -986,9 +987,35 @@ enum perf_event_type {
>>>> 	 */
>>>> 	PERF_RECORD_KSYMBOL			=3D 17,
>>>>=20
>>>> +	/*
>>>> +	 * Record bpf events:
>>>> +	 *  enum perf_bpf_event_type {
>>>> +	 *	PERF_BPF_EVENT_UNKNOWN		=3D 0,
>>>> +	 *	PERF_BPF_EVENT_PROG_LOAD	=3D 1,
>>>> +	 *	PERF_BPF_EVENT_PROG_UNLOAD	=3D 2,
>>>> +	 *  };
>>>> +	 *
>>>> +	 * struct {
>>>> +	 *	struct perf_event_header	header;
>>>> +	 *	u16				type;
>>>> +	 *	u16				flags;
>>>> +	 *	u32				id;
>>>> +	 *	u8				tag[BPF_TAG_SIZE];
>>>> +	 *	struct sample_id		sample_id;
>>>> +	 * };
>>>> +	 */
>>>> +	PERF_RECORD_BPF_EVENT			=3D 18,
>=20
>>> It was suggested to allow pinning modules/programs to avoid this
>>> situation, but that of course has other undesirable effects, such as a
>>> trivial DoS.
>>>=20
>>> A truly horrible hack would be to include an open filedesc in the event
>>> that needs closing to release the resource, but I'm sorry for even
>>> suggesting that **shudder**.
>>>=20
>>> Do we have any sane ideas?
>>=20
>> How about we gate the open filedesc solution with an option, and limit
>> that option for root only? If this still sounds hacky, maybe we should
>> just ignore when short-living programs are missed?
>=20
> Short lived short programs could go in the event? Short lived long
> events.. One could ask for max number of bytes of binary?
>=20
> The smallest kernel modules are 16KB, multiple of PAGE_SIZE:
>=20
> [acme@quaco perf]$ cat /proc/modules | sort -k2 -nr | tail
> ebtable_nat 16384 1 - Live 0x0000000000000000
> ebtable_filter 16384 1 - Live 0x0000000000000000
> crct10dif_pclmul 16384 0 - Live 0x0000000000000000
> crc32_pclmul 16384 0 - Live 0x0000000000000000
> coretemp 16384 0 - Live 0x0000000000000000
> btrtl 16384 1 btusb, Live 0x0000000000000000
> btbcm 16384 1 btusb, Live 0x0000000000000000
> arc4 16384 2 - Live 0x0000000000000000
> acpi_thermal_rel 16384 1 int3400_thermal, Live 0x0000000000000000
> ac97_bus 16384 1 snd_soc_core, Live 0x0000000000000000
> [acme@quaco perf]$
>=20
> On a Fedora 29 I have these here, all rather small:
>=20
> # bpftool prog
> 13: cgroup_skb  tag 7be49e3934a125ba  gpl
> 	loaded_at 2019-01-04T14:40:32-0300  uid 0
> 	xlated 296B  jited 229B  memlock 4096B  map_ids 13,14
> 14: cgroup_skb  tag 2a142ef67aaad174  gpl
> 	loaded_at 2019-01-04T14:40:32-0300  uid 0
> 	xlated 296B  jited 229B  memlock 4096B  map_ids 13,14
> 15: cgroup_skb  tag 7be49e3934a125ba  gpl
> 	loaded_at 2019-01-04T14:40:32-0300  uid 0
> 	xlated 296B  jited 229B  memlock 4096B  map_ids 15,16
> 16: cgroup_skb  tag 2a142ef67aaad174  gpl
> 	loaded_at 2019-01-04T14:40:32-0300  uid 0
> 	xlated 296B  jited 229B  memlock 4096B  map_ids 15,16
> 17: cgroup_skb  tag 7be49e3934a125ba  gpl
> 	loaded_at 2019-01-04T14:40:43-0300  uid 0
> 	xlated 296B  jited 229B  memlock 4096B  map_ids 17,18
> 18: cgroup_skb  tag 2a142ef67aaad174  gpl
> 	loaded_at 2019-01-04T14:40:43-0300  uid 0
> 	xlated 296B  jited 229B  memlock 4096B  map_ids 17,18
> 21: cgroup_skb  tag 7be49e3934a125ba  gpl
> 	loaded_at 2019-01-04T14:40:43-0300  uid 0
> 	xlated 296B  jited 229B  memlock 4096B  map_ids 21,22
> 22: cgroup_skb  tag 2a142ef67aaad174  gpl
> 	loaded_at 2019-01-04T14:40:43-0300  uid 0
> 	xlated 296B  jited 229B  memlock 4096B  map_ids 21,22
> [root@quaco IRPF2018]#
>=20
>=20
> Running 'perf trace' with its BPF augmenter get these two more:
>=20
> 158: tracepoint  name sys_enter  tag 12504ba9402f952f  gpl
> 	loaded_at 2019-01-08T17:12:39-0300  uid 0
> 	xlated 512B  jited 374B  memlock 4096B  map_ids 118,117,116
> 159: tracepoint  name sys_exit  tag c1bd85c092d6e4aa  gpl
> 	loaded_at 2019-01-08T17:12:39-0300  uid 0
> 	xlated 256B  jited 191B  memlock 4096B  map_ids 118,117
> [root@quaco ~]#
>=20
> A PERF_RECORD_MMAP gets as its payload up to PATH_MAX - sizeof(u64).
>=20
> So for a class of programs, shoving it together with the
> PERF_RECORD_MMAP like event may be enough?
>=20
> You started the shuddering suggestions... ;-)
>=20
> - Arnaldo

Besides the cited binary, we are adding more information for each=20
BPF program, including source code. So even short program could=20
easily exceed PATH_MAX...

Song

