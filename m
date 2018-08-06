Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4437AC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 00:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B797A21991
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 00:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B797A21991
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeHFC4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 22:56:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:36599 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbeHFC4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 22:56:34 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2018 17:49:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,450,1526367600"; 
   d="gz'50?scan'50,208,50";a="222138924"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.4])
  by orsmga004.jf.intel.com with ESMTP; 05 Aug 2018 17:49:55 -0700
Date:   Mon, 6 Aug 2018 08:50:30 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        LKP <lkp@01.org>
Subject: [LKP] d2ba09c17a [ 8.644676] BUG: unable to handle kernel paging
 request at cd8dcf6c
Message-ID: <20180806005030.GA18936@shao2-debian>
Reply-To: kernel test robot <lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit d2ba09c17a0647f899d6c20a11bab9e6d3382f07
Author:     Alexei Starovoitov <ast@kernel.org>
AuthorDate: Mon May 21 19:22:30 2018 -0700
Commit:     David S. Miller <davem@davemloft.net>
CommitDate: Wed May 23 13:23:40 2018 -0400

    net: add skeleton of bpfilter kernel module
    
    bpfilter.ko consists of bpfilter_kern.c (normal kernel module code)
    and user mode helper code that is embedded into bpfilter.ko
    
    The steps to build bpfilter.ko are the following:
    - main.c is compiled by HOSTCC into the bpfilter_umh elf executable file
    - with quite a bit of objcopy and Makefile magic the bpfilter_umh elf file
      is converted into bpfilter_umh.o object file
      with _binary_net_bpfilter_bpfilter_umh_start and _end symbols
      Example:
      $ nm ./bld_x64/net/bpfilter/bpfilter_umh.o
      0000000000004cf8 T _binary_net_bpfilter_bpfilter_umh_end
      0000000000004cf8 A _binary_net_bpfilter_bpfilter_umh_size
      0000000000000000 T _binary_net_bpfilter_bpfilter_umh_start
    - bpfilter_umh.o and bpfilter_kern.o are linked together into bpfilter.ko
    
    bpfilter_kern.c is a normal kernel module code that calls
    the fork_usermode_blob() helper to execute part of its own data
    as a user mode process.
    
    Notice that _binary_net_bpfilter_bpfilter_umh_start - end
    is placed into .init.rodata section, so it's freed as soon as __init
    function of bpfilter.ko is finished.
    As part of __init the bpfilter.ko does first request/reply action
    via two unix pipe provided by fork_usermode_blob() helper to
    make sure that umh is healthy. If not it will kill it via pid.
    
    Later bpfilter_process_sockopt() will be called from bpfilter hooks
    in get/setsockopt() to pass iptable commands into umh via bpfilter.ko
    
    If admin does 'rmmod bpfilter' the __exit code bpfilter.ko will
    kill umh as well.
    
    Signed-off-by: Alexei Starovoitov <ast@kernel.org>
    Signed-off-by: David S. Miller <davem@davemloft.net>

449325b52b  umh: introduce fork_usermode_blob() helper
d2ba09c17a  net: add skeleton of bpfilter kernel module
0b5b1f9a78  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
116b181bb6  Add linux-next specific files for 20180803
+------------------------------------------+------------+------------+------------+---------------+
|                                          | 449325b52b | d2ba09c17a | 0b5b1f9a78 | next-20180803 |
+------------------------------------------+------------+------------+------------+---------------+
| boot_successes                           | 265        | 69         | 77         | 10            |
| boot_failures                            | 59         | 38         | 28         | 19            |
| BUG:workqueue_lockup-pool                | 56         | 20         | 24         |               |
| invoked_oom-killer:gfp_mask=0x           | 2          | 2          | 1          |               |
| Mem-Info                                 | 3          | 4          | 2          |               |
| EIP:__put_user_4                         | 1          |            |            |               |
| BUG:unable_to_handle_kernel              | 0          | 14         | 2          | 19            |
| Oops:#[##]                               | 0          | 14         | 2          | 19            |
| EIP:fput                                 | 0          | 14         | 2          | 19            |
| Kernel_panic-not_syncing:Fatal_exception | 0          | 14         | 2          | 19            |
| EIP:iov_iter_fault_in_readable           | 0          | 1          |            |               |
| Out_of_memory:Kill_process               | 0          | 0          | 1          |               |
+------------------------------------------+------------+------------+------------+---------------+

