Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5958ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFBC21477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VFkaXQyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CFBC21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbeIOGsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:48:05 -0400
Received: from mail-cys01nam02on0123.outbound.protection.outlook.com ([104.47.37.123]:39088
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726216AbeIOGsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHBJB7WHeIUPgb2pxzBz0KFtSz5Uo73m3jnRjLsGat0=;
 b=VFkaXQyTsqHmVOypXfw5EtvukkjDYY2vg6EdkuKDpzsZ8r6dbGXs8Bfk0zMohg4XtNgtOEaNABOIaW1tIEUTLZNenkbDo93KHs2HXkw9GQQr1mKIZbLW7oHMEd4wcxie0pWokvmu60wdGnAWWPKYkUeSB0RPD2vMq9A1uUJPzQs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:30:59 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:59 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 61/92] rcutorture: Use monotonic timestamp for
 stall detection
Thread-Topic: [PATCH AUTOSEL 4.18 61/92] rcutorture: Use monotonic timestamp
 for stall detection
Thread-Index: AQHUTJOxPbaLDJQmX0y3RNAUxl+7kw==
Date:   Sat, 15 Sep 2018 01:30:32 +0000
Message-ID: <20180915012944.179481-60-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:DAIG7fRoHRLtVebqVGliTKaz8F6wlIShkG+qS6F2V9Gfi/J7v1R2t3aGfRn1xLWOfGNfESxR/eLx/GNVwImHEWyJlAHeASubsPRH6Ce412vkNrW6aQ4pSF4z22OKzJ/x/khh20IfzeSxhEGKkUqqK3tKURpVlc97jlLpB2F1YbBltX1LtqJZlfedhJZ2ec1dnMHkyF0yKnT01+6fSEf/9qg/07WskRF2kSMbFDIG36GSHRqYr/8mAXpDiyTIIhhlOdNBcAepg96iauD7JZfDuXiULo6mampgwK85Yg8Elbkls/3Z3kvzhI+VClaCkR9imQ7j5vmSpo7FX+Dp65qURPXG8JWgfkFEcTpnII6/OpJrXK+3UV2QpScDPO0p4I3T5mYe8kfZdC+1LAzqfXlTHX+OK8L/d5ZlDz8WAOw5HCG22qOLgNpuRnoa/fDYTOGB5PzInS9Vt29sBwdYTcrcvQ==;5:kUGfFP6Vc7fB8TezP3dVIGEs0USRYymCJgCTP88O1xKV8KTjTxbkDyV8futYYcqHgnEhlpYmpW02EP98/nithYD2P3yxXnIdmsBtbN/TT13bp6bsQNmcH8J9XgiWptzhpHZjD+ib8ykjjFHXn5btr2Oq+vZCbSRz6jLyCL4xwrQ=;7:PUQoLvVXaL0vnQVAYts61ToEv79fIyEBB/oPkh/TSJk6IiJGubfC6CqcU4EL+dI83T7eweVM4xLRoBhhnHk6BcMOD1ok1YDWsp0T/D4vH1TptGsXm9xnU8Gqsu4B//WqEBl44GMParmsrSZOVZtEjum/siMEDKxSXqh4IlMh0LrhLXYgGKLGBJooloRBS5ty4fnQraVvrG3OljYSpOMk+L9jE3LyLvSjwTUA80+tYDKAnIlYeG91kI/jW2UBv6uo
x-ms-office365-filtering-correlation-id: da7f37a8-6220-4517-cce9-08d61aaae477
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
x-microsoft-antispam-prvs: <CY4PR21MB074144DF3B4A7D75F1A8988BFB180@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(376002)(396003)(346002)(189003)(199004)(186003)(106356001)(25786009)(6346003)(6486002)(6436002)(476003)(102836004)(11346002)(5660300001)(2616005)(26005)(217873002)(105586002)(486006)(446003)(4326008)(53936002)(5250100002)(14454004)(10090500001)(14444005)(2900100001)(256004)(6666003)(2501003)(10290500003)(6512007)(22452003)(72206003)(8676002)(478600001)(110136005)(97736004)(68736007)(66066001)(81156014)(81166006)(2906002)(99286004)(86362001)(86612001)(6506007)(76176011)(8936002)(6116002)(3846002)(1076002)(54906003)(305945005)(36756003)(7736002)(316002)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: JrH3tDxvr8K+KzQV/fPQCJO39kPSUFDjgcdKTof0iqPf47cgov5cE0jHkcFB8LXzVErYW3oeT3dpJSma2bKnXCJYjv63vxXVXdgbpJd7n1uD6sC2OwFESHp64/1id1PXexZ5abKdg/7a/TerRxR0/ytpR+awNNbBugjxbxrDUcGUZtxClQFM+wjFLDhFi7o1v4Ln8fK7LE60y61zVUuRfUESXkCXDPqbrhtteN2FtVFOLQP0UDbITnB1zKXjfsAewI5sVrST9Y+qW5wGs+BoczvmYqZz+snNUtFopwea679a9ucNA7xioCoUvrP1EncZOESKWKtRtK6m9cibP8VBXyU2CT5VUyWfcAuXcKBCXWQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da7f37a8-6220-4517-cce9-08d61aaae477
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:32.1980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 622be33fcbc93e9b672b99ed338369eb5e843ac3 ]

The get_seconds() call is deprecated because it overflows on 32-bit
architectures. The algorithm in rcu_torture_stall() can deal with
the overflow, but another problem here is that using a CLOCK_REALTIME
stamp can lead to a false-positive stall warning when a settimeofday()
happens concurrently.

Using ktime_get_seconds() instead avoids those issues and will never
overflow. The added cast to 'unsigned long' however is necessary to
make ULONG_CMP_LT() work correctly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/rcu/rcutorture.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 42fcb7f05fac..f42cf69ef539 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1446,7 +1446,7 @@ static int rcu_torture_stall(void *args)
 		VERBOSE_TOROUT_STRING("rcu_torture_stall end holdoff");
 	}
 	if (!kthread_should_stop()) {
-		stop_at =3D get_seconds() + stall_cpu;
+		stop_at =3D ktime_get_seconds() + stall_cpu;
 		/* RCU CPU stall is expected behavior in following code. */
 		rcu_read_lock();
 		if (stall_cpu_irqsoff)
@@ -1455,7 +1455,8 @@ static int rcu_torture_stall(void *args)
 			preempt_disable();
 		pr_alert("rcu_torture_stall start on CPU %d.\n",
 			 smp_processor_id());
-		while (ULONG_CMP_LT(get_seconds(), stop_at))
+		while (ULONG_CMP_LT((unsigned long)ktime_get_seconds(),
+				    stop_at))
 			continue;  /* Induce RCU CPU stall warning. */
 		if (stall_cpu_irqsoff)
 			local_irq_enable();
--=20
2.17.1
