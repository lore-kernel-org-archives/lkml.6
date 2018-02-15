Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1883814-1518710431-2-16582274422130848610
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518710431; b=bieY02tfCwbu8AjZt24UgfM7pIAyKpEpoliJ9Esly6UZ6iu
    Hy2jziPioqyjbIUXtu8NR6+DM7qF8Gv0T5dEamwxWs6iLLzr8KAlXqC8kwkqHV/2
    5GCZRAKKqj8vPrGewzzaa5PhlaRMYzJK2lwlvh8PBDma5t20k1ddc+ZEE7ebPzXA
    /VoJN5chPYywBA7C24MopFSsg69UmMf8hUZ7GH88ZC2Z9MQodFMQZmS0UzeEMYwZ
    nWawQQX0QWyz7R384tYZ66IaY+Rukb0ELQtA29yzHW3B7c8uz6jVIbFznzHDlgy8
    7mwjNrT5RxO250xL5w7L5VHct+7mFgL3vLKjMjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710431; bh=ihLKjkrMxtR+0faU3QwP2HLQ/X
    BntOc5KqS1Ju/RsM8=; b=sCSXOBr/GWMxGgFzJFY3bJwDdC2a7zeCg/BB+32G6r
    shZdCQhvjRVHFeF9Tm4PQqYJLMDVl/2HvQHPHJ0NZeYpUTTV+QGeousJTqLztP22
    nU6WOsHFG7/sGMAqd2QK2IpKHdMXG0k4s3q2j0IKpG1L/uaOkUHftvtiYyQghP0A
    XMmwYsAfC4lCKW6Cloea7GEskaIEZsHpJwo4yHwOvE/s7ueXxIqycUod98rkom1C
    /V7Kd7lNuU3Ll2crbDMOX0R+xXTls6pa0HBPkTQ7QFjSSnHD3IdSDF2uvWjPthtY
    yAGSfLJ/qvhAucloPwgRDfxjSigM/xmzrpqFKdKlpMcQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424803AbeBOPrA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:47:00 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35996 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424796AbeBOPq7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:46:59 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 4.15 165/202] ipmi: use dynamic memory for DMI driver override
Date: Thu, 15 Feb 2018 16:17:45 +0100
Message-Id: <20180215151721.500079240@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Garry <john.garry@huawei.com>

commit 5516e21a1e95e9b9f39985598431a25477d91643 upstream.

Currently a crash can be seen if we reach the "err"
label in dmi_add_platform_ipmi(), calling
platform_device_put(), like here:
[    7.270584]  (null): ipmi:dmi: Unable to add resources: -16
[    7.330229] ------------[ cut here ]------------
[    7.334889] kernel BUG at mm/slub.c:3894!
[    7.338936] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[    7.344475] Modules linked in:
[    7.347556] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.15.0-rc2-00004-gbe9cb7b-dirty #114
[    7.355907] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 IT17 Nemo 2.0 RC0 11/29/2017
[    7.365137] task: 00000000c211f6d3 task.stack: 00000000f276e9af
[    7.371116] pstate: 60000005 (nZCv daif -PAN -UAO)
[    7.375957] pc : kfree+0x194/0x1b4
[    7.379389] lr : platform_device_release+0xcc/0xd8
[    7.384225] sp : ffff0000092dba90
[    7.387567] x29: ffff0000092dba90 x28: ffff000008a83000
[    7.392933] x27: ffff0000092dbc10 x26: 00000000000000e6
[    7.398297] x25: 0000000000000003 x24: ffff0000085b51e8
[    7.403662] x23: 0000000000000100 x22: ffff7e0000234cc0
[    7.409027] x21: ffff000008af3660 x20: ffff8017d21acc10
[    7.414392] x19: ffff8017d21acc00 x18: 0000000000000002
[    7.419757] x17: 0000000000000001 x16: 0000000000000008
[    7.425121] x15: 0000000000000001 x14: 6666666678303d65
[    7.430486] x13: 6469727265766f5f x12: 7265766972642e76
[    7.435850] x11: 6564703e2d617020 x10: 6530326435373638
[    7.441215] x9 : 3030303030303030 x8 : 3d76656420657361
[    7.446580] x7 : ffff000008f59df8 x6 : ffff8017fbe0ea50
[    7.451945] x5 : 0000000000000000 x4 : 0000000000000000
[    7.457309] x3 : ffffffffffffffff x2 : 0000000000000000
[    7.462674] x1 : 0fffc00000000800 x0 : ffff7e0000234ce0
[    7.468039] Process swapper/0 (pid: 1, stack limit = 0x00000000f276e9af)
[    7.474809] Call trace:
[    7.477272]  kfree+0x194/0x1b4
[    7.480351]  platform_device_release+0xcc/0xd8
[    7.484837]  device_release+0x34/0x90
[    7.488531]  kobject_put+0x70/0xcc
[    7.491961]  put_device+0x14/0x1c
[    7.495304]  platform_device_put+0x14/0x1c
[    7.499439]  dmi_add_platform_ipmi+0x348/0x3ac
[    7.503923]  scan_for_dmi_ipmi+0xfc/0x10c
[    7.507970]  do_one_initcall+0x38/0x124
[    7.511840]  kernel_init_freeable+0x188/0x228
[    7.516238]  kernel_init+0x10/0x100
[    7.519756]  ret_from_fork+0x10/0x18
[    7.523362] Code: f94002c0 37780080 f94012c0 37000040 (d4210000)
[    7.529552] ---[ end trace 11750e4787deef9e ]---
[    7.534228] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    7.534228]

This is because when the device is released in
platform_device_release(), we try to free
pdev.driver_override. This is a const string, hence
the crash.
Fix by using dynamic memory for pdev->driver_override.

Signed-off-by: John Garry <john.garry@huawei.com>
[Removed the free of driver_override from ipmi_si_remove_by_dev().  The
 free is done in platform_device_release(), and would result in a double
 free, and ipmi_si_remove_by_dev() is called by non-platform devices.]
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/ipmi/ipmi_dmi.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/char/ipmi/ipmi_dmi.c
+++ b/drivers/char/ipmi/ipmi_dmi.c
@@ -106,7 +106,10 @@ static void __init dmi_add_platform_ipmi
 		pr_err("ipmi:dmi: Error allocation IPMI platform device\n");
 		return;
 	}
-	pdev->driver_override = override;
+	pdev->driver_override = kasprintf(GFP_KERNEL, "%s",
+					  override);
+	if (!pdev->driver_override)
+		goto err;
 
 	if (type == IPMI_DMI_TYPE_SSIF) {
 		set_prop_entry(p[pidx++], "i2c-addr", u16, base_addr);
