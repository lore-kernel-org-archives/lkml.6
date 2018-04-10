Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752078AbeDJBL7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 21:11:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:26722 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751770AbeDJBL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 21:11:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,429,1517904000";
   d="gz'50?scan'50,208,50";a="219092795"
Date: Tue, 10 Apr 2018 09:12:32 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        LKP <lkp@01.org>
Subject: [lkp-robot] [bisect done] e71e836f46 [   17.567570] WARNING: CPU: 0
 PID: 1 at arch/x86/include/asm/pgtable.h:540 __change_page_attr_set_clr
Message-ID: <20180410011232.ooo3u7v7uxkqoz2o@shao2-debian>
Reply-To: kernel test robot <lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3kvqdadyjkd4topo"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3kvqdadyjkd4topo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/pti

commit e71e836f463dd2cfb319ce88ae4a6e4f83904e6c
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri Apr 6 13:55:11 2018 -0700
Commit:     Ingo Molnar <mingo@kernel.org>
CommitDate: Mon Apr 9 18:27:33 2018 +0200

    x86/mm: Remove extra filtering in pageattr code
    
    The pageattr code has a mode where it can set or clear PTE bits in
    existing PTEs, so the page protections of the *new* PTEs come from
    one of two places:
    
      1. The set/clear masks: cpa->mask_clr / cpa->mask_set
      2. The existing PTE
    
    We filter ->mask_set/clr for supported PTE bits at entry to
    __change_page_attr() so we never need to filter them again.
    
    The only other place permissions can come from is an existing PTE
    and those already presumably have good bits.  We do not need to filter
    them again.
    
    Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
    Cc: Andrea Arcangeli <aarcange@redhat.com>
    Cc: Andy Lutomirski <luto@kernel.org>
    Cc: Arjan van de Ven <arjan@linux.intel.com>
    Cc: Borislav Petkov <bp@alien8.de>
    Cc: Dan Williams <dan.j.williams@intel.com>
    Cc: David Woodhouse <dwmw2@infradead.org>
    Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Cc: Hugh Dickins <hughd@google.com>
    Cc: Josh Poimboeuf <jpoimboe@redhat.com>
    Cc: Juergen Gross <jgross@suse.com>
    Cc: Kees Cook <keescook@google.com>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Nadav Amit <namit@vmware.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: linux-mm@kvack.org
    Link: http://lkml.kernel.org/r/20180406205511.BC072352@viggo.jf.intel.com
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

64c8075940  x86/mm: Do not auto-massage page protections
e71e836f46  x86/mm: Remove extra filtering in pageattr code
0564258fb2  x86/pti: Leave kernel text global for !PCID
87e1e2f51c  Merge branch 'x86/pti'
+-----------------------------------------------------------------------+------------+------------+------------+------------+
|                                                                       | 64c8075940 | e71e836f46 | 0564258fb2 | 87e1e2f51c |
+-----------------------------------------------------------------------+------------+------------+------------+------------+
| boot_successes                                                        | 35         | 0          | 19         | 11         |
| boot_failures                                                         | 0          | 26         |            |            |
| WARNING:at_arch/x86/include/asm/pgtable.h:#__change_page_attr_set_clr | 0          | 26         |            |            |
| RIP:__change_page_attr_set_clr                                        | 0          | 26         |            |            |
+-----------------------------------------------------------------------+------------+------------+------------+------------+

[   17.548562]   #1: Loopback 1
[   17.549344]   #2: Virtual MIDI Card 1
[   17.550337]   #3: MTPAV on parallel port at 0x378
[   17.563486] ------------[ cut here ]------------
[   17.564783] attempted to set unsupported pgprot: 0000000000000163 bits: 0000000000000100 supported: fffffffffffffeff
[   17.567570] WARNING: CPU: 0 PID: 1 at arch/x86/include/asm/pgtable.h:540 __change_page_attr_set_clr+0xbfa/0x1170
[   17.570762] CPU: 0 PID: 1 Comm: swapper Not tainted 4.16.0-02286-ge71e836 #1
[   17.572644] RIP: 0010:__change_page_attr_set_clr+0xbfa/0x1170
[   17.574197] RSP: 0000:ffff88001e573d00 EFLAGS: 00010286
[   17.575614] RAX: 0000000000000000 RBX: ffff88001741a000 RCX: 0000000000000000
[   17.577519] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff83279170
[   17.579427] RBP: ffff88001e573e08 R08: 0000000000000001 R09: 0000000000000000
[   17.581352] R10: 000ffffffffff000 R11: 0000000000000000 R12: 0000000003200000
[   17.582992] R13: 0000000000000163 R14: 0000000000000063 R15: 0000000000000001
[   17.584241] FS:  0000000000000000(0000) GS:ffffffff82e99000(0000) knlGS:0000000000000000
[   17.586073] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.587416] CR2: 0000000000000000 CR3: 0000000002e74000 CR4: 00000000000006b0
[   17.589080] Call Trace:
[   17.589676]  ? vsyscall_gtod_data+0xf80/0xf80
[   17.590704]  ? vsyscall_gtod_data+0xf80/0xf80
[   17.591728]  ? mutex_unlock+0x12/0x20
[   17.592594]  ? vsyscall_gtod_data+0xf80/0xf80
[   17.593623]  change_page_attr_set_clr+0x216/0x5d0
[   17.594722]  ? vsyscall_gtod_data+0xf80/0xf80
[   17.595749]  set_memory_nx+0x3a/0x40
[   17.596599]  ? vsyscall_gtod_data+0xf80/0xf80
[   17.597625]  free_init_pages+0x98/0xe0
[   17.598511]  ? rest_init+0xb0/0xb0
[   17.599320]  free_initmem+0x28/0x30
[   17.600148]  kernel_init+0x22/0x100
[   17.600977]  ret_from_fork+0x3a/0x50
[   17.601824] Code: 1e 02 01 e8 f9 e6 13 00 48 8b 95 58 ff ff ff 48 8b 0d 23 dd 34 02 4c 89 ee 48 c7 c7 18 28 aa 82 48 f7 d2 4c 21 ea e8 16 e4 06 00 <0f> 0b b9 01 00 00 00 31 d2 be 01 00 00 00 48 c7 c7 80 8b 26 83 
[   17.606341] ---[ end trace 16136a0c17150c2b ]---
[   17.616310] Freeing unused kernel memory: 1548K

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start a9f81d026491b1dc0f64e4dad849a0b2ea0f03d5 0adb32858b0bddf4ada5f364a84ed60b196dbcda --
git bisect  bad 89db5e5f1ed291b114171b5d81ee941e1eb70445  # 04:42  B      0     4   18   1  Merge 'linux-review/Xinming-Hu/mwifiex-parse-key-management-suite-from-RSN-IE/20180409-171140' into devel-spot-201804100130
git bisect  bad f91328b04f19cf29e83ebbb512a1315489bfbbe9  # 04:58  B      0     9   24   2  Merge 'perf/perf/urgent' into devel-spot-201804100130
git bisect  bad 033232e2c16a8c44d91aa8a43f0203ead03d0fac  # 05:09  B      0     9   22   0  Merge 'linux-review/Sibi-Sankar/drm-msm-dsi-add-dsi-host-helper-functions-support/20180409-233706' into devel-spot-201804100130
git bisect  bad c80c7a223772e856100903a6d8e15b9ef0596119  # 05:22  B      0     9   26   4  Merge 'tip/perf/urgent' into devel-spot-201804100130
git bisect good e4c1b9da9186f1de6a4f72818aa850e03fca1d1b  # 05:34  G     11     0    0   0  Merge 'shli/for-next' into devel-spot-201804100130
git bisect good f913eccc9053b8b7c29ff0b9e5e4fe7fbb5b94e1  # 05:54  G     10     0    0   0  Merge 'tip/x86/urgent' into devel-spot-201804100130
git bisect  bad 3fc99a3d6d548923163f10e75ba75e5a1cb762ec  # 06:05  B      0     4   19   2  Merge 'tip/x86/pti' into devel-spot-201804100130
git bisect good 8a57f4849f4fa22ed18a941164a214083fc020a2  # 06:22  G     11     0    0   0  x86/mm: Introduce "default" kernel PTE mask
git bisect  bad e71e836f463dd2cfb319ce88ae4a6e4f83904e6c  # 07:08  B      0     8   23   2  x86/mm: Remove extra filtering in pageattr code
git bisect good 64c80759408f1c47d2414bfa79f80a4573a8d68d  # 07:25  G     11     0    0   0  x86/mm: Do not auto-massage page protections
# first bad commit: [e71e836f463dd2cfb319ce88ae4a6e4f83904e6c] x86/mm: Remove extra filtering in pageattr code
git bisect good 64c80759408f1c47d2414bfa79f80a4573a8d68d  # 07:27  G     31     0    0   0  x86/mm: Do not auto-massage page protections
# extra tests with debug options
git bisect  bad e71e836f463dd2cfb319ce88ae4a6e4f83904e6c  # 07:41  B      0     7   20   0  x86/mm: Remove extra filtering in pageattr code
# extra tests on HEAD of linux-devel/devel-spot-201804100130
git bisect  bad a9f81d026491b1dc0f64e4dad849a0b2ea0f03d5  # 07:41  B      0   343  359   0  0day head guard for 'devel-spot-201804100130'
# extra tests on tree/branch tip/x86/pti
git bisect good 0564258fb2cfe6876738665314445bf391f450e2  # 08:01  G     10     0    0   0  x86/pti: Leave kernel text global for !PCID
# extra tests with first bad commit reverted
git bisect good eed15c0d8c2e4ba37eb663b885dee522dabb39dc  # 08:12  G     11     0    0   0  Revert "x86/mm: Remove extra filtering in pageattr code"
# extra tests on tree/branch tip/master
git bisect good 87e1e2f51cc3159ba33f71b9b30ac04d0753227c  # 08:29  G     11     0    0   0  Merge branch 'x86/pti'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--3kvqdadyjkd4topo
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-quantal-vp-13:20180410070827:x86_64-randconfig-s3-04100201:4.16.0-02286-ge71e836:1.gz"
Content-Transfer-Encoding: base64

