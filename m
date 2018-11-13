Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA67C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC55920896
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="KR/iEmo5";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="hDs+A1UM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC55920896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbeKNIAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 03:00:18 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:17837 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726022AbeKNIAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 03:00:18 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wADLvAMb019746;
        Tue, 13 Nov 2018 14:00:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=BI5sKWfHNi89UzPilsd17pYMNcKueVRYVALJ7m46zIo=;
 b=KR/iEmo56N37WsPi5a13VWSNqk2gb6AYKHj51E+Tsa3J4jZbXTpa8wK5uPMdgDAhwa6e
 FN8ojExWn/PXXDsiHF9u8medKKfBnkGyJRGju9kIxT6eEW+ehLSsq/pM4WzFgS3ygWfS
 4dGRC2kAz8UmoeRwmbVnBU+V4OHg7DadiLU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2nr4hxrh22-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 13 Nov 2018 14:00:03 -0800
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 13 Nov 2018 13:59:27 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Tue, 13 Nov 2018 13:59:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BI5sKWfHNi89UzPilsd17pYMNcKueVRYVALJ7m46zIo=;
 b=hDs+A1UMem1elTkYaJbjlxBmR21KwFaAkrFeP/oEtCSctMctmw+rASrLJOjYlXgwHAsE45V0y8h2fxdPzm+XMb1gWWhJesJHlXGpvUX5DjrerSVZsCXMa+Ieln6HbQwcCxU1n3vYRxC4pe8Pmxqn38/bQ1fuEUtTL2aXWCKdnEg=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0822.namprd15.prod.outlook.com (10.164.171.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Tue, 13 Nov 2018 21:59:24 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14%2]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 21:59:24 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v2 3/6] cgroup: cgroup v2 freezer
Thread-Topic: [PATCH v2 3/6] cgroup: cgroup v2 freezer
Thread-Index: AQHUetwXxFde3wHnZUKDpNhUsGNNTqVN2ueAgABnogA=
Date:   Tue, 13 Nov 2018 21:59:23 +0000
Message-ID: <20181113215919.GC15590@tower.DHCP.thefacebook.com>
References: <20181112230422.5911-1-guro@fb.com>
 <20181112230422.5911-5-guro@fb.com> <20181113154825.GC30990@redhat.com>
In-Reply-To: <20181113154825.GC30990@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0054.namprd19.prod.outlook.com
 (2603:10b6:300:94::16) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::6:e7cf]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0822;20:uns9N4nGS22C3jN3Z4JeLdtlSZem+sdqMN2laTaLmb91KHTkqeUYfrzBFPOdvZOqM4zUdFGPx7m6G03Zbg1lI+yQoKYNRGqlU/uahg6a1bd+rZ9l8ESQdEwVluqt7ELoSnfqwmu1JxFXblkNnWmOakOdX3MQhOlKFvqGY93QfB0=
