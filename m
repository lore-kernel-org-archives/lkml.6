Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED5DC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A41420850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="VoT7Y/J+";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="hqy3wa11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A41420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbeLDAL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:11:28 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35042 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725903AbeLDAL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 19:11:28 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB404UCO009420;
        Mon, 3 Dec 2018 16:11:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=U3JjbP/W/sU665MEzYUwF/I0/Jtnm8EbcXnYYbGHVWE=;
 b=VoT7Y/J+TEZoF1P/Ep3X/ceknIYm+xRV2k8d5htltf8v8z2/7+oqTcwTcOF5NO1WEdgU
 JpSFr5PjkG/bMgfHn100OHe7OBJWwSFM7KTzowvm5MGK2Qg61E+YzqG8nXg4GHj5MgyY
 Eoz54+8Pp8nL4jDbaXfiDtPoRh1o0w2QHq0= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2p5cmr0dv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 03 Dec 2018 16:11:17 -0800
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 3 Dec 2018 16:11:15 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 3 Dec 2018 16:11:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3JjbP/W/sU665MEzYUwF/I0/Jtnm8EbcXnYYbGHVWE=;
 b=hqy3wa11mMwe0Mv2HkXxZ0jtequq0TF4VXKe3BWGEoiOGHcL4z9JbdcGIWiSpekfX7WCyZTa+HpUPCYpMu8pSFyGzZmiidY1A2ncNOI7LECz7l9rtKPcKs35uYljsA8nbGbU/xZwzQzxFYVi+S97QXVUUzNDgrRc8wxLaEjgulA=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0453.namprd15.prod.outlook.com (10.163.110.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 00:11:13 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::1d40:c1ed:72a7:38a6]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::1d40:c1ed:72a7:38a6%4]) with mapi id 15.20.1382.020; Tue, 4 Dec 2018
 00:11:13 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v4 4/7] cgroup: cgroup v2 freezer
Thread-Topic: [PATCH v4 4/7] cgroup: cgroup v2 freezer
Thread-Index: AQHUiQcuu3vJ28CJwUGWXyoIhkv5PaVtHB4AgACdiIA=
Date:   Tue, 4 Dec 2018 00:11:13 +0000
Message-ID: <20181204001105.GA14586@castle.DHCP.thefacebook.com>
References: <20181130234745.6756-1-guro@fb.com>
 <20181130234745.6756-5-guro@fb.com> <20181203144717.GD31795@redhat.com>
In-Reply-To: <20181203144717.GD31795@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR12CA0056.namprd12.prod.outlook.com
 (2603:10b6:300:103::18) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::5:9a6e]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0453;20:NiNXplmZzDJ0GpanlWCkM6fZChgaxvTGXsWOJl6vtoe+y7L5tQWNtaCPfdP4xbTaMI3Am2p+vKaHcVh1cmeId6p/hF7CV/e5TvN8s9yIdIrEpzXcLrF8+Fx+8qxiJKDFqDP4/WRhMr1m3OtpgF6wgovkGPNnB5oANkT/lL66C0c=
