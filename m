Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55798C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135D42243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bOY6aza3";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="XWv/w9NP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135D42243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733160AbeKODKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 22:10:36 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:64931 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725759AbeKODKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 22:10:36 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.22/8.16.0.22) with SMTP id wAEH4c02017710;
        Wed, 14 Nov 2018 09:06:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=SBHOXh5Ab4jAaZVCCtf4yqFFqUucT5F2vw11c/BFXcc=;
 b=bOY6aza3IW2XZZ+5QhcSHnVpX3In/6buEZNPs+ftP1GUcF+Heoq3+QhFxkGqZEEPuWPK
 0DmEWhNsFnK0wGOykW4fIIV5jVbiA2qwNn+MK0+a04tUUTji+xZf5dSwNqRdcFOqbr6j
 U5CIR194LoLr8il9YEqtXBSpny/qCKJXcck= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2nrn9hgj4c-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 14 Nov 2018 09:06:28 -0800
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 14 Nov 2018 09:06:26 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 14 Nov 2018 09:06:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBHOXh5Ab4jAaZVCCtf4yqFFqUucT5F2vw11c/BFXcc=;
 b=XWv/w9NPskVK+M0xuq/MuNhFq2osDCY22XWdRUmWzxPI2+J/9gTdo+NP1Vnrd25KprnSqceeEQrBzYr/QcmEf0h00Bhwuh6vv+L4F7vNnlRdGW/Rk8IHwOtVqUjC2fL4A5jRivgZnHV7mw9OC3VFcSJDtMjHuE+APSg7eJhvQAg=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0888.namprd15.prod.outlook.com (10.164.171.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.20; Wed, 14 Nov 2018 17:06:06 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14%2]) with mapi id 15.20.1294.045; Wed, 14 Nov 2018
 17:06:06 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v2 3/6] cgroup: cgroup v2 freezer
Thread-Topic: [PATCH v2 3/6] cgroup: cgroup v2 freezer
Thread-Index: AQHUetwXxFde3wHnZUKDpNhUsGNNTqVN2ueA///hhYCAAcPYAIAAAqeA
Date:   Wed, 14 Nov 2018 17:06:06 +0000
Message-ID: <20181114170558.GA24889@castle.DHCP.thefacebook.com>
References: <20181112230422.5911-1-guro@fb.com>
 <20181112230422.5911-5-guro@fb.com> <20181113154825.GC30990@redhat.com>
 <20181113215919.GC15590@tower.DHCP.thefacebook.com>
 <20181114165631.GE13885@redhat.com>
In-Reply-To: <20181114165631.GE13885@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1701CA0018.namprd17.prod.outlook.com
 (2603:10b6:301:14::28) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:6f7f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0888;20:oFPrkhAkgiwzVEZMsdbbGdQgI62IHZ0QrjLy9GHioey4O7lpJoYzbDFouP6yGnixQHISCC7JP94dPp33FRetPTtiatBNtwXCVhBiy7nmOUalE7y9JKuOZRfg0algEWGCG8qiVpoK8oSEmMCmUgLe4FSoYHPQDlQX+WxyI3EazR8=
