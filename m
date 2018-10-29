Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2125CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775162082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="RiV8ne3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775162082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbeJ2UNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 16:13:05 -0400
Received: from mail-eopbgr70040.outbound.protection.outlook.com ([40.107.7.40]:26788
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726582AbeJ2UNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 16:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7G4MawVxblUIJxDyUnvZuDya/gRtl2yRtNyn3CvXQU=;
 b=RiV8ne3lB16sRKcWNpwgNs8vXrKf2CRdvBin7VRkUit3QmASeKrqHBQ+dvk4AW9ZypxmrVKFMJuHLsac8DzN5yhSNYRR6xlQEVNl7ylqY8nGoQ+57op29WWA4TC1XmI1KoCU741TIuro4V2hD6NXVu2DSMiKiPM5dt/SBlugKSI=
Received: from AM4PR0501MB2769.eurprd05.prod.outlook.com (10.172.216.13) by
 AM4PR0501MB2258.eurprd05.prod.outlook.com (10.165.82.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.18; Mon, 29 Oct 2018 11:24:43 +0000
Received: from AM4PR0501MB2769.eurprd05.prod.outlook.com
 ([fe80::1c05:fbc0:15d3:9c93]) by AM4PR0501MB2769.eurprd05.prod.outlook.com
 ([fe80::1c05:fbc0:15d3:9c93%3]) with mapi id 15.20.1273.027; Mon, 29 Oct 2018
 11:24:42 +0000
From:   Ran Rozenstein <ranro@mellanox.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "dipankar@in.ibm.com" <dipankar@in.ibm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        Maor Gottlieb <maorg@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: RE: [PATCH tip/core/rcu 02/19] rcu: Defer reporting RCU-preempt
 quiescent states when disabled
Thread-Topic: [PATCH tip/core/rcu 02/19] rcu: Defer reporting RCU-preempt
 quiescent states when disabled
Thread-Index: AQHUb27SVlgbygUSaE+GPdWo3UdIVqU2Ei+g
Date:   Mon, 29 Oct 2018 11:24:42 +0000
Message-ID: <AM4PR0501MB27691ECD1B0ECB0531B16F20C5F30@AM4PR0501MB2769.eurprd05.prod.outlook.com>
References: <20180829222021.GA29944@linux.vnet.ibm.com>
 <20180829222047.319-2-paulmck@linux.vnet.ibm.com>
In-Reply-To: <20180829222047.319-2-paulmck@linux.vnet.ibm.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ranro@mellanox.com; 
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM4PR0501MB2258;6:TQNWERzxpQD0bZlt2DcJ46+fWWy6UlihzE+V/pbq1NFjWyPmAkS93hZ6EWJcKX0cc93k3XZtEIgrx1lVI9D5F4ot0UaogDzSPySSgNE/4VNlggwU2hz9YDX2nuL4zXzUpJlOw1Vo69prhm19JIiixKl58FyuDV1/VmCu8cfEz1GnVYaeDIPpmxmZw1w+pOsTKn2hUBgZMgFeKyZpt6vmd4FcHcIxPl91a2Mf14KQW3xd0GSc3ZVygQElc5O92ZDmIVoSp8n9Wq0PQZUXHnBoPpWRZnwnOcCFCccj2ylGIqpNUoqec14OosE02UVp+ZvHEtBpqWJzj32p3Qb2MlMFNIB8Ug+nlgUfYpyS+ZAc6lELjCvOLveyXSjIjLRoOpOgzZVjO6FCoNmTzz74JyV5xOpv8fAQL79d/KwQei9k40SedjPkeAfxIzX49B0m4q4bTnQnXWwLofLlr2NHVRqGhA==;5:Jmj7QUEFqWTXWyeSGnD8RCrBOgoNcjuPa5QvZJfLxJ8D86LWNLnNlwEkzdNj0IAfHp4aIEJpOwYvdcLzyUdesV8lpujJsZjhbyms6O3dC+Jov6aPRZVAZrJNNc15ECYU4G/E4xMJaQa8pAxAt2ovQCtGy78YprExEYSWsEJTuZ4=;7:4NiS6UbPaLIe7O+3D60LhtnOLMctzrJnYFQlgpe6fwlGgSg5t0V7+uem9AU6zLI7lPmTNfgnrsirQMKCuBJ0wYPv9QKT7xzcY0nebpxfqAl/X/shmP7pThm8X758fA68QyGHGxwG0BBGYaPvDe+Q0g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 18b3f90c-549f-4a1c-5877-08d63d911f9b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR0501MB2258;
x-ms-traffictypediagnostic: AM4PR0501MB2258:
x-microsoft-antispam-prvs: <AM4PR0501MB22585BD22CC1AE81DF76C8D9C5F30@AM4PR0501MB2258.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211171220733660)(9452136761055)(85827821059158)(280536654915231)(104084551191319)(211936372134217)(20558992708506);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM4PR0501MB2258;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0501MB2258;
x-forefront-prvs: 084080FC15
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(396003)(136003)(39860400002)(189003)(13464003)(199004)(7416002)(6506007)(53936002)(26005)(68736007)(6246003)(107886003)(99286004)(105586002)(102836004)(106356001)(81166006)(55016002)(6116002)(3846002)(9686003)(86362001)(8936002)(53546011)(305945005)(7696005)(7736002)(81156014)(76176011)(8676002)(6436002)(5660300001)(2906002)(229853002)(2501003)(74316002)(33656002)(5250100002)(4001150100001)(14444005)(256004)(2900100001)(97736004)(4326008)(25786009)(39060400002)(71190400001)(11346002)(476003)(446003)(71200400001)(478600001)(66066001)(54906003)(316002)(14454004)(110136005)(186003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0501MB2258;H:AM4PR0501MB2769.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GOSWAG3+R8hi/pYqm/d9qcT6uMDVIGdMd84cYKDa0jJARs2X3KcRhRQ7ZCEXYDpJp7zpnb+10O2c6XbSgHtuTAHIm2l/tBvPepjNzyn6QYiqrAM2dJx05TF281SXUETi8gkMq4mck8y3M/rbDMH4DGXrf+B/ddeCJTssgGE5+MC7JNDVXlR7uvkZeLZ93s3+YuIuUDQlCBg7Aa8DnllvamP7KJaQzg3REVawmDHkn4VM04CFqbiF+2anx683/jQzbmsiUl45ALhAVWOeFJ3vKrecjOgEszCdF2gagyno/V7ej1RioGucULayh5zgDMzRq293TtnKcAZXXLfxH6R/AOF38zapupeKfTj3aekocQk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b3f90c-549f-4a1c-5877-08d63d911f9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 11:24:42.8080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0501MB2258
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul and all,

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Paul E. McKenney
> Sent: Thursday, August 30, 2018 01:21
> To: linux-kernel@vger.kernel.org
> Cc: mingo@kernel.org; jiangshanlai@gmail.com; dipankar@in.ibm.com;
> akpm@linux-foundation.org; mathieu.desnoyers@efficios.com;
> josh@joshtriplett.org; tglx@linutronix.de; peterz@infradead.org;
> rostedt@goodmis.org; dhowells@redhat.com; edumazet@google.com;
> fweisbec@gmail.com; oleg@redhat.com; joel@joelfernandes.org; Paul E.
> McKenney <paulmck@linux.vnet.ibm.com>
> Subject: [PATCH tip/core/rcu 02/19] rcu: Defer reporting RCU-preempt
> quiescent states when disabled
>=20
> This commit defers reporting of RCU-preempt quiescent states at
> rcu_read_unlock_special() time when any of interrupts, softirq, or
> preemption are disabled.  These deferred quiescent states are reported at=
 a
> later RCU_SOFTIRQ, context switch, idle entry, or CPU-hotplug offline
> operation.  Of course, if another RCU read-side critical section has star=
ted in
> the meantime, the reporting of the quiescent state will be further deferr=
ed.
>=20
> This also means that disabling preemption, interrupts, and/or softirqs wi=
ll act
> as an RCU-preempt read-side critical section.
> This is enforced by checking preempt_count() as needed.
>=20
> Some special cases must be handled on an ad-hoc basis, for example,
> context switch is a quiescent state even though both the scheduler and
> do_exit() disable preemption.  In these cases, additional calls to
> rcu_preempt_deferred_qs() override the preemption disabling.  Similar log=
ic
> overrides disabled interrupts in rcu_preempt_check_callbacks() because in
> this case the quiescent state happened just before the corresponding
> scheduling-clock interrupt.
>=20
> In theory, this change lifts a long-standing restriction that required th=
at if
> interrupts were disabled across a call to rcu_read_unlock() that the matc=
hing
> rcu_read_lock() also be contained within that interrupts-disabled region =
of
> code.  Because the reporting of the corresponding RCU-preempt quiescent
> state is now deferred until after interrupts have been enabled, it is no =
longer
> possible for this situation to result in deadlocks involving the schedule=
r's
> runqueue and priority-inheritance locks.  This may allow some code
> simplification that might reduce interrupt latency a bit.  Unfortunately,=
 in
> practice this would also defer deboosting a low-priority task that had be=
en
> subjected to RCU priority boosting, so real-time-response considerations
> might well force this restriction to remain in place.
>=20
> Because RCU-preempt grace periods are now blocked not only by RCU read-
> side critical sections, but also by disabling of interrupts, preemption, =
and
> softirqs, it will be possible to eliminate RCU-bh and RCU-sched in favor =
of
> RCU-preempt in CONFIG_PREEMPT=3Dy kernels.  This may require some
> additional plumbing to provide the network denial-of-service guarantees
> that have been traditionally provided by RCU-bh.  Once these are in place=
,
> CONFIG_PREEMPT=3Dn kernels will be able to fold RCU-bh into RCU-sched.
> This would mean that all kernels would have but one flavor of RCU, which
> would open the door to significant code cleanup.
>=20
> Moving to a single flavor of RCU would also have the beneficial effect of
> reducing the NOCB kthreads by at least a factor of two.
>=20
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com> [ paulmck:
> Apply rcu_read_unlock_special() preempt_count() feedback
>   from Joel Fernandes. ]
> [ paulmck: Adjust rcu_eqs_enter() call to rcu_preempt_deferred_qs() in
>   response to bug reports from kbuild test robot. ] [ paulmck: Fix bug lo=
cated
> by kbuild test robot involving recursion
>   via rcu_preempt_deferred_qs(). ]
> ---
>  .../RCU/Design/Requirements/Requirements.html |  50 +++---
>  include/linux/rcutiny.h                       |   5 +
>  kernel/rcu/tree.c                             |   9 ++
>  kernel/rcu/tree.h                             |   3 +
>  kernel/rcu/tree_exp.h                         |  71 +++++++--
>  kernel/rcu/tree_plugin.h                      | 144 +++++++++++++-----
>  6 files changed, 205 insertions(+), 77 deletions(-)
>=20

We started seeing the trace below in our regression system, after I bisecte=
d I found this is the offending commit.
This appears immediately on boot.=20
Please let me know if you need any additional details.

Thanks,
Ran


[2018-10-27 05:53:07] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[2018-10-27 05:53:07] UBSAN: Undefined behaviour in kernel/rcu/tree_plugin.=
h:620:28
[2018-10-27 05:53:07] signed integer overflow:
[2018-10-27 05:53:07] 0 - -2147483648 cannot be represented in type 'int'
[2018-10-27 05:53:07] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.0-for-=
upstream-dbg-2018-10-25_03-10-39-82 #1
[2018-10-27 05:53:07] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)=
, BIOS 1.10.2-1ubuntu1 04/01/2014
[2018-10-27 05:53:07] Call Trace:
[2018-10-27 05:53:07]  dump_stack+0x9a/0xeb
[2018-10-27 05:53:07]  ubsan_epilogue+0x9/0x7c
[2018-10-27 05:53:07]  handle_overflow+0x235/0x278
[2018-10-27 05:53:07]  ? __ubsan_handle_negate_overflow+0x1bd/0x1bd
[2018-10-27 05:53:07]  ? sched_clock_local+0xd4/0x140
[2018-10-27 05:53:07]  ? kvm_clock_read+0x14/0x30
[2018-10-27 05:53:07]  rcu_preempt_deferred_qs+0x12a/0x150
[2018-10-27 05:53:07]  rcu_note_context_switch+0x1b9/0x1ac0
[2018-10-27 05:53:07]  __schedule+0x22d/0x1fd0
[2018-10-27 05:53:07]  ? pci_mmcfg_check_reserved+0x130/0x130
[2018-10-27 05:53:07]  ? sched_set_stop_task+0x330/0x330
[2018-10-27 05:53:07]  ? lockdep_hardirqs_on+0x360/0x620
[2018-10-27 05:53:07]  schedule_idle+0x45/0x80
[2018-10-27 05:53:07]  do_idle+0x23e/0x3e0
[2018-10-27 05:53:07]  ? check_flags.part.26+0x440/0x440
[2018-10-27 05:53:07]  ? arch_cpu_idle_exit+0x40/0x40
[2018-10-27 05:53:07]  ? __wake_up_common+0x156/0x5c0
[2018-10-27 05:53:07]  ? _raw_spin_unlock_irqrestore+0x59/0x70
[2018-10-27 05:53:07]  cpu_startup_entry+0x19/0x20
[2018-10-27 05:53:07]  start_secondary+0x420/0x570
[2018-10-27 05:53:07]  ? set_cpu_sibling_map+0x2f90/0x2f90
[2018-10-27 05:53:07]  secondary_startup_64+0xa4/0xb0
[2018-10-27 05:53:07] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[2018-10-27 05:53:07] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[2018-10-27 05:53:07] UBSAN: Undefined behaviour in kernel/rcu/tree_plugin.=
h:624:28
[2018-10-27 05:53:07] signed integer overflow:
[2018-10-27 05:53:07] -2147483648 + -2147483648 cannot be represented in ty=
pe 'int'
[2018-10-27 05:53:07] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.0-for-=
upstream-dbg-2018-10-25_03-10-39-82 #1
[2018-10-27 05:53:07] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)=
, BIOS 1.10.2-1ubuntu1 04/01/2014
[2018-10-27 05:53:07] Call Trace:
[2018-10-27 05:53:07]  dump_stack+0x9a/0xeb
[2018-10-27 05:53:07]  ubsan_epilogue+0x9/0x7c
[2018-10-27 05:53:07]  handle_overflow+0x235/0x278
[2018-10-27 05:53:07]  ? __ubsan_handle_negate_overflow+0x1bd/0x1bd
[2018-10-27 05:53:07]  ? check_flags.part.26+0x440/0x440
[2018-10-27 05:53:07]  ? _raw_spin_unlock_irqrestore+0x3c/0x70
[2018-10-27 05:53:07]  ? _raw_spin_unlock_irqrestore+0x3c/0x70
[2018-10-27 05:53:07]  ? lockdep_hardirqs_off+0x1fd/0x2c0
[2018-10-27 05:53:07]  ? kvm_clock_read+0x14/0x30
[2018-10-27 05:53:07]  rcu_preempt_deferred_qs+0x145/0x150
[2018-10-27 05:53:07]  rcu_note_context_switch+0x1b9/0x1ac0
[2018-10-27 05:53:07]  __schedule+0x22d/0x1fd0
[2018-10-27 05:53:07]  ? pci_mmcfg_check_reserved+0x130/0x130
[2018-10-27 05:53:07]  ? sched_set_stop_task+0x330/0x330
[2018-10-27 05:53:07]  ? lockdep_hardirqs_on+0x360/0x620
[2018-10-27 05:53:07]  schedule_idle+0x45/0x80
[2018-10-27 05:53:07]  do_idle+0x23e/0x3e0
[2018-10-27 05:53:07]  ? check_flags.part.26+0x440/0x440
[2018-10-27 05:53:07]  ? arch_cpu_idle_exit+0x40/0x40
[2018-10-27 05:53:07]  ? __wake_up_common+0x156/0x5c0
[2018-10-27 05:53:07]  ? _raw_spin_unlock_irqrestore+0x59/0x70
[2018-10-27 05:53:07]  cpu_startup_entry+0x19/0x20
[2018-10-27 05:53:07]  start_secondary+0x420/0x570
[2018-10-27 05:53:07]  ? set_cpu_sibling_map+0x2f90/0x2f90
[2018-10-27 05:53:07]  secondary_startup_64+0xa4/0xb0
[2018-10-27 05:53:07] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