x-ms-office365-filtering-correlation-id: 5c476327-b7c5-453a-01c8-08d6597d0017
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0453;
x-ms-traffictypediagnostic: BY2PR15MB0453:
x-microsoft-antispam-prvs: <BY2PR15MB04531CC56F5859AB859BD123BEAF0@BY2PR15MB0453.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231455)(999002)(11241501185)(944501493)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0453;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0453;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(396003)(346002)(366004)(39860400002)(189003)(199004)(97736004)(6116002)(11346002)(476003)(5660300001)(486006)(46003)(68736007)(446003)(102836004)(4326008)(186003)(33656002)(39060400002)(256004)(5024004)(14444005)(6246003)(33896004)(6436002)(305945005)(105586002)(2906002)(316002)(25786009)(99286004)(106356001)(7736002)(229853002)(6486002)(52116002)(54906003)(6506007)(76176011)(386003)(71190400001)(71200400001)(6512007)(6916009)(8676002)(1076002)(8936002)(53936002)(478600001)(86362001)(9686003)(14454004)(81156014)(81166006)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0453;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hGN1PV1bymjoaPPxEDdQtkSfluZQMBNU1ZfEGE503xpKVD/Zk2REspjTu/skKDS4lCME5u6Vml3BevkthIwNUlz2aNAEnEcGSMpW3kJKQ112RDtd9HLB762YYb2it2THpaVc2r47ngsZe+Ln5WArfihwQZbj3dLjA80sQjeMIaIzmXTBE97DNZOkMuHzhrHqRL2HxAXzG4+v82LSy9H34aFzEjeBlUxdL52G+CUD2So2QCbaz2wef8WDtaB+GToLLyUeefHUivanbCUDRW1U/Y6GoZ7f4RMiTsVEir/FZ/0UEWEE1y9k5mXhQ8fZykTEE1h5Ng05ILcnnSI8k5pPbNfPOjpAXCmfKPZJTDJcO0I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <87C0C50BC289E147B62B1AF5F48DDDBE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c476327-b7c5-453a-01c8-08d6597d0017
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 00:11:13.0739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0453
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-03_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 03:47:18PM +0100, Oleg Nesterov wrote:
> To be honest, I fail to understand this patch. At least after a quick gla=
nce,
> I will try to read it again tomorrow but so far I do not even understand =
the
> desired semantics wrt signals/ptrace.
>=20
> On 11/30, Roman Gushchin wrote:
> >
> > @@ -368,6 +369,8 @@ static inline int signal_pending_state(long state, =
struct task_struct *p)
> >  		return 0;
> >  	if (!signal_pending(p))
> >  		return 0;
> > +	if (unlikely(cgroup_task_frozen(p)))
> > +		return __fatal_signal_pending(p);
>=20
> Oh, this is not nice. And doesn't look right.
>=20
> > +/*
> > + * Entry path into frozen state.
> > + * If the task was not frozen before, counters are updated and the cgr=
oup state
> > + * is revisited. Otherwise, the task is put into the TASK_KILLABLE sle=
ep.
> > + */
> > +void cgroup_enter_frozen(void)
> > +{
> > +	if (!current->frozen) {
> > +		struct cgroup *cgrp;
> > +
> > +		spin_lock_irq(&css_set_lock);
> > +		current->frozen =3D true;
> > +		cgrp =3D task_dfl_cgroup(current);
> > +		cgrp->freezer.nr_frozen_tasks++;
> > +		WARN_ON_ONCE(cgrp->freezer.nr_frozen_tasks >
> > +			     cgrp->freezer.nr_tasks_to_freeze);
> > +		cgroup_update_frozen(cgrp, true);
> > +		spin_unlock_irq(&css_set_lock);
> > +	}
> > +
> > +	__set_current_state(TASK_INTERRUPTIBLE);
> > +	schedule();
>=20
> The comment above says TASK_KILLABLE, very confusing.

Sorry, it's a leftover from one of the previous versions. Fixed.

>=20
> Probably this pairs with the change in signal_pending_state() above. So t=
his
> schedule() should actually "work" in that it won't return if signal_pendi=
ng().
>=20
> But this can't protect from another signal_wake_up(). Yes, iiuc in this c=
ase
> cgroup_enter_frozen() will be called again "soon" but this all looks stra=
nge.

So, the idea here is to make ptrace traps and fatal signals working, but
non-fatal shouldn't be delivered.

As soon as the frozen task is looping in the signal delivery loop, it's fin=
e,
it's not going anywhere.

Without the change above the task is getting out of schedule() immediately,
if any signal is pending (including non-fatals). So it becomes a busy-loop.

>=20
> > --- a/kernel/ptrace.c
> > +++ b/kernel/ptrace.c
> > @@ -410,6 +410,13 @@ static int ptrace_attach(struct task_struct *task,=
 long request,
> >
> >  	spin_lock(&task->sighand->siglock);
> >
> > +	/*
> > +	 * If the process is frozen, let's wake it up to give it a chance
> > +	 * to enter the ptrace trap.
> > +	 */
> > +	if (cgroup_task_frozen(task))
> > +		wake_up_process(task);
>=20
> And why this can't race with cgroup_enter_frozen() ?
>=20
> Or think of PTRACE_INTERRUPT. It can race with cgroup_enter_frozen() too,=
 the
> tracee can miss this request because of that change in signal_pending_sta=
te().

It's a good point. So I need an additional synchronization around
checking/setting the JOBCTL_TRAP_FREEZE?

>=20
>=20
> >  static void do_jobctl_trap(void)
> >  {
> > +	struct sighand_struct *sighand =3D current->sighand;
> >  	struct signal_struct *signal =3D current->signal;
> >  	int signr =3D current->jobctl & JOBCTL_STOP_SIGMASK;
> > =20
> > -	if (current->ptrace & PT_SEIZED) {
> > -		if (!signal->group_stop_count &&
> > -		    !(signal->flags & SIGNAL_STOP_STOPPED))
> > -			signr =3D SIGTRAP;
> > -		WARN_ON_ONCE(!signr);
> > -		ptrace_do_notify(signr, signr | (PTRACE_EVENT_STOP << 8),
> > -				 CLD_STOPPED);
> > -	} else {
> > -		WARN_ON_ONCE(!signr);
> > -		ptrace_stop(signr, CLD_STOPPED, 0, NULL);
> > -		current->exit_code =3D 0;
> > +	if (current->jobctl & (JOBCTL_TRAP_STOP | JOBCTL_TRAP_NOTIFY)) {
> > +		if (current->ptrace & PT_SEIZED) {
> > +			if (!signal->group_stop_count &&
> > +			    !(signal->flags & SIGNAL_STOP_STOPPED))
> > +				signr =3D SIGTRAP;
> > +			WARN_ON_ONCE(!signr);
> > +			ptrace_do_notify(signr,
> > +					 signr | (PTRACE_EVENT_STOP << 8),
> > +					 CLD_STOPPED);
> > +		} else {
> > +			WARN_ON_ONCE(!signr);
> > +			ptrace_stop(signr, CLD_STOPPED, 0, NULL);
> > +			current->exit_code =3D 0;
> > +		}
> > +	} else if (current->jobctl & JOBCTL_TRAP_FREEZE) {
> > +		/*
> > +		 * Enter the frozen state, unless the task is about to exit.
> > +		 */
> > +		if (fatal_signal_pending(current)) {
> > +			current->jobctl &=3D ~JOBCTL_TRAP_FREEZE;
> > +		} else {
> > +			spin_unlock_irq(&sighand->siglock);
> > +			cgroup_enter_frozen();
> > +			spin_lock_irq(&sighand->siglock);
> > +		}
> >  	}
> >  }
> > =20
> > @@ -2401,12 +2420,23 @@ bool get_signal(struct ksignal *ksig)
> >  		    do_signal_stop(0))
> >  			goto relock;
> > =20
> > -		if (unlikely(current->jobctl & JOBCTL_TRAP_MASK)) {
> > +		if (unlikely(current->jobctl &
> > +			     (JOBCTL_TRAP_MASK | JOBCTL_TRAP_FREEZE))) {
> >  			do_jobctl_trap();
>=20
> Cosmetic nit, but can't you add another helper? To me something like
>=20
> 		if (JOBCTL_TRAP_MASK)
> 			do_jobctl_trap();
> 		else if (JOBCTL_TRAP_FREEZE)
> 			do_jobctl_freeze();
>=20
> will look more clean, but I won't insist.

Sure.

>=20
>=20
> > +		/*
> > +		 * If the task is leaving the frozen state, let's update
> > +		 * cgroup counters and reset the frozen bit.
> > +		 */
> > +		if (unlikely(cgroup_task_frozen(current))) {
> > +			spin_unlock_irq(&sighand->siglock);
> > +			cgroup_leave_frozen();
> > +			spin_lock_irq(&sighand->siglock);
>=20
> looks like this needs another "goto relock", no?
>=20
> And perhaps this another reason for the new do_jobctl_freeze() helper whi=
ch
> could absorb this leave_frozen() ?

Makes sense. Will follow this path in v5.

Thank you!
