Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754846AbeDZJIb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 05:08:31 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:33688 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754428AbeDZJI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 05:08:26 -0400
X-Google-Smtp-Source: AIpwx4+boaENrvYYeo4L2QbiL61HAQ80BC2nJFu2vWANhHXIpwxUNRiFt61bJyhGHgAvTM9F8Eu7Jw==
From: Holger Schurig <holgerschurig@gmail.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] igb: reconnecting of cable not always detected
In-Reply-To: <CAKgT0UdTf5pf53==hB71Ba_N1gJ-TH_3uMajozr1wykLEbK80g@mail.gmail.com>
References: <87h8o0ocul.fsf@gmail.com> <CAKgT0Udj+d7yzPN4Jph8uk7Z6fz0oyWrO+6W6CfygSYTkGJ0Xw@mail.gmail.com> <877eovobxl.fsf@gmail.com> <CAKgT0UdTf5pf53==hB71Ba_N1gJ-TH_3uMajozr1wykLEbK80g@mail.gmail.com>
Date: Thu, 26 Apr 2018 11:08:22 +0200
Message-ID: <87wowumj21.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Thanks. I'm suspecting we may need to instrument igb_rd32 at this
> point. In order to trigger what you are seeing I am assuming the
> device has been detached due to a read failure of some sort.

Okay, I added a printk to igb_rd32. And because no one calls this
function directly (all access goes via the rd32/rd32_array macro) I also
added the output of the calling function. This should help greatly in
identifying the read from the hardware to the consumer.

Finally, I noticed that igb_update_stats() produced a lot of churn that
most likely are unrelated. So I helper variable to make output from this
function go away.

I installed this modified driver, rebooted, and removed / inserted the
LAN cable until the error was present.

As before, "ethtool" and "mii-tool" now said that the device is not
there, while "ip link" showed the device as present.


The full output of "journalctl -fk | grep igb" is 600 kB. So put the
whole file at Google Drive:

https://drive.google.com/open?id=1p9cCT2d_EHnSHh29oS3AepUgFTKGFSeA



I looked at the output to see patterns, e.g with

grep -n igb_get_cfg_done_i210 igb.error.txt
grep -n __igb_shutdown igb.error.txt
...

(and almost all other function names). I hoped to see patterns. But for
my untrained eye, things looked not out of the order.





(For reference, here is the debug patch)

Index: linux-4.16/drivers/net/ethernet/intel/igb/igb_main.c
===================================================================
--- linux-4.16.orig/drivers/net/ethernet/intel/igb/igb_main.c	2018-04-01 23:20:27.000000000 +0200
+++ linux-4.16/drivers/net/ethernet/intel/igb/igb_main.c	2018-04-26 10:36:09.625135952 +0200
@@ -759,7 +759,8 @@
 	}
 }
 
-u32 igb_rd32(struct e1000_hw *hw, u32 reg)
+int igb_rd32_silent = 0;
+u32 igb_rd32(const char *func, struct e1000_hw *hw, u32 reg)
 {
 	struct igb_adapter *igb = container_of(hw, struct igb_adapter, hw);
 	u8 __iomem *hw_addr = READ_ONCE(hw->hw_addr);
@@ -769,6 +770,8 @@
 		return ~value;
 
 	value = readl(&hw_addr[reg]);
+	if (!igb_rd32_silent)
+	printk("rd32 %s %08x %08x\n", func, reg, value);
 
 	/* reads should not return all F's */
 	if (!(~value) && (!reg || !(~readl(hw_addr)))) {
@@ -5935,6 +5938,7 @@
 	if (pci_channel_offline(pdev))
 		return;
 
+	igb_rd32_silent = 1;
 	bytes = 0;
 	packets = 0;
 
@@ -6100,6 +6104,7 @@
 		adapter->stats.b2ospc += rd32(E1000_B2OSPC);
 		adapter->stats.b2ogprc += rd32(E1000_B2OGPRC);
 	}
+	igb_rd32_silent = 0;
 }
 
 static void igb_tsync_interrupt(struct igb_adapter *adapter)
Index: linux-4.16/drivers/net/ethernet/intel/igb/e1000_regs.h
===================================================================
--- linux-4.16.orig/drivers/net/ethernet/intel/igb/e1000_regs.h	2018-04-01 23:20:27.000000000 +0200
+++ linux-4.16/drivers/net/ethernet/intel/igb/e1000_regs.h	2018-04-26 10:34:24.332157000 +0200
@@ -370,7 +370,8 @@
 
 struct e1000_hw;
 
-u32 igb_rd32(struct e1000_hw *hw, u32 reg);
+extern int igb_rd32_silent;
+u32 igb_rd32(const char *fname, struct e1000_hw *hw, u32 reg);
 
 /* write operations, indexed using DWORDS */
 #define wr32(reg, val) \
@@ -380,14 +381,14 @@
 		writel((val), &hw_addr[(reg)]); \
 } while (0)
 
-#define rd32(reg) (igb_rd32(hw, reg))
+#define rd32(reg) (igb_rd32(__func__, hw, reg))
 
 #define wrfl() ((void)rd32(E1000_STATUS))
 
 #define array_wr32(reg, offset, value) \
 	wr32((reg) + ((offset) << 2), (value))
 
-#define array_rd32(reg, offset) (igb_rd32(hw, reg + ((offset) << 2)))
+#define array_rd32(reg, offset) (igb_rd32(__func__, hw, reg + ((offset) << 2)))
 
 /* DMA Coalescing registers */
 #define E1000_PCIEMISC	0x05BB8 /* PCIE misc config register */
