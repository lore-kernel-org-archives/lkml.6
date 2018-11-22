Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86E7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CB220838
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bC5Washy";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Kbc0GqW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65CB220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406562AbeKWEyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:54:50 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54300 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387638AbeKWEyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 23:54:49 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAMIDMGF022585;
        Thu, 22 Nov 2018 10:13:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=a/XOx2Q1lImNqPNXxLJ1L0VnOs6B9X/p/GAl3n0qs2c=;
 b=bC5Washy1cLwjRz2fmU7EVUzshiFI1ujEz67d0LG0eX58ikbHS52cv7WqWAgWRdDk2Mx
 m3RFPIuJLK1sXyG5psoufrfJHTc+4/uHHwdpW0PeK0/YORj5LAbdeXyH1iaYACKUH7VX
 eEIjPrtuml6qV/noMFt9667tI/x4d5i6tik= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nwwvygmay-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 22 Nov 2018 10:13:36 -0800
Received: from frc-hub01.TheFacebook.com (2620:10d:c021:18::171) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 22 Nov 2018 10:13:34 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 22 Nov 2018 10:13:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/XOx2Q1lImNqPNXxLJ1L0VnOs6B9X/p/GAl3n0qs2c=;
 b=Kbc0GqW7yDRqGsNjwJpaubN1apvutCD1W/MBj+Jgg1nFpraTSYc/DQLFfzhXf6wU2XVAd9q48q0ntIFy8WbkAMB5Wt8aKodRXAUnjZx2qMvybu1bm2/WuRCdl5zWddlnMi2ljT5znAc+KbrpdXOW6tmoaKRPN651ceWTVnhcvZI=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1808.namprd15.prod.outlook.com (10.174.255.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Thu, 22 Nov 2018 18:13:32 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::6d1e:3274:a367:a55c]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::6d1e:3274:a367:a55c%3]) with mapi id 15.20.1361.016; Thu, 22 Nov 2018
 18:13:32 +0000
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
Thread-Index: AQHUgdQ11TRJMN8CIkSD/uQZUfyfEaVbiN6AgACRn4A=
Date:   Thu, 22 Nov 2018 18:13:32 +0000
Message-ID: <71189F83-A09F-4A03-95EC-694D37FD7675@fb.com>
References: <20181121195502.3259930-1-songliubraving@fb.com>
 <20181122093219.GK2131@hirez.programming.kicks-ass.net>
In-Reply-To: <20181122093219.GK2131@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.101.1)
x-originating-ip: [2620:10d:c090:180::1:34c]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1808;20:LBW5hSoOjirrpIA9RCuuElrwi9AwPGcbA22dbV0HJbWCvMms/Vsz57NYMqzY3NLgA1k7MBxHSJQO+/knomRaR9EeVG1uB3Oyr5rFiFjs/Bj7MRwFzBKFhXZ+DGvBZ/Zv8ya+mBJRm8Wu3rCsjOVMwdl5h1a6eS1a20KKx9asktI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4babe233-166e-4a31-16b4-08d650a6364d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1808;
x-ms-traffictypediagnostic: MWHPR15MB1808:
x-microsoft-antispam-prvs: <MWHPR15MB1808864CD6FCA1023F9B1A85B3DB0@MWHPR15MB1808.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(10201501046)(3002001)(93006095)(93001095)(3231442)(11241501184)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1808;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1808;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(136003)(189003)(199004)(102836004)(106356001)(105586002)(54906003)(4326008)(71190400001)(71200400001)(76176011)(14454004)(316002)(97736004)(53936002)(53546011)(6506007)(575784001)(6306002)(6512007)(86362001)(99286004)(186003)(14444005)(6246003)(83716004)(256004)(2906002)(305945005)(7736002)(25786009)(33656002)(8676002)(46003)(81156014)(81166006)(478600001)(966005)(6116002)(2616005)(476003)(8936002)(36756003)(50226002)(6486002)(68736007)(6436002)(82746002)(486006)(6916009)(57306001)(229853002)(446003)(11346002)(2900100001)(5660300001)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1808;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4isjpR/MQjRofsa44RHAg2/YJNw8075wSi7GzIZaC3zsGLCOb/8XX63H7NgQcyDdCik45NYK3VPR9tCbswIu4zamQMbLqTnzLZ7VMQaE7oBvd6LyX6N5hoQ0r6JHpg2i+CYNfOTdrt+8OAiqcy5kuOzxjlhF2C192GrMDd+zKDn8QgOWuewfStEmMrvtD80JIiRFUgubucqY9lWhClYkjH+eGuXpkt7fmtT1TUWYcJXvywqcDtNcXVhxYYGQBRUPP0FoyEkBd2Zq9aPBvAcQMtqskxBNC1fZfVh2wUk+/YSXDAI9I6VIXmrftOtpRHLhXn5ac13XyyjoOKYpdqMCoFZJIEV9vAcd50I2CLO/H88=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E56FF10F8D5FA041BE2CE94C3CE091BF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4babe233-166e-4a31-16b4-08d650a6364d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 18:13:32.3443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1808
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-22_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

