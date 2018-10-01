Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8976EC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A5320666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cZ5thSiX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A5320666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbeJAHQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:16:15 -0400
Received: from mail-by2nam03on0136.outbound.protection.outlook.com ([104.47.42.136]:2896
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729983AbeJAHQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwPIKI20Sc24cOhklHdJLkn2YVb1SoRGuNKWtQDQI24=;
 b=cZ5thSiX+H/yeXjzI0lyeeZ/pZ6NiZF6TW0pElDgvwMFfkyDXsmT+5flW4WvRdE5K5XuYl2qkEaeeYJT6nJCLFM1EyCSIak/EuicVPi3JkzhcIcKm0ZPfsoxCTyn74yA2coHS0o/paNLgqaZONyWjUuQo/lsMIt5Wjwoo72fUW8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.5; Mon, 1 Oct 2018 00:40:44 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:44 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Olaf Hering <olaf@aepfle.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 25/26] xen: avoid crash in disable_hotplug_cpu
Thread-Topic: [PATCH AUTOSEL 4.9 25/26] xen: avoid crash in
 disable_hotplug_cpu
Thread-Index: AQHUWR9jRvJlL8Zp/kijXZ/PhSjn3w==
Date:   Mon, 1 Oct 2018 00:40:44 +0000
Message-ID: <20181001004026.147201-25-alexander.levin@microsoft.com>
References: <20181001004026.147201-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004026.147201-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:eMAa/y7Q6IEB60EUREpR5GTbzfYTQvCUGaQfb/6bZhkSq4W1LjauB2lI5PoqlNOB3/riSGUdrEGwqSH5PKoQVcfac3b4c1vQgn/a41QaI+kL1zPy2FrB9oegTS+01/VXaV/dUXMtnNXpyaEg7XFtDrbXgaCwF7TfsBBMfoPwmc6SIgpcmy1eJ4HZw5VpeQJrTUEHZqW93N8miAMuq16tVlLT9COAg+UZT35Vn0oNqDaFcRAwyVGpiWc2bG/AiZ/12Zqnhw18sD6bDejrOeZZtxTLOtzFREmlArd70CmLACJGrd2ZNKDzkhFKagAbEn5dj8dGxQeEhmPxsdXk+GY/c+1eSSPfrPryP61iQe5a6/kclQ9l7Lo1bdjg2rU2jB0DrwPA9ULlE5712BskY/8FLWM1KprjBC8IOBNdKDT6lj77IllsvOVXDLhCKR4pepV4VqFEKDlu9I0bXo140uhR0w==;5:a6kQORGac7uTWSAmPqI7KVla99SSTER2YUGm9zRISfuwTWG5lJKp4ApLfAGqjFoDvSAay7n/K1k/LGzkmutTkWxnjUv+l+sbIzJpmZXypiKlQt+xW1g9gAdJjsAToJkVD2EJVcjAeDRkL2dnwv+QGnSZ3J7pTcDm7k+FyBJd9OU=;7:IavzOWDkKUTycnI4+1Xb5IgvPriORS4LkGWWcfczT2PMK53qPp74sOf2SG0SYxDJzW+s4Z79torkynOfi+X0QPwo5qu9JHPj1T7hhG4431JYa8QK3AkNT3wlCv/BQWWrupVDANyGjWdlbgvqVhLqVDr/yf4Iz7pnWzMh5A83LVaT65IwWEwvoViBRf+/TK24GvdHMYzsLC8Z1a+9bHbhlQ4qkOAQU9+JhTnWpNAAG7VsZj+HascurAhWOhPmsWh/
x-ms-office365-filtering-correlation-id: 7decdc46-dbc8-49d4-562e-08d6273685d4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB0165CFD96C0F697C2ED763A7FBEF0@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(476003)(2616005)(256004)(217873002)(486006)(6486002)(1076002)(11346002)(446003)(86362001)(97736004)(2900100001)(3846002)(6116002)(2501003)(110136005)(478600001)(54906003)(2906002)(5250100002)(6436002)(8936002)(316002)(53936002)(14444005)(81166006)(81156014)(68736007)(5660300001)(99286004)(8676002)(10290500003)(26005)(6346003)(4326008)(86612001)(6506007)(305945005)(106356001)(7736002)(76176011)(6512007)(72206003)(102836004)(25786009)(105586002)(107886003)(186003)(14454004)(71200400001)(34290500001)(71190400001)(22452003)(36756003)(66066001)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: cYjp4u0WEuGC5c7NsggOn0dYpTPEVcczIiZjMlLwq0ItjEbNBRdKD2/pluiKpxWLNZ6DCFJeHFr4KTU+8ZCawEuIlNcA5v3rJetJdyZHSIa9xDy3TMHgJ0ipRC/f+J5CgR/9Oy0vEGRRjGihRMRwl+n/qUBYraoTWEXPGMymDqWtKwoS6xl1nnCVwj0crPX7Qfc9H/Lgwtl98XDeYL+02lIZFs+oFpA/AQ7yopM0T+Qc+PQbAh2Z25dvs7KERzKDsdXC6qqr4y5fk8cvUW3s9vONra3oHvBDBfEZRZvS8yaLneujjHbNf22KTELszpEl+Yu/6HrKPS4i3XgvFR05XXKkcpukWdo7mD8OQKcLQqM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7decdc46-dbc8-49d4-562e-08d6273685d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:40:44.5295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
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