H4sICFgFzFoAA2RtZXNnLXF1YW50YWwtdnAtMTM6MjAxODA0MTAwNzA4Mjc6eDg2XzY0LXJh
bmRjb25maWctczMtMDQxMDAyMDE6NC4xNi4wLTAyMjg2LWdlNzFlODM2OjEA7Fzrc+LGsv98
96/oU/niPcfCevKqInUxxruUjU2MN8k9qRQlpBEoFhLRA9up/eNv94wwoAcgL5tP0dZaSJr+
TU/PdE/3qEfMDL1XsAI/CjwGrg8Ri5Ml3rDZB5Z9xl7i0LTiyRMLfeZ9cP1lEk9sMzbbIL/I
60PXtbraMtLHHvN3nspNQ2vI8ocgifHxziNFnNJHOUq1ocuKLn8QtU/iIDa9SeT+xXZKaZbp
EAhyulgGnuuziaZO3d2aZLllU6EPV8wKFsuQRZHrz+DW9ZOXWq0GIzPkN/q313RpBz6rfbgM
gphuxnMGgofah98AD7kmMH8XALBiSB34oNeUek2WZFVt1qUZayisqdXh7GmauJ79v97TUnKn
svYRzmaW9UbUqGk1Gc6u2NQ10ytJ+fgRflBg9NDvD0eP8Jgw6C5DUGSQG21ZbWsy9MaPoMpK
M8tRL1gsTN8GEkQbQmxC58JmqwuUjgzzxJ9NYjN6mixN37U6CthsmszAXOKF+Bm9RuGfE9N7
Nl+jCfPNqcdsCK1kid3OavhjYi2TSYRdgT3iLhj2XQf7EXwW11zHNxcs6siwDF0/fqphxU+L
aNbBZooKJQWiwIm9wHpKlm9M+At38mzG1twOZh1+E4JgGaU/vcC0J8i+7UZPHRWhsQPjtxsy
2OHUri1cPwgnVpD4cadJjYjZwq55wQxH1Yp5HRaG4M6wDJvgTX5vPdA7cfwqAx/7gm26MZbP
FcVQsWFbpTY3VzOzg2AL04PwmWT91LkQ3SzFLIqjizDxpT8TlrCLPxPTR2lJq+XFS7M+qetS
iP2DqI47kyJNknUUH/bkhUdjSbKJtTb/K0XLIJaok3kZRZPb6Zhy9Lpm26rlTDWlZbFm02S6
WWe609Rass7qVnvqRsyKJYGptC5qqwX9/ks6FmFTb0OuG5qktTcNkRQNptgKa97ZYvqihGm4
vL9/nAyG3U/9zsXyaSYaekAYqCFS4+JYZi/WrSvWwIIRQiOahU4tmiexHTz7HTmrSDf9h7v+
LUTJchmEMSoBjvuonS0FMPBjHEufmJ+gxvGLfJkeQ8kl4fr82Uy8KFsK5XHhLJM2/mjA9egL
PLueB0nE4PrXcffnfrY8a6pyGy4H92MJVWLl2sjicv4auRYOyofuEBbmMscuLy4of1uwxa6J
5Ie0azWdqeP8jlyQHagE1nKsPJhDYGh8WbhidiU4J8+b8344JdtUxXFsxXlPU4lSzYG9mzeH
OSS4bTi69W44gbYDd5A7PhG0hbmk+e/NYKKrQBNibhac4iyz9hp+44YUgWmIiukjW/zuVzjr
vzAriRlcuVzeH8msx2ixcEZsA7oc7irXB59fUWNXbhSEyCGVZXYbbn4eFiuGmLCy8ljLYaur
odP5sVQUAitki2C1jWVusFJZFg8bQe6ZUTxZOj50kJqPF9TNl4kZWvO32/qawyzE8PHhAdvr
oMmIIUYRtOE5dGMmTU3rqbCw477QlG36Mxatu6DAbgl5tK7x2IMI0OXlLnm5xLdMa17UUrRx
vNz1Fl7apYVMrszQ5dI/zCdMTTSC6EemEkLhRU9wff12vY8r9HDECMt1LYC655m255m+55mx
51l9z7NG6TOaF0bdxzZ6djRLJqFJSgK/yVLj9zb8cgnwSw/gS0/C/5C7zqKNLXQyHVSh8XBE
Hn6Jfmg4po8n3bL1wsYfT7pl151CUgcnbJvTDUdSzIeMGW8D1E1jDYA/URVx3luiAlApSI+z
ZRyuTO9jDh1gsbTagJR1WXLq04ZVxLpPVlABM2RmxJvhBc+AHAQhRUthmCypS3JWmYZtWmoT
nBTzBa0WjWQKbkDVjUY9B/Zwg13+IusWL3kO6W9ufEafHruXtzkPYYvG3KIxj6SZbtFMj6Sx
tmisfTTooFwNxjdvE5bCWoothgJaSKtwKHR7o0Eb+jxIFSPBmjPrKUoWFEy5Dno+XDXKNEnQ
P4yvRru+xXW9qcvcHio6nK1k8lh7n8fwsRTgcdsBuL7uK3W1yQHQ20UAJQWAy19HPVE8Lcvv
vF2VVHCNp2wFekOQNfRcBaJ4lQqu8i3AKJ5EoOhaL1fB1XtaMM5VIAsZ67kpTtB0R4NettVG
Q9A082IVxasw9XnUz/WbcS0q0Jq5CkTxKhXcBuR6c8ZM26Y1BqzOYYwXypKkVoqXjgNw3g6D
e2xwtrYRa4BcpU+rhWRRJN2m0ARQ7xZRCHKbPAzi8pyi8IVJNgof85J7IL7w9Q9EiECfGnXd
xkbTOkJ6keN/izThpBEqow2B46CXiCdQ9GZDUVu6oYP1anksF/Bw6ihIQgt9mi04mt5p8cbJ
HNxpElD0WLFsXWW67TjTc/7ItT028fFZs6kYLdloIQca+Ll6/xv4a7ejwN24GnY1lW4WxEcU
NhQFDXmUO7E2AMAWy/i1oBa2ci1W9nwYrLh5+4s4jWIzjPmsw9DLAZ8W6jLlhUlMpxoqkDYv
Xy9/iLcKw79M8/BoseLm7YEpD62yMAPfjYlaLEBySPlbpH7vr0H4SuHSpA4GRZNbam6VbN3P
JGEs02ipwMtTvG1zYSMfqKL76VQlpSoLHzLVcFYEyTncDq7v0bWNrXlbU3LTYwoI0yRG/9Zc
ma5HQ6INrRSg2ASNhtKju2AhDO5hFIR8EbQu55r/DntFxdpw9zDpjb6ML5ZBFLnIDy0GRuC5
C1foPErCJDtQg1EYWIiIklQuUFnTxTc7FzumrBD85G44gDPTWrqoy7+RAcBY1PH4f3SdYryl
/J4zg4N7ov1NRmeYljGRlEzhenVVaZzvNI5Hw/j803gAsqRqxewM7h4n44fe5P7nBzibYgsx
CEmiiRv+ib9mXjA1PX6hrvnLc+Wj7ClcI2bQ86NTHLozOnNAPA8efuJn3gODK3j7eYcTj1qZ
M2ObMwPm7mwOPG4/zJySMqdlmDNKmDMqM9faZq51EuZaJcy1KjOn7HQqXp2CPbOEPbM6e8oO
e8pJ2JuWsDctYe/hJ1kYx+krBKhdoWuznDIfPeqVktpzhvBoRK0EMafhRyPqJYh6qYSME0qo
XlJ7LjI8GrFRgth4N2KzBLFkvkGa1mEJvZVVjhhwm8LKCWVvlbQrtzhwNKJdgpjzGI5GZCWI
OefwaESnBNHJIopQgUQPZ8Pu1ePHt6Uda2eJyvUdcoOL1ka2IjLXJielKTfrpooxBy32ce+f
2YV+SBo3iVk/GznRkgWcrWf5nHG8+XmYeptm9OpbMLrmnPPoqSi+iWJmevSScyfCUlnLZs0c
wc76uyrukt9Ky/di+eTNi+O1jnoDsHkYkPPl1i+el2ZortwwTkzP/QsbLV5CA4q2YNl7J5wK
meP6zJb+cB3HJTc4G1Rlgqn17UwkpbQURa3Lul5XGwZVUxBO0Qu8YNEGx4xi7HJ0BOntebbU
EgUomR7y2IZIhlAGW1Mb9SYk4sQfdZR/86t9xOjo4dSYk1jiejG6n+Roe24Uo3+9CKau58av
MAuDZEniDPwawCPFBrAODlRsYM6ZuRFitv55k/7Pm/R/3qR/+5t0rghtcQKhD+v3Pbk5+or5
Ma1YURQJczOapyu9dJsbsrphUE5NENosbAP6NIaqq80mTvw4XArc4cBmUjmaMD5rNPS51Lqq
6HoJ2pCvsLRBV1uqVr+5MFStoag3W4b9TJX1Ft55WpsQG+dpo6E1bnB0U+LUOdSVuo5XgbhS
DL15w80m1o19gBfTCK1XS9cb9Zu3hYVzkG/AWpjS+kZ+buM1XnzBx9y6iZZG4KLKmeK1asnr
WIdyvNDCcQNr8onHaCgteS0lemGjqnrxskP2+t/vPvJIeHl3/zjo9SucAEqQ3nEUInFhTYR5
O/sIU0byItezBt2NAHniXLoiV/vuPD3O3QgrM/0I4rkZ4x+XOh5MuOpffvm0Ho00meH0jA9K
kRI/Mh3hn+DsYCf8hTw1r1aVp9O1buDAa5Cg48ZEw3BejGiAU3PogRky8INYTMAzkn4Z0iaR
7xw1i9J6UlEtFsx2cVamF0sBgYawYujWhP/67q072Rj/Zr1TBNJDIt53PvS+oMw9B/g0nC01
ChktXdMaIMxdFlIyg8g8QjJ3sfTYgnKdaPjUsrT/Q2VwhvNjrk1UmVswI2yXJjfHZkvxwu8Y
AmTFo3wGdEYTLCVd4BiWTCdmoeQg66m3theiN/oC3DuDZzMkkaB2CTeNgggaKOStnRU6ch/z
kI/oLEZcPGW13j1MMBAb4/yiGeo5+CGt9+AkpRp1epfDUgONXqS4r9SzCG9JONzFyifgpMXK
8nVyL07T8rcBCZItUSWYb73CCuMRnL6CkJISlq8YTM5jOLM+Ajp0dXhABj+bOJ8NfKtGf2cB
DAPPN8MsLqXaDru/Tm7vezdX/dFk/OWyd9sdj/soA2juKz3B4o+f2xvd0vcWJ/Cb/v+N3wia
GNkUEfDqP3fHnyfjwX/72/hyKyftbA39u8eHQT+tZDeQKaHofe4O7tZccc+mkCkqVcRUYR3r
90Dr5RAv03kUlaPj1JI1eLrMEaMrBxTWYOwbovVfgzk4Yvich6Oxvva2ssRSyZEt95UPKL6G
MBoI85K4MWsfi/eeI9fQQ8dXiDBohK/PXH5fQ3FaJDF7wWfPEYb5XyHkpzz238x3V+piD5u2
eH8KwROxf/TpYBVd6RL/fbcqBHwP/33XKhCe/n6PKjYtuMJ/36UVogVX+PdvqKL3varYOsS8
jA7n96qCYiqXL5zBnHn2Kar4u9Q6ZFYSRu6K0etUW0oltHVsOC24uQe7ABh+UE+DDQuRd0rA
Iv/zdHyn2AL2NDLZ4pawLuiP4Bu6l5fdDPZ1d3Dbvzqa70JwuizCrsT3tiCO4LuaTL7z+J6b
oS2R6yphTPkfcmIlijal7oWiFqtnIQwte54AppwbVTkJN5VgEGhDCp0fMagSmNUaVQ5TkZtU
PikQb9d7uEnl8+0wxdxUblQxN1VgdhkR6yXSJfygYJu042F2GXk3zB5utAoi3sNNFZhyblTl
JLKpBLOHG61Ch+/hpgpMOTdaFWUo56YSzB5uqijDHm5OoVPqaXSqIswebk6hUxVhyrk5iU5V
hNnDzSl0qiJMOTcn0amKMHu4OYVOVYTZODh8BUhy/TQlspoybBycb4Qp5aaKMuzhphpMGTeV
lKGcm4owpdxUUYY93FSDKeOmkjKUc1MRppSbaspQys07dYrHdmk4vasMB+qvSlha42bAV6zx
EGFZjVuDulqNBwlLa9wM3Io1HiIsq3FrcFar8SBhaY3qO9u4l/B7RvJf4Rfak3nxbLqxWL0/
moPDq3bPz5RCBY7peklIGRqVwrs3DCvwY/aCnC3cF9eftSvQO67vRnN6O7HB2bt4eIAbL33X
sXCjBWVmvbNRAP2rfvfq9gZHkm97+Ua997SnXnoDwtcIfezldKmW2SceddXfzEzFuxigRCH4
mnbR38/O3rFRrVUxZRV9K8y0fCX9aJh1jx8H8y4B50X8KQjsc0o/ArWucItimRGLYGlGEbP/
9Y56swQi3bgXhLTwvXL5ziCeWKdsbWXZKauI/Obu8HadSBUlFm1ochLPewXT+jNxQ9plTgmi
gWnnX5rv5OPOlyz+9iTcxnb6bVoNIYu6REZFyGZuFLNwlyFVX+/gGj+7aIQoeyF6XSxYHLoW
DC7uYUFb53hy9BZdU6u/JRFA/yWmfHAUXW/05YdNlh+6MA0s1r/rXt4O7j7B4F4SyeMPP21x
q7bq2u8iP3hwPykooOlGE0cmJdCCDPTuVeZpPahmPv/Yx6aormjyzsavMcogDBKResUTCM9k
SQHpR5Qqc+hMGe4KDLGRbRm6/Psi+OMKx1p7azuvYuiGdhhZFciavEaWDyPXG4Z+GFnL8qwd
Rm7KRuswsp5F1g8jt3TVOIxsZJENgayUI6ti7B5CrmeR6wd5PhK5kUVunAq5mUVungq5lUVu
nUrOipxTFflk2Hk1VE6Greaw1VNJW8mponJYF4/Fzimjclgbj8XOqaNiHIu9bXyVeon1LSrb
qFC2WaFs6/iyatlsUVRWqVBWrVBW21+2VnscDPsPbVjh4yDs8CmE6JUOB1A6Kr9UaXcHXtM5
ixFHVhv7T3z/Ch2mllYzZLQxn/+ijF2x5TpLs+OKIIDEc/6O/tKCWrc1vcWaqt7KuCa6Ljda
htpsys0d3yStt2d67jQUGdE280xKRguWcBY9ubSJiz76xSiVcmV6CavVwNCajRp9bCOYBcPB
aAxn3vKPDrURmyjnhuvStSfITnv9eax1Ov8CvYxFssBLOSe+Ie1a2LMhQEFX6W0/gHJOiYJq
djfANtQycE+A19Aav8MtbaAS+2ncx9vLDYZ+c0l7z9QhP+l02tCiG6vs0NqHaM9B+bQDoWkt
9LzQqWunHzOkb4iKTWabMQVnjrlwadTgeDnn7qLHvy5wDuhuLpc8IJVfto2KoZLbOV7iUEXH
+2cV2jB0Y3eWbke4Rk8aZsxn5IKGLBbfR9qQNzUd3coRC/kuQt9i0CcPFxuV+JuvMt6xeJqE
2HpK1+VcAVkuGA2/gB2iuQvP+RLKM6WJcxc5QhfWe91k32rIKbb/83YW83hfGrOGzhz2F32t
YL3Xqs35TJOarZDRp+eEo4ymgRYzKGnDjecgbfb1axrvugKY7VuUkYmtR1wMO3IJupquN4z1
jkxv8z2HmH8EAocm41+nimpZCmtLNbcoarVNSWNttGrgcSOHso1N6IDRbBpNQysq+Pb9iXVZ
TWsoWzuM06K8xjcWAn9tNiMKXVCCXFRrrDa09AXtQqHtmDb/zIQsL6JCTFGtaf+RRDQ44mAL
pY72q6m14Czl/2MW4XG8H4AbIlWjj0SphlavG7rSyIHUavwDwhwmrbG4yIJbLLXe1NUmIhUX
2pYR2kpO0sKjoavFBDTiuLnHUJ5RpniUzhHIN00SRd2LZPMANYh2A2dosaoaVZYh1TRNp+9E
ruLF0kGF3OTabYamoWvNuvh83QJtsdg7JRYpQHzEWVGbw00GstGQWzgwn4PwiW/3oy2XiW9L
YTB1hSZFzBNfiKT9KRZtimIvZFxIRd5sBCqtufXNQaPJ466dGfB7boqtY6yNrXB4nnDRhKAa
m91r6rn42Ft2Qvh/0q6EuY1bSf+V2bepipQnUoNzZvhWWyvJks2NDpZpJ065XKzhMRKfeYVD
6sivf92NmQHmoEQ5lSqHpNAfgAbQaHQ3GnhFDCTSEwbYzydxuqU0nIUUK7Ke0TDlVAyqFpxs
O7CtJhMQH1q2UrxNzWQAUwD+7l2fHaeT4ho79AIOpkSSyeGBKS8kl3i1pFae+aHKGmayPiXb
RZa0s1ypd1Ct9NCiQL0ct28gXeMlufWkNIWKv6Tbobl/akklqByYufRuO8MLCK3xdj6HPQkE
Pl6WnoNetE5taQ36CUjYi08d72NhF6FUo8vRcuaZHc25R4FLRYJMHq22ONx5J+8wpcAC8/7F
Yxi4ojTMWMQ3FiNcPXTNHi92160wPGBRCIMKf82TbZVvyxMto6tXlPAyJnNTTi58xSMBu9T2
boIbvK3A423k8fTMXPvDpUW3RVr2uohfvrsnQN+IYABG6+fVZtwxs361Hfw5myycqy2FhiAD
mCUh3vSejnXHg9HlT8zMmYNDz1MkH2CM8/LAdT8K6uVh2mB5qXxVKh+igcovl+cWHxrLSuWj
EMqzevkcPwRl1JZnbabq5aXFD4UvS+UFx0R49fIZvhKcV8sHoW2/mTPx7G65hm1sntOb2hoq
YzAzCmKSxqaiop4jbz1/LN/lQTquJKtUChv+E+ZgGuGEfbZtsEQiFIWN83SMOaMHt/3uARwQ
tyClTFqyQ1tchjJqKG6TO9UocHNtoMAc94P+eQ+tiJMFGmBTh0hH6uVqTu/uYMbjiq/VKEKl
C2LUX9cw+eHfGsNgzkdFwYNMg0y9vu/1hddXFhGmLysKmqWapZvAxVkoVfnZ26GLRFRa4WZb
XU/HsDAfp4vx8jH1kvVyTtj/8qaJBwdFvM64fj6iVN//WI2mJ4vlaJ3+g0zL2S3FGKSLU4+g
nTJLh5lZZ7n3vndBd3XNFutjGjTPvyyoQBgqXuQJAxn1cQlK15lp3Ff4AebFwXg5j9HyirL/
q8kO0kqSb5Y3oPlqWBqYpMvr3fT8U190fL+D43Xe8W77XsHXr/3J3ZzU7et+95sFCGm6NwLk
mvLB6cXg5vbT4PL28827w39lai+pqv3edQEVmHHCvriMhm6blgNsLsSodOQrzCUxHTh/Nokd
iAD0K1IQvK/TpZfloMO8c6MkyAbP9iKAw43/JrCxSQaCWkYNTKiI7QfWlIF62AyqBNuzhQ0p
S4ZJM2ggGN8P1E4eSx2GOHeAuqD0QdvpeF8x+0sH/Qjfskw1PmhsMaVsQ43KGUXYK1A1KmEw
ixEYG0kdg7kYIAdYDYNZDNaEwdDSnmNInwVKN2GAmCJmdvKRH3HiKfzPsgJzM2jVRD4DKTd6
9rrvLjz0MH3PAZkF9FlCI8+SwAFkEUrBNwBKCygS7SDBEvXfhBQ6TQtM0wK3aUqp4E2AI6dp
gdM02GdVfeBEMXCMiabBD50JJDloP3VGAUbWhLxibZaXFgmeHmI4AdJtyl63+0WSELWIoF6I
PRADgxj4TYj9/CSEgEEUVhnGaY7DEpEdxtBsUOumcNeJBDU24E0YznQy6z4Z23U/zs5BqMtb
tuPBojojXKzQYoHgcGSInzjLH7O9iMZuGRjhuzATCzOpN0mB8qOq3ROOKPH9SQOLuMsiJYxW
WMeos2gyHNn2jJNSt0Bb4I1Nqa2z7F2HEaw3Sx4Z3XcXeZkroW3FsIErkfB5lcPSTJw4kciV
ponDXK5oODGrqpCWFa7k3ZGmO4FtgmY8CquCTVa4YecKs3OFuUzVqmFsHBjucsXZtihxfeJp
OZxuyrzRcKZm1Y1DvZE3gdS1DUzt4E1oeDN0mgD7TlAVFGonb7jlDXd5E+Bp6QWYCm+k5U2w
gzeB8GFPrCDqt/EmkA3zWO/gzcjwxu1U04DrnbwRljeixJtQqqgq3fVO3oSWN8NdvIm0H1Qb
FryNN+gd8avzJmjmDTMigjkiImQh4y+Rl3kjLW+kyxvM8FRTEYKdvBlZ3iQ7eBMqzOFVQQzf
yBs0QVVlVriDN0beMEfehDrUNeUi3MkbZXmjXN7gkwqsKrbCXbxhVt6wXfImYlzXFMTobbyJ
eMOainbwxsgb5sibSLxCXuaNtrzRJd4orWvzJtrJGytv2C55EwU8DKqyOH4jb2DcWZW/8Q7e
GHnD3E7BsvarAx7v5E1geRNY3nD0HdVZHO/kjZU3rFneAKKEfarK7aHVbLiKhw28Ca2Oy8m0
34zRpNkkoe0cfHSaAofcoOm0t1x4N5+vT7Ns67Y4aA7aNTB0C0vJ1XTx3ft6dfPr6TfvAMO+
POX9wnyP5e5CJA8CPJW9SH62mzz0BR4MXyQ/t+RA/UuJnHOuXiF/9wK5CKPXau/n5L9EDiEc
/qvzkJTih7s4Xg87+ZtbXpxS2h7vt/enWdpQiwGrqVGxzjEsDeZCxwje8QRT06Un0+U/YSIc
LR8XxWfylJwsihyegATiUVT3wFIFmeUFI2LXy5mXZ4e3AExymJB5cTdgEv8qyHFRMaN/7rtW
bltYArPxva2h8Rs4hvDF5NFY55IYemqcv1gwSS21kui63Zv6fju0tDpkL9BmDLbVWsLQ10Hx
Vuh0PFl6o3i12a4ntkLgJdrxHZoIzf2rVTowtRF1r9ennDlQQ5uS7VfZgzKSLDQFXT/3GhGN
aou29lpO2ibYY1QL/gm8j8vxcpYsvffT5Rwnnfc/d9mn/6M8k+3p5n9tPUyjS6D3qZe7DI3d
r7FNcOSG/l/2YBrO40V8B/xJ0FmDvj5bCgYWl9D4Af1444xdfXr+6RT98hjygjx7ZzjctQ6j
tgVRGo3ijgmWwnjRbouhUCWLLRbXZOug4ijmKI5jQG/I0lNMmTNESzfhEdKFLJL2dThKyUhv
Lg63SQJte/VpLMCAoZLqdQznfcHiXUGLwemUfzbbTjYgHO6zGGdkD29zbssJH9v7miMsf4cC
KSSTsoT8ochXTJbpLMgJPVf5mNa8wIijAp/XcFIMV954s/h5FxnodWWyK35+2tuDMPQxasQh
7J/f7kEWcdzHX2NQWBBwIxJfI+C+pWACTziLZNTBfwbYjI53c3lux8xv2wHgXER7+C7z6AKk
ECFuJePReAibhfkfhorNZl6fvKipd00jhVZ58zpZtpQO8tcyVBtzvoo2P7SocHBGv2MPGyJM
mAi5GeiRlSN8bcX8RM+VDif2BZXVZN3CtNn0d4sXRBhtU3LIm5h0E27h/ME+ClRQi0hiSPrv
JiFfB2bhdjam6JFc7sDkhK/k9jSJdTF0H74Xi5eriKGJ4rLfOsflju+guNsROsXDCIPX4I+X
U4oFqJUIUUNdLVaw2S96RsbgeNoSLJCCSniZ0tSbYXZoWDg9jIMjCrOajrzuu5RcIUNMJ2je
vjy0SIKjWMyR2F5IsKE2ICljN8iQ+F5ICWtC0tqPLBIaYMfz2OPfbAnoflgqsUddQWP/Iz9y
kOReSLIJKQCFVloktReS8lkDkij1Tv8NJJ3PEzuTOtmbh0E5PTyUDqXg1WAWei5nNa8GszSG
slQCWbgfKnR2cFlEsGAlAZON3qjctSNfdZAhShj5jZ6iHEW96hkDlMhERu5G0Xu7xBCNB4F+
CS3Y2xeGaArkwB47gCUIOPp8NqPVYEZxbgNUmPBxogEFCu0TLcQVL6e6RtxIY7c+nfe8SYr0
0xRlaRMcZrEs8MRRFi9bxhMgJdBDgnhD6PPrQDoD8mtIUjKDBNt+gZIWgS/o6nWbTKhUJ35y
cDTHyfT5Xe9VJkGnZMQUrzUlJG0LIFpXmCvrR3FAmUXF5NWQIkvAgqBqISCn5xU+mkWR0dM1
BrGBEnqMJ8cN7FppUoQxIQQcEesOJtxTut0vIgsBQKRenFJyt4+T2QS2dwugeNToNKULASYI
tNs/xcfK8HbpHQXhxRR+57Qi4DU3Fx0Cf6MTTaYaUuRmeh/DUgG2fLy9Lr/W6jxGPS6psgKj
o/LgifOrvpdNpqPi7WMti7KcqRDk4OfFKs6yAcPeCweKJC3iV0VbaZ+c1ZfryaQoM84SmsJg
gyiVvxaFMTpLO6+97nzlFWN84Qftw+EA5nHOIIQQmlFUZCoGk/GkZdLyd0rRiRjnhRmnMZzx
kXQX0JjS7XAJ2PN41nFCHSo4tl+BUmhNHsEBajabxn+3ngqOU0+gkH+bx2UCyzP7c0s8xs8/
XFcDlq0vNFYrikpbzu/WA7wJ6h3w8NDolHcUVg0/gcQwKW1RvWdSqyyA0ptNko2FAwkdNMDp
V+Bgj22EU0Kggei3Lx7GI130WzddiklemyTpqZOH3FzOsD2LZIQjhgxKoFI8xP6MQLnOmv6M
sbZIW8S1O8SgAYofJg4C+eM1R75m1GX+5j6jzzhUGfE+JLKtFVO+zm64fDQP2FBMtnskcAKi
O/ntlwijky0KV+gfr955edttlzgG6R8333ZRMOHCXGNiPpyzA9pb1qNtawMsBCZ3Wq2W16eH
O5cmgTqc+TB/A3AcX2lJ4u8TytkIXyUdTwZkCXqIZycgWUDCDJfp5MRchh4slqYN93/BL+n9
NkngS1FeAP12A19OFCa0M7VAweTPdDDOgktPfPp6v5yNl0mSfcvJhKlluFymmxN27DtfbS2B
+2sBK7381Y8BSEN8rsZkQYdjn/u5qJi5P2L2PdOaxWAYr2EPXg9GQwRZLuB3W3f+Q9H8gvNC
ka7qct47x3WNwgYTs2e/DgyzKbO1JdYBrwzbLhrzCGt2AiTakGGQUIn2fY/i0cdmV89soRjO
RhF/aLw9Tp/TxLwgDpRtixaFFC9bq7zjfQKuZ3AIvFzEM6gotbSSCfEKbdYqaEmZEk7C4cuU
9EzW/RrYD/pymVhQnOdLxNmrPmUyxTFE8vUBsyukPGhSRzz8WwChDKpT5gW62sjLiMK4f7wB
IOWywf6xBmBc399ioZL6b3FAaYba1+sNMKKoUnmgVXXhvKlyUMqr3GusnGw+5bo1nCP0C3U7
7a3Vq2HiiF31FnUa2VypVQQYXLGzVtvQeqUqEtUG1ys1YrxSaeAH1TFqamW9yoBUldf5Oxom
s+VyXKk2DHl1dJvaWas2YFxX2burthpxBGcTZm4O4SsdmGkDbY5QbL4aDKeb9ERz2snpbHfC
Am+4RXtw9t1uJ5Ei1SHBSGzKVHGQOVvIOBpA/w5tWR1irNX/X/Zha//0dEZOkBNPKKGO8Icr
852HPCwqEL5PwVX9913vy2U/OyxhRid8py7ewDl0uKVDTzpab4dHeK2l9FCJBYJTKEihm+4V
wOQN5K5jjUqpEHepuyTlsD1d9o0mFs9cJIZq1x525tBSBAG6pkyPjUm9f97vFlc5D4bp3WHu
B8vb5rdl1jrvYB7/G3ZAEOWHFjMSGGI4XZpn5LczIF3gXeGKOwnLcp/hpYRSWcpVP8V33RvK
M4b7fKn8KPnT9d8dZIdM2yDOQww1LRF9fx7Cv001YCh6pfCwVIMtqnwUnviebwf9SvjCjnno
Lkt3c1RcGLU0sKxwGFdTUAQ3YdAx86LwAVMZmFhQJiVLOijWuZO1bUtEARrep6v5tHhCiVJJ
OaMkojYvCPCakJ8RZKf7wl1pC0GHQLp1e9fdzMtgXN+OE9U2QQittUEcpNMOHODJAIOPeKLR
J1481zAOUjsmQoY46U1d/e5lrSZb0nidqOTvxd3abEpW/T9EoDU6Z5zXbM7pNRtMy7DYxL/B
MMbWldoyyL3l42SNyq/3MI3xeTvYQVDNczochuifmy5WWxBKVN47AzEIrI5T7ziz7x5f3Xzp
/9H/dN3xffzc+/3j2Q1+Jjrzr5Uh0tf29kcJ8isQXn6zBUWE292Hd1fn9IYlnsNH0xV9BGlI
HtiT4l0bopAh7ho3g0YaO5ttByWc2lEZERFaIHr309l0lZqvuXPpp49ZxqUOXsXyvZ8ssQ4x
WK8PUgPNBCFMpWMQR8ovLm5Lj+6SmAdq0/t4bVJdlGVhYGL+Mps+vXyERidMauQ/iST0DjB7
3oknj+hiHZw1tmP4at6fPDTvpFG1pzmk9FXkZ5DaQDILyS2keANkSEHd17dfTs0t+xmIi0y4
VmSlbvvfLR0c4TG9Tz5pkQM3y7+WuCgNGW+zghmSgY4D1fRBb6fAk2uQatMeOubHteGQbRHa
4ZCc+3ir9w2kR8gaj8T5f/PME2mQIoyTPV3BxBnB2cfQd7yfumN0WLRHRw94D8PHFeYf++KY
c2AXuolU4I0f54/cu3hauU2TlOMISJcd6D1F2AyX8XqcGl9J2ympo6Lk5RLdgWTapNL0XNx8
mxprBzA+s+7Rw3gwoPYKqQMIh3109C4XrQd6SREEVkaWDxt0xRbXHCNdYHxHs+8De1fsBA0P
ILcXrfloNZz5Pr4y/+hUAzKe5TEi8d3qDm0HNhzlwccwCls6JMvMdDiP03nH655de6f9a1xJ
JKad63nlmcXafkVHAKgId1O6R4tpJmlzweV2B5T4YO5nVIbWf57cWJJI+xj7AbvHBkbXtPld
tmTzqhZ+O2qHR0aPuv21IEbVBQ2tU5waC+8qHqbeOad1XsSQPLRBX1DY2FYuiOvhKRaR0Ylu
xInW/M/vFKDbkQl6suUBLqqXh3LJLPPDeDA36Rpd6j15iuUGwQOmhM4M08b/fWhRBUc7//st
mhRXwAQ8qqNa515spomG3nPjB7TEINRhwfx2nV9ly/ZbV0XBB4FPHuaj6ZFZcScM36PGp1hP
VOS0Q4YY6uFExxhEp0m2rKZ7untHQz1MV2iZgpVkIUBzZ2+AGM8W3BKHGgPiF8konc7xjnTT
3iylsSTON2N8yriDH3L+HMBn+HiCvDlebOegnx2aBU4maJQ/LhBTEmXj2Xnr/ZcnM9qweG47
INNV2MJ/I+/6Arbhp3EW/kxOCgsAx1cA+AhS+8nrXZ/DcYFE0fXkr7/iBe6R8KdsJbRp5rIo
io5QyoEAWWNqlZvJBs8pjoABFlKA+XwEcJ2SadSWkRoj5D70u8eg+Hgj2AlzFlSWMxpYoIkP
o3iBnhl6O9w7P72pjYRDEUnAfniqkXzaLvDZ0Gp5vEoBmuaMyqe0eRtd4eVqAoHzMiMD6Td+
hlGD44KlgG5hhS5vQB+BpTrBsLYsOc3Bx0Ov9/H2mBFTDTdzMddyzmqizVnre9i6Oc2uaiGe
gt3R4pXfLsShatEDhnkSnDVIBif1CwCgvzwy8WU74kvzZImoLVCuM0OKu50WaN2muktXfbzJ
5h5ac4CuLyGuP/zVEbwFx9ZDT/GOkliM8Y6QHaUtWKBQU9sJtptV50XclgULI5TnBDbZi83A
3LZufS8QsFRgEQrG5nwFEji1qZ2cRQhG59Dp3dBpwfvpXYwh0hebe3y2dbN7wFVbtn23RfAf
z+Bqb1QG+Kq2fLE1MPXwpPJ0N3Q5AtM2bxJOAVBS1rDPvtQqVm6VppiBDLZx/rHd8w8BghAl
5vz7NAVJePqlzZXR0/CHI+8DPgF8OsP4r94FO/3jiyWMKIyLKODguSKXV7ZlW7UOtOm2X9Bw
n2NI9R+n1/XTPEYNeJfs9vTT8aW+PDuzRMD4qKhouPpzgmNXA/ClpQC5B02b3I+mg/sRaIgY
+cthKv98sbinWNCfvQ+4hZ3nJvW1d3Dx4bx7mDHcIgU+RqAjUms1ggMmlqKRWoHmhg7LklRC
ipDjkXJbqvvzAsukINaq1TYfOBEnCtEqnAf/wtxDuOLPsF4xAjhZbu44801Nl7ef3sOXPbsm
OMNTXxb49l8uFByMyOuavaw+zPcE+JRgZGHeOdI+ltmXI9po6EFcWwdsyPINe/loPBrEo7ml
VwGam7KfDS9Phym+8Vv0kFIR5nsKeUKwFObtmqfUwG7/3Q0obPGqyORC0AGd8d4S9T1bWeow
QrPkmzr2OLYdkz7F4L2l9s18VJBr46LZmzwGvWUCB2+YtM8WhOtIvwFkMp9yjPROpus5GS1o
UtjB1iJ6k+4HeJq/hKc4KlfJZjwdTGa4x+djDL/8h7drb2ojV/ZfRVvnj5A6thmNNC/XYe8F
A1nOhscCSbZ2a8s1tsfgE7/KDyDn09/+tWZGMiZgx7OXIsQeqVuPabVarX7U8cSpmkTbvMwX
MNBC38YJgNgbsdl20XeLJ1bhNhQPsnKWdZhoOBFtRRd0PCjhcW+8TfMwDeoSs8YF+MROfQLz
7i3QfFvOsicL7Qdqm07MB/PCuYHBFQdz2hh8+GBXdUKMP87Pnsyhyk+wKwJjAHP854e0d0d7
/8nIxHyqFag8X5yn39iDwaIMAygtv4PyGF/Meai8ny3nkc5gbCX/HViMBl0yYS6KQdYEbK7u
YKqAAnMGEdLijJKcRPCP5PuLHE0uvrP6gk7Jvc+cb/5A9sIOvtIRvrfsLg5IoPItskTr+BVk
xGpxAdIU5/3ZgaqJAolfy5VsF9y9A9s96UUqdDHmIG9NlS/9nHJzuPN0vKTXjMuaWe6sInRD
wpzcoy02rN9lkcxoudlJtchwFe8iczvbdN+CBVEJ1CX3y46QdZKPC3rBA55SW1OzV9pKTWk0
A6vHLARNIPmMXtZDsWEWH3Ls+2dX5fno2a5tUfgJVtOLKLahIPvSlfZDB2MzDy/ZE8aYwDZQ
Qugwdl6OvxvN6dgLvVeQbU9zOlF+6GIsaW7DOaZTnFpBsDnxFbNlcQW+vzK8Vdp7YXZDo24C
Qfmvk15oggSt1IyNRnud9kLNkbl2oT1coiYV0J6yGCG4lrOjmuIL8fHJ+N1CfB1PHgVJ9jbG
mLFr+Xh1zv+zRSC4R80x/6PC8ihDyzLOd60c9/ZUajtKpyL5GrLtqTQmlCsYt6XSxPMcrqZ2
otIEemUX11tUGtBpG2d60J56lUoDahv9XKn5PSoNSOyC58sg9jQW7sUV/bnZ993zy5+5A0rz
16PjWu5C0jy//PQXdCLeU+jV6I9mfbusSd+ijhLQGhRKk6ZpQRAKw6rXQUs42orAH1fgDj/9
/j0426CP+3E6S09gDpo95CPhrwXZdE0gZBA00pOMyhtXgNPmCf+9h87yrlmoVbJCNdk0l36e
2Fu99VuI4oJvv8OP8uu99xZvqLGK8zvDw1txC4PwIbN8RHz3xdfsm7nOcO8QixPuPs/APk/H
yg2iM2OxByXC6z2XYu/1thckVadE495KW85AlBfKbSTDp2lqCQ2qVhiELLp8O15+YC/2RVes
oeRaNCFUaFdBAAfJl7DIt7HY+aIJ45BRg8GTbs9Hru+ICfR0c35Ez54f5Jn2Is+r2ZwzZc8S
XEJsMzkDv1vvDSZ0CKov/a5FoxSCD6F0mkJftKgPcdRpFkdo40u9HM+nWXfQH9ilnGgS4bbR
3KONxWD8re5I//DGgznXeTp7gJ/heRwffrzypHjXOjw9eSda6Sibpe6klLYqFkUgYfg/T9NI
6tD2Q2RFpEjxjlVcIzoTpyL7vXh6BDp8Z/GEEQ4Tr+K5z54Gy5H45XP9qnUWikui27GDIZY4
Vf4xIaIX5/++OvmQXxuuab9k4anJYIkK5DP37kkvyzXb3OtFZgxlmrjIs0MndgrZqovrB2Rz
K45IjkoftaQhv+kc//K9HJ7ghZekdbDk6j6rCG11U+5CPLdLAZQq/c2HuPNvcv3vmwBYwECi
uWOr0JH1xwHctIlj0koa57rRwqCoYSHDIN5Go3F8Azv6awtPGwYx/uMb+eVcPEpIMKOU33iv
0MPm+l4tbv6bdibD7lx8oMPv14nFkXBQzEfZ7ns9dsndyxmYQow/CZs/VsfMRzQlNur8kBbX
ZMo6NN5Nf7JAvsR1igVyrE7K+JazbHFQl8n7HCxEXMMoYU83enkhXHta+PC0ch3EUfcRphUP
B2Niu+XWHMGELsK9DKZt2J5i0+kO09G0ycb/vUm2YuYvzr8cnt1aWMVhj1P43lNb94894iBf
jm9dPd1hUSjgV0+9MGuDtkhi+45ZzbxwsGfEoYzXEDuXfA221JssFwfGoUbskVyZfsODPLoG
Y4nYUIRARpH0ZJux3Cyyh0z8Aq/jf83x+X/H6UN6P2l0J43l158tMC3P8Dnw4ceBOMdXzhOA
ieFUFOMFEQ3GzVOVLUokMPfWuHAnfv7S5JwdwXl1i4mJFYfntAhvbg+vb8UoW9xPemxoorUq
fDNoXINhWgTUYHAdM98vwWl5dTI4GxSPVrIOZLMZdbIeWPgwgPv6Y9rPZsR71Etj+oJCgdKt
BhaHkJtXMWM8cHTMTLQaDC0dwtwW1+NwxynBE49da21ChEGoPO+EJNeFCcLfZf9uy91HxJ1I
cIEXkrkMl4qELhowLbDwfcMixm33a4jTIh5lmXkhX230EjC7NP/fCipx0IYhQhmtInsWdce1
ANgzbrP4CTthL/HC7H1D3GfpbNGhY/2BemUZJIkPZ+HBbevSULG5KKKvxsjtmPpssi8UZh+y
UVxARjA+jaDeYvAHPlO1c26AhDT4Xs+/FyaxAKLjMca3iCPT5jPTQ1RREn5v8y6CInCdznIw
7AmOXqWKQxoqavbWcCoOnLDt9t5+VVQBYBBo3zBHLZXpx+fSpIVNswiT9+SfWJAwip6DbEc6
FlXMkabGD+1FF+ZHn1+bcaRNKyER+QRGmZ1u6D09bbcSlFQRZr47XQYMid62y767JqKorGNc
wM5H866KOlHxsm7O5y2hoiN6YMka63eChCLFYscUumu5cKJkxDHnM3iO2Fpufnc2aTe0ZATv
Sqy+WCVR1Dc4rPmUZyuyT/qzij/43nC+ozZHaff+v489nL+793+IP07rHyd3g25pF7pmFupw
M+UbX4kSB1F/icA5RqOmMTmld93Opk/trvrxfkfsMGA5VWl3ak1Zf5ALKuIhq+z1Bdw/xAhJ
gOCIrEhSYdiru8njaXs8gXEs/MLwbZTO7gbjYtvnR9N0POhS+UvMT9FqwI41793jYvcGRvMk
Yw7uBouN72mBJWZ2nWNZsVO4GtB0ZeJyTlLkuATQJlDz509HtJSLVQ5/Ls5+DN8NEqwOhGxB
uzCl1guBBhZ/2iFs7elkmyurh2VHueAkIW531XTftcCBDwdFHnV9Olz0RzSDx7+49+K4er08
LcNeZcOpM2uBL7e6e6SKrEaxCLSvN4g/pO14Azod0Ot+GGVtQkTb8+fzE5gizsTNFC0dcnaM
lVtyQIUJiNBCXSDU1qwHjwrkHGMnFm7fGFZYwFjFRYiq48svFx8vD4+RZvZnWyPx/aLGYATj
+T5MQWF51hRPdDp6avend2l5x9joDErxEXZ2sL74cHV2Kc4uzm7F6eHZx59+suU+B9IcwbnS
pkPZe+9U4GsFU4GVVc8rKLbJdDA8e0l46LB+ILHAOmKrkk2Bx5kztNBD1CGGnYMjrnctZIvE
jbHPV/hqGKsS/ybQe+PlcOg0nnA84s0DvvVG7VLBQfCRZEG7lw2HUP0MJvOVzW85Fpy9alzn
OEtOthoGVjHkFlZUFLI8dOagZVN17W4NUIHETToq3WWTu1k6NTnJCrGBEOVxyexyiUINQ7nW
9X7r5lpc9vvsBeWURxoc4Iwk/KvWWf2E7ZlZuUfyF4eDMhH8jguTcgeU3h4blBZWYVvCI2wl
bcPlRvMbkjvVr9LBzGgX+TiKfCXi4vbI2g/rEkFivJho6/2EI1JxGjb6tVLYIl6roSM/nyyW
4nzQG0AuI55uAhRAyqRJHhqtMJs5RyQzGuHXe6JBWjyaQ0xNiDlhhRepVZCTrTTnbtjaAV+g
vhkFJrQQdFDfIG6M9CxEorEE8nwa4jpP+cknu7OrB4tamj1mjsBiKKjhr2befn718cbMMj9a
sGknh5lY4aAa8bk2iGsmIwuhOf75mxCBhQjomPc2hANAe0HyNkBiAaIIwb5/hwma0ct9LnV3
flnL9ziZ1Fto7fz6YbzRq7NE6cdSbRLFzQIkHGaCjWS7ji6ZjgilKo053t6MxD0fCRe0H4i0
MxBJyfU0nci8Dd6Jb2cMdntR3u4sfbRVV9pxWlAaJlFcvzObpL0uMlAWkQBfhhYLBz7gOJUM
T+MawoT2joQpEvyeNcmem/eT6fzATqsKAygZhlm3OUzHWdsIqHlIPXra6K7npGM4OsAYZ0fd
FMcnLZiU8q0laIRkjIbfCBphPC9stzkypio8HEz9q9nkP4jXc5ulJacnOuKsEqZKs1yia3lB
J32OMmT8T0kq8b1fbWRJRkSSwAaSkrRUrFUCEkum3PKZcfBE48kVG57nZ3pbP+CblU66oLfV
TnskSxw1Dhu3jXP6e9EwujoE4KQ3EDdIGsfeStJSZ8DuDKUrCb0ZV1EdsakAbG6Rwcrkdz9u
Cv4pNB5iz3vv1ObFVNb+fHJ9c3Z5QexYcgBjbWsmHHbf2/GnxBdICVqvEF8MBcEuuPwVfJpX
b34bTyRzfmUc4Fh7jwyEQcOpzLaNtvLZZZ3n8x+ejfLSFL52QHDb8BffdbEjOZEoyaUAarz8
YyHDOORc8yJv4nl5pCG1cxKz8mz6D9jar08ayVV5VdSmn6aY3n+bD8ocpoMewCxAomCquwJA
QteAwzHdfptmjryjQ5y9nlX+eHsjyp+Vyj4Hxn/ea4nmJZJMWcYTKgkjfgev4Px5BGfCeHGE
qDL5r90lQ9oK1HPAK3qpZZJZhGV2+mQim6zWL+Y9X4NNd6chOdz31gfhvzD1JJDjLLmKO511
BosisI5bOWKbKK7JIXSdgTJPa9qqsYLskOdK89yCGFf7yOuI69Aii21NZJAZa+KezuA18XnP
897D1fN6D//f8N+CJGri2BSfuzyEdgilcsSyVjpfrCH2/TXEQ+hwiNQYsVxDDFuwHLH/CmK1
3uM3EIecv4oRq0qnIgqhH2HEulLECd/PMuKgSsQxnFhyxGGliBXf4zLi6DWqUFu+vJhmWeeI
40p7HOq4eHmJ22NO6e30eFtyQzyO4uWllfY4YZUBI+5UiTiROih63H3t5cktpwLJkYoe9yrt
MW17RY+zShGHfP/MiPuVIiZmkTMhWSk/ThJODM2IZYWISR5M/HyBSL9SxLQt50xIVsmPA5wt
85cnq+THgRckSfHyquTHAdhxkCOukh8HXiLLOY6qREyyGPs6k1iymAA9iWKs5J2Xskfg02nC
5zqeqP9MUonvFIW4NKMiaYqkLfI55RIVKVOknCJOMUBF2hRpW0QbT8BFgSkKnCIO0ktFoSkK
bZHmeORUFJmiyCkycUyuf4tNUWyL0H0uSkxR4hRFykDJfMxWmRT4oR/lgy5G7QybRLgc0s8L
nemKVAGZT4p0ZiX28qHLfFqkMy9xlA9e5hMjnZlJdOKX0uirP7A9zsrTRqCIKUDdhZg7bY73
iEs+DgIl5ua8vScjUACdBgJa3d77+s97xFPpC63PiLbwehRrBeHcqjYCpfgSASmz25PHMbsP
lURrawUxyOBoMevP84NwTXRnXeV3D8x/9TwgEhtZZ7PFwWQMU8B+ncT3Qf/bgb1+CFTCoWNf
tHYsEsAUCmMOu0TkjuN53dN1LxG+anoRzan4dNtCkAJfIeSvcsak4V1KvT27vBEnx8ein3bz
4zwSx7ONVP3fy3HdDxB/KLcpXb3hDLS5YgD4YMzRX/kQsGKgYl+O1hEOGW4iBoTt4pFkw35x
+rT1gzhcrX86GJuw0C/XjzwoXg8/3pS5bRBVu+lUiPEaBR2CCm8WS+hwCjGFEtH9J9MOHGKd
8kRB6U3lvvWJPz87PhMt6PJtxcBj3z6qCAvv26vDz+vqZlZUOyrmIFTsXVx3fv4U3eVC3Gez
TPzlPrcwNB4Yoy2ICKYLkysB1wDLsbVKm95BT9Rc1UTIUAkEQXv+2KqGcPJciYiaFTEP0C7t
CnSu/HJ4fXF28YGtyQiTuIJyhy0v0ln3fv8pDvcH4+5w2cv20/lof3rH669x3wy0J9ptuPbT
cuI1hThnbeo6LdnZP72nTj/d954kHbTLNiMvwttZbao1GY1oNTwSh8ddAa5SUijke98xov+H
fUkRsWx6m9dnV3yk95pbd4jWDwI/3FyZWWxilpBzS2bEa3s0lSenHw8/3HCpJJnCcvco4KV9
ffh7c01DJK6PfjdTz7iolZSftl6oaxFGrAy/Pn4R4c3ZS0+Pz+wbJg5PRzp3cInGzeb10ZXT
F4wr82Jx7cVrCCU9TV7pYSwVVt61NHofS1fcFylf6qF0FBWe8p8hhOkTEKoXaPsaudpW0fHT
YL3fFqH2wbwRu2+tL3v4817QyyxnzM+SxJZ8HQ+p8PujD9m6vmVw0w58bMiCaKT40Lp2NGI0
20ggbLdSWCyFuMvzX5io1rU7B36GvJt4+nwOwo7To8RD/LgWXBhuZ0g25RSxWCL+RzzQ/tJF
aN67xaTX7qWLlJZCP/b2+W8JkHicynILABlBbUcAo+Uie2ovx9jAqKr095FowVb0g2Q7zCrk
A90rS5lEJAIKeg6QjnBbtUUrAYcgAa9tm7hP7fET1VRgEtqpF7KH+haIjWJN9GeZubngEcyp
bhJT1cypGXNYSkI9yzgm82ABNgWEzltO4FPg4qPeYgqAzFpiId0mK6C+IqDGsEDm42VIz62W
QNijFhdtxC9u04b/tRh24NSTMQTl1qSXEZPO4JNL/CGLRT8RWShIUiTy1LGIOyIJREDP+/mv
eej1SHoRvZ5QGrC6K2ICzFDajfArY+HHIk1F7ONhPxI9ruZTKykaIvElI9gQDf3L65N02RGd
BL3g0Cj4VRJAnWzlYdlC7KEjfihiJey4QraI5p05G/fgek0ShgylClOvK0m28bp+h/fqEkaG
bNNbJBxYjjnOvJnoMu+AJNnjVwsSKVDNF0S85UseaFZznXwOCOPA+mSMMHFESk2hvMgv4sMR
Btr0YJvzeqM+bUm2URVxnPVtQGJEvP6LHfpg8UJCplavx9FX1MvncfQJU+STdA1Hg+G30WS5
uO8BVfIGKr0e4R+odMLZz+b3kHnlGziUp1/AkcjE89lqHjeHp8ZkGlmoGIuYkoRcdxwYh5O7
uyI7xH8mpZVI4nsxhxhlLLckoE1m6QxGchyHTcyn6ePYGGGzSdJ82b035kOEx6jTac5LbBAZ
gp37FEUczaOKPsUNL6RjkdqtT8BCu42srE8k1sU7zhOwaM5OWE2f6Jil9Y70FDcQK0kmVfXJ
l0YJvGOfaGjV0ZNPOzPoKUnqfTrtIeyN772RmUOV6XicJRwjjr8vdyZN5DyCTrSi4emQLS53
7JMm2bC6KQ+R5r3AVvDf+hD2vXSQKrHu+ZJ4KTzXBmN2/DRRqhfpYjkvDr6EjbivjnceYYRI
LpWNMJGx3J3QE8Wx1arqU6ghINHB+KH3Jy3Fv5omfjlaLm0poqCor7w4DHceA8khmv2DKhmD
ouOzJ3fukx/LCph/PpG03TYLFyfqSvaUdel4Id7tzzuD8f5o0mOHqHfPH4h654FT5jXLmMvv
Nmkt+vHWjCN3B8mNHnAym+IkmuFTPfNqsvY10rVZOhrO+4+bdIW4ZgUDP/p0s9HAVSXTvHFr
4Y+3hnhvD+Y8HYc9Pu4TT5/zI3l4qufmGZ1xOl0vnHc9b+B5G3Vqh3e/3ilkkn+lU3LTTsUV
dIomSOcdkPI7nVJbzJT2dyQWRIs49NRGtEKns90bkxs2ppIdG0O0dtY8miEGmw3Rq5by5Pco
TzLlxZu95F05Amag5Z1uNgM7MIStGwuqIN+NG9uVjW/VmP5/bCzcdRppy4Dmf6O2dh3YNm1V
QfiHXrhZY1UQ/saN7bDDbd/YDjsXN/bbyfknqL5fby0XOiMVsmPXbqJrxDkmqhKnozAO4Ji6
Y58ijyP6ViNOJ1VIXthXzLZCv8+3GryyfKvZVJ5IdiWVIhLVRo3tusXnecc3aUx5O/CSv2u6
lVfFLnEqN5pueisVNHa06XRXsbNHmzZWhWAaeHKzxnYQEbduTFYhj1ZOtTus27+vU5Ucz6ru
VBUH2ao7JXdYLX9fp6rghBueLZXcgRMW7vvNi8/t29blRs3tygs3k7+K1nbZ6IrBsfP1rLPc
qMEdiNyEkFx88+R0RrRC1JM9bUgwu6z3YpjFhzpnZuss+/1stlHjO8huVjkpsWykUU4eHmlp
lJO6JmVN6trXSNYivxapWqRrUVCLwloU1aKkFh3WoqNa1KpFx7XopBad1mKvFrf+r7Vn7W0j
OfKz+SsmQYB4A5Lq94M4HWKvnUXusPHBXiM4CAthODOUeeZr+ZDXOdx/v6qeR4+k7h5R0i5k
UqOp6u7qevajamzej83fxvbt2P44tu/G9v3Y/m38ho/fiPEbOX6jxm9+HL95N36rx2/N+K0d
v7Pj9wzXQcV4hQ2z8dB6KPrBjEyJMZo+z8NHLJZwrV7EwwdsFDSIW8TfZa+51ultLarFg51p
xCGsO0f0vHFRSbglLzUuRplR7Ll9YlQY+jJbbczV11XP3PRxWKRiL7Ppg9gsY6ajOorpZJGv
VnjGdNLkczjc23TjVsQ33ZhuMYPDx58ZOzosrLeb/9zRgvaTz9zsZK6sq2QvE2MjNsW538Tr
NjuxpMbhyz3SCyIH9jsRoTXW78Witj3ki+r+JBr6Q/Z16Yq+z79nv7z/+HOG6bXzVYtGcO2y
Fddomgv9SI37XVLDXVKKafVsDaEw+cvLbMEiNstcYeJn9smC+nyZcyKATRNBybP7pAmWHn+x
PnGm6LPlWHPhKtq9UJ9g5vizNalWwuV7eWaf/rM+jeYqI8+yt9stFpH8w+iXPeL9jknjxG5f
Zdm7/LbK/mO7Aev5byV8/5+/7qvyS36cFtv1v4+u8O1f/aWQ+mBmdlMdr8EFOh2O13hnIHut
xBx6y7TIOMNv4CX/gGmgYfTzqrv7MR29g4bwcL/LCJPvb054cfswHbUN5HUOIGzkgPDN7cVp
25F3HfW6t9YAWrlU3m0zqDow8TimbXFZd7c7vGhx6I8G3lICi8TFxwSjcWMoK1dsEvXI9B6K
us5cHEVLhhCKu7AwR2CX2vGOM+qJlt3rKb5KefDV0bs3//jp/cdZ9vHzP/C2QfbmU/bxw4df
pqPPmxUyD9ZvxRxC+9MGy2BhysQ8u22uZ2CSPiDXuK49ULiaWEWO2dydY3+qs9etsNCUYzoY
GCbE+bZfusMYP/784dNoi/Vt1stVvs++gZX+0qDZbY8w0UvoPZa7/VrVTTQNZqcNJrZz941Q
UWPyt9zXScJEecfpaFQc96tJkWHdhJMfDcgWInXlFL4B33ZDLLeYidFJFQeNCDJlOtk8Hr+L
uxaj2rj7R9AWild7TwYANasTD3SA8r6pYXbA1Dgs0nIaxxJvnnPrtQEAsvvNc/KI5nmdsySG
Jd68EsSfLwJA/qB59ojm0Tm0cSzx5g13ee86QPWgef6I5g2W/4xjCTRfi+hnp6Z2y/IaM1Rc
gshqZdo/Ngr2G2q55h7NdlMfTTrtptk/Ma8yuC6Yamixym/grS/usk/V5St1bN1gc3e7cABt
ysimc2O8vYP354QCHxa7jcoHOn/8gkhcpWxM4TFt//ipOh62xVdQea9pxhZgUXI8K5OBLsNC
DKD2sis6kzP6axBCdgBz00Lo7IrN2AyCxBAIoZl52IrJrjjAkHArgW7Z7ErOAAScn/BQqocw
lGRXFsYSbIXZjGX9lykMnGATgoebUF0LJu+gBEBpGAle+A53jPuOzTswoDJTMzqjRoTB8g6q
6ghNgdLcIlQIhmRFB0M7EFtPTpjQMDesg1ksWiBGcHZ4lG407xMOBoiEo7HJnPsWuvEzJBuw
zIyRCLFtB2W7wTDpiM0TxPasltsODIlNZmJGeaQx5qnAu6ll2s0R9FJFhIGSwNRCF66YBTAW
acsD6Q7GuollManzxCiKFoaTpKBSP6SOEJwiM/AZZSrGDvahFHGG3CBnYZg+ETrScZheMwOm
YBHu7hGh6KjAZUJcjclooG/K8V5UkYSGoxvW02F9lXlFwjvKCdrwAos0BAzdQpVlB4WSERPX
vi4tqw5ENFOkwxx+Z4pkpxmETOrTkJ4XqtaomMolDBSgtzCJKSJ9OeqEVtj0FJVeq7YgkrTa
QT5C8jooOqQdvAJXXfekSIiR6qlh347EKaIReYAJ0p63PZBKT1BoPBonKA4SMHjSoNxBO8G+
gZYRD2EUaeyeitiIIuMBKNEKBJORKfLE7vSCkikDRmlIxFXavejTYd6pEmVqnYVplcNQXvi4
6qBsmuJeikrSOT+kJnmkdwHu1jSt5pSfpAXvgFgjRTEyBLhBcydGMmKJSNXTQB4I5UEhD4Xn
iOiQO6cHLXOoqdYuq5gG8kCLThVr3blOEQvrxVx39DOk0av2LC+Vnq1WDXssD3kQkWCIvkzM
ZQci0z4X805X4WmgOqcrYpZ7ToPvnXYMEXUhdc8geQcP+HiAIQIMa6xjCBiYjHSweAhkSWea
Y85GyJe01KmiKNUD3GB5zUNYsGOQh6wHE2n/ydO87HSElUkuClglqxJMpHqEw4C8AdFJJiJl
T3v5dkxSqfQt2aLT+9aeEyX58K2b2kFhosRDpWc2aGQo4ak4KeRHUpKe154IUu2BVOsZx+ym
H5PujUmnVER/SFZ5IDNgMwI8ToltlASlMd0SUBIUQ22amirfli481KDLFnL0KIhMbThMhIYB
q0sxUk8JPAtRw8XpCW0eJIVORM93IgUPw1IrFeGJYjTtVwd0BGVsQHhDMGmfra+/2MJDuWWk
SECrevxq/JqIC7gTNi1IBZMk9jwAwgf8r5B64EPuV7BzPO2AhawZ5YMLSh7Kh84UY2cnEswO
GkHqSc7bdSg+rGK9n0y5TstST4cxD2SSCxYBx4hy21hcEXFG+9SgnaNDBUn5bdRkok6A40WR
91b0WLd4MehgSr/QhpG7i6N0pK9VKPqiGIY7fzvqXoW4ROjBlbDQeijG4rXvrCJsEtS3kiUF
M+Q1UsmTHowXl4U3BzK1AKSCginVgCMckkup03LpVacqPVDt0UJjj3Bpe2OqfVowIrHFRxrw
sqhqXR8ek+cQNVTS9SE9Cnq+Va1XGxWx0PSqxvlhJOb+hJhdpdwYXFgmd1bk1YADQ8PCoWx6
ej1LqC6gonrIgQnRW9NBnui5gcxzhW49GBrRbH2ukL0NAN56xDzi+oRWkqhO+j5hyXLReWqZ
K2hQdOP8xLjCtyR71DDpmDk0JJP2mFhIqEy7xSOHoXJv7QxrXWIdIXqICw1vGIoOO049KDHE
UaQICqTpdpRomIPvxD2e9ia5QRQ2Ixg7P0q3C2/9rbOqQA0xrKlz79dgIJz0WHur9T0o7cQr
HpuFBmXTfm5vabujHiMkscJPglPMSLMLw4ZXvWyvJVYLVhQqwIOMpAxq3ztmysOoAVe3twXs
N7DIgEkN9Q5jxhTFvRku/Kaci/2cuYraq95SYw+Op5fyPB9VlQcSacXkFy2s322ksvUfSWRg
RUBAGNXt/vPwlmjVI+LAekzPjugelB30HwP2m2H8mNqn9OxecQ/EE6FgREZYsw02vKK38LvD
LlJNAHkzUvZa0jhbQL6w2lQ9p730QsJseulMh1aMmIsiU7EdCUQmPXDeuJImsoZdhFsVjWWI
bWOzIJRMh3i97R2/9e22Y+MC7eMm5jUH1yk/I6zX+MBGje+c7nwnJkgjlzZoxdH9NOB+Vl7n
CjY0y164ekZBiKesajGRPN1xZ1S9oxrCJBdaQlProsA4xXsaY+6lWKZCaoLnYB6EFkyKFP1I
aHmZSdk6Wyxif3oKg3o6uEBwwBUPLDEwOWD2A8toTKWOXqjgzidTNEn03qY+8TDpvaTQ3GI0
h26WDPK4y9T5cJ5UejcJ+DyopJUeXNXvCaKfKgzr6oM1jwiJmRdgZR8b3fbcGd2deRncp/Yj
042zFQXqsZLpgfHmkNqgY1xKDyTqDWRKz7HEOu1vRUyBIW2QYM/RTGZgr6w3XX6rg7mwKW73
TYARDU+vAIe40KS3yoL2w6R3voK7UcyYVjOZiBAHVpuZGdj6Uv09w261iVmRtoreXTVeR1uZ
Dr49KfyZQmZ1w3/hyALMYogY1jbeqg2uT5GQw88Jeey6Ww9mcIsopNY58Qslw8ebrD+4RoZ2
iYLjko/c7ODcw6gkq3vpnVMPo5sjWzo2Js+BfO7BTOP4yJhFDY3JJk96qQAIJWmpCuzKcbcD
mIrvvXQUxEOxQaYIMC3eiqiXBSiPHYDwZrh3arI96xQ9cRIyj5ymtsBIkOhUN8Ft5Nxb5IAm
bTbBosflQiaE06QTTeaJUIQzUrsZJrqS6/vJ/WyztEPdD9G4Z3vGG8Ubm2zP9X7liDPRrr8N
amtVeajhI8aBk0zcbUNGvUjVW5LwRwI5J+ltFe/O9GDSJ5JCGpSzWmvEdrN6y01ewnj6TJIK
mB/OZbuCEdmz6FG8B6UerQF6Y9KDy6SpUJrjXmR90ojx2PJsSNK4bVRB7NBsSKrFwDpXqCEh
62UJSmLBKr8Tq3Ix5NL4VljvnPbA6lFIZYvBwzyhAWH86BYvaGT1IrQoy2V77prKCE/5w7Zz
L8VSJCXL86FWHkamj214UlQ9oOYQtR4M63pjGtoEu3O7gkuTnlgdaqI7xBOxc7219g7IRbXp
cC7QFMaoLqTA9I6PNnRKtsfcH7Hs4y2xas+sx8KXngNUegOinIsr4mAhtamSS3zBxQuuSRci
RKxq8BAAd/uIjs0jYE6ZyYgy07xVZjFyQjgYmgXdrgzG/EnvWecLD5W+uxX0vHR3fSssxmlt
bdoz1n50XMsMoQFHc3+6zOb5ob5kh9XTMiyq0rxSl4nHO9DdNbifsHRc7u6lurvRZXUo9svd
cbs/tK+8KcvKnavEF7Aox6HGeVFWt3ffYUpDPHT/Nbyhd/c9SoWgD947fO+a/JhvSniEN1qx
Zhi3ShjGCNOxFwTjQoDbKEZX7c3AX7N/tncEu8t/2evdspwJpX+IIGKUE8aUsXR0VXxZrkoy
E1j6Iy+KY/aaorneV8fTfgOjeP+PD5/++9PYXax2d7IPQHB3f9mT9z56DcGBsVL30eONy+01
EP64337H8gT6uY0o+I8arMXYNdJcDr1eb8tTU67w0a3cQbK9vqmO1S1eR8e+midhKasVIOl1
Rj0Jzfq36+NyXZUHLJzzmuEm0tOGdACoXVMZ4jmkF5IzDTxko+xFLDEM7FLkBWkV0UwKFvu7
ZgLTacfgKRMW80cYGusBoVYQowyPtSCZsZYr7omEBXlOy7Kpf1X+AQQLi/yN3RVzgfVn4e23
+XLV5RdZbbe7afb+9+UR750fsNL757+/axFM+0J6BdLYE9Xq9+Wxd7N4BL3Dk+3tlf5p9ulU
4H1fV/XeZC57xGmPv6m6VpTADBqcUx6/w/5aqKHL2A6LxPD4zJvwCCi5vXOL+8FNeDV0Gdth
kcYninrsTXgEVFQQnboJr8Qjmlfc1Zs87ya8cFfRLWWpm/BqKAuOwyIVo+fehAdAQ5TQMnUT
Xg1lvHFYjLwziOGb8AAoMX8BpYylWM8MsZ7DIhkj57IeAoLSJ0nWM0Os57AwqxKpHKLNG0K1
ESnWM0Os57CAr2/OZT0HqFyd3jjrmSHWc1hMryrWY1kPAQWmiEuxnhliPYcF1D89l/UUzJqg
VCX0FTSvB5p3WDBh0Lmsp5BsRPOEvoLmzXDzhjBrz87/gYAQWBuWZL2h9COIRUiwveeyngM0
9s7cP2A9O5R+BLFI9IzPZT0E1OD0JfN/2KFSSw4LaKezWU87kwPGMsV6dkjrOSyCqbO1HgAa
RriRKdazQ1rPYaHa6nNZDwE1ZSrJeqmUex4LBAdnaz0ExEqpSYNrh7SewwJqR53LegBoCZZD
TrLekNZzWGAOE7oz0rycQoDsMiDui9MEglZw3asZVjX3VWohRqk03tS4rfbgoRudHRerCus9
77HKJT6AL4v6AXwIiOv3x/W8eaX7/Np+2bdfGpg5fmyg2warR+b7/RIbIhdkRrJivgBfGP1u
4XsspLrf449VXlb77L+WO/gl05xYTZVbMX3wv8ejXB3WEJ636E4jIohYmRJ4u0JblsJlKLrh
d3Bh2c7JW1cF/scl/GXlyrADVrBjzY+EHwE/HH6waiqFHwIUtI6KZNRkX/vzvpgCnnz1Z+ff
4+LE6XhYlpUrP1r9vqsKfFhsS8wBtP1WZ6PSGtSqxQPez8kUh1gk7Wn1Z2WvA2wWggvSqal9
8SDNlU6lZkQEwmqVSLEFEjOIQjIrk8bWmkEUSgmZ1Fp2CAWESNIkNI90VazTKASWIIlrD0mS
mS4RhSVCPSw3eNq5FFOT+X5Z3tzPnykHM3FqM5UCRAwF7FhMXDrd9suUzFy+wGt44GpAr9eY
gOpQFYfsEm8JcawgadXoBF1BxXCxP20uUJBmEDIfM/e0KkfZX+rsVxhGY8Fl6G7btoXGLbiy
nzf76mZ5wLqVu9vs8CXfQ2/ryrmOy4vdqZViBALFYu9J8efNofhS4TpLiVH0sVoDmtOx3ALL
l9XRSV6HAIuG0XsIPh23ux1KFTy9bp5eL/KvFeazq/YeljF0Hpo32rxbYSBMbejWVMpThfJ8
r2M1TjsFZ1Agg53fH4DlRGvywv3hTKKP+7T+cIPJQV+2PxL81cf0Z+/sgodTGpc2En2pAR7d
D6vso+hyjyYQMVmW7Md59ABtwZ7EvwhLGaY4fcn54QazIkJ/KszbiNa5q8hZQ/gXrUZxb19s
Ez62WmH0fpXvcFEflztnmSWj0W/V+jRZrm9aWzhZZL8V228MzeHXyW+nfHPMV5Pb3YTyCcFj
oT+dBULPB2Hng/DzQcT5IPJ8EFWDjL7eri9fj1450HrKJr8bda3E6NWkTiw6gVfgF1TE8M39
oSlw/qf6Ex6gadqX2cX2sFznN9VF01b7OSm2+6rBOy1u/gUQ6wzYET4P612Gn2V1uyzAVQLP
g4w31RF+v4QPAn+qf8PM7/vxsmyfIh+B+wIyfLkp8K3tpGYu+N7lTlwqTkh1mPeeTXCBe4um
YX66gedg4tx+0qXz35D9sDf75W3lPKTLELeN11W5zN2fxsvFJaZNXW4HwejTwNjTwPjTwMTT
wOTTwFQMDPPM5ivwWMoayxLzjX8HR2KD07PeAr+Bc7A5rVajH0ajfLeD+An5eA8McIn7dhf7
fA1s8uW0ubk+5oev17t8sywu6ehVM/H5Dn5tvgPj73+7zlff8u+H6yadLuAqTrsS5GiKKhLY
/xpU1WrlNmTAAbsETh29AmacLhduk+8Sft3tl5vj1ym0/3V9uLncbuCRa3cCDR+2iyP6SKed
78xmvbxuOfPSPR292m53h/b7apuX1zAUJNAlwwa2692xewJNlvt5OQU3b7u/LtDtujRuPCDI
JYQkN9er6rZaXYLvP3pVJyG9hqfu4ehVsd0ctjAz4JYCpirfr77XI8Ann8iYgpeHo+y913t6
e5NfAsI1eKqv9t9Gr+b7fFN8uYRA5fQ7ynO1unD/Tg677XHCCDWYPpxQDrBvP3z45frvP7/5
6f3lxe7rzYUDuqg1xATwlNDkYnkzOYC0IRBAX9wUxURfQKhbGa4WQvGyZMVizqktKmPySuSq
EgvDwV2uVHFxu0ak/5qIKVVTMsEgXk1uGvAw3XDGq/1i2po5oC9w1x//9L+g+K7++uv//TGb
1KyWwbP629Vf4PHo/wFlT7hhC2YBAA==

