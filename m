Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AF7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBC821104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="O7HPPyDA";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="a4f/wdS0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DBC821104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731252AbeK1GEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:04:15 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53338 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729499AbeK1GEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 01:04:15 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wARIxEgK031011;
        Tue, 27 Nov 2018 11:04:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=BcnQNPLVmTg/bn7ccBQQNTvIm/dx01sjugND9B+x7jI=;
 b=O7HPPyDAy0NWBU3Vye73AFMi5NCdU6KVKonajySkzS9pG0WD/Y7FZ6OdY3JmMOVPPa2k
 4Bxt5jiJ24xQ8uorjXAMmg0loYw8y2ah0tupsiDK8abxyWiHxbVI+aD0VMrdr9RbX8LE
 V0ff6q1sBKC75/1HYsCxGBKuw/oGCHmZ4ik= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2p19gg8h73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 27 Nov 2018 11:04:39 -0800
Received: from frc-hub01.TheFacebook.com (2620:10d:c021:18::171) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 27 Nov 2018 11:04:37 -0800
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Tue, 27 Nov 2018 11:04:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcnQNPLVmTg/bn7ccBQQNTvIm/dx01sjugND9B+x7jI=;
 b=a4f/wdS02IuhN2/WHhagWqXhRYQKSGxwbxPVSHe9ehNJcIQvplevxixadMGhsIorgf6h1HQ/gDD7pZ21ErgBBtKGRVvimpkBgbCif482e8TQDLtkp4ju2nuB8XtAMTbVKpxkKEbJSIhubJ4IJqkmPsAXRAkUVy5u+J+Q2OtzSNM=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1359.namprd15.prod.outlook.com (10.173.232.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Tue, 27 Nov 2018 19:04:36 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::6d1e:3274:a367:a55c]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::6d1e:3274:a367:a55c%3]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 19:04:36 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "acme@kernel.org" <acme@kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH perf,bpf 0/5] reveal invisible bpf programs
Thread-Topic: [PATCH perf,bpf 0/5] reveal invisible bpf programs
Thread-Index: AQHUgdQ11TRJMN8CIkSD/uQZUfyfEaVbiN6AgACRn4CABhB7AIAAVs6AgAGCpIA=
Date:   Tue, 27 Nov 2018 19:04:35 +0000
Message-ID: <B1C5F28C-5359-4E03-88B6-726FA9C73BB4@fb.com>
References: <20181121195502.3259930-1-songliubraving@fb.com>
 <20181122093219.GK2131@hirez.programming.kicks-ass.net>
 <71189F83-A09F-4A03-95EC-694D37FD7675@fb.com>
 <20181126145004.GO2113@hirez.programming.kicks-ass.net>
 <83B32093-DD4B-4A64-8476-07471015D72F@fb.com>
