Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA61ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634B520827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="hG1EmNQd";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="eJjz5C0R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634B520827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeKIDmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:42:09 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45090 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726801AbeKIDmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:42:09 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA8I3C2K030967;
        Thu, 8 Nov 2018 10:04:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=206Vi8Kt0Cp/K8cQ9FShjI0Q6fDdxS/CTXopOYxOLqc=;
 b=hG1EmNQdnhGYQ0dlYb8yKjWS7/JPV/pcz3hj9vCGfFCjMcJvpUTyURzTph9fwrJIeGam
 judySv05vRbGENvwAaQHStqihLCeeJry3KJGsLLL+TckNtAXrrs5QBpmepW8xWnOEDxa
 8hifCHCTsKkdIAJTvVzspYTkbPv6MlMeeeo= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nmqww8gf1-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 08 Nov 2018 10:04:49 -0800
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 8 Nov 2018 10:04:47 -0800
Received: from FRC-CHUB10.TheFacebook.com (2620:10d:c021:18::29) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Thu, 8 Nov 2018 10:04:47 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.30) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 8 Nov 2018 13:04:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=206Vi8Kt0Cp/K8cQ9FShjI0Q6fDdxS/CTXopOYxOLqc=;
 b=eJjz5C0RKHX+LSpkancvA6bBPyo/FPFxDdTBe+9pht7uZ9yofGdAot9XcRkW5g5DIOnzBTgEILZr9F5Ca8MEN/XR6PIrkPJnbayZiePIK20tT72Y7zBT9Sd5/GwJUEWNvFifceKhpc1R6Fa/GoCpuxBkOl3AmYzaVR4lfbImSHY=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1726.namprd15.prod.outlook.com (10.174.254.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Thu, 8 Nov 2018 18:04:45 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::4cd7:6768:136d:7a8b]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::4cd7:6768:136d:7a8b%2]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 18:04:45 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Netdev <netdev@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "acme@kernel.org" <acme@kernel.org>
Subject: Re: [RFC perf,bpf 1/5] perf, bpf: Introduce PERF_RECORD_BPF_EVENT
Thread-Topic: [RFC perf,bpf 1/5] perf, bpf: Introduce PERF_RECORD_BPF_EVENT
Thread-Index: AQHUdhLRNu0EDS9AC0KZ+9MuHYh4daVD/w6AgACjMoCAAVksAIAAM3wA
Date:   Thu, 8 Nov 2018 18:04:44 +0000
Message-ID: <C858C862-E523-4CE8-AB39-CC9B27BE2538@fb.com>
References: <20181106205246.567448-1-songliubraving@fb.com>
 <20181106205246.567448-2-songliubraving@fb.com>
 <20181107084057.GG9781@hirez.programming.kicks-ass.net>
 <31067290-4B66-4AA1-8027-607397BC0264@fb.com>
 <20181108150028.GU9761@hirez.programming.kicks-ass.net>
