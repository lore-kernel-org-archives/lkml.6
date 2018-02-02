Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2948269-1517591811-2-12692496507279141461
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
    t=1517591810; b=HqyT0+gsBXPrlSOVRzfpb5F3J+tJYxtHVkGlwvvUnmWpIEf
    yZ64Blz5awcnXXanLU5rIWw1qlco0tKk90zOZDjZ5XgOU2ESk0+JFzYr9I2u5+uX
    G4h9hBjv0eqe3BBHk+PaKeVaL4mDF2WMPmCjeerBjw3OPBCdzZiIBT24nU5TNHMl
    +akX6p/jPZX6wrqLSnfPi357OalqhGKYw8um69/4srfqkdAKkP/ePR/CGA9Km2rb
    aBCRVNKSck35L4qDCLo/X8QkFli8py6Eau+3zx61uHidGObrb+ZpLw6Q/+TP26u8
    wCMoukQZNbQtLVIvp2F55vyr3xuhmQWtwx3vvew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591810; bh=PrbLBHEDIBQmUyggbfx31gQ3dn
    pi4Y2dJS96vr9W5bk=; b=G3nxyLPZUgyIW7EHZmc3oR/okyobLilWs4/AYL23Iv
    1n4YdsaPfphkCCc+6R04Dw6ZlEASCnWzAXZN+OfTmdXAgNy1VVNAggukoR3pnp71
    suQS6CuVSl1fws91CAG3n4LJkYQ7ytJKmmsoY0UbOb8VvnbJ2G4IfCn4G1HywDyd
    3n9XWOJwrnnPMDTwNflSP3+PGxANbHbRDqGANzvSd3ovqiDTpOV7Ix2qjg0QkT4Z
    zBP/q0OEOkuZpRQhqzkPjLQtfGQmcTK7wmqFLQ8pQPkrXPeLqrc0gzoinw8tjBQc
    i4h6/pwrwHogLBknKbntkK1L2Y+QBd6Fil7ycqS9859w==
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
        id S1753863AbeBBRQs (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:16:48 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41068 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753855AbeBBRQo (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:16:44 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Todd Fujinaka <todd.fujinaka@intel.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Subject: [PATCH 4.15 22/55] igb: Free IRQs when device is hotplugged
Date: Fri,  2 Feb 2018 17:58:40 +0100
Message-Id: <20180202140828.468736835@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
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

From: Lyude Paul <lyude@redhat.com>

commit 888f22931478a05bc81ceb7295c626e1292bf0ed upstream.

Recently I got a Caldigit TS3 Thunderbolt 3 dock, and noticed that upon
hotplugging my kernel would immediately crash due to igb:

[  680.825801] kernel BUG at drivers/pci/msi.c:352!
[  680.828388] invalid opcode: 0000 [#1] SMP
[  680.829194] Modules linked in: igb(O) thunderbolt i2c_algo_bit joydev vfat fat btusb btrtl btbcm btintel bluetooth ecdh_generic hp_wmi sparse_keymap rfkill wmi_bmof iTCO_wdt intel_rapl x86_pkg_temp_thermal coretemp crc32_pclmul snd_pcm rtsx_pci_ms mei_me snd_timer memstick snd pcspkr mei soundcore i2c_i801 tpm_tis psmouse shpchp wmi tpm_tis_core tpm video hp_wireless acpi_pad rtsx_pci_sdmmc mmc_core crc32c_intel serio_raw rtsx_pci mfd_core xhci_pci xhci_hcd i2c_hid i2c_core [last unloaded: igb]
[  680.831085] CPU: 1 PID: 78 Comm: kworker/u16:1 Tainted: G           O     4.15.0-rc3Lyude-Test+ #6
[  680.831596] Hardware name: HP HP ZBook Studio G4/826B, BIOS P71 Ver. 01.03 06/09/2017
[  680.832168] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
[  680.832687] RIP: 0010:free_msi_irqs+0x180/0x1b0
[  680.833271] RSP: 0018:ffffc9000030fbf0 EFLAGS: 00010286
[  680.833761] RAX: ffff8803405f9c00 RBX: ffff88033e3d2e40 RCX: 000000000000002c
[  680.834278] RDX: 0000000000000000 RSI: 00000000000000ac RDI: ffff880340be2178
[  680.834832] RBP: 0000000000000000 R08: ffff880340be1ff0 R09: ffff8803405f9c00
[  680.835342] R10: 0000000000000000 R11: 0000000000000040 R12: ffff88033d63a298
[  680.835822] R13: ffff88033d63a000 R14: 0000000000000060 R15: ffff880341959000
[  680.836332] FS:  0000000000000000(0000) GS:ffff88034f440000(0000) knlGS:0000000000000000
[  680.836817] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  680.837360] CR2: 000055e64044afdf CR3: 0000000001c09002 CR4: 00000000003606e0
[  680.837954] Call Trace:
[  680.838853]  pci_disable_msix+0xce/0xf0
[  680.839616]  igb_reset_interrupt_capability+0x5d/0x60 [igb]
[  680.840278]  igb_remove+0x9d/0x110 [igb]
[  680.840764]  pci_device_remove+0x36/0xb0
[  680.841279]  device_release_driver_internal+0x157/0x220
[  680.841739]  pci_stop_bus_device+0x7d/0xa0
[  680.842255]  pci_stop_bus_device+0x2b/0xa0
[  680.842722]  pci_stop_bus_device+0x3d/0xa0
[  680.843189]  pci_stop_and_remove_bus_device+0xe/0x20
[  680.843627]  trim_stale_devices+0xf3/0x140
[  680.844086]  trim_stale_devices+0x94/0x140
[  680.844532]  trim_stale_devices+0xa6/0x140
[  680.845031]  ? get_slot_status+0x90/0xc0
[  680.845536]  acpiphp_check_bridge.part.5+0xfe/0x140
[  680.846021]  acpiphp_hotplug_notify+0x175/0x200
[  680.846581]  ? free_bridge+0x100/0x100
[  680.847113]  acpi_device_hotplug+0x8a/0x490
[  680.847535]  acpi_hotplug_work_fn+0x1a/0x30
[  680.848076]  process_one_work+0x182/0x3a0
[  680.848543]  worker_thread+0x2e/0x380
[  680.848963]  ? process_one_work+0x3a0/0x3a0
[  680.849373]  kthread+0x111/0x130
[  680.849776]  ? kthread_create_worker_on_cpu+0x50/0x50
[  680.850188]  ret_from_fork+0x1f/0x30
[  680.850601] Code: 43 14 85 c0 0f 84 d5 fe ff ff 31 ed eb 0f 83 c5 01 39 6b 14 0f 86 c5 fe ff ff 8b 7b 10 01 ef e8 b7 e4 d2 ff 48 83 78 70 00 74 e3 <0f> 0b 49 8d b5 a0 00 00 00 e8 62 6f d3 ff e9 c7 fe ff ff 48 8b
[  680.851497] RIP: free_msi_irqs+0x180/0x1b0 RSP: ffffc9000030fbf0

As it turns out, normally the freeing of IRQs that would fix this is called
inside of the scope of __igb_close(). However, since the device is
already gone by the point we try to unregister the netdevice from the
driver due to a hotplug we end up seeing that the netif isn't present
and thus, forget to free any of the device IRQs.

So: make sure that if we're in the process of dismantling the netdev, we
always allow __igb_close() to be called so that IRQs may be freed
normally. Additionally, only allow igb_close() to be called from
__igb_close() if it hasn't already been called for the given adapter.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 9474933caf21 ("igb: close/suspend race in netif_device_detach")
Cc: Todd Fujinaka <todd.fujinaka@intel.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/intel/igb/igb_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3676,7 +3676,7 @@ static int __igb_close(struct net_device
 
 int igb_close(struct net_device *netdev)
 {
-	if (netif_device_present(netdev))
+	if (netif_device_present(netdev) || netdev->dismantle)
 		return __igb_close(netdev, false);
 	return 0;
 }
