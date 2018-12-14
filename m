Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BEAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292FF206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ieRmnfNM";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="U0zqyjfx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbeLNRNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:13:00 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60256 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729508AbeLNRM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:12:59 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBEH8OLe005628;
        Fri, 14 Dec 2018 09:12:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=5fST0ww/73BrG5y1RoxM1gjiv8RdC75VimRY7n5hTwA=;
 b=ieRmnfNMk619uGlKnmZvRSC6mvv3e8OkJPJAswFlKk1uAPjd6lus2SYT7D2OyeySOt1o
 7idxvEx/06TgVs7goJthLQbh36M5+iaOmwCB0VigkyxmuXdm662Mbnc/S2c7fCzDmkQS
 qgFbongoqixo4KfZpu26PREJE/JflSjBqK0= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pcfgq08ms-18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 14 Dec 2018 09:12:12 -0800
Received: from frc-mbx06.TheFacebook.com (2620:10d:c0a1:f82::30) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 14 Dec 2018 09:10:59 -0800
Received: from frc-hub05.TheFacebook.com (2620:10d:c021:18::175) by
 frc-mbx06.TheFacebook.com (2620:10d:c0a1:f82::30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 14 Dec 2018 09:10:58 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Fri, 14 Dec 2018 09:10:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fST0ww/73BrG5y1RoxM1gjiv8RdC75VimRY7n5hTwA=;
 b=U0zqyjfx89M6a35rJlfXtFL+uj5loz5cuuOAyHP/Gk0Evb7qcyzHpYK2z6lRak98/7IeXa35zDZX0TyOb5TbshswyoTE+XRZW0uMNvtzvcP3tw2+8LXFkM/0oMx2BryM4yhCggGMy3LbXYr7NkWc1jlqjHWMqlIT7MAgcosrZNo=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1773.namprd15.prod.outlook.com (10.174.255.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Fri, 14 Dec 2018 17:10:56 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::78be:8c1:352b:6f6e]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::78be:8c1:352b:6f6e%5]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 17:10:56 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 perf, bpf-next 1/4] perf, bpf: Introduce
 PERF_RECORD_BPF_EVENT
Thread-Topic: [PATCH v3 perf, bpf-next 1/4] perf, bpf: Introduce
 PERF_RECORD_BPF_EVENT
Thread-Index: AQHUkan/BrxKv3p0HEGwaC6e4kWgY6V7FkWAgABBOQCAAA/SgIAAB6sAgAGVzgCAADMvgIABDDiAgAA4boA=
Date:   Fri, 14 Dec 2018 17:10:56 +0000
Message-ID: <B58B3944-0A30-4A25-923E-C7E1FF6AC4DE@fb.com>
References: <20181211233351.4036381-1-songliubraving@fb.com>
 <20181211233351.4036381-2-songliubraving@fb.com>
 <20181212131549.GZ5289@hirez.programming.kicks-ass.net>
 <C6E2C200-4C86-4EE0-97FA-228C0E0629B1@fb.com>
 <20181212180553.GC5289@hirez.programming.kicks-ass.net>
 <20181212133320.75d5cad8@gandalf.local.home>
 <20181213184546.GM5289@hirez.programming.kicks-ass.net>
 <3FC2A5A4-9502-4B33-A944-BEB14B520E23@fb.com>
 <20181214134857.GR21027@kernel.org>