--3kvqdadyjkd4topo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-quantal-vp-13:20180410070827:x86_64-randconfig-s3-04100201:4.16.0-02286-ge71e836:1"

#!/bin/bash

kernel=$1
initrd=quantal-core-x86_64.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/quantal/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu kvm64
	-kernel $kernel
	-initrd $initrd
	-m 512
	-smp 2
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

--3kvqdadyjkd4topo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.16.0-02286-ge71e836"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 4.16.0 Kernel Configuration
#
CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_CONSTRUCTORS=y
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
CONFIG_KERNEL_XZ=y
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SWAP is not set
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
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
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set

#
# RCU Subsystem
#
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
CONFIG_BLK_CGROUP=y
CONFIG_DEBUG_BLK_CGROUP=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
CONFIG_RT_GROUP_SCHED=y
# CONFIG_CGROUP_PIDS is not set
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
# CONFIG_CGROUP_HUGETLB is not set
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
CONFIG_CGROUP_DEBUG=y
CONFIG_SOCK_CGROUP_DATA=y
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
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
# CONFIG_PCSPKR_PLATFORM is not set
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
CONFIG_ADVISE_SYSCALLS=y
# CONFIG_MEMBARRIER is not set
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
# CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_USERFAULTFD=y
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
# CONFIG_COMPAT_BRK is not set
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SYSTEM_DATA_VERIFICATION is not set
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_OPROFILE=y
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_UPROBES=y
# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
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
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
CONFIG_GCC_PLUGIN_SANCOV=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
CONFIG_HAVE_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR_NONE is not set
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
CONFIG_CC_STACKPROTECTOR_AUTO=y
CONFIG_THIN_ARCHIVES=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
# CONFIG_HAVE_ARCH_HASH is not set
# CONFIG_ISA_BUS_API is not set
# CONFIG_CPU_NO_EFFICIENT_FFS is not set
CONFIG_HAVE_ARCH_VMAP_STACK=y
# CONFIG_VMAP_STACK is not set
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX is not set
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
CONFIG_REFCOUNT_FULL=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_GCOV_PROFILE_ALL is not set
# CONFIG_GCOV_FORMAT_AUTODETECT is not set
# CONFIG_GCOV_FORMAT_3_4 is not set
CONFIG_GCOV_FORMAT_4_7=y
# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
# CONFIG_MODULES is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
# CONFIG_BLK_DEV_INTEGRITY is not set
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_DEV_THROTTLING is not set
CONFIG_BLK_CMDLINE_PARSER=y
CONFIG_BLK_WBT=y
# CONFIG_BLK_WBT_SQ is not set
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_DEBUG_FS is not set
CONFIG_BLK_SED_OPAL=y

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_CFQ_GROUP_IOSCHED=y
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"
# CONFIG_MQ_IOSCHED_DEADLINE is not set
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
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
# CONFIG_ZONE_DMA is not set
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_X2APIC is not set
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
# CONFIG_INTEL_RDT is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
CONFIG_IOSF_MBI_DEBUG=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
CONFIG_NO_BOOTMEM=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_AMD is not set
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
# CONFIG_DMI is not set
# CONFIG_CALGARY_IOMMU is not set
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_UP_LATE_INIT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
# CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
# CONFIG_VM86 is not set
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=y
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=y
# CONFIG_X86_5LEVEL is not set
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_GENERIC_GUP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_NEED_PER_CPU_KM=y
CONFIG_CLEANCACHE=y
# CONFIG_CMA is not set
# CONFIG_MEM_SOFT_DIRTY is not set
# CONFIG_ZPOOL is not set
# CONFIG_ZBUD is not set
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_ZONE_DEVICE=y
CONFIG_ZONE_DEVICE=y
CONFIG_ARCH_HAS_HMM=y
CONFIG_MIGRATE_VMA_HELPER=y
CONFIG_HMM=y
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
# CONFIG_DEVICE_PUBLIC is not set
CONFIG_FRAME_VECTOR=y
CONFIG_PERCPU_STATS=y
CONFIG_GUP_BENCHMARK=y
# CONFIG_X86_PMEM_LEGACY is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
# CONFIG_ARCH_RANDOM is not set
# CONFIG_X86_SMAP is not set
CONFIG_X86_INTEL_UMIP=y
# CONFIG_X86_INTEL_MPX is not set
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
# CONFIG_EFI is not set
# CONFIG_SECCOMP is not set
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
# CONFIG_SCHED_HRTICK is not set
# CONFIG_KEXEC is not set
CONFIG_KEXEC_FILE=y
# CONFIG_KEXEC_VERIFY_SIG is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_PM_SLEEP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
# CONFIG_ACPI_NFIT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_DPTF_POWER is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
# CONFIG_SFI is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set

