Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752662AbeB1OvX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:51:23 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36652 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752436AbeB1OvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:51:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 28 Feb 2018 06:51:20 -0800
From: Sodagudi Prasad <psodagud@codeaurora.org>
To: ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, fengc@google.com
Subject: bpf: mismatch between inode->i_private and inode->i_op
Message-ID: <bd542b0aa788195daba16ac420afb587@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Trying to boot 4.14.19 kernel with Android and observed a crash in bpf 
system.
 From the call stack netd process is trying to access the 
/sys/fs/bfp/traffic_cookie_uid_map file.
After checking call stack further observed that, inode->i_private is 
pointing to (struct bpf_map *) but inode->i_op is pointing to the 
bpf_prog_fops.

[ 4134.721483] Unable to handle kernel paging request at virtual address 
800000001
[ 4134.820925] Mem abort info:
[ 4134.901283]   Exception class = DABT (current EL), IL = 32 bits
[ 4135.016736]   SET = 0, FnV = 0
[ 4135.119820]   EA = 0, S1PTW = 0
[ 4135.201431] Data abort info:
[ 4135.301388]   ISV = 0, ISS = 0x00000021
[ 4135.359599]   CM = 0, WnR = 0
[ 4135.470873] user pgtable: 4k pages, 39-bit VAs, pgd = 
ffffffe39b946000
[ 4135.499757] [0000000800000001] *pgd=0000000000000000, 
*pud=0000000000000000
[ 4135.660725] Internal error: Oops: 96000021 [#1] PREEMPT SMP
[ 4135.674610] Modules linked in:
[ 4135.682883] CPU: 5 PID: 1260 Comm: netd Tainted: G S      W       
4.14.19+ #1
[ 4135.716188] task: ffffffe39f4aa380 task.stack: ffffff801d4e0000
[ 4135.731599] PC is at bpf_prog_add+0x20/0x68
[ 4135.741746] LR is at bpf_prog_inc+0x20/0x2c
[ 4135.751788] pc : [<ffffff94ab7ad584>] lr : [<ffffff94ab7ad638>] 
pstate: 60400145
[ 4135.769062] sp : ffffff801d4e3ce0
[ 4135.777241] x29: ffffff801d4e3cf0 x28: ffffffe39f4aa380
[ 4135.790125] x27: ffffffe39f4aa380 x26: 0000000000000118
[ 4135.803020] x25: 0000000000000030 x24: 0000000000000015
[ 4135.815799] x23: 0000000000000000 x22: 0000000001080020
[ 4135.828704] x21: ffffffe3a01bf8f8 x20: 0000000000000001
[ 4135.841494] x19: ffffffe383821280 x18: 0000000000000000
[ 4135.854346] x17: 0000000000000000 x16: ffffff94acc92000
[ 4135.867083] x15: 0000000000042e7f x14: ffffff94ace81d88
[ 4135.880041] x13: 000000000001e4a7 x12: 0000000000000110
[ 4135.892894] x11: bdf96acb38411b00 x10: 0000000000000000
[ 4135.905610] x9 : ffffff94ac24c400 x8 : 0000000800000001
[ 4135.918578] x7 : bbbbbbbbbbbbbbbb x6 : ffffff801d4e3c24
[ 4135.931357] x5 : ffffff801d4e3c10 x4 : 0000000000000000
[ 4135.944231] x3 : 0000000000000000 x2 : 0000000000000000
[ 4135.957062] x1 : 0000000000000001 x0 : ffffffe383821280
[ 4135.969757]
[ 4135.969757] PC: 0xffffff94ab7ad544:
[ 4135.981567] d544  91074400 91278021 72a00103 aa1303e2 94036495 
a9417bfd f84207f3 d65f03c0
[ 4136.001588] d564  a9be4ff4 a9017bfd 910043fd 2a0103f4 aa0003f3 
d503201f f9400e68 f9800111
[ 4136.021504] d584  885f7d09 0b140129 880afd09 35ffffaa d5033bbf 
7140213f 5400010d f9400e69
[ 4136.041346] d5a4  b27ceff3 f9800131 885f7d28 4b140108 880b7d28 
35ffffab a9417bfd aa1303e0
[ 4136.061210]
[ 4136.061210] LR: 0xffffff94ab7ad5f8:
[ 4136.073031] d5f8  35ffffaa d5033bbf 34000089 a9417bfd a8c24ff4 
d65f03c0 d4210000 17fffffc
[ 4136.093094] d618  f81e0ff3 a9017bfd 910043fd aa0003f3 d503201f 
320003e1 aa1303e0 97ffffcc
[ 4136.112946] d638  a9417bfd f84207f3 d65f03c0 f81e0ff3 a9017bfd 
910043fd aa0003f3 d503201f
[ 4136.132694] d658  f9400e6a b9400149 2a0903e8 340002a8 f9400e6b 
1100050d 93407d0c 93407dae
[ 4136.152810]
[ 4136.152810] SP: 0xffffff801d4e3ca0:
[ 4136.164610] 3ca0  ab7ad584 ffffff94 60400145 00000000 a01bf8f8 
ffffffe3 00000006 00000000
[ 4136.184188] 3cc0  00000000 00000080 ab844204 ffffff94 1d4e3cf0 
ffffff80 ab7ad584 ffffff94
[ 4136.204262] 3ce0  00000000 00000000 83821280 ffffffe3 1d4e3d10 
ffffff80 ab7ad638 ffffff94
[ 4136.224210] 3d00  9136a3c0 ffffffe3 9136a3c0 ffffffe3 1d4e3d70 
ffffff80 ab7b5d08 ffffff94
[ 4136.253946]
[ 4136.258315] Process netd (pid: 1260, stack limit = 
0xffffff801d4e0000)
[ 4136.273746] Call trace:
[ 4136.280146] Exception stack(0xffffff801d4e3ba0 to 0xffffff801d4e3ce0)
[ 4136.295378] 3ba0: ffffffe383821280 0000000000000001 0000000000000000 
0000000000000000
[ 4136.313715] 3bc0: 0000000000000000 ffffff801d4e3c10 ffffff801d4e3c24 
bbbbbbbbbbbbbbbb
[ 4136.332157] 3be0: 0000000800000001 ffffff94ac24c400 0000000000000000 
bdf96acb38411b00
[ 4136.350831] 3c00: 0000000000000110 000000000001e4a7 ffffff94ace81d88 
0000000000042e7f
[ 4136.369115] 3c20: ffffff94acc92000 0000000000000000 0000000000000000 
ffffffe383821280
[ 4136.387357] 3c40: 0000000000000001 ffffffe3a01bf8f8 0000000001080020 
0000000000000000
[ 4136.405694] 3c60: 0000000000000015 0000000000000030 0000000000000118 
ffffffe39f4aa380
[ 4136.424136] 3c80: ffffffe39f4aa380 ffffff801d4e3cf0 ffffff94ab7ad638 
ffffff801d4e3ce0
[ 4136.442494] 3ca0: ffffff94ab7ad584 0000000060400145 ffffffe3a01bf8f8 
0000000000000006
[ 4136.460936] 3cc0: 0000008000000000 ffffff94ab844204 ffffff801d4e3cf0 
ffffff94ab7ad584
[ 4136.479241] [<ffffff94ab7ad584>] bpf_prog_add+0x20/0x68
[ 4136.491767] [<ffffff94ab7ad638>] bpf_prog_inc+0x20/0x2c
[ 4136.504536] [<ffffff94ab7b5d08>] bpf_obj_get_user+0x204/0x22c
[ 4136.518746] [<ffffff94ab7ade68>] SyS_bpf+0x5a8/0x1a88

User space is trying to access a bpf map, so inode->i_op and 
inode->i_priate should be pointing to bpf_map_iops and struct bpf_map * 
respectively.
But inode ->I_private value is correct but the inode->i_op is not.

Are there any race conditions assigning inode->i_private and 
inode->i_op? Am I missing any critical fixes?

-Thanks, Prasad

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