x-ms-office365-filtering-correlation-id: 10ff33b8-cabb-4d8b-a458-08d64a5376ee
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0888;
x-ms-traffictypediagnostic: BY2PR15MB0888:
x-microsoft-antispam-prvs: <BY2PR15MB0888E2639B4DC87FD7C0D5BCBEC30@BY2PR15MB0888.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3002001)(3231412)(11241501184)(944501410)(52105112)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0888;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0888;
x-forefront-prvs: 085634EFF4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(346002)(39860400002)(366004)(199004)(189003)(52314003)(575784001)(71200400001)(71190400001)(86362001)(7736002)(2900100001)(6246003)(76176011)(81156014)(81166006)(8676002)(99286004)(52116002)(2906002)(8936002)(39060400002)(6116002)(1076002)(229853002)(25786009)(5024004)(14444005)(68736007)(6916009)(256004)(186003)(102836004)(97736004)(93886005)(54906003)(5660300001)(316002)(6436002)(476003)(386003)(6506007)(33896004)(305945005)(478600001)(9686003)(53936002)(486006)(11346002)(6512007)(446003)(105586002)(14454004)(6486002)(106356001)(33656002)(4326008)(46003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0888;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Oy0UOJltTX3uHRp0Pwj4Kv5WXCSXAOLerj2NpeBKPKi5DIE31Aqnbn4SqPpfH4qQ7KKbxsaJLUCwnIMNcHr8JoNWDpkWl8Ac3Fgnw6JKU8HYax5/cFiXHqS1NhT0hqcdWKWPy7TB3ixgRDTIGsXWWDTjKOz/Hc9mLqlmAo5TIO4VZGaFUfqUAdb7iwIt6vr28bNVkb2PgqY/VDtQwfGJlsRPKfaJMYU9Fc2a9+d1Fs1u7Qav2ve2lwHYcBscMTAOAkSKbxnZuTKXnAmgdngIh42g6OVl/OPWe5XcI1qeYjGUM8jvmU9tRbVZDqt/6sve1auelbc1BgPX2/lY3IaYRlqRLWEpRC5ZDeeUG/nQ5PA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2E7132A9E2449141A195A12CE298CFE0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ff33b8-cabb-4d8b-a458-08d64a5376ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2018 17:06:06.3120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0888
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-14_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 05:56:32PM +0100, Oleg Nesterov wrote:
> Hi Roman,
>=20
> On 11/13, Roman Gushchin wrote:
> >
> > > > +#define TASK_FROZEN			0x1000
> > > > +#define TASK_STATE_MAX			0x2000
> > >
> > > Just noticed the new task state... Why? Can't we avoid it?
> >
> > We can, but it's nice to show to userspace that tasks are frozen,
> > rather than just stuck somewhere in the kernel...
>=20
> But then you need to change get_task_state() too. Which iiuc could
> probably check ->frozen along with ->state.
>=20
> I do not think the new task state is a good idea, at least I would like
> to ask you to make a separate patch which we can discuss separately.

Yeah, I have separated it in v3.

>=20
>=20
> > > > +	set_current_state(TASK_WAKEKILL | TASK_INTERRUPTIBLE | TASK_FROZE=
N);
> > >
> > > Why not __set_current_state() ?
> >
> > Hm, it's not a hot path at all, so set_current_state() is good enough.
> > Not a strong preference, of course.
>=20
> It is not about performance, to me set_current_state() looks as if we nee=
d
> a memory barrier for some obscure/undocumented reason and this doesn't he=
lp
> to understand the code.
>=20
> > > If ->state include TASK_INTERRUPTIBLE, why do we need TASK_WAKEKILL?
> > >
> > > And again, why TASK_FROZEN?
> >
> > So, should it be just TASK_INTERRUPTIBLE | TASK_FROZEN ?
>=20
> Again, TASK_FROZEN is pointless at least until you change fs/proc or unti=
l
> you have wake_up_state(TASK_FROZEN). May be cgroup_do_freeze() and/or
> ptrace_attach() could use it, but see above, I'd suggest to make another
> patch.
>=20
> Looks like you need TASK_KILLABLE, see below.
>=20
> > > > +	clear_thread_flag(TIF_SIGPENDING);
> > > > +	schedule();
> > > > +	recalc_sigpending();
> > >
> > > I simply can't understand these 3 lines above but I bet this is not c=
orrect ;)
> >
> > So, yeah, the problem is that if there is TIF_SIGPENDING bit set, sched=
ule()
> > will return immediately, so we're getting pretty much a busy loop here.
>=20
> I suspected this answer ;)
>=20
> > This is a nasty workaround.
>=20
> No, this is very wrong. Just suppose the caller is killed right before
> clear_thread_flag(TIF_SIGPENDING).

So, I had TASK_KILLABLE before, but had some issues with ptrace/gdb.
I'll revisit this option.

>=20
> > I believe we can clear and not call recalc_sigpending() at all. Does th=
is seem
> > to be correct?
>=20
> I think you need to simply remove both clear_thread_flag() and recalc_sig=
pending().
> If schedule() is called in TASK_KILLABLE state it will return only if
> fatal_signal_pending() is true, and this is what we want, right?
>=20
> OK, it seems you are going to make the new version anyway, so I can wait =
for it
> and not read this series ;)

Sure! I'm about to post it.

Thanks!