#
# CPU frequency scaling drivers
#
# CONFIG_X86_INTEL_PSTATE is not set
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_P4_CLOCKMOD is not set

#
# shared options
#
# CONFIG_X86_SPEEDSTEP_LIB is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
# CONFIG_CPU_IDLE_GOV_MENU is not set
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
CONFIG_INTEL_IDLE=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_MMCONFIG is not set
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_CNB20LE_QUIRK=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_BUS_ADDR_T_64BIT=y
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
CONFIG_PCI_STUB=y
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# Cadence PCIe controllers support
#

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
CONFIG_PCIE_DW_PLAT=y

#
# PCI host controller drivers
#
CONFIG_VMD=y

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
# CONFIG_ISA_BUS is not set
# CONFIG_ISA_DMA_API is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set
# CONFIG_X86_SYSFB is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_HAVE_AOUT is not set
CONFIG_BINFMT_MISC=y
# CONFIG_COREDUMP is not set
# CONFIG_IA32_EMULATION is not set
CONFIG_X86_X32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=y
CONFIG_UNIX=y
CONFIG_UNIX_DIAG=y
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
# CONFIG_XFRM_USER is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
# CONFIG_XFRM_STATISTICS is not set
CONFIG_NET_KEY=y
CONFIG_NET_KEY_MIGRATE=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_UDP_TUNNEL is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
CONFIG_INET6_XFRM_MODE_TRANSPORT=y
CONFIG_INET6_XFRM_MODE_TUNNEL=y
CONFIG_INET6_XFRM_MODE_BEET=y
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_FOU is not set
# CONFIG_IPV6_FOU_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
CONFIG_ATM=y
# CONFIG_ATM_CLIP is not set
CONFIG_ATM_LANE=y
# CONFIG_ATM_MPOA is not set
# CONFIG_ATM_BR2684 is not set
# CONFIG_L2TP is not set
CONFIG_STP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
CONFIG_DECNET=y
CONFIG_DECNET_ROUTER=y
CONFIG_LLC=y
CONFIG_LLC2=y
CONFIG_ATALK=y
# CONFIG_DEV_APPLETALK is not set
CONFIG_X25=y
CONFIG_LAPB=y
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
CONFIG_DCB=y
CONFIG_BATMAN_ADV=y
# CONFIG_BATMAN_ADV_BATMAN_V is not set
CONFIG_BATMAN_ADV_BLA=y
# CONFIG_BATMAN_ADV_DAT is not set
CONFIG_BATMAN_ADV_NC=y
# CONFIG_BATMAN_ADV_MCAST is not set
CONFIG_BATMAN_ADV_DEBUGFS=y
CONFIG_BATMAN_ADV_DEBUG=y
# CONFIG_OPENVSWITCH is not set
CONFIG_VSOCKETS=y
CONFIG_VSOCKETS_DIAG=y
# CONFIG_VMWARE_VMCI_VSOCKETS is not set
CONFIG_VIRTIO_VSOCKETS=y
CONFIG_VIRTIO_VSOCKETS_COMMON=y
CONFIG_NETLINK_DIAG=y
CONFIG_MPLS=y
# CONFIG_NET_MPLS_GSO is not set
# CONFIG_MPLS_ROUTING is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
CONFIG_CGROUP_NET_PRIO=y
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_STREAM_PARSER is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=y
# CONFIG_AX25_DAMA_SLAVE is not set
CONFIG_NETROM=y
CONFIG_ROSE=y

