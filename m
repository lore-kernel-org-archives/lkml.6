Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D94DC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278DC20666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="i2GXdvrG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 278DC20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbeJAHSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:18:41 -0400
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:26608
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730083AbeJAHQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwPIKI20Sc24cOhklHdJLkn2YVb1SoRGuNKWtQDQI24=;
 b=i2GXdvrGiIoxjmnYDiDdPDUvbFaoFAwehz3PR9oRi83jd9f2Fb4rInXK6nL/3VvDNwNiSmcZPBz796Sxus1pH70zLb+Fm4QolDkLTa0CI4Cf2jVjgTPuk+xa7cFhD2WkPrmuDf+7vfZ44VRLD0DdjL9QbOFXfdkFYQnXWvoNMg8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0791.namprd21.prod.outlook.com (10.175.121.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:41:34 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:41:34 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Olaf Hering <olaf@aepfle.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 16/17] xen: avoid crash in disable_hotplug_cpu
Thread-Topic: [PATCH AUTOSEL 4.4 16/17] xen: avoid crash in
 disable_hotplug_cpu
Thread-Index: AQHUWR+AN47QJUsPmEaJP3sqnt9ZQA==
Date:   Mon, 1 Oct 2018 00:41:34 +0000
Message-ID: <20181001004122.147276-16-alexander.levin@microsoft.com>
References: <20181001004122.147276-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004122.147276-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0791;6:t1nUr+Xm4yAioSb7hYcpT2eiqYcsq6auWEOLEPjC0kVJnvwJwCseugqC6VOxnVOYn0CEU/cZSIR2d7FuaU+7q7CxVaX4gzAaaQ9fuPyWMp7S3UgN06/PkiDcAyLjTiuQopzwldHMUiLaDznvaDMsaSwihjrSnLFRoFrswRwxSuXx4Ch4T/bhEiMyDbbhw9NJjbn43uii049VYQcmBfwSciwEQ6HJsEo0s7IVVdT7MvYzP4FOTMGdn9Qx5d0hFEnZqd83MDvBIi65oRCeQyVe2aTdMXXVegrQVnsm24VNMpSeKHuZ08fiS4NsWclEzq1CRFW+Ou7F1/W3R9cGMSVj/mIpD4u1pK6meP53HeFaV7aVcfFSNd8j2h4ioAIUEp41U0+FeSr50funewswWJCtDz59DXWnNEIaYugu/k3FUrdR8ChUKLferjO48Z+HzRq88blfmBe3tuldiMkN2wHPIA==;5:L2g2aUinErAgy1A5PdGzM4yfpclK524lsDvYh+IWeMyMPZFX9X+BE7X16rTHGFsG7osbSAjAtvJGwClVpaD1J3h7rapsLTtBYkDAcUaaco7vky2G5BYzcINfp8+Yv/b4dYWIQhNkNYZFo0qPhRb9+lDflVWS6j1n9BW4UF9ymII=;7:BI69e7hTA4v1LSk5qsdXG9ft3bLDlC4SNWPLkmoZExDzh8fTFHO1oRIv2zQgLeqZSAXkhP6ybePT8cVY181uMF4jr3IBMhLE9uta6f1hYAEen+4Km4cAtWPRkM9PPm7Hq4/rtilXMnGM4JJA7cuuWpW/GPlSRz5oaqYXmA7kOkJ7T4EInvZBe9VIBxYxhdimRmlAIWxsfkXnlD+X0mzwFAnk3oILIDm1UIJENigjilD1/jQJgPGbeCQi9eazNX0y
x-ms-office365-filtering-correlation-id: d39c5306-672a-4be2-6d80-08d62736a372
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0791;
x-ms-traffictypediagnostic: CY4PR21MB0791:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB079158F1CAD1B59E8F6D2786FBEF0@CY4PR21MB0791.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0791;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0791;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(366004)(376002)(39860400002)(189003)(199004)(72206003)(71190400001)(478600001)(316002)(110136005)(14454004)(2616005)(54906003)(105586002)(107886003)(106356001)(186003)(305945005)(26005)(34290500001)(71200400001)(22452003)(7736002)(256004)(14444005)(25786009)(10290500003)(99286004)(68736007)(53936002)(486006)(6512007)(446003)(66066001)(36756003)(6506007)(81166006)(81156014)(6486002)(5250100002)(86362001)(2501003)(5660300001)(4326008)(11346002)(6116002)(476003)(3846002)(10090500001)(97736004)(1076002)(8676002)(8936002)(102836004)(217873002)(6436002)(76176011)(86612001)(2900100001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0791;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Gw+4IvNOY9xZYaKONtPysO/9UUEeoibI2YauIve/NHwR34Qn00KHDHNkNWc+x/xc9r6hotP5lZDyJckmunJ03Y1EyES1QcoVUuE7hqGeJjMOUO+htbZzUw5wlRtiSNw9QL7ypIE7YOi1DC1c/3JPOnb7hoNIoXncRwUYaOc2n+zBY/IwJCc/coMd3x83gsi5/jJ/Kss1EXnAXcXyrogTK4ekNzNRevoQGHKuZyzXM9Ic9MXcRLtFz/tkzZSwKyffQpwu16D4aVY3Z/p8SFiDyWvOt5UA1X7gefmXyg5nooS9ATq2NCoqarvdDPv5iU4w7Nz3MiFc9LwnuL35pp5ArHdCCHB8GYRnuD5W1qBHR7w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39c5306-672a-4be2-6d80-08d62736a372
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:41:34.2425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0791
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olaf Hering <olaf@aepfle.de>

[ Upstream commit 3366cdb6d350d95466ee430ac50f3c8415ca8f46 ]

The command 'xl vcpu-set 0 0', issued in dom0, will crash dom0:

BUG: unable to handle kernel NULL pointer dereference at 00000000000002d8
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 7 PID: 65 Comm: xenwatch Not tainted 4.19.0-rc2-1.ga9462db-default #1 =
openSUSE Tumbleweed (unreleased)
Hardware name: Intel Corporation S5520UR/S5520UR, BIOS S5500.86B.01.00.0050=
.050620101605 05/06/2010
RIP: e030:device_offline+0x9/0xb0
Code: 77 24 00 e9 ce fe ff ff 48 8b 13 e9 68 ff ff ff 48 8b 13 e9 29 ff ff =
ff 48 8b 13 e9 ea fe ff ff 90 66 66 66 66 90 41 54 55 53 <f6> 87 d8 02 00 0=
0 01 0f 85 88 00 00 00 48 c7 c2 20 09 60 81 31 f6
RSP: e02b:ffffc90040f27e80 EFLAGS: 00010203
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8801f3800000 RSI: ffffc90040f27e70 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff820e47b3 R09: 0000000000000000
R10: 0000000000007ff0 R11: 0000000000000000 R12: ffffffff822e6d30
R13: dead000000000200 R14: dead000000000100 R15: ffffffff8158b4e0
FS:  00007ffa595158c0(0000) GS:ffff8801f39c0000(0000) knlGS:000000000000000=
0
CS:  e033 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000002d8 CR3: 00000001d9602000 CR4: 0000000000002660
Call Trace:
 handle_vcpu_hotplug_event+0xb5/0xc0
 xenwatch_thread+0x80/0x140
 ? wait_woken+0x80/0x80
 kthread+0x112/0x130
 ? kthread_create_worker_on_cpu+0x40/0x40
 ret_from_fork+0x3a/0x50

This happens because handle_vcpu_hotplug_event is called twice. In the
first iteration cpu_present is still true, in the second iteration
cpu_present is false which causes get_cpu_device to return NULL.
In case of cpu#0, cpu_online is apparently always true.

Fix this crash by checking if the cpu can be hotplugged, which is false
for a cpu that was just removed.

Also check if the cpu was actually offlined by device_remove, otherwise
leave the cpu_present state as it is.

Rearrange to code to do all work with device_hotplug_lock held.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/xen/cpu_hotplug.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/xen/cpu_hotplug.c b/drivers/xen/cpu_hotplug.c
index 5676aefdf2bc..f4e59c445964 100644
--- a/drivers/xen/cpu_hotplug.c
+++ b/drivers/xen/cpu_hotplug.c
@@ -18,15 +18,16 @@ static void enable_hotplug_cpu(int cpu)
=20
 static void disable_hotplug_cpu(int cpu)
 {
-	if (cpu_online(cpu)) {
-		lock_device_hotplug();
+	if (!cpu_is_hotpluggable(cpu))
+		return;
+	lock_device_hotplug();
+	if (cpu_online(cpu))
 		device_offline(get_cpu_device(cpu));
-		unlock_device_hotplug();
-	}
-	if (cpu_present(cpu))
+	if (!cpu_online(cpu) && cpu_present(cpu)) {
 		xen_arch_unregister_cpu(cpu);
-
-	set_cpu_present(cpu, false);
+		set_cpu_present(cpu, false);
+	}
+	unlock_device_hotplug();
 }
=20
 static int vcpu_online(unsigned int cpu)
--=20
2.17.1
