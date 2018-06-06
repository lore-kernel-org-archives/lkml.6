Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BA5C5601A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=corsac.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932543AbeFFIVi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 04:21:38 -0400
Received: from pic75-3-78-194-244-226.fbxo.proxad.net ([78.194.244.226]:33420
        "EHLO mail.corsac.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S932352AbeFFIVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 04:21:36 -0400
Date: Wed, 6 Jun 2018 10:21:30 +0200
From: Yves-Alexis Perez <corsac@corsac.net>
To: linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        David Windsor <dwindsor@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Mateusz Jurczyk <mjurczyk@google.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        David Herrmann <dh.herrmann@gmail.com>, netdev@vger.kernel.org,
        Alexander Kappner <agk@godking.net>,
        Johannes Berg <johannes.berg@intel.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Freeze when using ipheth+IPsec+IPv6
Message-ID: <20180606082130.GA3730@scapa.corsac.net>
References: <20180605085450.GA3506@scapa.corsac.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <20180605085450.GA3506@scapa.corsac.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Tue, Jun 05, 2018 at 10:54:51AM +0200, Yves-Alexis Perez wrote:
> Hi,
> 
> since some kernels releases (I didn't test thorougly but at least 4.16
> and 4.17) I have regular freezes in certain situations on my laptop.
> 
> It seems to happen when I:
> 
> - tether using my iPhone (involving ipheth)
> - mount an IPsec tunnel over IPv4
> - run evolution to fetch my mail (IMAP traffic over IPv6 inside the IPv4
>   IPsec tunnel)
> 
> When I do that, the interface seems to freeze. Last time the mouse was
> still moving so the kernel didn't completely crash, but the UI was
> completely irresponsive. I managed to get the attached log from
> /sys/fs/pstore with refcount_t stuff pointing to an underflow.

Today I had a different behavior. Again same situation (ipheth, IPsec
tunnel, refresh of the LKML folder in Evolution). The kernel didn't
crash/freeze but I had multiple (33309 actually) "recvmsg bug:
copied..." traces like this one:


[ 1555.957599] ------------[ cut here ]------------
[ 1555.957619] recvmsg bug: copied ABEA08B2 seq 1 rcvnxt ABEA0DCE fl 0
[ 1555.957805] WARNING: CPU: 3 PID: 2177 at /home/corsac/projets/linux/linux/net/ipv4/tcp.c:1850 tcp_recvmsg+0x610/0xb40
[ 1555.957813] Modules linked in: esp4 xfrm6_mode_tunnel xfrm4_mode_tunnel bnep ipheth rtsx_pci_sdmmc snd_hda_codec_realtek iwlmvm snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_intel iwlwifi snd_hda_codec snd_hwdep rtsx_pci snd_hda_core snd_pcm thinkpad_acpi efivarfs input_leds
[ 1555.957895] CPU: 3 PID: 2177 Comm: pool Tainted: G                T 4.17.0 #22
[ 1555.957902] Hardware name: LENOVO 20CMCTO1WW/20CMCTO1WW, BIOS N10ET48W (1.27 ) 09/12/2017
[ 1555.957922] RIP: 0010:tcp_recvmsg+0x610/0xb40
[ 1555.957927] RSP: 0018:ffffb77e010f7cf8 EFLAGS: 00010282
[ 1555.957932] RAX: 0000000000000000 RBX: 00000000abea08b2 RCX: 0000000000000006
[ 1555.957935] RDX: 0000000000000007 RSI: 0000000000000086 RDI: ffffa37a8dd95610
[ 1555.957939] RBP: ffffb77e010f7db8 R08: 00000000000003b4 R09: 0000000000000004
[ 1555.957942] R10: ffffa37a3b1180c8 R11: 0000000000000001 R12: ffffa37a81d40e00
[ 1555.957945] R13: ffffa37a3b118000 R14: ffffa37a3b118524 R15: 0000000000000000
[ 1555.957951] FS:  0000738f795c0700(0000) GS:ffffa37a8dd80000(0000) knlGS:0000000000000000
[ 1555.957954] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1555.957957] CR2: 0000738f0879a028 CR3: 000000024200c006 CR4: 00000000003606e0
[ 1555.957964] Call Trace:
[ 1555.957996]  inet_recvmsg+0x5c/0x110
[ 1555.958017]  __sys_recvfrom+0xf2/0x160
[ 1555.958030]  __x64_sys_recvfrom+0x1f/0x30
[ 1555.958039]  do_syscall_64+0x72/0x1c0
[ 1555.958048]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1555.958053] RIP: 0033:0x73901a71deae
[ 1555.958056] RSP: 002b:0000738f795bee50 EFLAGS: 00000246 ORIG_RAX: 000000000000002d
[ 1555.958060] RAX: ffffffffffffffda RBX: 0000000000000028 RCX: 000073901a71deae
[ 1555.958063] RDX: 0000000000000404 RSI: 0000738f087955a7 RDI: 0000000000000028
[ 1555.958066] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[ 1555.958068] R10: 0000000000000000 R11: 0000000000000246 R12: 0000738f087955a7
[ 1555.958071] R13: 0000000000000404 R14: 0000000000000000 R15: ffffffffffffffff
[ 1555.958075] Code: e9 33 fd ff ff 4c 89 e0 41 8b 8d 20 05 00 00 89 de 48 c7 c7 10 47 05 ae 48 89 85 48 ff ff ff 44 8b 85 70 ff ff ff e8 80 0d 93 ff <0f> 0b 48 8b 85 48 ff ff ff e9 ed fd ff ff 41 8b 8d 20 05 00 00 
[ 1555.958180] ---[ end trace e7da03c87ec51f13 ]---