In-Reply-To: <83B32093-DD4B-4A64-8476-07471015D72F@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.101.1)
x-originating-ip: [2620:10d:c090:200::6:8f0c]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1359;20:VBUV1qO8eOAmwrJ+LW+KXYXRWflQBkT5hHO222HGvbZTIfSdN0o6cOeCPZ0ELw5x95AC9Nbpk2X8mwJkA7QdbxgJu2Okt2WdKoMfPlO43EishiFR2gIyG5vnml3+vgY4N7Sy5PnVpisfiyTXlCoQQPC5tdq3VNIXn1oBHwkuLIc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c192e229-662b-4635-c567-08d6549b2c5f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1359;
x-ms-traffictypediagnostic: MWHPR15MB1359:
x-microsoft-antispam-prvs: <MWHPR15MB1359DA2D2461C1CEE104DF69B3D00@MWHPR15MB1359.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(93006095)(93001095)(3002001)(10201501046)(3231443)(11241501185)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1359;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1359;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(376002)(346002)(136003)(54534003)(189003)(199004)(186003)(83716004)(53546011)(71190400001)(6506007)(71200400001)(68736007)(33656002)(256004)(14444005)(6512007)(305945005)(82746002)(53936002)(7736002)(102836004)(4326008)(6246003)(14454004)(106356001)(105586002)(446003)(2616005)(6116002)(76176011)(486006)(97736004)(36756003)(46003)(5660300001)(11346002)(99286004)(476003)(57306001)(6486002)(6916009)(93886005)(6436002)(54906003)(316002)(478600001)(86362001)(229853002)(81156014)(50226002)(81166006)(8936002)(25786009)(8676002)(2906002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1359;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Kq/ksIz/HiTNgNcfMEuteeabK4uxNFLNG4ZTVMBlqVRlpGiIO9N5wzgLS1UA2dpPDvQ69li+TBBkVDv2SP5WbGNvorbfctib95/dcOCZ9AhVvKpGP2LfWMWwznCbyvDDviG4nOfoyy9pHc4anxhIsiGS8c5pfnkDS2mNM1dvp1y+SA73bPbSbjqgHmeCk1JyqlMoZ69sm4/h8l7ezwqfqJAZSV2NVTyZF6bDb+dLpEFTvrwnVDRfpXeN435DVUXX9eIkJOpLieesPc2uJysKr5Zs8i/HxqBmbUiasK9cF/7umLh5TJC0cUnRmH6aXYBXfzoQ0pqqyNlfWHbyvtE8YCNI0Tyf+sPc1iZJTDnCKy0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0ED587AAC44D02429CF982E8839F5095@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c192e229-662b-4635-c567-08d6549b2c5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 19:04:35.8923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1359
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-27_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 26, 2018, at 12:00 PM, Song Liu <songliubraving@fb.com> wrote:
>=20
>=20
>=20
>> On Nov 26, 2018, at 6:50 AM, Peter Zijlstra <peterz@infradead.org> wrote=
:
>>=20
>> On Thu, Nov 22, 2018 at 06:13:32PM +0000, Song Liu wrote:
>>> Hi Peter,
>>>=20
>>>> On Nov 22, 2018, at 1:32 AM, Peter Zijlstra <peterz@infradead.org> wro=
te:
>>>>=20
>>>> On Wed, Nov 21, 2018 at 11:54:57AM -0800, Song Liu wrote:
>>>>> Changes RFC -> PATCH v1:
>>>>>=20
>>>>> 1. In perf-record, poll vip events in a separate thread;
>>>>> 2. Add tag to bpf prog name;
>>>>> 3. Small refactorings.
>>>>>=20
>>>>> Original cover letter (with minor revisions):
>>>>>=20
>>>>> This is to follow up Alexei's early effort to show bpf programs
>>=20
>>>>> In this version, PERF_RECORD_BPF_EVENT is introduced to send real tim=
e BPF
>>>>> load/unload events to user space. In user space, perf-record is modif=
ied
>>>>> to listen to these events (through a dedicated ring buffer) and gener=
ate
>>>>> detailed information about the program (struct bpf_prog_info_event). =
Then,
>>>>> perf-report translates these events into proper symbols.
>>>>>=20
>>>>> With this set, perf-report will show bpf program as:
>>>>>=20
>>>>> 18.49%     0.16%  test  [kernel.vmlinux]    [k] ksys_write
>>>>> 18.01%     0.47%  test  [kernel.vmlinux]    [k] vfs_write
>>>>> 17.02%     0.40%  test  bpf_prog            [k] bpf_prog_07367f7ba80d=
f72b_
>>>>> 16.97%     0.10%  test  [kernel.vmlinux]    [k] __vfs_write
>>>>> 16.86%     0.12%  test  [kernel.vmlinux]    [k] comm_write
>>>>> 16.67%     0.39%  test  [kernel.vmlinux]    [k] bpf_probe_read
>>>>>=20
>>>>> Note that, the program name is still work in progress, it will be cle=
aner
>>>>> with function types in BTF.
>>>>>=20
>>>>> Please share your comments on this.
>>>>=20
>>>> So I see:
>>>>=20
>>>> kernel/bpf/core.c:void bpf_prog_kallsyms_add(struct bpf_prog *fp)
>>>>=20
>>>> which should already provide basic symbol information for extant eBPF
>>>> programs, right?
>>>=20
>>> Right, if the BPF program is still loaded when perf-report runs, symbol=
s=20
>>> are available.=20
>>=20
>> Good, that is not something that was clear. The Changelog seems to imply
>> we need this new stuff in order to observe symbols.
>=20
> I will clarify this in next version.=20
>=20
>>=20
>>>> And (AFAIK) perf uses /proc/kcore for annotate on the current running
>>>> kernel (if not, it really should, given alternatives, jump_labels and
>>>> all other other self-modifying code).
>>>>=20
>>>> So this fancy new stuff is only for the case where your profile spans
>>>> eBPF load/unload events (which should be relatively rare in the normal
>>>> case, right), or when you want source annotated asm output (I normally
>>>> don't bother with that).
>>>=20
>>> This patch set adds two pieces of information:
>>> 1. At the beginning of perf-record, save info of existing BPF programs;
>>> 2. Gather information of BPF programs load/unload during perf-record.=20
>>>=20
>>> (1) is all in user space. It is necessary to show symbols of BPF progra=
m
>>> that are unloaded _after_ perf-record. (2) needs PERF_RECORD_BPF_EVENT=
=20
>>> from the ring buffer. It covers BPF program loaded during perf-record=20
>>> (perf record -- bpf_test).=20
>>=20
>> I'm saying that if you given them symbols; most people won't need any of
>> that ever.
>>=20
>> And just tracking kallsyms is _much_ cheaper than either 1 or 2. Alexei
>> was talking fairly big amounts of data per BPF prog. Dumping and saving
>> that sounds like pointless overhead for 99% of the users.
>=20
> Due to the kernel-module-like natural of BPF program, I think it is still
> necessary to cover cases that BPF programs are unloaded when perf-record
> runs. How about we add another step that scans all bpf_prog_XXXX from
> kallsyms, and synthesizes symbols for them?
>=20
>>=20
>>>> That is; I would really like this fancy stuff to be an optional extra
>>>> that is typically not needed.
>>>>=20
>>>> Does that make sense?
>>>=20
>>> (1) above is always enabled with this set. I added option no-bpf-events=
=20
>>> to disable (2). I guess you prefer the (2) is disabled by default, and=
=20
>>> enabled with an option?
>>=20
>> I'm saying neither should be default enabled. Instead we should do
>> recording and tracking by default.
>>=20
>> That gets people symbol information on BPF stuff, which is likely all
>> they ever need.
>=20
> How about we extend PERF_RECORD_BPF_EVENT with basic symbol information
> (name, addr, length)? By default, we just record these events in the ring
> buffer, just like mmap events. This (plus scanning kallsyms before record=
)
> will enable symbols for all BPF programs.=20
>=20
> For more information, we add an option to enable more information=20
> (annotated asm, etc.), with dedicated dummy event, thread, and ring buffe=
r.=20
>=20

After syncing with Alexei offline, I realized this won't work cleanly.=20

My initial idea is to extend PERF_RECORD_BPF_EVENT like:

struct bpf_event {
        struct perf_event_header header;
        u16 type;
        u16 flags;
        u32 id;          /* bpf prog_id */

        u64 start_addr;
        u32 length;   =20
        char name[KSYM_NAME_LEN];
};

This is a structure with variable length, which is OK.=20

However, I missed the fact that each bpf program could have up to 256 sub
programs. To fit that into single bpf_event need some pretty ugly hack:

struct bpf_sub_prog {
        u64 start_addr;
        u32 length;    /* or length */
        u32 name_len;  /* length of name, struct bpf_event need it */
        char name[KSYM_NAME_LEN];
};

struct bpf_event {
        struct perf_event_header header;
        u16 type;
        u16 flags;
        u32 id;          /* bpf prog_id */
        u64 num_of_sub_prog;
       =20
	struct bpf_sub_prog sub_progs[];
};

In this case, bpf_sub_prog has variable length, thus struct bpf_event has
variable number of variable length members. This not impossible to handle
these, but it will be ugly for sure.=20

One alternative to this approach is to keep one sub program per bpf_event,=
=20
but generate multiple bpf_event (one for each sub program). Another solutio=
n
is to generate separate records (same or different PERF_RECORD_*) for=20
bpf_event and bpf_sub_prog.=20

However, I don't think any of these yield as clean perf ABI as current=20
version.=20

In summary, I can think of the following directions:

1. Current design.=20
   Pros: simple perf ABI;=20
   Cons: more work in perf tool.
2. One bpf_event per BPF prog, variable number of variable length variable.
   Pros: less work for perf tool, if annotation is not needed;=20
   Cons: ugly perf ABI.=20
3. Multiple bpf_event per BPF prog (one per sub prog).=20
   Pros: less work for perf tool, if annotation is not needed;=20
   Cons: need coordinate multiple records (same prog_id, different sub prog=
).
4. Separate bpf_event and bpf_sub_prog_event.=20
   Pros: less work for perf tool, if annotation is not needed;=20
   Cons: more complicated perf ABI (two PERF_RECORD_* or more complicated=20
         encoding for the same PERF_RECORD_).=20

Overall, I think current design is the best for simplest ABI. And it gives=
=20
flexibility to tune what information perf tool get from bpf syscalls.=20

Peter and Arnaldo, what's your recommendation on these directions (or other
better alternatives)?

Thanks,
Song