[    8.622364] NET: Registered protocol family 10
[    8.624402] Segment Routing with IPv6
[    8.625167] mip6: Mobile IPv6
[    8.641639] kworker/u2:2 (99) used greatest stack depth: 7120 bytes left
[    8.642851] kworker/u2:2 (98) used greatest stack depth: 7092 bytes left
[    8.644676] BUG: unable to handle kernel paging request at cd8dcf6c
[    8.645008] *pde = 0f7d5067 *pte = 0d8dc060 
[    8.645008] Oops: 0002 [#1] DEBUG_PAGEALLOC
[    8.645008] Modules linked in:
[    8.645008] CPU: 0 PID: 1 Comm: swapper Tainted: G                T 4.17.0-rc6-01470-gd2ba09c #1
[    8.645008] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[    8.645008] EIP: fput+0x0/0x90
[    8.645008] EFLAGS: 00210246 CPU: 0
[    8.645008] EAX: cd8dcec0 EBX: cd8dcec0 ECX: 00000001 EDX: 00000000
[    8.645008] ESI: 000c5e20 EDI: fffffff8 EBP: cf079f2c ESP: cf079f0c
[    8.645008]  DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068
[    8.645008] CR0: 80050033 CR2: cd8dcf6c CR3: 020d1000 CR4: 001406d0
[    8.645008] Call Trace:
[    8.645008]  ? fork_usermode_blob+0x6a/0xb0
[    8.645008]  ? ipv6_exthdrs_offload_init+0x42/0x42
[    8.645008]  load_umh+0x1d/0x5f
[    8.645008]  do_one_initcall+0x40/0x17e
[    8.645008]  ? do_early_param+0x73/0x73
[    8.645008]  kernel_init_freeable+0xdd/0x15c
[    8.645008]  ? rest_init+0xd0/0xd0
[    8.645008]  kernel_init+0x8/0xe0
[    8.645008]  ret_from_fork+0x2e/0x38
[    8.645008] Code: f5 c1 89 da e8 12 db fe ff 5b 5d c3 8d b4 26 00 00 00 00 e8 e3 de f0 ff a1 20 80 f5 c1 89 da e8 f7 da fe ff 5b 5d c3 8d 74 26 00 <ff> 88 ac 00 00 00 74 08 c3 8d b4 26 00 00 00 00 55 8b 15 1c b6 
[    8.645008] EIP: fput+0x0/0x90 SS:ESP: 0068:cf079f0c
[    8.645008] CR2: 00000000cd8dcf6c
[    8.645008] ---[ end trace 5661140b357de987 ]---
[    8.645008] Kernel panic - not syncing: Fatal exception

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start acb1872577b346bd15ab3a3f8dff780d6cca4b70 v4.17 --
git bisect  bad 9d2e34897d8dfe8b85603ee0a5d4f0481e991824  # 16:15  B      1     4    1   1  Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
git bisect  bad 5e4e290d3751607726a62f0b49e11261a0a9345e  # 16:44  B      0     2   17   0  ARM: disable KCOV for trusted foundations code
git bisect  bad a8a4021b776b4475e8a4657185a718cdfc07b88c  # 17:05  B      0     3   18   0  Merge branch 'core-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good ec064d3c6b40697fd72f4b1eeabbf293b7947a04  # 17:24  G    121     0   56  56  Merge tag 'driver-core-4.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
git bisect  bad 3a979e8c07e3ee9933016368db0a55943b00a089  # 17:46  B      0     2   17   0  Merge tag 'mailbox-v4.18' of git://git.linaro.org/landing-teams/working/fujitsu/integration
git bisect good 10b1eb7d8ce5635a7deb273f8291d8a0a7681de1  # 18:14  G    118     0   53  55  Merge branch 'next-general' of git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security
git bisect  bad 70f2ae1f002b0ed4b4382210df8e4b6e54079012  # 18:29  B      0     2   17   0  Merge tag 'ovl-fixes-4.18' of git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs
git bisect good 5eb6eed7e0fe880dc8de8da203cc888716bbf196  # 18:56  G    118     0   43  43  Merge tag 'trace-v4.18' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
git bisect  bad 1c8c5a9d38f607c0b6fd12c91cbe1a4418762a21  # 19:16  B      0     2   18   0  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
git bisect good 285767604576148fc1be7fcd112e4a90eb0d6ad2  # 19:36  G    120     0   62  62  Merge tag 'overflow-v4.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
git bisect good 10f678683e4026e43524b0492068a371d00fdeed  # 19:57  G    117     0   50  50  Merge branch 'xdp_xmit-bulking'
git bisect  bad a45675796a0763f5e0ffb75496c3865e961560d3  # 20:06  B      0     1   16   0  8139too: Remove unnecessary netif_napi_del()
git bisect good ec932fbda7ba6ac10dba59fd20c736be9a6976e4  # 20:30  G    121     0   47  47  mlxsw: use devlink helper to generate physical port name
git bisect  bad 5a867abdf6db501af37004c331a7dbe81d4fe0b2  # 20:46  B     28     3   10  10  Merge branch 'qca8k-QCA8334-switch-support'
git bisect good 9b10df596bd4d38f2a58cf87e0780510acc53d8d  # 21:01  G    117     0   41  41  i40e: use WARN_ONCE to replace the commented BUG_ON size check
git bisect  bad a0d163f4327febeae2c98c4b1aaff3552e5b1667  # 21:18  B      1     1    0   0  nfp: add shared buffer configuration
git bisect good 9c803cfd5fe211cb7d3a7157b489209f8cc527a2  # 21:45  G    117     0   36  36  Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue
git bisect good 8673daf4f55bf3b918dec78aee2132d191225106  # 22:10  G    123     0   40  40  qedf: Add get_generic_tlv_data handler.
git bisect good 449325b52b7a6208f65ed67d3484fd7b7184477b  # 22:30  G    117     0   34  34  umh: introduce fork_usermode_blob() helper
git bisect  bad e95a5f548945c1c212b92e3b88cfb571a7bb95ca  # 22:40  B      5     2    1   1  Merge branch 'bpfilter'
git bisect  bad d2ba09c17a0647f899d6c20a11bab9e6d3382f07  # 22:51  B      5     5    2   2  net: add skeleton of bpfilter kernel module
# first bad commit: [d2ba09c17a0647f899d6c20a11bab9e6d3382f07] net: add skeleton of bpfilter kernel module
git bisect good 449325b52b7a6208f65ed67d3484fd7b7184477b  # 23:06  G    354     0   92 128  umh: introduce fork_usermode_blob() helper
# extra tests with debug options
git bisect  bad d2ba09c17a0647f899d6c20a11bab9e6d3382f07  # 23:17  B      2     6    2   2  net: add skeleton of bpfilter kernel module
# extra tests on HEAD of linux-devel/devel-hourly-2018080409
git bisect  bad 03bcc90a4082341dae8a4a540af17a0d79cf07af  # 23:17  B     16     4    0  31  0day head guard for 'devel-hourly-2018080409'
# extra tests on tree/branch linus/master
git bisect  bad 0b5b1f9a78b5e1bb3c3972fcd27dc013367550f8  # 23:34  B      1     1    1   1  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
# extra tests on tree/branch linux-next/master
git bisect  bad 116b181bb646afedd770985de20a68721bdb2648  # 23:45  B      0     2   17   0  Add linux-next specific files for 20180803

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--u3/rZRmxL6MmkK24
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-ivb41-105:20180804225411:i386-randconfig-sb0-08041433:4.17.0-rc6-01470-gd2ba09c:1.gz"
Content-Transfer-Encoding: base64

H4sICFrKZVsAA2RtZXNnLXlvY3RvLWl2YjQxLTEwNToyMDE4MDgwNDIyNTQxMTppMzg2LXJh
bmRjb25maWctc2IwLTA4MDQxNDMzOjQuMTcuMC1yYzYtMDE0NzAtZ2QyYmEwOWM6MQC8XFlz
27iyfs+v6FvzMPYZSya4aanSqSvLcqyyZWssJ5N7UikVRYIyjylSw8VLKj/+dgPUSlKWHGWU
irkBHxqNbnQ30CS3Iv8V7DCIQ5+DF0DMk3SGNxz+YRCFYy+YQPf8HI6447RC14UkBMeLrbHP
j6vVKoSPH/gmBH9JIstORo88Crj/wQtmaTJyrMRqgvKiqHrNUOpKdtvngbir1G2z7rgfwjTB
2+IWU8Qvu7UoydjYtZn9QaKPkjCx/FHsfefyqaO7VOnDObfD6SzicUxduPaC9IXoHViRuNG9
vqDLmxAi7oe2lXhhAAHnDnfovhMGvPrhLAwTKpw8cJDNVT98BfwpVUnbNwkMTxxREUCvslpV
qUS2WVGYXlMqE0cdW0rDhqPHcer5zv/6j7PKQ4xcOIajiW2v1GxUdTg652PPyq4q6vEx/MZg
aCXQTiegg6o2daOp69AZ3oOqsPomNVfdu5vuNcTpbBZGCXfAnqVxc7MUQC9IuA8feZB6ARcX
+TLt/jk2i10PEs/Gi3yJDj6y0mh+vLRSP86Xuo+sIJ7yxJq3d99/qZvbyi3OOoNPm+Ww6qk7
S5swlH2k4fkybH/ugsutJI24ECbWhN9f6jVw/dASRWahFyQ41BMvTpDjv78PVkXY4bD70zg6
4rQ/f9kF5yVOrISPUPNQMb+q35oARs08md8nuY/lbdXIMXWB0g1IYZ2s1pyWGImpnZDmJqiy
QFjgxVDXVBi/Jjw+gVToyu9YK3CsyPkd3DCaWklOC3hdVZpw1rsdVmZR+OShFsHs4TX2bMuH
u3YfptYsJ4aiuKz5dcqngjPrv8rarYY7dt1vSBP1ZS+whmvnwVwCQybw6Ik7e8G5edrc98Ox
XFdd12Huu7qKNdUc2Ltpc7lLjFuFo1vvhpNoa3BvUufwcTppgjcJwohk0Q8nPn/CyQvVgbQr
J4pjnLPntuirME0ITCIqVWCz+A3O8DaajpsvcNR94XaK6nGe2TdAWU64LUyDbQVBmMCYz4Ga
EIRBZdDuZpbhfzaRh31iBajVOpAZwjkyR+t5v9eEP7v9TzDMNAwGHTjydF25+AJ/wKDX+3IC
rNEwj08EY4FVmVJVKwwU/VRhp2gD9E3Qy9cZctKLwwiZR+QTrVef+8U6m84cmhE2hmo+RCtS
CK3Wv0tHSWJFfBo+rWJZS6xsmIslWlb3rTgZzdwAWlibJBlnjZeRFdkPi7tSVzar9+/v7rCv
LtqfBBLsfhOeIy/hlbFlPxYWdr0XnKHQzExwEpwPaN4kSV40LvC3BRFNpSh3JsqlgW3ZD0W9
RIMpyl2s4GUSVkjkkxV5gvNv0wljK0bTgm6V/CHn4ke4uFhcb6OKzR263LCiUdnyTNvyTN/y
zNjyzNzyrFb6jOzcoH3fhE4YuN4kjaQ791Wp1NAy/nUG8FcH4FOngv9BXg/k9V/3ADnFRV0n
Q4caPCB3tkQ3NJTn3auumCBpenavumJu3MKqbpgGjqjXH1QSITLoMq4AmJY5B8BTVEM0xzNU
ACp1NEuiJ8s/zqECTGd2E7AG+rGuOa7lvE0v8BIPDTw2FEavGWhu2qeGVbeY8jMS26w6xgzT
Weijg7hOFzTGJMHCO2GmVs9NeGd3VzjU2IitmXjjBLJzMeEMPt63z667W+rUVurUdqxTX6lT
31YHfZ/z3vBqyRR37GgZU9AcFjKl3RmgWeiKqEqOpv3A7cc4nVK04LleFq2UaYOsfzc8H6y7
LRdmvaGIOY1hpPGEPD277VwO4bgU4H4V4OKiy4xOVwBoCgGwDADOvgw6srj8MXFncVXSwAUe
NhvQ1baoVtNzDcji+zRwnu8B+t7EAqZ127kGzt/Tg2GuAUXyWM+ZKVmnPeh1cmxlkq21eo4o
WXwfoi4H3fy4NUw5bvkGZPF9GrgOyasXhFmOQxE22WvORaHNKtlMI0onIcx/buYMwtHiTgaQ
a1Tpn8Fl7+Nlv9sH68nyfBL6nCulGgaWu779a3sxmBPkh89oV6dNtJ0VmPvN+dI7FXt8mlZs
P7QfmxRvA84M0zgCpYnFiY0n6P95UwunOHoqCm5B+CRCLgSIQR8bpu7gqKBvOL/Y1riM1mKc
LRyQASMeQKsbjVpdZ3WwX22f5yJ0UTkO04jc4BU0ciGawhNb/wmvTELRY2Y7usp1x3XHJ+KR
5/h8FOCzeh3lTjEaTK9rEOTaXZlOG8pyOm1sm07/EwZzd6jADTrvt6UsFYST5DmuhWwlFgkw
IsAQ1y9AydajiiK1PMqlN3noY33g01nymvPvwicxsX+n/mB0HSXC9HP00TCscHJOmjQGmaGk
AhkT8u2Kh3irMKbOMUFp8GLyt8CUx6ubMD30D6i2XFIUkMouZJXh3QZzELHoN7NIDMA0tIZa
LAzE3iZoKoiiqB+oGMRnJAGngW11lKxKWcCzht9o1GXxE7juXdyiM57YD82C2SQTLVlNryu7
0rVWz2RaQy9ojxk55yMjHsZpghHAYlZswpzgzRpy8hGTtRN56G3Mw6piSzDoV+69KZbq3cIg
jMSyrank/MR3mI2sCpUe3fR7cGTZMw+nlq80H30Dx/XFf/QWE7zFvuWsRu+W6n5V0P+3Zp6N
VWlenq+2strJGhFiXQKffxz2QKmoWjE5vZv70fCuM7r9fAdH4zSmuCuNR170N55N/HBs+eJC
ndOXpypAHlGESsSgs0uHJPImdBSAeOzd/SmOglO9c1ic3qCdzgn6m5QZq5QZ8IDzEogVlLeJ
Yxlx2gZxRglxOQF8k7jGKnGNgxDXKCGusTdxbG1Q8eoQ5Fkl5Fn7k8fWyGMHIW9cQt64hLy7
PxU5fY1fIUTtijwn73TtLPWspHX2bkStBDGn4Tsj6iWIubB0wSHjgBwyS1rPLf3vjFgrQay9
G7FeglhiF7BO420OLcqyHQRuWZgdkPd2Sb/sdyM6JYg5d2NnRF6CmPMod0Z0SxDdEt8BWQ9H
/fb5/fFiNcteW5XzArmJhOdbAljPIWeirtRNS8UIiNY3RTDCnUJ/IYvqpNWnQJOce7FudDS3
7rlJ8epzP3NNrfg1sGFwISgWIVxRlBUn3PIT9HfWwjzm1B0jH+yv7YBkkQM5ubSBMhYhzsId
E60OOj30tZ48O++UzXehZ1ZkPXlRklq+9x07K/cdAFlasLq/FtVF3PUC7lT+67muRz7zZmy3
EdPNb28EdKzBlIbZaOiKhkEdaxQEdRiWOCGGyxOejOT5SGwlAvp+tAHpRuFUBjxZdsAfOMjs
VHnRXAWeveQB7CiYjGhlsZXj6QzZXkGc0G5CrECkgKOpNbMOqTyIRy32L3G1rfJXWlbIrfue
pZ6fABNutu/FCbrX03Ds+V7yCpMoTGc0CGFQBbin8APm8Yder+dIvZJjY4fo0GPwTquaOAw4
kK1THOXTyJqiO5FiTxMcidHMCjwkXG52CX+1JU/j1zj6e2T5z9ZrPMrW/yGy5aZNFU9G2KsR
8tP3RySZYZq0UNgg4EnVcwNryuOWQssPQfJYxYYfp/GkhQIjG6wwiEM3IUlJZwsigqk3eqaI
wgknLXETwnAWZ6d+aDk4slPHix9bKu2QYXy7uIEjEo2d6tQLwmhkh2mQtOrUiYRPnaofTkbC
PWnhTCx39PhosZ+X7dm1kuRVAbFvJ8mmG0PlhDFDxY6tlFrefJpYrUCGSNEz8fqxdWrz2YMb
n8qsi9MoDSp/pzzlp6+hnYQV72mss1NPq5sVklI5QVXiMWpoXdGZrmmnPiV2VByirSn+Vh5Q
m/zXCuVdUCml0cySO1jNUky95tYbDce0VcVibGyNG9x0NK2uukqtOfZibicViamfVp+mdPq9
sivAolFV1RsGq9TN5kpHKkwxYIwdsR9aK2SflpANZ7e396Nev/2x2zqdPU5kV7dzY2LbFb3a
ON2V4NN5D8szYgokhSSbR241fkgTJ3wO8lOAUIimPIDUi/m+WH53lQcJLbpZ9gOHByt+yFbT
6baYBeWscRRGDo+agFEN05hSy5IfCnzo0OGVcjSxN7FAQzfRNAzNLAUTWyfed5pTOoNPv+V6
ulZivppEliJbAjnKbIrSnJ/kGumL9aImqKqpMPXqVDWZYdavVizPEQqTdjW3JJT0dYKlFeUK
FYkStk5AVxQdr0J5xbSaeSX2ffCcmSqCjWOcJzXDMPDBfLXkBBDBnlqVtRsUn6A9zJGZ2bQ5
Fdkql2+94mxWsMoHtHuL9h4gM1V1WkKg5Vlpt+gC4Ah0Q4XHs1xrQMZ7JEVDAkj3IAOw1foc
gJlKMQDA7FEQkAHU1wDkBQKgqpllAE9TYYoEgKPUxLJyBlBz+ZyCGnahXwzgh8/kWwgAOxMA
AWBni9QCQDWMMgCAKo2jBGBuzVwAqIo9p4DGu6wLCEBCkQE0dMuoZQDMNcaaLQBMFV3wcgCR
dyQBVrswRwMpoEUAHdoSI9XwXEgevJgsEfpOlPXwEAY45cUia++vAYyxkzgRBiK5MV3kRkxR
2KvV6u3jyrzBBPTN3Qg93yHqjUbRXhBRgB3Tgh2t5HMxcBYl18nbzNwEQH1GBaWniYVO2AlO
F5HTmm9oCpu7uNqsu0hdERauIG1FFivLcsnvCcry12jj0b2Y8cDhgf0K2LSHoxdGtGc+e0XH
/yGBI/sYUHRMuMPOXVqo473ArtLfSQj90A+saBOXciX77S+j69vO1Xl3MBp+Outct4fDLrIP
6ttKj7D4/WUTFj99a3ECv+r+33BRoY7eaFEF0fxle3g5Gvb+013FR3V8q4Xuzf1dr5s1suFG
FtfoXLZ7N3OqxIxfSBSVKiKqsI35FDgPXf2NwaMICsXR1BqoGbnKKOFAXiXGK1FqJ3MwFyVG
eFQo14xlRm6zcqXkt1nuhxCobK0YECiJUy/hzV3x3vPLdfSt3w+I0WWHH8+Cfz8ieZimOOng
s+cYp88fEIlDHvsfprtdaeMIW47YenPRPHPnR3YACB+xM+s31w9vNtGunOG/X9aEhO/gv1/a
BMLT31/RxLIH5/jvl/RC9uAc//4DTXR+VRMrPydMyYdMA7lfLEF3P7zdhDd3gdHh5r5ziCb+
KbWOuI0uiPfE8cxyKhmHVn5LSldvvs39AmD4TT0MNkxlWiQBy/TEAroXMvQubAlbxpP9sFeo
JaxT+iPphvbZWfvn6C4Ep8si7L34vcqIg9P9i+WbHNkKObaVMIA/yMWtxJbLK+1TphZPMoUw
5AEfAKacGpUdhJq9YBBoWRVa/8Z4V2Lu16lymD2pyfiTAYl+vYeajD8/D1NMzd6dKqZmH5h1
QtJAnJ7Bbwz7pO0Os07Iu2G2UKPtweIt1OwDU06Nyg7Cm71gtlCj7THgW6jZB6acGm0fZSin
Zi+YLdTsowxbqDmETqmH0ak9YbZQcwid2hOmnJqD6NSeMFuoOYRO7QlTTs1BdGpPmC3UHEKn
9oRZOjhiBajiBVn62n7KsHRwfhKmlJp9lGELNfvBlFGzlzKUU7MnTCk1+yjDFmr2gymjZi9l
KKdmT5hSavZThlJq3qlTIrbLwulMGXZrf9+KpS1q6jtbfKtiWYsk1O9q8c2KpS2i4L6vxbcq
lrVIwvmuFt+sWNqi+s4+bq34KyP5H/AXvTJ4+mx5iVy935mCt1ftnp8pgwVIF+kbA8Wrdm/A
IEb2VYKY1ku8YNLcRbezn+sFXvxAuxNLnK2Lh29Q42d7HVMvnlJizDs7BdA977bPr69QkgLH
p07tvaK5b7u0AyLWCAMc5WypljsHlrr9d2bGci8GaBMefmRD9M+TM5eNddnaeX169Yc92YDZ
YyV9/huvLta/E2Y+4rvBvIvBBTxmhgZhKt43U01VzCm2FfMYZLsnYMXAX2biawTVPG8PQcLt
effs08cmxNx3qX2YWXGc3wmXOaadMKIV9CdPvA4icqM0pm2WXUuifJjx5CcyJ5lqKrpu1taS
JmUzhCzbojyF5Wdq1oln+jeRftuE4bOHsxBlucav0ylPIs+G3umtSGmQGa3Letg1bEF8/2Xx
ag+VwyngwreSKmR5u0wg0OMV8jRFUxcpCNB9SSjzF/m1kbBkGArDNm7aZ9e9m4/Qu63INOG7
P1ewTEU15CvjWGBUVMAwGijXlP1Ir195Af6lT26gkgZCbpZFa4paW3vFZ4gMjFD+qCcytedI
qTCo/BuHhLt0pFxmBn3quQJtO/Ge6OQc5aS5+p5rXVHNt5FViawpc2TlbeSGGOq3kLVNmrVD
IeubyPqhkI1NZEMis59GNjeRzUPRXNtErh0Kub6JXD8UcmMTuXEoPjMlpyrKwbDzasgOhq3m
sNVDcZvlVJEdTBdZThnZwbSR5dSRGbtir06+zCybfQvK1vYoW9+jbGP3smqptSgoy/Yoq+5R
Vttetlq97/W7d014wsdh1BImhOqzlgBgLVVcqpSaj9d03MRIYruJ4yc/7ITOVkOrGgrOi5ff
lymQq3XYph+DABWRMbjzK/6q6Wh6baw6TmPDr9F1pdYwVFUzSVyWxpwpot2O5XvjSH6Bz+G+
Rals4QyO4kePXtc5lh/GSigbMeXVKhhavValr1CEk7DfGwzhyJ/9t0V9xC4upZUhfP0bMsgZ
ITXN+TvKTZHih1Fa4E3TaRO0lfcGmcrI/RhS7E3vc1xE1pQ/h9HjSpLJcriYJhq4Di1n4AVN
Ebe/kr9Fg3yEEBGqm/+6yLY8Xq1JftqwK74L2YS1NO5lpikzmGGsFhvSKzEinTWgBD6MNEWO
x3T1WwDMRM8HfcDZrB1NKXNzfragg5IFKTMU6F0Q8b4Qeod8KQ6spmgafX0gDZJtmeyKukxk
V04kWzfy2NFhphEWUOLjij+JpyoqQ5ZPSUIpfzb7hGUsLFGnC2MreFzKl4ruMHqm1xa6+fL1
Ee/++mzZon51Rg2pfXHQ6bBSt6Gu13XeqnsC7OMaBGXJijzfZvYpTRFPDBYpyEeXVvzMff8Y
jlxr6pGuKS/miRhPn841+wTQxZ/NxCqA8qKvcEITfRtSsISgn1VowufUD3gk393vk3xbPkw4
3sKppz3so4Am8tNJSxTUJRyfAY/E23aBzeH/SXvS5rZxZD+/+RXY3Q/jzFgycRA8dr37fGZc
40NrOTN55UqpKB62Nrqiw0n+/etukAQv+chOTTkShW4CDaAvdDfO0LiAAW7ntj7oUhO1qV9M
Iwtlg6sPefL/PnmuvkbQCzJM1qD7T7/bVSw8gav4bpiH5GHppg3VA2hGLVNQPRbze9rMlhn0
oWvXicBXXoNZ/fcZa7ndJTzXwcQou4Zgj3OYxIziQbsTOspF25P7tiymnSrJeaCREc1hqjB/
YpXWhlb+st6OTRaUBYXXg7lze3fCTEqhEKGrQkyBxtwuGJN/4KiDSolXqbQCiOuzu5DdlhYi
1ShcxIspMwutGo4u3SAAiGibTDaVfiGbmacbzJPKO8b22pxMetwHqy5ebpGaRXGZB0yjncMK
n0ZJUuEs0ne1XxjXmD9KqaWY1NhhzMrA1cAk4deQmlBlQ2uM92HLG3Um2uDUJi5SBasDIuZK
TpAyUobwGCu2nmlKfeCUNEP18aIYt6cF58r1SvJg40NKnKAHe9yVUgZKKd73hARlKWRUPPWw
Or/UtEjMAxkO4uzQCh0NkgrY7W/bhxQ5jKUEUyCaYSMfUw4hlTaj1IKezS1wGgU6NCw12Gvx
6vtyk4Rm9S+3oy/TlEo2o3BCZ4JtLyTO/cNysuhlMJU+SJlrkAwROwdmnX7Ok00NiR36T1ju
oaWDO/st0KoCrSQPynpXCRaDHd0ML/ZAC93CBjslWLvStEvT2Gpu2WkbwgtkB4TsO2w0PBmg
qyKd42qqbFaN0/Hsa44eHmCOMCui/UYdaNEBTPK7dwqsvvfHJEkXFsKTnnYLCG7yoo+uLg2T
WcPGo8WYbaewZ6P4y3aC64JyRUHrqGwWL3CCcmehsFnBQtl08Fgv8FEomYZ7pfwcOmwo2dC1
PQNezL2iodk3ed407hSc39VquyxNiwocMOjadntc4J5cTRJYxF8n82TxdW0yfBH33zE1B/Rg
GGW0+o61hFP212U8OZwv4tX6rzTWVYqdhGU13lbew5UdcVG5WLD3g7M1qkfGd+xgESDmnBdQ
HPi5nV7kKreoCB2bzt3DA1hie8liFqFjCbf5vUlz72WZrR7Dgafg0sVqM2xwPXCOHBk6ToiT
fRIyYFMlXe+H6cMMheKnCrDht13AuSOU7R2dja5v7kbnNx+uT9/9PVfdyDU3HFxZVC65uFqo
EAsOHLgvu7o6ubk+v3hfzajfx0K1P29yVoeV2DFpJCGC1JnjehnFGLydYLoIJlCZeezbLmiZ
c9faPMPLDeEo89C29hzkdTC/o8rPJueZAIA1kkxn95MFy7kGFn2KMy9fOxVC+m9FlpjkelQM
WsiCVyPrKlw77kSKBs6bkNZKAIyzbqT81Ujt2rXQwnE5QZeQDuymkN1jFYWQCwkLylR8cEDJ
iqj0kYNpf3YWOajmTRzc4vCMBdrGwas4tEQfagMHtzh4Fw6OFkWJQ3ikm7VxAH9GgxR7ZGY+
FkRT+KdCCgmkUF3gU2Dv8Xd2cXrGkON+LhByi9DhGc08z7wKQqOTvwGhsghlpiuYFLGpN2Dy
K13zTNe8atdAevpvQhhXuuZVu6ZJYjUwyXLiSJlpT75fXUCA0G9PHODIu1C8WJvtpWWGCn8E
GjAZr1jwWhEPtxh9sB5egdEzGD2nC+Pw6tgiDEh5qCEUtMZhi6gQdiHvGKas7RMlip3awFFZ
TmbfZ4nd90luuoAAryxW1bHWq7h8iwsYR4WHONUaedzVJNV3oZFOFU1q0aQdXXI9L2iuBFlh
JY6TdpBI1EgEM9zaMrKbROk4tv1JamUZgZm0KV1FY/dZXqk+hv1mwT3VJq7cRRXf9mLcQRXP
9dGkruFSZuFEmUKqdC0cXqOK55N/qI2jxYdiUEVoOF6lCz5vT7JqUMOuFW7XSq2eIujzbZ5R
QSOqVKmILap5nTGtMKW6TptAuKJJG/eNtAnc9ly5O2jjG9qMq13wYZM+A16njbC0EVXagORo
08bdSRtlaePtoI1wArc1Lv022ggQ7q2J1ztoExvaVAfFOwald9JGWtrIGm3E871o0Ma3tBnv
oo3QKmhi9N5IGxG0B+d104YbFsErLELIDl7u7aSNsrRRNdrAD6Ip2L2dtIktbbJdtFFK4Yl4
DaP/Rtp0CRd/B20Mv+EVfiNcp01afydtXEsbt0Yb1yOraheaOm245Td8F78RmivdlC7BG2mj
O2RDsIM2ht/wcbULHYMKdtJGW9roGm089SyaBm0sv+E7+Y3nB6q5oKM30gYEjWjSN9pBG8Nv
eHVQvnJEZxc6aeNZ2ng12gT8WTQN2lh+w3fym8Bt8+Kx1WyEG407aONXdVwBgqbVq/EuzSbz
7eDgo+2KBJae20l1aw9s8+sPV0d5nR/b3AVGV/VvXJSOmkv05N5fXv9+9IntYVANc9kv3GHc
nvBKrj0uXwA/fgbc09J/AfzEggP0LzXwQOqX3n66G1w40hUvgA8L8F+CCqDkTlMnIKX46SGK
VuOwuEUIw9Po4OyP90e5b9PiwD33HA4Lg24ZjK5MUiyltD6cLH6FhbC/+DovP9PhxuF8Ma+9
oCU5ai/IPS8YrbhaTNlysV5PKje5SGTTsDSK5nUHIhjjrueXF9Whk5LF0ZLuIiNfXxbhQcsT
vNEuNuFxHw2A5XpkDjUIejAYUr2Pp3TVZ7zDsy+FORW0cMPiAIlg3L7sa9arlJwBNcztwR+P
3S6SxTRbsPeTxQwnhf3jIf/0v1SfrD/Z/NO+J3DwuGFwNzDHRYVbrqtP0pEaqHM+gGmaRfPo
IV2xrDj+ta04ebwrzk3y2KJHFGMoGr5QaO5LnTfHHUyHnyM8AaMr2QqXvFb1OisSViTax8V9
SVQdiy5IG2+zDDr2igtjJIwIde0XcVQuA8sa1e6lVOTLfekwybcALvktXgIQdg1J4+lJ4mQM
u8v8g5EL0ykb0lnYml3RdKAX1dwEc2pqju8VZbrdPmiXPdkXdkdL33NE45DQxENCb4DilR/s
ZQYWOgh8ZN3zJfCR+cDMMR7olC2U48uAWrCcHw+mWJNxnsCH6LuBMLt9n12crsk7O8Y6oxEF
19ieuq4iAzjHxF+FCRZrBybtexVM4lWYMt6FCeS6ZzGhbyeZRUx8qrTwhaq1eMW7vK7xa8f4
AXNM6lWYVCcmMJsrc+K+ChOs1w5MsP8qmPR/gcn1XKexksL8JiavWclV4eFtc9VSRfvlrHm0
3Xmw3TjWFo6PKjWGVcwrL3FhW3e5jwuvsXqF713h6d2zWNxXON2V46ncGb0Di36Dt13hcJ/F
5r3Bza6cgM7yXmRlJQDnwgWugfKCioiiRx7muUfX45polXSa3xMIAiPGeHcT7I6xPGX8xWS2
jOxVb8AcSE3fxMsRVptN5yOUYHgrwYiiETpDEoRfDaQBK0g1YhKwXCeyuLuTAUvXCD5ZI2vs
wiYcZdHxfSyp1gxxUNzVbo4OBvsKPGqfgT3O24h0gOwQEIXstxLJujyVwrOxaocJKb0SP1Xw
gG0BgvrD6eBFCsGQuBC+3+pK4HKDoneJVVd+FA9sQ9SSXozIsADcQ8n9EoBSFkK4qmkd0qHO
5WQ2MXF1kxUuNNBEDlAz3uDduaAFWLYgpFZttz4KtouLjzK0uQGDyASd3cJiBmlsESiPdyKg
cFIT3XcxPKIbUR4jzLqCjRLRFqn0wg2cTi83HZsX+jNVgF4/RrBfgS63N1f1i+wq14fW3cRK
eDak5ORyiNckmBtsi2shdYWmgfJBefwwh+1oSkiCAgAKYbbu98vjT08LBxd+fv/odo4VxovG
RZdie5tb3LzNDQymAA37K9AMMTCK7nAD6P9Q6GdXAJSnYa8BoTGDZ0RJrtAQ9fSw1+uZCEHM
r6Hclnvq16eQzalw0Go9Wm/wNpNDweYYrVh54lDcyoh0/adoeqgdVMbHi3V6yIHWoDOCVCl/
ldB6u4Evhy4ryvCO1mmMeBbzRZbZpsWDx8U0gX9tYA6eASFraw+EnUDnzJXa5sko7wBVLLTw
gad4HuyymD2sRjTmPSHfmZqID4gFH1GBTSyNuHkMGcDkYYVsmmYlo/U8JxCdZO3ojRl7vTdg
C2E8Qgd81yBMdfPKrHroTHn+9fh4VCAzE9rogiRz47kuVHre7oLy3Bfm4+UuuKQYduDYBdru
Buixb+kGrtt1oxdeoLqJ+fpeBCA1X0ZhX17HwPs++jNVHol9a0rrUxBk1faIi9DnxTwsorQl
RmlbLNqXvB2b/baobJdnGi8F6YjKxvA1aS9e81D75ajaFSNEFjQagxia0zBMgN8q3hJvCi2B
2Go7n9vwZURktLsuRDcYA2qeG04VYXgPhjj+xYIH2nNthWsw/ExwJAiv7XpDNxt8x8uebc89
DMAyGhg+x0Q8RAkTM1uOxpPN+lA6RAOS2IfIB7bx53STf3csIqEwsnv9ZQsyHwNRC1NT9cHw
AHM5wGuVJX/HBo+T6XSyZJeL7cNjEemIGKTygIjzDULnl2SJPu9Lwe7Pp9EDPL09uPlkieWh
wAFzHduD2IxYjz1uNsvw4CBK1yAb+vFjP932F6uHA2hzYOFcjrEYX+bfwEz59/VHzbIJTL2h
FCDqOxVvR+V1WuAOGb6/YB/Ph7lELcLeow2oN+NtLhnxhoFaFBmC+wIdFNcXlwBcEEfUfErU
ykcijNMKCWFN9oO+LNv4jkKm85CtwWB9fz4UsK7opoIKHuAHeKDUZPT6BUaPVambjB6wBUpj
QOfv6Xfjwo1semTTL4StXYlBIke2ESw7DJpfw4z+/M11gp87wbTAbXtMOwNsRmg8PBlelOHY
e+P1w7tiYRQEBK0jJyHbm0X/AfkvVJHQgDg9OgUDs4oub9xOUyzzvlhWQ0b3ck2mAuVL0YSa
femVodjtzmutyZIZbugu9SJTNo9GTJNqywBjQ2BmYiw2cXJ7Mro8Gx1f3A3ZIfP36cHxGSse
lGCeIzBlNAfDF+T1BUwy7n6Ro4IKPqiEhfmCcX0alDjNgV+lsUUHun+BLm51o9JMc26bvem1
EgwmV9Ve63FHoYggfKN4MRvT9R0+7P027hJIBTIoKBa/GsrlDkajYKTtaLLxPbxWvuaBxjZC
Y2D8ZDmbsBmGUz6kpoRAZYXJoC8sgFToUb4YXF3kvjbjMUdXb740+7axUmiUIPbRehKCXkyW
EN6hg9ZXNP/ewrG3fmfBXemX7xpenLfeZFviTY2YArzcAv8egIq/YsegtUDvozU7yH0mB5fX
H4f/N7y7AhMBPw/+vD2+xs8EZ/46FqfnVw4WqijvAfD8U9lQcxeDN4awR6MpzIpwnQMO6rZT
5jooRoGd5tojsEFWxrpa1/ij7zgUGpP7oahIO4o4TJ7GS2zAaMRCH4doBmPM+WgcbRP4am4q
eccma5CG9N6jEqWUHIVb7pBClNyiFBalfANKX+Hx3Xwdj3Bl1WL/baPA8VCXAstmEob0z8hc
7XB2e3tzC0BUJR448RB/uzitQAa4IGdfoydUWpYgDxxAYT5cjMqcp/R4Ea2S02gTgZm5WmHO
0vAKTxCgz5goZy+iwGh9DEKdGWupfJOCQdo30T9JEob0YWT0lBzxuYmv3SyqZYPH+H5MqIgs
RuEhY/tBjBaN9F1QJH4De5csu9BoiRQVXTzLk2FQLHK2t5mg/bdm3HdQIC/AOka9bQVqEz7W
5dN35d70wWjGecSsuRCTdDB8vi6Kfe1IlB2rcRI2RYwr3tlmUmIYXYoOsjxpae8WtJzbmwN8
xK7TDaXD5S74XslYQND0Be999nvXR0VYHuJTdKqU46vfIcCDIOjRRQJlchRsLdKF86H5ffR+
cXPgsuMssSg7gFuBsoYLUNfFYg35u2thXSzdPEJv9tANICUo26EUPVAP3zHXZNc4IRehVKGr
LbJA+P4zyHaT6sSkeZb3mAEyrRwMoYwWsLSOFmfsyXfLxbMutTRsiDwdeCFe6ROilxn+DA8E
4sQzPuTs9/l5QPj78el+7tEPr24+fDJZF9rZhz+K0eWP+1xY1LC+0VYETrcIzRsYoGAm0r4F
auF8jfpQDe7ow8ddcPaFoJzjCpwtUGVLn/KR0NfCr4P3YBnnKF7SxWaldENwoVBlyMXC0R27
QxfWlLJgMMNZoF5mNnJVTCyhBbpWD6inB9TtmpCwIwOLD08L1xO8ySM0A0q/kc81zq2UokxJ
HM3zDF7YylvbSZ/76ESLlktQwWeoY5QpdNMIdNcl8TNy///FAgmNATwWKNcKyYVU5AOs0s1h
jwfvKmAyQJ5HeTcie+jMvLGNlUbX+Csbe9qlqA7QuzV6AE/wwzfqe5KnFO8XfAYfgsaeWtMX
MAScSBklTxG8IH78msCc/Xl6VwwNZ/io+JGhRTktuDCsAZiV1Lq+1qUwQsQiQDWijrjiJOuz
4n4zwyjZ3nzxla4IOiwCBRCL4piB8TXK0hWQX3Z170/8keGvb+qf6yL/rGNGEW2vEQalUcLy
NsnCwNS3a0v5ADQ4bSivuBwR9B/FZcR9kvcgpkHcn1kQ0GplAyRfnoVmjxWpYphjFJ90k9Yh
Bzt4D5gpLCldIQsoBOgBG8do/47e2vdAKpMJ6BIkvnRUdsGs46KxdjDXkxpnq/TLaE7nIQKX
JZuf02cGEn4JJnwJwhVp24AFL6DsAWhYNXxI/iYTTItjdAqHhqwpQrO2OAKH4s4/b8AOg4Ud
ofXP3qNNRvlcOPFL87B6JIN7Hz0bxVyEYMp7bolVOFq84pRcaAvBFepyw8kM9jy7O6EeQ2cv
K0Ibm6FT/hUnB46FUArPvfOkI3abl30g8/5i8FTpgcs1cuPJEpTJK7y/MK03UFyjGv4ZZVi6
OtiKULC9IHje4ubCaVnciEv46Ahq4PKfx+UUp0wNXMDJYAqphtO2tEGMnVPcDbaMHshJlX7Z
5r6lOPGTONOxReNS7v4vyyQFJdnJvMR1tAffN/Qdmzu6uPzRtr9ZLNGrBsuX3f8NhkTFpEaD
o/dnR5eXNyfN5iaVcU2XDeJNUPOw2YKSwx02uDjF9L8TEIAgNL7iNaUrdhchewaF7T1r/HfH
dl+Y9zfefMdvwLcougZvegzZv8+uPuA5wTxBfjY4AcMBVs35R/YrnfXso2Km3+2bfFvgOk5f
9DhzFLq8BLysif7sAtSSDJjir8AgDpxvgdNqcX559H6IdBN4Gq3zUbeaHX0MzUylscPOjmvf
Tj4S3fE/zs5O7bc2muEF/Ri7KSzHs1M8cDf/+YAU+hpnYJ1lIoaW5TentTTYKfXYG7Oz4sP5
0LyVmcGkDpiy+KG4m6kyrbcgN8EKhG9SwjcRlksQvkkAEk5CauLJrUIUHFTCpDWUE1SDQNGJ
09bCYf9CbvV5BFtohXn5o/F0MYYZ0BFMwbiFCZpPlk96lH7bPCar9WiRZXRHJ0oxgALVCP+0
oKjNdvYITXgCTdys1SRZjBZzYxPh7a2IDFcB99KOPkBjKioyoqoT0NaTB/in1dTsZOMzBhGR
4kaH5gl2grvtyfoXnvJviuEk2IM2OatY8UZZaJS2G4GqNcL01BHSF5qJFC+ebU8xlUfLXBZz
5gdgPbLUx8JCyZhlKaw45o6ZC/qCZH7CxgrYPyPTIf8fGqcSmB3LHGwccSxNAzZfA2Hm4Yc2
Qq9A+I8s+yfzfZAgFjf86Pg73+y6zB9juR8es7Fusbj2dsZVTlsFV3q4a7/QIi/25C5+2+v1
7sFkS/AAGoNEtMZkwrF0vSQNfI99Kiv2WZjfC6aOF8v2SOHEi5ipJMZ5hFfspt9iEBoVC6sB
epNldBhQuml+OgN1HGWPKaoAAvSnL+ls25vMHlhM4oj1MvYlXnwVCPS517hGteeA2azfvxGI
/wiQ+BEg+SNA6keA3B8B0gbop89Ps8O9n/6HgP+/ubPZbRCG4fjZfgpU9bKN7Ksd2gVp71FN
EwNWRSofIp02bdq77+8kFbBQreLUCyFOTABZYMdRfi5joT4fk5dkzaRcXK/QBRUBafu9UuIr
U5WtHLMWLf6Pv3QlBDZLX0Q3jdFVtvUkX8/zlflsuIVKGLbX+fYL3Su5FZSmahHkkvKRqI3z
47rco56iuEWTq4nP0sW6OEjtemCXP6pz6dWorhQhzg985EgnK/wuzOtAprzLZ/MrkHf73M7b
pbK1g+WHy91IPGITOum0GcZVWejMNsb6LRVGqm5OULybq3g/V3E1V3E9V/FhrmJyTNHYaWH4
qYW7jjatLAe0y7RhSg2MS8i777sdXzCLE1cXYuBjojdTgPRm8mbQQ72ZpqjeuNa/WG+mEdeb
KQB7Q+TJ3hglQHtDP2B7M/Vwb6Yx3VsGGOO98TgBtdk+Twj4ZvpD+GYaIr6ZjjG+R/0G0p7y
jXf1wXQ68JrpLIjX0y9vgnkNE1ssv/GB3Dw9/ywi5ewtgsydbS4h5l+ZDXZvup8AAA==

--u3/rZRmxL6MmkK24
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-ivb41-100:20180804225827:i386-randconfig-sb0-08041433:4.17.0-rc6-01469-g449325b:1.gz"
Content-Transfer-Encoding: base64

H4sICCrKZVsAA2RtZXNnLXlvY3RvLWl2YjQxLTEwMDoyMDE4MDgwNDIyNTgyNzppMzg2LXJh
bmRjb25maWctc2IwLTA4MDQxNDMzOjQuMTcuMC1yYzYtMDE0NjktZzQ0OTMyNWI6MQC8XG1z
2siy/p5f0bf2w+KzFtZIQgiqOHUxxjFlY7PGyeaeVIoS0gjrWEisXvySyo+/3TMCA0IYHLKk
Yr3NPN3T0z3TPdMSt+PgBZwoTKKAgx9CwtNshjdc/mEQR2M/nED37Awq3HVbkedBGoHrJ/Y4
4EfVahWihw98HYI/p7HtpKMHHoc8+OCHsywduXZqN0F9VjVDramWmt8OeCjuqpbpepr7IcpS
vC1uMVX88luLkkz16q7hfJDoozRK7WCU+N+5fOpYdar04Yw70XQW8yShJlz5YfZM/A7sWNzo
Xp3T5XUEMQ8ix079KISQc5e7dN+NQl79cBpFKRVO7zlIctUPXwF/alXy9k0CwyNHVAQwqqxe
VZXYMRWVGWZDmRhGQ9dqY6g8jDM/cP83eJgpIVe1I6hMHGepYqNqQOWMj307v1K0oyP4jcHQ
TqGdTcAATWuyWrNWg87wDjSVWevMXHZvr7tXkGSzWRSn3AVnliXN9VIAvTDlAXzkYeaHXFwU
y7T7Z0gWWx6mvoMXxRIdfGRn8fx4YWdBUix1F9thMuWpPad313+2zG3lFmedwaf1clj1xJtl
TRjKNlLvfBm2P3fB43aaxVzoEmvC789WHbwgskWRWeSHKfb0xE9SlPjv74PVEHY47P40joE4
7c9fdsF5TlI75SM0PLTLr9q3JkCtbh7P75PaJ/K2VisIdYHSDcle3bzWnJcEmakfk+GmaLFA
WOAnYOkajF9SnhxDJkzld6wVunbs/g5eFE/ttGAE3NLUJpz2bobKLI4efTQimN2/JL5jB3Db
7sPUnhXUUBSXNb9O+VRIZvWnrNxqeGPP+4Y8UVv2Amt4ThHMIzAUAo8fubsXnFfkzXs/HCs0
1fNc5r2rqVhTK4C9mzePeyS4ZTi69W44ibYC9yZ3Lh9nkyb4kzCKSReDaBLwRxy80BzIugqq
OMYhez4VfRUzEwKTikoTWC9+jQO8gzPH9ReodJ+5k6F5nOXTG6Aup9wRM4Njh2GUwpjPgZoQ
RqEyaHfzieF/1pGHfRIFaFULaBbCMbLA61m/14Q/u/1PMMwtDAYdqPiGoZ5/gT9g0Ot9OQbW
aJhHx0KwwKpMrWoKA9U4UdkJzgHGOujFywwl6SdRjMIj9onXy8/9zTabzVwaEda6at5FS1oI
rda/S3tJYsV8Gj0uY9mvWHk3b9ZoWT2wk3Q080JoYW3SZBw1nkd27Nwv7kpbWa/ev7u9xbZ6
OP+kkGLzm/AU+ylXxrbzsLGw5z/jCIXTzAQHwXmHFqckKYvGOf62IOJUKcqdinJZ6NjO/aZW
4oQpyp0v4eUatpHJRzv2heTf5hPGdoJTC3pV8oeSSx7g/HxxvY0rNvfnCt2Kk8qWZ/qWZ8aW
Z7Utz8wtz+qlz2ieG7TvmtCJQs+fZLH05r6qSh1nxr9OAf7qAHzqKPgf5PVAXv91B1AwXLR1
mujQggfkzZbYho76vHvVpSlITj27V12abryNVb0oC11Rrz9QUqEy6DIuAZi2OQfAUzRDnI5n
aABUqjJL40c7OCqgAkxnThOwRl1VPHNcL3ibfuinPk7wSCiKX3LQwrBPhDVvM+enpLZ5dQwZ
prMoQAdxlS9ojEmDhXfCTN0qDHint5fY1UhkbHK8cQz5uRhwBh/v2qdX3S11vKU63m51KMCY
16mr2+qg73PWG16+CsUbu3ouFJwONwql3RngtNAVQZXsTeeeOw9JNqVowff8PFgpswZZ/3Z4
Nlh1W85Nq6GKMY1hpPGIMj296VwM4agU4G4Z4Py8y2qdrgDQVQJgOQCcfhl0ZHH5Y+LO4qqE
wDke1gkYWltUqxsFArL4PgTOii1A35tEwPRuu0Dg7D0tGBYIqFLGRmGaknXag16nIFYmxVq3
CkzJ4vswdTHoFvutYcp+KxKQxfchcBWRVy8Ys12XAmyarzkXhdar5CONKJ1GMP95uTMIlcWd
HKBAVO2fwkXv40W/2wf70fYDUvqCK6XValju6uav7cVgzlAQPeG8Om3i3KnA3G8ult6p2MPj
VHGCyHloUrwNODJMkxjUJhYnMR6j/+dPbRzi6KkouAXhkwi5ECABY1wzDRd7BX3D+cU24jJa
S3C0cEEGjHiAGtPqlqY1DHBenIAXInRROYmymNzgJTRyIZrCE1v9Ca9MQtFj5riGxg3X88bH
4pHvBnwU4jPLQr1Taw1mWDqEBbpLwym5dfPhlG0bTv8ThXN3aIMbdNZvS13aEE4SiZWQrWRG
AowIMMQNNqDky1GbIrUiyoU/ue9jfeDTWfpS8O+iRzGwf6f2YHQdp2Lq5+ijYVjhFpw0ORnk
EyUVyIVQpCse4q2NMXVBCGqDb2Z/C0x5vLoO00P/gGrLFUUBqe7CVhneTTgHEWt+M5vUAMya
3tA2KwOJtwm6BqIo2gcaBskZWcBhYFsdNa9SFvCs4Dcalix+DFe98xt0xlPnvrlhNMlVS1Yz
LHVXvlbqmUxHWy7SY7WC85EzD+MsxQhgMSo2Yc7weg05+IjB2o199DbmYdXmmWDQV+78KZbq
3cAgisWqrakW/MR3TBt5FSo9uu73oGI7Mx+Hlq80Hn0D1wvEf/QWU7zFvhVmjd4N1f2qov9v
z3wHq9K4PF9tZfXjFSbEugQ+/zjsgapo+mZ2etd3o+FtZ3Tz+RYq4yyhuCtLRn78N55Ngmhs
B+JCm/NX5CpEGVGESsygs0uHNPYndBSAeOzd/imOQlK9M1icXuM8XVD0NzmrLXNWg3scl0Cs
oLzNHMuZ09eYq5UwV1DAN5lrLDPXOAhzjRLmGnszx1Y6Fa8OwZ5dwp69P3tshT12EPbGJeyN
S9i7/VOVw9f4BSK0rth3i07XzlrPSqizdyPqJYgFC98Z0ShBLISlCwnVDighs4R6Yel/Z8R6
CWL93YhWCWLJvIB1Gm9LaFGW7aBwr4XZAWXvlLTLeTeiW4JYcDd2RuQliAWPcmdErwTRK/Ed
UPRQ6bfP7o4Wq1nOyqqcH8pNJDzfEsD6LjkTlmqZtoYREK1vimCEuxv9hTyqk7M+BZrk3It1
o8p8di8Mipef+7lraicvoQODc8GxCOE2RVlJyu0gRX9nJcxjrjWuFYP9lR2QPHIgJ5c2UMYi
xFm4Y4LqoNNDX+vRd4pO2XwTembH9qMfp5kd+N+xsXLfAVCkG1b3V6K6mHt+yF3lv77n+eQz
r8d2azHd/PZaQMcaTG2YjYah6hjUscaGoA7DEjfCcHnC05E8H4mtREDfjzYgvTiayoAnTw74
AzuZnajPuqfCk5/egxOHkxGtLLYKMp2h2BXEiZwmJCrEKri6VjctyORBPGqxf4mrbZW/0rJC
Yd33NPODFJhwswM/SdG9nkZjP/DTF5jEUTajTojCKsAdhR8wjz8Myyqwein7xonQocfgnVY1
sRuwI1sn2MsnsT1FdyLDlqbYE6OZHfrIuNzsEv5qS54mL0n898gOnuyXZJSv/0PsyE2bKp6M
sFUjlGcQjEgzoyxtobJByNOq74X2lCctlZYfwvShioQfpsmkhQojCSoMkshLSVOy2YKJcOqP
niiicKNJS9yEKJol+WkQ2S727NT1k4eWRjtkGN8ubmCPxGO3OvXDKB45URamLYsakfKpWw2i
yUi4Jy0cieWOHh8t9vPyPbtWmr6oIPbtJNt0Y6geM1bTsGFLpV5vPk7sVihDpPiJZP3QOnH4
7N5LTmTSxUmchcrfGc/4yUvkpJHiP44NduLrlqmQlsoBSknGaKGWajBD108CyutQXOKtKf4q
92hNwYtCeRdUSm0089yOmjau26amWp5Z465Zd3XDMjy3Pq4zyzDq9XFz7CfcSRWJaZxUH6d0
+l3ZFWBBVNNqGP4pTDebSy1RqM/H2BLnvrXE90kJ33B6c3M36vXbH7utk9nDRLZ1uzgmjqMY
1cbJrhyfLJpYmhGzQVVItXnsVZP7LHWjp7A4BgiLaMoDSMOYb4wVt1d5mNKqm+3cc7i3k/t8
OZ1ui2FQDhuVKHZ53AQMa5jO1Hqe/bDBiY5crpSjic2JBRr6iWatppulYGLvxP9Og0pn8Om3
QktXSsyXk2iqyNdAKvmkojbnJwUifbFg1ARNMy2mXZ5oJquZ1uXS1FNp1NT65XwqoaSvY9BY
w7xES6KErWMwVNXAq0he1Sy8oNEZZcVMDbHGCY6TulGvUZ18weEY1EtwpraycoPiE5wPC1zm
c9qciXyVK7BfcDTbsMoHtHuL8z1APlVZtIRAy7Ny3qILgAoYNQ0eTgvUgCbvkdQMCSDdgxzA
0aw5ADPVzQAAswfBQA5grQDICwRASzPLAB6nYioSAK5aF8vKOUDd43MO6tiE/maAIHoi30IA
OHn/CwAnX6QWAFqtVgYAUKV+lADMqxsLAKxtzgGwv8uagACkEzlAw7C4lwMwr9bQDQGAQ0Rj
C4DIO5IAy02Yo4HUz00AHdoSI8vwPUjv/YRmIvSdKOvhPgpxxEtE0t5fAxhjI3EcDEVuY7bI
jZiirler1ZuHpWGDCejr2xF6vkM0G52ivTCmADuhBTtayeei42xKrpO3mbkOgOaM9klPUxud
sGMcLWK3Nd/QFHPu4mq97iJ1RcxwG9JWZLGyLJfinqAsf4VzPLoXMx66PHReAEn72HtRTHvm
sxd0/O9TqDhHQJ0Pt9i4CxttvBc6Vfo7iaAfBaEdr+NSqmS//WV0ddO5POsORsNPp52r9nDY
RfGBta30CIvfXTRh8TO2Fifwy+7/DRcVLPRGN1UQ5C/aw4vRsPef7jI+muNbFLrXd7e9bk5k
zY3cXKNz0e5dz7kSA/5GpqjUJqY20pgPgfPQNVjrPIqgUB1NnUyrUBk1HMirxHglzpx0Duah
xgiPCvWasXyOW6+slPzWy/0QCpWvFQMCpUnmp7y5K957foWGvvX7AQm67PDjScjvRywP0wwH
HXz2lODw+QNicShi/8N8t5U29rDtiq03D2dn7v7IDwDRAzZm9ebq4U0SbeUU//0yEhK+g/9+
KQmEp7+/gsRrC87w3y9phWzBGf79B0h0fhWJpZ8bZeRCZqHcL5agux/eJuHPPWD0t3ngHoLE
P2XWMXfQBfEfOZ7ZrpJLaOn3yunyzbelvwEYftMOgw1TmRZJwDI9cQPfCx16F7aELZPJfthL
3BLWCf2RfEP79LT9c3xvBKfLTdh7yXtZEAfn+xfrNzmyCjm2ShTCH+TiKontcaV9wrTNg8xG
GPKADwBTzo3GDsLNXjAI9FoVWv/GeFdi7teocpg9ucnlkwOJdr2Hm1w+Pw+zmZu9G7WZm31g
VhnJQnF6Cr8xbJO+O8wqI++G2cKNvoeIt3CzD0w5Nxo7iGz2gtnCjb5Hh2/hZh+Ycm70fYyh
nJu9YLZws48xbOHmEDalHcam9oTZws0hbGpPmHJuDmJTe8Js4eYQNrUnTDk3B7GpPWG2cHMI
m9oT5tXBEStAih/m6Wv7GcOrg/OTMKXc7GMMW7jZD6aMm72MoZybPWFKudnHGLZwsx9MGTd7
GUM5N3vClHKznzGUcvNOmxKxXR5O58awG/19K5ZS1LV3UnyrYhlFUup3UXyzYilFVNz3UXyr
YhlFUs53UXyzYilF7Z1t3FrxV0byP+AvemXw5Mn2U7l6vzMHb6/aPT1RBguQLdI3Bjav2r0B
gxj5VwkSWi/xw0lzF9vOf54f+sk97U684mxdPHyDmyDf65j6yZQSY97ZKIDuWbd9dnWJmhS6
ATVq7xXNfenSDohYIwyxl/OlWu4eWOv235kZy70YoE14+JF30T/Pzlw3VnVr5/Xp5R+2ZA1m
j5X0+W+8vFj/Tph5j+8G8y4Bb5Axq+kQZeJ9M83UxJji2AlPQNI9BjsB/jwTXyOoFmV7CBZu
zrqnnz42IeGBR/RhZidJcSdc5ph2ophW0B998TqISI3Smb5ediWJ8n7G05/InGSaqRqGWV9J
mpRkCFnSojyF18/UrDLPjG8i/bYJwycfRyHKck1eplOexr4DvZMbkdIgM1pf62HTkIL4/svi
1R4qh0PAeWCnVcjzdplAoMdL7Omqri1SEKD7nFLmL8prLV+pVjeJxnX79Kp3/RF6N4pME779
cwnLVDVLvjKOBUYbCtQFpyL7kV6/8kP8S5/cQCMNhd4sFa0b1sorPkMUYIz6Ry2RqT0VVWGg
/Bu7hHt0pFxmBn1quQptJ/Uf6eQM9aS5/J4rqoH6NrImkXV1jqy+jdwQXf0Wsr7Os34oZGMd
2TgUcm0duSaR2U8jm+vI5qF4rq8j1w+FbK0jW4dCbqwjNw4lZ6YWTEU9GHbRDNnBsLUCtnYo
abOCKbKD2SIrGCM7mDWygjmy2q7Yy4MvM8tG3w1l63uUtfYo29i9rFY6W2woy/Yoq+1RVt9e
tlq96/W7t014xMdR3BJTCNVnLQHAWpq41Cg1H6/puI6RJk4T+09+2AmdrYZerak4Ll58f02B
XK7D2JofgwCKyBjc+RV/zXR1oz7WXLex5tcYhlpv1DRNN0ldXidz9GuIbscO/HEsv8Dn8sCm
VLZoBpXkwafXdY7kh7FSykbMeLUKNd2qV+krFNEk6vcGQ6gEs/+2qI3YxFdtZQhf/4YCckfI
TXP+jnJTpPhhlBb602zaBH3pvUGmqVbjG1oMxt70Psd5bE/5UxQ/LCWZuEulLaNOSZO2O/DD
pojbX8jfok6uIESM5ha8LLItj5Zr1nSk0xWfhWzCShb3a6YpM1jNXC42pFdiRDprSAl8GGmK
HI/p8rcAWA39E/QBZ7N2PKXMzfnZgg9KFqTMUKB3QcT7Qugd8ld1YKaq1+nrA1mYbktkV7XX
PHb1WIp1LY2d1UUPCyjxccWfxWuYJkpkShpK+bP5JywTMRN1ujC2w4dX/dJQAbD0lY1uvnx9
xL+7On2laFyeEiGtLw4GHV7rSu1Zquu+VfcY2McVCMqSFXm+zfxTmiKeGCxSkCsXdvLEg+AI
Kp499cnW1GfzWPRnQOe6cwzo4s9mYhVAfTZeJaHp2DzUDQqWEPSzBk34nAUhj+W7+33SbzuA
CcdbOPS0h31U0FR+OukVpWaQsgx4LN62Cx0OXQousIHZ/7N2rc9t40j+X8Hufhhn1paJFwlq
z1fn2HHGtX5oLSczV6mUipIoWzt6RZScyf31190gCfAhW95xPsSyjP6x2QAajUZ3Y+Hqg65C
kjbxxUJUoax3/SlP/j8kz9X3BLigjUkGtv/shxvFsNOLYbDf9/OQPCzdtKF6APWoZRGR7hqn
T5v5agI8tM06YUwoasrqz2es5fsuEcHsCXwdJUA3wjiYUDxoez5HOWiP5KEri+m6CnqKS1RE
C+gqTJ9Yp5VXK/+SbYc2C8qR2o3Z3f0ZsymFQnR11OXwIMztgncyx4E69kq8ShmG0KM3H+67
7K7cIVKNwuVoOWN2oPnh6FLFBgSabMfTjccXqplFusE8qZwxdtDUZKDSkXi02qI0i+IyD5hG
u4ARPkvGY0+zyEiruNhcY/4opZZiUmPLZlYabXBsnmEJCWhClQ3dZrwDU96aM8kGu3asMTEc
qwMispcSJGOSIeHYXWw105R44JQzQ/XxkhFOz5IcyxDrUjzY+IQSJ+iLA66llLEKpexEMQdj
qcuoeOqJ37/UtEjMgzUclrMTt+joGEb0V/bL9iFFDeMkwRQszTCR31MOIZU2o9SCI5dbENQK
dMD2OYChNlr/WG3GXTv6V9vBt1lKFZtxcUJngmvPlYLue1hNl0eTiBsDq8wNrAwJuwBlnf6e
J5taEQf0TzjtEYpAq9dRK49aSl56Wk7HWAx2cNu/PAArdAsT7Jxo3UgLFS0ljeZOnTYpoki2
UMhOwAb9sx66KtIFjiZvsob6pcecPjxAH2FWRPOJOsblqUFM6/fROaj6o8/Tcbp0FJGII1NQ
cJsXfXp9ZZVMBhOPBuNkO4M5m4y+bac4LihXFKwOb7JEhuuSbVxs1jBQNi06NjLGCeWgXD/7
AetL1tceZzBtSs7svMnzpnGmYP+u19tVubXw6OKoOt0elzgn19MxDOLv08V4+T2zGb6I/Q9M
zQE7GN4yWf/AWsIp++tqND1ZLEfr7K/0rusUmYRhNdy655hAC12WwcudT4J97H3I0DyyvuMA
iwCx4KKgAhuD45DNC9OAVrlDQ+i9Ze4LfAGsH4yX8wQdSzjNv9g096PJxFWP4aDSOegxrDbD
eje94DSQ3SDoYmefdRmoqVKuX/rpwxwXxa+OWJGTrpU4d4Syg9MPg5vb+8HF7aeb83f/yE03
cs31e9cOSsP61AKFKPjioH3Z9fXZ7c3F5Uc/o/4QC9X+tMlVHRZix6SRMQmkqhyzVTLC4O0x
potgApXtx45jAaaxoO6u9DM83AqOEg9d64jeHfp34P3Z5jwTAahGWtPZl+mS5VoDiz6NJlE+
djxBmoDW1f3Bxja5Hg2DBli8N1hb4dphKyhucF4FWikBMJy0g/K9ZejGrqMWAWp8oC4pA5hN
XfYFqyh0uUDT31Z8CMDISqj0EWX6uV7kYJrXMbjDsFZcCwb3MUIwixoY3GHwNgyOLvgSA+xF
tIGbGKCfcUOKHNmex2zFI/rhiQKMK23ayGeg3kc/2OX5B4Ya9/cCkDvAgE+o5/kk8gBBLbS+
005A5QDlJPSQ1GuRjMdaZFmLfNbssvYKwJHHWuSzFsGMbyDJsuM4jvhm5xt/AEkTRk1uACNn
oXhwaKdXKCdo8CdgAdPmFQteK9LhDjGmg4MXESOLGAVtiP3rMk+Oo8siqgEKGuMwRVQXZiFv
eU1ZmScKxoNuw/CGk533k7Gb9+N86wILuDdYlYGl6xks47BAcXg6JPBr5HENU6Y+sDwYGfgw
qYNJW1gC8zyKa1jSUyVBkLaISFREBCZkQ0SyXUTpcOT4GVfKMnKw2kR9UPowbp7llepHMN8c
eRQ2hSt3ScU4LoYtUomiWNYHjrIDJ5kolErbwOEVqcAjGr2kalIpXkfZ14k8Fow1T3aSq8pY
4W6sVOop8vh5LoQvFW/ZoprXExYqTKmuyibWuoGoXymb2Do4mxgtsjFWNkPHgoDx185Cq2yE
k43wZSO4IOt4F0xNNsrJJtohG8FDJeqdFr5ONgK6rDGOwx2yGVnZ+C8lQDb1oRvulI10spEV
2YiYjkd3wdRkY5xshrtkI6VqaJrolbKRUVNFRO2y4VZFcE9FCOhCET5DXpWNcrJRFdmo6FmY
mmxGTjaTXbLRXGlVQzSvlI1WTdmYHbKx+oZHPgthczKYnbLRTja6Ihu0COtT0+ySDXf6hu/S
NyKMVFhfXeJXygYsBlmXb7xDNlbfcF/fRKJpo8Y7ZRM62YQV2cBuXNZlE++UjdM3fKe+MVqp
+mRPXikbY5odn+yQjdU33H+pmJNvdSd5VTaRk01UkU38PBc12Th9w3fpG4k+0fp8GDrLRuhk
2CIb49u4Evc79R4b7rJsJsa9HHz0WCFzqWW3B3vzm0/Xp3mZH9dcCOe+wk35ZemouUJP7per
m3+efmUHGFTDNPuZB4y7E14pwGTVL5C/f4Zch2H0AvmZIwfqnyvkYejcwzvIz58hj6R+ifl+
Qf5z7Aihvxv7WTKKnx6SZD3sFrcIYXgaHZx9/nia+zYdBm+aJRUMR4NuGYyuHKdYSSk7mS7/
DgPhcPl9UX6mw42TxXJReUDDqKs8IPe8YLTiejljq2WWTb2bXAAgjmGaFM2rDkQJQlC6vKcO
nZRslKzoLjLy9U0SPGh5gie6wYa7VHznVTawhxpE3ev1qd7HU7ruMN7i2Qc6E2ufrl8cIBGN
7shOyI68kjMwCfQRnuaxu+V4OZss2cfpco6dwv7rIf/0P1SerDPd/Ld7jg7QHdu779njosIt
18pTKHAMXPSgm+bJInlI12xSHP96reIwrjg3yWOLHlGMoaj5QqW0x5/UHGcwHX4O8ASMrmQr
XPKhqtZZkRIseOPuS6LqWHRB2nA7mQBje1wYI/HYQ+2B4V0GNqlVu5d4BLvHYZJxBJxe+CUC
4caQEgY1zng0HsLssj8wcmE2Y306C8vYNXUHelHtTTDntub4QVGmW3fAujySHeFmtIKOqh8S
2nhI4AYk7v3BXWbgqO3BwWqxAj2y6Nk+xgMd1wJMHtuC5fq4N8OajIsxfEh+WAo72w/Z5XlG
3tkh1hlNKLjG4zSy0zpH4nshgcJqQTLQ5Q5J7IU04W1IscZ5UyChb2c8T5hwAwO222FQabHH
s6K299c8JF2QI6m9kFQrkuTKQ9J7IemAtyApTe6pHCn8E0iR0Lo2krr5TUxRvZKrjEHwcW3U
UkX71bx+tN16sF071haB0ehHFco70JYxGMVtBkXpNVZ7+N5lHJmg1QldoOg9nO4yNkbz51DC
V3jb0ehV5jm06BVudljaNN9D9wlHICIDIsH1goqIokce+vmIbse10SrpLL8nEBaMEca722B3
jOUp4y+m81XirnpTgVLkaRytBlhtNl0McAXDWwkGFI3QGpIgjB9Ig4e8tZgEhdHYoCDvz3os
zZB8mqFqbEMTINUSjh9iSbV6iIMKYBJLCwcvuweOOmQYdNYEguVKE1CX/VKCZOWpFJ6N+QwT
KD0SP3k4MMzh/T6d916UELwSF7CVqbPCgwitUYA4usKqK/8xDjqL9ojI8AhiPBp5iUApRyEj
Xvcq0KHO1XQ+tXF10zUONLBEjtEy3uDduWAFZA5CmYbriM500DUuuy43oJfYoLM7GMywGjsA
3fQGEwCFk9rovsv+Kd2I8phg1hVMlISmiMcFXvLTZuTSsXlhP1MF6OwxgfkKcrm7va5eZOdd
H1p1EytuIlTHZI+dXfXxmgR7g21xLWToZCqCUIFMPy1gOtoSkmAAgEE4yTqd8vjTYOFbUd4/
ul1ghfGiccHSyN3mNqrf5maMoE3LNViGGBhFd7gB9b8p9LMtAMoYHCBfKYNnQEmu0BDt9O7R
0ZGNEMT8Gspt+UJ8fe2yBRUOWmeDbIO3mZwItsBoRe+bgOJWBmTrPyWzkzBAY3y4zNITDrIG
mxFWlfKvElpvN/DLiWZFFd5Blo4QZ7lYTiauafHF43I2hp8uMMcYGLRB24uwM2DO3qhtvxnk
DFDFQkdvBLorKdhlOX9YD+idD4R8Z2siPiAKfkUFNrE04uaxyyLF87BCNksnG4cWh+hh2Ysb
++5VbuKATM4W+raXsNXNvV6NwQ4Kn388fj0owGyH1lgQhrdjtHHeZEEa8adZULFq79NdpE02
wpC3ju8dbOC4zWpcRNDLf4qLGE/u5csQ7uFVBA5MaImOWYrEvrOl9SkI0t97jIrQ5+Wim0dp
Y27CL//nUEKFZkg9Nvt1UdljQAlFe1Q28ClcxGPUCUNNeVPFG6IKGgxhGVrQa9gAv/VoS7qp
6wTE1tvFwoUvA5AxPNLtQLcYA2q/t5oqwfAeDHH8S0keBxrHQREaDRs/GxwJi9c229DNBj/w
smfHecw1TkFcWPB7TMRDSOiY+WownG6yExmQDGjFPkE9sB39nm7y3wMHJIUBzZJ928Kaj4Go
xVZTdWDjAdvlGK9Vlvwd6z1OZ7Ppil0ttw+PRaQjIiiJxuBig9T5JVmiwztSsC8Xs+QBvr07
vv3qhIXx8ZhFh+1h2UzYEXvcbFbd4+MkzWBt6IweO+m2s1w/HEObY0cXcjz4/rb4A7Yp/7r5
LWSTKXS9lRQAdQLP21E+Lgo0abv+x0v220U/X1GLsPdkA+bNcJuvjHjDQCWKDMmjiPb5l1dA
XAhHVHxK2MpInIbD1BNhFydXR7o2cSyhzcMkgw3rx4u+gHFFNxV4ODykmVRX9OELil5GTUUP
aFJI3oIWxc+jlRXfa2ihiGO8yeGHdQgnLtmy7mXC1hFYFV/ZqWsEgxhD8DMYHz/9oYP4p1Yy
Q47y9zTPYAcKjftn/csyuPtgmD28K4ZZ0R1gw+Qdwg7myb/BmhCqSI9ATBjkoO1hk0ZXQW5n
KdaMX678ANSD3C5yVLAtwu16hWr+7agM7K4zbzBgW+HhUn9DN7MXebd5bGM69lrKQGMk7Gg9
wtIVZ3dng6sPg/eX9312wswhffH+Ayu+cGRcoWMzJ8MH5NUKbGrvYZHxgtsFoeNiM4RRgqHS
MtSg/dKRg5NCF3CjBhteM0Ob9bzZqx4rudGSVx8LIwNnJOENRsv5kC4DMTKSTeyCCEPgopKJ
/alig6GTGLc7mG5MhJfUV/zZBqPMNAbyTFfzKZtjcOZDagsSeCNMxh3hCITEE6PL3vVl7rmz
/nd0HOdDs+MaSylz9EE27YKVTfsqvJEH93LJ4kcD46DYUiG5Etjj9ln9y4vGk1xLrXANmi5W
W1gNerBhWLP3YAMB90nGjnMPzPHVzW/9/+3fX8OGAz/3fr17f4Ofic7+HzjM0LjI0wrkFyC8
+OoaxpFNJ1rDAga9InRwzEOtgzJzQjEKE7WXKMGOZm33an51dsBBbxuINvdqUcl3XDAxFRuv
xIEtKJYNOcFNNUawD4bJdgy/2ntP3rFpBmsrPfe0gMSLXnHfkru3EJI7SOEg5f6QUkUGTL9F
NhrgyKpkErhGWqHsMtgnTbtd+jGwF0V8uLu7vQMiqjkPmriPf7s8d5QwPUAI8+/JE5pAKwlP
Awj74XJQZlCl75fJenyebBLYtK7XmAHVv8bzCOAZ0+7crRYY+48hrXO793JPiozR5ZPox3jc
7dKHgbV6cuALG627WfpFiIf4fEzPSBxizNEq/g8RSxgVCFzrf4HdM+0Tu9bmpBjr4rs8tQYX
Wc4ONlPcTWaMmwCX9yXstdEKXIMRhl+H5bfvyrkpIrQ5v1IOXhdTfjAY31/YoYkJJK4C6+G4
W19itHjnmuEJL9g06G7LU6AO7sBmurs9xq/YTbqh5LrcoX9UKpaoIzuCH/1ujm5OiyA/xFPk
4c3xqjcS8DiOj+hagjLVCqYWWdblq4UyoFSX3SeTRREDnAqUg2xJQc8JKdAdQM+uBImxdPMI
3BygU0FKMN27UhyBsfmOadHVCptx0ZWqq0MHpij4dSfYblGd2aTR8lY0BANjDhNUljC0Tpcf
2JPR5eDJSpsPGxqO3THFC4K66LOG//rHAjHxxBA1+5f8dKH7z/fnh/n5QPf69tNXm8MRBofw
n2J0leQhFyU0rNxoD4IVM1127RMYQDAbt98gdXRcYoZjhe7002+76LwHSom+g/kSTbb0KX8T
+rXwEuGtWtbVild+sXm5uiG5ikO3LJzes3t0iM0opwbzpQXaZXYi+8vEClqgo/aYOD0mtiuL
hHszJULMPcymeC9I175Q+gd5cEf5nqcoejJKFnk+MEzlrWNSaYGmcbJagUE/RxujTMibJWC7
rkif0WHCXzyimEZDSZRbheSQKrIL1unm5IjH7zyyiLa7lMUjJg+teTxe4wiTVvZrrANuffwG
bGX0J57hhz+I93GeoHxY6Bn8Euz/1G2kEUFwnC3J+CmBB4wev4+hz349vy9eDXv4tPgjw/3p
rNDCMAagV1LnSMvKxSjGEJhINoA9l1uHFbelWUXJDhbL73Th0EkRdoAoYYz27fdkkq61EbKN
vV/xjwz/+ir+jMBDlioyLtHuUuJAKQnD26Yeg1LfZk7yJuY2otBEissBUX8urjbu0HoPyzQs
9x88EhOFNZJ8eBaWPda3GkEf4/JJ13KdcNhVH4AyhSEVOrHEAeUBZcNRBAvX4JW8xzC0Ysor
1ESJDx2ULNhx7BoLclxB48k6/TZY0OmKwGHJFhf0mcEKv8rSjSNRHA9wAQWvszwC0q6/8aH1
dzzFJDtGZ3q4LbYlbbICQ+Ila3i49/sG9mEwsBP0JbCPuCej7DDs+JX90j/gwbmPfpKiL7pM
dCLtUEONEdEvnjuFjiISuBPpT+cw59n9GXEMzF55izY2A52l9jiHCBxFbDQ6CWwKE7vLi0iQ
s+Cy9+Q4APWPmc7z6QqMyWu8DTGtNYAOlXs8O3IUYO/twW3sCJREKfwmdB6HUo71oCO8VrHe
41RPSkehQx15G/z1H+tVc28fUwQJLknVhoOstamNRZ2JzaqInBEYpILp4cXW4LPoBB5BJPaQ
n3TDCHanOPkxa+BbF390+L/Y56vTG9bPg2CeeMe45rHCQ6pstFntPnijc7ZQHceynOZSBRon
wWa6GpVHPdi2dAqhC8przrXZI0BEuldXuHcuHtC3Pla6pMvqUYp/cwUQkABIgCBeLdABeGm9
SThu4x4l7uarqGuvaHdV9tt4kQ3wyHiGyrul85SmMNWyPd4h2d7OBNADs+kQW3iG8nJxvMzy
d2ZcHwvlySeM0fO4XKWLp4wCVrrsFn5hT3k5L/slbRNhh7FKNo+ONqYQLtAC2eAhA3vqunfV
Zx/7t41XhtmKazLeOZXf2ptfJ5Gfi+O1gY4nzamiRNn684e7/uXtTZcFmIAYcFVvGfzJf2+J
59KdEQ9MCdBTi+18CH27nICE7M6bHOvoedUdr7HBGeQaFxXL/uZcqnisrTyS0E4Gq+HparlL
Wy6t0/7PUUYSeyRvDY9o/D3CWYDfuZX4b7gNagrNyNh2F7VmePvf6vFHBqvZzKLTrckeQRyg
j6RCcJ7OUA39YPcwxLvMbxyij67S+Oq+z8p/fuMwkDxscs3x8TzC6i9eU4P5Vh4uo/x1oLNn
16hM3Lm7WyhCToZ2lbAHnUrLIS5cGGvp8YSOinr7Qu6lk9rnDPZquvkSokX0IXAj6tjJeogH
x/aMx2+sRBTkuBQ86L0oKd+u19REvCjqxALvD1qiGYMVJPAq7sJzdMhSDAU9pMs0YSk5CIJ3
6GO6O8Cfffq/GBKH7Nz++dqf82EYSpMD88NyX9wAFqIBPFs+0FAjYN4AjmL0lxOweAZYNjl+
ATiGRSwHlm8piigIo0IU6k2BBdXZIWD9psAwwnkOHL4psDJo4hBw9KbAIcWdE7B5U2BEzoFj
f7hRTR9vHL92uEXGyILj5C05NkGgiik9fFNgLnQBPHpuSvNXisIIykAi4PGbcizJ9Cbg9E2B
FW1sCHjypsBhEObA/E31sYlElHce528KbFRUcCz+v71rb3IbN/J/m58CSaVq5ZwpEXyTd8pl
13b28th1amf39lKpLR0foMSTSMokNfIkdd/9ugFQpGaGGonSzNg+u+CRRAJNPBqNBvuH7osS
9mxHzjx6UXnsUX4UihO+qDz2dNNsanxReeyBqJcThF5UHnugIMuliV5UHnu2gQegUC2R/uwk
sK3yO3k8fOsCeYRfUL/dZXuOgcck4JZw6+nTzi1uE4NbwnOm3+60PRAkOr8lHF/6ZucWdxgA
t4TfSr/d6HoeRds43BJ+YH27c4u7m4JbwpGr73Rueajzwi3hidXfbYUxkrkuCApXqr7XueXi
2wNsl2xz+7bE1KhhierTptW0c9PV5U1d3tTbm7owZ8JN2SnU6Nx0ZCOkP1C/3XCZoF+7Ypyk
Q0+fWp2bltfq9Qf/kbjI2bgtaRroekt6/fnrH8nVAraP0abe22mjZywO9kIkwCwSkRq/Czj4
hlS1jByPuTRPs4A/tZfq70awZwT561APdR4VLcGmrbs77K7HwcSu9KsovHVla3zdpwIX/tfY
0jzYcZd1mvC3c1VbChgL38YFczYrtjm+U61umVI9BPVShNntNu8Nluju/t2k1Na6L35YziEj
PZl1B7mQQPthqZSbRthGmL6HTKI5bU48PPILWUR1Ud1wP3uN6Rs3/QS6uTFgjOB7OydNaurI
CNwN2ts3b0gSROkK30teowMEPCNlqn/a5KoO/Wo3ZwuEeaClYdvI24fhqjLMu/CXonXO6CIB
x8F58zOPQ4lvMHDDIre6S1bmbEVEHAXP0txlW8zleKFDxXjUC/QcyF9soJdOqrcEdNeiwt6T
12QEXPMAWEfTumCdCaujSRldjePJlaYlIfd+7hOOWDF8MqnCNJ8Aa0PNQsbfG1ebaMGRVIQ7
ziw5HPdmVx0TdquIadkRwzpZB+sETG3eARABKQtmAgxJGSEJ9wESmtslofyVQ7AJBujw+clE
fK/cvjUwbZif6N6tZFjBB4Cxtuu691UQGBtVaF5B2O4dJGG6e/2+81e6AXZsf30DNQWVEgaa
ZbgpDsXveGdraBzckXXFNnGB+IRDo9KUFw2n6ILAcVGrEagyfEk2WxXFEoYJ9tboJynB17L1
pkRMJkPLO1F15bV81Sk9H0q/rxJYgqhvoiy2UswJ/1l8xn6F5sEJGigmMGG/OlTRHwREEs9m
1ghzI4Ix15naXKnQ3ItDuEW7GnrARdQjNk75czO9KnTPiX1I3v35V0qFrzcmqzScCBtaNTHH
1BlrahnZqkZN21PnpukZurXLMYbhOlTND0GJAMVjJkQJAmcNwwrZeVvEZFZ5JScaVRsaaPtE
0cltB3jslYDEVH4sUfDcIM6VkDfBNSN/gnWoIv8Ww/f/+T3mAwZZshvEPY43y98p1SLztQ+h
Y8WJFFFG7IYMlsaRKXwhgsBE722/tCvRTRWhAXjO6hlUBeQ9P0lDRgYFbg4q7quM7ZaKcVP+
DVSFQ/P4yd9yvuF+3HY85mked2ZSBnlcZD6pRVtQqnZ9P27EfS7esI5iduCvXUUldEVSIhXD
EdVtV6eaDatFk02O/xZrHCBfxsjNHAGyWY/Jzym0MZ3naENIEGEKwhVRtfCzsbGBpBorTbdg
l8iuqXjcjfxW83cu53a5MijKuEW860oY7ezcIyFK02KN76+q7hhArgeHIGZBYzrYVaDx6Qfb
wF0VxrJacJm2F5U3X3//LTrM/uGn77/H2BJfX5Ef3r37caz8lK/Q1nhTbHhHSIgymg8Ccp1C
x0G3S/jPKwEGiorNKobpjUACbt/fVLhgwSOzSkwCqC66N0XwONJ6/d27KwXmRJVm6SooyXaR
RgtJZg0LXY5jC6taFizZHt4IGAUFF1/9cVpgYJQApliZ8aPQ3Of1WPkbVD3jKJdtkPPTwgLm
g7mb5vBJpapxWazXZXpddZ1P4wmzMkXWDVYvx4qCjmZVUFCKLcb5aToH+APruMTLW2Sbpsfi
QkC6j5sSlu4hZPuxpgQuugYop9YzTYmWI837OFL7wpEfD0eK26+x0bhSRwtYiUidrSfcISho
sS3XugY/NvNIXEtNBIg4uFH82JlWlhDbPuk3H2Glmmc397gfbB9K8S2Wv2vUD8LBQDzpdpkl
srOWtARHIH2uS8Ssisp0DapEtVvabX7SVyztof20S/sxXHNgrGGvC3tGSr0va/aDa/bzMpvM
Inw0G5RnyIOMSc/EqNI3ea7Qv4iIE4gomG1ZoPFdbhOSejuaIND/5ZiMVOo3mrLE/r/cf5CJ
uPzbj4IuUTRKOBIUk6213zWj8/2cZN1/XYf9r0scmyjdHLbbyZFcqAbx/ddDgwSMeIfbuX83
0EjESGiTJGlTtwcfSJ2cpnt0qUsk5cBQnJx6BkZ3SZQQLyQae9K2PX7f9c0R70LP0O+/bgck
cDFk1D0d2p00z91Bd1PiElcnjtc7+e622gUGiu7MrZ6e+ZJ2SeH/O+zgdG5S+yECxwsvkXpY
npkY4Mo4LLL3B9PmKXT2B9x83N5yHpN4m3q6PTAIjR4uvidwdOtycubjSIrZ/X0qA95N3VX1
cM6evg8DEprEppeozCeRevohsIjlch3suFmoPH9LLpf2V/mudnYpkRT29LpLvIiYVq/U+ERT
76LUlfd7sv/UZwT3XwfF3tBJpB+Um3cUe9Cxbq9F5ysfffLkCZX/UyZpzwYBepNR9BV5SJv7
BNPelN/TDC61DvQIWicgNiMOu9wu++NIex1qHV+yb391qQ1rN/XImTDE8aBhr1R5luQY+KLA
SXo56VNPynOpXCgW96b8pURyT3tsGEkQo9rnt8r3qU27ydsnZJ9rb98zACB5Eo/ox++1ekY6
CUlMSRj1Knxf0pOl/ld3t/MdT/K2qYb7jakKftqWu9nG1+xjPGO4swKMldcctRMX7XnDv/zl
dUMq4pCmmFhU0qluWzWoOaEmSfjRPXSRXlbj7nFxn5qtIYSDihAfxGFuZRDB56zIyUF0WbRI
VzH1bYTBBlFUk5FFX7ZIpbffv7v62xV34LGU7ujTXLgcHu8XzpMKTSRRvSIjantH00CLqDXG
g9loEf3PP1z55OegzHn4YWkXVSMqo7wWq5g7jRy9RD92K+xsidVEY22JblmD8qapmQ41Q5fZ
S3YzS0rGyMhw9dMa1yWRSRQhktFObp/j4OGNbdM0aa0h/71ro/6VwLkhQDFmaxghzhtovqpX
jSM6bh/jpm5ZQQ0qqP2CJVdpSEaufVr7ZPGsuGYzbvBEY5sziAZa7TKWYbjn6IaMdMc6tY8s
07S0Xh7QzuEB2Ysjah7Pmby8AeUtXj6BvqHGyY2yNX7MsqdRxqBGySmXBHlRpwlwJlQABs4Y
1jbgnZL7XAMxMzIcc1gHsQgrDASs4wk0XeTxwHcX7aLuxOXYTpy1J0o2SeM6c218uMAAn9Y0
x3TxJF+WBetOk3QyAsoc11p153rJIN8MpbSYjNBUab0ekyuQX2+KiOMG+MnOyXU2uV1gXH+o
24e7Gve7/hj9in2Ccv5EcSNL7xiXg8CBcd1BPLeMOMOdOqUb1hASeHadzRD3cI2Ujpd8t3QB
DsuVusDI8C2fvhyjBZ77HZEeBhBm3PrTCW92KsHD1HTNuSA9w9f+H9XukiOhf8R1O7Hf7iqm
X1/9x+FnmPrADvhY9FzDd2wDncbMQT3fKTy6d+KSp/s8ksFg8cNLn7UyaUBDG6SVSP3BQf8j
5+oPshbDdc+m+BnqhyQydPfRpXGGkt8lM0hd6BLIuNMbUKBP1sQ4d5+hh3fJnLNrkiTOX+ZF
Tc5aqLuUhm1wZeGBKk8zVYfox3tcUcTYlau4lueqBlXiFmsMa0tnQLg/ez4iJ47trlVnbDzl
Nuj8VvH962VaJbbTp89gVNntMXUo9+3NcaWzbbBks2K9twfm3mgQGlwt0gTXZ1xvVfqvsOZ9
EMh6aAcsb1lL0uVHZjt6P2w+Dh8ctIz9Q3V73X3G6vno+Nungu/iK+N++K7Io+uubt7Jhly2
n89yrSMQuo9hOO6xQVKdJJS4xmdtsZBGyj4TxanAK+dpG3O+BaVnaGOP2BExwkfH431J95ge
+nEJlzKZiWHvM71+xKDbPdj8M0Do+1KPeZ6CSDeJdRiK9Izp0ijyi5rzT2FDk5KIEvveju6R
cbDPPAQ6O7ohccAPs3RF/50VNbbuINuPEaz7dTjBNH1i0nU8vAHzydt/hE5lsu/0Br1oBW7z
jRvyKeU8BOi9L+0JzKNVl36ZOyB90ob/JwTkgDrr8Ynbh8q6leiT4A/7UWzPBA0bCqs7PvUJ
I4orGA3OUAl6NheGR/SzlWXYBx/JOJ9NelLIff9qfinNq09Q3mK3PtH8xNut50gnDnhPh4IG
anvEiT9rwPGj7A36WOzz6sdOh3Y0pqMg8X0dcaoa0UPHjQh1SeAN10sOaKoux33vNPMHSD10
qlkQ0RNihyTRCWN7Cn/sktiR6cxB2ttHCDWZ4cmtbp740V7cPPOpr35I5/H9ejwr6T3PutRW
7CFYP3AobGpRVXoERQd9Nxok1j7xDcvpaU/KPco79b2HXZxoSKTpoEVS7MAVGDSR+3pJ86QQ
ZoQ74OSeKn2m73r7t/aXWsR7ps8Tg1vigIQeP2Lycb5sHDx+ZzL7ztKMPonPBbvoPgepDgWa
PDHciRBYO8ae5doYwfTqLQ9Phf7FIEcxz7n9M2f1CgNRyli7/g62NfVIvsqq+QydEE91zzJh
AKJVUFVTWWYWbOK0nskuX6fzKfQxd/E0bW3V+x030NLfYjDQX/UFsC1I5lwAmCRzLmCoS+Z0
pI0cYtfhCOMDBwto52BBEVbFitWMhHGy2lSL7rmClqRHMZL8H9IPAgGMdIQhvPr33aC66OZ3
MAyYlz7vxIDujjWNWvbxpyoebjyS1F3EFh9qPEoU70K4JBeD6ZyL7cHaDAcYUaiEdsYRCVn+
LAiepHEO6EySGA6/k1x5LpyoITMQmymLn4udk71xJr5K0DgbLrvfooELcJdFzhC6ksx5qFO5
pg2fc5LAJTBnu/V1mAyRYs8WsSyrm7xekA27Znnt341CjBoE+kfNZZYm7meF8nbeErMsDJBG
OsUkxWQXbLxieHoSH8fqNJIZ9ps0EGCNI2yfBUtGfXEYVlQWHj75b7PF0JVFUhraCbL44PVd
To/zJKkcyKF4aFn8PC664AwdiviHSWVrGEFKw3gf3/z0rU8wUMD7DdswgrEBNmuiknVRrDAe
cTXVeIRS+OD+XafaB7gAsxguVPUmWvIgwYZW/aql7FpI+WpRbPHp4aa6aZ9QEfTaij9ZyR8i
4/Hwgp6ByOi2NnwSV3775E5WD2OlgEzYviea/1BNReOndKLLGPZIw9M81EvxH2yHYq7x8e0e
zpJ1m43yIDS3azVbF1tWzliSpFEqhJF8qqu3ZXWTByHk1dR31Wxymrfqp+/Xz9AxRMde/XKW
zhczdD8N8jmaYaVe3XexJWLqttut/ZJH9Y3v61TPdAd1Km0pWC4eucV/aa4mK3Sy7ROd+iKU
8JpBjy0ZWwcYm3MmuKAtbDsunmRBznv46YtNPp8C30leqqYGSeMVbDsNonuK8nYVrLminmYM
w6koynuWbdQ0m8tNP1ET8j4qtjq6FV6qNwVsddX0OjSpStF5M4Gh+PbEQnRIIX1IIWNIIXNI
IWtIIVsUUpbX2XSkvOCFxe5I/eDaM9tUXqjC9bMKWeAHDDYGbd6y1erVv1QZW+NfmIQvVBlc
5zfiEy6gBlvGZFJUaQYq5IQ/W/xVm31aarj2OJr/A7JnWBX4rEBsU/iUoYkYhtV9lbMafuNr
CA1uiV9cl3uVxs1VdChPijJm5TSPMFehlgwvwvdtUEeLuJiT1DY0jVVh55oqlRkeqgiuY1wk
fM80xcgwK+RLrA3GyuZvXKb3s+GrjMVpwG++SpMpOthPiyMK0qEF9aEFjaEFzaEFraEF7b6C
GJ0gWMHCFgs6aQU6J55IzHGwsgKYC1a7fAMb/JeKEqxRLiODY0SeKY+iUwYZMA0Kp1kdVEvY
5YC8mgLjSTYI1vBTfocZUb6HJXwb3FQz6QkdaEWbdQxTbAxfZjAvZjz89wwZptjUU6i/8gJY
c5wmHOE/hZ9rYPt6OYbnL7NqPi1yuMSfq8KDqyKpxbLeVibP0lnDp1N+VXlRFOuq+Y6RvmfQ
FOygqY4PgH1JvbsCj4zLMB5naV6UswhDWk1d3h6Y4fF4VcxnPDrplJWl8kK4h5/BVX5ReREV
Ob45mdb1DVBiQbm6ES3AK1faK0otHVvZyde5ej0PpkAwC4BSuVVehGWQR4vpCl9J4uxmqwn/
qy6KDVBWdY26Gh5a8ZQX37x79+Psj999/e3b6WS9nE94oQlKCxXd4ItQ8WoVwsSDEtQ0jMk8
ilRz7E1kBCJLD53A1jU3sS0W204M6puZxE7oUNc0HSecXGdI9R9qbxCj+zsPhx32kONqsalj
2BJBJwOL/fo3/wQB+fff//K/vyaq4DcC18S3v/8WLiv/B/LHtKrZEgEA

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-yocto-ivb41-105:20180804225411:i386-randconfig-sb0-08041433:4.17.0-rc6-01470-gd2ba09c:1"

#!/bin/bash

kernel=$1
initrd=yocto-trinity-i386.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/yocto/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu Haswell,+smep,+smap
	-kernel $kernel
	-initrd $initrd
	-m 256
	-smp 1
	-device e1000,netdev=net0
	-netdev user,id=net0
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null
)

append=(
	root=/dev/ram0
	hung_task_panic=1
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	drbd.minor_count=8
	systemd.log_level=err
	ignore_loglevel
	console=tty0
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	vga=normal
	rw
	drbd.minor_count=8
	rcuperf.shutdown=0
)

"${kvm[@]}" -append "${append[*]}"

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.17.0-rc6-01470-gd2ba09c"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 4.17.0-rc6 Kernel Configuration
#
CONFIG_X86_32=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/i386_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
CONFIG_KERNEL_LZO=y
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
# CONFIG_SYSVIPC is not set
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_CROSS_MEMORY_ATTACH is not set
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y
CONFIG_AUDIT_WATCH=y
CONFIG_AUDIT_TREE=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_HUGETLB is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_NAMESPACES is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
# CONFIG_SYSFS_SYSCALL is not set
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
# CONFIG_ELF_CORE is not set
# CONFIG_PCSPKR_PLATFORM is not set
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT_ALWAYS_ON=y
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# CONFIG_VM_EVENT_COUNTERS is not set
CONFIG_COMPAT_BRK=y
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_PROFILING=y
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
# CONFIG_JUMP_LABEL is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
CONFIG_GCC_PLUGIN_CYC_COMPLEXITY=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
CONFIG_GCC_PLUGIN_STRUCTLEAK=y
CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE is not set
CONFIG_GCC_PLUGIN_RANDSTRUCT=y
# CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE is not set
CONFIG_HAVE_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR_NONE is not set
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
CONFIG_CC_STACKPROTECTOR_AUTO=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
CONFIG_REFCOUNT_FULL=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_LBDAF=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_CMDLINE_PARSER=y
CONFIG_BLK_WBT=y
# CONFIG_BLK_WBT_SQ is not set
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
# CONFIG_ACORN_PARTITION_CUMANA is not set
CONFIG_ACORN_PARTITION_EESOX=y
# CONFIG_ACORN_PARTITION_ICS is not set
CONFIG_ACORN_PARTITION_ADFS=y
CONFIG_ACORN_PARTITION_POWERTEC=y
CONFIG_ACORN_PARTITION_RISCIX=y
# CONFIG_AIX_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
CONFIG_SYSV68_PARTITION=y
# CONFIG_CMDLINE_PARTITION is not set
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
# CONFIG_IOSCHED_DEADLINE is not set
CONFIG_IOSCHED_CFQ=m
CONFIG_DEFAULT_NOOP=y
CONFIG_DEFAULT_IOSCHED="noop"
CONFIG_MQ_IOSCHED_DEADLINE=y
# CONFIG_MQ_IOSCHED_KYBER is not set
# CONFIG_IOSCHED_BFQ is not set
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_FREEZER=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_INTEL_RDT=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
# CONFIG_X86_RDC321X is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_X86_32_IRIS is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
CONFIG_NO_BOOTMEM=y
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_CYRIX_32 is not set
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
# CONFIG_CPU_SUP_UMC_32 is not set
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_UP_LATE_INIT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
# CONFIG_X86_ANCIENT_MCE is not set
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=y
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=m
# CONFIG_X86_LEGACY_VM86 is not set
# CONFIG_TOSHIBA is not set
CONFIG_I8K=y
# CONFIG_X86_REBOOTFIXUPS is not set
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_GENERIC_GUP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=y
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_NEED_PER_CPU_KM=y
# CONFIG_CLEANCACHE is not set
# CONFIG_FRONTSWAP is not set
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_AREAS=7
# CONFIG_ZPOOL is not set
CONFIG_ZBUD=m
CONFIG_ZSMALLOC=m
CONFIG_PGTABLE_MAPPING=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_FRAME_VECTOR=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_BENCHMARK=y
# CONFIG_HIGHPTE is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
# CONFIG_ARCH_RANDOM is not set
CONFIG_X86_SMAP=y
# CONFIG_X86_INTEL_UMIP is not set
# CONFIG_EFI is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_KEXEC=y
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
# CONFIG_HIBERNATION is not set
CONFIG_PM_SLEEP=y
CONFIG_PM_AUTOSLEEP=y
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
# CONFIG_PM_WAKELOCKS_GC is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
CONFIG_PM_TEST_SUSPEND=y
CONFIG_PM_SLEEP_DEBUG=y
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_DPTF_POWER is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y
CONFIG_X86_APM_BOOT=y
CONFIG_APM=m
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_ALLOW_INTS=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=m
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=m
# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m

