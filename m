Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1414047-1519989565-2-13948458512304647066
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519989564; b=wm4cuxtjI2coveQbHuZeMVlDQoDBqNFWzXfSYc6IV0mqRzJ
    E4WZN5GYtaTYhzvb1okTcelhAtJxFdDRPV3pfOE0nIDA35PQAKAldGzSgfnZC5mG
    bwMcgqPo6YXXwegqAxzK1M+pH48wMhA0a4zQow+jXt4IU17wQRsvn9GZAfbbaTN9
    8imETY49YaAcUoGBFRFSAuQEXoTzfiDNDLFKCdtpUbUpFh+fkkXn0A51QP5pJ4/U
    SpYm7zcp+5zJJ/8dwOOuJZx3md6NzK9MU+cFG5XOPlZEsaLWy/OwflXsYzACM24E
    DhjID4UPub3VjdIGmKsPinMxOPJAFywU2LIi0KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519989564; bh=KoB/3IXzpkIFBg3YF7gvWdcAC7
    spqFi1Zkft1ydW7so=; b=XJQwmd+qWCjX1t2KKxbmzULWvYEHAZs2w9R/Re1gtW
    Ol2ZCPnyc6ojc2FWYGhVLRkcLoHB1GrrPulzt+actKwXVikn68AytB91eT2tjuMM
    msV3Kk3EpwNM+p3Z5ybIGBQq74S8GKkavKTWeEDyGLHiKOZWU9D6YUjEC5pcctFk
    fmTEFjzoORY1hB1+6BZR3bps7v4jRYWzZEK44+1nssUd/fkNM4KubZD5dCqvi4jf
    P/cgSFbA5dgF9bIm/rHkO0aZCSjh0Zk3gNdOFsc7hfymoJwkOe0vJwHMX5ba2B0y
    31yRE/h3n9dQKNKeeynRdWgkfMG/X19/tAhPW8AM6Ujg==
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
        id S1423222AbeCBLS6 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 06:18:58 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49204 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423220AbeCBIv4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 03:51:56 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tushar Dave <tushar.n.dave@oracle.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 16/24] e1000: fix disabling already-disabled warning
Date: Fri,  2 Mar 2018 09:51:13 +0100
Message-Id: <20180302084239.947464482@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084239.157503766@linuxfoundation.org>
References: <20180302084239.157503766@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tushar Dave <tushar.n.dave@oracle.com>


[ Upstream commit 0b76aae741abb9d16d2c0e67f8b1e766576f897d ]

This patch adds check so that driver does not disable already
disabled device.

[   44.637743] advantechwdt: Unexpected close, not stopping watchdog!
[   44.997548] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input6
[   45.013419] e1000 0000:00:03.0: disabling already-disabled device
[   45.013447] ------------[ cut here ]------------
[   45.014868] WARNING: CPU: 1 PID: 71 at drivers/pci/pci.c:1641 pci_disable_device+0xa1/0x105:
						pci_disable_device at drivers/pci/pci.c:1640
[   45.016171] CPU: 1 PID: 71 Comm: rcu_perf_shutdo Not tainted 4.14.0-01330-g3c07399 #1
[   45.017197] task: ffff88011bee9e40 task.stack: ffffc90000860000
[   45.017987] RIP: 0010:pci_disable_device+0xa1/0x105:
						pci_disable_device at drivers/pci/pci.c:1640
[   45.018603] RSP: 0000:ffffc90000863e30 EFLAGS: 00010286
[   45.019282] RAX: 0000000000000035 RBX: ffff88013a230008 RCX: 0000000000000000
[   45.020182] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000203
[   45.021084] RBP: ffff88013a3f31e8 R08: 0000000000000001 R09: 0000000000000000
[   45.021986] R10: ffffffff827ec29c R11: 0000000000000002 R12: 0000000000000001
[   45.022946] R13: ffff88013a230008 R14: ffff880117802b20 R15: ffffc90000863e8f
[   45.023842] FS:  0000000000000000(0000) GS:ffff88013fd00000(0000) knlGS:0000000000000000
[   45.024863] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   45.025583] CR2: ffffc900006d4000 CR3: 000000000220f000 CR4: 00000000000006a0
[   45.026478] Call Trace:
[   45.026811]  __e1000_shutdown+0x1d4/0x1e2:
						__e1000_shutdown at drivers/net/ethernet/intel/e1000/e1000_main.c:5162
[   45.027344]  ? rcu_perf_cleanup+0x2a1/0x2a1:
						rcu_perf_shutdown at kernel/rcu/rcuperf.c:627
[   45.027883]  e1000_shutdown+0x14/0x3a:
						e1000_shutdown at drivers/net/ethernet/intel/e1000/e1000_main.c:5235
[   45.028351]  device_shutdown+0x110/0x1aa:
						device_shutdown at drivers/base/core.c:2807
[   45.028858]  kernel_power_off+0x31/0x64:
						kernel_power_off at kernel/reboot.c:260
[   45.029343]  rcu_perf_shutdown+0x9b/0xa7:
						rcu_perf_shutdown at kernel/rcu/rcuperf.c:637
[   45.029852]  ? __wake_up_common_lock+0xa2/0xa2:
						autoremove_wake_function at kernel/sched/wait.c:376