(complete log available but it seems that only R08 is changing between
these traces)

Followed by a "recvmsg bug 2:":

[ 1563.657991] ------------[ cut here ]------------
[ 1563.657992] recvmsg bug 2: copied ABEA08B2 seq 6A7E3970 rcvnxt ABECA5EE fl 0
[ 1563.658002] WARNING: CPU: 1 PID: 2177 at /home/corsac/projets/linux/linux/net/ipv4/tcp.c:1864 tcp_recvmsg+0x647/0xb40
[ 1563.658002] Modules linked in: esp4 xfrm6_mode_tunnel xfrm4_mode_tunnel bnep ipheth rtsx_pci_sdmmc snd_hda_codec_realtek iwlmvm snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_intel iwlwifi snd_hda_codec snd_hwdep rtsx_pci snd_hda_core snd_pcm thinkpad_acpi efivarfs input_leds
[ 1563.658016] CPU: 1 PID: 2177 Comm: pool Tainted: G        W       T 4.17.0 #22
[ 1563.658017] Hardware name: LENOVO 20CMCTO1WW/20CMCTO1WW, BIOS N10ET48W (1.27 ) 09/12/2017
[ 1563.658019] RIP: 0010:tcp_recvmsg+0x647/0xb40
[ 1563.658020] RSP: 0018:ffffb77e010f7cf8 EFLAGS: 00010282
[ 1563.658022] RAX: 0000000000000000 RBX: 00000000416bcf42 RCX: 0000000000000006
[ 1563.658023] RDX: 0000000000000007 RSI: 0000000000000086 RDI: ffffa37a8dc95610
[ 1563.658024] RBP: ffffb77e010f7db8 R08: 000000000013fd88 R09: 0000000000000004
[ 1563.658026] R10: ffffa37a3b1180c8 R11: 0000000000000001 R12: ffffa37a81d40e00
[ 1563.658027] R13: ffffa37a3b118000 R14: ffffa37a3b118524 R15: 0000000000000000
[ 1563.658028] FS:  0000738f795c0700(0000) GS:ffffa37a8dc80000(0000) knlGS:0000000000000000
[ 1563.658030] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1563.658031] CR2: 00007f967818b048 CR3: 000000024200c003 CR4: 00000000003606e0
[ 1563.658032] Call Trace:
[ 1563.658040]  inet_recvmsg+0x5c/0x110
[ 1563.658046]  __sys_recvfrom+0xf2/0x160
[ 1563.658054]  __x64_sys_recvfrom+0x1f/0x30
[ 1563.658060]  do_syscall_64+0x72/0x1c0
[ 1563.658062]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1563.658065] RIP: 0033:0x73901a71deae
[ 1563.658070] RSP: 002b:0000738f795bee50 EFLAGS: 00000246 ORIG_RAX: 000000000000002d
[ 1563.658080] RAX: ffffffffffffffda RBX: 0000000000000028 RCX: 000073901a71deae
[ 1563.658085] RDX: 0000000000000404 RSI: 0000738f087955a7 RDI: 0000000000000028
[ 1563.658089] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[ 1563.658092] R10: 0000000000000000 R11: 0000000000000246 R12: 0000738f087955a7
[ 1563.658097] R13: 0000000000000404 R14: 0000000000000000 R15: ffffffffffffffff
[ 1563.658102] Code: ff ff 41 8b 8d 20 05 00 00 48 c7 c7 40 47 05 ae 4c 89 95 48 ff ff ff 41 8b 54 24 28 44 8b 85 70 ff ff ff 41 8b 36 e8 49 0d 93 ff <0f> 0b 4c 8b 95 48 ff ff ff e9 89 fb ff ff 49 8b 55 60 83 e2 02 
[ 1563.658219] ---[ end trace e7da03c87ec5c408 ]---

and finally a NULL pointer dereference:

