Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E01FC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D0720841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IFRHrSmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D0720841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeIBRTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:19:54 -0400
Received: from mail-sn1nam02on0123.outbound.protection.outlook.com ([104.47.36.123]:20160
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727356AbeIBRTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IckFpbbSJrShEeENY0plMXCDuc/Dk6wTXP53vv2kISk=;
 b=IFRHrSmIeMjUsv404nwRNRIVmtr0zp1etMMXp1aMi1y6GavfsKyoXCntipTkHHLE764fmTiGiEg7xzaKAEknG+7p4tcdFjIOp/BEDskCBPw1peTTXNxmjtj2DZwPnrG6lZfBamDMkHJDIyn5ZhSgp6T8wpv0GmIEt87VvDwXwH0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0135.namprd21.prod.outlook.com (10.173.189.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:07 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:07 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Xiubo Li <xiubli@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 033/131] uio: fix possible circular locking
 dependency
Thread-Topic: [PATCH AUTOSEL 4.18 033/131] uio: fix possible circular locking
 dependency
Thread-Index: AQHUQr1dbhYhSdlkXkulpIPu7YDwAw==
Date:   Sun, 2 Sep 2018 13:03:38 +0000
Message-ID: <20180902064601.183036-33-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0135;6:3t8tnUBwYP5IUCLPH4xAbNLmBzf6J/KFA9Z6ARe4byOgU+XVKN2ftXc2OPNnip3+jS7uJ+qLvAe92OeysKhDzecT0pwhh//eeZdiauV3hQT4MbNz5KMOyBGRKrW229k5EYurlOfqoXJ3V8Tw0gygocgD9DELs3VC5OB1WH3lvNX6SCv9U7l+cGItc8/twkeakoaISjdJHgqplCIZYcITm6Ut9Fmbt90m0JlabszJ0xuoG659b5KJVHSNYvTNdEuSKXqEz9RssS0KyoTe0hOQnnuPTAfQbNJQa2xtD18krjLllghWmyN3O59LrKTwuuoxQzhHoc7a28my61Hh8lzBi8/qJRzopWpd1AEOY5GjH/7bs1tHt0yJ6Y8ZohnNbbvWRehUrTJQVJbO4GfKT4KwEOvERC9O9STcueNKfgSsawEFJmPyH/xYKaYGuvMLbJQ+jUuKWejDlemV1bBlQ0QqOA==;5:N2WtjLdqg17JXoKVCFbyI0yz2vpJ49mqdSjB+VONZLy+IwYXsVthNpFT1yXFXmM9Y78UVXOZ54rX/rr0vXnfkP9b6hA10BtHEiJQDfP0s4GFLapS8ywuUttlEr435gxZI0APmnoLECfZUW0xKGjmV3ZmANpPG7DuX0TAVtIMAgM=;7:xZP3HoCiBsYkyBp+nPR1/1PJTT1DV9DEixy1kOD5LRPZSfn5bQe7+VDbSQGRFv+awRZ2Wm7dwrlNQXekpxfelHmJXY9otKF+jP9KcKpKEaVeJp+C8efCkj+hGUbuhdWusy4J8rvpMZ3UNWJpWBv+5mu8YZnhR7mQeCgGcg/4U+8kTCuZ66mdNj0jlbJTrw9NzIhzB6LangFdwEE+uX1yB+x3Gzsvh5vWpl2rLUwXui3LZi02aZr9ecTUX4C/ZI80
x-ms-office365-filtering-correlation-id: 7dcc258a-d67f-4c18-22b6-08d610d49162
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0135;
x-ms-traffictypediagnostic: CY4PR21MB0135:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0135EAE36C6E9BF89DCBF5B8FB0D0@CY4PR21MB0135.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0135;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0135;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(376002)(346002)(189003)(199004)(478600001)(76176011)(53936002)(2616005)(6512007)(476003)(446003)(11346002)(36756003)(486006)(106356001)(305945005)(6486002)(6436002)(97736004)(102836004)(6506007)(5250100002)(2906002)(14444005)(256004)(72206003)(2501003)(10290500003)(14454004)(86612001)(186003)(26005)(217873002)(99286004)(86362001)(2900100001)(575784001)(22452003)(81156014)(81166006)(10090500001)(316002)(107886003)(8676002)(105586002)(6116002)(8936002)(25786009)(4326008)(7736002)(5660300001)(6666003)(110136005)(54906003)(1076002)(68736007)(66066001)(3846002)(21314002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0135;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cIT6Ebf5m7y9DBHG4TX1fzs+HeSgyMwIwXI/BqgU9363NQ0dKFFloF3zAzVRAUQuGhJ8bU6LdRpBvFJKrsBAWVhctoLFlpz/xI9w3SM8asgU2hzO/ZRN64gqfqn7CuPDYO4iI0KUlbr/o9fVY+7z0Jox6Fa2xQDU3afZyZs5a+cevMYWmxFfIki4zN9eh1a9WJ9ZvTDKil/Csh3WCwtDCi4s7NYq3K4VVlpsb6evN2dmuKYDw1nirbVzckQt51vaA/HXmDkwjKCo7HQAKwQddn4uLpZkRB8TG6k5133NKCcCSy0wd7z/bnlBER7tH3ZomP11X56pKYWEIg4mRF+8zlvSe4jDVBubzU45DTKcYco=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dcc258a-d67f-4c18-22b6-08d610d49162
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:39.0566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

[ Upstream commit b34e9a15b37b8ddbf06a4da142b0c39c74211eb4 ]

The call trace:
XXX/1910 is trying to acquire lock:
 (&mm->mmap_sem){++++++}, at: [<ffffffff97008c87>] might_fault+0x57/0xb0

but task is already holding lock:
 (&idev->info_lock){+.+...}, at: [<ffffffffc0638a06>] uio_write+0x46/0x130 =
[uio]

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (&idev->info_lock){+.+...}:
       [<ffffffff96f31fc9>] lock_acquire+0x99/0x1e0
       [<ffffffff975edad3>] mutex_lock_nested+0x93/0x410
       [<ffffffffc063873d>] uio_mmap+0x2d/0x170 [uio]
       [<ffffffff97016b58>] mmap_region+0x428/0x650
       [<ffffffff97017138>] do_mmap+0x3b8/0x4e0
       [<ffffffff96ffaba3>] vm_mmap_pgoff+0xd3/0x120
       [<ffffffff97015261>] SyS_mmap_pgoff+0x1f1/0x270
       [<ffffffff96e387c2>] SyS_mmap+0x22/0x30
       [<ffffffff975ff315>] system_call_fastpath+0x1c/0x21

-> #0 (&mm->mmap_sem){++++++}:
       [<ffffffff96f30e9c>] __lock_acquire+0xdac/0x15f0
       [<ffffffff96f31fc9>] lock_acquire+0x99/0x1e0
       [<ffffffff97008cb4>] might_fault+0x84/0xb0
       [<ffffffffc0638a74>] uio_write+0xb4/0x130 [uio]
       [<ffffffff9706ffa3>] vfs_write+0xc3/0x1f0
       [<ffffffff97070e2a>] SyS_write+0x8a/0x100
       [<ffffffff975ff315>] system_call_fastpath+0x1c/0x21

other info that might help us debug this:
 Possible unsafe locking scenario:
       CPU0                    CPU1
       ----                    ----
  lock(&idev->info_lock);
                               lock(&mm->mmap_sem);
                               lock(&idev->info_lock);
  lock(&mm->mmap_sem);

 *** DEADLOCK ***
1 lock held by XXX/1910:
 #0:  (&idev->info_lock){+.+...}, at: [<ffffffffc0638a06>] uio_write+0x46/0=
x130 [uio]

stack backtrace:
CPU: 0 PID: 1910 Comm: XXX Kdump: loaded Not tainted #1
Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference=
 Platform, BIOS 6.00 05/19/2017
Call Trace:
 [<ffffffff975e9211>] dump_stack+0x19/0x1b
 [<ffffffff975e260a>] print_circular_bug+0x1f9/0x207
 [<ffffffff96f2f6a7>] check_prevs_add+0x957/0x960
 [<ffffffff96f30e9c>] __lock_acquire+0xdac/0x15f0
 [<ffffffff96f2fb19>] ? mark_held_locks+0xb9/0x140
 [<ffffffff96f31fc9>] lock_acquire+0x99/0x1e0
 [<ffffffff97008c87>] ? might_fault+0x57/0xb0
 [<ffffffff97008cb4>] might_fault+0x84/0xb0
 [<ffffffff97008c87>] ? might_fault+0x57/0xb0
 [<ffffffffc0638a74>] uio_write+0xb4/0x130 [uio]
 [<ffffffff9706ffa3>] vfs_write+0xc3/0x1f0
 [<ffffffff9709349c>] ? fget_light+0xfc/0x510
 [<ffffffff97070e2a>] SyS_write+0x8a/0x100
 [<ffffffff975ff315>] system_call_fastpath+0x1c/0x21

Signed-off-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/uio/uio.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index c8c76a0c6107..6c58ad1abd7e 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -622,6 +622,12 @@ static ssize_t uio_write(struct file *filep, const cha=
r __user *buf,
 	ssize_t retval;
 	s32 irq_on;
=20
+	if (count !=3D sizeof(s32))
+		return -EINVAL;
+
+	if (copy_from_user(&irq_on, buf, count))
+		return -EFAULT;
+
 	mutex_lock(&idev->info_lock);
 	if (!idev->info) {
 		retval =3D -EINVAL;
@@ -633,21 +639,11 @@ static ssize_t uio_write(struct file *filep, const ch=
ar __user *buf,
 		goto out;
 	}
=20
-	if (count !=3D sizeof(s32)) {
-		retval =3D -EINVAL;
-		goto out;
-	}
-
 	if (!idev->info->irqcontrol) {
 		retval =3D -ENOSYS;
 		goto out;
 	}
=20
-	if (copy_from_user(&irq_on, buf, count)) {
-		retval =3D -EFAULT;
-		goto out;
-	}
-
 	retval =3D idev->info->irqcontrol(idev->info, irq_on);
=20
 out:
--=20
2.17.1