In-Reply-To: <20181214134857.GR21027@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::4:5631]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1773;20:9BCK9geYc/YdjxSI0KS9smHlixGi+0P2fQxc3xEMvEksq/eW1gWEw9AYCmRKdQTZEkc7W0g9XObkzOgbP+xuAoVV8aN4mjm6IYxQaE0upbSZVGDda4smOltxZyqsfn1KVTEQOpLK9aUgto+lIO6EKeZ9gDJwVMc5b4+AgRjS9tw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8d30203a-db4e-40ed-5e8a-08d661e71c89
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1773;
x-ms-traffictypediagnostic: MWHPR15MB1773:
x-microsoft-antispam-prvs: <MWHPR15MB177342A12D59867B8C2D6CA9B3A10@MWHPR15MB1773.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(11241501185)(6040522)(2401047)(5005006)(8121501046)(823302103)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1773;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1773;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(39860400002)(396003)(346002)(366004)(199004)(189003)(53936002)(14454004)(486006)(316002)(6512007)(106356001)(105586002)(93886005)(36756003)(71190400001)(476003)(71200400001)(4326008)(2616005)(86362001)(11346002)(446003)(6916009)(7736002)(229853002)(57306001)(561944003)(46003)(6436002)(478600001)(8676002)(6486002)(33656002)(25786009)(5660300001)(68736007)(8936002)(76176011)(99286004)(305945005)(50226002)(256004)(54906003)(6246003)(186003)(82746002)(14444005)(97736004)(53546011)(6506007)(2906002)(81156014)(81166006)(102836004)(6116002)(83716004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1773;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lq7ZHR5Y73gwtUtKrWgqV54KvcjpKZVDhUNGF3ai6QBNATIda34sRnKWHqSHZSdshSQ2J5e/sJxFekkUk+AwwnKLwGOIac0et083r/efMxFCr9cM2ILAX5g9h6zgCyx5V0szQuoJk9mA2DCmZvcDO3D4u9n+ksdRNlPHzqK+Iz4qU4swL87U0LAMA+OytoMp4wTI4uMoFmP+A9pTcf7CIl9CWqG1a0XuxQtwWEtfdPOBg71N+QH/pO33ezYNJ3FsJDWZAmJ87UtkegEOn7SPmF9KkyKSLXx45pTmEE4cFot+Fce054nHLXCLqa11NPFY
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5ABAAF8150F0DA47BAF359D4716AD767@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d30203a-db4e-40ed-5e8a-08d661e71c89
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 17:10:56.2358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1773
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-14_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 14, 2018, at 5:48 AM, Arnaldo Carvalho de Melo <acme@kernel.org> w=
rote:
>=20
> Em Thu, Dec 13, 2018 at 09:48:57PM +0000, Song Liu escreveu:
>>=20
>>=20
>>> On Dec 13, 2018, at 10:45 AM, Peter Zijlstra <peterz@infradead.org> wro=
te:
>>>=20
>>> On Wed, Dec 12, 2018 at 01:33:20PM -0500, Steven Rostedt wrote:
>>>> On Wed, 12 Dec 2018 19:05:53 +0100
>>>> Peter Zijlstra <peterz@infradead.org> wrote:
>>>>=20
>>>>> On Wed, Dec 12, 2018 at 05:09:17PM +0000, Song Liu wrote:
>>>>>>> And while this tracks the bpf kallsyms, it does not do all kallsyms=
.
>>>>>>>=20
>>>>>>> .... Oooh, I see the problem, everybody is doing their own custom
>>>>>>> kallsym_{add,del}() thing, instead of having that in generic code :=
-(
>>>>>>>=20
>>>>>>> This, for example, doesn't track module load/unload nor ftrace
>>>>>>> trampolines, even though both affect kallsyms. =20
>>>>>>=20
>>>>>> I think we can use PERF_RECORD_MMAP(or MMAP2) for module load/unload=
.=20
>>>>>> That could be separate sets of patches.  =20
>>>>>=20
>>>>> So I would actually like to move bpf_lock/bpf_kallsyms/bpf_tree +
>>>>> bpf_prog_kallsyms_*() + __bpf_address_lookup() into kernel/kallsyms.c
>>>>> and also have ftrace use that.
>>>>>=20
>>>>> Because currently the ftrace stuff is otherwise invisible.
>>>>>=20
>>>>> A generic kallsym register/unregister for any JIT.
>>>>=20
>>>> That's if it needs to look up the symbols that were recorded when init
>>>> was unloaded.
>>>>=20
>>>> The ftrace kallsyms is used to save the function names of init code
>>>> that was freed, but may have been recorded. With out the ftrace
>>>> kallsyms the functions traced at init time would just show up as hex
>>>> addresses (not very useful).
>>>>=20
>>>> I'm not sure how BPF would need those symbols unless they were execute=
d
>>>> during init (module or core) and needed to see what the symbols use to
>>>> be).
>>>=20
>>> Aah, that sounds entirely dodgy and possibly quite broken. We freed tha=
t
>>> init code, so BPF or your trampolines (or a tiny module) could actually
>>> fit in there and insert their own kallsyms, and then we have overlappin=
g
>>> symbols, which would be pretty bad.
>>>=20
>>> I thought the ftrace kallsym stuff was for the trampolines, which would
>>> be fairly similar to what BPF is doing. And why I'm trying to get a
>>> generic dynamic kallsym thing sorted. There's bound the be other
>>> code-gen things at some point.
>>=20
>> Hi Peter,=20
>>=20
>> I guess you are looking for something for all ksym add/delete events, li=
ke;
>>=20
>>      /*
>>       * PERF_RECORD_KSYMBOL
>>       *
>>       * struct {
>>       *      struct perf_event_header header;
>>       *      u64                             addr;
>>       *      u32                             len;
>>       *      u16                             ksym_type;
>>       *      u16                             flags;
>>       *      char                            name[];
>>       *      struct sample_id                sample_id;
>>       * };
>>       */
>=20
> Can't this reuse PERF_RECORD_MMAP2 with some bit in the header to mean
> that the name is the symbol name, not a path to some ELF/whatever? The
> ksym type could be encoded in the prot field, PROT_EXEC for functions,
> PROT_READ for read only data, PROT_WRITE for rw data.

Thanks Arnaldo!

I think this works. PERF_RECORD_MMAP2 has many bits in it. We can encode
a lot of details. We can even have bit to differentiate map/unmap.=20

>=20
> If we do it that way older tools will show the DSO name and an
> unresolved symbol, and even an indication if its a function or data,
> which is better than not showing anything when processing a new
> PERF_RECORD_KSYMBOL.

For compatibility, we can use attr.bpf_event bit (or attr.mmap2_plus)
to turn on/off new variations of PERF_RECORD_MMAP2. Unless user runs
perf-record and perf-report with different versions of perf tools, we=20
should not see weird events.=20

>=20
> New tools, seeing the perf_event_attr.header bit will know that this is
> a "map" with just one symbol and will show that for both DSO name and
> symbol.
>=20

Hi Peter,=20

Could you please share your comments/suggestions on Arnaldo's proposal?

Thanks,
Song



