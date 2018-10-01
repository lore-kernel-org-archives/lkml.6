Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B43C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA562083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Mw+52nyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA562083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbeJAHOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:14:49 -0400
Received: from mail-by2nam03on0120.outbound.protection.outlook.com ([104.47.42.120]:46043
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726604AbeJAHOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHCJyi6zW4RGTB4Bbj+9Goy95foR9Mt8NduAxPpOl1o=;
 b=Mw+52nykAAQZRNIHYLucl79SA4dc/trcxH6Wquie7SsdVdUJMEUR5IU6/mFRRfyHPiLWf3tHUMMKISm+U/C6eZO5c9QOEJxXBDyVrPKMxhmoeHFEu8+6L/0IiB4RwZOVDF9IVSUWWAmzqv//mj+iV5qayHNNt/u9yUWlDCYbbkI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0696.namprd21.prod.outlook.com (10.175.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 00:39:37 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:37 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Olaf Hering <olaf@aepfle.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 63/65] xen: avoid crash in disable_hotplug_cpu
Thread-Topic: [PATCH AUTOSEL 4.18 63/65] xen: avoid crash in
 disable_hotplug_cpu
Thread-Index: AQHUWR8aYUHyxCu1GEyoAuh1nfx0aQ==
Date:   Mon, 1 Oct 2018 00:38:42 +0000
Message-ID: <20181001003754.146961-63-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0696;6:IfzYTaEyaKC/Ix3Ktzs4Yzzmo2uZ2k5yKP4jqDvUprrdCdt1BgTp2lPqJIcmT5YP/XesXjqIKbcnznw4uCv48gI6f2xjASpX5/3RrbHxbWp7kjkgj8C6mopt3oXGWrXgdfLj5s6iY7Z4VkzslJPAkkgrCon+Ep7ulovcyH77r0MdzBE/5gTdi4D32ZJeiQNetXag97iVviyg+LyPEJFyIlbWJPZtru0uCjk9ybXKntndMDtLXBuuJOoEcyBvRnucpsJ/QD342KTwTk5FAGgw99ClMdn95T0eXJgtX/t9NdqUmqZN96ILE4oXsjrS2uDB0AM3riLX2lp6gDilm0qzjqVG7/A9EO3eIPO82A7tEeeJNAdSofhFnTWnfyVp71yNehFfCM6qPwHXyq+LHfXygtpPAXOx5VMFBfNFixERjggi+TAexFyiGk/ya0SXNFe+7loircLP9J2N9gUtlZARXw==;5:TLVnACnb2FikOv1lxLKIUjD29D29vY8laJkxxh1annq1Cb+gcoPXgjCtbye3EBbtByypa5Cb4hZs8bj4bHl0P3wAXUYRnLIEfahGCTluKz9RpmNJ7KR4HdT3RLEMpddUCTTReKfXzVY8KG8RY/rfSzm+18/8ojolkvMdhtZQCdc=;7:GaRJ4tVT0PMtXAHN5BJFHcoD2P8DP5c85dpXUQmVM6cnn+/d8A2W1qddCQ1uCabQDMbkAC+dBZ1w2x0ameRNmR21rJ5ANeIB9dQLJZmGqSGENLzPEnVAF1PLn9p1VkGJH+ucpLDIorvFVn+mmjSC2ljGW9P/fawBV2Qii514Vp7EkVNHCAslYgoidoadCht/fbErdOuYML5NmLLvIkkvuZzivCZLj2K8vwLMseDNd+M0JK8Eo4uYt1+QXiqyiqUI
x-ms-office365-filtering-correlation-id: d8fc9255-063a-471a-9d26-08d627365d8a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0696;
x-ms-traffictypediagnostic: CY4PR21MB0696:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB069649279917A9CA051B4398FBEF0@CY4PR21MB0696.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0696;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0696;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(199004)(3846002)(6116002)(5250100002)(71200400001)(97736004)(217873002)(71190400001)(1076002)(76176011)(6506007)(99286004)(11346002)(26005)(86362001)(36756003)(2501003)(446003)(2906002)(86612001)(102836004)(2616005)(476003)(14454004)(107886003)(10090500001)(14444005)(4326008)(34290500001)(316002)(486006)(22452003)(256004)(186003)(66066001)(53936002)(305945005)(25786009)(2900100001)(106356001)(6486002)(105586002)(7736002)(6512007)(81156014)(81166006)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(6436002)(10290500003)(72206003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0696;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yPJj6bt0Z7M8JQBDniva123wsfiYkjJK5tFsVrQqJgZQ2z/noPaHR/KMwC7x6qS9+dWByoYfI9QfAVWCFtbPv/KJc4bgc3IskoHUirgD0ACJKTlh+8h9EI1t1MwVW2mvb9sEbnpkkcOcl62W/L2eOrbu+wY+KX7Oipbv2o1dPuPuW5FI4hfKW0rfjL+eMw+Z3rrj9FJxk+u85tIkiu3GcdMc8uqwN026YTHUpj7aF2GDM4XPGdupJJod3zmeU4+Lyj2B19kZRKkF2rsGgwQ9bz6q6I52R9giqA6hiDc9VuVIGOQb6duumUNEHsOvPLJgpEZLMYNsJcSU++Ji+QMdoA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8fc9255-063a-471a-9d26-08d627365d8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:42.0821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0696
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
index d4265c8ebb22..b1357aa4bc55 100644
--- a/drivers/xen/cpu_hotplug.c
+++ b/drivers/xen/cpu_hotplug.c
@@ -19,15 +19,16 @@ static void enable_hotplug_cpu(int cpu)
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
