Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeEPScO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 14:32:14 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:40908 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751850AbeEPScM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 14:32:12 -0400
X-Google-Smtp-Source: AB8JxZoCdnpjdj5WNOuXRLTtyMxaCKGr4g4/AxrhORbvHdazc0w+WOv04sp7tczph26Ogz2f5ydAag==
Date: Wed, 16 May 2018 20:32:08 +0200
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: Jose.Abreu@synopsys.com, davem@davemloft.net, alexandre.torgue@st.com,
        peppe.cavallaro@st.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [BUG] net: stmmac: dwmac-sun8i broken in linux-next
Message-ID: <20180516183208.GA17778@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

The dwmac-sun8i driver is broken in next-20180515, symptom are no RX and TX errors as shown by ifconfig:
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.1.204  netmask 255.255.255.0  broadcast 192.168.1.255
        ether 96:75:ff:0d:f6:d8  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 4956 (4.8 KiB)
        TX errors 118  dropped 0 overruns 0  carrier 0  collisions 0

Reverting the following commit made the driver working:
4dbbe8dde8485b89bce8bbbe7564337fd7eed69f ("net: stmmac: Add support for U32 TC filter using Flexible RX Parser")
5f0456b43140af9413397cc11d03d18b9f2fc2fc ("net: stmmac: Implement logic to automatically select HW Interface")

Note that reverting only 4dbbe8dde8485b89bce8bbbe7564337fd7eed69f lead to crash:
[   31.385110] Backtrace: 
[   31.387576] [<c0510cd4>] (stmmac_open) from [<c062cf48>] (__dev_open+0xe4/0x180)
[   31.394972]  r10:ed447d04 r9:edc5d010 r8:ef02002c r7:c08670a4 r6:00000000 r5:c0c08488
[   31.402793]  r4:ef020000
[   31.405335] [<c062ce64>] (__dev_open) from [<c062d374>] (__dev_change_flags+0x190/0x1e8)
[   31.413421]  r8:00001002 r7:c0c08488 r6:00001003 r5:00000001 r4:ef020000
[   31.420122] [<c062d1e4>] (__dev_change_flags) from [<c062d3ec>] (dev_change_flags+0x20/0x50)
[   31.428555]  r9:edc5d010 r8:ed447c18 r7:ef020134 r6:00000000 r5:00001002 r4:ef020000
[   31.436300] [<c062d3cc>] (dev_change_flags) from [<c0646ef0>] (do_setlink+0x28c/0xbdc)
[   31.444213]  r9:edc5d010 r8:ed447c18 r7:00000000 r6:c0c08488 r5:ed447b50 r4:ef020000
[   31.451955] [<c0646c64>] (do_setlink) from [<c0648064>] (rtnl_newlink+0x54c/0x7a8)
[   31.459522]  r10:ed447d04 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:00000000
[   31.467343]  r4:ef020000
[   31.469885] [<c0647b18>] (rtnl_newlink) from [<c06449f8>] (rtnetlink_rcv_msg+0x38c/0x544)
[   31.478058]  r10:ed447d04 r9:00000000 r8:ee242840 r7:00000000 r6:edc5d000 r5:c0c08488
[   31.485879]  r4:00000000
[   31.488422] [<c064466c>] (rtnetlink_rcv_msg) from [<c066e458>] (netlink_rcv_skb+0xc0/0x118)
[   31.496768]  r10:c0c08488 r9:00000000 r8:00000020 r7:edc5d000 r6:c064466c r5:c0c08488
[   31.504589]  r4:ee242840
[   31.507129] [<c066e398>] (netlink_rcv_skb) from [<c0644668>] (rtnetlink_rcv+0x18/0x1c)
[   31.515042]  r8:ed447d60 r7:ee242840 r6:00000020 r5:ee37d800 r4:ee5fac00
[   31.521742] [<c0644650>] (rtnetlink_rcv) from [<c066db98>] (netlink_unicast+0x190/0x1fc)
[   31.529829] [<c066da08>] (netlink_unicast) from [<c066e098>] (netlink_sendmsg+0x3cc/0x410)
[   31.538089]  r10:00000000 r9:00000020 r8:014000c0 r7:ee242840 r6:ee37d800 r5:c0c08488
[   31.545910]  r4:ed447f44
[   31.548452] [<c066dccc>] (netlink_sendmsg) from [<c0604460>] (sock_sendmsg+0x1c/0x2c)
[   31.556279]  r10:00000000 r9:ed447edc r8:00000000 r7:eefce640 r6:00000000 r5:c0c08488
[   31.564100]  r4:ed447f44
[   31.566640] [<c0604444>] (sock_sendmsg) from [<c0604d9c>] (___sys_sendmsg+0x250/0x264)
[   31.574555] [<c0604b4c>] (___sys_sendmsg) from [<c0605e98>] (__sys_sendmsg+0x58/0x94)
[   31.582382]  r10:00000000 r9:ed446000 r8:c01011c4 r7:eefce640 r6:00000000 r5:bec25150
[   31.590203]  r4:c0c08488
[   31.592743] [<c0605e40>] (__sys_sendmsg) from [<c0605ee8>] (sys_sendmsg+0x14/0x18)
[   31.600307]  r7:00000128 r6:bec2d17c r5:bec25144 r4:00093ee0
[   31.605969] [<c0605ed4>] (sys_sendmsg) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
[   31.613704] Exception stack(0xed447fa8 to 0xed447ff0)
[   31.618756] 7fa0:                   00093ee0 bec25144 00000003 bec25150 00000000 85ce0000
[   31.626929] 7fc0: 00093ee0 bec25144 bec2d17c 00000128 000942a8 5afc783a 00094000 bec25150
[   31.635099] 7fe0: 00000000 bec250f0 0000012c b6e10b5c
[   31.640152] Code: e59a261c e59a013c e50b306c e592300c (e593300c) 
[   31.646632] ---[ end trace 407964b7deb937bf ]---

For the moment, I stil didnt find the issue.
What to we do now ? do you want that I send revert patchs ?

Regards