#
# AX.25 network device drivers
#
CONFIG_MKISS=y
CONFIG_6PACK=y
CONFIG_BPQETHER=y
# CONFIG_BAYCOM_SER_FDX is not set
# CONFIG_BAYCOM_SER_HDX is not set
CONFIG_YAM=y
CONFIG_CAN=y
CONFIG_CAN_RAW=y
CONFIG_CAN_BCM=y
CONFIG_CAN_GW=y

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=y
CONFIG_CAN_VXCAN=y
CONFIG_CAN_SLCAN=y
# CONFIG_CAN_DEV is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_BT=y
CONFIG_BT_BREDR=y
# CONFIG_BT_RFCOMM is not set
# CONFIG_BT_BNEP is not set
# CONFIG_BT_HIDP is not set
CONFIG_BT_HS=y
# CONFIG_BT_LE is not set
CONFIG_BT_LEDS=y
CONFIG_BT_SELFTEST=y
# CONFIG_BT_DEBUGFS is not set

#
# Bluetooth device drivers
#
# CONFIG_BT_HCIBTUSB is not set
# CONFIG_BT_HCIBTSDIO is not set
# CONFIG_BT_HCIUART is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBFUSB is not set
# CONFIG_BT_HCIVHCI is not set
# CONFIG_BT_MRVL is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_STREAM_PARSER is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set
# CONFIG_LIB80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=y
CONFIG_RFKILL_LEDS=y
# CONFIG_RFKILL_INPUT is not set
CONFIG_RFKILL_GPIO=y
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_NET_9P_DEBUG=y
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
CONFIG_NFC=y
CONFIG_NFC_DIGITAL=y
CONFIG_NFC_NCI=y
# CONFIG_NFC_NCI_SPI is not set
# CONFIG_NFC_NCI_UART is not set
CONFIG_NFC_HCI=y
CONFIG_NFC_SHDLC=y

#
# Near Field Communication (NFC) devices
#
# CONFIG_NFC_TRF7970A is not set
# CONFIG_NFC_MEI_PHY is not set
CONFIG_NFC_SIM=y
# CONFIG_NFC_PORT100 is not set
CONFIG_NFC_FDP=y
CONFIG_NFC_FDP_I2C=y
# CONFIG_NFC_PN544_I2C is not set
CONFIG_NFC_PN533=y
# CONFIG_NFC_PN533_USB is not set
CONFIG_NFC_PN533_I2C=y
CONFIG_NFC_MICROREAD=y
CONFIG_NFC_MICROREAD_I2C=y
# CONFIG_NFC_MRVL_USB is not set
# CONFIG_NFC_ST21NFCA_I2C is not set
CONFIG_NFC_ST_NCI=y
# CONFIG_NFC_ST_NCI_I2C is not set
CONFIG_NFC_ST_NCI_SPI=y
CONFIG_NFC_NXP_NCI=y
CONFIG_NFC_NXP_NCI_I2C=y
CONFIG_NFC_S3FWRN5=y
CONFIG_NFC_S3FWRN5_I2C=y
# CONFIG_NFC_ST95HF is not set
# CONFIG_PSAMPLE is not set
CONFIG_NET_IFE=y
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_DEVLINK=y
CONFIG_MAY_USE_DEVLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set

#
# Bus devices
#
CONFIG_CONNECTOR=y
# CONFIG_PROC_EVENTS is not set
CONFIG_MTD=y
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
CONFIG_MTD_AR7_PARTS=y

#
# Partition parsers
#

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=y
# CONFIG_FTL is not set
CONFIG_NFTL=y
# CONFIG_NFTL_RW is not set
CONFIG_INFTL=y
CONFIG_RFD_FTL=y
# CONFIG_SSFDC is not set
CONFIG_SM_FTL=y
CONFIG_MTD_OOPS=y
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
CONFIG_MTD_CFI_NOSWAP=y
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_GEOMETRY is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
# CONFIG_MTD_OTP is not set
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_CFI_AMDSTD=y
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
CONFIG_MTD_ROM=y
CONFIG_MTD_ABSENT=y

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=y
# CONFIG_MTD_PHYSMAP_COMPAT is not set
CONFIG_MTD_SBC_GXX=y
CONFIG_MTD_AMD76XROM=y
# CONFIG_MTD_ICHXROM is not set
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
# CONFIG_MTD_L440GX is not set
# CONFIG_MTD_PCI is not set
CONFIG_MTD_GPIO_ADDR=y
CONFIG_MTD_INTEL_VR_NOR=y
CONFIG_MTD_PLATRAM=y
# CONFIG_MTD_LATCH_ADDR is not set

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=y
CONFIG_MTD_PMC551_BUGFIX=y
# CONFIG_MTD_PMC551_DEBUG is not set
CONFIG_MTD_DATAFLASH=y
# CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
# CONFIG_MTD_DATAFLASH_OTP is not set
CONFIG_MTD_M25P80=y
# CONFIG_MTD_MCHP23K256 is not set
CONFIG_MTD_SST25L=y
# CONFIG_MTD_SLRAM is not set
CONFIG_MTD_PHRAM=y
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
CONFIG_MTD_NAND_ECC=y
# CONFIG_MTD_NAND_ECC_SMC is not set
# CONFIG_MTD_NAND is not set
CONFIG_MTD_ONENAND=y
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
CONFIG_MTD_ONENAND_GENERIC=y
CONFIG_MTD_ONENAND_OTP=y
# CONFIG_MTD_ONENAND_2X_PROGRAM is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
CONFIG_MTD_SPI_NOR=y
# CONFIG_MTD_MT81xx_NOR is not set
CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
CONFIG_SPI_INTEL_SPI=y
CONFIG_SPI_INTEL_SPI_PCI=y
# CONFIG_SPI_INTEL_SPI_PLATFORM is not set
CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
CONFIG_NVME_TARGET=y
# CONFIG_NVME_TARGET_LOOP is not set
# CONFIG_NVME_TARGET_FC is not set

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
CONFIG_AD525X_DPOT_SPI=y
CONFIG_DUMMY_IRQ=y
CONFIG_IBM_ASM=y
CONFIG_PHANTOM=y
# CONFIG_SGI_IOC4 is not set
CONFIG_TIFM_CORE=y
CONFIG_TIFM_7XX1=y
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_VMWARE_BALLOON is not set
CONFIG_USB_SWITCH_FSA9480=y
# CONFIG_LATTICE_ECP3_CONFIG is not set
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_MISC_RTSX is not set
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_93XX46=y
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_CB710_CORE=y
CONFIG_CB710_DEBUG=y
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=y
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=y
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
CONFIG_VMWARE_VMCI=y

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
CONFIG_INTEL_MIC_BUS=y

#
# SCIF Bus Driver
#
CONFIG_SCIF_BUS=y

#
# VOP Bus Driver
#
CONFIG_VOP_BUS=y

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#
# CONFIG_SCIF is not set

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
CONFIG_VOP=y
CONFIG_VHOST_RING=y
# CONFIG_GENWQE is not set
CONFIG_ECHO=y
# CONFIG_CXL_BASE is not set
# CONFIG_CXL_AFU_DRIVER_OPS is not set
# CONFIG_CXL_LIB is not set
# CONFIG_OCXL_BASE is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
# CONFIG_SCSI is not set
# CONFIG_SCSI_DMA is not set
# CONFIG_SCSI_NETLINK is not set
# CONFIG_ATA is not set
# CONFIG_MD is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
CONFIG_FIREWIRE_OHCI=y
# CONFIG_FIREWIRE_NET is not set
CONFIG_FIREWIRE_NOSY=y
CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_NTB_NETDEV is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
# CONFIG_VSOCKMON is not set
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

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
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
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
# CONFIG_AMD_XGBE_HAVE_ECC is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
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
CONFIG_NET_VENDOR_EXAR=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
# CONFIG_I40EVF is not set
# CONFIG_FM10K is not set
CONFIG_NET_VENDOR_I825XX=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX4_CORE is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
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
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SMSC=y
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
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_MDIO_BUS is not set
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_IPHETH is not set
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

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_ISDN is not set
CONFIG_NVM=y
# CONFIG_NVM_DEBUG is not set
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
# CONFIG_INPUT_SPARSEKMAP is not set
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
# CONFIG_INPUT_EVDEV is not set
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5520 is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
CONFIG_JOYSTICK_A3D=y
CONFIG_JOYSTICK_ADI=y
# CONFIG_JOYSTICK_COBRA is not set
CONFIG_JOYSTICK_GF2K=y
CONFIG_JOYSTICK_GRIP=y
CONFIG_JOYSTICK_GRIP_MP=y
# CONFIG_JOYSTICK_GUILLEMOT is not set
CONFIG_JOYSTICK_INTERACT=y
CONFIG_JOYSTICK_SIDEWINDER=y
# CONFIG_JOYSTICK_TMDC is not set
CONFIG_JOYSTICK_IFORCE=y
# CONFIG_JOYSTICK_IFORCE_USB is not set
# CONFIG_JOYSTICK_IFORCE_232 is not set
CONFIG_JOYSTICK_WARRIOR=y
CONFIG_JOYSTICK_MAGELLAN=y
# CONFIG_JOYSTICK_SPACEORB is not set
CONFIG_JOYSTICK_SPACEBALL=y
CONFIG_JOYSTICK_STINGER=y
# CONFIG_JOYSTICK_TWIDJOY is not set
CONFIG_JOYSTICK_ZHENHUA=y
# CONFIG_JOYSTICK_AS5011 is not set
CONFIG_JOYSTICK_JOYDUMP=y
CONFIG_JOYSTICK_XPAD=y
CONFIG_JOYSTICK_XPAD_FF=y
# CONFIG_JOYSTICK_XPAD_LEDS is not set
# CONFIG_JOYSTICK_PSXPAD_SPI is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
CONFIG_RMI4_SPI=y
CONFIG_RMI4_SMB=y
# CONFIG_RMI4_F03 is not set
CONFIG_RMI4_2D_SENSOR=y
# CONFIG_RMI4_F11 is not set
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F54 is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_GPIO_PS2=y
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=y
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
CONFIG_MOXA_INTELLIO=y
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINKMP=y
# CONFIG_SYNCLINK_GT is not set
CONFIG_NOZOMI=y
CONFIG_ISI=y
CONFIG_N_HDLC=y
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
CONFIG_DEVMEM=y
CONFIG_DEVKMEM=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_DMA is not set
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_MEN_MCB=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
# CONFIG_SERIAL_8250_RSA is not set
# CONFIG_SERIAL_8250_FSL is not set
CONFIG_SERIAL_8250_DW=y
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_MAX3100=y
CONFIG_SERIAL_MAX310X=y
CONFIG_SERIAL_UARTLITE=y
CONFIG_SERIAL_UARTLITE_CONSOLE=y
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=y
# CONFIG_SERIAL_SCCNXP is not set
CONFIG_SERIAL_SC16IS7XX=y
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
# CONFIG_SERIAL_SC16IS7XX_SPI is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=y
# CONFIG_SERIAL_ARC_CONSOLE is not set
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=y
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
# CONFIG_SERIAL_MEN_Z135 is not set
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
CONFIG_TTY_PRINTK=y
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_PROC_INTERFACE=y
CONFIG_IPMI_PANIC_EVENT=y
# CONFIG_IPMI_PANIC_STRING is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
CONFIG_IPMI_WATCHDOG=y
CONFIG_IPMI_POWEROFF=y
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=y
CONFIG_R3964=y
CONFIG_APPLICOM=y
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set
# CONFIG_TCG_TPM is not set
CONFIG_TELCLOCK=y
CONFIG_DEVPORT=y
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_PCIE=y

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
CONFIG_I2C_MUX_REG=y
# CONFIG_I2C_MUX_MLXCPLD is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=y
# CONFIG_I2C_ALI1563 is not set
CONFIG_I2C_ALI15X3=y
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
CONFIG_I2C_ISCH=y
# CONFIG_I2C_ISMT is not set
CONFIG_I2C_PIIX4=y
# CONFIG_I2C_NFORCE2 is not set
CONFIG_I2C_SIS5595=y
CONFIG_I2C_SIS630=y
CONFIG_I2C_SIS96X=y
# CONFIG_I2C_VIA is not set
CONFIG_I2C_VIAPRO=y

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PCI=y
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
CONFIG_I2C_KEMPLD=y
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_PXA_PCI is not set
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
CONFIG_I2C_DLN2=y
CONFIG_I2C_PARPORT_LIGHT=y
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
CONFIG_I2C_TAOS_EVM=y
CONFIG_I2C_TINY_USB=y
CONFIG_I2C_VIPERBOARD=y

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=y
CONFIG_I2C_CROS_EC_TUNNEL=y
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
CONFIG_SPI_AXI_SPI_ENGINE=y
CONFIG_SPI_BITBANG=y
CONFIG_SPI_CADENCE=y
CONFIG_SPI_DESIGNWARE=y
CONFIG_SPI_DW_PCI=y
# CONFIG_SPI_DW_MMIO is not set
# CONFIG_SPI_DLN2 is not set
CONFIG_SPI_GPIO=y
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_PXA2XX_PCI is not set
CONFIG_SPI_ROCKCHIP=y
# CONFIG_SPI_SC18IS602 is not set
CONFIG_SPI_XCOMM=y
CONFIG_SPI_XILINX=y
CONFIG_SPI_ZYNQMP_GQSPI=y

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
CONFIG_SPI_TLE62X0=y
CONFIG_SPI_SLAVE=y
CONFIG_SPI_SLAVE_TIME=y
# CONFIG_SPI_SLAVE_SYSTEM_CONTROL is not set
CONFIG_SPMI=y
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=y
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
CONFIG_NTP_PPS=y

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
CONFIG_PPS_CLIENT_LDISC=y
# CONFIG_PPS_CLIENT_GPIO is not set

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
CONFIG_PTP_1588_CLOCK_KVM=y
CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=y
CONFIG_PINCTRL_MCP23S08=y
# CONFIG_PINCTRL_SX150X is not set
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
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_ICH=y
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=y
# CONFIG_GPIO_MOCKUP is not set
CONFIG_GPIO_VX855=y

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
CONFIG_GPIO_ADP5588_IRQ=y
CONFIG_GPIO_MAX7300=y
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ADP5520 is not set
CONFIG_GPIO_ARIZONA=y
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_DA9052=y
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_DLN2=y
CONFIG_GPIO_JANZ_TTL=y
# CONFIG_GPIO_KEMPLD is not set
CONFIG_GPIO_LP3943=y
CONFIG_GPIO_LP873X=y
CONFIG_GPIO_TPS65086=y
CONFIG_GPIO_TPS6586X=y
# CONFIG_GPIO_TPS65912 is not set
# CONFIG_GPIO_TWL4030 is not set
CONFIG_GPIO_UCB1400=y
CONFIG_GPIO_WM831X=y
CONFIG_GPIO_WM8350=y

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
# CONFIG_GPIO_BT8XX is not set
CONFIG_GPIO_ML_IOH=y
# CONFIG_GPIO_PCI_IDIO_16 is not set
CONFIG_GPIO_PCIE_IDIO_24=y
# CONFIG_GPIO_RDC321X is not set

#
# SPI GPIO expanders
#
CONFIG_GPIO_MAX3191X=y
CONFIG_GPIO_MAX7301=y
# CONFIG_GPIO_MC33880 is not set
CONFIG_GPIO_PISOSR=y
CONFIG_GPIO_XRA1403=y

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=y
CONFIG_W1=y
# CONFIG_W1_CON is not set

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
CONFIG_W1_MASTER_DS2490=y
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_DS1WM=y
# CONFIG_W1_MASTER_GPIO is not set

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=y
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
CONFIG_W1_SLAVE_DS2431=y
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=y
# CONFIG_W1_SLAVE_DS2760 is not set
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=y
# CONFIG_POWER_AVS is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_WM831X_BACKUP is not set
# CONFIG_WM831X_POWER is not set
CONFIG_WM8350_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_DS2780=y
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=y
CONFIG_BATTERY_BQ27XXX=y
# CONFIG_BATTERY_BQ27XXX_I2C is not set
CONFIG_BATTERY_BQ27XXX_HDQ=y
CONFIG_BATTERY_DA9030=y
CONFIG_BATTERY_DA9052=y
CONFIG_BATTERY_DA9150=y
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_CHARGER_PCF50633=y
CONFIG_CHARGER_ISP1704=y
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LTC3651=y
CONFIG_CHARGER_MAX14577=y
# CONFIG_CHARGER_MAX77693 is not set
CONFIG_CHARGER_MAX8997=y
CONFIG_CHARGER_MAX8998=y
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_SMB347 is not set
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_RT5033=y
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_AD7314=y
CONFIG_SENSORS_AD7414=y
CONFIG_SENSORS_AD7418=y
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_ADM1025=y
# CONFIG_SENSORS_ADM1026 is not set
CONFIG_SENSORS_ADM1029=y
# CONFIG_SENSORS_ADM1031 is not set
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_ASC7621=y
# CONFIG_SENSORS_K8TEMP is not set
CONFIG_SENSORS_K10TEMP=y
CONFIG_SENSORS_APPLESMC=y
CONFIG_SENSORS_ASB100=y
# CONFIG_SENSORS_ASPEED is not set
# CONFIG_SENSORS_ATXP1 is not set
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
CONFIG_SENSORS_DA9052_ADC=y
# CONFIG_SENSORS_DA9055 is not set
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_MC13783_ADC=y
CONFIG_SENSORS_FSCHMD=y
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=y
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IBMAEM=y
# CONFIG_SENSORS_IBMPEX is not set
CONFIG_SENSORS_I5500=y
# CONFIG_SENSORS_CORETEMP is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=y
# CONFIG_SENSORS_LTC2945 is not set
CONFIG_SENSORS_LTC2990=y
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=y
# CONFIG_SENSORS_LTC4245 is not set
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX1111=y
# CONFIG_SENSORS_MAX16065 is not set
CONFIG_SENSORS_MAX1619=y
# CONFIG_SENSORS_MAX1668 is not set
CONFIG_SENSORS_MAX197=y
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX6621 is not set
# CONFIG_SENSORS_MAX6639 is not set
CONFIG_SENSORS_MAX6642=y
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_MENF21BMC_HWMON is not set
CONFIG_SENSORS_ADCXX=y
CONFIG_SENSORS_LM63=y
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=y
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775=y
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
CONFIG_SENSORS_PCF8591=y
CONFIG_PMBUS=y
# CONFIG_SENSORS_PMBUS is not set
# CONFIG_SENSORS_ADM1275 is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
CONFIG_SENSORS_IR35221=y
# CONFIG_SENSORS_LM25066 is not set
CONFIG_SENSORS_LTC2978=y
# CONFIG_SENSORS_LTC2978_REGULATOR is not set
CONFIG_SENSORS_LTC3815=y
CONFIG_SENSORS_MAX16064=y
# CONFIG_SENSORS_MAX20751 is not set
CONFIG_SENSORS_MAX31785=y
CONFIG_SENSORS_MAX34440=y
CONFIG_SENSORS_MAX8688=y
CONFIG_SENSORS_TPS40422=y
CONFIG_SENSORS_TPS53679=y
# CONFIG_SENSORS_UCD9000 is not set
# CONFIG_SENSORS_UCD9200 is not set
CONFIG_SENSORS_ZL6100=y
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHT3x=y
CONFIG_SENSORS_SHTC1=y
CONFIG_SENSORS_SIS5595=y
CONFIG_SENSORS_DME1737=y
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
# CONFIG_SENSORS_SCH5636 is not set
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=y
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS1015=y
CONFIG_SENSORS_ADS7828=y
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=y
# CONFIG_SENSORS_INA209 is not set
CONFIG_SENSORS_INA2XX=y
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
CONFIG_SENSORS_TMP103=y
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=y
# CONFIG_SENSORS_TMP421 is not set
CONFIG_SENSORS_VIA_CPUTEMP=y
CONFIG_SENSORS_VIA686A=y
CONFIG_SENSORS_VT1211=y
CONFIG_SENSORS_VT8231=y
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
CONFIG_SENSORS_W83795=y
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y
# CONFIG_SENSORS_WM831X is not set
CONFIG_SENSORS_WM8350=y

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR=y
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
# CONFIG_CLOCK_THERMAL is not set
CONFIG_DEVFREQ_THERMAL=y
CONFIG_THERMAL_EMULATION=y
CONFIG_INTEL_POWERCLAMP=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
CONFIG_INTEL_PCH_THERMAL=y
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_WATCHDOG_NOWAYOUT=y
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
# CONFIG_DA9052_WATCHDOG is not set
# CONFIG_DA9055_WATCHDOG is not set
CONFIG_DA9063_WATCHDOG=y
# CONFIG_MENF21BMC_WATCHDOG is not set
# CONFIG_WDAT_WDT is not set
# CONFIG_WM831X_WATCHDOG is not set
CONFIG_WM8350_WATCHDOG=y
CONFIG_XILINX_WATCHDOG=y
CONFIG_ZIIRAVE_WATCHDOG=y
CONFIG_RAVE_SP_WATCHDOG=y
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_TWL4030_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
CONFIG_RETU_WATCHDOG=y
# CONFIG_ACQUIRE_WDT is not set
CONFIG_ADVANTECH_WDT=y
CONFIG_ALIM1535_WDT=y
CONFIG_ALIM7101_WDT=y
CONFIG_F71808E_WDT=y
# CONFIG_SP5100_TCO is not set
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
CONFIG_IBMASR=y
CONFIG_WAFER_WDT=y
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=y
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=y
CONFIG_IT87_WDT=y
# CONFIG_HP_WATCHDOG is not set
CONFIG_KEMPLD_WDT=y
CONFIG_SC1200_WDT=y
CONFIG_PC87413_WDT=y
CONFIG_NV_TCO=y
CONFIG_60XX_WDT=y
CONFIG_CPU5_WDT=y
# CONFIG_SMSC_SCH311X_WDT is not set
CONFIG_SMSC37B787_WDT=y
CONFIG_VIA_WDT=y
CONFIG_W83627HF_WDT=y
# CONFIG_W83877F_WDT is not set
CONFIG_W83977F_WDT=y
CONFIG_MACHZ_WDT=y
CONFIG_SBC_EPX_C3_WATCHDOG=y
CONFIG_INTEL_MEI_WDT=y
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
CONFIG_MEN_A21_WDT=y

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=y
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
# CONFIG_SSB_B43_PCI_BRIDGE is not set
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
# CONFIG_SSB_SILENT is not set
CONFIG_SSB_DEBUG=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
CONFIG_PMIC_ADP5520=y
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
CONFIG_MFD_BD9571MWV=y
# CONFIG_MFD_AXP20X_I2C is not set
CONFIG_MFD_CROS_EC=y
CONFIG_MFD_CROS_EC_I2C=y
CONFIG_MFD_CROS_EC_SPI=y
# CONFIG_MFD_CROS_EC_CHARDEV is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_DLN2=y
CONFIG_MFD_MC13XXX=y
# CONFIG_MFD_MC13XXX_SPI is not set
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_HTC_PASIC3=y
# CONFIG_HTC_I2CPLD is not set
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
CONFIG_MFD_INTEL_LPSS_PCI=y
CONFIG_MFD_JANZ_CMODIO=y
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77693=y
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
CONFIG_EZX_PCAP=y
CONFIG_MFD_VIPERBOARD=y
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
# CONFIG_PCF50633_GPIO is not set
CONFIG_UCB1400_CORE=y
CONFIG_MFD_RDC321X=y
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=y
CONFIG_MFD_SMSC=y
# CONFIG_ABX500_CORE is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_MFD_TPS65912_SPI is not set
CONFIG_MFD_TPS80031=y
CONFIG_TWL4030_CORE=y
# CONFIG_MFD_TWL4030_AUDIO is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TMIO is not set
CONFIG_MFD_VX855=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_CS47L24 is not set
# CONFIG_MFD_WM5102 is not set
# CONFIG_MFD_WM5110 is not set
CONFIG_MFD_WM8997=y
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM831X_SPI=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
# CONFIG_MFD_WM8994 is not set
CONFIG_RAVE_SP_CORE=y
CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
# CONFIG_REGULATOR_88PM800 is not set
CONFIG_REGULATOR_ACT8865=y
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_ANATOP=y
# CONFIG_REGULATOR_BD9571MWV is not set
# CONFIG_REGULATOR_DA903X is not set
CONFIG_REGULATOR_DA9052=y
CONFIG_REGULATOR_DA9055=y
CONFIG_REGULATOR_DA9063=y
CONFIG_REGULATOR_DA9210=y
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=y
# CONFIG_REGULATOR_GPIO is not set
# CONFIG_REGULATOR_ISL9305 is not set
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LM363X=y
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
# CONFIG_REGULATOR_LP872X is not set
CONFIG_REGULATOR_LP8755=y
# CONFIG_REGULATOR_LP8788 is not set
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX14577=y
# CONFIG_REGULATOR_MAX1586 is not set
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8907=y
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8997=y
CONFIG_REGULATOR_MAX8998=y
# CONFIG_REGULATOR_MAX77693 is not set
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MT6311=y
# CONFIG_REGULATOR_MT6323 is not set
CONFIG_REGULATOR_MT6397=y
CONFIG_REGULATOR_PCAP=y
CONFIG_REGULATOR_PCF50633=y
CONFIG_REGULATOR_PFUZE100=y
# CONFIG_REGULATOR_PV88060 is not set
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=y
# CONFIG_REGULATOR_QCOM_SPMI is not set
CONFIG_REGULATOR_RT5033=y
# CONFIG_REGULATOR_S2MPA01 is not set
# CONFIG_REGULATOR_S2MPS11 is not set
# CONFIG_REGULATOR_S5M8767 is not set
CONFIG_REGULATOR_SKY81452=y
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=y
CONFIG_REGULATOR_TPS62360=y
CONFIG_REGULATOR_TPS65023=y
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65086=y
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS6524X=y
# CONFIG_REGULATOR_TPS6586X is not set
CONFIG_REGULATOR_TPS65912=y
# CONFIG_REGULATOR_TPS80031 is not set
CONFIG_REGULATOR_TWL4030=y
# CONFIG_REGULATOR_WM831X is not set
# CONFIG_REGULATOR_WM8350 is not set
# CONFIG_RC_CORE is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
CONFIG_MEDIA_SDR_SUPPORT=y
# CONFIG_MEDIA_CEC_SUPPORT is not set
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_V4L2=y
# CONFIG_VIDEO_ADV_DEBUG is not set
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_VIDEO_PCI_SKELETON=y
CONFIG_VIDEO_TUNER=y
CONFIG_VIDEOBUF_GEN=y
CONFIG_VIDEOBUF_DMA_SG=y
# CONFIG_TTPCI_EEPROM is not set

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW5864 is not set
CONFIG_VIDEO_TW68=y
# CONFIG_VIDEO_TW686X is not set
CONFIG_VIDEO_ZORAN=y
# CONFIG_VIDEO_ZORAN_DC30 is not set
CONFIG_VIDEO_ZORAN_ZR36060=y
# CONFIG_VIDEO_ZORAN_BUZ is not set
CONFIG_VIDEO_ZORAN_DC10=y
# CONFIG_VIDEO_ZORAN_LML33 is not set
CONFIG_VIDEO_ZORAN_LML33R10=y
CONFIG_VIDEO_ZORAN_AVS6EYES=y

