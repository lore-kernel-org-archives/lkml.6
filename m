Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A963ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F314A21477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OdnAIfLw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F314A21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbeIOHHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:07:53 -0400
Received: from mail-sn1nam01on0101.outbound.protection.outlook.com ([104.47.32.101]:52800
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728272AbeIOGrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFD1pWkVWjtug9sM2Z2E4WeaGwE0VO7Tux+9y9X8PuQ=;
 b=OdnAIfLwr/jyMlslhvikERWaJJ9zbVSIfvM/mlukiF4ZyGVBVtHNMqcKsVaWlmeeS9RQDSJA4/9R+NLKxtt4zzUuQz4xAI/nbm+gwtvM0p1ROYqmrAkVRLQGpf6sU70KFFP0mxgu8S888uC0Q/ieofjdYGhbjrZJS9OBws2ozMk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:30:05 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:05 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 23/92] sched/core: Use smp_mb() in
 wake_woken_function()
Thread-Topic: [PATCH AUTOSEL 4.18 23/92] sched/core: Use smp_mb() in
 wake_woken_function()
Thread-Index: AQHUTJOhrFRXKX/mcUqP6nIIcOfdSg==
Date:   Sat, 15 Sep 2018 01:30:05 +0000
Message-ID: <20180915012944.179481-23-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:SJcdoN4Q+M41yIWyUk82JQLSuQZ+tplLCOwWE5y66F48govwShcwv0mgfsfezGGGXWft1aM0H7KVLP5pwYv8YJwFqilWBY+ZoT9Xmf5/SDD5oOnhP1uoDSPihXiFRP2SLhk0yxRaxJvl6Xf1nZk3QN0+Z4w57r6ogM09PVfReOmuFX9u3t9cyfLa1Z7K73WEfl25en+UZW27Dwv+IlX+6m9z6PmOgNmsGXeUJ0eaLZMQFK8aDwd79oQjzxoewB7bMkojrE+toTGR6mICXVHgZAqtd6Z5TsKAGwiOykMUn9WkHcx/0yvzjmhqfAhJEc3Z8iOCj2tYIAcuuvtZAhTvcP/J8Q1L0y/uYv8DurjFqCRJD5k4egTi4JWWWkWkXq/Yhb/hHPkoYVcLWFw54+zIN+TVx01PhXComRAUWbN+jJr2NkZZaeZNOJYJf0grwagVqUtAnqpmKwW/GbSaTxaBFg==;5:yVXpP5xnBxweW7g73SX/YjIkDnT0A2y+axU53pfAWu5VDZWCOBbG1VPXUqyGumVpV5gxkdDfnAKqPkT19lxpJj3wRc+MJzKvs302JuC9Vn1F17FexygE3LYd6/VtHS37d/0enYUa0aKwJr4OQ2tJPfgStSVFDGiZbS2MBJrBZAg=;7:Zx+4KNmO2GQe9n8SsVhub5lMlO34WiPDam9wfo85wt5kvPKfLX4zikaqG4+GH6O/wEIZqEjM30JkzAvfX44deFyJlyjLmzVAzJs+QaZb1lcBy+UwzMd8dSIX3skxIC5n0RfhTQOI5HOl+uvLSKxHS1UjQ/A2er9Ud9+iaiMd7kC7CaRQ2Pw02XreAqozVvN6TUR0ZBQ97GzUMhjEhdbDUWwmQtn2fkdFQcvd9u1hpt5exvj9ycJp6qZb+5rHn8Sp
x-ms-office365-filtering-correlation-id: 39cf7fc4-1b80-4ac4-91d3-08d61aaac41f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
x-microsoft-antispam-prvs: <CY4PR21MB08249C45C83C42E66981D2D9FB180@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(190756311086443)(180628864354917)(89211679590171)(9452136761055)(85827821059158)(35762410373642)(42068640409301)(57025502571588)(151975744463004);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(346002)(366004)(396003)(189003)(199004)(6506007)(1076002)(66066001)(22452003)(99286004)(102836004)(76176011)(2501003)(5250100002)(97736004)(54906003)(6116002)(186003)(39060400002)(3846002)(107886003)(25786009)(11346002)(6346003)(446003)(486006)(476003)(26005)(2616005)(5660300001)(10090500001)(86612001)(86362001)(36756003)(4326008)(217873002)(316002)(68736007)(110136005)(8936002)(81156014)(8676002)(2906002)(6436002)(14444005)(256004)(72206003)(7736002)(53936002)(2900100001)(966005)(6306002)(478600001)(6512007)(81166006)(10290500003)(105586002)(7416002)(305945005)(106356001)(6486002)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: RmI6n/e1NRvNDfSf/6piCIhn4zt4SEzIAof+DmgKJnNe6Z+0M4JO5j0SS46h0nVKi+2STSp6AjPezSzgdlNOsjvbQ0yoEM8XCka5fqPB4RQrbEc5iBM5hQjjD7QiKOkSX6pUksNec4ZGGWkC+h+6DE9ef2fPZirwdgx8g2NNt6vTQUFN4TFSNFS+M5e+rcuBI2pu6UD9rJAvu5RHN7NtfdhBKqe5cpkb9JNnK18dYQSM0BpAQRCqRFZOiwEshSzCxovELL/PVs5XliTuD1dXUvsCTvxhvLUdE1ltLz4p8fuQ7L8+GhR6gruLnz75Tfcf85QBDz6HuR7XXUH23YWfEoH0w8N1wy8cFBThkOZA5Hg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39cf7fc4-1b80-4ac4-91d3-08d61aaac41f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:05.5732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Parri <andrea.parri@amarulasolutions.com>