> On Nov 22, 2018, at 1:32 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Wed, Nov 21, 2018 at 11:54:57AM -0800, Song Liu wrote:
>> Changes RFC -> PATCH v1:
>>=20
>> 1. In perf-record, poll vip events in a separate thread;
>> 2. Add tag to bpf prog name;
>> 3. Small refactorings.
>>=20
>> Original cover letter (with minor revisions):
>>=20
>> This is to follow up Alexei's early effort to show bpf programs
>>=20
>>   https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__www.spinics.net=
_lists_netdev_msg524232.html&d=3DDwIBAg&c=3D5VD0RTtNlTh3ycd41b3MUw&r=3DdR86=
92q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg&m=3D3--n8O2EZfFY2WyGCKt0u4zd73778zD=
7xmoNHi9tMCU&s=3D3DY93pysLN-m1tgYmd7YAyQGNSq6KpYKucIJcB3nofc&e=3D
>>=20
>> In this version, PERF_RECORD_BPF_EVENT is introduced to send real time B=
PF
>> load/unload events to user space. In user space, perf-record is modified
>> to listen to these events (through a dedicated ring buffer) and generate
>> detailed information about the program (struct bpf_prog_info_event). The=
n,
>> perf-report translates these events into proper symbols.
>>=20
>> With this set, perf-report will show bpf program as:
>>=20
>>   18.49%     0.16%  test  [kernel.vmlinux]    [k] ksys_write
>>   18.01%     0.47%  test  [kernel.vmlinux]    [k] vfs_write
>>   17.02%     0.40%  test  bpf_prog            [k] bpf_prog_07367f7ba80df=
72b_
>>   16.97%     0.10%  test  [kernel.vmlinux]    [k] __vfs_write
>>   16.86%     0.12%  test  [kernel.vmlinux]    [k] comm_write
>>   16.67%     0.39%  test  [kernel.vmlinux]    [k] bpf_probe_read
>>=20
>> Note that, the program name is still work in progress, it will be cleane=
r
>> with function types in BTF.
>>=20
>> Please share your comments on this.
>=20
> So I see:
>=20
>  kernel/bpf/core.c:void bpf_prog_kallsyms_add(struct bpf_prog *fp)
>=20
> which should already provide basic symbol information for extant eBPF
> programs, right?

Right, if the BPF program is still loaded when perf-report runs, symbols=20
are available.=20

> And (AFAIK) perf uses /proc/kcore for annotate on the current running
> kernel (if not, it really should, given alternatives, jump_labels and
> all other other self-modifying code).
>=20
> So this fancy new stuff is only for the case where your profile spans
> eBPF load/unload events (which should be relatively rare in the normal
> case, right), or when you want source annotated asm output (I normally
> don't bother with that).

This patch set adds two pieces of information:
1. At the beginning of perf-record, save info of existing BPF programs;
2. Gather information of BPF programs load/unload during perf-record.=20

(1) is all in user space. It is necessary to show symbols of BPF program
that are unloaded _after_ perf-record. (2) needs PERF_RECORD_BPF_EVENT=20
from the ring buffer. It covers BPF program loaded during perf-record=20
(perf record -- bpf_test).=20


> That is; I would really like this fancy stuff to be an optional extra
> that is typically not needed.
>=20
> Does that make sense?

(1) above is always enabled with this set. I added option no-bpf-events=20
to disable (2). I guess you prefer the (2) is disabled by default, and=20
enabled with an option?

Thanks,
Song
=20


