Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C92BC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBAB20855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="cHA7ygEV";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="kKFAZWhZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFBAB20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbeLKSlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:41:03 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54266 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726252AbeLKSlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:41:03 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBBIa1HU028763;
        Tue, 11 Dec 2018 10:40:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=PpWQbWMTDJn8Dhs/5lI36chAw7QFMQc+Ii/W6sMeU/g=;
 b=cHA7ygEVyGuJhCeEYRYLdGAR+MpbJ244XoZ4Ut90aZMXBsfNUyweXFdFMBPYcR1Hme6i
 7x8siT0izetQqvvHv5L8PwZXQtoB1rBZNQD5WnRdZycJ/2WcxmQEaJCH4E87WQ3Ho1gK
 j1lYpWbXdm8sn0OxPrhQ00GHe74Tyt+yjNU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pafja0s1q-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 11 Dec 2018 10:40:52 -0800
Received: from frc-mbx05.TheFacebook.com (2620:10d:c0a1:f82::29) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 11 Dec 2018 10:40:43 -0800
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-mbx05.TheFacebook.com (2620:10d:c0a1:f82::29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 11 Dec 2018 10:40:43 -0800
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Tue, 11 Dec 2018 10:40:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpWQbWMTDJn8Dhs/5lI36chAw7QFMQc+Ii/W6sMeU/g=;
 b=kKFAZWhZcIw7qpLPF6pnKAr3tGmETMhLbCImoWCyna0lO/VP/0d/jCM5MKrCKzUw6j6WcG3y6TvabpO5L2l4c5BsM7ZyPjA1TOzWJIGqh++6XXAJ474K2c3acPZRGHvqEPXvJDTzx7QfuKVtkgrhc8SrXqtHixtQWOKA1IFRx/c=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2197.namprd15.prod.outlook.com (52.135.196.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Tue, 11 Dec 2018 18:40:39 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::990:c2e0:2a8a:25c5]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::990:c2e0:2a8a:25c5%3]) with mapi id 15.20.1425.016; Tue, 11 Dec 2018
 18:40:39 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v5 4/7] cgroup: cgroup v2 freezer
Thread-Topic: [PATCH v5 4/7] cgroup: cgroup v2 freezer
Thread-Index: AQHUjmmlQwOP1yU/lEmjwwDF9MnbZKV5v7oAgAAldIA=
Date:   Tue, 11 Dec 2018 18:40:39 +0000
Message-ID: <20181211184033.GA8971@tower.DHCP.thefacebook.com>
References: <20181207201531.1665-1-guro@fb.com>
 <20181207201531.1665-5-guro@fb.com> <20181211162632.GB8504@redhat.com>
In-Reply-To: <20181211162632.GB8504@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO1PR15CA0047.namprd15.prod.outlook.com
 (2603:10b6:101:1f::15) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::5:8d6e]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2197;20:LgPwXsxaSyQYqf75ddXxEpI36UOF9t674K5pxXVWIzv+d4C7BhMc4+gH4hkorXH8KdPbEYtL/ZxXGyyu2/3NU+6F7xwNiEOqfrK93rx+dCqiR3KjPLFxN0J24qVHz67LVgD9n7IDsiQ4ErTPmjS/shnW/Hnxln3F1jfQEjZBbl0=