x-ms-office365-filtering-correlation-id: c9f6a8e5-1744-4355-9fd3-08d649b34593
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0822;
x-ms-traffictypediagnostic: BY2PR15MB0822:
x-microsoft-antispam-prvs: <BY2PR15MB0822A2BB56737C1CB6E144D8BEC20@BY2PR15MB0822.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(93006095)(93001095)(10201501046)(3231410)(11241501184)(944501410)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0822;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0822;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(102836004)(52116002)(76176011)(33896004)(105586002)(6506007)(386003)(575784001)(33656002)(86362001)(14454004)(186003)(7736002)(305945005)(8936002)(345774005)(68736007)(46003)(1076002)(99286004)(106356001)(11346002)(446003)(486006)(81166006)(81156014)(476003)(6116002)(8676002)(97736004)(229853002)(25786009)(256004)(14444005)(54906003)(316002)(71190400001)(2900100001)(478600001)(2906002)(6436002)(6486002)(6916009)(4326008)(53936002)(5660300001)(39060400002)(9686003)(6246003)(6512007)(71200400001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0822;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LGcbiCGFpv/ZkvmVd10GV0aD8eqLTaq71b5IHkpkRSBQL0uCSYwHL/KJBM7HTsPDlYGjKPmd/hwDpRc0SISDp63ukUKTXTePcme1+gT4iC/xpQn75T+QDB4GxF0FBVg/1Ri+ZFFdyKewQrf+lFYlBQxIcAHnJ6yHO2vvGGeZyvW+KTFCqTbjGN5E/NoBuov4mnOV10nrepAHMunPpaJel6DicuiQF6kSjc992EOQdUnV38U09JOWqb21wcjaPyDOuSuet7ES6exna7a1Zl9zIkuDonZwLKhJwTzj7+BTZQKiEExY6pN1M31XKj3k0BdO3VhtQgElWGMEdSl1rP+KyDvFW9TeVD3oWyhg3sto8Oc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6F48ABCFBF9C6F4591F8F42FAB296F0D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f6a8e5-1744-4355-9fd3-08d649b34593
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 21:59:23.9374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0822
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-13_15:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg!

On Tue, Nov 13, 2018 at 04:48:25PM +0100, Oleg Nesterov wrote:
> On 11/12, Roman Gushchin wrote:
> >
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -83,7 +83,8 @@ struct task_group;
> >  #define TASK_WAKING			0x0200
> >  #define TASK_NOLOAD			0x0400
> >  #define TASK_NEW			0x0800
> > -#define TASK_STATE_MAX			0x1000
> > +#define TASK_FROZEN			0x1000
> > +#define TASK_STATE_MAX			0x2000
>=20
> Just noticed the new task state... Why? Can't we avoid it?

We can, but it's nice to show to userspace that tasks are frozen,
rather than just stuck somewhere in the kernel...

>=20
> ...
>=20
> > +void cgroup_freezer_enter(void)
> > +{
> > +	long state =3D current->state;
>=20
> Why? it must be TASK_RUNNING?
>=20
> If not set_current_state() at the end is simply wrong... Yes, __refrigera=
tor()
> does this, but at least it has a reason although it is wrong too.
>=20
> > +	struct cgroup *cgrp;
> > +
> > +	if (!current->frozen) {
> > +		spin_lock_irq(&css_set_lock);
> > +		current->frozen =3D true;
> > +		cgrp =3D task_dfl_cgroup(current);
> > +		cgrp->freezer.nr_frozen_tasks++;
> > +
> > +		WARN_ON_ONCE(cgrp->freezer.nr_tasks_to_freeze <
> > +			     cgrp->freezer.nr_frozen_tasks);
> > +
> > +		if (cgrp->freezer.nr_tasks_to_freeze =3D=3D
> > +		    cgrp->freezer.nr_frozen_tasks)
> > +			cgroup_queue_notify_frozen(cgrp);
> > +		spin_unlock_irq(&css_set_lock);
> > +	}
> > +
> > +	/* refrigerator */
> > +	set_current_state(TASK_WAKEKILL | TASK_INTERRUPTIBLE | TASK_FROZEN);
>=20
> Why not __set_current_state() ?

Hm, it's not a hot path at all, so set_current_state() is good enough.
Not a strong preference, of course.

>=20
> If ->state include TASK_INTERRUPTIBLE, why do we need TASK_WAKEKILL?
>=20
> And again, why TASK_FROZEN?

So, should it be just TASK_INTERRUPTIBLE | TASK_FROZEN ?

>=20
> > +	clear_thread_flag(TIF_SIGPENDING);
> > +	schedule();
> > +	recalc_sigpending();
>=20
> I simply can't understand these 3 lines above but I bet this is not corre=
ct ;)

So, yeah, the problem is that if there is TIF_SIGPENDING bit set, schedule(=
)
will return immediately, so we're getting pretty much a busy loop here.
This is a nasty workaround.

I believe we can clear and not call recalc_sigpending() at all. Does this s=
eem
to be correct?

>=20
> if nothing else recalc_sigpending() without ->siglock is wrong, it can ra=
ce
> with signal_wakeup/etc.
>=20
> > +	set_current_state(state);
>=20
> see above...

Thank you for the review!
And looking forward for more comments from you!