[ Upstream commit 76e079fefc8f62bd9b2cd2950814d1ee806e31a5 ]

wake_woken_function() synchronizes with wait_woken() as follows:

  [wait_woken]                       [wake_woken_function]

  entry->flags &=3D ~wq_flag_woken;    condition =3D true;
  smp_mb();                          smp_wmb();
  if (condition)                     wq_entry->flags |=3D wq_flag_woken;
     break;

This commit replaces the above smp_wmb() with an smp_mb() in order to
guarantee that either wait_woken() sees the wait condition being true
or the store to wq_entry->flags in woken_wake_function() follows the
store in wait_woken() in the coherence order (so that the former can
eventually be observed by wait_woken()).

The commit also fixes a comment associated to set_current_state() in
wait_woken(): the comment pairs the barrier in set_current_state() to
the above smp_wmb(), while the actual pairing involves the barrier in
set_current_state() and the barrier executed by the try_to_wake_up()
in wake_woken_function().

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: akiyks@gmail.com
Cc: boqun.feng@gmail.com
Cc: dhowells@redhat.com
Cc: j.alglave@ucl.ac.uk
Cc: linux-arch@vger.kernel.org
Cc: luc.maranget@inria.fr
Cc: npiggin@gmail.com
Cc: parri.andrea@gmail.com
Cc: stern@rowland.harvard.edu
Cc: will.deacon@arm.com
Link: http://lkml.kernel.org/r/20180716180605.16115-10-paulmck@linux.vnet.i=
bm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/sched/wait.c | 47 ++++++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 928be527477e..a7a2aaa3026a 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -392,35 +392,36 @@ static inline bool is_kthread_should_stop(void)
  *     if (condition)
  *         break;
  *
- *     p->state =3D mode;				condition =3D true;
- *     smp_mb(); // A				smp_wmb(); // C
- *     if (!wq_entry->flags & WQ_FLAG_WOKEN)	wq_entry->flags |=3D WQ_FLAG_=
WOKEN;
- *         schedule()				try_to_wake_up();
- *     p->state =3D TASK_RUNNING;		    ~~~~~~~~~~~~~~~~~~
- *     wq_entry->flags &=3D ~WQ_FLAG_WOKEN;		condition =3D true;
- *     smp_mb() // B				smp_wmb(); // C
- *						wq_entry->flags |=3D WQ_FLAG_WOKEN;
- * }
- * remove_wait_queue(&wq_head, &wait);
+ *     // in wait_woken()			// in woken_wake_function()
  *
+ *     p->state =3D mode;				wq_entry->flags |=3D WQ_FLAG_WOKEN;
+ *     smp_mb(); // A				try_to_wake_up():
+ *     if (!(wq_entry->flags & WQ_FLAG_WOKEN))	   <full barrier>
+ *         schedule()				   if (p->state & mode)
+ *     p->state =3D TASK_RUNNING;			      p->state =3D TASK_RUNNING;
+ *     wq_entry->flags &=3D ~WQ_FLAG_WOKEN;	~~~~~~~~~~~~~~~~~~
+ *     smp_mb(); // B				condition =3D true;
+ * }						smp_mb(); // C
+ * remove_wait_queue(&wq_head, &wait);		wq_entry->flags |=3D WQ_FLAG_WOKEN=
;
  */
 long wait_woken(struct wait_queue_entry *wq_entry, unsigned mode, long tim=
eout)
 {
-	set_current_state(mode); /* A */
 	/*
-	 * The above implies an smp_mb(), which matches with the smp_wmb() from
-	 * woken_wake_function() such that if we observe WQ_FLAG_WOKEN we must
-	 * also observe all state before the wakeup.
+	 * The below executes an smp_mb(), which matches with the full barrier
+	 * executed by the try_to_wake_up() in woken_wake_function() such that
+	 * either we see the store to wq_entry->flags in woken_wake_function()
+	 * or woken_wake_function() sees our store to current->state.
 	 */
+	set_current_state(mode); /* A */
 	if (!(wq_entry->flags & WQ_FLAG_WOKEN) && !is_kthread_should_stop())
 		timeout =3D schedule_timeout(timeout);
 	__set_current_state(TASK_RUNNING);
=20
 	/*
-	 * The below implies an smp_mb(), it too pairs with the smp_wmb() from
-	 * woken_wake_function() such that we must either observe the wait
-	 * condition being true _OR_ WQ_FLAG_WOKEN such that we will not miss
-	 * an event.
+	 * The below executes an smp_mb(), which matches with the smp_mb() (C)
+	 * in woken_wake_function() such that either we see the wait condition
+	 * being true or the store to wq_entry->flags in woken_wake_function()
+	 * follows ours in the coherence order.
 	 */
 	smp_store_mb(wq_entry->flags, wq_entry->flags & ~WQ_FLAG_WOKEN); /* B */
=20
@@ -430,14 +431,8 @@ EXPORT_SYMBOL(wait_woken);
=20
 int woken_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, =
int sync, void *key)
 {
-	/*
-	 * Although this function is called under waitqueue lock, LOCK
-	 * doesn't imply write barrier and the users expects write
-	 * barrier semantics on wakeup functions.  The following
-	 * smp_wmb() is equivalent to smp_wmb() in try_to_wake_up()
-	 * and is paired with smp_store_mb() in wait_woken().
-	 */
-	smp_wmb(); /* C */
+	/* Pairs with the smp_store_mb() in wait_woken(). */
+	smp_mb(); /* C */
 	wq_entry->flags |=3D WQ_FLAG_WOKEN;
=20
 	return default_wake_function(wq_entry, mode, sync, key);
--=20
2.17.1