x-ms-office365-filtering-correlation-id: 803cb22c-63aa-4129-7d82-08d65f982575
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2197;
x-ms-traffictypediagnostic: BYAPR15MB2197:
x-microsoft-antispam-prvs: <BYAPR15MB2197BDED36EC84F2BD877C9FBEA60@BYAPR15MB2197.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3231455)(999002)(11241501185)(944501520)(52105112)(10201501046)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR15MB2197;BCL:0;PCL:0;RULEID:;SRVR:BYAPR15MB2197;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(396003)(376002)(346002)(199004)(189003)(305945005)(8676002)(81166006)(229853002)(8936002)(81156014)(6916009)(1076002)(97736004)(6116002)(33656002)(7736002)(6486002)(6436002)(14454004)(105586002)(54906003)(106356001)(316002)(68736007)(6512007)(25786009)(478600001)(9686003)(71190400001)(102836004)(53936002)(446003)(186003)(6506007)(4326008)(39060400002)(46003)(11346002)(76176011)(5660300001)(99286004)(386003)(71200400001)(6246003)(476003)(2906002)(14444005)(86362001)(5024004)(256004)(486006)(33896004)(52116002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2197;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: e+k6P3JXjYNKjbUxAqHNMmxujNexL8gZfHbnCMKOQaO+aojcwrnyPMgzJc/YqL3ZDAhw7wjgTdJLqwA01nniw73s0jkJuPDqZp72DlVGY1TKs/1uvG8j2NoQdHFGjnZEmSA84+f/qdbA63Z8xxooSXL8VDwmDzxRigt7eAOxGu81USUC5BDmSsF+kwZEQCji9zYdNpp2NnYAt9fWajT9n8ijXa3Copfkgu5PC+MKl27DPiXsX07yPlBxcijKZdmSF+nPxFTj2BFDdHSeZJan5sPOb9fknGCogzQzqF0Bcgh4an82ChZjeGDEv9A0kJSJ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3E1A5BC97A871243831DD0A6C3D02A1F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 803cb22c-63aa-4129-7d82-08d65f982575
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 18:40:39.1591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2197
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-11_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 05:26:32PM +0100, Oleg Nesterov wrote:
> On 12/07, Roman Gushchin wrote:
> >
> > Cgroup v2 freezer tries to put tasks into a state similar to jobctl
> > stop. This means that tasks can be killed, ptraced (using
> > PTRACE_SEIZE*), and interrupted. It is possible to attach to
> > a frozen task, get some information (e.g. read registers) and detach.
>=20
> I fail to understand how this all supposed to work.
>=20
> > @@ -368,6 +369,8 @@ static inline int signal_pending_state(long state, =
struct task_struct *p)
> >  		return 0;
> >  	if (!signal_pending(p))
> >  		return 0;
> > +	if (unlikely(cgroup_task_frozen(p) && p->jobctl =3D=3D JOBCTL_TRAP_FR=
EEZE))
> > +		return __fatal_signal_pending(p);
>=20
> I think I will never agree with this change ;) and I don't think it actua=
lly helps.

See below.

>=20
> > +void cgroup_enter_frozen(void)
> > +{
> > +	if (!current->frozen) {
> > +		spin_lock_irq(&css_set_lock);
> > +		current->frozen =3D true;
> > +		cgroup_inc_frozen_cnt(task_dfl_cgroup(current), false, true);
> > +		spin_unlock_irq(&css_set_lock);
> > +	}
> > +
> > +	__set_current_state(TASK_INTERRUPTIBLE);
> > +	schedule();
>=20
> So once again, suppose it races with PTRACE_INTERRUPT, or SIGSTOP, or som=
ething
> else which should be handled by get_signal() before do_freezer_trap().
>=20
> If (say) PTRACE_INTERRUPT comes before schedule it will be lost. Otherwis=
e
> the frozen task will react. This can't be right. Or I am totally confused=
.

Why?
PTRACE_INTERRUPT will set JOBCTL_TRAP_STOP, so signal_pending_state()
will return true, schedule() will return immediately, and we'll handle the =
trap.

>=20
> Perhaps you can split this patch? start with cgroup_enter_frozen() using
> TASK_KILLABLE, then teach it to handle ptrace/stop/etc? I think this way =
it
> would be simpler to discuss the necessary changes and document what exact=
ly
> are you trying to do.
>=20
> and btw.... what about suspend? try_to_freeze_tasks() will obviously fail
> if there is a ->frozen thread?

I have to think a bit more here, but something like this will probably work=
:

diff --git a/kernel/freezer.c b/kernel/freezer.c
index b162b74611e4..590ac4d10b02 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -134,7 +134,7 @@ bool freeze_task(struct task_struct *p)
                return false;
=20
        spin_lock_irqsave(&freezer_lock, flags);
-       if (!freezing(p) || frozen(p)) {
+       if (!freezing(p) || frozen(p) || cgroup_task_frozen()) {
                spin_unlock_irqrestore(&freezer_lock, flags);
                return false;
        }

--

If the task is already frozen by the cgroup freezer, we don't have to do
anything additionally.

Thanks!
