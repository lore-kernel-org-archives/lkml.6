Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752267AbeCYVIH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 17:08:07 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:25016 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbeCYVIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 17:08:04 -0400
X-ME-Helo: [192.168.8.29]
X-ME-Auth: ZXJpYy52YWxldHRlNkB3YW5hZG9vLmZy
X-ME-Date: Sun, 25 Mar 2018 23:08:00 +0200
X-ME-IP: 86.214.204.162
Reply-To: eric.valette@free.fr
To: LKML <linux-kernel@vger.kernel.org>
From: Eric Valette <eric.valette@free.fr>
Subject: Periodic Null pointer access with 4.14.29-30 (while using minidlna)
 in sendfile system call
Organization: HOME
Message-ID: <87f4360e-d118-651f-0724-c7f79a5d885b@free.fr>
Date: Sun, 25 Mar 2018 23:07:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:58.0) Gecko/20100101
 Thunderbird/58.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a few kernels I get this error when streaming video to TV via 
minidlna:

Please CC me, I'm not subscribed

BUG: unable to handle kernel NULL pointer dereference at 0000000000000078
[ 3330.960519] IP: tcp_push+0x70/0xeb
[ 3330.960520] PGD 0 P4D 0
[ 3330.960523] Oops: 0000 [#1] SMP PTI
[ 3330.960532] Modules linked in: uas usb_storage ehci_pci ehci_hcd 
xhci_pci xhci_hcd usbcore usb_common [last unloaded: usb_storage]
[ 3330.960546] CPU: 1 PID: 4587 Comm: minidlnad Not tainted 4.14.30 #1
[ 3330.960549] Hardware name: MotherBoard By ZOTAC MotherBoard 
H67ITX-C-E/H67ITX-C-E, BIOS 4.6.4.B 08/25/2011
[ 3330.960553] task: ffff88023ea64440 task.stack: ffffc900013d4000
[ 3330.960558] RIP: 0010:tcp_push+0x70/0xeb
[ 3330.960560] RSP: 0018:ffffc900013d7bc0 EFLAGS: 00010246
[ 3330.960563] RAX: 0000000000000000 RBX: 00000000000005a8 RCX: 
0000000000000000
[ 3330.960567] RDX: 0000000000000000 RSI: 0000000000028000 RDI: 
ffff880232b53080
[ 3330.960570] RBP: ffff880232b531b8 R08: 00000000000005a8 R09: 
0000000000008218
[ 3330.960574] R10: ffff880232b531b8 R11: 0000000000008000 R12: 
ffff880227665700
[ 3330.960577] R13: ffff880232b53080 R14: 00000000000005a8 R15: 
00000000ffffffe0
[ 3330.960581] FS:  00007f96f5e7ce80(0000) GS:ffff88023fa80000(0000) 
knlGS:0000000000000000
[ 3330.960585] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3330.960588] CR2: 0000000000000078 CR3: 0000000223fd2005 CR4: 
00000000000606e0
[ 3330.960591] Call Trace:
[ 3330.960598]  tcp_sendmsg_locked+0xac3/0xc1b
[ 3330.960606]  ? generic_pipe_buf_nosteal+0x6/0x6
[ 3330.960612]  sock_no_sendpage_locked+0x74/0x7b
[ 3330.960617]  tcp_sendpage_locked+0x36/0x72
[ 3330.960622]  ? release_sock+0x3b/0x74
[ 3330.960626]  ? lock_sock_nested+0xd/0x38
[ 3330.960630]  tcp_sendpage+0x38/0x4f
[ 3330.960636]  inet_sendpage+0x74/0xd3
[ 3330.960640]  kernel_sendpage+0x15/0x1c
[ 3330.960643]  sock_sendpage+0x1b/0x1e
[ 3330.960648]  pipe_to_sendpage+0x57/0x59
[ 3330.960652]  __splice_from_pipe+0xa4/0x150
[ 3330.960655]  splice_from_pipe+0x50/0x66
[ 3330.960660]  ? generic_pipe_buf_nosteal+0x6/0x6
[ 3330.960664]  direct_splice_actor+0x2e/0x2f
[ 3330.960669]  splice_direct_to_actor+0xf2/0x18b
[ 3330.960673]  ? vmsplice_to_user+0x10f/0x10f
[ 3330.960677]  do_splice_direct+0x87/0x9b
[ 3330.960684]  do_sendfile+0x186/0x2d6
[ 3330.960688]  SyS_sendfile64+0x50/0x7f
[ 3330.960693]  do_syscall_64+0x5c/0xe7
[ 3330.960699]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[ 3330.960704] RIP: 0033:0x7f96f3c30bea
[ 3330.960707] RSP: 002b:00007fff5ca2d008 EFLAGS: 00000206 ORIG_RAX: 
0000000000000028
[ 3330.960711] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
00007f96f3c30bea
[ 3330.960715] RDX: 00007fff5ca2d018 RSI: 000000000000000b RDI: 
000000000000000a
[ 3330.960718] RBP: 0000000076f378a2 R08: 0000000000000000 R09: 
00005633e3b45fe7
[ 3330.960722] R10: 0000000076f378a3 R11: 0000000000000206 R12: 
000000000000000b
[ 3330.960725] R13: 0000000000000001 R14: 00005633e3ddefa0 R15: 
0000000000000000
[ 3330.960729] Code: 44 03 8f 44 06 00 00 79 10 80 48 38 08 8b 8f 3c 06 
00 00 89 8f 44 06 00 00 40 80 e6 01 74 0c 8b 8f 3c 06 00 00 89 8f cc 05 
00 00 <44> 39 40 78 72 13 89 de 45 85 db b8 02 00 00 00 5b 0f 45 d0 e9
[ 3330.960774] RIP: tcp_push+0x70/0xeb RSP: ffffc900013d7bc0
[ 3330.960777] CR2: 0000000000000078
[ 3330.960780] ---[ end trace 4fc2992bf2697a5f ]---
[ 3332.872978] BUG: unable to handle kernel NULL pointer dereference at 
0000000000000078
[ 3332.872996] IP: tcp_push+0x70/0xeb
[ 3332.872998] PGD 0 P4D 0
[ 3332.873003] Oops: 0000 [#2] SMP PTI
[ 3332.873007] Modules linked in: uas usb_storage ehci_pci ehci_hcd 
xhci_pci xhci_hcd usbcore usb_common [last unloaded: usb_storage]
[ 3332.873022] CPU: 0 PID: 4589 Comm: minidlnad Tainted: G      D 
  4.14.30 #1
[ 3332.873026] Hardware name: MotherBoard By ZOTAC MotherBoard 
H67ITX-C-E/H67ITX-C-E, BIOS 4.6.4.B 08/25/2011
[ 3332.873030] task: ffff88022afd4e40 task.stack: ffffc90001484000
[ 3332.873035] RIP: 0010:tcp_push+0x70/0xeb
[ 3332.873038] RSP: 0018:ffffc90001487bc0 EFLAGS: 00010246
[ 3332.873042] RAX: 0000000000000000 RBX: 00000000000005a8 RCX: 
0000000000000000
[ 3332.873045] RDX: 0000000000000000 RSI: 0000000000028000 RDI: 
ffff880223ed7040
[ 3332.873049] RBP: ffff880223ed7178 R08: 00000000000005a8 R09: 
0000000000014218
[ 3332.873052] R10: ffff880223ed7178 R11: 0000000000008000 R12: 
ffff88021fde1c40
[ 3332.873056] R13: ffff880223ed7040 R14: 00000000000005a8 R15: 
00000000ffffffe0
[ 3332.873060] FS:  00007f96f5e7ce80(0000) GS:ffff88023fa00000(0000) 
knlGS:0000000000000000
[ 3332.873064] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3332.873067] CR2: 0000000000000078 CR3: 0000000223fd2006 CR4: 
00000000000606f0
[ 3332.873070] Call Trace:
[ 3332.873077]  tcp_sendmsg_locked+0xac3/0xc1b
[ 3332.873084]  ? generic_pipe_buf_nosteal+0x6/0x6
[ 3332.873090]  sock_no_sendpage_locked+0x74/0x7b
[ 3332.873095]  tcp_sendpage_locked+0x36/0x72
[ 3332.873100]  ? release_sock+0x3b/0x74
[ 3332.873104]  ? lock_sock_nested+0xd/0x38
[ 3332.873108]  tcp_sendpage+0x38/0x4f
[ 3332.873114]  inet_sendpage+0x74/0xd3
[ 3332.873118]  kernel_sendpage+0x15/0x1c
[ 3332.873122]  sock_sendpage+0x1b/0x1e
[ 3332.873126]  pipe_to_sendpage+0x57/0x59
[ 3332.873130]  __splice_from_pipe+0xa4/0x150
[ 3332.873134]  splice_from_pipe+0x50/0x66
[ 3332.873138]  ? generic_pipe_buf_nosteal+0x6/0x6
[ 3332.873142]  direct_splice_actor+0x2e/0x2f
[ 3332.873147]  splice_direct_to_actor+0xf2/0x18b
[ 3332.873151]  ? vmsplice_to_user+0x10f/0x10f
[ 3332.873156]  do_splice_direct+0x87/0x9b
[ 3332.873162]  do_sendfile+0x186/0x2d6
[ 3332.873166]  SyS_sendfile64+0x50/0x7f
[ 3332.873171]  do_syscall_64+0x5c/0xe7
[ 3332.873177]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[ 3332.873181] RIP: 0033:0x7f96f3c30bea
[ 3332.873184] RSP: 002b:00007fff5ca2d008 EFLAGS: 00000206 ORIG_RAX: 
0000000000000028
[ 3332.873189] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
00007f96f3c30bea
[ 3332.873192] RDX: 00007fff5ca2d018 RSI: 000000000000000b RDI: 
000000000000000a
[ 3332.873195] RBP: 0000000076f378a2 R08: 0000000000000000 R09: 
00005633e3b45fe7
[ 3332.873199] R10: 0000000076f35777 R11: 0000000000000206 R12: 
000000000000000b
[ 3332.873202] R13: 0000000000000001 R14: 00005633e3ddefa0 R15: 
000000000000212c
[ 3332.873206] Code: 44 03 8f 44 06 00 00 79 10 80 48 38 08 8b 8f 3c 06 
00 00 89 8f 44 06 00 00 40 80 e6 01 74 0c 8b 8f 3c 06 00 00 89 8f cc 05 
00 00 <44> 39 40 78 72 13 89 de 45 85 db b8 02 00 00 00 5b 0f 45 d0 e9
[ 3332.873252] RIP: tcp_push+0x70/0xeb RSP: ffffc90001487bc0
[ 3332.873254] CR2: 0000000000000078
[ 3332.873268] ---[ end trace 4fc2992bf2697a60 ]---
[ 3466.216198] BUG: unable to handle kernel NULL pointer dereference at 
0000000000000078
[ 3466.216214] IP: tcp_push+0x70/0xeb
[ 3466.216216] PGD 0 P4D 0
[ 3466.216221] Oops: 0000 [#3] SMP PTI
[ 3466.216224] Modules linked in: uas usb_storage ehci_pci ehci_hcd 
xhci_pci xhci_hcd usbcore usb_common [last unloaded: usb_storage]
[ 3466.216239] CPU: 0 PID: 4590 Comm: minidlnad Tainted: G      D 
  4.14.30 #1
[ 3466.216242] Hardware name: MotherBoard By ZOTAC MotherBoard 
H67ITX-C-E/H67ITX-C-E, BIOS 4.6.4.B 08/25/2011
[ 3466.216247] task: ffff880227582f40 task.stack: ffffc9000148c000
[ 3466.216252] RIP: 0010:tcp_push+0x70/0xeb
[ 3466.216255] RSP: 0018:ffffc9000148fbc0 EFLAGS: 00010246
[ 3466.216259] RAX: 0000000000000000 RBX: 00000000000005a8 RCX: 
0000000000000000
[ 3466.216263] RDX: 0000000000000000 RSI: 0000000000028000 RDI: 
ffff88023320f780
[ 3466.216266] RBP: ffff88023320f8b8 R08: 00000000000005a8 R09: 
0000000000020000
[ 3466.216269] R10: ffff88023320f8b8 R11: 0000000000008000 R12: 
ffff88021c45e700
[ 3466.216273] R13: ffff88023320f780 R14: 000000000000054d R15: 
00000000ffffffe0
[ 3466.216277] FS:  00007f96f5e7ce80(0000) GS:ffff88023fa00000(0000) 
knlGS:0000000000000000
[ 3466.216281] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3466.216284] CR2: 0000000000000078 CR3: 000000022f308002 CR4: 
00000000000606f0
[ 3466.216287] Call Trace:
[ 3466.216293]  tcp_sendmsg_locked+0xac3/0xc1b
[ 3466.216301]  ? generic_pipe_buf_nosteal+0x6/0x6
[ 3466.216306]  sock_no_sendpage_locked+0x74/0x7b
[ 3466.216311]  tcp_sendpage_locked+0x36/0x72
[ 3466.216316]  ? release_sock+0x3b/0x74
[ 3466.216320]  ? lock_sock_nested+0xd/0x38
[ 3466.216324]  tcp_sendpage+0x38/0x4f
[ 3466.216330]  inet_sendpage+0x74/0xd3
[ 3466.216334]  kernel_sendpage+0x15/0x1c
[ 3466.216337]  sock_sendpage+0x1b/0x1e
[ 3466.216342]  pipe_to_sendpage+0x57/0x59
[ 3466.216345]  __splice_from_pipe+0xa4/0x150
[ 3466.216349]  splice_from_pipe+0x50/0x66
[ 3466.216354]  ? generic_pipe_buf_nosteal+0x6/0x6
[ 3466.216358]  direct_splice_actor+0x2e/0x2f
[ 3466.216362]  splice_direct_to_actor+0xf2/0x18b
[ 3466.216366]  ? vmsplice_to_user+0x10f/0x10f
[ 3466.216371]  do_splice_direct+0x87/0x9b
[ 3466.216377]  do_sendfile+0x186/0x2d6
[ 3466.216381]  SyS_sendfile64+0x50/0x7f
[ 3466.216385]  do_syscall_64+0x5c/0xe7
[ 3466.216391]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[ 3466.216396] RIP: 0033:0x7f96f3c30bea
[ 3466.216398] RSP: 002b:00007fff5ca2d008 EFLAGS: 00000206 ORIG_RAX: 
0000000000000028
[ 3466.216403] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
00007f96f3c30bea
[ 3466.216407] RDX: 00007fff5ca2d018 RSI: 000000000000000b RDI: 
000000000000000a
[ 3466.216410] RBP: 0000000076f378a2 R08: 0000000000000000 R09: 
00005633e3b45fe7
[ 3466.216413] R10: 0000000076f3577b R11: 0000000000000206 R12: 
000000000000000b
[ 3466.216417] R13: 0000000000000001 R14: 00005633e3ddefa0 R15: 
0000000000002128
[ 3466.216420] Code: 44 03 8f 44 06 00 00 79 10 80 48 38 08 8b 8f 3c 06 
00 00 89 8f 44 06 00 00 40 80 e6 01 74 0c 8b 8f 3c 06 00 00 89 8f cc 05 
00 00 <44> 39 40 78 72 13 89 de 45 85 db b8 02 00 00 00 5b 0f 45 d0 e9
[ 3466.216466] RIP: tcp_push+0x70/0xeb RSP: ffffc9000148fbc0
[ 3466.216468] CR2: 0000000000000078
[ 3466.216471] ---[ end trace 4fc2992bf2697a61 ]---
[ 3466.285840] BUG: unable to handle kernel NULL pointer dereference at 
0000000000000078
[ 3466.285857] IP: tcp_push+0x70/0xeb
[ 3466.285859] PGD 0 P4D 0
[ 3466.285872] Oops: 0000 [#4] SMP PTI
[ 3466.285874] Modules linked in: uas usb_storage ehci_pci ehci_hcd 
xhci_pci xhci_hcd usbcore usb_common [last unloaded: usb_storage]
[ 3466.285882] CPU: 0 PID: 4782 Comm: minidlnad Tainted: G      D 
  4.14.30 #1
[ 3466.285884] Hardware name: MotherBoard By ZOTAC MotherBoard 
H67ITX-C-E/H67ITX-C-E, BIOS 4.6.4.B 08/25/2011
[ 3466.285886] task: ffff88022aba4580 task.stack: ffffc90001720000
[ 3466.285889] RIP: 0010:tcp_push+0x70/0xeb
[ 3466.285890] RSP: 0018:ffffc90001723bc0 EFLAGS: 00010246
[ 3466.285892] RAX: 0000000000000000 RBX: 00000000000005a8 RCX: 
0000000000000000
[ 3466.285894] RDX: 0000000000000000 RSI: 0000000000008000 RDI: 
ffff88023320f000
[ 3466.285896] RBP: ffff88023320f138 R08: 00000000000005a8 R09: 
0000000000008218
[ 3466.285897] R10: ffff88023320f138 R11: 0000000000008000 R12: 
ffff88021fd14e00
[ 3466.285899] R13: ffff88023320f000 R14: 00000000000005a8 R15: 
00000000ffffffe0
[ 3466.285901] FS:  00007f96f5e7ce80(0000) GS:ffff88023fa00000(0000) 
knlGS:0000000000000000
[ 3466.285903] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3466.285905] CR2: 0000000000000078 CR3: 000000022f308005 CR4: 
00000000000606f0
[ 3466.285906] Call Trace:
[ 3466.285910]  tcp_sendmsg_locked+0xac3/0xc1b
[ 3466.285914]  ? generic_pipe_buf_nosteal+0x6/0x6
[ 3466.285917]  sock_no_sendpage_locked+0x74/0x7b
[ 3466.285920]  tcp_sendpage_locked+0x36/0x72
[ 3466.285922]  ? release_sock+0x3b/0x74
[ 3466.285924]  ? lock_sock_nested+0xd/0x38
[ 3466.285926]  tcp_sendpage+0x38/0x4f
[ 3466.285930]  inet_sendpage+0x74/0xd3
[ 3466.285932]  kernel_sendpage+0x15/0x1c
[ 3466.285934]  sock_sendpage+0x1b/0x1e
[ 3466.285936]  pipe_to_sendpage+0x57/0x59
[ 3466.285938]  __splice_from_pipe+0xa4/0x150
[ 3466.285940]  splice_from_pipe+0x50/0x66
[ 3466.285942]  ? generic_pipe_buf_nosteal+0x6/0x6
[ 3466.285944]  direct_splice_actor+0x2e/0x2f
[ 3466.285947]  splice_direct_to_actor+0xf2/0x18b
[ 3466.285949]  ? vmsplice_to_user+0x10f/0x10f
[ 3466.285951]  do_splice_direct+0x87/0x9b
[ 3466.285954]  do_sendfile+0x186/0x2d6
[ 3466.285956]  SyS_sendfile64+0x50/0x7f
[ 3466.285959]  do_syscall_64+0x5c/0xe7
[ 3466.285963]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[ 3466.285965] RIP: 0033:0x7f96f3c30bea
[ 3466.285966] RSP: 002b:00007fff5ca2d008 EFLAGS: 00000206 ORIG_RAX: 
0000000000000028
[ 3466.285969] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
00007f96f3c30bea
[ 3466.285971] RDX: 00007fff5ca2d018 RSI: 000000000000000b RDI: 
000000000000000a
[ 3466.285972] RBP: 00000000af0c410c R08: 0000000000000000 R09: 
00005633e3b45fe7
[ 3466.285974] R10: 000000007fffffff R11: 0000000000000206 R12: 
000000000000000b
[ 3466.285976] R13: 0000000000000001 R14: 00005633e3ddefa0 R15: 
0000000000000000
[ 3466.285978] Code: 44 03 8f 44 06 00 00 79 10 80 48 38 08 8b 8f 3c 06 
00 00 89 8f 44 06 00 00 40 80 e6 01 74 0c 8b 8f 3c 06 00 00 89 8f cc 05 
00 00 <44> 39 40 78 72 13 89 de 45 85 db b8 02 00 00 00 5b 0f 45 d0 e9
[ 3466.286001] RIP: tcp_push+0x70/0xeb RSP: ffffc90001723bc0
[ 3466.286002] CR2: 0000000000000078
[ 3466.286017] ---[ end trace 4fc2992bf2697a62 ]---
[ 3467.935612] BUG: unable to handle kernel NULL pointer dereference at 
0000000000000078
[ 3467.935628] IP: tcp_push+0x70/0xeb
[ 3467.935631] PGD 0 P4D 0
[ 3467.935636] Oops: 0000 [#5] SMP PTI
[ 3467.935639] Modules linked in: uas usb_storage ehci_pci ehci_hcd 
xhci_pci xhci_hcd usbcore usb_common [last unloaded: usb_storage]
[ 3467.935654] CPU: 0 PID: 4784 Comm: minidlnad Tainted: G      D 
  4.14.30 #1
[ 3467.935658] Hardware name: MotherBoard By ZOTAC MotherBoard 
H67ITX-C-E/H67ITX-C-E, BIOS 4.6.4.B 08/25/2011
[ 3467.935662] task: ffff88023ea02400 task.stack: ffffc900015b4000
[ 3467.935667] RIP: 0010:tcp_push+0x70/0xeb
[ 3467.935670] RSP: 0018:ffffc900015b7bc0 EFLAGS: 00010246
[ 3467.935674] RAX: 0000000000000000 RBX: 00000000000005a8 RCX: 
0000000000000000
[ 3467.935678] RDX: 0000000000000000 RSI: 0000000000028000 RDI: 
ffff880236f0e780
[ 3467.935681] RBP: ffff880236f0e8b8 R08: 00000000000005a8 R09: 
0000000000012218
[ 3467.935685] R10: ffff880236f0e8b8 R11: 0000000000008000 R12: 
ffff88021ffaa1c0
[ 3467.935688] R13: ffff880236f0e780 R14: 0000000000000206 R15: 
00000000ffffffe0
[ 3467.935692] FS:  00007f96f5e7ce80(0000) GS:ffff88023fa00000(0000) 
knlGS:0000000000000000
[ 3467.935696] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3467.935699] CR2: 0000000000000078 CR3: 0000000223f10002 CR4: 
00000000000606f0
[ 3467.935702] Call Trace:
[ 3467.935709]  tcp_sendmsg_locked+0xac3/0xc1b
[ 3467.935716]  ? generic_pipe_buf_nosteal+0x6/0x6
[ 3467.935721]  sock_no_sendpage_locked+0x74/0x7b
[ 3467.935727]  tcp_sendpage_locked+0x36/0x72
[ 3467.935732]  ? release_sock+0x3b/0x74
[ 3467.935736]  ? lock_sock_nested+0xd/0x38
[ 3467.935740]  tcp_sendpage+0x38/0x4f
[ 3467.935745]  inet_sendpage+0x74/0xd3
[ 3467.935750]  kernel_sendpage+0x15/0x1c
[ 3467.935753]  sock_sendpage+0x1b/0x1e
[ 3467.935758]  pipe_to_sendpage+0x57/0x59
[ 3467.935762]  __splice_from_pipe+0xa4/0x150
[ 3467.935765]  splice_from_pipe+0x50/0x66
[ 3467.935770]  ? generic_pipe_buf_nosteal+0x6/0x6
[ 3467.935774]  direct_splice_actor+0x2e/0x2f
[ 3467.935779]  splice_direct_to_actor+0xf2/0x18b
[ 3467.935782]  ? vmsplice_to_user+0x10f/0x10f
[ 3467.935787]  do_splice_direct+0x87/0x9b
[ 3467.935793]  do_sendfile+0x186/0x2d6
[ 3467.935797]  SyS_sendfile64+0x50/0x7f
[ 3467.935802]  do_syscall_64+0x5c/0xe7
[ 3467.935808]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[ 3467.935812] RIP: 0033:0x7f96f3c30bea
[ 3467.935815] RSP: 002b:00007fff5ca2d008 EFLAGS: 00000206 ORIG_RAX: 
0000000000000028
[ 3467.935819] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
00007f96f3c30bea
[ 3467.935823] RDX: 00007fff5ca2d018 RSI: 000000000000000b RDI: 
000000000000000a
[ 3467.935826] RBP: 00000000af0c410c R08: 0000000000000000 R09: 
00005633e3b45fe7
[ 3467.935830] R10: 000000007fffffff R11: 0000000000000206 R12: 
000000000000000b
[ 3467.935833] R13: 0000000000000001 R14: 00005633e3ddefa0 R15: 
0000000000001b31
[ 3467.935837] Code: 44 03 8f 44 06 00 00 79 10 80 48 38 08 8b 8f 3c 06 
00 00 89 8f 44 06 00 00 40 80 e6 01 74 0c 8b 8f 3c 06 00 00 89 8f cc 05 
00 00 <44> 39 40 78 72 13 89 de 45 85 db b8 02 00 00 00 5b 0f 45 d0 e9
[ 3467.935882] RIP: tcp_push+0x70/0xeb RSP: ffffc900015b7bc0
[ 3467.935885] CR2: 0000000000000078
[ 3467.935909] ---[ end trace 4fc2992bf2697a63 ]---
[ 9308.859580] BUG: unable to handle kernel NULL pointer dereference at 
0000000000000078
[ 9308.859596] IP: tcp_push+0x70/0xeb
[ 9308.859598] PGD 0 P4D 0
[ 9308.859603] Oops: 0000 [#6] SMP PTI
[ 9308.859606] Modules linked in: uas usb_storage ehci_pci ehci_hcd 
xhci_pci xhci_hcd usbcore usb_common [last unloaded: usb_storage]
[ 9308.859621] CPU: 0 PID: 4785 Comm: minidlnad Tainted: G      D 
  4.14.30 #1
[ 9308.859624] Hardware name: MotherBoard By ZOTAC MotherBoard 
H67ITX-C-E/H67ITX-C-E, BIOS 4.6.4.B 08/25/2011
[ 9308.859629] task: ffff88022f1d6280 task.stack: ffffc900016b0000
[ 9308.859634] RIP: 0010:tcp_push+0x70/0xeb
[ 9308.859637] RSP: 0018:ffffc900016b3bc0 EFLAGS: 00010246
[ 9308.859640] RAX: 0000000000000000 RBX: 00000000000005a8 RCX: 
0000000000000000
[ 9308.859644] RDX: 0000000000000000 RSI: 0000000000028000 RDI: 
ffff880236f0e000
[ 9308.859647] RBP: ffff880236f0e138 R08: 00000000000005a8 R09: 
0000000000020000
[ 9308.859651] R10: ffff880236f0e138 R11: 0000000000008000 R12: 
ffff88023662ba80
[ 9308.859654] R13: ffff880236f0e000 R14: 00000000000005a8 R15: 
00000000ffffffe0
[ 9308.859659] FS:  00007f96f5e7ce80(0000) GS:ffff88023fa00000(0000) 
knlGS:0000000000000000
[ 9308.859662] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9308.859666] CR2: 0000000000000078 CR3: 000000022f308005 CR4: 
00000000000606f0
[ 9308.859669] Call Trace:
[ 9308.859675]  tcp_sendmsg_locked+0xac3/0xc1b
[ 9308.859682]  ? generic_pipe_buf_nosteal+0x6/0x6
[ 9308.859687]  sock_no_sendpage_locked+0x74/0x7b
[ 9308.859692]  tcp_sendpage_locked+0x36/0x72
[ 9308.859697]  ? release_sock+0x3b/0x74
[ 9308.859701]  ? lock_sock_nested+0xd/0x38
[ 9308.859705]  tcp_sendpage+0x38/0x4f
[ 9308.859711]  inet_sendpage+0x74/0xd3
[ 9308.859715]  kernel_sendpage+0x15/0x1c
[ 9308.859719]  sock_sendpage+0x1b/0x1e
[ 9308.859723]  pipe_to_sendpage+0x57/0x59
[ 9308.859727]  __splice_from_pipe+0xa4/0x150
[ 9308.859730]  splice_from_pipe+0x50/0x66
[ 9308.859735]  ? generic_pipe_buf_nosteal+0x6/0x6
[ 9308.859739]  direct_splice_actor+0x2e/0x2f
[ 9308.859743]  splice_direct_to_actor+0xf2/0x18b
[ 9308.859747]  ? vmsplice_to_user+0x10f/0x10f
[ 9308.859752]  do_splice_direct+0x87/0x9b
[ 9308.859757]  do_sendfile+0x186/0x2d6
[ 9308.859761]  SyS_sendfile64+0x50/0x7f
[ 9308.859766]  do_syscall_64+0x5c/0xe7
[ 9308.859771]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[ 9308.859776] RIP: 0033:0x7f96f3c30bea
[ 9308.859778] RSP: 002b:00007fff5ca2d008 EFLAGS: 00000212 ORIG_RAX: 
0000000000000028
[ 9308.859783] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
00007f96f3c30bea
[ 9308.859787] RDX: 00007fff5ca2d018 RSI: 000000000000000b RDI: 
000000000000000a
[ 9308.859790] RBP: 00000000af0c410c R08: 0000000000000000 R09: 
00005633e3b45fe7
[ 9308.859793] R10: 000000002f0c35e0 R11: 0000000000000212 R12: 
000000000000000b
[ 9308.859797] R13: 0000000000000001 R14: 00005633e3ddefa0 R15: 
0000000080000b2d
[ 9308.859800] Code: 44 03 8f 44 06 00 00 79 10 80 48 38 08 8b 8f 3c 06 
00 00 89 8f 44 06 00 00 40 80 e6 01 74 0c 8b 8f 3c 06 00 00 89 8f cc 05 
00 00 <44> 39 40 78 72 13 89 de 45 85 db b8 02 00 00 00 5b 0f 45 d0 e9
[ 9308.859846] RIP: tcp_push+0x70/0xeb RSP: ffffc900016b3bc0
[ 9308.859848] CR2: 0000000000000078
[ 9308.859851] ---[ end trace 4fc2992bf2697a64 ]---
root@nas2:~#

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr
