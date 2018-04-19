Date: Thu, 19 Apr 2018 09:56:08 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net,
	shuahkh@osg.samsung.com, patches@kernelci.org,
	ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
	stable@vger.kernel.org, Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 4.9 00/66] 4.9.95-stable review
Message-ID: <20180419075608.GA4230@kroah.com>
References: <20180417155645.868055442@linuxfoundation.org>
 <20180418174244.ke5n4uhbj5geijco@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418174244.ke5n4uhbj5geijco@xps>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 12:42:44PM -0500, Dan Rue wrote:
> On Tue, Apr 17, 2018 at 05:58:33PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.9.95 release.
> > There are 66 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Apr 19 15:56:27 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.95-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> > and the diffstat can be found below.
> 
> We've noticed a regression on arm32 in sendto() and send() system calls,
> causing them to hang forever.
> 
> The easiest way we have found to reproduce, is to simply run 'ip link'.
> When running 'strace -T ip link' we see:
> 
>     ...
>     getsockname(3, {sa_family=AF_NETLINK, nl_pid=364, nl_groups=00000000}, [12]) = 0 <0.000079>
>     .... long wait (10 minute) and then eventually:
>     send(3, {{len=40, type=0x12 /* NLMSG_??? */, flags=NLM_F_REQUEST|0x300, seq=1522961259, pid=0}, \"\21\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\10\0\35\0\1\0\0\0\"}, 40, 0[  807.868633] random: crng init done
> 
> Ignore the 'random: crng init done' - I believe it is causing the dmesg
> buffer to print which is what gets us our send() output.
> 
> We saw a similar strace hang on sendto() with the ltp 'gethostid01' test.
> 
> We've also observed the following kernel log during boot on the x15/arm32
> device:
> 
>     [   13.555030] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
>     [   13.580352] net eth0: initializing cpsw version 1.15 (0)
>     [   13.708220] Unable to handle kernel NULL pointer dereference at virtual address 00000008
>     [   13.716375] pgd = ed724f40
>     [   13.719126] [00000008] *pgd=ac173003, *pmd=fb03d003
>     [   13.724068] Internal error: Oops: 207 [#1] SMP ARM
>     [   13.728882] Modules linked in: snd_soc_simple_card snd_soc_simple_card_utils snd_soc_core snd_pcm_dmaengine snd_pcm snd_timer snd soundcore ac97_bus
>     [   13.742337] CPU: 0 PID: 243 Comm: NetworkManager Not tainted 4.9.95-rc1 #1
>     [   13.749241] Hardware name: Generic DRA74X (Flattened Device Tree)
>     [   13.755360] task: ed6a6e40 task.stack: ec114000
>     [   13.759916] PC is at kszphy_config_reset+0x1c/0x150
>     [   13.764815] LR is at kszphy_resume+0x24/0x64
>     [   13.769104] pc : [<c0b6f680>]    lr : [<c0b6f940>]    psr: 600e0113
>     [   13.769104] sp : ec115920  ip : ec115940  fp : ec11593c
>     [   13.780630] r10: 00000000  r9 : 00000007  r8 : 00000000
>     [   13.785877] r7 : ed049800  r6 : 00000000  r5 : ee1d3800  r4 : ed049c00
>     [   13.792431] r3 : 00000001  r2 : 00000000  r1 : 00000110  r0 : ed049c00
>     [   13.798987] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
>     [   13.806152] Control: 30c5387d  Table: ad724f40  DAC: fffffffd
>     [   13.811923] Process NetworkManager (pid: 243, stack limit = 0xec114220)
>     [   13.818564] Stack: (0xec115920 to 0xec116000)
>     [   13.822941] 5920: ed049c00 ee1d3800 00000000 ed049800 ec115954 ec115940 c0b6f940 c0b6f670
>     [   13.831154] 5940: ed049c00 ee1d3800 ec115984 ec115958 c0b693f8 c0b6f928 00000007 ed049c00
>     [   13.839368] 5960: ed049c00 c0c11cec c0c11cec 00000007 ee1d3e0c 00000000 ec1159a4 ec115988
>     [   13.847582] 5980: c0b69600 c0b69340 ee6af854 ed049c00 ee1d3800 c0c11cec ec1159cc ec1159a8
>     [   13.855795] 59a0: c0b6968c c0b695e8 ed040310 ee1d3e00 00000000 ee4fbc10 ee4fbc10 ee1d3e0c
>     [   13.864009] 59c0: ec115a04 ec1159d0 c0c0e47c c0b69644 00000001 00000000 c04d5160 ee4fbc10
>     [   13.872222] 59e0: ee1d3e00 ee1d3800 ee4fbc10 00000000 00000001 ed3aad80 ec115aa4 ec115a08
>     [   13.880436] 5a00: c0c11634 c0c0e258 00000000 c0476cec c0ef92e0 c0476cec c0df67b8 fffffff4
>     [   13.888647] 5a20: ec115aac fffffff3 ec115aac 0000000d 00000000 00000000 ec115a6c ec115a48
>     [   13.896861] 5a40: c0476cec c0eba8ac ec115aac 0000000d ee1d3800 00001002 00000000 ed5a7810
>     [   13.905074] 5a60: ec115a84 ec115a70 c0476ed0 c0476ca4 00000000 c0de20fc ec115aa4 ee1d3800
>     [   13.913287] 5a80: 00000000 c1193410 ee1d3830 00000000 ed5a7810 ed3aad80 ec115acc ec115aa8
>     [   13.921500] 5aa0: c0deeb64 c0c1118c ec115acc ee1d3800 ee1d3800 00001003 00000001 00001002
>     [   13.929713] 5ac0: ec115af4 ec115ad0 c0deee4c c0deeab4 ee1d3800 00001002 00000000 ee1d394c
>     [   13.937925] 5ae0: 00000000 ed5a7810 ec115b1c ec115af8 c0deef24 c0deedb4 ee1d3800 ec115c28
>     [   13.946137] 5b00: 00000000 c1193410 00000000 ed5a7810 ec115b8c ec115b20 c0e025f0 c0deef08
>     [   13.954351] 5b20: c0491510 c04aa8d4 00000000 ec115b38 00000000 00000003 00000000 00000000
>     [   13.962563] 5b40: 00000000 c230d40c ed6a7338 00000001 00000002 c1a58e78 c1a80870 ed6a6e40
>     [   13.970775] 5b60: ec115bfc 00000000 ee1d3800 00000000 00000000 00000000 00000000 ed5a7800
>     [   13.978988] 5b80: ec115d04 ec115b90 c0e04554 c0e0230c ec115bc4 00000000 ed3aad80 c11cb12c
>     [   13.987202] 5ba0: ed5a7820 c1b68b40 00000000 c1b69b50 ec115b90 ed5a7810 ec115c54 ec115bc8
>     [   13.995416] 5bc0: c04adef0 c04acd00 ec115c64 ec115bd8 c04adef0 00000000 00000000 00000000
>     [   14.003629] 5be0: 00000000 00000000 00000000 c230d400 ed6a7318 00000000 00000001 c230d40c
>     [   14.011842] 5c00: ed6a72f8 00000001 00000000 c1b69b84 c1a80870 ed6a6e40 ec115cb4 ec115c28
>     [   14.020054] 5c20: c04adef0 c04acdd4 00000000 00000000 00000000 00000000 00000000 00000000
>     [   14.028266] 5c40: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>     [   14.036479] 5c60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>     [   14.044691] 5c80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>     [   14.052903] 5ca0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>     [   14.061115] 5cc0: 00000000 00000000 00000000 00000000 00000000 00000000 c0e194b0 c0e040a4
>     [   14.069328] 5ce0: ed5a7800 c236d9e4 ed3aad80 ec115d84 00000000 00000000 ec115d44 ec115d08
>     [   14.077540] 5d00: c0e04908 c0e040b0 c0f458a8 c04ad82c 00000001 00000000 c0e01c0c 00000000
>     [   14.085753] 5d20: ed5a7800 c0e04828 ed3aad80 ed3aad80 ec115d84 00000000 ec115d64 ec115d48
>     [   14.093966] 5d40: c0e1e538 c0e04834 ed3aad80 ec212000 00000020 ed3aad80 ec115d7c ec115d68
>     [   14.102179] 5d60: c0e01c1c c0e1e494 ee2f0400 ec212000 ec115dac ec115d80 c0e1de70 c0e01bf0
>     [   14.110391] 5d80: ec115e24 7fffffff ec115f48 ec212000 ed3aad80 00000000 00000020 00000000
>     [   14.118603] 5da0: ec115e0c ec115db0 c0e1e29c c0e1dcfc ec115e24 ec115e48 0000000c 00000001
>     [   14.126817] 5dc0: be8be8b4 00000008 00000000 ed73bd00 00000000 000000f3 00000000 00000000
>     [   14.135031] 5de0: ec115e24 ec115f48 00000000 00000000 eddf6d80 ec115e28 00000000 00000000
>     [   14.143244] 5e00: ec115e1c ec115e10 c0dc8304 c0e1dfe4 ec115f34 ec115e20 c0dc8a70 c0dc82ec
>     [   14.151457] 5e20: ec115e84 00000000 c04afaa8 c04adb9c 00000001 00000000 600b0013 c1b7a9a4
>     [   14.159670] 5e40: 00000001 c1a4405c 001fa4f0 00000020 c04b00cc c04c87a0 c04afaa8 c04adb9c
>     [   14.167884] 5e60: 00000000 00000000 ffffe000 00000000 600b0013 00004000 00000000 c05fed1c
>     [   14.176097] 5e80: 600b0013 c04aa828 00000010 00000000 00000000 00000008 00004000 ed45ea00
>     [   14.184308] 5ea0: c1b79b7b c13c1e6c ec115efc ec115eb8 c05fed48 c04afc5c 00000000 00000000
>     [   14.192522] 5ec0: c05febb8 ec115ed0 c13e1ce0 ed45ea90 00000000 ec115f44 ec115f40 00000008
>     [   14.200735] 5ee0: 00000128 c0408e04 ec114000 00000000 ec115f0c ec115f00 c05fee84 c05febc4
>     [   14.208949] 5f00: ec115f1c ec115f10 c05fef04 be8be89c 00000000 eddf6d80 00000128 c0408e04
>     [   14.217162] 5f20: ec114000 00000000 ec115f94 ec115f38 c0dc9884 c0dc889c 00000000 00000000
>     [   14.225375] 5f40: 00000001 fffffff7 ec115e88 0000000c 00000001 00000000 00000000 ec115e50
>     [   14.233588] 5f60: 00000000 00000006 00000000 00000000 00000000 00000000 ec115f94 00000000
>     [   14.241801] 5f80: be8be89c 00000008 ec115fa4 ec115f98 c0dc98c8 c0dc9840 00000000 ec115fa8
>     [   14.250013] 5fa0: c0408c80 c0dc98bc 00000000 be8be89c 00000008 be8be89c 00000000 00000000
>     [   14.258225] 5fc0: 00000000 be8be89c 00000008 00000128 b69d9390 be8be900 00000000 001a93e0
>     [   14.266438] 5fe0: b6f316e0 be8be840 00000000 b699a4a4 800b0010 00000008 00000000 00000000
>     [   14.274661] [<c0b6f680>] (kszphy_config_reset) from [<c0b6f940>] (kszphy_resume+0x24/0x64)
>     [   14.282966] [<c0b6f940>] (kszphy_resume) from [<c0b693f8>] (phy_attach_direct+0xc4/0x1cc)
>     [   14.291183] [<c0b693f8>] (phy_attach_direct) from [<c0b69600>] (phy_connect_direct+0x24/0x5c)
>     [   14.299747] [<c0b69600>] (phy_connect_direct) from [<c0b6968c>] (phy_connect+0x54/0x88)
>     [   14.307792] [<c0b6968c>] (phy_connect) from [<c0c0e47c>] (cpsw_slave_open+0x230/0x294)
>     [   14.315749] [<c0c0e47c>] (cpsw_slave_open) from [<c0c11634>] (cpsw_ndo_open+0x4b4/0x618)
>     [   14.323883] [<c0c11634>] (cpsw_ndo_open) from [<c0deeb64>] (__dev_open+0xbc/0x124)
>     [   14.331498] [<c0deeb64>] (__dev_open) from [<c0deee4c>] (__dev_change_flags+0xa4/0x154)
>     [   14.331507] [<c0deee4c>] (__dev_change_flags) from [<c0deef24>] (dev_change_flags+0x28/0x58)
>     [   14.331522] [<c0deef24>] (dev_change_flags) from [<c0e025f0>] (do_setlink+0x2f0/0x890)
>     [   14.331531] [<c0e025f0>] (do_setlink) from [<c0e04554>] (rtnl_newlink+0x4b0/0x784)
>     [   14.331539] [<c0e04554>] (rtnl_newlink) from [<c0e04908>] (rtnetlink_rcv_msg+0xe0/0x1fc)
>     [   14.331550] [<c0e04908>] (rtnetlink_rcv_msg) from [<c0e1e538>] (netlink_rcv_skb+0xb0/0xcc)
>     [   14.331559] [<c0e1e538>] (netlink_rcv_skb) from [<c0e01c1c>] (rtnetlink_rcv+0x38/0x40)
>     [   14.331567] [<c0e01c1c>] (rtnetlink_rcv) from [<c0e1de70>] (netlink_unicast+0x180/0x210)
>     [   14.331575] [<c0e1de70>] (netlink_unicast) from [<c0e1e29c>] (netlink_sendmsg+0x2c4/0x380)
>     [   14.331584] [<c0e1e29c>] (netlink_sendmsg) from [<c0dc8304>] (sock_sendmsg+0x24/0x34)
>     [   14.331593] [<c0dc8304>] (sock_sendmsg) from [<c0dc8a70>] (___sys_sendmsg+0x1e0/0x1f0)
>     [   14.331601] [<c0dc8a70>] (___sys_sendmsg) from [<c0dc9884>] (__sys_sendmsg+0x50/0x7c)
>     [   14.331610] [<c0dc9884>] (__sys_sendmsg) from [<c0dc98c8>] (SyS_sendmsg+0x18/0x1c)
>     [   14.331620] [<c0dc98c8>] (SyS_sendmsg) from [<c0408c80>] (ret_fast_syscall+0x0/0x1c)
>     [   14.331629] Code: e52de004 e8bd4000 e59062dc e1a04000 (e5d63008) 
>     [   14.331751] ---[ end trace 7927abed2565423d ]---
> 
> Full output of a lava job that shows both of these symptoms can be seen
> at https://lkft.validation.linaro.org/scheduler/job/187562.
> 
> Looking through the patches, it's not obvious to me where the issue may
> be. We haven't bisected it yet but will begin. I noticed quite a few arm
> changes from Mark Rutland, and a change to net/rds/send.c from Ka-Cheong
> Poon. Both added to CC.

Can you try 'git bisect'?  I'll hold off on releasing 4.9.y until this
gets figured out.

thanks,

greg k-h