#
# CPU frequency scaling drivers
#
# CONFIG_CPUFREQ_DT is not set
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
CONFIG_X86_POWERNOW_K6=m
CONFIG_X86_POWERNOW_K7=y
CONFIG_X86_POWERNOW_K7_ACPI=y
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
CONFIG_X86_SPEEDSTEP_ICH=m
CONFIG_X86_SPEEDSTEP_SMI=m
CONFIG_X86_P4_CLOCKMOD=m
CONFIG_X86_CPUFREQ_NFORCE2=y
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set
# CONFIG_X86_E_POWERSAVER is not set

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK=y

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
# CONFIG_CPU_IDLE_GOV_MENU is not set
# CONFIG_INTEL_IDLE is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_HOST is not set

#
# DesignWare PCI Core Support
#

#
# PCI host controller drivers
#

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
CONFIG_SCx200=m
CONFIG_SCx200HR_TIMER=m
# CONFIG_OLPC is not set
CONFIG_ALIX=y
CONFIG_NET5501=y
CONFIG_GEOS=y
CONFIG_AMD_NB=y
CONFIG_PCCARD=m
CONFIG_PCMCIA=m
# CONFIG_PCMCIA_LOAD_CIS is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
# CONFIG_RAPIDIO is not set
CONFIG_X86_SYSFB=y

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_HAVE_AOUT=y
CONFIG_BINFMT_AOUT=y
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
CONFIG_COMPAT_32=y
CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_IPCOMP=y
# CONFIG_NET_KEY is not set
CONFIG_XDP_SOCKETS=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=y
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
# CONFIG_IP_MROUTE is not set
# CONFIG_SYN_COOKIES is not set
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_INET_ESP_OFFLOAD=y
CONFIG_INET_IPCOMP=y
CONFIG_INET_XFRM_TUNNEL=y
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=m
CONFIG_INET_XFRM_MODE_BEET=m
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_INET_UDP_DIAG=y
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
CONFIG_IPV6_OPTIMISTIC_DAD=y
# CONFIG_INET6_AH is not set
CONFIG_INET6_ESP=y
CONFIG_INET6_ESP_OFFLOAD=m
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=y
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=y
# CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET6_XFRM_MODE_TUNNEL is not set
CONFIG_INET6_XFRM_MODE_BEET=m
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
# CONFIG_IPV6_GRE is not set
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_NETLABEL is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
# CONFIG_NETFILTER is not set
CONFIG_BPFILTER=y
CONFIG_BPFILTER_UMH=y
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=y
CONFIG_SCTP_DBG_OBJCNT=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
# CONFIG_SCTP_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=y
# CONFIG_RDS is not set
CONFIG_TIPC=y
CONFIG_TIPC_MEDIA_UDP=y
# CONFIG_TIPC_DIAG is not set
CONFIG_ATM=y
# CONFIG_ATM_CLIP is not set
# CONFIG_ATM_LANE is not set
# CONFIG_ATM_BR2684 is not set
CONFIG_L2TP=y
CONFIG_L2TP_DEBUGFS=m
# CONFIG_L2TP_V3 is not set
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_DECNET=m
CONFIG_DECNET_ROUTER=y
CONFIG_LLC=y
CONFIG_LLC2=y
CONFIG_ATALK=m
# CONFIG_DEV_APPLETALK is not set
CONFIG_X25=y
# CONFIG_LAPB is not set
CONFIG_PHONET=y
# CONFIG_6LOWPAN is not set
CONFIG_IEEE802154=y
CONFIG_IEEE802154_NL802154_EXPERIMENTAL=y
CONFIG_IEEE802154_SOCKET=m
CONFIG_MAC802154=y
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=y
# CONFIG_NET_SCH_ATM is not set
CONFIG_NET_SCH_PRIO=y
CONFIG_NET_SCH_MULTIQ=m
# CONFIG_NET_SCH_RED is not set
CONFIG_NET_SCH_SFB=y
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=y
CONFIG_NET_SCH_CBS=m
CONFIG_NET_SCH_GRED=m
# CONFIG_NET_SCH_DSMARK is not set
# CONFIG_NET_SCH_NETEM is not set
# CONFIG_NET_SCH_DRR is not set
CONFIG_NET_SCH_MQPRIO=y
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=y
# CONFIG_NET_SCH_FQ_CODEL is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
# CONFIG_NET_SCH_PIE is not set
# CONFIG_NET_SCH_INGRESS is not set
# CONFIG_NET_SCH_PLUG is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_SFQ=y
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="sfq"

#
# Classification
#
CONFIG_NET_CLS=y
# CONFIG_NET_CLS_BASIC is not set
CONFIG_NET_CLS_TCINDEX=y
# CONFIG_NET_CLS_ROUTE4 is not set
# CONFIG_NET_CLS_FW is not set
# CONFIG_NET_CLS_U32 is not set
CONFIG_NET_CLS_RSVP=y
# CONFIG_NET_CLS_RSVP6 is not set
# CONFIG_NET_CLS_FLOW is not set
# CONFIG_NET_CLS_CGROUP is not set
CONFIG_NET_CLS_BPF=y
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=y
CONFIG_NET_EMATCH_NBYTE=y
CONFIG_NET_EMATCH_U32=y
CONFIG_NET_EMATCH_META=m
# CONFIG_NET_EMATCH_TEXT is not set
CONFIG_NET_EMATCH_CANID=y
CONFIG_NET_CLS_ACT=y
# CONFIG_NET_ACT_POLICE is not set
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
# CONFIG_NET_ACT_MIRRED is not set
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=y
CONFIG_NET_ACT_SKBEDIT=y
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_SKBMOD=y
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=y
CONFIG_NET_SCH_FIFO=y
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=m
CONFIG_BATMAN_ADV_BATMAN_V=y
# CONFIG_BATMAN_ADV_BLA is not set
CONFIG_BATMAN_ADV_DAT=y
CONFIG_BATMAN_ADV_NC=y
CONFIG_BATMAN_ADV_MCAST=y
# CONFIG_BATMAN_ADV_DEBUGFS is not set
CONFIG_OPENVSWITCH=y
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=y
# CONFIG_VSOCKETS_DIAG is not set
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
# CONFIG_MPLS_IPTUNNEL is not set
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
CONFIG_NET_NCSI=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y

