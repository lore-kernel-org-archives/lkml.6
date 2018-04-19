Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753359AbeDSDSo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 23:18:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:39125 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752504AbeDSDSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 23:18:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,467,1517904000";
   d="gz'50?scan'50,208,50";a="43004973"
Date: Thu, 19 Apr 2018 11:13:15 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Paul Blakey <paulb@mellanox.com>
Cc: linux-kernel@vger.kernel.org, lkp@01.org, Thomas Graf <tgraf@suug.ch>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florian Westphal <fw@strlen.de>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: 499ac3b60f ("test_rhashtable: add test case for rhltable with
 duplicate objects"): WARNING: suspicious RCU usage
Message-ID: <20180419031315.5bydronkvfk2svzz@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mirgrwpxdxksyg45"
Content-Disposition: inline
In-Reply-To: <20180419030602.e6prycb2gw3agagn@wfg-t540p.sh.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mirgrwpxdxksyg45
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

commit 499ac3b60f657dae82055fc81c7b01e6242ac9bc
Author:     Paul Blakey <paulb@mellanox.com>
AuthorDate: Sun Mar 4 17:29:49 2018 +0200
Commit:     David S. Miller <davem@davemloft.net>
CommitDate: Wed Mar 7 10:44:03 2018 -0500

     test_rhashtable: add test case for rhltable with duplicate objects
     
     Tries to insert duplicates in the middle of bucket's chain:
     bucket 1:  [[val 21 (tid=1)]] -> [[ val 1 (tid=2),  val 1 (tid=0) ]]
     
     Reuses tid to distinguish the elements insertion order.
     
     Signed-off-by: Paul Blakey <paulb@mellanox.com>
     Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
     Signed-off-by: David S. Miller <davem@davemloft.net>

d3dcf8eb61  rhashtable: Fix rhlist duplicates insertion
499ac3b60f  test_rhashtable: add test case for rhltable with duplicate objects
+--------------------------------------------------------------------+------------+------------+
|                                                                    | d3dcf8eb61 | 499ac3b60f |
+--------------------------------------------------------------------+------------+------------+
| boot_successes                                                     | 41         | 0          |
| boot_failures                                                      | 0          | 21         |
| WARNING:suspicious_RCU_usage                                       | 0          | 21         |
| lib/test_rhashtable.c:#suspicious_rcu_dereference_protected()usage | 0          | 21         |
+--------------------------------------------------------------------+------------+------------+

[    7.248372] test if its possible to exceed max_size 8192: no, ok
[    7.249256] Average test time: 464870041
[    7.249746] test inserting duplicates
[    7.250234] 
[    7.250425] =============================
[    7.250900] WARNING: suspicious RCU usage
[    7.251392] 4.16.0-rc4-00130-g499ac3b #2 Not tainted
[    7.251971] -----------------------------
[    7.252469] lib/test_rhashtable.c:502 suspicious rcu_dereference_protected() usage!
[    7.253574] 
[    7.253574] other info that might help us debug this:
[    7.253574] 
[    7.254489] 
[    7.254489] rcu_scheduler_active = 2, debug_locks = 1
[    7.255236] no locks held by swapper/0/1.
[    7.255700] 
[    7.255700] stack backtrace:
[    7.256274] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.16.0-rc4-00130-g499ac3b #2
[    7.257148] Call Trace:
[    7.257478]  dump_stack+0xb7/0x107
[    7.257884]  print_ht+0x8f/0x35d
[    7.258286]  test_insert_dup+0x13b/0x1ce
[    7.258745]  ? ___siphash_aligned+0x2b/0x2b
[    7.259369]  ? jhash+0x1bb/0x1bb
[    7.259769]  ? my_hashfn+0x1a/0x1a
[    7.260199]  ? rhashtable_walk_peek+0x78/0x78
[    7.260217]  test_rht_init+0x6f8/0x1212
[    7.260217]  ? ___siphash_aligned+0x2b/0x2b
[    7.260217]  ? initcall_blacklisted+0xb0/0xd3
[    7.260217]  ? kstrtoll+0x9a/0xbc
[    7.260217]  ? kstrtos8+0x69/0x89
[    7.260217]  ? test_insert_dup+0x1ce/0x1ce
[    7.260217]  ? do_early_param+0xb9/0xb9
[    7.260217]  do_one_initcall+0xaa/0x17d
[    7.260217]  ? do_early_param+0xb9/0xb9
[    7.260217]  kernel_init_freeable+0x124/0x1d9
[    7.260217]  ? rest_init+0xc5/0xc5
[    7.260217]  kernel_init+0xb/0x147
[    7.260217]  ? rest_init+0xc5/0xc5
[    7.260217]  ret_from_fork+0x24/0x30
[    7.267845] 
[    7.268075] =============================
[    7.268564] WARNING: suspicious RCU usage
[    7.269031] 4.16.0-rc4-00130-g499ac3b #2 Not tainted
[    7.269622] -----------------------------
[    7.270084] lib/test_rhashtable.c:507 suspicious rcu_dereference_protected() usage!
[    7.271169] 
[    7.271169] other info that might help us debug this:
[    7.271169] 
[    7.272102] 
[    7.272102] rcu_scheduler_active = 2, debug_locks = 1
[    7.272851] no locks held by swapper/0/1.
[    7.273338] 
[    7.273338] stack backtrace:
[    7.273862] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.16.0-rc4-00130-g499ac3b #2
[    7.274723] Call Trace:
[    7.275024]  dump_stack+0xb7/0x107
[    7.275452]  print_ht+0xf4/0x35d
[    7.275856]  test_insert_dup+0x13b/0x1ce
[    7.276085]  ? ___siphash_aligned+0x2b/0x2b
[    7.276085]  ? jhash+0x1bb/0x1bb
[    7.276085]  ? my_hashfn+0x1a/0x1a
[    7.276085]  ? rhashtable_walk_peek+0x78/0x78
[    7.276085]  test_rht_init+0x6f8/0x1212
[    7.276085]  ? ___siphash_aligned+0x2b/0x2b
[    7.276085]  ? initcall_blacklisted+0xb0/0xd3
[    7.276085]  ? kstrtoll+0x9a/0xbc
[    7.276085]  ? kstrtos8+0x69/0x89
[    7.276085]  ? test_insert_dup+0x1ce/0x1ce
[    7.276085]  ? do_early_param+0xb9/0xb9
[    7.276085]  do_one_initcall+0xaa/0x17d
[    7.276085]  ? do_early_param+0xb9/0xb9
[    7.276085]  kernel_init_freeable+0x124/0x1d9
[    7.276085]  ? rest_init+0xc5/0xc5
[    7.276085]  kernel_init+0xb/0x147
[    7.276085]  ? rest_init+0xc5/0xc5
[    7.276085]  ret_from_fork+0x24/0x30
[    7.285387] 
[    7.285589] =============================
[    7.286070] WARNING: suspicious RCU usage
[    7.286550] 4.16.0-rc4-00130-g499ac3b #2 Not tainted
[    7.287121] -----------------------------
[    7.287590] lib/test_rhashtable.c:508 suspicious rcu_dereference_protected() usage!
[    7.288702] 
[    7.288702] other info that might help us debug this:
[    7.288702] 
[    7.289617] 
[    7.289617] rcu_scheduler_active = 2, debug_locks = 1
[    7.290374] no locks held by swapper/0/1.
[    7.290859] 
[    7.290859] stack backtrace:
[    7.291375] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.16.0-rc4-00130-g499ac3b #2
[    7.292239] Call Trace:
[    7.292556]  dump_stack+0xb7/0x107
[    7.292669]  print_ht+0x15e/0x35d
[    7.292669]  test_insert_dup+0x13b/0x1ce
[    7.292669]  ? ___siphash_aligned+0x2b/0x2b
[    7.292669]  ? jhash+0x1bb/0x1bb
[    7.292669]  ? my_hashfn+0x1a/0x1a
[    7.292669]  ? rhashtable_walk_peek+0x78/0x78
[    7.292669]  test_rht_init+0x6f8/0x1212
[    7.292669]  ? ___siphash_aligned+0x2b/0x2b
[    7.292669]  ? initcall_blacklisted+0xb0/0xd3
[    7.292669]  ? kstrtoll+0x9a/0xbc
[    7.292669]  ? kstrtos8+0x69/0x89
[    7.292669]  ? test_insert_dup+0x1ce/0x1ce
[    7.292669]  ? do_early_param+0xb9/0xb9
[    7.292669]  do_one_initcall+0xaa/0x17d
[    7.292669]  ? do_early_param+0xb9/0xb9
[    7.292669]  kernel_init_freeable+0x124/0x1d9
[    7.292669]  ? rest_init+0xc5/0xc5
[    7.292669]  kernel_init+0xb/0x147
[    7.292669]  ? rest_init+0xc5/0xc5
[    7.292669]  ret_from_fork+0x24/0x30
[    7.302814] 
[    7.303002] =============================
[    7.303480] WARNING: suspicious RCU usage
[    7.303942] 4.16.0-rc4-00130-g499ac3b #2 Not tainted
[    7.304550] -----------------------------
[    7.305015] lib/test_rhashtable.c:519 suspicious rcu_dereference_protected() usage!
[    7.306095] 
[    7.306095] other info that might help us debug this:
[    7.306095] 
[    7.306995] 
[    7.306995] rcu_scheduler_active = 2, debug_locks = 1
[    7.307755] no locks held by swapper/0/1.
[    7.308242] 
[    7.308242] stack backtrace:
[    7.308762] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.16.0-rc4-00130-g499ac3b #2
[    7.309626] Call Trace:
[    7.309945]  dump_stack+0xb7/0x107
[    7.310367]  print_ht+0x1f0/0x35d
[    7.310762]  test_insert_dup+0x13b/0x1ce
[    7.311232]  ? ___siphash_aligned+0x2b/0x2b
[    7.311851]  ? jhash+0x1bb/0x1bb
[    7.312228]  ? my_hashfn+0x1a/0x1a
[    7.312228]  ? rhashtable_walk_peek+0x78/0x78
[    7.312228]  test_rht_init+0x6f8/0x1212
[    7.312228]  ? ___siphash_aligned+0x2b/0x2b
[    7.312228]  ? initcall_blacklisted+0xb0/0xd3
[    7.312228]  ? kstrtoll+0x9a/0xbc
[    7.312228]  ? kstrtos8+0x69/0x89
[    7.312228]  ? test_insert_dup+0x1ce/0x1ce
[    7.312228]  ? do_early_param+0xb9/0xb9
[    7.312228]  do_one_initcall+0xaa/0x17d
[    7.312228]  ? do_early_param+0xb9/0xb9
[    7.312228]  kernel_init_freeable+0x124/0x1d9
[    7.312228]  ? rest_init+0xc5/0xc5
[    7.312228]  kernel_init+0xb/0x147
[    7.312228]  ? rest_init+0xc5/0xc5
[    7.312228]  ret_from_fork+0x24/0x30
[    7.320198] 
[    7.320408] =============================
[    7.320870] WARNING: suspicious RCU usage
[    7.321361] 4.16.0-rc4-00130-g499ac3b #2 Not tainted
[    7.321929] -----------------------------
[    7.322398] lib/test_rhashtable.c:529 suspicious rcu_dereference_protected() usage!
[    7.323469] 
[    7.323469] other info that might help us debug this:
[    7.323469] 
[    7.324404] 
[    7.324404] rcu_scheduler_active = 2, debug_locks = 1
[    7.325157] no locks held by swapper/0/1.
[    7.325631] 
[    7.325631] stack backtrace:
[    7.326158] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.16.0-rc4-00130-g499ac3b #2
[    7.326980] Call Trace:
[    7.327293]  dump_stack+0xb7/0x107
[    7.327707]  print_ht+0x2bc/0x35d
[    7.328129]  test_insert_dup+0x13b/0x1ce
[    7.328380]  ? ___siphash_aligned+0x2b/0x2b
[    7.328380]  ? jhash+0x1bb/0x1bb
[    7.328380]  ? my_hashfn+0x1a/0x1a
[    7.328380]  ? rhashtable_walk_peek+0x78/0x78
[    7.328380]  test_rht_init+0x6f8/0x1212
[    7.328380]  ? ___siphash_aligned+0x2b/0x2b
[    7.328380]  ? initcall_blacklisted+0xb0/0xd3
[    7.328380]  ? kstrtoll+0x9a/0xbc
[    7.328380]  ? kstrtos8+0x69/0x89
[    7.328380]  ? test_insert_dup+0x1ce/0x1ce
[    7.328380]  ? do_early_param+0xb9/0xb9
[    7.328380]  do_one_initcall+0xaa/0x17d
[    7.328380]  ? do_early_param+0xb9/0xb9
[    7.328380]  kernel_init_freeable+0x124/0x1d9
[    7.328380]  ? rest_init+0xc5/0xc5
[    7.328380]  kernel_init+0xb/0x147
[    7.328380]  ? rest_init+0xc5/0xc5
[    7.328380]  ret_from_fork+0x24/0x30
[    7.337480] 
[    7.337480] ---- ht: ----
[    7.337480] bucket[1] -> [[ val 1 (tid=0) ]] -> [[ val 21 (tid=1) ]]
[    7.337480] -------------
[    7.339010] 

                                                           # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start 720b4957c76e21b64ebcfbe2db6628653457a132 661e50bc853209e41a5c14a290ca4decc43cbfd1 --
git bisect  bad 2105ee619597aa7c86e54374d7c18ca66d409546  # 05:17  B      0    11   24   0  Merge 'regmap/for-next' into devel-catchup-201803080312
git bisect  bad 4f9652fad49d3194174fd861d2ba2a008273380b  # 05:27  B      0     2   15   0  Merge 'hid/for-4.16/upstream-fixes' into devel-catchup-201803080312
git bisect  bad ee2902aa03dd3b02a8a7f01b4f8fa5b22e854d26  # 05:50  B      0     1   14   0  Merge 'jkirsher-net-queue/master' into devel-catchup-201803080312
git bisect good 08d0c47a51087fe73203e85d2455078bfeec2eeb  # 06:05  G     11     0    0   0  Merge 'linux-review/Leon-Romanovsky/RDMA-ucma-Limit-possible-option-size/20180308-012724' into devel-catchup-201803080312
git bisect good 70ccbfde7342e3d79f4fce05da08d1b6002d2492  # 06:19  G     11     0    1   1  Merge 'linux-review/Leon-Romanovsky/RDMA-ucma-Check-that-user-doesn-t-overflow-QP-state/20180308-011932' into devel-catchup-201803080312
git bisect good 7cb0d12201b8971cd91400c59e91743f760e3991  # 06:32  G     11     0    4   4  Merge 'linux-nvme/nvme-4.16-rc5' into devel-catchup-201803080312
git bisect good d69242bf203e3123ab722bdaa95e1bc42472d10b  # 06:46  G     11     0    1   1  Merge tag 'mac80211-for-davem-2018-03-02' of git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211
git bisect good b3bf5666a51068ad5ddd89a76ed877101ef3bc16  # 06:55  G     11     0    4   4  hv_netvsc: defer queue selection to VF
git bisect good 25b5cdfcce1b57971840505dfc78556bd12dea6d  # 07:07  G     11     0    1   1  dt-bindings: net: renesas-ravb: Make stream buffer optional
git bisect  bad 2695578b896aea472b2c0dcbe9d92daa71738484  # 07:16  B      0     4   17   0  net: usbnet: fix potential deadlock on 32bit hosts
git bisect  bad 803fafbe0cd522fa6b9e41ca3b96cfb2e2a2222d  # 07:34  B      0     1   14   0  fsl/fman: avoid sleeping in atomic context while adding an address
git bisect  bad 499ac3b60f657dae82055fc81c7b01e6242ac9bc  # 07:50  B      0    11   26   2  test_rhashtable: add test case for rhltable with duplicate objects
git bisect good d3dcf8eb615537526bd42ff27a081d46d337816e  # 07:59  G     10     0    1   1  rhashtable: Fix rhlist duplicates insertion
# first bad commit: [499ac3b60f657dae82055fc81c7b01e6242ac9bc] test_rhashtable: add test case for rhltable with duplicate objects
git bisect good d3dcf8eb615537526bd42ff27a081d46d337816e  # 08:02  G     32     0    3   4  rhashtable: Fix rhlist duplicates insertion
# extra tests with debug options
git bisect  bad 499ac3b60f657dae82055fc81c7b01e6242ac9bc  # 08:12  B      0     3   16   0  test_rhashtable: add test case for rhltable with duplicate objects
# extra tests on HEAD of linux-devel/devel-catchup-201803080312
git bisect  bad 720b4957c76e21b64ebcfbe2db6628653457a132  # 08:18  B      0    13   29   0  0day head guard for 'devel-catchup-201803080312'
# extra tests on tree/branch linux-devel/devel-catchup-201803080233
# extra tests with first bad commit reverted
git bisect good 7c17a6b5257f54bfeba9868af4a2fbbf0ae73c9f  # 15:37  G     11     0    0   0  Revert "test_rhashtable: add test case for rhltable with duplicate objects"

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--mirgrwpxdxksyg45
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-lkp-hsw01-11:20180308074820:x86_64-randconfig-in0-03080359:4.16.0-rc4-00130-g499ac3b:2.gz"
Content-Transfer-Encoding: base64

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
AA==

--mirgrwpxdxksyg45
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-lkp-hsw01-25:20180308080106:x86_64-randconfig-in0-03080359:4.16.0-rc4-00129-gd3dcf8e:1.gz"
Content-Transfer-Encoding: base64

H4sICCepoFoAA2RtZXNnLXlvY3RvLWxrcC1oc3cwMS0yNToyMDE4MDMwODA4MDEwNjp4ODZf
NjQtcmFuZGNvbmZpZy1pbjAtMDMwODAzNTk6NC4xNi4wLXJjNC0wMDEyOS1nZDNkY2Y4ZTox
AOxbW3PiSJZ+3voVuTEPjScMVuqGpA0mBtu4TNjYtHHV9E5FBZFIKay2bq2LL/3r95xMBEIC
G9fUvjURVVjSyS+PTp57Jpxl4StxkzhPQk6CmOS8KFO44fFPvPmMvxQZc4v5I89iHn4K4rQs
5h4rmEOUF6X66JRz1TBWj0Mebz1VPF91mfopKQt4vPWIyq/Vo9ZI1bV127A+ydnnRVKwcJ4H
f/ItKs33OYJ8OuduEqUZz/MgXpLrIC5fer0embJM3BhdX+Cll8S89+k0SQq8WTxwIuF7n74R
+Cg9ifpdApAnDqOTmOg9avaUbubqXeBbtbtLT/Nc3+Kk87gog9D7Z5aw6Ih0lq67HtTvaT2F
dM75ImCrqy49OiJ/o2Q2mZLp3Wg0md6T+4eSTFhGLKL0HUN3VIWcze6JqlCrydRZEkUs9kgY
xCCFDN5icOLxp5OMRQp5KOPlvGD54zxlceAOKPH4olwSlsKF/DN/zbM/5ix8Zq/5nMdsEXKP
ZG6ZwqLyHvwxd9NynoOgQd5BxGFlBrBKJOZFL/BjFvF8oJA0C+LisQcTP0b5cgBvKifsUpIn
fhEm7mOZrpmIo2D+zAr3wUuWA3GTJEmar/4ME+bNgX0vyB8HKkDDGhbrGwrxsoXXi4I4yeZu
UsbFwMKXKHjk9cJkCTrzxMMBzzISLIGGz+GmuFep8aAoXhUiNFuyjTdmyjGlhgovVqPa3Hxa
sgGARSwk2TPK+nFwIle5W/C8yE+yMu7+UfKSn7wmbpF0w8e0+5A/K/TkxTLnpt7NYJEA2g+W
3SBWuoqmWIpm2CchKlXXQwYd8X/XRcmUaRdXW5JR1Vnp1sKkhqH1DdVceLrq+2qfKRb1dNPT
tL5FTe4sgpy7RVfCqvZJ7ynCv//sHoqwmbdvgLV1DafxRl3VIAt4HfdhUGP+ZD/z5PT29n4+
ngw/jwYn6eNSvvN7ggGz6fZPDuX6pHrN/Wa5Q29Qz3nm9/KHsvCS53igNM3ranR3M7omeZmm
SVaAaYA15E6TipBxXICGfeZxCXYoLto0w8k5GZbgYOIicOGiTXEGj1iZVd+XrAzzJhWI7cRP
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
u/jXD1/g15/9f4U6fQzMHAMA

--mirgrwpxdxksyg45
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-yocto-lkp-hsw01-11:20180308074820:x86_64-randconfig-in0-03080359:4.16.0-rc4-00130-g499ac3b:2"

#!/bin/bash

kernel=$1
initrd=yocto-trinity-x86_64.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/yocto/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu Haswell,+smep
	-kernel $kernel
	-initrd $initrd
	-m 512
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

--mirgrwpxdxksyg45
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.16.0-rc4-00130-g499ac3b"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 4.16.0-rc4 Kernel Configuration
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
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
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
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
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
CONFIG_TICK_ONESHOT=y
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ_FULL is not set
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set
CONFIG_CPU_ISOLATION=y

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
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
# CONFIG_NUMA_BALANCING is not set
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
# CONFIG_MEMCG_SWAP_ENABLED is not set
# CONFIG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
# CONFIG_CGROUP_HUGETLB is not set
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
CONFIG_CGROUP_DEBUG=y
# CONFIG_SOCK_CGROUP_DATA is not set
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
# CONFIG_RD_LZO is not set
CONFIG_RD_LZ4=y
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
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
CONFIG_SYSCTL_SYSCALL=y
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
CONFIG_AIO=y
# CONFIG_ADVISE_SYSCALLS is not set
# CONFIG_MEMBARRIER is not set
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
# CONFIG_SLUB is not set
CONFIG_SLOB=y
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SYSTEM_DATA_VERIFICATION is not set
CONFIG_PROFILING=y
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_OPROFILE=y
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_JUMP_LABEL=y
CONFIG_STATIC_KEYS_SELFTEST=y
# CONFIG_UPROBES is not set
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
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
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
CONFIG_CC_STACKPROTECTOR_STRONG=y
# CONFIG_CC_STACKPROTECTOR_AUTO is not set
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
# CONFIG_HAVE_ARCH_HASH is not set
# CONFIG_ISA_BUS_API is not set
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
# CONFIG_CPU_NO_EFFICIENT_FFS is not set
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX is not set
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_PHYS_TO_DMA=y
CONFIG_ARCH_HAS_REFCOUNT=y
CONFIG_REFCOUNT_FULL=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
# CONFIG_MODULES is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_ZONED=y
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
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
CONFIG_MINIX_SUBPARTITION=y
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
CONFIG_ULTRIX_PARTITION=y
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
CONFIG_SYSV68_PARTITION=y
CONFIG_CMDLINE_PARTITION=y
CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
# CONFIG_IOSCHED_DEADLINE is not set
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"
CONFIG_MQ_IOSCHED_DEADLINE=y
# CONFIG_MQ_IOSCHED_KYBER is not set
CONFIG_IOSCHED_BFQ=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_FREEZER=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_FAST_FEATURE_TESTS is not set
# CONFIG_X86_X2APIC is not set
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_RETPOLINE is not set
CONFIG_INTEL_RDT=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
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
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
# CONFIG_DMI is not set
# CONFIG_GART_IOMMU is not set
# CONFIG_CALGARY_IOMMU is not set
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
# CONFIG_SCHED_SMT is not set
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=y
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=y
# CONFIG_VM86 is not set
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=y
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_INTEL is not set
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_X86_5LEVEL is not set
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_ARCH_USE_MEMREMAP_PROT=y
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
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
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
# CONFIG_BOUNCE is not set
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
# CONFIG_CLEANCACHE is not set
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_ZSWAP=y
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
CONFIG_Z3FOLD=y
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_ZONE_DEVICE=y
# CONFIG_ZONE_DEVICE is not set
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_BENCHMARK=y
# CONFIG_X86_PMEM_LEGACY is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
# CONFIG_X86_PAT is not set
CONFIG_ARCH_RANDOM=y
# CONFIG_X86_SMAP is not set
CONFIG_X86_INTEL_UMIP=y
CONFIG_X86_INTEL_MPX=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
# CONFIG_EFI is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_KEXEC_VERIFY_SIG=y
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
CONFIG_DEBUG_HOTPLUG_CPU0=y
CONFIG_COMPAT_VDSO=y
# CONFIG_LEGACY_VSYSCALL_NATIVE is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
# CONFIG_HIBERNATION is not set
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
CONFIG_PM_SLEEP_DEBUG=y
CONFIG_DPM_WATCHDOG=y
CONFIG_DPM_WATCHDOG_TIMEOUT=120
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
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=y
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
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
# CONFIG_ACPI_EXTLOG is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
# CONFIG_CPUFREQ_DT is not set
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=y

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y

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
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_BUS_ADDR_T_64BIT=y
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
CONFIG_PCIE_CADENCE=y
# CONFIG_PCIE_CADENCE_HOST is not set
CONFIG_PCIE_CADENCE_EP=y

#
# DesignWare PCI Core Support
#

#
# PCI host controller drivers
#

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
# CONFIG_PCI_ENDPOINT_CONFIGFS is not set
# CONFIG_PCI_EPF_TEST is not set

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# CONFIG_ISA_BUS is not set
# CONFIG_ISA_DMA_API is not set
CONFIG_AMD_NB=y
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set
# CONFIG_X86_SYSFB is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_HAVE_AOUT is not set
CONFIG_BINFMT_MISC=y
# CONFIG_COREDUMP is not set
CONFIG_IA32_EMULATION=y
# CONFIG_IA32_AOUT is not set
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_NET=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
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
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_STREAM_PARSER is not set
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_STREAM_PARSER is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set
# CONFIG_LIB80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
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
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_ALLOW_DEV_COREDUMP is not set
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
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
CONFIG_CMA_SIZE_SEL_PERCENTAGE=y
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8

#
# Bus devices
#
CONFIG_SIMPLE_PM_BUS=y
# CONFIG_CONNECTOR is not set
CONFIG_MTD=y
# CONFIG_MTD_REDBOOT_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_OF_PARTS is not set
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
CONFIG_NFTL_RW=y
CONFIG_INFTL=y
CONFIG_RFD_FTL=y
# CONFIG_SSFDC is not set
CONFIG_SM_FTL=y
# CONFIG_MTD_OOPS is not set
CONFIG_MTD_SWAP=y
# CONFIG_MTD_PARTITIONED_MASTER is not set

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
CONFIG_MTD_CFI_GEOMETRY=y
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
CONFIG_MTD_MAP_BANK_WIDTH_16=y
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_I4=y
CONFIG_MTD_CFI_I8=y
# CONFIG_MTD_OTP is not set
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
CONFIG_MTD_ROM=y
CONFIG_MTD_ABSENT=y

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_PHYSMAP is not set
# CONFIG_MTD_PHYSMAP_OF is not set
CONFIG_MTD_AMD76XROM=y
CONFIG_MTD_ICHXROM=y
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=y
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=y

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_DATAFLASH=y
CONFIG_MTD_DATAFLASH_WRITE_VERIFY=y
# CONFIG_MTD_DATAFLASH_OTP is not set
CONFIG_MTD_M25P80=y
CONFIG_MTD_MCHP23K256=y
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
CONFIG_MTD_PHRAM=y
CONFIG_MTD_MTDRAM=y
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
CONFIG_MTD_BLOCK2MTD=y

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SMC=y
CONFIG_MTD_NAND=y
CONFIG_MTD_NAND_BCH=y
CONFIG_MTD_NAND_ECC_BCH=y
# CONFIG_MTD_SM_COMMON is not set
# CONFIG_MTD_NAND_DENALI_PCI is not set
# CONFIG_MTD_NAND_DENALI_DT is not set
# CONFIG_MTD_NAND_GPIO is not set
# CONFIG_MTD_NAND_OMAP_BCH_BUILD is not set
# CONFIG_MTD_NAND_RICOH is not set
# CONFIG_MTD_NAND_DISKONCHIP is not set
CONFIG_MTD_NAND_DOCG4=y
# CONFIG_MTD_NAND_CAFE is not set
CONFIG_MTD_NAND_NANDSIM=y
CONFIG_MTD_NAND_PLATFORM=y
# CONFIG_MTD_ONENAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
CONFIG_MTD_SPI_NOR=y
CONFIG_MTD_MT81xx_NOR=y
# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
# CONFIG_SPI_INTEL_SPI_PCI is not set
# CONFIG_SPI_INTEL_SPI_PLATFORM is not set
# CONFIG_MTD_UBI is not set
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_KOBJ=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
# CONFIG_OF_OVERLAY is not set
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
CONFIG_CDROM=y
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_CDROM_PKTCDVD_WCACHE=y
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=y
CONFIG_VIRTIO_BLK_SCSI=y
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_MULTIPATH is not set
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
CONFIG_NVME_TARGET=y
CONFIG_NVME_TARGET_LOOP=y
# CONFIG_NVME_TARGET_FC is not set

#
# Misc devices
#
# CONFIG_SENSORS_LIS3LV02D is not set
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
CONFIG_AD525X_DPOT_SPI=y
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=y
# CONFIG_DS1682 is not set
CONFIG_USB_SWITCH_FSA9480=y
CONFIG_LATTICE_ECP3_CONFIG=y
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_MISC_RTSX=y
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
# CONFIG_EEPROM_AT25 is not set
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=y
# CONFIG_EEPROM_93XX46 is not set
CONFIG_EEPROM_IDT_89HPESX=y
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# CONFIG_SENSORS_LIS3_I2C is not set
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
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

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
# CONFIG_GENWQE is not set
CONFIG_ECHO=y
# CONFIG_CXL_BASE is not set
# CONFIG_CXL_AFU_DRIVER_OPS is not set
# CONFIG_CXL_LIB is not set
# CONFIG_OCXL_BASE is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=y
CONFIG_HAVE_IDE=y
CONFIG_IDE=y

#
# Please see Documentation/ide/ide.txt for help/info on IDE drives
#
CONFIG_IDE_XFER_MODE=y
CONFIG_IDE_TIMINGS=y
CONFIG_IDE_ATAPI=y
CONFIG_BLK_DEV_IDE_SATA=y
# CONFIG_IDE_GD is not set
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEACPI is not set
CONFIG_IDE_TASK_IOCTL=y
# CONFIG_IDE_PROC_FS is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_PLATFORM is not set
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_IDEPNP is not set

#
# PCI IDE chipsets support
#
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT8172 is not set
# CONFIG_BLK_DEV_IT8213 is not set
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_BLK_DEV_TC86C001 is not set
# CONFIG_BLK_DEV_IDEDMA is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_NETLINK is not set
# CONFIG_SCSI_MQ_DEFAULT is not set
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
CONFIG_CHR_DEV_OSST=y
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
CONFIG_CHR_DEV_SCH=y
CONFIG_SCSI_ENCLOSURE=y
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
# CONFIG_SCSI_SAS_LIBSAS is not set
CONFIG_SCSI_SRP_ATTRS=y
CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
CONFIG_ISCSI_BOOT_SYSFS=y
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
CONFIG_SCSI_UFSHCD=y
# CONFIG_SCSI_UFSHCD_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_ISCI is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=y
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
CONFIG_SCSI_VIRTIO=y
CONFIG_SCSI_DH=y
# CONFIG_SCSI_DH_RDAC is not set
# CONFIG_SCSI_DH_HP_SW is not set
CONFIG_SCSI_DH_EMC=y
# CONFIG_SCSI_DH_ALUA is not set
CONFIG_SCSI_OSD_INITIATOR=y
CONFIG_SCSI_OSD_ULD=y
CONFIG_SCSI_OSD_DPRINT_SENSE=1
CONFIG_SCSI_OSD_DEBUG=y
# CONFIG_ATA is not set
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
# CONFIG_FIREWIRE_OHCI is not set
# CONFIG_FIREWIRE_SBP2 is not set
# CONFIG_FIREWIRE_NET is not set
# CONFIG_FIREWIRE_NOSY is not set
CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

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
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
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
CONFIG_NET_VENDOR_EXAR=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
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
# CONFIG_I40E is not set
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
# CONFIG_QCA7000_SPI is not set
# CONFIG_QCA7000_UART is not set
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
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
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
# CONFIG_KEYBOARD_STMPE is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
CONFIG_JOYSTICK_A3D=y
CONFIG_JOYSTICK_ADI=y
CONFIG_JOYSTICK_COBRA=y
CONFIG_JOYSTICK_GF2K=y
CONFIG_JOYSTICK_GRIP=y
# CONFIG_JOYSTICK_GRIP_MP is not set
CONFIG_JOYSTICK_GUILLEMOT=y
CONFIG_JOYSTICK_INTERACT=y
# CONFIG_JOYSTICK_SIDEWINDER is not set
CONFIG_JOYSTICK_TMDC=y
CONFIG_JOYSTICK_IFORCE=y
CONFIG_JOYSTICK_IFORCE_USB=y
# CONFIG_JOYSTICK_IFORCE_232 is not set
CONFIG_JOYSTICK_WARRIOR=y
CONFIG_JOYSTICK_MAGELLAN=y
CONFIG_JOYSTICK_SPACEORB=y
# CONFIG_JOYSTICK_SPACEBALL is not set
CONFIG_JOYSTICK_STINGER=y
# CONFIG_JOYSTICK_TWIDJOY is not set
CONFIG_JOYSTICK_ZHENHUA=y
# CONFIG_JOYSTICK_AS5011 is not set
CONFIG_JOYSTICK_JOYDUMP=y
CONFIG_JOYSTICK_XPAD=y
# CONFIG_JOYSTICK_XPAD_FF is not set
CONFIG_JOYSTICK_XPAD_LEDS=y
# CONFIG_JOYSTICK_PSXPAD_SPI is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_GTCO is not set
CONFIG_TABLET_USB_HANWANG=y
CONFIG_TABLET_USB_KBTAB=y
CONFIG_TABLET_USB_PEGASUS=y
CONFIG_TABLET_SERIAL_WACOM4=y
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_88PM860X is not set
# CONFIG_TOUCHSCREEN_ADS7846 is not set
CONFIG_TOUCHSCREEN_AD7877=y
# CONFIG_TOUCHSCREEN_AD7879 is not set
CONFIG_TOUCHSCREEN_AR1021_I2C=y
CONFIG_TOUCHSCREEN_ATMEL_MXT=y
CONFIG_TOUCHSCREEN_ATMEL_MXT_T37=y
CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
# CONFIG_TOUCHSCREEN_BU21013 is not set
CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=y
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP_I2C=y
CONFIG_TOUCHSCREEN_CYTTSP_SPI=y
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP4_I2C=y
CONFIG_TOUCHSCREEN_CYTTSP4_SPI=y
CONFIG_TOUCHSCREEN_DYNAPRO=y
CONFIG_TOUCHSCREEN_HAMPSHIRE=y
CONFIG_TOUCHSCREEN_EETI=y
CONFIG_TOUCHSCREEN_EGALAX=y
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
CONFIG_TOUCHSCREEN_FUJITSU=y
CONFIG_TOUCHSCREEN_GOODIX=y
# CONFIG_TOUCHSCREEN_HIDEEP is not set
CONFIG_TOUCHSCREEN_ILI210X=y
CONFIG_TOUCHSCREEN_S6SY761=y
# CONFIG_TOUCHSCREEN_GUNZE is not set
CONFIG_TOUCHSCREEN_EKTF2127=y
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=y
# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
CONFIG_TOUCHSCREEN_WACOM_I2C=y
CONFIG_TOUCHSCREEN_MAX11801=y
CONFIG_TOUCHSCREEN_MCS5000=y
# CONFIG_TOUCHSCREEN_MMS114 is not set
CONFIG_TOUCHSCREEN_MELFAS_MIP4=y
CONFIG_TOUCHSCREEN_MTOUCH=y
CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
CONFIG_TOUCHSCREEN_PENMOUNT=y
CONFIG_TOUCHSCREEN_EDT_FT5X06=y
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
CONFIG_TOUCHSCREEN_TOUCHWIN=y
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=y
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
CONFIG_TOUCHSCREEN_MC13783=y
CONFIG_TOUCHSCREEN_TOUCHIT213=y
CONFIG_TOUCHSCREEN_TSC_SERIO=y
CONFIG_TOUCHSCREEN_TSC200X_CORE=y
CONFIG_TOUCHSCREEN_TSC2004=y
CONFIG_TOUCHSCREEN_TSC2005=y
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_PCAP is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
CONFIG_TOUCHSCREEN_SILEAD=y
CONFIG_TOUCHSCREEN_SIS_I2C=y
# CONFIG_TOUCHSCREEN_ST1232 is not set
CONFIG_TOUCHSCREEN_STMFTS=y
# CONFIG_TOUCHSCREEN_STMPE is not set
CONFIG_TOUCHSCREEN_SUR40=y
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
CONFIG_TOUCHSCREEN_SX8654=y
# CONFIG_TOUCHSCREEN_TPS6507X is not set
CONFIG_TOUCHSCREEN_ZET6223=y
CONFIG_TOUCHSCREEN_ZFORCE=y
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SPI is not set
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
# CONFIG_RMI4_F11 is not set
CONFIG_RMI4_F12=y
# CONFIG_RMI4_F30 is not set
# CONFIG_RMI4_F34 is not set
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
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_APBPS2=y
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_SYNCLINK_GT is not set
# CONFIG_NOZOMI is not set
# CONFIG_ISI is not set
CONFIG_N_HDLC=y
# CONFIG_N_GSM is not set
CONFIG_TRACE_ROUTER=y
CONFIG_TRACE_SINK=y
CONFIG_DEVMEM=y
CONFIG_DEVKMEM=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
# CONFIG_SERIAL_8250_FSL is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set
# CONFIG_SERIAL_OF_PLATFORM is not set

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
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=y
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
# CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE is not set
CONFIG_SERIAL_DEV_BUS=y
# CONFIG_SERIAL_DEV_CTRL_TTYPORT is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_HVC_DRIVER=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=y
# CONFIG_IPMI_PROC_INTERFACE is not set
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
CONFIG_IPMI_WATCHDOG=y
CONFIG_IPMI_POWEROFF=y
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
CONFIG_R3964=y
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=256
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
CONFIG_TCG_TIS_I2C_ATMEL=y
# CONFIG_TCG_TIS_I2C_INFINEON is not set
CONFIG_TCG_TIS_I2C_NUVOTON=y
# CONFIG_TCG_NSC is not set
# CONFIG_TCG_ATMEL is not set
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=y
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_OF=y

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
CONFIG_I2C_MUX_GPIO=y
# CONFIG_I2C_MUX_GPMUX is not set
CONFIG_I2C_MUX_LTC4306=y
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_ALGOBIT=y

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
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
CONFIG_I2C_DESIGNWARE_SLAVE=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=y
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
# CONFIG_I2C_KEMPLD is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_PXA_PCI is not set
# CONFIG_I2C_RK3X is not set
# CONFIG_I2C_SIMTEC is not set
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
CONFIG_I2C_ROBOTFUZZ_OSIF=y
CONFIG_I2C_TAOS_EVM=y
CONFIG_I2C_TINY_USB=y

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=y
CONFIG_I2C_CROS_EC_TUNNEL=y
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
CONFIG_SPI_DEBUG=y
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
# CONFIG_SPI_AXI_SPI_ENGINE is not set
CONFIG_SPI_BITBANG=y
CONFIG_SPI_CADENCE=y
CONFIG_SPI_DESIGNWARE=y
# CONFIG_SPI_DW_PCI is not set
CONFIG_SPI_DW_MMIO=y
CONFIG_SPI_GPIO=y
CONFIG_SPI_FSL_LIB=y
CONFIG_SPI_FSL_SPI=y
CONFIG_SPI_OC_TINY=y
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_PXA2XX_PCI is not set
CONFIG_SPI_ROCKCHIP=y
CONFIG_SPI_SC18IS602=y
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
CONFIG_SPI_SLAVE_SYSTEM_CONTROL=y
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
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
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
# CONFIG_PINCTRL is not set
CONFIG_GPIOLIB=y
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
CONFIG_GPIO_ALTERA=y
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_FTGPIO010 is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_GRGPIO=y
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=y
# CONFIG_GPIO_MOCKUP is not set
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set

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
# CONFIG_GPIO_ADNP is not set
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
CONFIG_GPIO_MAX732X_IRQ=y
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=y
CONFIG_GPIO_BD9571MWV=y
# CONFIG_GPIO_DA9055 is not set
# CONFIG_GPIO_KEMPLD is not set
CONFIG_GPIO_LP3943=y
# CONFIG_GPIO_LP873X is not set
# CONFIG_GPIO_MAX77620 is not set
# CONFIG_GPIO_STMPE is not set
CONFIG_GPIO_TPS65086=y
# CONFIG_GPIO_TPS65218 is not set
CONFIG_GPIO_TPS65910=y
CONFIG_GPIO_WM8350=y
CONFIG_GPIO_WM8994=y

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set

#
# SPI GPIO expanders
#
CONFIG_GPIO_74X164=y
CONFIG_GPIO_MAX3191X=y
# CONFIG_GPIO_MAX7301 is not set
CONFIG_GPIO_MC33880=y
CONFIG_GPIO_PISOSR=y
CONFIG_GPIO_XRA1403=y

#
# USB GPIO expanders
#
CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
# CONFIG_W1_MASTER_DS2490 is not set
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=y

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=y
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2805=y
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
# CONFIG_W1_SLAVE_DS2433_CRC is not set
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS2760=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
# CONFIG_W1_SLAVE_DS28E17 is not set
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_GPIO=y
# CONFIG_POWER_RESET_GPIO_RESTART is not set
CONFIG_POWER_RESET_LTC2952=y
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_RESET_SYSCON=y
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
# CONFIG_SYSCON_REBOOT_MODE is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
# CONFIG_PDA_POWER is not set
CONFIG_GENERIC_ADC_BATTERY=y
# CONFIG_WM8350_POWER is not set
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=y
# CONFIG_BATTERY_ACT8945A is not set
CONFIG_BATTERY_CPCAP=y
CONFIG_BATTERY_DS2760=y
# CONFIG_BATTERY_DS2780 is not set
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_LEGO_EV3=y
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=y
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_AXP20X_POWER=y
CONFIG_AXP288_CHARGER=y
# CONFIG_AXP288_FUEL_GAUGE is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_CHARGER_88PM860X=y
CONFIG_CHARGER_ISP1704=y
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LTC3651=y
CONFIG_CHARGER_MAX14577=y
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
CONFIG_CHARGER_MAX77693=y
CONFIG_CHARGER_MAX8997=y
CONFIG_CHARGER_BQ2415X=y
# CONFIG_CHARGER_BQ24190 is not set
CONFIG_CHARGER_BQ24257=y
# CONFIG_CHARGER_BQ24735 is not set
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_SMB347=y
# CONFIG_CHARGER_TPS65090 is not set
# CONFIG_CHARGER_TPS65217 is not set
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
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1021 is not set
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7310=y
CONFIG_SENSORS_ADT7410=y
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_APPLESMC=y
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ASPEED=y
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_DA9055 is not set
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_MC13783_ADC is not set
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_GL518SM=y
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_G760A is not set
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_GPIO_FAN=y
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=y
CONFIG_SENSORS_IBMPEX=y
CONFIG_SENSORS_IIO_HWMON=y
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LINEAGE=y
# CONFIG_SENSORS_LTC2945 is not set
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC4151=y
CONFIG_SENSORS_LTC4215=y
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX1111=y
# CONFIG_SENSORS_MAX16065 is not set
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=y
CONFIG_SENSORS_MAX6642=y
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=y
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=y
CONFIG_SENSORS_TC654=y
CONFIG_SENSORS_MENF21BMC_HWMON=y
CONFIG_SENSORS_ADCXX=y
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM70=y
# CONFIG_SENSORS_LM73 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=y
CONFIG_SENSORS_LM87=y
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=y
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NTC_THERMISTOR is not set
CONFIG_SENSORS_NCT6683=y
# CONFIG_SENSORS_NCT6775 is not set
CONFIG_SENSORS_NCT7802=y
CONFIG_SENSORS_NCT7904=y
CONFIG_SENSORS_PCF8591=y
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
CONFIG_SENSORS_ADM1275=y
CONFIG_SENSORS_IBM_CFFPS=y
CONFIG_SENSORS_IR35221=y
CONFIG_SENSORS_LM25066=y
# CONFIG_SENSORS_LTC2978 is not set
CONFIG_SENSORS_LTC3815=y
CONFIG_SENSORS_MAX16064=y
# CONFIG_SENSORS_MAX20751 is not set
CONFIG_SENSORS_MAX31785=y
# CONFIG_SENSORS_MAX34440 is not set
# CONFIG_SENSORS_MAX8688 is not set
CONFIG_SENSORS_TPS40422=y
# CONFIG_SENSORS_TPS53679 is not set
# CONFIG_SENSORS_UCD9000 is not set
CONFIG_SENSORS_UCD9200=y
# CONFIG_SENSORS_ZL6100 is not set
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHT3x=y
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=y
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
# CONFIG_SENSORS_SMSC47M192 is not set
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS1015=y
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_ADS7871=y
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_INA3221=y
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
# CONFIG_SENSORS_TMP401 is not set
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=y
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=y
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y
CONFIG_SENSORS_WM8350=y
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CPU_THERMAL is not set
# CONFIG_CLOCK_THERMAL is not set
CONFIG_DEVFREQ_THERMAL=y
CONFIG_THERMAL_EMULATION=y
CONFIG_MAX77620_THERMAL=y
# CONFIG_QORIQ_THERMAL is not set
# CONFIG_DA9062_THERMAL is not set
CONFIG_INTEL_POWERCLAMP=y
CONFIG_X86_PKG_TEMP_THERMAL=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_QCOM_SPMI_TEMP_ALARM=y
# CONFIG_GENERIC_ADC_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_SFLASH is not set
CONFIG_BCMA_DRIVER_GMAC_CMN=y
# CONFIG_BCMA_DRIVER_GPIO is not set
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_ACT8945A=y
CONFIG_MFD_AS3711=y
# CONFIG_MFD_AS3722 is not set
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_ATMEL_FLEXCOM=y
CONFIG_MFD_ATMEL_HLCDC=y
# CONFIG_MFD_BCM590XX is not set
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_CROS_EC=y
CONFIG_MFD_CROS_EC_I2C=y
# CONFIG_MFD_CROS_EC_SPI is not set
CONFIG_MFD_CROS_EC_CHARDEV=y
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
CONFIG_MFD_MC13XXX_I2C=y
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
CONFIG_MFD_88PM800=y
# CONFIG_MFD_88PM805 is not set
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77620=y
CONFIG_MFD_MAX77686=y
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
CONFIG_EZX_PCAP=y
CONFIG_MFD_CPCAP=y
# CONFIG_MFD_VIPERBOARD is not set
CONFIG_MFD_RETU=y
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_RK808 is not set
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
# CONFIG_AB3100_OTP is not set
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
# CONFIG_STMPE_I2C is not set
CONFIG_STMPE_SPI=y
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TPS65217=y
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TI_LP87565 is not set
CONFIG_MFD_TPS65218=y
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
CONFIG_MFD_TPS80031=y
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TC3589X is not set
# CONFIG_MFD_TMIO is not set
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8400=y
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
CONFIG_RAVE_SP_CORE=y
CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
# CONFIG_REGULATOR_88PM800 is not set
CONFIG_REGULATOR_88PM8607=y
CONFIG_REGULATOR_ACT8865=y
# CONFIG_REGULATOR_ACT8945A is not set
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_ANATOP=y
CONFIG_REGULATOR_AAT2870=y
CONFIG_REGULATOR_AB3100=y
# CONFIG_REGULATOR_AS3711 is not set
# CONFIG_REGULATOR_AXP20X is not set
CONFIG_REGULATOR_BD9571MWV=y
CONFIG_REGULATOR_CPCAP=y
# CONFIG_REGULATOR_DA9055 is not set
# CONFIG_REGULATOR_DA9062 is not set
CONFIG_REGULATOR_DA9063=y
# CONFIG_REGULATOR_DA9210 is not set
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_GPIO=y
# CONFIG_REGULATOR_HI6421 is not set
CONFIG_REGULATOR_HI6421V530=y
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
# CONFIG_REGULATOR_LM363X is not set
CONFIG_REGULATOR_LP3971=y
# CONFIG_REGULATOR_LP3972 is not set
CONFIG_REGULATOR_LP872X=y
# CONFIG_REGULATOR_LP873X is not set
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LTC3589=y
# CONFIG_REGULATOR_LTC3676 is not set
# CONFIG_REGULATOR_MAX14577 is not set
CONFIG_REGULATOR_MAX1586=y
# CONFIG_REGULATOR_MAX77620 is not set
# CONFIG_REGULATOR_MAX8649 is not set
# CONFIG_REGULATOR_MAX8660 is not set
# CONFIG_REGULATOR_MAX8907 is not set
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8973=y
CONFIG_REGULATOR_MAX8997=y
CONFIG_REGULATOR_MAX77686=y
CONFIG_REGULATOR_MAX77693=y
CONFIG_REGULATOR_MAX77802=y
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
# CONFIG_REGULATOR_MC13892 is not set
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_MT6323=y
CONFIG_REGULATOR_MT6397=y
CONFIG_REGULATOR_PCAP=y
# CONFIG_REGULATOR_PFUZE100 is not set
CONFIG_REGULATOR_PV88060=y
# CONFIG_REGULATOR_PV88080 is not set
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_QCOM_SPMI=y
CONFIG_REGULATOR_RN5T618=y
CONFIG_REGULATOR_RT5033=y
CONFIG_REGULATOR_S2MPA01=y
CONFIG_REGULATOR_S2MPS11=y
# CONFIG_REGULATOR_S5M8767 is not set
CONFIG_REGULATOR_SKY81452=y
# CONFIG_REGULATOR_TPS51632 is not set
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS65023=y
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65086=y
CONFIG_REGULATOR_TPS65090=y
# CONFIG_REGULATOR_TPS65132 is not set
# CONFIG_REGULATOR_TPS65217 is not set
CONFIG_REGULATOR_TPS65218=y
CONFIG_REGULATOR_TPS6524X=y
CONFIG_REGULATOR_TPS65910=y
CONFIG_REGULATOR_TPS80031=y
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_WM8350=y
CONFIG_REGULATOR_WM8400=y
# CONFIG_REGULATOR_WM8994 is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
CONFIG_CEC_PIN=y
CONFIG_RC_CORE=y
CONFIG_RC_MAP=y
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
# CONFIG_IR_NEC_DECODER is not set
CONFIG_IR_RC5_DECODER=y
CONFIG_IR_RC6_DECODER=y
CONFIG_IR_JVC_DECODER=y
# CONFIG_IR_SONY_DECODER is not set
# CONFIG_IR_SANYO_DECODER is not set
# CONFIG_IR_SHARP_DECODER is not set
# CONFIG_IR_MCE_KBD_DECODER is not set
CONFIG_IR_XMP_DECODER=y
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=y
# CONFIG_IR_ENE is not set
CONFIG_IR_HIX5HD2=y
CONFIG_IR_IMON=y
CONFIG_IR_MCEUSB=y
# CONFIG_IR_ITE_CIR is not set
# CONFIG_IR_FINTEK is not set
# CONFIG_IR_NUVOTON is not set
CONFIG_IR_REDRAT3=y
# CONFIG_IR_SPI is not set
CONFIG_IR_STREAMZAP=y
# CONFIG_IR_WINBOND_CIR is not set
CONFIG_IR_IGORPLUGUSB=y
CONFIG_IR_IGUANA=y
# CONFIG_IR_TTUSBIR is not set
# CONFIG_RC_LOOPBACK is not set
# CONFIG_IR_GPIO_CIR is not set
# CONFIG_IR_GPIO_TX is not set
CONFIG_IR_SERIAL=y
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_SIR is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
# CONFIG_MEDIA_SDR_SUPPORT is not set
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_MEDIA_CEC_RC=y
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_V4L2=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=y
CONFIG_V4L2_FWNODE=y
CONFIG_VIDEOBUF_GEN=y
CONFIG_VIDEOBUF_VMALLOC=y
CONFIG_VIDEOBUF_DVB=y
CONFIG_DVB_CORE=y
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
# CONFIG_TTPCI_EEPROM is not set
CONFIG_DVB_MAX_ADAPTERS=16
# CONFIG_DVB_DYNAMIC_MINORS is not set
CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=y
# CONFIG_VIDEO_PVRUSB2_SYSFS is not set
# CONFIG_VIDEO_PVRUSB2_DVB is not set
CONFIG_VIDEO_HDPVR=y
CONFIG_VIDEO_USBVISION=y
CONFIG_VIDEO_STK1160_COMMON=y
CONFIG_VIDEO_STK1160=y

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=y
# CONFIG_VIDEO_AU0828_V4L2 is not set
# CONFIG_VIDEO_AU0828_RC is not set
CONFIG_VIDEO_CX231XX=y
# CONFIG_VIDEO_CX231XX_RC is not set
CONFIG_VIDEO_CX231XX_DVB=y
# CONFIG_VIDEO_TM6000 is not set

#
# Digital TV USB devices
#
# CONFIG_DVB_USB is not set
CONFIG_DVB_USB_V2=y
# CONFIG_DVB_USB_AF9015 is not set
# CONFIG_DVB_USB_AF9035 is not set
# CONFIG_DVB_USB_ANYSEE is not set
CONFIG_DVB_USB_AU6610=y
# CONFIG_DVB_USB_AZ6007 is not set
CONFIG_DVB_USB_CE6230=y
# CONFIG_DVB_USB_EC168 is not set
CONFIG_DVB_USB_GL861=y
# CONFIG_DVB_USB_LME2510 is not set
CONFIG_DVB_USB_MXL111SF=y
CONFIG_DVB_USB_RTL28XXU=y
# CONFIG_DVB_USB_DVBSKY is not set
CONFIG_DVB_USB_ZD1301=y
# CONFIG_DVB_TTUSB_BUDGET is not set
# CONFIG_DVB_TTUSB_DEC is not set
CONFIG_SMS_USB_DRV=y
CONFIG_DVB_B2C2_FLEXCOP_USB=y
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
CONFIG_DVB_AS102=y

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=y
CONFIG_VIDEO_EM28XX_V4L2=y
CONFIG_VIDEO_EM28XX_DVB=y
# CONFIG_VIDEO_EM28XX_RC is not set

#
# USB HDMI CEC adapters
#
# CONFIG_USB_PULSE8_CEC is not set
CONFIG_USB_RAINSHADOW_CEC=y
# CONFIG_MEDIA_PCI_SUPPORT is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
CONFIG_CEC_PLATFORM_DRIVERS=y
CONFIG_CEC_GPIO=y

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=y
CONFIG_RADIO_ADAPTERS=y
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
CONFIG_USB_MR800=y
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
CONFIG_USB_KEENE=y
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
CONFIG_RADIO_TEA5764=y
# CONFIG_RADIO_TEA5764_XTAL is not set
CONFIG_RADIO_SAA7706H=y
CONFIG_RADIO_TEF6862=y
# CONFIG_RADIO_WL1273 is not set

#
# Texas Instruments WL128x FM driver (ST based)
#

#
# Supported FireWire (IEEE 1394) Adapters
#
# CONFIG_DVB_FIREDTV is not set
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=y
CONFIG_VIDEO_TVEEPROM=y
CONFIG_CYPRESS_FIRMWARE=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_VIDEOBUF2_DMA_SG=y
CONFIG_DVB_B2C2_FLEXCOP=y
CONFIG_SMS_SIANO_MDTV=y
CONFIG_SMS_SIANO_RC=y
CONFIG_SMS_SIANO_DEBUGFS=y

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_VIDEO_IR_I2C=y

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_MSP3400=y
CONFIG_VIDEO_CS53L32A=y
CONFIG_VIDEO_WM8775=y

#
# RDS decoders
#

#
# Video decoders
#
CONFIG_VIDEO_SAA711X=y
CONFIG_VIDEO_TVP5150=y

#
# Video and audio decoders
#
CONFIG_VIDEO_CX25840=y

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
CONFIG_MEDIA_TUNER=y
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_MT2060=y
CONFIG_MEDIA_TUNER_QT1010=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MXL5005S=y
CONFIG_MEDIA_TUNER_MXL5007T=y
CONFIG_MEDIA_TUNER_MC44S803=y
CONFIG_MEDIA_TUNER_FC0012=y
CONFIG_MEDIA_TUNER_FC0013=y
CONFIG_MEDIA_TUNER_TDA18212=y
CONFIG_MEDIA_TUNER_E4000=y
CONFIG_MEDIA_TUNER_FC2580=y
CONFIG_MEDIA_TUNER_TUA9001=y
CONFIG_MEDIA_TUNER_SI2157=y
CONFIG_MEDIA_TUNER_R820T=y
CONFIG_MEDIA_TUNER_QM1D1C0042=y

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_M88DS3103=y

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=y
CONFIG_DVB_TDA18271C2DD=y
CONFIG_DVB_SI2165=y
CONFIG_DVB_MN88472=y
CONFIG_DVB_MN88473=y

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24123=y
CONFIG_DVB_MT312=y
CONFIG_DVB_S5H1420=y
CONFIG_DVB_STV0299=y
CONFIG_DVB_TUNER_ITD1000=y
CONFIG_DVB_TUNER_CX24113=y
CONFIG_DVB_CX24120=y
CONFIG_DVB_TS2020=y
CONFIG_DVB_TDA10071=y

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_DRXD=y
CONFIG_DVB_MT352=y
CONFIG_DVB_ZL10353=y
CONFIG_DVB_CXD2820R=y
CONFIG_DVB_RTL2830=y
CONFIG_DVB_RTL2832=y
CONFIG_DVB_SI2168=y
CONFIG_DVB_AS102_FE=y
CONFIG_DVB_ZD1301_DEMOD=y
# CONFIG_DVB_GP8PSK_FE is not set

#
# DVB-C (cable) frontends
#
CONFIG_DVB_TDA10023=y
CONFIG_DVB_STV0297=y

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=y
CONFIG_DVB_BCM3510=y
CONFIG_DVB_LGDT330X=y
CONFIG_DVB_LGDT3305=y
CONFIG_DVB_LGDT3306A=y
CONFIG_DVB_LG2160=y
CONFIG_DVB_S5H1409=y
CONFIG_DVB_AU8522=y
CONFIG_DVB_AU8522_DTV=y

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=y
CONFIG_DVB_MB86A20S=y

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=y

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=y

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=y
CONFIG_DVB_ISL6421=y
CONFIG_DVB_A8293=y

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DEBUG_MM=y
# CONFIG_DRM_DEBUG_MM_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_FBDEV_EMULATION is not set
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_TTM=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_VM=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
CONFIG_DRM_I2C_SIL164=y
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
# CONFIG_CHASH is not set
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
CONFIG_DRM_RCAR_DW_HDMI=y
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_BOCHS is not set
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_ILITEK_IL9322=y
CONFIG_DRM_PANEL_SAMSUNG_LD9040=y
# CONFIG_DRM_PANEL_LG_LG4573 is not set
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# CONFIG_DRM_DUMB_VGA_DAC is not set
CONFIG_DRM_LVDS_ENCODER=y
# CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW is not set
# CONFIG_DRM_NXP_PTN3460 is not set
# CONFIG_DRM_PARADE_PS8622 is not set
CONFIG_DRM_SIL_SII8620=y
CONFIG_DRM_SII902X=y
CONFIG_DRM_SII9234=y
CONFIG_DRM_TOSHIBA_TC358767=y
CONFIG_DRM_TI_TFP410=y
CONFIG_DRM_I2C_ADV7511=y
# CONFIG_DRM_I2C_ADV7533 is not set
# CONFIG_DRM_I2C_ADV7511_CEC is not set
CONFIG_DRM_DW_HDMI=y
CONFIG_DRM_DW_HDMI_CEC=y
CONFIG_DRM_ARCPGU=y
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_MXSFB is not set
# CONFIG_DRM_TINYDRM is not set
CONFIG_DRM_LEGACY=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
# CONFIG_DRM_LIB_RANDOM is not set

#
# Frame buffer Devices
#
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
# CONFIG_FB_DDC is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA is not set
CONFIG_FB_FOREIGN_ENDIAN=y
# CONFIG_FB_BOTH_ENDIAN is not set
CONFIG_FB_BIG_ENDIAN=y
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=y
# CONFIG_FB_SVGALIB is not set
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=y
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_FB_N411=y
CONFIG_FB_HGA=y
CONFIG_FB_OPENCORES=y
# CONFIG_FB_S1D13XXX is not set
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
CONFIG_FB_SM501=y
# CONFIG_FB_SMSCUFX is not set
CONFIG_FB_UDL=y
CONFIG_FB_IBM_GXT4500=y
CONFIG_FB_VIRTUAL=y
CONFIG_FB_METRONOME=y
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_BROADSHEET is not set
# CONFIG_FB_AUO_K190X is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
# CONFIG_VGASTATE is not set
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# CONFIG_LOGO is not set
# CONFIG_SOUND is not set

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
CONFIG_HID_APPLE=y
CONFIG_HID_ASUS=y
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
CONFIG_HID_CORSAIR=y
CONFIG_HID_CMEDIA=y
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELECOM is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_KEYTOUCH is not set
CONFIG_HID_KYE=y
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_GYRATION is not set
CONFIG_HID_ICADE=y
# CONFIG_HID_ITE is not set
CONFIG_HID_JABRA=y
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
# CONFIG_HID_LOGITECH is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=y
CONFIG_HID_NTI=y
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=y
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
# CONFIG_HID_PICOLCD_FB is not set
# CONFIG_HID_PICOLCD_LEDS is not set
CONFIG_HID_PICOLCD_CIR=y
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=y
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
CONFIG_HID_SMARTJOYPLUS=y
CONFIG_SMARTJOYPLUS_FF=y
CONFIG_HID_TIVO=y
# CONFIG_HID_TOPSEED is not set
CONFIG_HID_THINGM=y
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=y
# CONFIG_ZEROPLUS_FF is not set
# CONFIG_HID_ZYDACRON is not set
CONFIG_HID_SENSOR_HUB=y
# CONFIG_HID_SENSOR_CUSTOM_SENSOR is not set
# CONFIG_HID_ALPS is not set

#
# USB HID support
#
# CONFIG_USB_HID is not set
# CONFIG_HID_PID is not set

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=y
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
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_OTG=y
# CONFIG_USB_OTG_WHITELIST is not set
CONFIG_USB_OTG_BLACKLIST_HUB=y
CONFIG_USB_OTG_FSM=y
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
# CONFIG_USB_MON is not set
CONFIG_USB_WUSB=y
CONFIG_USB_WUSB_CBAF=y
CONFIG_USB_WUSB_CBAF_DEBUG=y

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=y
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
CONFIG_USB_EHCI_PCI=y
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=y
CONFIG_USB_ISP116X_HCD=y
# CONFIG_USB_ISP1362_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
# CONFIG_USB_UHCI_HCD is not set
CONFIG_USB_U132_HCD=y
CONFIG_USB_SL811_HCD=y
CONFIG_USB_SL811_HCD_ISO=y
CONFIG_USB_R8A66597_HCD=y
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=y
CONFIG_USB_HCD_BCMA=y
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=y
CONFIG_USB_PRINTER=y
CONFIG_USB_WDM=y
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
# CONFIG_USB_STORAGE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
CONFIG_USB_MICROTEK=y
# CONFIG_USBIP_CORE is not set
CONFIG_USB_MUSB_HDRC=y
# CONFIG_USB_MUSB_HOST is not set
# CONFIG_USB_MUSB_GADGET is not set
CONFIG_USB_MUSB_DUAL_ROLE=y

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
CONFIG_USB_DWC3=y
CONFIG_USB_DWC3_ULPI=y
# CONFIG_USB_DWC3_HOST is not set
CONFIG_USB_DWC3_GADGET=y
# CONFIG_USB_DWC3_DUAL_ROLE is not set

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=y
CONFIG_USB_DWC3_OF_SIMPLE=y
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
# CONFIG_USB_SERIAL_GENERIC is not set
CONFIG_USB_SERIAL_SIMPLE=y
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
CONFIG_USB_SERIAL_CH341=y
CONFIG_USB_SERIAL_WHITEHEAT=y
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=y
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
CONFIG_USB_SERIAL_EMPEG=y
# CONFIG_USB_SERIAL_FTDI_SIO is not set
CONFIG_USB_SERIAL_VISOR=y
# CONFIG_USB_SERIAL_IPAQ is not set
CONFIG_USB_SERIAL_IR=y
# CONFIG_USB_SERIAL_EDGEPORT is not set
CONFIG_USB_SERIAL_EDGEPORT_TI=y
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=y
CONFIG_USB_SERIAL_IPW=y
# CONFIG_USB_SERIAL_IUU is not set
CONFIG_USB_SERIAL_KEYSPAN_PDA=y
# CONFIG_USB_SERIAL_KEYSPAN is not set
CONFIG_USB_SERIAL_KLSI=y
CONFIG_USB_SERIAL_KOBIL_SCT=y
CONFIG_USB_SERIAL_MCT_U232=y
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
CONFIG_USB_SERIAL_MOS7840=y
CONFIG_USB_SERIAL_MXUPORT=y
# CONFIG_USB_SERIAL_NAVMAN is not set
CONFIG_USB_SERIAL_PL2303=y
CONFIG_USB_SERIAL_OTI6858=y
# CONFIG_USB_SERIAL_QCAUX is not set
CONFIG_USB_SERIAL_QUALCOMM=y
# CONFIG_USB_SERIAL_SPCP8X5 is not set
CONFIG_USB_SERIAL_SAFE=y
# CONFIG_USB_SERIAL_SAFE_PADDED is not set
CONFIG_USB_SERIAL_SIERRAWIRELESS=y
CONFIG_USB_SERIAL_SYMBOL=y
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=y
CONFIG_USB_SERIAL_XIRCOM=y
CONFIG_USB_SERIAL_WWAN=y
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
CONFIG_USB_SERIAL_OPTICON=y
CONFIG_USB_SERIAL_XSENS_MT=y
CONFIG_USB_SERIAL_WISHBONE=y
# CONFIG_USB_SERIAL_SSU100 is not set
CONFIG_USB_SERIAL_QT2=y
CONFIG_USB_SERIAL_UPD78F0730=y
CONFIG_USB_SERIAL_DEBUG=y

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
CONFIG_USB_SEVSEG=y
CONFIG_USB_RIO500=y
CONFIG_USB_LEGOTOWER=y
CONFIG_USB_LCD=y
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=y
CONFIG_USB_FTDI_ELAN=y
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
CONFIG_USB_LD=y
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=y
# CONFIG_USB_TEST is not set
CONFIG_USB_EHSET_TEST_FIXTURE=y
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=y
CONFIG_USB_HUB_USB251XB=y
CONFIG_USB_HSIC_USB3503=y
CONFIG_USB_HSIC_USB4604=y
# CONFIG_USB_LINK_LAYER_TEST is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
# CONFIG_USB_GPIO_VBUS is not set
CONFIG_TAHVO_USB=y
CONFIG_TAHVO_USB_HOST_BY_DEFAULT=y
# CONFIG_USB_ISP1301 is not set
CONFIG_USB_GADGET=y
CONFIG_USB_GADGET_DEBUG=y
CONFIG_USB_GADGET_VERBOSE=y
CONFIG_USB_GADGET_DEBUG_FILES=y
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
CONFIG_USB_FOTG210_UDC=y
# CONFIG_USB_GR_UDC is not set
# CONFIG_USB_R8A66597 is not set
CONFIG_USB_PXA27X=y
CONFIG_USB_MV_UDC=y
# CONFIG_USB_MV_U3D is not set
CONFIG_USB_SNP_CORE=y
CONFIG_USB_SNP_UDC_PLAT=y
# CONFIG_USB_M66592 is not set
CONFIG_USB_BDC_UDC=y

#
# Platform Support
#
CONFIG_USB_BDC_PCI=y
# CONFIG_USB_AMD5536UDC is not set
CONFIG_USB_NET2272=y
CONFIG_USB_NET2272_DMA=y
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
CONFIG_USB_GADGET_XILINX=y
CONFIG_USB_DUMMY_HCD=y
# CONFIG_USB_CONFIGFS is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_LED_TRIG is not set
CONFIG_USB_ULPI_BUS=y
CONFIG_UWB=y
CONFIG_UWB_HWA=y
# CONFIG_UWB_WHCI is not set
CONFIG_UWB_I1480U=y
CONFIG_MMC=y
CONFIG_PWRSEQ_EMMC=y
CONFIG_PWRSEQ_SIMPLE=y
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=y
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=y
# CONFIG_MMC_SDHCI_PCI is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=y
# CONFIG_MMC_SDHCI_OF_ARASAN is not set
CONFIG_MMC_SDHCI_OF_AT91=y
# CONFIG_MMC_SDHCI_CADENCE is not set
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
CONFIG_MMC_USDHI6ROL0=y
# CONFIG_MMC_REALTEK_USB is not set
# CONFIG_MMC_CQHCI is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
CONFIG_MMC_SDHCI_XENON=y
CONFIG_MMC_SDHCI_OMAP=y
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
CONFIG_MSPRO_BLOCK=y
CONFIG_MS_BLOCK=y

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_MEMSTICK_REALTEK_USB=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_88PM860X=y
CONFIG_LEDS_AS3645A=y
CONFIG_LEDS_BCM6328=y
CONFIG_LEDS_BCM6358=y
CONFIG_LEDS_CPCAP=y
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_LM3692X=y
# CONFIG_LEDS_MT6323 is not set
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
CONFIG_LEDS_LP5523=y
# CONFIG_LEDS_LP5562 is not set
CONFIG_LEDS_LP8501=y
# CONFIG_LEDS_LP8860 is not set
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=y
# CONFIG_LEDS_WM8350 is not set
CONFIG_LEDS_DAC124S085=y
CONFIG_LEDS_REGULATOR=y
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_MC13783=y
# CONFIG_LEDS_TCA6507 is not set
CONFIG_LEDS_TLC591XX=y
# CONFIG_LEDS_MAX77693 is not set
CONFIG_LEDS_MAX8997=y
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_MENF21BMC=y
CONFIG_LEDS_KTD2692=y
CONFIG_LEDS_IS31FL319X=y
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
CONFIG_LEDS_TRIGGER_CPU=y
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
CONFIG_LEDS_TRIGGER_CAMERA=y
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_ACCESSIBILITY=y
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=y
# CONFIG_EDAC_AMD64 is not set
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82975X is not set
# CONFIG_EDAC_I3000 is not set
# CONFIG_EDAC_I3200 is not set
# CONFIG_EDAC_IE31200 is not set
# CONFIG_EDAC_X38 is not set
# CONFIG_EDAC_I5400 is not set
# CONFIG_EDAC_I7CORE is not set
# CONFIG_EDAC_I5000 is not set
# CONFIG_EDAC_I5100 is not set
# CONFIG_EDAC_I7300 is not set
# CONFIG_EDAC_PND2 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_AUXDISPLAY is not set
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=y
CONFIG_UIO_DMEM_GENIRQ=y
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_VIRT_DRIVERS=y
# CONFIG_VBOXGUEST is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_BALLOON is not set
CONFIG_VIRTIO_INPUT=y
CONFIG_VIRTIO_MMIO=y
# CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# CONFIG_HYPERV_TSCPAGE is not set
# CONFIG_STAGING is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_PSTORE is not set
CONFIG_CROS_EC_CTL=y
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_CLK_HSDK is not set
# CONFIG_COMMON_CLK_MAX77686 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI514 is not set
# CONFIG_COMMON_CLK_SI570 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CDCE925 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_S2MPS11 is not set
# CONFIG_COMMON_CLK_NXP is not set
# CONFIG_COMMON_CLK_PXA is not set
# CONFIG_COMMON_CLK_PIC32 is not set
# CONFIG_COMMON_CLK_VC5 is not set
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
CONFIG_MAILBOX=y
# CONFIG_PLATFORM_MHU is not set
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
# CONFIG_MAILBOX_TEST is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# CONFIG_AMD_IOMMU is not set

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
# CONFIG_SUNXI_SRAM is not set
# CONFIG_SOC_TI is not set

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
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_ADC_JACK is not set
CONFIG_EXTCON_AXP288=y
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX14577=y
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_MAX77693=y
CONFIG_EXTCON_MAX77843=y
CONFIG_EXTCON_MAX8997=y
CONFIG_EXTCON_RT8973A=y
# CONFIG_EXTCON_SM5502 is not set
CONFIG_EXTCON_USB_GPIO=y
# CONFIG_EXTCON_USBC_CROS_EC is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=y
CONFIG_IIO_SW_TRIGGER=y
CONFIG_IIO_TRIGGERED_EVENT=y

#
# Accelerometers
#
CONFIG_ADXL345=y
CONFIG_ADXL345_I2C=y
# CONFIG_ADXL345_SPI is not set
CONFIG_BMA180=y
# CONFIG_BMA220 is not set
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
CONFIG_BMC150_ACCEL_SPI=y
# CONFIG_DA280 is not set
CONFIG_DA311=y
CONFIG_DMARD06=y
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
CONFIG_HID_SENSOR_ACCEL_3D=y
# CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
CONFIG_KXSD9=y
# CONFIG_KXSD9_SPI is not set
CONFIG_KXSD9_I2C=y
CONFIG_KXCJK1013=y
CONFIG_MC3230=y
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
# CONFIG_MMA7455_SPI is not set
CONFIG_MMA7660=y
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
# CONFIG_MMA9551 is not set
CONFIG_MMA9553=y
CONFIG_MXC4005=y
CONFIG_MXC6255=y
# CONFIG_SCA3000 is not set
CONFIG_STK8312=y
# CONFIG_STK8BA50 is not set

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=y
CONFIG_AD7266=y
CONFIG_AD7291=y
CONFIG_AD7298=y
CONFIG_AD7476=y
CONFIG_AD7766=y
CONFIG_AD7791=y
# CONFIG_AD7793 is not set
CONFIG_AD7887=y
# CONFIG_AD7923 is not set
# CONFIG_AD799X is not set
# CONFIG_AXP20X_ADC is not set
CONFIG_AXP288_ADC=y
# CONFIG_CC10001_ADC is not set
CONFIG_CPCAP_ADC=y
# CONFIG_ENVELOPE_DETECTOR is not set
CONFIG_HI8435=y
CONFIG_HX711=y
CONFIG_LTC2471=y
CONFIG_LTC2485=y
CONFIG_LTC2497=y
CONFIG_MAX1027=y
# CONFIG_MAX11100 is not set
# CONFIG_MAX1118 is not set
CONFIG_MAX1363=y
CONFIG_MAX9611=y
CONFIG_MCP320X=y
CONFIG_MCP3422=y
# CONFIG_NAU7802 is not set
CONFIG_QCOM_VADC_COMMON=y
CONFIG_QCOM_SPMI_IADC=y
CONFIG_QCOM_SPMI_VADC=y
# CONFIG_SD_ADC_MODULATOR is not set
CONFIG_TI_ADC081C=y
CONFIG_TI_ADC0832=y
CONFIG_TI_ADC084S021=y
CONFIG_TI_ADC12138=y
CONFIG_TI_ADC108S102=y
# CONFIG_TI_ADC128S052 is not set
CONFIG_TI_ADC161S626=y
# CONFIG_TI_ADS7950 is not set
# CONFIG_TI_ADS8688 is not set
# CONFIG_TI_AM335X_ADC is not set
# CONFIG_TI_TLC4541 is not set
# CONFIG_VF610_ADC is not set

#
# Amplifiers
#
CONFIG_AD8366=y

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
CONFIG_CCS811=y
CONFIG_IAQCORE=y
# CONFIG_VZ89X is not set
CONFIG_IIO_CROS_EC_SENSORS_CORE=y
CONFIG_IIO_CROS_EC_SENSORS=y

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=y
CONFIG_HID_SENSOR_IIO_TRIGGER=y
CONFIG_IIO_MS_SENSORS_I2C=y

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_SPI=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Counters
#

#
# Digital to analog converters
#
CONFIG_AD5064=y
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
# CONFIG_AD5421 is not set
# CONFIG_AD5446 is not set
CONFIG_AD5449=y
# CONFIG_AD5592R is not set
# CONFIG_AD5593R is not set
# CONFIG_AD5504 is not set
CONFIG_AD5624R_SPI=y
CONFIG_LTC2632=y
CONFIG_AD5686=y
CONFIG_AD5755=y
CONFIG_AD5761=y
# CONFIG_AD5764 is not set
# CONFIG_AD5791 is not set
# CONFIG_AD7303 is not set
CONFIG_AD8801=y
CONFIG_DPOT_DAC=y
CONFIG_DS4424=y
CONFIG_M62332=y
# CONFIG_MAX517 is not set
CONFIG_MAX5821=y
CONFIG_MCP4725=y
CONFIG_MCP4922=y
CONFIG_TI_DAC082S085=y
CONFIG_VF610_DAC=y

#
# IIO dummy driver
#
CONFIG_IIO_SIMPLE_DUMMY=y
# CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
CONFIG_IIO_SIMPLE_DUMMY_BUFFER=y

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
CONFIG_AD9523=y

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=y

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
CONFIG_ADIS16130=y
# CONFIG_ADIS16136 is not set
CONFIG_ADIS16260=y
CONFIG_ADXRS450=y
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
CONFIG_BMG160_SPI=y
CONFIG_HID_SENSOR_GYRO_3D=y
# CONFIG_MPU3050_I2C is not set
CONFIG_IIO_ST_GYRO_3AXIS=y
CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
CONFIG_IIO_ST_GYRO_SPI_3AXIS=y
CONFIG_ITG3200=y

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4403=y
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
CONFIG_MAX30102=y

#
# Humidity sensors
#
CONFIG_AM2315=y
CONFIG_DHT11=y
CONFIG_HDC100X=y
# CONFIG_HID_SENSOR_HUMIDITY is not set
# CONFIG_HTS221 is not set
# CONFIG_HTU21 is not set
CONFIG_SI7005=y
CONFIG_SI7020=y

#
# Inertial measurement units
#
CONFIG_ADIS16400=y
CONFIG_ADIS16480=y
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
# CONFIG_BMI160_SPI is not set
CONFIG_KMX61=y
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
# CONFIG_INV_MPU6050_SPI is not set
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
CONFIG_IIO_ST_LSM6DSX_SPI=y
CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
CONFIG_AL3320A=y
CONFIG_APDS9300=y
# CONFIG_APDS9960 is not set
CONFIG_BH1750=y
CONFIG_BH1780=y
# CONFIG_CM32181 is not set
CONFIG_CM3232=y
CONFIG_CM3323=y
CONFIG_CM3605=y
CONFIG_CM36651=y
CONFIG_IIO_CROS_EC_LIGHT_PROX=y
# CONFIG_GP2AP020A00F is not set
CONFIG_SENSORS_ISL29018=y
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
CONFIG_HID_SENSOR_ALS=y
# CONFIG_HID_SENSOR_PROX is not set
CONFIG_JSA1212=y
CONFIG_RPR0521=y
CONFIG_LTR501=y
CONFIG_MAX44000=y
CONFIG_OPT3001=y
CONFIG_PA12203001=y
CONFIG_SI1145=y
CONFIG_STK3310=y
CONFIG_ST_UVIS25=y
CONFIG_ST_UVIS25_I2C=y
CONFIG_ST_UVIS25_SPI=y
CONFIG_TCS3414=y
CONFIG_TCS3472=y
# CONFIG_SENSORS_TSL2563 is not set
CONFIG_TSL2583=y
CONFIG_TSL4531=y
CONFIG_US5182D=y
CONFIG_VCNL4000=y
CONFIG_VEML6070=y
CONFIG_VL6180=y
CONFIG_ZOPT2201=y

#
# Magnetometer sensors
#
# CONFIG_AK8974 is not set
CONFIG_AK8975=y
CONFIG_AK09911=y
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
CONFIG_BMC150_MAGN_SPI=y
CONFIG_MAG3110=y
CONFIG_HID_SENSOR_MAGNETOMETER_3D=y
CONFIG_MMC35240=y
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
CONFIG_IIO_ST_MAGN_SPI_3AXIS=y
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y
CONFIG_SENSORS_HMC5843_SPI=y

#
# Multiplexers
#
CONFIG_IIO_MUX=y

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=y
# CONFIG_HID_SENSOR_DEVICE_ROTATION is not set

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=y
CONFIG_IIO_INTERRUPT_TRIGGER=y
# CONFIG_IIO_TIGHTLOOP_TRIGGER is not set
CONFIG_IIO_SYSFS_TRIGGER=y

#
# Digital potentiometers
#
CONFIG_DS1803=y
CONFIG_MAX5481=y
CONFIG_MAX5487=y
CONFIG_MCP4131=y
# CONFIG_MCP4531 is not set
CONFIG_TPL0102=y

#
# Digital potentiostats
#
CONFIG_LMP91000=y

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_BMP280_SPI=y
CONFIG_IIO_CROS_EC_BARO=y
CONFIG_HID_SENSOR_PRESS=y
CONFIG_HP03=y
# CONFIG_MPL115_I2C is not set
# CONFIG_MPL115_SPI is not set
# CONFIG_MPL3115 is not set
CONFIG_MS5611=y
# CONFIG_MS5611_I2C is not set
CONFIG_MS5611_SPI=y
CONFIG_MS5637=y
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=y
CONFIG_IIO_ST_PRESS_SPI=y
CONFIG_T5403=y
CONFIG_HP206C=y
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y
CONFIG_ZPA2326_SPI=y

#
# Lightning sensors
#
CONFIG_AS3935=y

#
# Proximity and distance sensors
#
# CONFIG_LIDAR_LITE_V2 is not set
CONFIG_RFD77402=y
CONFIG_SRF04=y
CONFIG_SX9500=y
CONFIG_SRF08=y

#
# Temperature sensors
#
# CONFIG_MAXIM_THERMOCOUPLE is not set
# CONFIG_HID_SENSOR_TEMP is not set
CONFIG_MLX90614=y
CONFIG_TMP006=y
CONFIG_TMP007=y
CONFIG_TSYS01=y
# CONFIG_TSYS02D is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_ARM_GIC_V3_ITS is not set
# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_PHY_CPCAP_USB=y
CONFIG_PHY_QCOM_USB_HS=y
# CONFIG_PHY_QCOM_USB_HSIC is not set
CONFIG_PHY_TUSB1210=y
CONFIG_POWERCAP=y
# CONFIG_MCB is not set

#
# Performance monitor support
#
CONFIG_RAS=y
CONFIG_RAS_CEC=y
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
CONFIG_LIBNVDIMM=y
CONFIG_BLK_DEV_PMEM=y
CONFIG_ND_BLK=y
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=y
CONFIG_BTT=y
CONFIG_DAX=y
CONFIG_DEV_DAX=y
CONFIG_NVMEM=y
CONFIG_STM=y
CONFIG_STM_DUMMY=y
CONFIG_STM_SOURCE_CONSOLE=y
# CONFIG_STM_SOURCE_HEARTBEAT is not set
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_GTH is not set
# CONFIG_INTEL_TH_STH is not set
CONFIG_INTEL_TH_MSU=y
CONFIG_INTEL_TH_PTI=y
# CONFIG_INTEL_TH_DEBUG is not set
CONFIG_FPGA=y
# CONFIG_ALTERA_PR_IP_CORE is not set
# CONFIG_FPGA_MGR_ALTERA_PS_SPI is not set
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_MGR_XILINX_SPI=y
# CONFIG_FPGA_MGR_ICE40_SPI is not set
CONFIG_FPGA_BRIDGE=y
CONFIG_XILINX_PR_DECOUPLER=y
CONFIG_FPGA_REGION=y
CONFIG_OF_FPGA_REGION=y
CONFIG_FSI=y
# CONFIG_FSI_MASTER_GPIO is not set
# CONFIG_FSI_MASTER_HUB is not set
CONFIG_FSI_SCOM=y
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y

#
# Firmware Drivers
#
CONFIG_EDD=y
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
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
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
# CONFIG_EXT4_FS_SECURITY is not set
# CONFIG_EXT4_ENCRYPTION is not set
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=y
# CONFIG_XFS_QUOTA is not set
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
# CONFIG_XFS_ONLINE_SCRUB is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=y
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
# CONFIG_BTRFS_FS_POSIX_ACL is not set
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
CONFIG_BTRFS_DEBUG=y
CONFIG_BTRFS_ASSERT=y
CONFIG_BTRFS_FS_REF_VERIFY=y
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=y
# CONFIG_F2FS_STAT_FS is not set
# CONFIG_F2FS_FS_XATTR is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_QUOTA is not set
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
# CONFIG_AUTOFS4_FS is not set
CONFIG_FUSE_FS=y
# CONFIG_CUSE is not set
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
CONFIG_OVERLAY_FS_INDEX=y
# CONFIG_OVERLAY_FS_NFS_EXPORT is not set

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=y
CONFIG_CACHEFILES_DEBUG=y
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
CONFIG_FAT_DEFAULT_UTF8=y
CONFIG_NTFS_FS=y
CONFIG_NTFS_DEBUG=y
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
# CONFIG_PROC_VMCORE is not set
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
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
CONFIG_ADFS_FS=y
CONFIG_ADFS_FS_RW=y
CONFIG_AFFS_FS=y
# CONFIG_ECRYPT_FS is not set
CONFIG_HFS_FS=y
CONFIG_HFSPLUS_FS=y
# CONFIG_HFSPLUS_FS_POSIX_ACL is not set
CONFIG_BEFS_FS=y
CONFIG_BEFS_DEBUG=y
CONFIG_BFS_FS=y
CONFIG_EFS_FS=y
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_SQUASHFS is not set
CONFIG_VXFS_FS=y
# CONFIG_MINIX_FS is not set
CONFIG_OMFS_FS=y
CONFIG_HPFS_FS=y
CONFIG_QNX4FS_FS=y
CONFIG_QNX6FS_FS=y
CONFIG_QNX6FS_DEBUG=y
CONFIG_ROMFS_FS=y
# CONFIG_ROMFS_BACKED_BY_BLOCK is not set
CONFIG_ROMFS_BACKED_BY_MTD=y
# CONFIG_ROMFS_BACKED_BY_BOTH is not set
CONFIG_ROMFS_ON_MTD=y
CONFIG_PSTORE=y
CONFIG_PSTORE_ZLIB_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
CONFIG_PSTORE_RAM=y
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
CONFIG_EXOFS_FS=y
# CONFIG_EXOFS_DEBUG is not set
CONFIG_ORE=y
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=y
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_FSCACHE is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=y
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SMB311 is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
CONFIG_NLS_ISO8859_3=y
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=y
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
# CONFIG_NLS_MAC_CYRILLIC is not set
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=y
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
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
CONFIG_STRIP_ASM_SYMS=y
CONFIG_READABLE_ASM=y
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_PAGE_OWNER=y
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
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
CONFIG_DEBUG_PAGEALLOC=y
# CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT is not set
CONFIG_PAGE_POISONING=y
CONFIG_PAGE_POISONING_NO_SANITY=y
CONFIG_PAGE_POISONING_ZERO=y
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
# CONFIG_DEBUG_OBJECTS_FREE is not set
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
# CONFIG_DEBUG_OBJECTS_WORK is not set
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_ARCH_HAS_KCOV=y
CONFIG_KCOV=y
CONFIG_KCOV_ENABLE_COMPARISONS=y
CONFIG_KCOV_INSTRUMENT_ALL=y
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
# CONFIG_SCHED_DEBUG is not set
# CONFIG_SCHED_INFO is not set
# CONFIG_SCHEDSTATS is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_DEBUG_TIMEKEEPING=y
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCKDEP=y
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=y
# CONFIG_WW_MUTEX_SELFTEST is not set
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=y
# CONFIG_TEST_LIST_SORT is not set
CONFIG_TEST_SORT=y
# CONFIG_BACKTRACE_SELF_TEST is not set
CONFIG_RBTREE_TEST=y
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_KSTRTOX=y
# CONFIG_TEST_PRINTF is not set
CONFIG_TEST_BITMAP=y
CONFIG_TEST_UUID=y
CONFIG_TEST_RHASHTABLE=y
CONFIG_TEST_HASH=y
CONFIG_FIND_BIT_BENCHMARK=y
CONFIG_TEST_FIRMWARE=y
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
CONFIG_MEMTEST=y
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
CONFIG_IO_STRICT_DEVMEM=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_X86_PTDUMP_CORE is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
CONFIG_DEFAULT_IO_DELAY_TYPE=3
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
# CONFIG_TRUSTED_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
# CONFIG_PAGE_TABLE_ISOLATION is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_XOR_BLOCKS=y
CONFIG_ASYNC_CORE=y
CONFIG_ASYNC_XOR=y
CONFIG_ASYNC_PQ=y
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
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_MCRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_ABLK_HELPER=y
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set

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
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF=y
# CONFIG_CRYPTO_CRCT10DIF_PCLMUL is not set
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_POLY1305_X86_64=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=y
# CONFIG_CRYPTO_SHA1_MB is not set
CONFIG_CRYPTO_SHA256_MB=y
CONFIG_CRYPTO_SHA512_MB=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
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
CONFIG_CRYPTO_AES_NI_INTEL=y
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
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_SALSA20_X86_64=y
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=y
# CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_PADLOCK is not set
# CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_DESC is not set
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set
# CONFIG_BINARY_PRINTF is not set

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
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
# CONFIG_XZ_DEC_IA64 is not set
CONFIG_XZ_DEC_ARM=y
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_BCH=y
CONFIG_BCH_CONST_PARAMS=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_SGL_ALLOC=y
# CONFIG_DMA_DIRECT_OPS is not set
# CONFIG_DMA_VIRT_OPS is not set
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=y
CONFIG_DDR=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
# CONFIG_SG_SPLIT is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set

--mirgrwpxdxksyg45--
