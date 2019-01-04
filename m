Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE682C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E6221872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=be.atlascopco.com header.i=@be.atlascopco.com header.b="Rr9MuQLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfADMmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 07:42:32 -0500
Received: from mail-eopbgr140048.outbound.protection.outlook.com ([40.107.14.48]:54055
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726218AbfADMmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 07:42:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=be.atlascopco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDE6OfRsU23/j/i8XxmU1M/sh6zL6FgB2GAMBEpUYqk=;
 b=Rr9MuQLk5ue0ZtzvQU3YYPPQF9n7T9cNcU6GQSirSJljOaQI/jSUoLP1Q8jJJk3cN7FofCf6Zo2RvFt2B/IjWhg8Tjoww0odSBG+X4kAnZD+bIkQ5PQQTe6dAQAm6S+U/qbjE5oFBjBW34dfahSkfR+3ilcG64OsFBqHqUzamsE=
Received: from AM0PR03MB4804.eurprd03.prod.outlook.com (20.178.21.77) by
 AM0PR03MB3683.eurprd03.prod.outlook.com (52.134.81.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Fri, 4 Jan 2019 12:42:27 +0000
Received: from AM0PR03MB4804.eurprd03.prod.outlook.com
 ([fe80::8c3d:1937:13d1:2034]) by AM0PR03MB4804.eurprd03.prod.outlook.com
 ([fe80::8c3d:1937:13d1:2034%3]) with mapi id 15.20.1495.005; Fri, 4 Jan 2019
 12:42:27 +0000
From:   Tom Putzeys <tom.putzeys@be.atlascopco.com>
To:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: CFS scheduler: spin_lock usage causes dead lock when
 smp_apic_timer_interrupt occurs
Thread-Topic: CFS scheduler: spin_lock usage causes dead lock when
 smp_apic_timer_interrupt occurs
Thread-Index: AQHUpCmA0rZUkh1AuUGWaL1Zt68HeKWfDRDJ
Date:   Fri, 4 Jan 2019 12:42:27 +0000
Message-ID: <AM0PR03MB4804FA468B7A006AEEA8592ABB8E0@AM0PR03MB4804.eurprd03.prod.outlook.com>
References: <AM0PR03MB480425D5999E0D08DAB30204BB8E0@AM0PR03MB4804.eurprd03.prod.outlook.com>
In-Reply-To: <AM0PR03MB480425D5999E0D08DAB30204BB8E0@AM0PR03MB4804.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tom.putzeys@be.atlascopco.com; 
x-originating-ip: [165.225.88.61]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR03MB3683;6:ZopUOaeFZf81t3cAKQ3mvpkbv56PK/bd9+oCwCAxfhzHWDvp6ZW2fmFBaUK8u5WTJEnLpd4KnJ4k9lX+xHgtK9o1rO/qCnlfdOr6DaliiKmMTgW1R40RCx0xuCZb7N+DpprbJbwvugbNrdZV3pM5F7C+L1tiXNyjaNxYMnbO6N8hZqA/zDhwJ8br8fCX7+zfwsU4rIIck2hjUHgf6FnncahU2QoBhWBfXjoHSFZ6Bm2qfrkdcUOBhvpYeKJ/iX/I1GuJQf3GHknVjj+5CsCC+oQyhj0azr+b5rIZTnm9KEFXkxBfv25BXdqbngsnklf4xi42++h07B3y3XdrPtmpGYnqsRWFaLe0qQs/ODckBb6cys0HNLkP3W16LS+1p/bEcFQKEog9LkYctehuHAjUQWk14yswb7EE740NpGXjgWRwHCv8uzW2eXOHTQyLj0IvLsRuZlRwczb6BWZ6lIGWkg==;5:2I+KGzDhTMvQimwNI4rLFkNDddt6umBSOuhZhu5qUWZuOPW+N5/GhS+0xMUcGIzguk2i7PVa7OxVK2QJ6AemgLy1IV9A/AYygVilUrHqtL/rz/LwdXYX1O+PQx7EcQhiDzso/s7OMiEkfqVI/DdHslv71XnPQidgBa9cXu8qOB+Lf78zodtkYKsCB9CELcJ+UM72jJMut5MuMZgteX9VqA==;7:bbFzygNR5VsO3hgN+NWrv3J5NGwfCUtGwbyfiDaTAaeA+hKqu6fr4IBKAJyhssrX0CUy88vfvAogfea8F3CPhTKowCUu0hbc+GyMytTaSKuf4BimUsvL4vVl+SUW/zqPwHWb2Lg4x1stGumk6nx2DA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6026474d-ab08-4151-2198-08d6724215c1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR03MB3683;
x-ms-traffictypediagnostic: AM0PR03MB3683:
x-microsoft-antispam-prvs: <AM0PR03MB368384CEE4B1DBBBB0D733EDBB8E0@AM0PR03MB3683.eurprd03.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM0PR03MB3683;BCL:0;PCL:0;RULEID:;SRVR:AM0PR03MB3683;
x-forefront-prvs: 0907F58A24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(136003)(346002)(376002)(189003)(199004)(81156014)(81166006)(186003)(8676002)(68736007)(33656002)(3846002)(14454004)(8936002)(2940100002)(6116002)(93156006)(105586002)(97736004)(66066001)(4326008)(478600001)(106356001)(25786009)(7736002)(305945005)(71190400001)(486006)(6306002)(71200400001)(9686003)(55016002)(44832011)(53936002)(11346002)(446003)(476003)(7696005)(5660300001)(86362001)(26005)(55236004)(2501003)(102836004)(76176011)(2906002)(110136005)(74316002)(256004)(14444005)(6506007)(966005)(316002)(99286004)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR03MB3683;H:AM0PR03MB4804.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: be.atlascopco.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tN57Mb587XAd8OiZcL0UVgo2uvILeEatX2Ez+NnF8t2w+90Dfa3bZCEF0z1j4DBRQNyn/uoftbYSRWWYDlZVs3NL6OgnbsV6ehvW2veHfe/eYPOdNswqFPGmEhxy1jrozvaDJEkbXja3vR++6Ka7VxodxJ9tFHZrUXmG4ve553B5BveUctN1V1BGzd4fddmKkMmRkEcQgJg8G6rMEU0uqy+Mi4HXNbabGmVzwdwq6HUantpGbbtgxmspCUgyAo3sT3uKcfux4BUZRdhawT2Bb4/pq8YFj15jVj+m7J+nVecT2ZPCR06w9rCtlMmxInG6
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: be.atlascopco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6026474d-ab08-4151-2198-08d6724215c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2019 12:42:27.7179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 556e6b1f-b49d-4278-8baf-db06eeefc8e9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB3683
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Ingo and Peter,

I would like to report a possible bug in the CFS scheduler causing a dead l=
ock.=A0

We suspect this bug to have caused intermittent yet highly-persistent syste=
m freezes on our quad-core SMP systems.

We noticed the problem on 4.1.17 preempt-rt but we suspect the problematic =
code is not linked to the preempt-rt patch and is also present in the lates=
t 4.20 kernel.

The problem concerns the use of spin_lock to lock cfs_b in a situation wher=
e the spin lock is used in an interrupt handler:
-  __run_hrtimer (in kernel/time/hrtimer.c) calls fn(timer) with IRQ's enab=
led. This can call sched_cfs_period_timer() (in kernel/sched/fair.c) which =
locks cfs_b.=A0
- the hard IRQ smp_apic_timer_interrupt can then occur. It can call ttwu_qu=
eue() which grabs the spin lock for its CPU run queue and can then try to e=
nqueue a task via the CFS scheduler.
- this can call check_enqueue_throttle() which can call assign_cfs_rq_runti=
me() which tries to obtain the cfs_b lock. It is now blocked.

The cfs_b lock uses spin_lock and so was not intended for use inside a hard=
 irq but the CFS scheduler does just that when it uses a hrtimer_interrupt =
to wake up and enqueue work. Our initial impression is that  the cfs_b need=
s to be locked using spin_lock_irqsave.

My colleague Mike Pearce has submitted a bug report on Bugzilla 3 weeks ago=
: https://bugzilla.kernel.org/show_bug.cgi?id=3D201993

We would appreciate any feedback.

Kind regards,

Tom

     =
