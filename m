Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5165CC32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E6E204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="MlFk8xXi";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YzFnXuXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E6E204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbeKUDEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:04:13 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48314 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725904AbeKUDEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:04:13 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id wAKGXfe8002261;
        Tue, 20 Nov 2018 08:34:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=1QWNwXk+d7gvnjiLHK8+lTv5uCYNdFQcPLt4U9dAXPg=;
 b=MlFk8xXirmkwe93vaKWWevEovJ2oWhsgEmtylHyNGoZ4NlXyDWEqVTQqIcYuM1Bmd5oa
 CzMz80ye4CaUe8XldnqndfFOWjkJ/yiTxSnEUF21areK7akSqe8e6upYWLuFTfELvsVr
 oEwfyy6ZcYL9H4hgekOHTT5yV0gJjAZWj6o= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2nvk4trswn-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 20 Nov 2018 08:34:06 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 20 Nov 2018 08:33:29 -0800
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Tue, 20 Nov 2018 08:33:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QWNwXk+d7gvnjiLHK8+lTv5uCYNdFQcPLt4U9dAXPg=;
 b=YzFnXuXTuAQ/WY5FSRJyeJneSTJ0rh87V69wRjWqJ5ZbWRAMmhdHbpfvzlw8Pic5xkmdRPA/fFcE2+TZ04JlHXojsZImGLgdnAeSwxSZ87rQVTBsEHwyIXWaCWF02I7KLQEQTZtiN4dyKGZ6xMzkRRF4c1PriTZMXYT/E5dZB5s=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0728.namprd15.prod.outlook.com (10.164.170.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Tue, 20 Nov 2018 16:33:11 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::1d40:c1ed:72a7:38a6]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::1d40:c1ed:72a7:38a6%3]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 16:33:11 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>
CC:     Roman Gushchin <guroan@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 4/7] cgroup: cgroup v2 freezer
Thread-Topic: [PATCH v3 4/7] cgroup: cgroup v2 freezer
Thread-Index: AQHUfg31+N8cXqD8i0C7qWHjcgNkRKVY3zGAgAACIoA=
Date:   Tue, 20 Nov 2018 16:33:11 +0000
Message-ID: <20181120163304.GA21462@tower.DHCP.thefacebook.com>
References: <20181117003830.15344-1-guro@fb.com>
 <20181117003830.15344-5-guro@fb.com>
 <20181120162529.GU2509588@devbig004.ftw2.facebook.com>
In-Reply-To: <20181120162529.GU2509588@devbig004.ftw2.facebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0062.namprd22.prod.outlook.com
 (2603:10b6:300:12a::24) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::4:6c9c]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0728;20:+47pHKjjliZlRk6s8Z+ZbjiPD8uA4/Ak/Vbw6ARB/XninZ2sV1557dPgI8vHBgRUcJx3zo3eMKTmTC3tDxyAdEmmmB7gGgkn9efuWA7Zyf6xYfiknUPJEuuqtCfQ2sBQBD8gyggQyeAHhA4Sk51COp8uqUG6DeuSsAHY/k7c+KQ=
x-ms-office365-filtering-correlation-id: db5968b5-5ff5-4dbe-7e3f-08d64f05dc3d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0728;
x-ms-traffictypediagnostic: BY2PR15MB0728:
x-microsoft-antispam-prvs: <BY2PR15MB07284623BE875DC9FDEDEEA5BED90@BY2PR15MB0728.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(10201501046)(3002001)(3231442)(11241501184)(944501410)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0728;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0728;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(2906002)(33656002)(6486002)(25786009)(478600001)(14454004)(105586002)(14444005)(256004)(106356001)(1076002)(2900100001)(316002)(54906003)(6116002)(305945005)(7736002)(6436002)(97736004)(5660300001)(68736007)(81166006)(81156014)(446003)(11346002)(71190400001)(8936002)(6246003)(476003)(8676002)(71200400001)(86362001)(9686003)(6512007)(53936002)(486006)(39060400002)(99286004)(102836004)(186003)(46003)(33896004)(6506007)(386003)(229853002)(4326008)(76176011)(6916009)(52116002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0728;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Y4h16w3fOVqBS3yF8U1e36cYFpQS9GBKuxCtvhPE2+t7NnTHaM91fTl5jg/P39A9V7iK+o6D3hxPGpd47utIvYKtTVLEJHblcsXTWevVDFKz0/mRxYtJT96pw/g6AGj4uPv7mGwQJL22pdsyTM2NcuE8IhLMrbuLgdDrXNoNtNpMZN9DcFpRoYvCVSs7CTH487Nb+cloUaGnj4VzGyTpXN4c0bOGGJcXYaA24Kfiw21dMkpN3i86Bry3VVDbEsnI5iET4qDrLAXoucGIWeMZ+HT97ihRc3SdDaH1geDumRg3nv2ZfGv8dzDyxBQv/Xi2FFy8O4BwIJ3b6nN3EgNhYuqiE9huXh58ZT4R54sl7Fo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BF46CAD78D143D44BEF5C9251F9041F1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: db5968b5-5ff5-4dbe-7e3f-08d64f05dc3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 16:33:11.2796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0728
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-20_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 08:25:29AM -0800, Tejun Heo wrote:
> On Fri, Nov 16, 2018 at 04:38:27PM -0800, Roman Gushchin wrote:
> > +void cgroup_freezer_migrate_task(struct task_struct *task,
> > +				 struct cgroup *src, struct cgroup *dst)
> > +{
> > +	lockdep_assert_held(&css_set_lock);
> > +
> > +	/*
> > +	 * Kernel threads are not supposed to be frozen at all.
> > +	 */
> > +	if (task->flags & PF_KTHREAD)
> > +		return;
> > +
> > +	/*
> > +	 * Adjust counters of freezing and frozen tasks.
> > +	 */
> > +	if (test_bit(CGRP_FREEZE, &src->flags)) {
> > +		src->freezer.nr_tasks_to_freeze--;
> > +		WARN_ON_ONCE(src->freezer.nr_tasks_to_freeze < 0);
> > +	}
> > +
> > +	/*
> > +	 * If the task is frozen, let's bump nr_tasks_to_freeze even
> > +	 * if the target cgroup isn't frozen: the counter will be decreased
> > +	 * in cgroup_leave_frozen().
> > +	 */
> > +	if (test_bit(CGRP_FREEZE, &dst->flags) || task->frozen)
> > +		dst->freezer.nr_tasks_to_freeze++;
> > +
> > +	if (task->frozen) {
> > +		src->freezer.nr_frozen_tasks--;
> > +		dst->freezer.nr_frozen_tasks++;
> > +		WARN_ON_ONCE(src->freezer.nr_frozen_tasks < 0);
> > +		WARN_ON_ONCE(dst->freezer.nr_frozen_tasks >
> > +			     dst->freezer.nr_tasks_to_freeze);
> > +	}
>=20
> If a non-frozen task is being moved into a frozen cgroup, shouldn't
> that also trigger frozen state update?

It does! Just below these lines:

	/*
	 * If the task isn't in the desired state, force it to it.
	 */
	if (task->frozen !=3D test_bit(CGRP_FREEZE, &dst->flags))
		cgroup_freeze_task(task, test_bit(CGRP_FREEZE, &dst->flags));


It's also covered by the 5th kselftest.

Thanks!