#
# Media capture/analog TV support
#
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
CONFIG_VIDEO_HEXIUM_ORION=y
CONFIG_VIDEO_MXB=y
CONFIG_VIDEO_DT3155=y

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX25821=y
CONFIG_VIDEO_CX25821_ALSA=y
# CONFIG_VIDEO_SAA7134 is not set
CONFIG_V4L_PLATFORM_DRIVERS=y
CONFIG_VIDEO_CAFE_CCIC=y
CONFIG_SOC_CAMERA=y
CONFIG_SOC_CAMERA_PLATFORM=y
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
CONFIG_SDR_PLATFORM_DRIVERS=y

#
# Supported MMC/SDIO adapters
#
# CONFIG_CYPRESS_FIRMWARE is not set
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_VIDEOBUF2_DMA_SG=y
CONFIG_VIDEO_SAA7146=y
CONFIG_VIDEO_SAA7146_VV=y

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TDA9840=y
CONFIG_VIDEO_TEA6415C=y
CONFIG_VIDEO_TEA6420=y

#
# RDS decoders
#

#
# Video decoders
#
CONFIG_VIDEO_BT856=y
CONFIG_VIDEO_BT866=y
CONFIG_VIDEO_KS0127=y
CONFIG_VIDEO_SAA7110=y
CONFIG_VIDEO_SAA711X=y

#
# Video and audio decoders
#

#
# Video encoders
#
CONFIG_VIDEO_ADV7170=y
CONFIG_VIDEO_ADV7175=y

#
# Camera sensor devices
#
CONFIG_VIDEO_OV7670=y

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
# soc_camera sensor drivers
#
CONFIG_SOC_CAMERA_IMX074=y
CONFIG_SOC_CAMERA_MT9M001=y
# CONFIG_SOC_CAMERA_MT9M111 is not set
CONFIG_SOC_CAMERA_MT9T031=y
CONFIG_SOC_CAMERA_MT9T112=y
CONFIG_SOC_CAMERA_MT9V022=y
# CONFIG_SOC_CAMERA_OV5642 is not set
CONFIG_SOC_CAMERA_OV772X=y
CONFIG_SOC_CAMERA_OV9640=y
CONFIG_SOC_CAMERA_OV9740=y
CONFIG_SOC_CAMERA_RJ54N1=y
CONFIG_SOC_CAMERA_TW9910=y
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
CONFIG_AGP=y
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_SIS is not set
CONFIG_AGP_VIA=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
# CONFIG_CHASH is not set
# CONFIG_DRM_LIB_RANDOM is not set

#
# Frame buffer Devices
#
# CONFIG_FB is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
CONFIG_LCD_ILI922X=y
CONFIG_LCD_ILI9320=y
CONFIG_LCD_TDO24M=y
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=y
CONFIG_LCD_S6E63M0=y
CONFIG_LCD_LD9040=y
# CONFIG_LCD_AMS369FG06 is not set
CONFIG_LCD_LMS501KF03=y
# CONFIG_LCD_HX8357 is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
CONFIG_BACKLIGHT_LM3533=y
CONFIG_BACKLIGHT_DA903X=y
# CONFIG_BACKLIGHT_DA9052 is not set
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_PM8941_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_WM831X is not set
# CONFIG_BACKLIGHT_ADP5520 is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_PCF50633=y
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_PANDORA=y
CONFIG_BACKLIGHT_SKY81452=y
# CONFIG_BACKLIGHT_GPIO is not set
CONFIG_BACKLIGHT_LV5207LP=y
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# CONFIG_VGASTATE is not set
CONFIG_SOUND=y
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_SEQ_DEVICE=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
CONFIG_SND_DEBUG=y
# CONFIG_SND_DEBUG_VERBOSE is not set
# CONFIG_SND_PCM_XRUN_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_SEQ_MIDI_EVENT=y
CONFIG_SND_SEQ_MIDI=y
CONFIG_SND_SEQ_MIDI_EMUL=y
CONFIG_SND_SEQ_VIRMIDI=y
CONFIG_SND_MPU401_UART=y
CONFIG_SND_OPL3_LIB=y
CONFIG_SND_OPL3_LIB_SEQ=y
# CONFIG_SND_OPL4_LIB_SEQ is not set
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_DRIVERS=y
CONFIG_SND_DUMMY=y
CONFIG_SND_ALOOP=y
CONFIG_SND_VIRMIDI=y
CONFIG_SND_MTPAV=y
CONFIG_SND_SERIAL_U16550=y
# CONFIG_SND_MPU401 is not set
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=0
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=y
# CONFIG_SND_ASIHPI is not set
CONFIG_SND_ATIIXP=y
CONFIG_SND_ATIIXP_MODEM=y
CONFIG_SND_AU8810=y
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
CONFIG_SND_AW2=y
# CONFIG_SND_BT87X is not set
CONFIG_SND_CA0106=y
CONFIG_SND_CMIPCI=y
CONFIG_SND_OXYGEN_LIB=y
CONFIG_SND_OXYGEN=y
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=y
# CONFIG_SND_CS46XX_NEW_DSP is not set
CONFIG_SND_CTXFI=y
CONFIG_SND_DARLA20=y
CONFIG_SND_GINA20=y
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
CONFIG_SND_GINA24=y
CONFIG_SND_LAYLA24=y
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
CONFIG_SND_ECHO3G=y
CONFIG_SND_INDIGO=y
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
CONFIG_SND_INDIGOIOX=y
CONFIG_SND_INDIGODJX=y
# CONFIG_SND_EMU10K1_SEQ is not set
CONFIG_SND_ENS1370=y
CONFIG_SND_ENS1371=y
CONFIG_SND_FM801=y
CONFIG_SND_HDSP=y

#
# Don't forget to add built-in firmwares for HDSP driver
#
CONFIG_SND_HDSPM=y
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=y
CONFIG_SND_INTEL8X0M=y
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
CONFIG_SND_PCXHR=y
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
CONFIG_SND_RME9652=y
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
CONFIG_SND_YMFPCI=y

#
# HD-Audio
#
CONFIG_SND_HDA=y
CONFIG_SND_HDA_INTEL=y
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=1
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_CODEC_REALTEK=y
CONFIG_SND_HDA_CODEC_ANALOG=y
# CONFIG_SND_HDA_CODEC_SIGMATEL is not set
CONFIG_SND_HDA_CODEC_VIA=y
CONFIG_SND_HDA_CODEC_HDMI=y
CONFIG_SND_HDA_CODEC_CIRRUS=y
CONFIG_SND_HDA_CODEC_CONEXANT=y
CONFIG_SND_HDA_CODEC_CA0110=y
# CONFIG_SND_HDA_CODEC_CA0132 is not set
CONFIG_SND_HDA_CODEC_CMEDIA=y
# CONFIG_SND_HDA_CODEC_SI3054 is not set
CONFIG_SND_HDA_GENERIC=y
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
CONFIG_SND_HDA_CORE=y
CONFIG_SND_HDA_PREALLOC_SIZE=64
CONFIG_SND_SPI=y
# CONFIG_SND_USB is not set
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=y
CONFIG_SND_DICE=y
CONFIG_SND_OXFW=y
# CONFIG_SND_ISIGHT is not set
# CONFIG_SND_FIREWORKS is not set
CONFIG_SND_BEBOB=y
# CONFIG_SND_FIREWIRE_DIGI00X is not set
CONFIG_SND_FIREWIRE_TASCAM=y
CONFIG_SND_FIREWIRE_MOTU=y
CONFIG_SND_FIREFACE=y
# CONFIG_SND_SOC is not set
CONFIG_SND_X86=y
CONFIG_AC97_BUS=y

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
# CONFIG_HIDRAW is not set
CONFIG_UHID=y
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
CONFIG_HID_ACRUX=y
# CONFIG_HID_ACRUX_FF is not set
# CONFIG_HID_APPLE is not set
CONFIG_HID_ASUS=y
CONFIG_HID_AUREAL=y
CONFIG_HID_BELKIN=y
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_PRODIKEYS is not set
CONFIG_HID_CMEDIA=y
CONFIG_HID_CYPRESS=y
# CONFIG_HID_DRAGONRISE is not set
CONFIG_HID_EMS_FF=y
# CONFIG_HID_ELECOM is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
CONFIG_HID_GFRM=y
CONFIG_HID_KEYTOUCH=y
CONFIG_HID_KYE=y
CONFIG_HID_WALTOP=y
# CONFIG_HID_GYRATION is not set
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
CONFIG_HID_JABRA=y
CONFIG_HID_TWINHAN=y
# CONFIG_HID_KENSINGTON is not set
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_HIDPP=y
CONFIG_LOGITECH_FF=y
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MAYFLASH=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NTI is not set
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=y
# CONFIG_PANTHERLORD_FF is not set
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
# CONFIG_HID_PLANTRONICS is not set
CONFIG_HID_PRIMAX=y
# CONFIG_HID_SAITEK is not set
CONFIG_HID_SAMSUNG=y
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEELSERIES is not set
CONFIG_HID_SUNPLUS=y
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
CONFIG_HID_SMARTJOYPLUS=y
# CONFIG_SMARTJOYPLUS_FF is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THINGM is not set
# CONFIG_HID_THRUSTMASTER is not set
CONFIG_HID_UDRAW_PS3=y
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=y
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
# CONFIG_HID_ALPS is not set

#
# USB HID support
#
# CONFIG_USB_HID is not set
# CONFIG_HID_PID is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
CONFIG_USB_MOUSE=y

#
# I2C HID support
#
CONFIG_I2C_HID=y

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
CONFIG_USB_DYNAMIC_MINORS=y
CONFIG_USB_OTG=y
# CONFIG_USB_OTG_WHITELIST is not set
CONFIG_USB_OTG_BLACKLIST_HUB=y
# CONFIG_USB_OTG_FSM is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_MON=y
CONFIG_USB_WUSB_CBAF=y
# CONFIG_USB_WUSB_CBAF_DEBUG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=y
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
CONFIG_USB_OXU210HP_HCD=y
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_ISP1362_HCD=y
CONFIG_USB_FOTG210_HCD=y
CONFIG_USB_MAX3421_HCD=y
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_U132_HCD=y
# CONFIG_USB_SL811_HCD is not set
CONFIG_USB_R8A66597_HCD=y
# CONFIG_USB_HCD_SSB is not set
CONFIG_USB_HCD_TEST_MODE=y

#
# USB Device Class drivers
#
CONFIG_USB_ACM=y
CONFIG_USB_PRINTER=y
CONFIG_USB_WDM=y
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
CONFIG_USBIP_CORE=y
CONFIG_USBIP_VHCI_HCD=y
CONFIG_USBIP_VHCI_HC_PORTS=8
CONFIG_USBIP_VHCI_NR_HCS=1
# CONFIG_USBIP_HOST is not set
CONFIG_USBIP_VUDC=y
# CONFIG_USBIP_DEBUG is not set
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_HOST=y
# CONFIG_USB_MUSB_GADGET is not set
# CONFIG_USB_MUSB_DUAL_ROLE is not set

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
# CONFIG_MUSB_PIO_ONLY is not set
CONFIG_USB_DWC3=y
CONFIG_USB_DWC3_ULPI=y
# CONFIG_USB_DWC3_HOST is not set
CONFIG_USB_DWC3_GADGET=y
# CONFIG_USB_DWC3_DUAL_ROLE is not set

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=y
CONFIG_USB_DWC2=y
CONFIG_USB_DWC2_HOST=y

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PERIPHERAL is not set
# CONFIG_USB_DWC2_DUAL_ROLE is not set
# CONFIG_USB_DWC2_PCI is not set
CONFIG_USB_DWC2_DEBUG=y
# CONFIG_USB_DWC2_VERBOSE is not set
CONFIG_USB_DWC2_TRACK_MISSED_SOFS=y
CONFIG_USB_DWC2_DEBUG_PERIODIC=y
CONFIG_USB_CHIPIDEA=y
CONFIG_USB_CHIPIDEA_PCI=y
# CONFIG_USB_CHIPIDEA_UDC is not set
# CONFIG_USB_CHIPIDEA_HOST is not set
# CONFIG_USB_CHIPIDEA_ULPI is not set
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1760_HOST_ROLE=y
# CONFIG_USB_ISP1760_GADGET_ROLE is not set
# CONFIG_USB_ISP1760_DUAL_ROLE is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
CONFIG_USB_EMI26=y
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
CONFIG_USB_LCD=y
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
CONFIG_USB_FTDI_ELAN=y
CONFIG_USB_APPLEDISPLAY=y
CONFIG_USB_SISUSBVGA=y
# CONFIG_USB_LD is not set
CONFIG_USB_TRANCEVIBRATOR=y
# CONFIG_USB_IOWARRIOR is not set
CONFIG_USB_TEST=y
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=y
CONFIG_USB_YUREX=y
CONFIG_USB_EZUSB_FX2=y
CONFIG_USB_HUB_USB251XB=y
CONFIG_USB_HSIC_USB3503=y
CONFIG_USB_HSIC_USB4604=y
CONFIG_USB_LINK_LAYER_TEST=y
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
CONFIG_USB_GPIO_VBUS=y
# CONFIG_TAHVO_USB is not set
CONFIG_USB_ISP1301=y
CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
# CONFIG_USB_FOTG210_UDC is not set
CONFIG_USB_GR_UDC=y
# CONFIG_USB_R8A66597 is not set
CONFIG_USB_PXA27X=y
CONFIG_USB_MV_UDC=y
CONFIG_USB_MV_U3D=y
CONFIG_USB_SNP_CORE=y
CONFIG_USB_M66592=y
CONFIG_USB_BDC_UDC=y

