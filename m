Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753325AbeDUUcz (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 16:32:55 -0400
Received: from mail-ot0-f178.google.com ([74.125.82.178]:36657 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753223AbeDUUcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 16:32:53 -0400
X-Google-Smtp-Source: AIpwx48hiVQCFv2qQF08kn2EQsPMAUykWvdueP31GK8zpExR/afiOB0IEROUUnCHxO6a3qN8hKCJYg==
From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: False memory leak in iwlmvm
To: Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Message-ID: <b785238b-9d20-0297-382c-65f41be00ea3@lwfinger.net>
Date: Sat, 21 Apr 2018 15:32:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentlemen,

I was checking a scan of /sys/kernel/debug/kmemleak with 4.17.0-rc1 and came 
across this leak message arising from iwlwifi. It is a false message as 
unloading iwlmvm has it disappearing from the scan.

Thanks,
Larry

unreferenced object 0xffff88021da6c580 (size 128):
   comm "softirq", pid 0, jiffies 4298748784 (age 7844.956s)
   hex dump (first 32 bytes):
     00 c4 a6 1d 02 88 ff ff 00 00 00 00 00 00 00 00  ................
     00 00 00 00 20 00 00 00 00 38 49 15 ca 55 00 00  .... ....8I..U..
   backtrace:
     [<00000000599c704b>] nf_ct_ext_add+0x9e/0x180 [nf_conntrack]
     [<00000000e323b857>] init_conntrack+0x206/0x5b0 [nf_conntrack]
     [<00000000639e3725>] nf_conntrack_in+0x3c8/0x4e0 [nf_conntrack]
     [<00000000795b6382>] nf_hook_slow+0x43/0xc0
     [<000000005e335478>] ip_rcv+0x2e3/0x3a0
     [<0000000063a4cdd5>] __netif_receive_skb_core+0x3f5/0xb70
     [<00000000cb885815>] netif_receive_skb_internal+0x2c/0xf0
     [<00000000976d864f>] napi_gro_receive+0xd1/0xf0
     [<00000000ea233b08>] ieee80211_deliver_skb+0xe7/0x250 [mac80211]
     [<00000000b29f1d1e>] ieee80211_rx_handlers+0xd30/0x1e40 [mac80211]
     [<000000004f15ea1a>] ieee80211_prepare_and_rx_handle+0x534/0x11c0 [mac80211]
     [<0000000088d8e9fc>] ieee80211_rx_napi+0x328/0x9c0 [mac80211]
     [<000000008360ee9e>] iwl_mvm_rx_rx_mpdu+0x501/0x960 [iwlmvm]
     [<00000000b977d096>] iwl_pcie_rx_handle+0x21d/0x870 [iwlwifi]
     [<000000005ccb7965>] iwl_pcie_irq_handler+0x6b5/0xa00 [iwlwifi]
     [<0000000010a165b6>] irq_thread_fn+0x21/0x50