#
# Network testing
#
CONFIG_NET_PKTGEN=y
# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
# CONFIG_CAN_RAW is not set
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m

#
# CAN Device Drivers
#
# CONFIG_CAN_VCAN is not set
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_LEDS is not set
CONFIG_CAN_GRCAN=m
# CONFIG_PCH_CAN is not set
# CONFIG_CAN_C_CAN is not set
# CONFIG_CAN_CC770 is not set
CONFIG_CAN_IFI_CANFD=m
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_SJA1000_ISA=m
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_EMS_PCMCIA=m
# CONFIG_CAN_EMS_PCI is not set
CONFIG_CAN_PEAK_PCMCIA=m
# CONFIG_CAN_PEAK_PCI is not set
# CONFIG_CAN_KVASER_PCI is not set
# CONFIG_CAN_PLX_PCI is not set
CONFIG_CAN_SOFTING=m
CONFIG_CAN_SOFTING_CS=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
CONFIG_CAN_MCP251X=m
# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_BT=m
# CONFIG_BT_BREDR is not set
CONFIG_BT_LE=y
CONFIG_BT_LEDS=y
# CONFIG_BT_SELFTEST is not set
# CONFIG_BT_DEBUGFS is not set

#
# Bluetooth device drivers
#
CONFIG_BT_BCM=m
# CONFIG_BT_HCIBTSDIO is not set
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_SERDEV=y
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_NOKIA=m
# CONFIG_BT_HCIUART_BCSP is not set
CONFIG_BT_HCIUART_ATH3K=y
CONFIG_BT_HCIUART_LL=y
# CONFIG_BT_HCIUART_3WIRE is not set
# CONFIG_BT_HCIUART_INTEL is not set
CONFIG_BT_HCIUART_BCM=y
# CONFIG_BT_HCIUART_QCA is not set
# CONFIG_BT_HCIUART_AG6XX is not set
# CONFIG_BT_HCIUART_MRVL is not set
CONFIG_BT_HCIDTL1=m
CONFIG_BT_HCIBT3C=m
CONFIG_BT_HCIBLUECARD=m
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
CONFIG_BT_WILINK=m
CONFIG_AF_RXRPC=y
# CONFIG_AF_RXRPC_IPV6 is not set
# CONFIG_AF_RXRPC_INJECT_LOSS is not set
CONFIG_AF_RXRPC_DEBUG=y
# CONFIG_RXKAD is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_WIMAX=m
CONFIG_WIMAX_DEBUG_LEVEL=8
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
CONFIG_RFKILL_GPIO=m
CONFIG_NET_9P=y
# CONFIG_NET_9P_VIRTIO is not set
# CONFIG_NET_9P_DEBUG is not set
CONFIG_CAIF=m
CONFIG_CAIF_DEBUG=y
CONFIG_CAIF_NETDEV=m
CONFIG_CAIF_USB=m
CONFIG_CEPH_LIB=y
CONFIG_CEPH_LIB_PRETTYDEBUG=y
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
CONFIG_NFC=m
# CONFIG_NFC_DIGITAL is not set
CONFIG_NFC_NCI=m
CONFIG_NFC_NCI_SPI=m
CONFIG_NFC_NCI_UART=m
# CONFIG_NFC_HCI is not set

#
# Near Field Communication (NFC) devices
#
# CONFIG_NFC_FDP is not set
# CONFIG_NFC_PN533_I2C is not set
CONFIG_NFC_MRVL=m
CONFIG_NFC_MRVL_UART=m
CONFIG_NFC_MRVL_I2C=m
CONFIG_NFC_MRVL_SPI=m
CONFIG_NFC_ST_NCI=m
CONFIG_NFC_ST_NCI_I2C=m
CONFIG_NFC_ST_NCI_SPI=m
# CONFIG_NFC_NXP_NCI is not set
# CONFIG_NFC_S3FWRN5_I2C is not set
CONFIG_PSAMPLE=y
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# CONFIG_DMA_CMA is not set

#
# Bus devices
#
CONFIG_SIMPLE_PM_BUS=m
# CONFIG_CONNECTOR is not set
# CONFIG_MTD is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION is not set
CONFIG_BLK_DEV_FD=m
CONFIG_CDROM=y
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
CONFIG_BLK_DEV_DRBD=m
# CONFIG_DRBD_FAULT_INJECTION is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=y
CONFIG_VIRTIO_BLK=y
CONFIG_VIRTIO_BLK_SCSI=y
CONFIG_BLK_DEV_RBD=y
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_MULTIPATH is not set
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_FC is not set
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_FC is not set

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=m
CONFIG_HMC6352=y
CONFIG_DS1682=y
# CONFIG_PCH_PHUB is not set
CONFIG_USB_SWITCH_FSA9480=m
CONFIG_LATTICE_ECP3_CONFIG=y
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_AT25=y
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=m
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
CONFIG_TI_ST=m
CONFIG_SENSORS_LIS3_I2C=y
CONFIG_ALTERA_STAPL=y
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#

#
# SCIF Bus Driver
#

#
# VOP Bus Driver
#

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
CONFIG_ECHO=y
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=m
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=m
CONFIG_SCSI_DMA=y
CONFIG_SCSI_MQ_DEFAULT=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_MPT3SAS is not set
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=m
# CONFIG_SCSI_UFSHCD_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_ISCI is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
CONFIG_SCSI_VIRTIO=m
# CONFIG_SCSI_LOWLEVEL_PCMCIA is not set
CONFIG_SCSI_DH=y
# CONFIG_SCSI_DH_RDAC is not set
CONFIG_SCSI_DH_HP_SW=m
# CONFIG_SCSI_DH_EMC is not set
# CONFIG_SCSI_DH_ALUA is not set
# CONFIG_SCSI_OSD_INITIATOR is not set
CONFIG_ATA=m
# CONFIG_ATA_VERBOSE_ERROR is not set
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
CONFIG_SATA_AHCI_PLATFORM=m
CONFIG_AHCI_CEVA=m
# CONFIG_AHCI_QORIQ is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
# CONFIG_ATA_SFF is not set
# CONFIG_MD is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
# CONFIG_TCM_FILEIO is not set
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set

#
# CAIF transport drivers
#
# CONFIG_CAIF_TTY is not set
# CONFIG_CAIF_SPI_SLAVE is not set
# CONFIG_CAIF_HSI is not set
# CONFIG_CAIF_VIRTIO is not set

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_MDIO=m
CONFIG_NET_VENDOR_3COM=y
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=m
CONFIG_E1000E_HWTS=y
CONFIG_IGB=m
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=m
CONFIG_IXGBE_HWMON=y
# CONFIG_I40E is not set
CONFIG_NET_VENDOR_EXAR=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
# CONFIG_MSCC_OCELOT_SWITCH is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_NI=y
CONFIG_NET_VENDOR_8390=y
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
# CONFIG_ETHOC is not set
CONFIG_NET_PACKET_ENGINE=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_QLGE is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_SPI is not set
# CONFIG_QCA7000_UART is not set
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_ALE is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_PCMCIA_RAYCS is not set

#
# WiMAX Wireless Broadband devices
#

#
# Enable USB support to see WiMAX USB drivers
#
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=y
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
# CONFIG_INPUT_SPARSEKMAP is not set
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
CONFIG_KEYBOARD_ADP5589=m
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1070=m
CONFIG_KEYBOARD_QT2160=m
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
CONFIG_KEYBOARD_GPIO=y
CONFIG_KEYBOARD_GPIO_POLLED=m
CONFIG_KEYBOARD_TCA6416=m
CONFIG_KEYBOARD_TCA8418=y
CONFIG_KEYBOARD_MATRIX=m
CONFIG_KEYBOARD_LM8323=m
CONFIG_KEYBOARD_LM8333=m
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_KEYBOARD_OPENCORES=m
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_KEYBOARD_SUNKBD=y
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TC3589X is not set
CONFIG_KEYBOARD_TM2_TOUCHKEY=y
CONFIG_KEYBOARD_TWL4030=m
CONFIG_KEYBOARD_XTKBD=y
# CONFIG_KEYBOARD_CROS_EC is not set
CONFIG_KEYBOARD_CAP11XX=m
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
CONFIG_JOYSTICK_A3D=y
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
CONFIG_JOYSTICK_GRIP=m
CONFIG_JOYSTICK_GRIP_MP=y
# CONFIG_JOYSTICK_GUILLEMOT is not set
CONFIG_JOYSTICK_INTERACT=y
CONFIG_JOYSTICK_SIDEWINDER=y
CONFIG_JOYSTICK_TMDC=y
# CONFIG_JOYSTICK_IFORCE is not set
CONFIG_JOYSTICK_WARRIOR=m
CONFIG_JOYSTICK_MAGELLAN=m
CONFIG_JOYSTICK_SPACEORB=m
CONFIG_JOYSTICK_SPACEBALL=m
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDJOY is not set
CONFIG_JOYSTICK_ZHENHUA=y
CONFIG_JOYSTICK_AS5011=y
CONFIG_JOYSTICK_JOYDUMP=m
# CONFIG_JOYSTICK_XPAD is not set
CONFIG_JOYSTICK_PSXPAD_SPI=y
# CONFIG_JOYSTICK_PSXPAD_SPI_FF is not set
# CONFIG_JOYSTICK_PXRC is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
# CONFIG_RMI4_F11 is not set
CONFIG_RMI4_F12=y
# CONFIG_RMI4_F30 is not set
# CONFIG_RMI4_F34 is not set
CONFIG_RMI4_F54=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_SERIO_APBPS2 is not set
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_SYNCLINK_GT is not set
# CONFIG_NOZOMI is not set
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_TRACE_ROUTER=m
CONFIG_TRACE_SINK=m
# CONFIG_DEVMEM is not set
CONFIG_DEVKMEM=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_CS=m
CONFIG_SERIAL_8250_MEN_MCB=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
CONFIG_SERIAL_8250_DW=y
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set
CONFIG_SERIAL_OF_PLATFORM=m

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
CONFIG_SERIAL_UARTLITE=m
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
CONFIG_SERIAL_SC16IS7XX=y
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
# CONFIG_SERIAL_SC16IS7XX_SPI is not set
# CONFIG_SERIAL_TIMBERDALE is not set
CONFIG_SERIAL_ALTERA_JTAGUART=m
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_IFX6X60=y
# CONFIG_SERIAL_PCH_UART is not set
CONFIG_SERIAL_XILINX_PS_UART=y
CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=y
# CONFIG_SERIAL_FSL_LPUART_CONSOLE is not set
CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE=y
CONFIG_SERIAL_MEN_Z135=y
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
CONFIG_TTY_PRINTK=y
CONFIG_HVC_DRIVER=y
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PROC_INTERFACE=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
# CONFIG_IPMI_WATCHDOG is not set
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
CONFIG_HW_RANDOM_GEODE=y
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_NVRAM=m
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=m
CONFIG_CARDMAN_4000=m
CONFIG_CARDMAN_4040=m
CONFIG_SCR24X=m
# CONFIG_IPWIRELESS is not set
CONFIG_MWAVE=y
CONFIG_SCx200_GPIO=m
CONFIG_PC8736x_GPIO=m
CONFIG_NSC_GPIO=y
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=m
CONFIG_TCG_TIS=m
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C_ATMEL is not set
# CONFIG_TCG_TIS_I2C_INFINEON is not set
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
# CONFIG_TCG_NSC is not set
# CONFIG_TCG_ATMEL is not set
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
CONFIG_TCG_VTPM_PROXY=m
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
CONFIG_TCG_TIS_ST33ZP24_SPI=m
CONFIG_TELCLOCK=m
CONFIG_DEVPORT=y
CONFIG_XILLYBUS=y
# CONFIG_XILLYBUS_OF is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=m
CONFIG_I2C_MUX_GPIO=m
# CONFIG_I2C_MUX_GPMUX is not set
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=m
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_PINCTRL is not set
CONFIG_I2C_MUX_REG=y
CONFIG_I2C_DEMUX_PINCTRL=m
CONFIG_I2C_MUX_MLXCPLD=y
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=m
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
CONFIG_I2C_KEMPLD=m
CONFIG_I2C_OCORES=m
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_PXA is not set
# CONFIG_I2C_RK3X is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT_LIGHT is not set
CONFIG_I2C_TAOS_EVM=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_CROS_EC_TUNNEL is not set
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=m
# CONFIG_SPI_AXI_SPI_ENGINE is not set
CONFIG_SPI_BITBANG=y
# CONFIG_SPI_CADENCE is not set
CONFIG_SPI_DESIGNWARE=y
# CONFIG_SPI_DW_PCI is not set
# CONFIG_SPI_DW_MMIO is not set
CONFIG_SPI_GPIO=m
CONFIG_SPI_FSL_LIB=y
CONFIG_SPI_FSL_SPI=y
CONFIG_SPI_OC_TINY=y
# CONFIG_SPI_PXA2XX is not set
CONFIG_SPI_ROCKCHIP=y
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_TOPCLIFF_PCH is not set
CONFIG_SPI_XCOMM=m
# CONFIG_SPI_XILINX is not set
CONFIG_SPI_ZYNQMP_GQSPI=y

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
CONFIG_SPI_LOOPBACK_TEST=m
CONFIG_SPI_TLE62X0=y
CONFIG_SPI_SLAVE=y
CONFIG_SPI_SLAVE_TIME=m
CONFIG_SPI_SLAVE_SYSTEM_CONTROL=y
# CONFIG_SPMI is not set
CONFIG_HSI=m
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=m
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PTP_1588_CLOCK_PCH=y
CONFIG_PTP_1588_CLOCK_KVM=y
CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
CONFIG_PINCTRL_AS3722=m
CONFIG_PINCTRL_AMD=y
CONFIG_PINCTRL_MCP23S08=m
CONFIG_PINCTRL_SINGLE=y
# CONFIG_PINCTRL_SX150X is not set
# CONFIG_PINCTRL_MAX77620 is not set
CONFIG_PINCTRL_RK805=y
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_GPIOLIB=y
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=m

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
CONFIG_GPIO_ALTERA=m
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_FTGPIO010 is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_GRGPIO=m
CONFIG_GPIO_HLWD=y
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=m
CONFIG_GPIO_MENZ127=y
CONFIG_GPIO_MOCKUP=m
# CONFIG_GPIO_SYSCON is not set
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_XILINX=y

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_104_DIO_48E=y
# CONFIG_GPIO_104_IDIO_16 is not set
CONFIG_GPIO_104_IDI_48=m
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_GPIO_MM=m
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
CONFIG_GPIO_WINBOND=m
# CONFIG_GPIO_WS16C48 is not set

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=m
# CONFIG_GPIO_ADNP is not set
CONFIG_GPIO_MAX7300=m
# CONFIG_GPIO_MAX732X is not set
CONFIG_GPIO_PCA953X=m
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=m
# CONFIG_GPIO_BD9571MWV is not set
CONFIG_GPIO_DA9052=y
CONFIG_GPIO_KEMPLD=m
CONFIG_GPIO_LP873X=y
# CONFIG_GPIO_LP87565 is not set
CONFIG_GPIO_MAX77620=m
# CONFIG_GPIO_RC5T583 is not set
# CONFIG_GPIO_TC3589X is not set
CONFIG_GPIO_TPS65086=m
CONFIG_GPIO_TPS65218=m
# CONFIG_GPIO_TPS65910 is not set
# CONFIG_GPIO_TPS65912 is not set
CONFIG_GPIO_TWL4030=m
# CONFIG_GPIO_WM831X is not set
CONFIG_GPIO_WM8350=y
CONFIG_GPIO_WM8994=m

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set