In-Reply-To: <20181108150028.GU9761@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.101.1)
x-originating-ip: [2620:10d:c090:200::7:4fb8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1726;20:9CMcwtsgI2JhubOdN/ffrbUY3oszjgdoNvmpFOWxiMZFdnjmeXwemjzHiU+ID1txe3vYOnjWkleeDkGmv/7gzcNRK2bOT5FjSgJOCyB+88DH5fXmP+oOiL6zkfK1AqVMdp3ypmaytx0DrGOiKm7ZH2dQWGitge8i0Uo6MavOJtk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 329fd542-917a-4fff-6268-08d645a4aa22
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1726;
x-ms-traffictypediagnostic: MWHPR15MB1726:
x-microsoft-antispam-prvs: <MWHPR15MB17262451F4C554D05B037AEFB3C50@MWHPR15MB1726.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3231382)(11241501184)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1726;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1726;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(346002)(376002)(39860400002)(189003)(199004)(86362001)(71200400001)(71190400001)(446003)(11346002)(486006)(83716004)(476003)(4326008)(25786009)(68736007)(2616005)(50226002)(8936002)(7736002)(305945005)(478600001)(229853002)(106356001)(105586002)(8676002)(2906002)(81156014)(14454004)(81166006)(76176011)(316002)(256004)(6486002)(36756003)(5660300001)(33656002)(97736004)(53546011)(102836004)(6506007)(93886005)(2900100001)(99286004)(6916009)(6116002)(6246003)(46003)(57306001)(6512007)(54906003)(6436002)(186003)(82746002)(53936002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1726;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QtEucb0GHy+E1TUwwz6kZhwXfwcwk1qNCnVJev3xyHBIXJ6xSIoSlToYhDWbconBoUtuFrX8BXpoZVVBRixOsRv2bqGOdCgdts5PyJfZJB/iV48p92MCkJswoXPz3hQH5mKq2PafNnJIsuL27aRYuqZSLkqVYHg6IdVW2L4yrmQDTrxkt1877ETJLqHM1SzAFUWHQZH+L8j6e6lwl8SVeihbqELdnToE/AAkPZKWQcFIaZHv1nyc0jpGsgWEp2/nw+B0cZ15GyCPOgQsnYtzPx313WYe85wynnnaflFhxLIx28Ws6E7QHJywOPbku+CxVI4VjpxfWNVZ5Az6IvlgbZFCLe7evtavH+jNjsdIR6M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7ED8500B60234A4285502EC3EE9CD718@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 329fd542-917a-4fff-6268-08d645a4aa22
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 18:04:44.8505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1726
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

> On Nov 8, 2018, at 7:00 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Wed, Nov 07, 2018 at 06:25:04PM +0000, Song Liu wrote:
>>=20
>>=20
>>> On Nov 7, 2018, at 12:40 AM, Peter Zijlstra <peterz@infradead.org> wrot=
e:
>>>=20
>>> On Tue, Nov 06, 2018 at 12:52:42PM -0800, Song Liu wrote:
>>>> For better performance analysis of BPF programs, this patch introduces
>>>> PERF_RECORD_BPF_EVENT, a new perf_event_type that exposes BPF program
>>>> load/unload information to user space.
>>>>=20
>>>>       /*
>>>>        * Record different types of bpf events:
>>>>        *   enum perf_bpf_event_type {
>>>>        *      PERF_BPF_EVENT_UNKNOWN          =3D 0,
>>>>        *      PERF_BPF_EVENT_PROG_LOAD        =3D 1,
>>>>        *      PERF_BPF_EVENT_PROG_UNLOAD      =3D 2,
>>>>        *   };
>>>>        *
>>>>        * struct {
>>>>        *      struct perf_event_header header;
>>>>        *      u16 type;
>>>>        *      u16 flags;
>>>>        *      u32 id;  // prog_id or map_id
>>>>        * };
>>>>        */
>>>>       PERF_RECORD_BPF_EVENT                   =3D 17,
>>>>=20
>>>> PERF_RECORD_BPF_EVENT contains minimal information about the BPF progr=
am.
>>>> Perf utility (or other user space tools) should listen to this event a=
nd
>>>> fetch more details about the event via BPF syscalls
>>>> (BPF_PROG_GET_FD_BY_ID, BPF_OBJ_GET_INFO_BY_FD, etc.).
>>>=20
>>> Why !? You're failing to explain why it cannot provide the full
>>> information there.
>>=20
>> Aha, I missed this part. I will add the following to next version. Pleas=
e
>> let me know if anything is not clear.
>=20
>>=20
>> This design decision is picked for the following reasons. First, BPF=20
>> programs could be loaded-and-jited and/or unloaded before/during/after=20
>> perf-record run. Once a BPF programs is unloaded, it is impossible to=20
>> recover details of the program. It is impossible to provide the=20
>> information through a simple key (like the build ID). Second, BPF prog
>> annotation is under fast developments. Multiple informations will be=20
>> added to bpf_prog_info in the next few releases. Including all the
>> information of a BPF program in the perf ring buffer requires frequent=20
>> changes to the perf ABI, and thus makes it very difficult to manage=20
>> compatibility of perf utility.=20
>=20
> So I don't agree with that reasoning. If you want symbol information
> you'll just have to commit to some form of ABI. That bpf_prog_info is an
> ABI too.

At the beginning of the perf-record run, perf need to query bpf_prog_info=20
of already loaded BPF programs. Therefore, we need to commit to the=20
bpf_prog_info ABI. If we also include full information of the BPF program=20
in the perf ring buffer, we will commit to TWO ABIs.=20

Also, perf-record write the event to perf.data file, so the data need to be=
=20
serialized. This is implemented in patch 4/5. To include the data in the=20
ring buffer, we will need another piece of code in the kernel to do the
same serialization work.  =20

On the other hand, processing BPF load/unload events synchronously should
not introduce too much overhead for meaningful use cases. If many BPF progs
are being loaded/unloaded within short period of time, it is not the steady
state that profiling works care about.=20

Would these resolve your concerns?=20

Thanks,
Song

