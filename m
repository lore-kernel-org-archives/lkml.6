Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqlS1G+iFyD7mm6N6tld3TqnW2lXYoXbSl6D8axNoT/4Zpj7NomT2rrSRzKIIh1pRMVcR1u
ARC-Seal: i=1; a=rsa-sha256; t=1525116475; cv=none;
        d=google.com; s=arc-20160816;
        b=0FBqcZdCPUNh9LQUbxMg4LqKAHOrSrtqYW+78HiqVQMqQev1g7RJ2FUUFc+jqX/qXK
         jEComT+7OxmZwFrRbjhpWQ6dvvfsZZoVg3Mvwo6/Mle3UzACusECvUR6K51sDMIqHm/y
         9W+1kYXD+e4tNxHJ7NOmk3qfrbe7q0FW84uP6Nuu3xW+6CIsutNIErj+ORJGPWkUCD73
         XZbQN/PrchmVkrz8TkqGiE3/F+my/ZUvkHGxHG23XQwUf1JIVPH9Bjq1GZidylpGROTL
         nutz+my3vBhNSH2SowzXx3YB/T47AzPAv3oO6ZDTxiaitKhl++KwAkWahK9EFM12I+js
         TkEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=/swdEYKDpyc/DDHZWllGWABLO5hC+qyao1hbp6BY5pc=;
        b=A54iN58a5CGydGoErKvSfD6pm1AJOB3eW2pqPHzbaOZ8jtx4Yse3K1Q52o57mIuvvW
         +xvu2lTTyrt862Nj6XEJO4GVADTrpGrUJsnGVwi+lVJdQDYwMAXCtstl7isu3Rd8IJjX
         xKnkE97XWRT2Pq8eM1P83g36OnI7dlAWCGaIOBy0/p/ByIHhZE8Q1+mAc38nSlmvYSGG
         RDK+sUCuqK7w+ou4HqeZX5OTGsYGSyvpHHWMNq5jNEuwf7V843NXlpPZtReJGI/HvOLx
         FUxZDjR2SmKTCreUv7t70foQJFLHYvQfjcvjD8Sup7tStfAvw0OalOi586DcADdxToVZ
         nbOw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 614D122DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Zhengjun Xing <zhengjun.xing@linux.intel.com>,
	Christian Kellner <christian@kellner.me>,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.16 014/113] xhci: Fix Kernel oops in xhci dbgtty
Date: Mon, 30 Apr 2018 12:23:45 -0700
Message-Id: <20180430184015.678955884@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200533597724965?=
X-GMAIL-MSGID: =?utf-8?q?1599200533597724965?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

commit 7fc65d4c2ba9e5006c629669146c6876b65aa233 upstream.

tty_unregister_driver may be called more than 1 time in some
hotplug cases,it will cause the kernel oops. This patch checked
dbc_tty_driver to make sure it is unregistered only 1 time.

[  175.741404] BUG: unable to handle kernel NULL pointer dereference at 0000000000000034
[  175.742309] IP: tty_unregister_driver+0x9/0x70
[  175.743148] PGD 0 P4D 0
[  175.743981] Oops: 0000 [#1] SMP PTI
[  175.753904] RIP: 0010:tty_unregister_driver+0x9/0x70
[  175.754817] RSP: 0018:ffffa8ff831d3bb0 EFLAGS: 00010246
[  175.755753] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  175.756685] RDX: ffff92089c616000 RSI: ffffe64fe1b26080 RDI: 0000000000000000
[  175.757608] RBP: ffff92086c988230 R08: 000000006c982701 R09: 00000001801e0016
[  175.758533] R10: ffffa8ff831d3b48 R11: ffff92086c982100 R12: ffff92086c98827c
[  175.759462] R13: ffff92086c988398 R14: 0000000000000060 R15: ffff92089c5e9b40
[  175.760401] FS:  0000000000000000(0000) GS:ffff9208a0100000(0000) knlGS:0000000000000000
[  175.761334] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  175.762270] CR2: 0000000000000034 CR3: 000000011800a003 CR4: 00000000003606e0
[  175.763225] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  175.764164] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  175.765091] Call Trace:
[  175.766014]  xhci_dbc_tty_unregister_driver+0x11/0x30
[  175.766960]  xhci_dbc_exit+0x2a/0x40
[  175.767889]  xhci_stop+0x57/0x1c0
[  175.768824]  usb_remove_hcd+0x100/0x250
[  175.769708]  usb_hcd_pci_remove+0x68/0x130
[  175.770574]  pci_device_remove+0x3b/0xc0
[  175.771435]  device_release_driver_internal+0x157/0x230
[  175.772343]  pci_stop_bus_device+0x74/0xa0
[  175.773205]  pci_stop_bus_device+0x2b/0xa0
[  175.774061]  pci_stop_bus_device+0x2b/0xa0
[  175.774907]  pci_stop_bus_device+0x2b/0xa0
[  175.775741]  pci_stop_bus_device+0x2b/0xa0
[  175.776618]  pci_stop_bus_device+0x2b/0xa0
[  175.777452]  pci_stop_bus_device+0x2b/0xa0
[  175.778273]  pci_stop_bus_device+0x2b/0xa0
[  175.779092]  pci_stop_bus_device+0x2b/0xa0
[  175.779908]  pci_stop_bus_device+0x2b/0xa0
[  175.780750]  pci_stop_bus_device+0x2b/0xa0
[  175.781543]  pci_stop_and_remove_bus_device+0xe/0x20
[  175.782338]  pciehp_unconfigure_device+0xb8/0x160
[  175.783128]  pciehp_disable_slot+0x4f/0xd0
[  175.783920]  pciehp_power_thread+0x82/0xa0
[  175.784766]  process_one_work+0x147/0x3c0
[  175.785564]  worker_thread+0x4a/0x440
[  175.786376]  kthread+0xf8/0x130
[  175.787174]  ? rescuer_thread+0x360/0x360
[  175.787964]  ? kthread_associate_blkcg+0x90/0x90
[  175.788798]  ret_from_fork+0x35/0x40

Cc: <stable@vger.kernel.org> # 4.16
Fixes: dfba2174dc42 ("usb: xhci: Add DbC support in xHCI driver")
Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Tested-by: Christian Kellner <christian@kellner.me>
Reviewed-by: Christian Kellner <christian@kellner.me>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-dbgtty.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -320,9 +320,11 @@ int xhci_dbc_tty_register_driver(struct
 
 void xhci_dbc_tty_unregister_driver(void)
 {
-	tty_unregister_driver(dbc_tty_driver);
-	put_tty_driver(dbc_tty_driver);
-	dbc_tty_driver = NULL;
+	if (dbc_tty_driver) {
+		tty_unregister_driver(dbc_tty_driver);
+		put_tty_driver(dbc_tty_driver);
+		dbc_tty_driver = NULL;
+	}
 }
 
 static void dbc_rx_push(unsigned long _port)