#
# SPI GPIO expanders
#
# CONFIG_GPIO_74X164 is not set
CONFIG_GPIO_MAX3191X=m
# CONFIG_GPIO_MAX7301 is not set
CONFIG_GPIO_MC33880=m
CONFIG_GPIO_PISOSR=m
CONFIG_GPIO_XRA1403=y
CONFIG_W1=m

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_DS1WM=m
CONFIG_W1_MASTER_GPIO=m

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
# CONFIG_W1_SLAVE_SMEM is not set
CONFIG_W1_SLAVE_DS2405=m
CONFIG_W1_SLAVE_DS2408=m
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
# CONFIG_W1_SLAVE_DS2413 is not set
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=m
# CONFIG_W1_SLAVE_DS2805 is not set
CONFIG_W1_SLAVE_DS2431=m
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=m
# CONFIG_W1_SLAVE_DS2760 is not set
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=m
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=m
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_AS3722 is not set
# CONFIG_POWER_RESET_GPIO is not set
CONFIG_POWER_RESET_GPIO_RESTART=y
CONFIG_POWER_RESET_LTC2952=y
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_RESET_SYSCON=y
CONFIG_POWER_RESET_SYSCON_POWEROFF=y
CONFIG_REBOOT_MODE=m
CONFIG_SYSCON_REBOOT_MODE=m
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_PDA_POWER=m
CONFIG_WM831X_BACKUP=m
CONFIG_WM831X_POWER=y
CONFIG_WM8350_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=y
CONFIG_BATTERY_ACT8945A=m
CONFIG_BATTERY_DS2780=m
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=y
CONFIG_BATTERY_BQ27XXX=m
# CONFIG_BATTERY_BQ27XXX_I2C is not set
CONFIG_BATTERY_BQ27XXX_HDQ=m
# CONFIG_BATTERY_DA9052 is not set
CONFIG_BATTERY_DA9150=m
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
# CONFIG_BATTERY_MAX1721X is not set
# CONFIG_CHARGER_88PM860X is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LTC3651=y
CONFIG_CHARGER_MAX14577=m
CONFIG_CHARGER_DETECTOR_MAX14656=m
CONFIG_CHARGER_BQ2415X=y
# CONFIG_CHARGER_BQ24190 is not set
CONFIG_CHARGER_BQ24257=m
CONFIG_CHARGER_BQ24735=y
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=m
CONFIG_CHARGER_TPS65090=m
CONFIG_BATTERY_GAUGE_LTC2941=m
CONFIG_BATTERY_RT5033=m
CONFIG_CHARGER_RT9455=m
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
CONFIG_SENSORS_ABITUGURU3=y
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=y
# CONFIG_SENSORS_ADM1026 is not set
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=y
# CONFIG_SENSORS_ADT7411 is not set
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=m
# CONFIG_SENSORS_ADT7475 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_APPLESMC=y
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ASPEED=y
# CONFIG_SENSORS_ATXP1 is not set
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
CONFIG_SENSORS_DA9052_ADC=y
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_MC13783_ADC is not set
# CONFIG_SENSORS_FSCHMD is not set
# CONFIG_SENSORS_FTSTEUTATES is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=m
CONFIG_SENSORS_G762=m
# CONFIG_SENSORS_GPIO_FAN is not set
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=y
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=m
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LINEAGE=y
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
CONFIG_SENSORS_MAX1111=y
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
CONFIG_SENSORS_MAX31722=m
CONFIG_SENSORS_MAX6621=m
CONFIG_SENSORS_MAX6639=y
CONFIG_SENSORS_MAX6642=y
CONFIG_SENSORS_MAX6650=y
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
CONFIG_SENSORS_TC654=y
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM70=y
CONFIG_SENSORS_LM73=m
# CONFIG_SENSORS_LM75 is not set
CONFIG_SENSORS_LM77=m
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=y
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=y
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=m
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_NTC_THERMISTOR=y
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT7802=m
CONFIG_SENSORS_NCT7904=m
CONFIG_SENSORS_PCF8591=y
CONFIG_PMBUS=y
# CONFIG_SENSORS_PMBUS is not set
# CONFIG_SENSORS_ADM1275 is not set
CONFIG_SENSORS_IBM_CFFPS=m
CONFIG_SENSORS_IR35221=y
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=y
# CONFIG_SENSORS_LTC2978_REGULATOR is not set
CONFIG_SENSORS_LTC3815=y
# CONFIG_SENSORS_MAX16064 is not set
CONFIG_SENSORS_MAX20751=m
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=y
# CONFIG_SENSORS_TPS40422 is not set
CONFIG_SENSORS_TPS53679=y
CONFIG_SENSORS_UCD9000=y
# CONFIG_SENSORS_UCD9200 is not set
# CONFIG_SENSORS_ZL6100 is not set
# CONFIG_SENSORS_PWM_FAN is not set
CONFIG_SENSORS_SHT15=m
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SHT3x is not set
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=m
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
# CONFIG_SENSORS_SMSC47M192 is not set
CONFIG_SENSORS_SMSC47B397=y
# CONFIG_SENSORS_SCH5627 is not set
# CONFIG_SENSORS_SCH5636 is not set
CONFIG_SENSORS_STTS751=m
CONFIG_SENSORS_SMM665=y
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS1015=y
# CONFIG_SENSORS_ADS7828 is not set
CONFIG_SENSORS_ADS7871=m
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA209 is not set
# CONFIG_SENSORS_INA2XX is not set
CONFIG_SENSORS_INA3221=y
CONFIG_SENSORS_TC74=y
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_VIA_CPUTEMP=m
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=y
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=y
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=y
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_WM831X is not set
CONFIG_SENSORS_WM8350=m

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
CONFIG_CPU_THERMAL=y
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
CONFIG_MAX77620_THERMAL=y
CONFIG_QORIQ_THERMAL=y
CONFIG_DA9062_THERMAL=m
# CONFIG_INTEL_POWERCLAMP is not set
# CONFIG_X86_PKG_TEMP_THERMAL is not set
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_WATCHDOG_NOWAYOUT=y
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_SOFT_WATCHDOG_PRETIMEOUT=y
# CONFIG_DA9052_WATCHDOG is not set
# CONFIG_DA9062_WATCHDOG is not set
# CONFIG_GPIO_WATCHDOG is not set
# CONFIG_WDAT_WDT is not set
# CONFIG_WM831X_WATCHDOG is not set
CONFIG_WM8350_WATCHDOG=y
CONFIG_XILINX_WATCHDOG=y
CONFIG_ZIIRAVE_WATCHDOG=m
CONFIG_CADENCE_WATCHDOG=y
CONFIG_DW_WATCHDOG=y
CONFIG_RN5T618_WATCHDOG=y
CONFIG_TWL4030_WATCHDOG=y
CONFIG_MAX63XX_WATCHDOG=y
CONFIG_MAX77620_WATCHDOG=y
CONFIG_RETU_WATCHDOG=m
CONFIG_ACQUIRE_WDT=m
CONFIG_ADVANTECH_WDT=y
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
CONFIG_EBC_C384_WDT=m
CONFIG_F71808E_WDT=y
# CONFIG_SP5100_TCO is not set
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
CONFIG_IBMASR=y
CONFIG_WAFER_WDT=y
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=m
# CONFIG_IT87_WDT is not set
# CONFIG_HP_WATCHDOG is not set
CONFIG_KEMPLD_WDT=m
CONFIG_SC1200_WDT=m
# CONFIG_SCx200_WDT is not set
CONFIG_PC87413_WDT=y
# CONFIG_NV_TCO is not set
CONFIG_60XX_WDT=m
# CONFIG_SBC8360_WDT is not set
CONFIG_SBC7240_WDT=y
CONFIG_CPU5_WDT=y
# CONFIG_SMSC_SCH311X_WDT is not set
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_VIA_WDT is not set
# CONFIG_W83627HF_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_W83977F_WDT is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
CONFIG_MEN_A21_WDT=m

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC is not set
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=m
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
# CONFIG_SSB_SILENT is not set
# CONFIG_SSB_DEBUG is not set
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_SFLASH=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
CONFIG_MFD_ACT8945A=m
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_AS3722=y
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_ATMEL_FLEXCOM is not set
CONFIG_MFD_ATMEL_HLCDC=m
CONFIG_MFD_BCM590XX=m
CONFIG_MFD_BD9571MWV=m
# CONFIG_MFD_AXP20X_I2C is not set
CONFIG_MFD_CROS_EC=y
CONFIG_MFD_CROS_EC_I2C=m
CONFIG_MFD_CROS_EC_SPI=m
# CONFIG_MFD_CROS_EC_CHARDEV is not set
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
CONFIG_MFD_DA9052_I2C=y
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=m
# CONFIG_MFD_DA9063 is not set
CONFIG_MFD_DA9150=m
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
CONFIG_MFD_MC13XXX_I2C=m
CONFIG_MFD_HI6421_PMIC=y
CONFIG_HTC_PASIC3=y
CONFIG_HTC_I2CPLD=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=m
CONFIG_MFD_88PM805=m
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=m
CONFIG_MFD_MAX77620=y
# CONFIG_MFD_MAX77686 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6397=y
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_CPCAP=y
CONFIG_MFD_RETU=y
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT5033=m
CONFIG_MFD_RC5T583=y
CONFIG_MFD_RK808=y
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=m
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=m
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
# CONFIG_AB3100_CORE is not set
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=m
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=m
CONFIG_MFD_TPS65086=m
CONFIG_MFD_TPS65090=y
# CONFIG_MFD_TPS65217 is not set
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TI_LP87565=m
CONFIG_MFD_TPS65218=m
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=m
# CONFIG_MFD_TPS65912_I2C is not set
CONFIG_MFD_TPS65912_SPI=m
# CONFIG_MFD_TPS80031 is not set
CONFIG_TWL4030_CORE=y
# CONFIG_MFD_TWL4030_AUDIO is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
CONFIG_MFD_LM3533=m
# CONFIG_MFD_TIMBERDALE is not set
CONFIG_MFD_TC3589X=y
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
CONFIG_MFD_ARIZONA_SPI=m
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
# CONFIG_MFD_WM5110 is not set
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM831X_SPI is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=m
# CONFIG_RAVE_SP_CORE is not set
CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
# CONFIG_REGULATOR_FIXED_VOLTAGE is not set
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=m
CONFIG_REGULATOR_88PG86X=m
CONFIG_REGULATOR_88PM800=m
CONFIG_REGULATOR_88PM8607=m
CONFIG_REGULATOR_ACT8865=m
CONFIG_REGULATOR_ACT8945A=m
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_ANATOP=y
CONFIG_REGULATOR_AS3722=y
CONFIG_REGULATOR_BCM590XX=m
# CONFIG_REGULATOR_BD9571MWV is not set
# CONFIG_REGULATOR_CPCAP is not set
CONFIG_REGULATOR_DA9052=m
CONFIG_REGULATOR_DA9062=m
# CONFIG_REGULATOR_DA9210 is not set
CONFIG_REGULATOR_DA9211=m
CONFIG_REGULATOR_FAN53555=y
# CONFIG_REGULATOR_GPIO is not set
# CONFIG_REGULATOR_HI6421 is not set
CONFIG_REGULATOR_HI6421V530=y
CONFIG_REGULATOR_ISL9305=y
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_LM363X=m
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=m
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP873X=m
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LP87565=m
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=m
# CONFIG_REGULATOR_MAX14577 is not set
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX77620=m
# CONFIG_REGULATOR_MAX8649 is not set
CONFIG_REGULATOR_MAX8660=y
# CONFIG_REGULATOR_MAX8952 is not set
CONFIG_REGULATOR_MAX8973=y
# CONFIG_REGULATOR_MAX8998 is not set
CONFIG_REGULATOR_MC13XXX_CORE=m
# CONFIG_REGULATOR_MC13783 is not set
CONFIG_REGULATOR_MC13892=m
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_MT6323=m
CONFIG_REGULATOR_MT6397=y
CONFIG_REGULATOR_PFUZE100=m
CONFIG_REGULATOR_PV88060=y
# CONFIG_REGULATOR_PV88080 is not set
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_PWM=m
CONFIG_REGULATOR_RC5T583=m
CONFIG_REGULATOR_RK808=y
CONFIG_REGULATOR_RN5T618=y
CONFIG_REGULATOR_RT5033=m
CONFIG_REGULATOR_S2MPA01=y
# CONFIG_REGULATOR_S2MPS11 is not set
CONFIG_REGULATOR_S5M8767=y
CONFIG_REGULATOR_SKY81452=m
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS62360=y
# CONFIG_REGULATOR_TPS65023 is not set
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65086=m
# CONFIG_REGULATOR_TPS65090 is not set
# CONFIG_REGULATOR_TPS65132 is not set
# CONFIG_REGULATOR_TPS65218 is not set
CONFIG_REGULATOR_TPS6524X=m
CONFIG_REGULATOR_TPS65910=m
CONFIG_REGULATOR_TPS65912=m
# CONFIG_REGULATOR_TWL4030 is not set
# CONFIG_REGULATOR_VCTRL is not set
CONFIG_REGULATOR_WM831X=y
CONFIG_REGULATOR_WM8350=y
# CONFIG_REGULATOR_WM8994 is not set
CONFIG_CEC_CORE=m
CONFIG_RC_CORE=y
# CONFIG_RC_MAP is not set
# CONFIG_LIRC is not set
# CONFIG_RC_DECODERS is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_IR_ENE is not set
CONFIG_IR_HIX5HD2=m
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
# CONFIG_IR_ITE_CIR is not set
# CONFIG_IR_FINTEK is not set
# CONFIG_IR_NUVOTON is not set
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_WINBOND_CIR is not set
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_RC_LOOPBACK=m
CONFIG_IR_GPIO_CIR=m
# CONFIG_IR_SERIAL is not set
CONFIG_IR_SIR=y
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
CONFIG_MEDIA_SDR_SUPPORT=y
# CONFIG_MEDIA_CEC_SUPPORT is not set
# CONFIG_MEDIA_CEC_RC is not set
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_V4L2=y
CONFIG_VIDEO_ADV_DEBUG=y
CONFIG_VIDEO_FIXED_MINOR_RANGES=y

#
# Media drivers
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=y

#
# Audio decoders, processors and mixers
#

#
# RDS decoders
#

#
# Video decoders
#

#
# Video and audio decoders
#

#
# Video encoders
#

#
# Camera sensor devices
#

#
# Flash devices
#

#
# Video improvement chips
#

#
# Audio/Video compression chips
#

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#

#
# Sensors used on soc_camera driver
#

#
# Media SPI Adapters
#
CONFIG_MEDIA_TUNER=y
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MC44S803=y

