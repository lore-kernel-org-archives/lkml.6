Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519415519-2-9490540350796728829
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415518; b=ehgisJlofyIKzXheIbBhyNfQ6xV2l8sA3qihbC9h4n6Vj36
    DDu+TlwBskQSv7y1vtIib9e13KV48Kmc/q0RvJ0kes9N52Ey+v6hD4exQyOWmFqg
    sWYmuOXDS5CJGwW43NX/PbRCB0kN9/SFf7sk/LGd+TexUAbsS+eaUCNt21B4aHXg
    LXPkEtEDJzJOa/JlI8MpPsoSL8qAvoShmxm9lP8G32BvaYTK6/JCo7ScmOv7z8PG
    epMaTEF9Xq7T1N+WHGyfmeIHi71z8p7blc6ObfbbQhcC8GYiubCw3tPoDWRpk0XD
    mAE68S/ZSwIQuR4wXPu7GpoNxxXqZNgrNViehdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415518; bh=p/0Xk+aJUjgBIvn6wrVQ0MUhwz
    DX7/m0iJmhvgpeluA=; b=schGODhqQCRHvOv+v+uoWt/AoXzNmS4YOGu9SJtmw1
    +LQbohAra4WLb4lCDBeyGafnQLkhiC431KOaOIiKomZQ9WnQG4bkeeMtLZey3mpJ
    50ga3mlp5AD6HGIUCV4A5/ccwJ9qcs6I9f+zZTKiJFNF6kDor4UDC9i+P828I2PM
    /oY9V2j2ZwzoY9ZXgO9LXYGP54qtuqCiPvmcYgsZKu94Pk7Z1ap5SaTrzMHkG13I
    h0oe/2Mm9HDiOvC4OeP4A1W6etnEP+b7TmurQq2YBiY7Ci5AQv+wAC3jZXaHzsoy
    JHQ1al8OA9VOCWQRRS4j9WlO2O3lrEyQcCzXYc39cH+A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933869AbeBWSpw (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:45:52 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43468 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933587AbeBWSpu (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:45:50 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vincent Pelletier <plr.vincent@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 080/145] usb: dwc3: gadget: Wait longer for controller to end command processing
Date: Fri, 23 Feb 2018 19:26:26 +0100
Message-Id: <20180223170735.109309217@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vincent Pelletier <plr.vincent@gmail.com>


[ Upstream commit 8722e095f5a44d0e409e45c5ddc2ee9cf589c777 ]

DWC3_DEPCMD_ENDTRANSFER has been witnessed to require around 600 iterations
before controller would become idle again after unplugging the USB cable
with AIO reads submitted.
Bump timeout from 500 iterations to 1000 so dwc3_stop_active_transfer does
not receive -ETIMEDOUT and does not WARN:

[   81.326273] ------------[ cut here ]------------
[   81.335341] WARNING: CPU: 0 PID: 1874 at drivers/usb/dwc3/gadget.c:2627 dwc3_stop_active_transfer.constprop.23+0x69/0xc0 [dwc3]
[   81.347094] Modules linked in: usb_f_fs libcomposite configfs bnep btsdio bluetooth ecdh_generic brcmfmac brcmutil dwc3 intel_powerclamp coretemp ulpi kvm_intel udc_core kvm irqbypass crc32_pclmul crc32c_intel pcbc dwc3_pci aesni_intel aes_i586 crypto_simd cryptd ehci_pci ehci_hcd basincove_gpadc industrialio gpio_keys usbcore usb_common
[   81.378142] CPU: 0 PID: 1874 Comm: irq/34-dwc3 Not tainted 4.14.0-edison+ #119
[   81.385545] Hardware name: Intel Corporation Merrifield/BODEGA BAY, BIOS 542 2015.01.21:18.19.48
[   81.394548] task: f5b1be00 task.stack: f420a000
[   81.399219] EIP: dwc3_stop_active_transfer.constprop.23+0x69/0xc0 [dwc3]
[   81.406086] EFLAGS: 00010086 CPU: 0
[   81.409672] EAX: 0000001f EBX: f5729800 ECX: c132a2a2 EDX: 00000000
[   81.416096] ESI: f4054014 EDI: f41cf400 EBP: f420be10 ESP: f420bdf4
[   81.422521]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
[   81.428061] CR0: 80050033 CR2: b7a3f000 CR3: 01d94000 CR4: 001006d0
[   81.434483] Call Trace:
[   81.437063]  __dwc3_gadget_ep_disable+0xa3/0x2b0 [dwc3]
[   81.442438]  ? _raw_spin_lock_irqsave+0x32/0x40
[   81.447135]  dwc3_gadget_ep_disable+0xbf/0xe0 [dwc3]
[   81.452269]  usb_ep_disable+0x1c/0xd0 [udc_core]
[   81.457048]  ffs_func_eps_disable.isra.15+0x3b/0x90 [usb_f_fs]
[   81.463070]  ffs_func_set_alt+0x7d/0x310 [usb_f_fs]
[   81.468132]  ffs_func_disable+0x14/0x20 [usb_f_fs]
[   81.473075]  reset_config+0x5b/0x90 [libcomposite]
[   81.478023]  composite_disconnect+0x2b/0x50 [libcomposite]
[   81.483685]  dwc3_disconnect_gadget+0x39/0x50 [dwc3]
[   81.488808]  dwc3_gadget_disconnect_interrupt+0x21b/0x250 [dwc3]
[   81.495014]  dwc3_thread_interrupt+0x2a8/0xf70 [dwc3]
[   81.500219]  ? __schedule+0x78c/0x7e0
[   81.504027]  irq_thread_fn+0x18/0x30
[   81.507715]  ? irq_thread+0xb7/0x180
[   81.511400]  irq_thread+0x111/0x180
[   81.515000]  ? irq_finalize_oneshot+0xe0/0xe0
[   81.519490]  ? wake_threads_waitq+0x30/0x30
[   81.523806]  kthread+0x107/0x110
[   81.527131]  ? disable_percpu_irq+0x50/0x50
[   81.531439]  ? kthread_stop+0x150/0x150
[   81.535397]  ret_from_fork+0x19/0x24
[   81.539136] Code: 89 d8 c7 45 ec 00 00 00 00 c7 45 f0 00 00 00 00 c7 45 f4 00 00 00 00 e8 56 ef ff ff 85 c0 74 12 50 68 b9 1c 14 f8 e8 64 0f f7 c8 <0f> ff 58 5a 8d 76 00 8b 83 98 00 00 00 c6 83 a0 00 00 00 00 83
[   81.559295] ---[ end trace f3133eec81a473b8 ]---

Number of iterations measured on 4 consecutive unplugs:
[ 1088.799777] dwc3_send_gadget_ep_cmd(cmd=331016, params={0, 0, 0}) iterated 605 times
[ 1222.024986] dwc3_send_gadget_ep_cmd(cmd=331016, params={0, 0, 0}) iterated 580 times
[ 1317.590452] dwc3_send_gadget_ep_cmd(cmd=331016, params={0, 0, 0}) iterated 598 times
[ 1453.218314] dwc3_send_gadget_ep_cmd(cmd=331016, params={0, 0, 0}) iterated 594 times

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/gadget.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -247,7 +247,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_
 		struct dwc3_gadget_ep_cmd_params *params)
 {
 	struct dwc3		*dwc = dep->dwc;
-	u32			timeout = 500;
+	u32			timeout = 1000;
 	u32			reg;
 
 	int			cmd_status = 0;
