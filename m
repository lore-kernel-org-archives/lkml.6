Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C76BECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A596720866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Z9VT3cFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A596720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbeIOGtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:49:47 -0400
Received: from mail-co1nam03on0116.outbound.protection.outlook.com ([104.47.40.116]:27616
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728318AbeIOGto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhK/wJEI6DKU9mLwsschFfwCUDCoFB5jX1bIujtg7RA=;
 b=Z9VT3cFFSMscOWR7A8AM7ZMOGjjMLV2QyiptYIVcSzq644vG8aaBY3OA2geskWrEQyF9MGdybBqRVL2u36HTKqFy051AhMjllirGHN/Sy3sIp1X5ebhoj0NzLiQhGgTuZt0t8KPTg6XFXbqhT8i777IgEffkLNN1jdr7QAcFQr0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:32:40 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:32:40 +0000
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
Subject: [PATCH AUTOSEL 4.14 17/57] sched/core: Use smp_mb() in
 wake_woken_function()
Thread-Topic: [PATCH AUTOSEL 4.14 17/57] sched/core: Use smp_mb() in
 wake_woken_function()
Thread-Index: AQHUTJP9yfhUpeJ4+kGPIGvWoIct0A==
Date:   Sat, 15 Sep 2018 01:32:40 +0000
Message-ID: <20180915013223.179909-17-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:ueTiukGtGMcbLWF9XLUBLWK1eCtSjFcKLe//HRUKik4mGwNpN0F+AXDpvPYEQWln729G2LTglTiwtyA6zIBENjfB/zZeJBL6SkMZVJqBIj73cyiYOLj5dj21PgsRaCn5cZa7Y5p6kwqjobXsLdJgnbcXjlgPFRRcyRZxe0ZrBJ4+QoNrpyctMAT1+h821vl2zIJTlbQKP6+MS9fjb2k6mOq5cjc0KW+5qw9YtkuPfTQ9JJ7wwsBEttEbci6xiaCliqs2+BkjazJwVwPTo6IVRf9VAwt4LZSfp52l3YKvla0gZKQnZkMM2LovInMxFJXKJhnqSpNnox9f1T7op+OjUBLo7hCRjY4BZlnfXkoDm0lUmfKRcNwxa0c0IISXFjIK+/Hb2OtUIs1neAdBbC8GiJBfA4j+JTubj2Y7h9A2URqw4VUhLolAPLgxZjdlMMN8WvPHk0pr4qqBfa4OR8HYMg==;5:mpmkFWU4AKhtquUfpz8SfAiiAIjlNztUP3MgnZV1dksNoWCm+axFKPw03ytWsb8kNjNOdHHP5zEJMbieac1AMrq+nOLtY4RCdvVbEnMHDqLKFyv8oiA3m+0+zypUYWzPrYqSGSzp8iNyhIYwFdTySpqzVWASwIoR9xoh4zbRcwI=;7:BzGPUx9LkxzoL7pgiHsDHluZbPyRxzRUyW1OhiG28+5S8IgOnmPGMZoKMvNYdJS40ZRSOE94XQ7S00hUpKzXBYKXkP5IsjffadKsqArQmz10h9sIP68NAbZk294ahclrN1u0iAHGemM9YmUz61kfFQSvYtNKB/LnZzGZpNm3PvYDwGXDjTUSSfJau+pL3GE3PSgS6giY/DuGsRPiQ4mwCttqIzc5zICAB4LilPR7C/t7uoPVKxl7TQLu+w+hDn3V
x-ms-office365-filtering-correlation-id: 752fb648-56f1-4931-5fc4-08d61aab206f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08226E21D023FB23E6A2D3E1FB180@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(190756311086443)(180628864354917)(89211679590171)(9452136761055)(85827821059158)(35762410373642)(42068640409301)(57025502571588)(151975744463004);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(1076002)(966005)(72206003)(6506007)(102836004)(478600001)(8936002)(10290500003)(2906002)(81166006)(81156014)(5660300001)(22452003)(2900100001)(39060400002)(8676002)(110136005)(54906003)(107886003)(99286004)(25786009)(4326008)(316002)(10090500001)(97736004)(305945005)(7736002)(7416002)(6116002)(3846002)(256004)(14444005)(66066001)(76176011)(217873002)(6436002)(14454004)(36756003)(476003)(86612001)(6512007)(26005)(6306002)(5250100002)(53936002)(486006)(106356001)(11346002)(2616005)(6486002)(86362001)(446003)(186003)(105586002)(2501003)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ytJYsDrD6SWz7wOBkfzCrCQ/qTvm/iznogTUkptJ5qqpDXt9V8G4HOH5sXZ4rSpg75ombYVKYRVFDffbkk1wp7RsUvrzvuvk7YaYdHQkGQyBYsUGMfsa0BLgGp6FnUszbHOAcLfutt5t7+YiUdooIMwY9tfLED9jKYUWgqRbP38UUICt5dtNzIilVFx1Kd2wd6ZV9MpJu5AaA9mA2JO3SeyqMyLmVSaCM+DRyM5qE+kymIh1VjZPXCXR6OSms36HPW9HACu0ipiHgoFEPWr0Roe/1iQiZo2DnM8v5Ou/XCiA4NJ4k5wfN15TO2HLWc9t+bxqrQ0llUpFW5hm7D7joSR+rpThII4/ezxrA47KtDs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 752fb648-56f1-4931-5fc4-08d61aab206f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:40.4153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
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
index 929ecb7d6b78..e29608464382 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -395,35 +395,36 @@ static inline bool is_kthread_should_stop(void)
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
@@ -433,14 +434,8 @@ EXPORT_SYMBOL(wait_woken);
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