#
# Tools to develop new frontends
#

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
CONFIG_DRM_DEBUG_MM=y
# CONFIG_DRM_DEBUG_MM_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_TTM=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
CONFIG_DRM_I2C_NXP_TDA998X=m
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
CONFIG_DRM_VGEM=m
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_RCAR_DW_HDMI is not set
# CONFIG_DRM_RCAR_LVDS is not set
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_BOCHS is not set
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_ARM_VERSATILE=y
CONFIG_DRM_PANEL_LVDS=m
# CONFIG_DRM_PANEL_SIMPLE is not set
CONFIG_DRM_PANEL_ILITEK_IL9322=y
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=m
# CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set
# CONFIG_DRM_PANEL_SAMSUNG_LD9040 is not set
# CONFIG_DRM_PANEL_LG_LG4573 is not set
CONFIG_DRM_PANEL_ORISETECH_OTM8009A=m
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=y
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=m
# CONFIG_DRM_PANEL_RAYDIUM_RM68200 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
# CONFIG_DRM_PANEL_SHARP_LQ101R1SX01 is not set
CONFIG_DRM_PANEL_SHARP_LS043T1LE01=y
CONFIG_DRM_PANEL_SITRONIX_ST7789V=y
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=m
# CONFIG_DRM_DUMB_VGA_DAC is not set
# CONFIG_DRM_LVDS_ENCODER is not set
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=m
CONFIG_DRM_NXP_PTN3460=y
CONFIG_DRM_PARADE_PS8622=m
# CONFIG_DRM_SIL_SII8620 is not set
CONFIG_DRM_SII902X=y
CONFIG_DRM_SII9234=y
# CONFIG_DRM_TOSHIBA_TC358767 is not set
CONFIG_DRM_TI_TFP410=y
CONFIG_DRM_I2C_ADV7511=m
# CONFIG_DRM_I2C_ADV7533 is not set
CONFIG_DRM_I2C_ADV7511_CEC=y
# CONFIG_DRM_ARCPGU is not set
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_MXSFB is not set
# CONFIG_DRM_TINYDRM is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_BACKLIGHT=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
CONFIG_FB_OPENCORES=m
CONFIG_FB_S1D13XXX=m
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_SM501 is not set
CONFIG_FB_IBM_GXT4500=m
CONFIG_FB_VIRTUAL=m
CONFIG_FB_METRONOME=m
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_BROADSHEET is not set
# CONFIG_FB_AUO_K190X is not set
# CONFIG_FB_SIMPLE is not set
CONFIG_FB_SSD1307=m
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_L4F00242T03=y
CONFIG_LCD_LMS283GF05=y
# CONFIG_LCD_LTV350QV is not set
CONFIG_LCD_ILI922X=y
CONFIG_LCD_ILI9320=m
CONFIG_LCD_TDO24M=m
CONFIG_LCD_VGG2432A4=m
CONFIG_LCD_PLATFORM=m
CONFIG_LCD_S6E63M0=m
CONFIG_LCD_LD9040=y
CONFIG_LCD_AMS369FG06=y
CONFIG_LCD_LMS501KF03=y
CONFIG_LCD_HX8357=m
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=m
CONFIG_BACKLIGHT_LM3533=m
CONFIG_BACKLIGHT_PWM=y
# CONFIG_BACKLIGHT_DA9052 is not set
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_PM8941_WLED=y
# CONFIG_BACKLIGHT_SAHARA is not set
CONFIG_BACKLIGHT_WM831X=y
CONFIG_BACKLIGHT_ADP8860=y
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_88PM860X is not set
# CONFIG_BACKLIGHT_LM3630A is not set
CONFIG_BACKLIGHT_LM3639=m
CONFIG_BACKLIGHT_LP855X=y
# CONFIG_BACKLIGHT_PANDORA is not set
CONFIG_BACKLIGHT_SKY81452=m
CONFIG_BACKLIGHT_GPIO=m
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=m
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
# CONFIG_HID_GENERIC is not set

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
CONFIG_HID_ACRUX=y
CONFIG_HID_ACRUX_FF=y
CONFIG_HID_APPLE=y
CONFIG_HID_ASUS=y
CONFIG_HID_AUREAL=y
CONFIG_HID_BELKIN=m
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
CONFIG_HID_CMEDIA=y
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
CONFIG_DRAGONRISE_FF=y
CONFIG_HID_EMS_FF=m
CONFIG_HID_ELECOM=m
# CONFIG_HID_EZKEY is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
CONFIG_HID_KEYTOUCH=y
CONFIG_HID_KYE=m
CONFIG_HID_WALTOP=m
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
CONFIG_HID_ITE=y
CONFIG_HID_JABRA=y
CONFIG_HID_TWINHAN=y
CONFIG_HID_KENSINGTON=y
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
CONFIG_LOGIWHEELS_FF=y
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MAYFLASH=m
# CONFIG_HID_MICROSOFT is not set
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
CONFIG_PANTHERLORD_FF=y
# CONFIG_HID_PETALYNX is not set
CONFIG_HID_PICOLCD=y
# CONFIG_HID_PICOLCD_FB is not set
CONFIG_HID_PICOLCD_BACKLIGHT=y
# CONFIG_HID_PICOLCD_LCD is not set
CONFIG_HID_PICOLCD_LEDS=y
# CONFIG_HID_PICOLCD_CIR is not set
# CONFIG_HID_PLANTRONICS is not set
CONFIG_HID_PRIMAX=y
CONFIG_HID_SAITEK=m
# CONFIG_HID_SAMSUNG is not set
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=y
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
CONFIG_HID_SMARTJOYPLUS=m
CONFIG_SMARTJOYPLUS_FF=y
# CONFIG_HID_TIVO is not set
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=y
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=y
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=y

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=y
# CONFIG_UWB_WHCI is not set
CONFIG_MMC=m
CONFIG_PWRSEQ_EMMC=m
CONFIG_PWRSEQ_SD8787=m
CONFIG_PWRSEQ_SIMPLE=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
CONFIG_MMC_TEST=m

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
# CONFIG_MMC_SDHCI_PCI is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_OF_ARASAN is not set
CONFIG_MMC_SDHCI_OF_AT91=m
# CONFIG_MMC_SDHCI_CADENCE is not set
CONFIG_MMC_SDHCI_F_SDH30=m
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
CONFIG_MMC_SPI=m
# CONFIG_MMC_SDRICOH_CS is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=m
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_MMC_SDHCI_OMAP is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_88PM860X is not set
# CONFIG_LEDS_AAT1290 is not set
CONFIG_LEDS_APU=m
CONFIG_LEDS_AS3645A=y
# CONFIG_LEDS_BCM6328 is not set
CONFIG_LEDS_BCM6358=m
# CONFIG_LEDS_CPCAP is not set
# CONFIG_LEDS_LM3530 is not set
CONFIG_LEDS_LM3533=m
CONFIG_LEDS_LM3642=m
CONFIG_LEDS_LM3692X=m
# CONFIG_LEDS_MT6323 is not set
CONFIG_LEDS_NET48XX=m
CONFIG_LEDS_WRAP=m
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=m
# CONFIG_LEDS_LP3944 is not set
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
# CONFIG_LEDS_LP5523 is not set
# CONFIG_LEDS_LP5562 is not set
CONFIG_LEDS_LP8501=m
# CONFIG_LEDS_LP8860 is not set
# CONFIG_LEDS_CLEVO_MAIL is not set
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=m
# CONFIG_LEDS_WM831X_STATUS is not set
# CONFIG_LEDS_WM8350 is not set
CONFIG_LEDS_DA9052=m
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
CONFIG_LEDS_REGULATOR=y
CONFIG_LEDS_BD2802=y
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_MC13783 is not set
# CONFIG_LEDS_TCA6507 is not set
CONFIG_LEDS_TLC591XX=m
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_OT200=m
CONFIG_LEDS_KTD2692=y
CONFIG_LEDS_IS31FL319X=m
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_MLXCPLD=y
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
CONFIG_LEDS_TRIGGER_CPU=y
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
# CONFIG_LEDS_TRIGGER_CAMERA is not set
# CONFIG_LEDS_TRIGGER_PANIC is not set
CONFIG_LEDS_TRIGGER_NETDEV=m
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_INTF_DEV_UIE_EMUL=y
CONFIG_RTC_DRV_TEST=m

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_88PM860X is not set
# CONFIG_RTC_DRV_88PM80X is not set
CONFIG_RTC_DRV_ABB5ZES3=y
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_AS3722=y
CONFIG_RTC_DRV_DS1307=y
CONFIG_RTC_DRV_DS1307_HWMON=y
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=y
# CONFIG_RTC_DRV_DS1374_WDT is not set
# CONFIG_RTC_DRV_DS1672 is not set
CONFIG_RTC_DRV_HYM8563=y
CONFIG_RTC_DRV_MAX6900=y
# CONFIG_RTC_DRV_MAX8998 is not set
CONFIG_RTC_DRV_MAX77686=m
# CONFIG_RTC_DRV_RK808 is not set
CONFIG_RTC_DRV_RS5C372=y
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_ISL12022 is not set
# CONFIG_RTC_DRV_ISL12026 is not set
# CONFIG_RTC_DRV_X1205 is not set
CONFIG_RTC_DRV_PCF8523=y
CONFIG_RTC_DRV_PCF85063=y
CONFIG_RTC_DRV_PCF85363=y
# CONFIG_RTC_DRV_PCF8563 is not set
CONFIG_RTC_DRV_PCF8583=y
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
CONFIG_RTC_DRV_TWL4030=m
# CONFIG_RTC_DRV_TPS65910 is not set
# CONFIG_RTC_DRV_RC5T583 is not set
CONFIG_RTC_DRV_S35390A=y
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=y
CONFIG_RTC_DRV_RX8025=y
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_S5M is not set

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=y
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
CONFIG_RTC_DRV_DS1305=y
CONFIG_RTC_DRV_DS1343=m
# CONFIG_RTC_DRV_DS1347 is not set
CONFIG_RTC_DRV_DS1390=y
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RX6110 is not set
CONFIG_RTC_DRV_RS5C348=y
CONFIG_RTC_DRV_MAX6902=y
CONFIG_RTC_DRV_PCF2123=y
CONFIG_RTC_DRV_MCP795=m
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=y
CONFIG_RTC_DRV_DS3232_HWMON=y
CONFIG_RTC_DRV_PCF2127=y
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_CMOS is not set
CONFIG_RTC_DRV_DS1286=m
# CONFIG_RTC_DRV_DS1511 is not set
CONFIG_RTC_DRV_DS1553=y
CONFIG_RTC_DRV_DS1685_FAMILY=y
# CONFIG_RTC_DRV_DS1685 is not set
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
CONFIG_RTC_DRV_DS17485=y
# CONFIG_RTC_DRV_DS17885 is not set
# CONFIG_RTC_DS1685_PROC_REGS is not set
# CONFIG_RTC_DS1685_SYSFS_REGS is not set
CONFIG_RTC_DRV_DS1742=y
# CONFIG_RTC_DRV_DS2404 is not set
# CONFIG_RTC_DRV_DA9052 is not set
CONFIG_RTC_DRV_DA9063=m
CONFIG_RTC_DRV_STK17TA8=y
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
CONFIG_RTC_DRV_M48T59=y
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
CONFIG_RTC_DRV_V3020=y
CONFIG_RTC_DRV_WM831X=m
CONFIG_RTC_DRV_WM8350=y
CONFIG_RTC_DRV_ZYNQMP=m
CONFIG_RTC_DRV_CROS_EC=y

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_FTRTC010=y
CONFIG_RTC_DRV_MC13XXX=m
# CONFIG_RTC_DRV_SNVS is not set
CONFIG_RTC_DRV_MT6397=m
CONFIG_RTC_DRV_R7301=y
# CONFIG_RTC_DRV_CPCAP is not set

#
# HID Sensor RTC drivers
#
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=m
CONFIG_HD44780=m
CONFIG_IMG_ASCII_LCD=y
# CONFIG_HT16K33 is not set
CONFIG_UIO=m
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=m
CONFIG_UIO_DMEM_GENIRQ=m
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
CONFIG_UIO_PRUSS=m
# CONFIG_UIO_MF624 is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
CONFIG_STAGING=y
# CONFIG_IPX is not set
# CONFIG_NCP_FS is not set
# CONFIG_COMEDI is not set
# CONFIG_RTLLIB is not set
# CONFIG_RTS5208 is not set
# CONFIG_FB_SM750 is not set
# CONFIG_FB_XGI is not set

#
# Speakup console speech
#
CONFIG_STAGING_MEDIA=y

#
# Android
#
# CONFIG_STAGING_BOARD is not set
# CONFIG_LNET is not set
# CONFIG_DGNC is not set
CONFIG_GS_FPGABOOT=m
# CONFIG_UNISYSSPAR is not set
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
CONFIG_FB_TFT=y
CONFIG_FB_TFT_AGM1264K_FL=m
CONFIG_FB_TFT_BD663474=y
# CONFIG_FB_TFT_HX8340BN is not set
CONFIG_FB_TFT_HX8347D=y
# CONFIG_FB_TFT_HX8353D is not set
# CONFIG_FB_TFT_HX8357D is not set
CONFIG_FB_TFT_ILI9163=m
CONFIG_FB_TFT_ILI9320=m
# CONFIG_FB_TFT_ILI9325 is not set
CONFIG_FB_TFT_ILI9340=m
CONFIG_FB_TFT_ILI9341=m
# CONFIG_FB_TFT_ILI9481 is not set
# CONFIG_FB_TFT_ILI9486 is not set
CONFIG_FB_TFT_PCD8544=y
# CONFIG_FB_TFT_RA8875 is not set
CONFIG_FB_TFT_S6D02A1=m
CONFIG_FB_TFT_S6D1121=m
# CONFIG_FB_TFT_SH1106 is not set
# CONFIG_FB_TFT_SSD1289 is not set
# CONFIG_FB_TFT_SSD1305 is not set
# CONFIG_FB_TFT_SSD1306 is not set
CONFIG_FB_TFT_SSD1331=y
CONFIG_FB_TFT_SSD1351=y
# CONFIG_FB_TFT_ST7735R is not set
CONFIG_FB_TFT_ST7789V=m
# CONFIG_FB_TFT_TINYLCD is not set
CONFIG_FB_TFT_TLS8204=y
# CONFIG_FB_TFT_UC1611 is not set
# CONFIG_FB_TFT_UC1701 is not set
CONFIG_FB_TFT_UPD161704=y
CONFIG_FB_TFT_WATTEROTT=y
CONFIG_FB_FLEX=y
# CONFIG_FB_TFT_FBTFT_DEVICE is not set
CONFIG_MOST=m
# CONFIG_MOST_CDEV is not set
# CONFIG_MOST_NET is not set
CONFIG_MOST_VIDEO=m
# CONFIG_MOST_DIM2 is not set
CONFIG_MOST_I2C=m
# CONFIG_KS7010 is not set
# CONFIG_GREYBUS is not set

#
# USB Power Delivery and Type-C drivers
#
# CONFIG_DRM_VBOXVIDEO is not set
CONFIG_PI433=y
CONFIG_MTK_MMC=m
# CONFIG_MTK_AEE_KDUMP is not set
CONFIG_MTK_MMC_CD_POLL=y
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_LAPTOP is not set
CONFIG_CHROMEOS_PSTORE=m
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_MELLANOX_PLATFORM=y
# CONFIG_MLXREG_HOTPLUG is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_WM831X is not set
# CONFIG_CLK_HSDK is not set
# CONFIG_COMMON_CLK_MAX77686 is not set
# CONFIG_COMMON_CLK_RK808 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI514 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_SI570 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CDCE925 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_S2MPS11 is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_VC5 is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=y
# CONFIG_PCC is not set
# CONFIG_ALTERA_MBOX is not set
# CONFIG_MAILBOX_TEST is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#

#
# Broadcom SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=y
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=m
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
CONFIG_DEVFREQ_GOV_PASSIVE=m

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=m

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX14577=m
CONFIG_EXTCON_MAX3355=m
CONFIG_EXTCON_RT8973A=m
CONFIG_EXTCON_SM5502=m
CONFIG_EXTCON_USB_GPIO=m
CONFIG_EXTCON_USBC_CROS_EC=m
CONFIG_MEMORY=y
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_ATMEL_HLCDC_PWM is not set
CONFIG_PWM_CROS_EC=m
CONFIG_PWM_FSL_FTM=y
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=y
# CONFIG_PWM_TWL is not set
# CONFIG_PWM_TWL_LED is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_TI_SYSCON=y
CONFIG_FMC=y
CONFIG_FMC_FAKEDEV=m
CONFIG_FMC_TRIVIAL=y
CONFIG_FMC_WRITE_EEPROM=y
CONFIG_FMC_CHARDEV=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=m
CONFIG_PHY_PXA_28NM_HSIC=m
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
CONFIG_POWERCAP=y
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
CONFIG_DAX=y
CONFIG_DEV_DAX=y
CONFIG_NVMEM=y

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=m
# CONFIG_ALTERA_PR_IP_CORE_PLAT is not set
CONFIG_FPGA_MGR_ALTERA_PS_SPI=m
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_MGR_XILINX_SPI=m
CONFIG_FPGA_MGR_ICE40_SPI=m
CONFIG_FPGA_BRIDGE=m
CONFIG_XILINX_PR_DECOUPLER=m
CONFIG_FPGA_REGION=m
# CONFIG_OF_FPGA_REGION is not set
# CONFIG_FSI is not set
CONFIG_PM_OPP=y
# CONFIG_SIOX is not set
CONFIG_SLIMBUS=m
CONFIG_SLIM_QCOM_CTRL=m

#
# Firmware Drivers
#
CONFIG_EDD=y
# CONFIG_EDD_OFF is not set
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_DELL_RBU=y
CONFIG_DCDBAS=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=m
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_GOOGLE_FIRMWARE=y
CONFIG_GOOGLE_COREBOOT_TABLE=m
# CONFIG_GOOGLE_COREBOOT_TABLE_ACPI is not set
CONFIG_GOOGLE_COREBOOT_TABLE_OF=m
CONFIG_GOOGLE_MEMCONSOLE=m
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set
CONFIG_GOOGLE_MEMCONSOLE_COREBOOT=m
CONFIG_GOOGLE_VPD=m

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=y
# CONFIG_EXT4_FS_POSIX_ACL is not set
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_ENCRYPTION is not set
CONFIG_EXT4_DEBUG=y
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_CHECK=y
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=y
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
# CONFIG_XFS_ONLINE_SCRUB is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=y
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
CONFIG_NILFS2_FS=y
# CONFIG_F2FS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
# CONFIG_MANDATORY_FILE_LOCKING is not set
CONFIG_FS_ENCRYPTION=m
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
CONFIG_OVERLAY_FS_INDEX=y
# CONFIG_OVERLAY_FS_NFS_EXPORT is not set
CONFIG_OVERLAY_FS_XINO_AUTO=y

#
# Caches
#
CONFIG_FSCACHE=m
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
CONFIG_FSCACHE_DEBUG=y
CONFIG_FSCACHE_OBJECT_LIST=y
CONFIG_CACHEFILES=m
CONFIG_CACHEFILES_DEBUG=y
# CONFIG_CACHEFILES_HISTOGRAM is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
CONFIG_ECRYPT_FS=m
# CONFIG_ECRYPT_FS_MESSAGING is not set
CONFIG_HFS_FS=y
# CONFIG_HFSPLUS_FS is not set
CONFIG_BEFS_FS=y
CONFIG_BEFS_DEBUG=y
# CONFIG_BFS_FS is not set
CONFIG_EFS_FS=y
CONFIG_CRAMFS=y
# CONFIG_CRAMFS_BLOCKDEV is not set
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
CONFIG_SQUASHFS_LZ4=y
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
CONFIG_SQUASHFS_ZSTD=y
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
CONFIG_SQUASHFS_EMBEDDED=y
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=m
CONFIG_MINIX_FS=m
CONFIG_OMFS_FS=y
CONFIG_HPFS_FS=m
# CONFIG_QNX4FS_FS is not set
CONFIG_QNX6FS_FS=y
CONFIG_QNX6FS_DEBUG=y
CONFIG_ROMFS_FS=m
CONFIG_ROMFS_BACKED_BY_BLOCK=y
CONFIG_ROMFS_ON_BLOCK=y
# CONFIG_PSTORE is not set
CONFIG_SYSV_FS=y
CONFIG_UFS_FS=y
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_UFS_DEBUG is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=m
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=m
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
# CONFIG_NLS_MAC_CYRILLIC is not set
CONFIG_NLS_MAC_GAELIC=m
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=y
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
# CONFIG_NLS_UTF8 is not set
CONFIG_DLM=m
# CONFIG_DLM_DEBUG is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
# CONFIG_DYNAMIC_DEBUG is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_WARN_DEPRECATED=y
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=1024
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_READABLE_ASM=y
CONFIG_UNUSED_SYMBOLS=y
CONFIG_PAGE_OWNER=y
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
CONFIG_PAGE_POISONING=y
CONFIG_PAGE_POISONING_NO_SANITY=y
CONFIG_PAGE_POISONING_ZERO=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
# CONFIG_DEBUG_OBJECTS_FREE is not set
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
CONFIG_DEBUG_OBJECTS_WORK=y
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_SLAB_LEAK=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
# CONFIG_SOFTLOCKUP_DETECTOR is not set
# CONFIG_HARDLOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=1
CONFIG_WQ_WATCHDOG=y
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_DEBUG_TIMEKEEPING=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=y
CONFIG_WW_MUTEX_SELFTEST=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_TRACE=y
CONFIG_RCU_EQS_DEBUG=y
CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
CONFIG_FAIL_PAGE_ALLOC=y
# CONFIG_FAIL_MAKE_REQUEST is not set
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_SANITIZE_ALL is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_NULL=y
CONFIG_TEST_UBSAN=m
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_DEBUG_WX is not set
# CONFIG_DOUBLEFAULT is not set
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
CONFIG_IO_DELAY_UDELAY=y
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=2
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
CONFIG_DEBUG_ENTRY=y
CONFIG_DEBUG_NMI_SELFTEST=y
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_LSM_MMAP_MIN_ADDR=65536
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
# CONFIG_SECURITY_SELINUX_DISABLE is not set
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=0
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE=1
CONFIG_SECURITY_APPARMOR_HASH=y
# CONFIG_SECURITY_APPARMOR_HASH_DEFAULT is not set
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
CONFIG_SECURITY_LOADPIN=y
# CONFIG_SECURITY_LOADPIN_ENABLED is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_INTEGRITY is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_DEFAULT_SECURITY="selinux"
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_MCRYPTD=m
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=m
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=m
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
CONFIG_CRYPTO_RMD128=y
CONFIG_CRYPTO_RMD160=m
# CONFIG_CRYPTO_RMD256 is not set
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
# CONFIG_CRYPTO_SHA512 is not set
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_TGR192=y
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_AES_586=m
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=m
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=y
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_SALSA20_586 is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_586=m
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SPECK=m
CONFIG_CRYPTO_TEA=m
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=m
CONFIG_CRYPTO_LZ4=m
# CONFIG_CRYPTO_LZ4HC is not set

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=m
CONFIG_CRYPTO_USER_API_HASH=m
CONFIG_CRYPTO_USER_API_SKCIPHER=m
CONFIG_CRYPTO_USER_API_RNG=m
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
CONFIG_SECONDARY_TRUSTED_KEYRING=y
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set

#
# Library routines
#
CONFIG_BITREVERSE=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
CONFIG_CRC32_SARWATE=y
# CONFIG_CRC32_BIT is not set
CONFIG_CRC4=y
CONFIG_CRC7=m
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
CONFIG_AUDIT_GENERIC=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=m
CONFIG_842_DECOMPRESS=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
# CONFIG_XZ_DEC_POWERPC is not set
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_SGL_ALLOC=y
CONFIG_DMA_DIRECT_OPS=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=m
CONFIG_NLATTR=y
CONFIG_LRU_CACHE=m
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=m
CONFIG_DDR=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
CONFIG_STRING_SELFTEST=y

--u3/rZRmxL6MmkK24--