[   45.030414]  kthread+0x126/0x12e:
						kthread at kernel/kthread.c:233
[   45.030834]  ? __kthread_bind_mask+0x8e/0x8e:
						kthread at kernel/kthread.c:190
[   45.031399]  ? ret_from_fork+0x1f/0x30:
						ret_from_fork at arch/x86/entry/entry_64.S:443
[   45.031883]  ? kernel_init+0xa/0xf5:
						kernel_init at init/main.c:997
[   45.032325]  ret_from_fork+0x1f/0x30:
						ret_from_fork at arch/x86/entry/entry_64.S:443
[   45.032777] Code: 00 48 85 ed 75 07 48 8b ab a8 00 00 00 48 8d bb 98 00 00 00 e8 aa d1 11 00 48 89 ea 48 89 c6 48 c7 c7 d8 e4 0b 82 e8 55 7d da ff <0f> ff b9 01 00 00 00 31 d2 be 01 00 00 00 48 c7 c7 f0 b1 61 82
[   45.035222] ---[ end trace c257137b1b1976ef ]---
[   45.037838] ACPI: Preparing to enter system sleep state S5

Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
Tested-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/e1000/e1000.h      |    3 +-
 drivers/net/ethernet/intel/e1000/e1000_main.c |   27 +++++++++++++++++++++-----
 2 files changed, 24 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/intel/e1000/e1000.h
+++ b/drivers/net/ethernet/intel/e1000/e1000.h
@@ -328,7 +328,8 @@ struct e1000_adapter {
 enum e1000_state_t {
 	__E1000_TESTING,
 	__E1000_RESETTING,
-	__E1000_DOWN
+	__E1000_DOWN,
+	__E1000_DISABLED
 };
 
 #undef pr_fmt
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -940,7 +940,7 @@ static int e1000_init_hw_struct(struct e
 static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct net_device *netdev;
-	struct e1000_adapter *adapter;
+	struct e1000_adapter *adapter = NULL;
 	struct e1000_hw *hw;
 
 	static int cards_found = 0;
@@ -950,6 +950,7 @@ static int e1000_probe(struct pci_dev *p
 	u16 tmp = 0;
 	u16 eeprom_apme_mask = E1000_EEPROM_APME;
 	int bars, need_ioport;
+	bool disable_dev = false;
 
 	/* do not allocate ioport bars when not needed */
 	need_ioport = e1000_is_need_ioport(pdev);
@@ -1250,11 +1251,13 @@ err_mdio_ioremap:
 	iounmap(hw->ce4100_gbe_mdio_base_virt);
 	iounmap(hw->hw_addr);
 err_ioremap:
+	disable_dev = !test_and_set_bit(__E1000_DISABLED, &adapter->flags);
 	free_netdev(netdev);
 err_alloc_etherdev:
 	pci_release_selected_regions(pdev, bars);
 err_pci_reg:
-	pci_disable_device(pdev);
+	if (!adapter || disable_dev)
+		pci_disable_device(pdev);
 	return err;
 }
 
@@ -1272,6 +1275,7 @@ static void e1000_remove(struct pci_dev
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
+	bool disable_dev;
 
 	e1000_down_and_stop(adapter);
 	e1000_release_manageability(adapter);
@@ -1290,9 +1294,11 @@ static void e1000_remove(struct pci_dev
 		iounmap(hw->flash_address);
 	pci_release_selected_regions(pdev, adapter->bars);
 
+	disable_dev = !test_and_set_bit(__E1000_DISABLED, &adapter->flags);
 	free_netdev(netdev);
 
-	pci_disable_device(pdev);
+	if (disable_dev)
+		pci_disable_device(pdev);
 }
 
 /**
@@ -5137,7 +5143,8 @@ static int __e1000_shutdown(struct pci_d
 	if (netif_running(netdev))
 		e1000_free_irq(adapter);
 
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(__E1000_DISABLED, &adapter->flags))
+		pci_disable_device(pdev);
 
 	return 0;
 }
@@ -5181,6 +5188,10 @@ static int e1000_resume(struct pci_dev *
 		pr_err("Cannot enable PCI device from suspend\n");
 		return err;
 	}
+
+	/* flush memory to make sure state is correct */
+	smp_mb__before_atomic();
+	clear_bit(__E1000_DISABLED, &adapter->flags);
 	pci_set_master(pdev);
 
 	pci_enable_wake(pdev, PCI_D3hot, 0);
@@ -5255,7 +5266,9 @@ static pci_ers_result_t e1000_io_error_d
 
 	if (netif_running(netdev))
 		e1000_down(adapter);
-	pci_disable_device(pdev);
+
+	if (!test_and_set_bit(__E1000_DISABLED, &adapter->flags))
+		pci_disable_device(pdev);
 
 	/* Request a slot slot reset. */
 	return PCI_ERS_RESULT_NEED_RESET;
@@ -5283,6 +5296,10 @@ static pci_ers_result_t e1000_io_slot_re
 		pr_err("Cannot re-enable PCI device after reset.\n");
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
+
+	/* flush memory to make sure state is correct */
+	smp_mb__before_atomic();
+	clear_bit(__E1000_DISABLED, &adapter->flags);
 	pci_set_master(pdev);
 
 	pci_enable_wake(pdev, PCI_D3hot, 0);