[ 1563.658223] BUG: unable to handle kernel NULL pointer dereference at 0000000000000028
[ 1563.658230] PGD 0 P4D 0 
[ 1563.658234] Oops: 0000 [#1] PREEMPT SMP PTI
[ 1563.658237] Modules linked in: esp4 xfrm6_mode_tunnel xfrm4_mode_tunnel bnep ipheth rtsx_pci_sdmmc snd_hda_codec_realtek iwlmvm snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_intel iwlwifi snd_hda_codec snd_hwdep rtsx_pci snd_hda_core snd_pcm thinkpad_acpi efivarfs input_leds
[ 1563.658253] CPU: 1 PID: 2177 Comm: pool Tainted: G        W       T 4.17.0 #22
[ 1563.658255] Hardware name: LENOVO 20CMCTO1WW/20CMCTO1WW, BIOS N10ET48W (1.27 ) 09/12/2017
[ 1563.658258] RIP: 0010:tcp_recvmsg+0x1eb/0xb40
[ 1563.658260] RSP: 0018:ffffb77e010f7cf8 EFLAGS: 00010282
[ 1563.658263] RAX: 0000000000000000 RBX: 00000000416bcf42 RCX: 0000000000000006
[ 1563.658265] RDX: 0000000000000007 RSI: 0000000000000086 RDI: ffffa37a8dc95610
[ 1563.658268] RBP: ffffb77e010f7db8 R08: 000000000013fd88 R09: 0000000000000004
[ 1563.658270] R10: ffffa37a3b1180c8 R11: 0000000000000001 R12: ffffa37a81d40e00
[ 1563.658272] R13: ffffa37a3b118000 R14: ffffa37a3b118524 R15: 0000000000000000
[ 1563.658275] FS:  0000738f795c0700(0000) GS:ffffa37a8dc80000(0000) knlGS:0000000000000000
[ 1563.658278] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1563.658280] CR2: 0000000000000028 CR3: 000000024200c003 CR4: 00000000003606e0
[ 1563.658282] Call Trace:
[ 1563.658287]  inet_recvmsg+0x5c/0x110
[ 1563.658291]  __sys_recvfrom+0xf2/0x160
[ 1563.658295]  __x64_sys_recvfrom+0x1f/0x30
[ 1563.658298]  do_syscall_64+0x72/0x1c0
[ 1563.658302]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1563.658304] RIP: 0033:0x73901a71deae
[ 1563.658306] RSP: 002b:0000738f795bee50 EFLAGS: 00000246 ORIG_RAX: 000000000000002d
[ 1563.658309] RAX: ffffffffffffffda RBX: 0000000000000028 RCX: 000073901a71deae
[ 1563.658311] RDX: 0000000000000404 RSI: 0000738f087955a7 RDI: 0000000000000028
[ 1563.658312] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[ 1563.658314] R10: 0000000000000000 R11: 0000000000000246 R12: 0000738f087955a7
[ 1563.658316] R13: 0000000000000404 R14: 0000000000000000 R15: ffffffffffffffff
[ 1563.658318] Code: 8b 44 24 78 41 39 d8 77 57 41 f6 44 24 34 01 0f 85 24 01 00 00 45 85 ff 0f 84 40 04 00 00 49 8b 04 24 49 39 c2 0f 84 1d 02 00 00 <8b> 50 28 41 8b 1e 39 d3 0f 88 f4 03 00 00 49 89 c4 29 d3 41 f6 
[ 1563.658365] RIP: tcp_recvmsg+0x1eb/0xb40 RSP: ffffb77e010f7cf8
[ 1563.658366] CR2: 0000000000000028
[ 1563.658369] ---[ end trace e7da03c87ec5c409 ]---

If you need more information, please ask.

Regards,
- -- 
Yves-Alexis
-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE8vi34Qgfo83x35gF3rYcyPpXRFsFAlsXmYcACgkQ3rYcyPpX
RFtK6QgArIJyLOT8Lot0jdQehm9MfL6iNUWNSHbEckhK80zYQCLUodj8VQJsmeu1
1hZwvg/Kuw0vxLG3i744NxcbCncfoaBUkZHoUmCZxFzyUeQVviAf9EaLp6cU0JPk
ZBSKPeoPMF9WlBKecV9O/j6T6FRjbSmV/J7esj6vNFXm3iwOh1Yp0cugpU+j+/IA
BxWVkKWZqS/uxtXaakoYdYOvrcRRpxcGKNXHajGW2AKXqybfoPgx0tSWzQ8bpn/o
3NtU9AL5flo4CgmnSY+qXtwT1fnNEtSVbbRmWyrMRpzzLLzTE2v4Pn5043J1Q1C6
EmfVzeYke69MSSGG/fqrLeEV6PzLZQ==
=C7Mx
-----END PGP SIGNATURE-----