#
# Platform Support
#
CONFIG_USB_BDC_PCI=y
CONFIG_USB_AMD5536UDC=y
# CONFIG_USB_NET2272 is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
CONFIG_USB_EG20T=y
CONFIG_USB_DUMMY_HCD=y
# CONFIG_USB_CONFIGFS is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_LED_TRIG is not set
CONFIG_USB_ULPI_BUS=y
# CONFIG_UWB is not set
CONFIG_MMC=y
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=y
CONFIG_MMC_TEST=y

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_PCI=y
# CONFIG_MMC_RICOH_MMC is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=y
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_TIFM_SD is not set
CONFIG_MMC_SPI=y
CONFIG_MMC_CB710=y
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_VUB300=y
CONFIG_MMC_USHC=y
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=y
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=y
CONFIG_MMC_SDHCI_XENON=y
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=y
CONFIG_MS_BLOCK=y

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=y
# CONFIG_MEMSTICK_JMICRON_38X is not set
CONFIG_MEMSTICK_R592=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_AS3645A is not set
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3533=y
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_MT6323=y
CONFIG_LEDS_PCA9532=y
CONFIG_LEDS_PCA9532_GPIO=y
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
# CONFIG_LEDS_LP8788 is not set
CONFIG_LEDS_PCA955X=y
# CONFIG_LEDS_PCA955X_GPIO is not set
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM831X_STATUS=y
CONFIG_LEDS_WM8350=y
# CONFIG_LEDS_DA903X is not set
CONFIG_LEDS_DA9052=y
# CONFIG_LEDS_DAC124S085 is not set
CONFIG_LEDS_REGULATOR=y
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_ADP5520=y
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_TCA6507=y
# CONFIG_LEDS_TLC591XX is not set
CONFIG_LEDS_MAX8997=y
CONFIG_LEDS_LM355x=y
# CONFIG_LEDS_MENF21BMC is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=y
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
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
# CONFIG_RTC_NVMEM is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
CONFIG_RTC_DRV_TEST=y

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM80X=y
CONFIG_RTC_DRV_ABB5ZES3=y
# CONFIG_RTC_DRV_ABX80X is not set
# CONFIG_RTC_DRV_DS1307 is not set
CONFIG_RTC_DRV_DS1374=y
CONFIG_RTC_DRV_DS1374_WDT=y
CONFIG_RTC_DRV_DS1672=y
CONFIG_RTC_DRV_LP8788=y
CONFIG_RTC_DRV_MAX6900=y
# CONFIG_RTC_DRV_MAX8907 is not set
# CONFIG_RTC_DRV_MAX8998 is not set
# CONFIG_RTC_DRV_MAX8997 is not set
CONFIG_RTC_DRV_RS5C372=y
CONFIG_RTC_DRV_ISL1208=y
CONFIG_RTC_DRV_ISL12022=y
CONFIG_RTC_DRV_X1205=y
# CONFIG_RTC_DRV_PCF8523 is not set
# CONFIG_RTC_DRV_PCF85063 is not set
CONFIG_RTC_DRV_PCF85363=y
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
CONFIG_RTC_DRV_M41T80=y
# CONFIG_RTC_DRV_M41T80_WDT is not set
CONFIG_RTC_DRV_BQ32K=y
CONFIG_RTC_DRV_TPS6586X=y
# CONFIG_RTC_DRV_TPS80031 is not set
CONFIG_RTC_DRV_S35390A=y
CONFIG_RTC_DRV_FM3130=y
CONFIG_RTC_DRV_RX8010=y
CONFIG_RTC_DRV_RX8581=y
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
CONFIG_RTC_DRV_RV8803=y
# CONFIG_RTC_DRV_S5M is not set

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=y
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
CONFIG_RTC_DRV_DS1390=y
CONFIG_RTC_DRV_MAX6916=y
CONFIG_RTC_DRV_R9701=y
# CONFIG_RTC_DRV_RX4581 is not set
CONFIG_RTC_DRV_RX6110=y
CONFIG_RTC_DRV_RS5C348=y
CONFIG_RTC_DRV_MAX6902=y
CONFIG_RTC_DRV_PCF2123=y
CONFIG_RTC_DRV_MCP795=y
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=y
# CONFIG_RTC_DRV_DS3232_HWMON is not set
CONFIG_RTC_DRV_PCF2127=y
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_CMOS is not set
CONFIG_RTC_DRV_DS1286=y
CONFIG_RTC_DRV_DS1511=y
CONFIG_RTC_DRV_DS1553=y
CONFIG_RTC_DRV_DS1685_FAMILY=y
CONFIG_RTC_DRV_DS1685=y
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
# CONFIG_RTC_DRV_DS17485 is not set
# CONFIG_RTC_DRV_DS17885 is not set
# CONFIG_RTC_DS1685_PROC_REGS is not set
CONFIG_RTC_DS1685_SYSFS_REGS=y
CONFIG_RTC_DRV_DS1742=y
CONFIG_RTC_DRV_DS2404=y
CONFIG_RTC_DRV_DA9052=y
# CONFIG_RTC_DRV_DA9055 is not set
CONFIG_RTC_DRV_DA9063=y
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
CONFIG_RTC_DRV_M48T59=y
# CONFIG_RTC_DRV_MSM6242 is not set
CONFIG_RTC_DRV_BQ4802=y
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set
CONFIG_RTC_DRV_WM831X=y
CONFIG_RTC_DRV_WM8350=y
CONFIG_RTC_DRV_PCF50633=y
CONFIG_RTC_DRV_CROS_EC=y

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_FTRTC010=y
# CONFIG_RTC_DRV_PCAP is not set
# CONFIG_RTC_DRV_MC13XXX is not set
# CONFIG_RTC_DRV_MT6397 is not set

#
# HID Sensor RTC drivers
#
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
# CONFIG_DMADEVICES_VDEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_ACPI=y
CONFIG_ALTERA_MSGDMA=y
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_INTEL_IOATDMA is not set
CONFIG_INTEL_MIC_X100_DMA=y
CONFIG_QCOM_HIDMA_MGMT=y
CONFIG_QCOM_HIDMA=y
# CONFIG_DW_DMAC is not set
# CONFIG_DW_DMAC_PCI is not set

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
# CONFIG_DMATEST is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
# CONFIG_IMG_ASCII_LCD is not set
CONFIG_UIO=y
CONFIG_UIO_CIF=y
CONFIG_UIO_PDRV_GENIRQ=y
CONFIG_UIO_DMEM_GENIRQ=y
# CONFIG_UIO_AEC is not set
CONFIG_UIO_SERCOS3=y
# CONFIG_UIO_PCI_GENERIC is not set
CONFIG_UIO_NETX=y
# CONFIG_UIO_PRUSS is not set
CONFIG_UIO_MF624=y
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# CONFIG_HYPERV_TSCPAGE is not set
CONFIG_STAGING=y
# CONFIG_IRDA is not set
# CONFIG_IPX is not set
# CONFIG_NCP_FS is not set
# CONFIG_COMEDI is not set
# CONFIG_R8712U is not set

#
# Speakup console speech
#
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
# CONFIG_ION is not set
# CONFIG_FIREWIRE_SERIAL is not set
CONFIG_DGNC=y
CONFIG_GS_FPGABOOT=y
CONFIG_CRYPTO_SKEIN=y
# CONFIG_UNISYSSPAR is not set
CONFIG_MOST=y
CONFIG_MOST_CDEV=y
CONFIG_MOST_NET=y
CONFIG_MOST_SOUND=y
CONFIG_MOST_VIDEO=y
CONFIG_MOST_DIM2=y
# CONFIG_MOST_I2C is not set
CONFIG_MOST_USB=y
# CONFIG_KS7010 is not set
# CONFIG_GREYBUS is not set

#
# USB Power Delivery and Type-C drivers
#
CONFIG_PI433=y
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACERHDF is not set
# CONFIG_ASUS_LAPTOP is not set
CONFIG_DELL_SMBIOS=y
CONFIG_DELL_SMBIOS_SMM=y
# CONFIG_DELL_SMO8800 is not set
# CONFIG_DELL_RBTN is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
CONFIG_AMILO_RFKILL=y
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
# CONFIG_MSI_LAPTOP is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_COMPAL_LAPTOP is not set
# CONFIG_SONY_LAPTOP is not set
# CONFIG_IDEAPAD_LAPTOP is not set
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ACPI_WMI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_INTEL_CHT_INT33FE is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=y
# CONFIG_INTEL_OAKTRAIL is not set
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_PVPANIC is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_INTEL_PUNIT_IPC=y
# CONFIG_MLX_PLATFORM is not set
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_PSTORE=y
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_WM831X is not set
CONFIG_COMMON_CLK_SI5351=y
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
CONFIG_COMMON_CLK_S2MPS11=y
# CONFIG_COMMON_CLK_NXP is not set
# CONFIG_COMMON_CLK_PXA is not set
# CONFIG_COMMON_CLK_PIC32 is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# CONFIG_ATMEL_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
# CONFIG_MAILBOX is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# CONFIG_AMD_IOMMU is not set
# CONFIG_INTEL_IOMMU is not set
# CONFIG_IRQ_REMAP is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CHAR=y
CONFIG_RPMSG_VIRTIO=y
CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#
# CONFIG_SOUNDWIRE_INTEL is not set

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
# CONFIG_SUNXI_SRAM is not set
# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=y
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX14577=y
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_MAX77693=y
CONFIG_EXTCON_MAX8997=y
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
CONFIG_EXTCON_USBC_CROS_EC=y
CONFIG_MEMORY=y
# CONFIG_IIO is not set
CONFIG_NTB=y
# CONFIG_NTB_AMD is not set
CONFIG_NTB_IDT=y
CONFIG_NTB_INTEL=y
CONFIG_NTB_SWITCHTEC=y
CONFIG_NTB_PINGPONG=y
CONFIG_NTB_TOOL=y
CONFIG_NTB_PERF=y
CONFIG_NTB_TRANSPORT=y
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
# CONFIG_VME_CA91CX42 is not set
CONFIG_VME_TSI148=y
CONFIG_VME_FAKE=y

#
# VME Board Drivers
#
CONFIG_VMIVME_7805=y

#
# VME Device Drivers
#
CONFIG_VME_USER=y
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_ARM_GIC_V3_ITS is not set
CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_ATH79 is not set
# CONFIG_RESET_AXS10X is not set
# CONFIG_RESET_BERLIN is not set
# CONFIG_RESET_IMX7 is not set
# CONFIG_RESET_LANTIQ is not set
# CONFIG_RESET_LPC18XX is not set
# CONFIG_RESET_MESON is not set
# CONFIG_RESET_PISTACHIO is not set
# CONFIG_RESET_SIMPLE is not set
# CONFIG_RESET_SUNXI is not set
# CONFIG_RESET_TI_SYSCON is not set
# CONFIG_RESET_ZYNQ is not set
# CONFIG_RESET_TEGRA_BPMP is not set
CONFIG_FMC=y
# CONFIG_FMC_FAKEDEV is not set
CONFIG_FMC_TRIVIAL=y
CONFIG_FMC_WRITE_EEPROM=y
# CONFIG_FMC_CHARDEV is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=y
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_PHY_QCOM_USB_HS=y
CONFIG_PHY_QCOM_USB_HSIC=y
CONFIG_PHY_SAMSUNG_USB2=y
# CONFIG_PHY_EXYNOS4210_USB2 is not set
# CONFIG_PHY_EXYNOS4X12_USB2 is not set
# CONFIG_PHY_EXYNOS5250_USB2 is not set
CONFIG_PHY_TUSB1210=y
CONFIG_POWERCAP=y
# CONFIG_INTEL_RAPL is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_THUNDERBOLT is not set

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# CONFIG_LIBNVDIMM is not set
CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_STM=y
CONFIG_STM_DUMMY=y
# CONFIG_STM_SOURCE_CONSOLE is not set
CONFIG_STM_SOURCE_HEARTBEAT=y
CONFIG_STM_SOURCE_FTRACE=y
CONFIG_INTEL_TH=y
CONFIG_INTEL_TH_PCI=y
CONFIG_INTEL_TH_GTH=y
# CONFIG_INTEL_TH_STH is not set
CONFIG_INTEL_TH_MSU=y
CONFIG_INTEL_TH_PTI=y
# CONFIG_INTEL_TH_DEBUG is not set
CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
CONFIG_FPGA_MGR_ALTERA_PS_SPI=y
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
# CONFIG_FPGA_MGR_XILINX_SPI is not set
CONFIG_FPGA_BRIDGE=y
# CONFIG_XILINX_PR_DECOUPLER is not set
CONFIG_FPGA_REGION=y
CONFIG_FSI=y
# CONFIG_FSI_MASTER_GPIO is not set
CONFIG_FSI_MASTER_HUB=y
CONFIG_FSI_SCOM=y
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=y
# CONFIG_SLIM_QCOM_CTRL is not set

#
# Firmware Drivers
#
CONFIG_EDD=y
CONFIG_EDD_OFF=y
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_DELL_RBU=y
CONFIG_DCDBAS=y
# CONFIG_ISCSI_IBFT_FIND is not set
# CONFIG_FW_CFG_SYSFS is not set
# CONFIG_GOOGLE_FIRMWARE is not set
# CONFIG_EFI_DEV_PATH_PARSER is not set

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=y
# CONFIG_EXT4_FS_POSIX_ACL is not set
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_ENCRYPTION is not set
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
CONFIG_JFS_FS=y
# CONFIG_JFS_POSIX_ACL is not set
# CONFIG_JFS_SECURITY is not set
CONFIG_JFS_DEBUG=y
CONFIG_JFS_STATISTICS=y
CONFIG_XFS_FS=y
CONFIG_XFS_QUOTA=y
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=y
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
CONFIG_BTRFS_ASSERT=y
CONFIG_BTRFS_FS_REF_VERIFY=y
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
# CONFIG_F2FS_FS_POSIX_ACL is not set
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FS_ENCRYPTION is not set
CONFIG_F2FS_IO_TRACE=y
CONFIG_F2FS_FAULT_INJECTION=y
CONFIG_FS_DAX=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_MANDATORY_FILE_LOCKING is not set
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_QUOTA is not set
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=y
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# CONFIG_MISC_FILESYSTEMS is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=y
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
# CONFIG_NLS_MAC_GAELIC is not set
CONFIG_NLS_MAC_GREEK=y
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
# CONFIG_NLS_UTF8 is not set
# CONFIG_DLM is not set

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
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
# CONFIG_ENABLE_WARN_DEPRECATED is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=2048
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_READABLE_ASM=y
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_PAGE_OWNER=y
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
CONFIG_STACK_VALIDATION=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_PAGE_REF=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
CONFIG_DEBUG_OBJECTS_FREE=y
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
CONFIG_DEBUG_OBJECTS_WORK=y
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_DEBUG_SLAB is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_VMACACHE=y
CONFIG_DEBUG_VM_RB=y
# CONFIG_DEBUG_VM_PGFLAGS is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_HAVE_ARCH_KASAN=y
# CONFIG_KASAN is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_KCOV=y
# CONFIG_KCOV_ENABLE_COMPARISONS is not set
# CONFIG_KCOV_INSTRUMENT_ALL is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=0
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHED_INFO is not set
# CONFIG_SCHEDSTATS is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set
# CONFIG_DEBUG_PREEMPT is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=y
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=y
CONFIG_NETDEV_NOTIFIER_ERROR_INJECT=y
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
# CONFIG_FUNCTION_GRAPH_TRACER is not set
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_PREEMPT_TRACER=y
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
CONFIG_PROFILE_ANNOTATED_BRANCHES=y
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_TRACING_BRANCHES=y
CONFIG_BRANCH_TRACER=y
CONFIG_STACK_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
# CONFIG_FUNCTION_PROFILER is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
CONFIG_MMIOTRACE=y
# CONFIG_HIST_TRIGGERS is not set
CONFIG_TRACEPOINT_BENCHMARK=y
CONFIG_RING_BUFFER_BENCHMARK=y
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_TRACE_EVAL_MAP_FILE=y
# CONFIG_TRACING_EVENTS_GPIO is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
CONFIG_IO_STRICT_DEVMEM=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_X86_PTDUMP_CORE is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_DEBUG_WX is not set
# CONFIG_DOUBLEFAULT is not set
# CONFIG_DEBUG_TLBFLUSH is not set
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
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
CONFIG_PUNIT_ATOM_DEBUG=y
# CONFIG_UNWINDER_ORC is not set
CONFIG_UNWINDER_FRAME_POINTER=y

#
# Security options
#
# CONFIG_KEYS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_XOR_BLOCKS=y
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
CONFIG_CRYPTO_USER=y
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_MCRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_ABLK_HELPER=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
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
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
CONFIG_CRYPTO_CRC32=y
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_POLY1305_X86_64=y
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=y
CONFIG_CRYPTO_SHA1_MB=y
# CONFIG_CRYPTO_SHA256_MB is not set
CONFIG_CRYPTO_SHA512_MB=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_SM3=y
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_X86_64=y
# CONFIG_CRYPTO_AES_NI_INTEL is not set
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST5_AVX_X86_64=y
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_DES3_EDE_X86_64=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=y
# CONFIG_CRYPTO_SALSA20_X86_64 is not set
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
CONFIG_CRYPTO_TEA=y
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=y
CONFIG_CRYPTO_DEV_PADLOCK_AES=y
# CONFIG_CRYPTO_DEV_PADLOCK_SHA is not set
# CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_DESC is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_QAT=y
CONFIG_CRYPTO_DEV_QAT_DH895xCC=y
CONFIG_CRYPTO_DEV_QAT_C3XXX=y
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=y
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=y
CONFIG_CRYPTO_DEV_QAT_C62XVF=y
CONFIG_CRYPTO_DEV_NITROX=y
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=y
# CONFIG_CRYPTO_DEV_VIRTIO is not set

#
# Certificates for signature checking
#
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
CONFIG_VHOST_NET=y
CONFIG_VHOST_VSOCK=y
CONFIG_VHOST=y
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
CONFIG_BITREVERSE=y
# CONFIG_HAVE_ARCH_BITREVERSE is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
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
CONFIG_BCH=y
CONFIG_BCH_CONST_PARAMS=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_SGL_ALLOC=y
CONFIG_DMA_DIRECT_OPS=y
# CONFIG_DMA_VIRT_OPS is not set
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=y
# CONFIG_DDR is not set
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
# CONFIG_SG_SPLIT is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set

--3kvqdadyjkd4topo--
