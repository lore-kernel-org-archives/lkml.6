Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754839AbeDCFqF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 01:46:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:56833 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754305AbeDCFqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 01:46:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,398,1517904000";
   d="gz'50?scan'50,208,50";a="31072613"
Date: Tue, 3 Apr 2018 13:46:36 +0800
From: kernel test robot <fengguang.wu@intel.com>
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, LKP <lkp@01.org>
Subject: [lkp-robot] [bisect done] 2b232e0c3b [    8.623356] kworker/u2:0/5
 is trying to contend lock (ww_class_mutex) at:
Message-ID: <20180403054636.ezkn7hkzanlnhbvn@shao2-debian>
Reply-To: kernel test robot <fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ktpplqomzai76t5t"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ktpplqomzai76t5t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit 2b232e0c3b3a09f3e33750aa20e314f1b80e5361
Author:     Chris Wilson <chris@chris-wilson.co.uk>
AuthorDate: Tue Feb 28 09:40:11 2017 +0000
Commit:     Ingo Molnar <mingo@kernel.org>
CommitDate: Thu Mar 2 09:00:38 2017 +0100

    locking/ww_mutex: Replace cpu_relax() with cond_resched() for tests
    
    When busy-spinning on a ww_mutex_trylock(), we depend upon the other
    thread advancing and releasing the lock. This can not happen on a single
    CPU unless we relinquish it:
    
      [ ] NMI watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [kworker/0:1:18]
      ...
      [ ] Call Trace:
      [ ]  mutex_trylock()
      [ ]  test_mutex_work+0x31/0x56
      [ ]  process_one_work+0x1b4/0x2f9
      [ ]  worker_thread+0x1b0/0x27c
      [ ]  kthread+0xd1/0xd3
      [ ]  ret_from_fork+0x19/0x30
    
    Reported-by: Fengguang Wu <fengguang.wu@intel.com>
    Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Cc: Andrew Morton <akpm@linux-foundation.org>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Fixes: f2a5fec17395 ("locking/ww_mutex: Begin kselftests for ww_mutex")
    Link: http://lkml.kernel.org/r/20170228094011.2595-1-chris@chris-wilson.co.uk
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

e2679aecf1  Merge branch 'linus' into locking/urgent, to pick up fixes
2b232e0c3b  locking/ww_mutex: Replace cpu_relax() with cond_resched() for tests
bc16d4052f  Merge branch 'efi-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
d1f1142ea4  Add linux-next specific files for 20180329
+-------------------------------------------------------+------------+------------+------------+---------------+
|                                                       | e2679aecf1 | 2b232e0c3b | bc16d4052f | next-20180329 |
+-------------------------------------------------------+------------+------------+------------+---------------+
| boot_successes                                        | 47         | 0          | 11         | 48            |
| boot_failures                                         | 8          | 33         | 0          | 2             |
| is_trying_to_contend_lock(ww_class_mutex)at           | 8          | 33         |            |               |
| calltrace:__ww_mutex_lock                             | 8          | 33         |            |               |
| WARNING:at_arch/x86/mm/dump_pagetables.c:#note_page   | 8          | 33         |            |               |
| WARNING:at_net/bridge/br_fdb.c:#br_fdb_find           | 0          | 1          |            |               |
| Mem-Info                                              | 0          | 7          | 0          | 2             |
| WARNING:at_lib/debugobjects.c:#debug_print_object     | 0          | 18         |            |               |
| WARNING:at_drivers/pci/pci-sysfs.c:#pci_mmap_resource | 0          | 2          |            |               |
| EIP:__put_user_4                                      | 0          | 1          |            |               |
+-------------------------------------------------------+------------+------------+------------+---------------+

[    8.622950] 
[    8.623213] =================================
[    8.623356] [ BUG: bad contention detected! ]
[    8.623356] 4.10.0-11076-g2b232e0 #256 Not tainted
[    8.623356] ---------------------------------
[    8.623356] kworker/u2:0/5 is trying to contend lock (ww_class_mutex) at:
[    8.623356] [<81997dfc>] __ww_mutex_lock+0x12f/0xaf8
[    8.623356] but there are no locks held!
[    8.623356] 
[    8.623356] other info that might help us debug this:
[    8.623356] 4 locks held by kworker/u2:0/5:
[    8.623356]  #0:  ("test-ww_mutex"){......}, at: [<8105ea96>] process_one_work+0x1d3/0x44e
[    8.623356]  #1:  ((&stress->work)){......}, at: [<8105eabb>] process_one_work+0x1f8/0x44e
[    8.623356]  #2:  (ww_class_acquire){......}, at: [<8108d819>] stress_reorder_work+0x7a/0x18c
[    8.623356]  #3:  (ww_class_mutex){......}, at: [<8108d82c>] stress_reorder_work+0x8d/0x18c
[    8.623356] 
[    8.623356] stack backtrace:
[    8.623356] CPU: 0 PID: 5 Comm: kworker/u2:0 Not tainted 4.10.0-11076-g2b232e0 #256
[    8.623356] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[    8.623356] Workqueue: test-ww_mutex stress_reorder_work
[    8.623356] Call Trace:
[    8.623356]  dump_stack+0x79/0xab
[    8.623356]  ? __ww_mutex_lock+0x12f/0xaf8
[    8.623356]  print_lock_contention_bug+0xb4/0xc1
[    8.623356]  ? __ww_mutex_lock+0x12f/0xaf8
[    8.623356]  lock_acquired+0xd0/0x22d
[    8.623356]  ? stress_reorder_work+0x8d/0x18c
[    8.623356]  __ww_mutex_lock+0x12f/0xaf8
[    8.623356]  ww_mutex_lock+0x3e/0x45
[    8.623356]  ? stress_reorder_work+0x8d/0x18c
[    8.623356]  stress_reorder_work+0x8d/0x18c
[    8.623356]  ? process_one_work+0x22a/0x44e
[    8.623356]  process_one_work+0x290/0x44e
[    8.623356]  worker_thread+0x32a/0x40b
[    8.623356]  ? process_scheduled_works+0x27/0x27
[    8.623356]  kthread+0xdc/0xde
[    8.623356]  ? process_scheduled_works+0x27/0x27
[    8.623356]  ? __kthread_bind_mask+0x86/0x86
[    8.623356]  ret_from_fork+0x21/0x30
[   45.079970] torture_init_begin: Refusing rcu init: spin_lock running.
[   45.083167] torture_init_begin: One torture test at a time!
[   45.084371] audit: initializing netlink subsys (disabled)
[   45.086254] workingset: timestamp_bits=30 max_order=16 bucket_order=0
[   45.087816] audit: type=2000 audit(1522699530.094:1): state=initialized audit_enabled=0 res=1

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start v4.11 v4.10 --
git bisect  bad ce70df089143c49385b4f32f39d41fb50fbf6a7c  # 21:47  B      0     6   22   3  mm, gup: fix typo in gup_p4d_range()
git bisect  bad bd0f9b356d00aa241ced36fb075a07041c28d3b8  # 21:57  B      0    11   42  18  sched/headers: fix up header file dependency on <linux/sched/signal.h>
git bisect good d5500a074741b78b7f778b4ab3415d5ecdcda0a7  # 22:38  G     11     0    0   2  Merge tag 'usercopy-v4.11-rc1.fix' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
git bisect good 6053dc981449718d90a429933e99b441e1adaea6  # 23:37  G     11     0    0   4  Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
git bisect good 606ed721afdbba2f560db87f33cbdb72463a5d7b  # 00:32  G     10     0    0   4  Merge tag 'xtensa-20170303' of git://github.com/jcmvbkbc/linux-xtensa
git bisect good f26db9649af36b8eb76850108113d4056f494537  # 01:18  G     10     0    0  11  Merge tag 'trace-v4.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
git bisect good 21f85778bd037f6d7652a79a60657599edf39ef6  # 02:25  G     10     0    0  11  Merge branch 'efi-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad c3abcabe813b4a0976b58f7e6c1e63b2070c8dda  # 02:31  B      0     1   26  12  Merge branch 'perf-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 26db8f992444a87465fc01b264b0317a3943e2b6  # 03:37  G     10     0    0   7  Merge branch 'irq-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad 500e1af25209a048daa1f1f86083d4849d5c555b  # 03:56  B      0     2   37  22  Merge branch 'locking-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad 2b232e0c3b3a09f3e33750aa20e314f1b80e5361  # 04:26  B      0     1   36  22  locking/ww_mutex: Replace cpu_relax() with cond_resched() for tests
git bisect good e2679aecf1060063b97bf187ba1c61430aab0701  # 06:42  G     10     0    0   8  Merge branch 'linus' into locking/urgent, to pick up fixes
# first bad commit: [2b232e0c3b3a09f3e33750aa20e314f1b80e5361] locking/ww_mutex: Replace cpu_relax() with cond_resched() for tests
git bisect good e2679aecf1060063b97bf187ba1c61430aab0701  # 09:40  G     30     0    0   8  Merge branch 'linus' into locking/urgent, to pick up fixes
# extra tests on HEAD of linux-devel/devel-catchup-201804021333
git bisect  bad 055d8c1139e38f0550de9ca5e9943dc5ae9e1c56  # 09:40  B      0    14   32   0  0day head guard for 'devel-catchup-201804021333'
# extra tests on tree/branch linus/master
git bisect  bad bc16d4052f1ae99996f3475b5a73d29c86e7ba81  # 09:40  B      1     2    0   0  Merge branch 'efi-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
# extra tests with first bad commit reverted
git bisect good abda4e2ba9aa789e51c233db44fb00189161ed92  # 13:37  G     15     0    0   0  Revert "locking/ww_mutex: Replace cpu_relax() with cond_resched() for tests"
# extra tests on tree/branch linux-next/master
git bisect  bad d1f1142ea4f41cf0b6c71a39e90525faf1983aa6  # 13:40  B      1    14    0   0  Add linux-next specific files for 20180329

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--ktpplqomzai76t5t
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-intel12-23:20180403040553:i386-randconfig-n0-201813:4.10.0-11076-g2b232e0:256.gz"
Content-Transfer-Encoding: base64

H4sICMITw1oAA2RtZXNnLXlvY3RvLWludGVsMTItMjM6MjAxODA0MDMwNDA1NTM6aTM4Ni1y
YW5kY29uZmlnLW4wLTIwMTgxMzo0LjEwLjAtMTEwNzYtZzJiMjMyZTA6MjU2ALxcW3OjSLJ+
PudX5Ma8uHctmQKEkCI0sbIttxW2bI3lnundjg4FgkJmjIDh4ktH//jNLEA3QLdWDz1jBGR+
lVWVmZVZVcCN0H0H0/ci3+XgeBDxOAnwhsX//wvgIdUlcXyFW8dL3uCFh5Hje6DWGT6qMSY1
tdpUnsiKzCU4eZ4kjmv923mZqPIHOJma5pyjWVfqSHHJJ46RXdXYB/gAv8gNDUaDITwmHLpB
CApIaltS2o0mXIweQZaYvi7MTe/hrncLURIEfhhzC8wgidrrVAB9L+YufORe4nhcXBRpuoNL
6CbxE/dix8SLdYo3XTuzg6SNP5pwNfwEr47rQhJxuPo86v7eW6fnuiy14bx/P6oFof/iWChe
8PQeOabhwkN3ADMjKIgqyFPOLzM+A+lNWjtqK7da9sS2v6IUxsQtdNVGsJZtFsFsAgt5xMMX
bu0FZxdlsw+HY4Wq2rbF7IOqipxyAexg2WxuU8Mtw9Gtg+FStBW4rdJZfJJM2+BMPT90vCm4
/tTlL6jgaLUx3qivM9x9hpPeGzeTmMOlIxrwA6BSxtyM0SbbYOD5pdCoowEJDnJdR2KUxYsL
yJeDfht+6w0+wSg2PMsILRhewImjqtLVZ/gXDPv9z6fAWi3tw6loBmDkMeQaQ+M+k9gZWrW6
Dnr9HmC9ncgPsaokI7facPP7oNzCksAysF5rDZs36JLOQKfza2Wbplghn/kvy1jGAivrlHL9
S9ldI4rHge1BB7lJ79DG38ZGaD7N76aaLRWa2kRnaGOFyQGi/62ojYIS7M66ZOKpae/OumTO
dimr7SeeJfgGw1osmteIlwE0Q8sB8Cc2HLq7AF0gUenZ8wIqwCww24APm1LN1ibNgsd3PCd2
0IFiQX74noEWzIoKVprlkp8b6LIz9jg0ZoHv4qCQy9WaCCJxgsj5xoFpil5Q0fOHG/iChcg2
U/HGKWS/hYoMPz52z28LA8IST2OJp7kjj77Eo+/I01riaW3iwfHosj+6WTSkPbGUrCHRRZU2
ZPdiiMbfE6FDqgHmEzefo2RGg71j40BH3gWs1OMUTC7lfxhdDleHkitNb0lAv5gKJy/YD+f3
F9cj+FAJ8LgMcHXVY42LngBQJAJgGQCcfx5epOTpwcSd+VVFAVd4Wi9AlbuCrakWCkjJ9yng
slgDSVKpCZjS6xYKuDykBqNCAVLaxmrBF6U83WH/otCsLG3Wpl4QKiXfR6jrYa/Yby0t7bdi
ASn5PgXc+hRpCcEMy0LHH5FX5lwQrbNk3klQxz7kh50N0HAyv5MBFAqVBudw3f94PegNwHgx
HJeUvjBgyo0G0t3e/7GZDHKBXP8V0Em1QYIa5LFMkXonsueXWc10ffO5DZ8iChxmURiBOmlo
qoVtiuN3frGJFUNsQKeCvCC1sSTqgVMMEJyZgR6VngrCDQiJKDxCb2GBb9sYteAJ/aystlhT
YzqY76bLo3UEwR35SWjy9jLczIjwLw24q4cYfFMoesxMS5W5atn25FQ8ciyXjz18puuoeFKj
xVRdAa9Q7n99HB5Cw5vystTictBNFaMkXqfBfiUmtsuHJIA7P5yhshZRsnihLBQuolw706cB
8gOfBfH7+vOB/yK89DeqTxQbYSzGfm6YT+CVZHqpZ89GSiLIGqFYrniIt0qTlkIjSC1eLv4G
mOqEYB2mjwECcacZrICUdhGrCu/ey0FiPzbcwCA1AK2htORyZaDmbYMigyClBNES7YwioE1v
4pEylqoYdQW/1dJT8lO47V/dw8SIzad2iWvIVCtlU3VpV7lW+DSmtNSS8lhjnTH1LMKPWiEm
FRTD20bixuVOejioPTozpOrfwxBzeLJUTSqEfQd49IyFqMd3gz6cGGbgoNF/IU+BSZTtiv8x
+IvxFvtacOj9e+L9In3F/ChwTGQlv5fPY7Dm6YoQIo3D5x9HfZBqslIuTv/ucTx6uBjf//4A
J5MEWQH/jp3wL/w1df2J4YoLOZevKJWHbRRjhkTCYOxKpzh0pnQWgHjuP/wmzqKl+pcw/3mH
Q2hBbbdK1liWrAFP6GVAJJzbhWOZcMqacI0K4QrqtFW41rJwraMI16oQrrW3cGylU/HqGOIZ
FeIZ+4vHVsRjRxFvUiHepEK8h9+k1BlN3gGT7zB0rGI8tLPWs4rS2cGISgViwcJ3RlQrEAtZ
5ryFGkdsIa2idO1gxGYFYvNgRL0CsWJcQJ7W9haa07IdFG5BzI7Y9mZFvcyDEa0KxELwsDMi
r0AsxIc7I9oViHZF7IBNDyeD7uXjh/nklOl7tjNNwnRGwfFsCk7o94bc0rEomNAlXTNkTG8m
RsRFmsCt0nghmgUT38cqdV3MpkgQBhfDTxjvoNv248BNpuK6InNMowXKHSnEF9NHJ3lUUHCm
K3PBWYhP0ShNJU/EPM08NRRNMLzoYxj14pjF6PscZSZhAyM0XpwwTgzX+YbyPPPQ4y5ga5XM
nK6kUiG3HY9btT8d23YouF1PqNYSqfz2WhYlM1lRmaRjHiVjlFnMo0REPg54aNIqyt3DGFtz
1MZA2QvHeItKHU+cOFrcQvCozeiCQvD0ah01x+vNJtyiNRZFaaWB6hnlov/Wba1JHQ4RUzS1
IesQSmDJqsQ0SJii6w214HcD5KwZqAZmexMbCJIOFvhPVWoV/OcyyheaIIDC8tXvgyxPMaJ3
z4ThlehtkWGX5c9RzA03xnB5JQvHCtqGWWA4Txw3Rh2mAN51ojiiGV6Ry/qhxUPk9SeO68Tv
MA39JCAd8r06wCOlOZDnOaquF5BvUtUyfUwcPIsiaNIi1MPOGSrpWWjM0GISbzqOqUsDw3PM
DktXLUQk3Ul/Ru9R+NfYcF+N92jMPTFHCKGZzufX8YdQAUxUXXdMlfaTuIO2Ah6P647tGTMe
dSSaePDi5zoW/DyLph3U97TAGoPIt2NSdNK6TAhv5oxfKXOx/GlH3ATfD6Lsp+sb1hjFt5zo
uSPTCgnm0fMb2P/hxKrPHM9H7fQTL+7oVImYz6y660/HInDq4BiRLs3w8XxhJltZ7cTxu4QJ
N+bVqdh0YySdMtaQsWJLVIubL1Oj46WpWPhKbf3cOUuXV2sxx149CxOv9lfCE36GKnLmKLpW
wzzdSj1mzcNcRGI6U85cWritWSRPW/ytmdQQSSAIJFWSmaIo7WwN11QmiiG1bIUrSrMhGehC
ucJUm010iTcUjbUnTsTNuJbCquys/jKj399quyLk5Sr4v6rKNdZ+983Yrzm0PstkzKFggjUx
nzpLop9Viw7n9/eP4/6g+7HXOQuep2mNN7TI1DRrzbNdxT3L61e+5l2iG6TLPLTr0VMSW/6r
1ymOOWQC7fQEqSVAZgmFIGOIw+eTET1lc+3cw7GWTJRJsgonwqbb5BLIFWG0gspRGHYuiekd
TMN84qVYitzU9DkYJmlMwVrKFXB98sq1ajSxcjJHw6hXa2BDVoKJhR3nGzkiHBl+KTTWCkU+
1UX+MpufOcnGUamd/ygUMhCTWTRWtVqSdHMma6yh6TdLo+1JS1fZTT560gaIU5DllnqD1od+
CXMvrAJd+emVzFTkp1UpbCwZu+IGJhHGDCrTCDifysEg4gbMmVFbuUHpFsYABTGzcTyXIpuC
c413dIElU5AAtvOGYQhAOjwbLY0GvFo+VtMFwEmjoUrwfF4ojY7gWfBnALp4kgEY6QUCyJKq
VwG8zMRIJwBaUlPMP2cATZtnAKzZ1GBQDoAxF4VDkMZs0kICPZvNJgCaPq8CAKhTN6QAMmPG
HEBG55BXgVVXAQGoT1MAVBBT01oZAGP6RBUATU1rbACI+VsmAVuuQo4GqX6VAVzQ2hlptmND
/ORENPpguEeL4E++h6FahLc5/DEEjJEAnaAn9ukk86XyGepqvV6/f17yHFhx5SvaCg9pETrd
eXLxCZxZ4PIZ2qkIoQv0/0c0qKhoxmacmWMENo6GedTWwRANI91FlNZhBRQEwVja+jOJBMaU
+zNO3ocslgZ328BaxThoGnaHYVK6DLaOtX79z4OPIhJe3t0/9i96e5wAKpAOOEqR4tAw+TgN
Ek4+wIRTE1IeWhfpCa2s4g1UttDI3EP9p8v0SFo544ZHmmjEqZbifwZc9s4/fcy9FYWEqKH4
oBIp8SLDTjMb1HIrEbtQqHr1fWU6Xu36NqB7xXCcpxXD6DLCGFhUhx4YIceBJk7D2Cm1fhUS
mWnaFqdoRbQxLWuq2YxbDsa2tF7uE2gIaMaWH/7jp9fuaDp+LLtDR9J/+G3UljH6I9N3wr+i
Nu0AZNo6KTocHN2JIDYwaz3FWCO0OrrNLLEyS1G+uKJRZp0339L4RcTUX/Pgap3sFrME7NkA
e4N75ju8YJiBY4GPYcuFH7yHOE7HcGJ+AByINHjAPOXawAG/75l1+jv1YeC7nhGu46I/hkH3
8/j2/uLmsjccjz6dX9x2R6PeqA2gb6IeI/njdXvRrepGcgK/6f1nNGfAIafgRYlBFH/dHV2P
R/3/9pbxVzLY8hJ6d48P/V5WiIgVt3FcXHf7d7lUIvwrFYqoyoQqLSOPh/JpOXet82h2CINX
1qBxtsCM4yVQXorJdIiOJwezMX0V7paCQ5ZFvOvMtYpjne67UKhsHQxEmpY4MW/vinfIUajo
tuM7RJj0w/dX0X7fw/Q0SzCEwWevEQZj3yEUpyL23yx3t9bFHjYsseBvY6zOre/ZCcB/xsqs
3sxOW7G7tXP8d3zsFPcC//0cbMSlv0fFXsh8if+OK3cq8yX+/ZnYF0fHXjosP6H8MPHSTScp
2g6n7dhOntdiFs1d65jYE8PKJIYsC/8B7L/L5kNuYrbjvHD8ZVi1rL2XjoWkyze392UJMPwi
HwcbZs4bTV8S8GuIzr5M7rkqHoSdwla1yX7YP7kvKUKrUcRWw7j+XxS71Sjir3XPmFxul6Uw
FNodAaZaGpkdRZq9YBBowQqdX+Epw9yvUtUwe0qTtU8GJOp1iDRZ+/w4TLk0e1eqXJp9YFYF
SXPW2jn8wrBOyu4wq4IcDLNBGmWPJt4gzT4w1dLI7ChtsxfMBmmUPTp8gzT7wFRLo+xjDNXS
7AWzQZp9jGGDNMewKfk4NrUnzAZpjmFTe8JUS3MUm9oTZoM0x7CpPWGqpTmKTe0Js0GaY9jU
njCLAEdMhdQcL9ujup8xLAKcH4SplGYfY9ggzX4wVdLsZQzV0uwJUynNPsawQZr9YKqk2csY
qqXZE6ZSmv2MoVKaA21KJFxZ6pgZw27l78tYWaIiH1jiNsaqEkmpDypxK2Nliai4h5W4jbGq
RFLOg0rcylhZonxgHTcy/sxM/jv8Qa/5nr0aTpxOY+8swfZpr9dX2gwGZItJSNtFDpjhQgzT
92jRPaJJEsebtnex7eywHc+JnmiafoGzcYZsizRuNuk/c6IZ7U86sFIAvcte9/L2BjXJs1yq
1O7TdgeKT0sBYj7Mw17Opgy5dWSt23+JYpIuSgDtG4DvWRf9/eLkurGqWztP8C4fWJM1mD3m
oPNjsjy/fSBM3uO7wRzUwCVtzFQGfiLe95QbivApphHxCNJyT8GIgL8F4psP9WLbHkOEe7Fb
oQ0Rd20qHwIjiopLwitbpJ8CHh+6L5q1GJM1SVW15sqm6LQYQk7Loi09Mbr+qRPFPFwVqKF+
hTgy23CZfQ8D5Jas1RVZh8H1t8VWoQWPKsm0dG64ziRMN4tY3DVosdQP4CR6dmjT+of0ux4x
rXcnvF6Hht5Q6w0G5/7UH/SHIzhxgz87rWZDVWVtacuSqja1rxA41hir2s7f8Mv3D87Qr86S
GV4uv3bTYKqa78+/8EOahH9xxKt0ssSaEmOL16uwvfT5Xn6WvhDQHdym+wsjiBKTqmsnrvsO
hvlX4oT0YQnaiuwb1lLLMUVtsK8wopGUNjpfhcaMv/rh89KayxK1Kumtr/AfY2a0YcJNf5Y6
c8/CkupLZJqGZN0g6IYz2iGQ/yoHbWDv0bu3iRdv2iq5wyZOpimSmkEFvvPjeE1ZlcX2ijYM
8w8TDee7zvqX7aVd6Kypq9jltwYaTLqn2Xm8PV8UqN6cUznyQJxUOi14dU1VVnitbbynwD4u
Q6ABNRDiKuRiJ9RoMATDRTPxDPpwTZSt4rdBVm8WPM1GS156r2NgvNGnckQ1A8N8Tne4LzRU
1uWG/hV6tEVk/g4r7arDYfDKNeI6ZC+oMOif3YvHC3OWW0zS5vtLoPcW0ysuqNyrW1kVVDEq
4657ftu/+wj9+1r6PszDbwsshamynH7qBAnGZQS6jpogNtPTW8OOh39pcxIOVJ7wDwtSWdXZ
yrusI7T3EH2w2EAm9gOfSDUGtV/RhSniTC/tMNQzrLkEXfFpIPxxib6yvfStBXRfmr4dWc6Q
pRxZ2o6sNvTmdmQlQ1ZyZGU7cqPZlLcjqxmymiOr25E1PLYjNzLkRo7cSJHZDyNrGbKWI2vH
krmZITdz5OaxkPUMWc+R9WMhtzLkVo7cOlY7MymDNuamIh0NOzfDyRybHQ07N0Rzji0fq7VZ
borWHHsHW9wROzdGPsc+mjWy3BztOXZjV+xl58u0Ku9bQtvcg1bfg7a1O61cOVqU0LI9aOU9
aJXNtPX6Y3/Qe2jDCz72w44YQoifdQQA68jiUqY3vfCazusYj6NsixR94CsWn5lY3wCaUc6D
BByupXb2vUgRpS4CopNrI3rlrvsBTmxj5rjv4lsVpyJEcNvCtE4BY/cgECm79KYWlGbIQ/Hm
qmdy6FG8jwFI4i0+XxloYrerQASNegmGg0/ZhzROxQTRK21EFrlChOGF+74ITBVMNJioShvO
6cOAYs94gIkONrJFH+cR+/jr9WWWJoVVGYuf0DZX5GDilZrT9AXYObEqSbJUzMGWnqtKkzY/
0tc2SjY9YnityOU53IKGyZRZgPgSX8yhTxnAWp6tsiaF1CAmXDCWK6WRZVYi62pZsqYhzUff
p7zTpa/vyEsZaZoW/mMZVBHC7Z5xqoqitpaUK321kr51tEjZovTjiwZ1/8l6/rVQIFVtNcWn
H1/iWWCj2pQlG2pLphxrJXX9wbd6NaUp6Vqzwf5H2rV2t40j2b+Cfpxtu9uWCRJ8qccz48h2
t8/ajttKpjObk6OlSMrmWK8RpSTePfvft26BFCCK8qM7HxyJQl2ABaBQBVQVYp8stFjZJqxP
pilSAbLLaJsVAn/u2ghxD6p4sIYV4svAIR7dvusJHdkqVNdRXeUfCMSBdjlPpHdk5X713cCn
cXR99q4rbtfmMueznKWzsdCT03Yk930V0MxI5yu8V52A6g7x/FOa2OMkoyaa0qHvrq1PBLJz
jDtCsFuMcz+KwQP82uW/nOSS5miCCIjFFzZLv3bIcsjFPC2Op7NhMSsR5IOggi8Jmfyk5V9/
MHPSj2OYCIRlARpbuUPqhl7AkiW6LfOR8wKZJ9FWK8Qw0L3DONpu2Qyi57eSHISB0HgahhiQ
a/KYZhCNpV9XdzmMNfPqNEnIQkN8MOdHROqvXIc58xiu8gsZHLJ/ScTA6uYoVUQKr6bZ4YIY
wdYRNmJ0HlK0JcUmkN4Bgqv2WloWEzLZTA6hWEU+yYC2/ZvY92A93c2L2eEoJEvpa1dc00qT
iHNElj5UgfSafTr6yjW5DeJAQri8hlrZ1LEM1xn0OBx98LZ/sUc6xYomxinTmrEfhwpdvVXc
rDlbFBHNwhYK5FQe9Hs3MDzzKUZKaROFcRuRqebk7o46GAEPzRqlE7nO+pWwLi6ov5fbKykV
jNz1y+xVa1op+o7oe6LvW4ixMoh6ZFbJE0a8iULgi9V8ra6t6aTjRJsD+n6GUb8oMhqLX4pp
NvtShakB+2dMMtItEMezeDzgTM3f6imYLspveWJW4TkJTR1TjxtHZv5jBt6S8MaKimo+0gP6
cS+bTRKY3YhA+aizXRyORiaJlPQcRxI7kHRK3FzfOCeO13VItSDO97qCpvSaQx/7+R2C8cpP
FjFvXbQSV1ulYu/kbHD99t3g/O3769P9n6s0m7xx0b+5MlC0onotUEBBGBLJPnF11Xt7fX7x
i51Y40CkyfSHZSUWEGqG+IqMGbIpSEqamXCMzhBZgUAn3SMd0wSPNyNBafcYVa4ZxxG7VmlP
RcieUAysn3WCASZY5HptEx+LmahmITK5paOwGgUWI6F0vAos04k4sEBugfkuJMtLwNoSCA/b
QQPlqdeAbqQLGY52gAYvfW0zdg11GGCCEvWa0iEx0kWC3CjoShdqnk784pCykXAGNKw3di+S
KHQaGNJghBzz2oIhLQxFg9ffwpAGQ7ZhSKQEWGP4QRC7bRgk76g0p2HRPZ+6zFP6z2IFQpZU
G/mYxGX6KC5OzwT2nx9qQGkAHTninpej0AIMgmp0vxRQGUBvFGwgxfJVSJHVtFA3LbSbFrIA
fwVgajUttJoWQkfbQvLWHSel19b5kT2AQteRrRhVE+qKAz29Am8ExTchFZKDwpB4XLEMN4gk
CuMXIIYaMXTaEPtXbwwgWRnNeeLyGEcqnK5kc2zrNb2NeULvrJq9yBjWcNLzfpSZeZ9VKjwt
xdZgJVUrbL6gjRUZLBIclgxx7MSXLs0D1fpaGsZzbJjcwOTbTSIdMg6bWJ4lShwnb2GRa7PI
JTMtbo5Lr51F+TA17ck2cq0iCUDQlCY2jJlnVX7/lOabIQ+CUDYFmreLK5FpxbCFKyFZas1O
V3rgJCMFrrQNHLnBlbCFK6rBlfp1lH6d0GpCRNxoykXV4IYZK9KMlY0kqZ5DrWj2rwXj2lyx
li0HmexHIlDIZbDBG49mlWry2X8dbzy3pav9HbyJNG+GVhNohnpN3vg7eeMa3rgbvPFbWOzv
5I0yvAl38SagCd7s8+CVvCHptiUFgx28STVv7JcKg9DxniDf5I1neONt8CamcdPsoWAnbyLD
m+EO3ihaCLakVvg63pC+4fmtGNu8kVpESEtEKBoJbrPDw528UYY3yuaNwj7bE61o8CY1vBnt
4o2vfQ02EKNX8qbaTtjGaOGNljfSkjcqaBk30U7e+IY3/gZvIho3TX0s2sUbaeSN3CVvFI1E
rymL49fxxndoprditPBGyxtpyRtf6o3VneSbvAkMbwKbN77XMm7inbwx8kbukje+R4t0c5Ym
r+SN0sfE2xgtvNHyRtov5beIq2Qnb0LDm3CDN5B6TW0y2ckbI2/kLnnjh3G4tcYMjWbj+smw
hTeRreP6WISbo3m4S7MZReblcIHKuinwLXJki7VHtvn1+6uTKj+WKR562Dsz+xsX6y2Xy2L6
ID5eXv/nySexB5cD4YsfpSOkOf8K6O2c58jfPEEeR556hrxnyIn6R5tcOsqNnyE/fYJcquC5
2vs1+Y+xReiG7nrT6qzy8nDFLzdnnFdROyo6SBIvnHNDpVTQHHasSn++S5LFsFvf2AS3NxwR
iH/8clLtMBoMTMOnMAwNNnPgtZnlSFxWHhezn2j4HMy+TNef+WjgeDqbWhXos6ndFVT7NfCC
XMzGYj4ry8K6AymQoY8tprr4phNWIKOQncXm5SCdLfKuvkHu5qbPyTE+54uOkC0764GMafLb
dP369Itp/I7XCcShlZ+Fll//kP6E4naWzcajmfilQM6pZSH+cld9+jvnBOwUy7+u63Edn4dE
9hkbzVl1wV2f7zc6QdYseNytqNpTnc7+why8dAyIVNBnrL1JdlrDhiaOlRtbmQHZRZgEXBzT
lh25BjimHPCdQ/DJo5EUqM08JIFLqq1vLqviVHJ8l9xwNRpR215w9xNh8PR/FsO6N62+kcxg
qAg7RM8dwUSGgKyn4HkC10gpVzucXefLy2SI81U7/Z8pFXmub5cS1cYsH0cxL4+FdK2GRDFc
Ai2Cug0llXx/fXny5uzy7FT0Lm76bz8r0Tu5xCdDT+Ir3qBfTcf4RG+zXCSjUZFyWtgvetOg
cfdB4NEyRFNlOkq7+DPAKV5XXJ/39GEzxhcZ8lbxGHPgObZ5saHwlOM2jgD7X4olX7ZCQ8r6
wdyhsqZWMRumvyeLKZ9hp7PVOONz+nqCimRKX/mkRyfnhD8mfV+P0dAnFlMLzvuHPYxq3Npg
y4PQ92LZ7j95XoxznU+1lrCGSIW8FTidk9ie3ujZBeaZElQk4hKiWv5ukLEZu/w3cHxlCi0m
D8TFacmb4UNkadaX3+0bpCBkXaFCki9C8hyvBSmMcfZVI7kvQhrJNqQoji0kbKVlk0S4n0yJ
2Lff33tRXWHb+9MSDT/TGkm9CEm1Irl8Hl0j+S9C8h3ZguSp0EIK/gSS7wfNkdStrrMLm0m2
I8f1INc3phPfIzKfNE/UW8/TmzmySZ/GtrVrn6NHcEuM23br60169YKjjogUI9l6kFCj+C84
4yCUyHeeQglecbgR0dLqt56Y1GjhK041IieIXiINXUNAJMSSd70bkZfwTShKiMFWVwXkNq19
FeQB8qc1095GTixhwwJuSE17HkcdiNhZZxMzQBgAGqgrfl2DlOtzNZzu2Q1mUK4SnywcWtlI
XL8/vXmJ+4Wr/LDpBB5JUkU0xOElaTp/HMcLnJc4ZRgCxXb37U1vgwBpvTNahy8+iBJBEUus
qtOSj2knfIreMRC+wuZjE2KVzZ8iIuUl2CZapk8ShWzqthFdn/c/qw6uF0gf0ntaHfPxk0Dx
1nY/H61dFpNCh2kUC/g+kGp4BPuEoUgtM9JCRlG4faKF9e7i4oPXNf7rN2RzItnRLSknSZkb
AO30tQ1woh2R+EC+f8KXTdEL3bHvRsJeG6YVrsNOWNtGwz+KLJ/V9ggpHqSF3ScZ60O3b682
Lwm1rr7d3KyPXJfPbVlB7l32cWcNxttBrVCRamyVjSPq0fdTOPVzBl3SCxbJZFSuXd0kIggU
omjqCAIuk63jBpQT1ZEDkh3wERmRLh7ny9nkbjFgP5M9N9jXSQfvFnnCjzgjJXIPLu+7IvTq
GAsxzkdLg+YpeAI00Tz3aTRnB5qvPLY0Lq/eX/52+tvhNRQhncwQbh9WolIdKmRY4NHQJ/n5
7j7XnjZ8Z8SEnTlo2jPRMM+ntfUhO1z0YoFkxNSBixnJZA5JJAK+/FpTcPWk825UFcY48keQ
2YDjsJc0G0iwdQ8PD3FV8IJDwPitP3JG1U+kD3OCq0U5oJfJy/IYt0DkpDqaJw6rmgN2Efmc
jI8DBxrzcFbmx5KGGdkvtM6uf/Wo9GpJX459UadgH5R5CpzZlF7GFK0f3M/GGf1fe1FJOC2G
0Ii3X0T00G0YStWTQdUAzi5p6GWIQ4AX0evWNuh1KFQLfVu1+lq/Wm8GOfV5az+Y6vF4UIPp
Lmg0Qek4mieaYLV8uwm+Cv50EwIPU7wFYxfpdjNCPhx9cTPYqGm0IvIQIPSnWhHzydRzEKby
TQSSsD5pwk4VDXirb25hP2fbsEvrsD/c7W1HChoUEiLNe2AY8oWXabqJmwdJKFWSNlRchRnj
e6R4SXOZZoQtDzZlzXfPhRfA8XP/LALPpzHwUXD0JjIbcljuVN8xXAm7b8SnJkH7dQ3fQamB
Y98ygRTImlQvdPI1BA9YJfPF0crtOkc+nD+Xi0c9vauGZjpT7d6XLwPeDx5wrtV9WhK7Wy/5
F6SMD7NR+tdPYjAgCi7LQ+YnUpbd0ZHzNRlFTbrhCrmmSTepVgGuseS0kt80yza/z0DIHmA6
vfeEN9WIdE7LVHV7C9y7thqrrFqw57HJia3i4jvSEsTetxD+h/Wbfbv/vx3+938H4AczwPHz
JA6IAZWv9GA2pclF2OBA5hEHVO16aaMjV8Le3n/oJePwryDY34E+HO5AH0W70JH7wfRgFXza
Bh9l1IUEr9sxWOSsQNc1hMkRHDLS7Qq8jQr0EGmHd9Od8FHWDt/8rjUOqK6ccH6rrzg21MHV
I10yH3uzCVm9dvfaM+iJidaE/TVZZLyTC22/K347u3oPpQBBCnAwFHsFSZHzD+In1mkPBM2F
YP9Ae0JL1OIeSvYLl0euI1UT/nfja7wxyNqYtfXGCAR418oMka0m8wGzDD0YYwoOtwr97TXz
Vd9exMUGRpqRrXxHVEN6wa+p/JM1MHYdJE0lM4cKuu6WwCPY142lV7WiWdLLMcH8P9+IVxb/
W9t0d91kx3RvKxw7OwrreTFY3kNrxTtqWKdtjNTAfAk2WYgZw5fAD9E/4RbNwxo3S6lEtl3/
H0HFWKqQB9hgGGD9BwODI/zZKr/IlwN4WA9GFTfkEXyfuJzyO7T0c5hKrcfAyhoMyWCesrKi
4y4W6Urofe+1GiQWqyl2nDtroMiTQdgO9BbBXPq5tiASeHAjeOQbQ668kNT2ZJWhnsK+OWia
L3GLlihXw/KxFHvabzrP9g1x4MJUBO+IoETqB6DTzKf5jxvqjj2HlR4ec8eS7LQVtiqq74Yb
URjh1KNqBQ6Dj/kmG36wJ33XDWLoSohn6Mr9Lps3+bEV2qOL1rejkZ1Co726HgUVxGTQ4TTi
vG/2JVjnILutyAbYZhvjTOEhf+TqDaEnQ77JTT/fKNw4i9PFI1dtFq+cQtsKKz4OXBdOC7LE
y/k0v5u1FvclnCdG8M/nkPe96lyQ413CTp14QpeN4chizhau8+WoFD+k+fz+BztGha/RoyL1
WRETByHOilC2PqQUe5Os1JtUguzxuigpBwGM7GfPXSJDEbjYi9LXqs9x3x6PzfXvLvW2h/wA
WeuvrovNezyDrUutHkDxIh5Q/Xpq6Ii6ekeDiXyFvSQmus+/YnXqchyblJGq0jVZsTFMErgY
L0wyKhYTLMJdHXIxghM/5MDjurTyeKtMV5CUxLUB/z/w3L39astA4GKhxoVCUHlBZJrqU2Pj
DaQ/iOPCY3kLJ1CvxfEcuBFZOJ5H4BtMs0uHsV/3TjHXBEgfo2/g6zKBKa2CqMbm5X2ke8UN
nNZOcX2f804wAUmXSVJ1owoc3wl20Gi/S6ZZrXDTKXd8tKN0GMa8A5UiI1zvtje4PBu8uXjX
F8ciUAf85M2ZWD8xhJGPs7qKEK+8UcFBveJgj5p6WFXn1fCIoNcKFSzAPDVwcRj6FVy63ZB1
ucDx3NiUe1W90pPKjzbrraLFGI/0rMmQb6yMvNDbxq6JPM/jWC7diJdTqQAhn8lyNinSQPFe
X7cqpOOb/Cj4iWRAskSojd4h7X2I+CiLv/T7ZwbND3DshUu6cRenNejWnHCqeCBDE3g4FFgM
STPSC+RaCAYdL1QSuzGId/ccL4iEtunr3/2QJB/CllYckoSM9i04Ee/IYAYBRxHQJk5EXeix
gyfH0U34Ds4uOm2YY9/PelpHM/Gr54sFcejQdQ2M74KdxXS+IjbeYBdSvFktlzSpabofVcd1
R5fXH/r/7L+76joOPt/8fvvmGp+ZTv91DCaO1dc+QDbkRyI8/7QuGOM0nTjpxQEOQe+LcTEv
9dfaGeT72yows8uGifjeEGMDF7mHFrSU07BxfecI4STOOppbCY7/0pckl/fJQm//l+bkm3A8
V8ZIhlKdn/I1RlB4kIEGiQsiMpYW/6bpQ9MYYZyDIWkM8Hng20P39f1cXO/JGlJpcVAdpAJS
GkjXQHovh/QdB5PllC/JeJeMH2DGHfIGMR+tWgUD8PR6Nj38PKNJQJ1fX8Gj+SI+y45nitPC
AdE7K++LYdJlwESYgPl3+gcxTubL2dwi4yOBZT5Oxw8DE1J4jJ0tApkeTtL5cEyNdsT9l46h
c0NsSvUfpym7g9FL9GCTZlu9rYiN4vsDcI9UwX/NFt+51T3CjOOF8AT+NZnepbjXr6sVA45Z
rJ9VCQmcTtyRYm9Z0BPirIycKmC/xMbagjRePA7WT/et1voBpDMt/JNH5I0Ee3gw3VFrp5yu
KEfm++NrQxK60Pumo7QsJogD2Ioj16VCTO7r3oVYQZ+pXv8HIpssPo8H/PCj8+mHLX0OxBFH
fk2WGW7W7eJDfRy0R5/p4zHM/qPpajLMF/tisir5FAGdOi4soFhJzP3rmb6OS5wW5cPbae++
mNfH9I2xFYcSPnrjYji/f+yKc7414+r04i3N77ISP1bpSMG5lfSFKTR8/b/tvKYLxdi+rwot
Rql04RBye97DB/FtWe1afCv2/jv5YZ/0uzSZl6txFRmpx+kWaBxH0Qao41eg9IFAWX0RNnb5
QmzlSI5frrDpv8Ei+aKTWNEHzixBcIsXw7kSvoEVHC2CsVPMaOV+exU7X78ifVV1/TkD1yB7
w0dxmnymPvt9NsvuZ1Dtibf5uLNvkD125GwinxFggStP6xD5JMVVqLgyD6Yex5fWAnTO55rf
GEidN2qPFGY+RSbggR4p+3hojfR9BHXTIkcyg9ck9tN7W1/lnhLTy5+5dh6c5TwnG+aRrSod
Kp9l2HWwag4kdD6b68WkoC69uBIXYg/bOgtc+0eSrmLYfs0sgxFKbJBvYTzLkbyqZidbIs4b
twX8C6REt/IOdu4PaA3ik1n6BPnvGIBY+n4LwBYLuR07GKfB+XLIxb9N46Qj+YBqnCZTaHpY
LflGcdE7ubYsE/1yFhkHP1ZkJMWzR+rzIrUoqsP4smOIpIQrOoArgVQJtjWRVTTAQpCmYeh0
mYJefYPIKhpDFeeiA1q9YU+VKzgCFkjouD5jLbcknKLFDapa+a8E7i/PVIOw9HXZ11bkRZjG
OUir7DZ7t/vi5vbtEddMZjSnRay0mkPL/PY6rjx8iA6vT6pQSsZTAbwoK7zNKxKJHfEh35O4
zqJD49y6aZYAaBmyEiXs9gKv0+lBO+FsWDVAHCBatGrBRkAeCZp7atMeXAc87+rX/+l67iGZ
VfvCd7u+QjHpdj3VrbalGSzk5Xon2G6G9XT6Ino3AxYF2P5gsPxFzCYWd4LDB4NA9opjENbs
rblLJLT4+E/wl5RPDx5Gxd3QasEvxV2CQIYznPRgsdvZ7X5HdRyrRaFOIsBwWxdihrhPXT3Z
GtdByszi693Q5ghN27pJGAJnX5GNtHyqVc5mqzwHUreCbR2F8qlRGIfK4UwUH8g07Yr/inzP
Ef1eb62JVvXSQOhkYzl8yA0lKbxU9eShKEmzYABxtRovCzw4gOJXipMxLRbi5kye/PODRRiy
96uuMpizx0cluI126dC0cwwNkvB8oqXnkZbJAcnIwSj7f+autbltHNl+v7+Cu/kwTq5lEeCb
VakpJ3YynsSON3Li7E5N6VIUZXMsiSpRspP8+tunARLQw3Kc9VZtdicRye4G0Hg1Go2Dr9TE
X3Mxww77FC+uqwkl18NyimT99ir5/exL9/DYvzx8SFBTTmBzGNqY0ZGuh+N8OL/dmdo9iSU+
TKdWgEkltmgShPVaGbr+yZJtF7S1ZLH04Dc7Pz93roopzTj5eoVLav7S0NP0GSr6V70j7IJx
OwWhCu/aYgUTUwQ80N77k/OVoh/4nbPjC6pdkdCPy4uLfzp7zdzVzFi8o/5SBqGx9clYZQzV
10ogjnfQX02Dp9VOAj+lAgUb8Xz7aVpysrQ+oTcAAqYZelpmlsgwgBlaFkURk50X+KPsphgP
Nl6k6liJIx08W58Z6Z738eywWRYdxRjeVddDLBn179fKAE8dmwqzUrtItLIWR2ioR9kiG1TV
jXNB7B1JUk5fnxxuylH4NtvkJHxOoURwbIqYYPqr15UYtnGUBW33Dx29nb57dbSv46/T0w+f
/lQQP6G7T3/5bBGJfWFaRSIShATCYiGzlVNwSISjAGU2WA2fDBENtsJ3+OnLfXxWgh4Hk09g
TZO+dUn4sTFnqO1PFIwSuwMnpbFoksSPEAtb3A6WV2kzbxXN0ixVLhaX5s0VHwtNx9qd0h3w
K+1MeW7khj72OLSH5vACm6fTeswnBAC6KLH5MKiwirY9No0DrMsa6LI6Vvw1lsYi9t7tzjkt
oXenjRvJM7JK3JW07IIkDFUwuYlwwYPWKNoUY2RPtaGeHNCQFMO1lc2yKQ6AvFn+VS7qpdqd
rsuracY7U7+8+f3d8T9Pzt78YjXMxnsPKVIgGO+OBo45tnwXCJ7pqdMPy+nNtLqbWrR8IqEc
FpTosF/TargYZPPUOTols78qVOwe3zlgeOA7JB6Zs9KbaN4VsxJkvsQ4RWQdMiDRCDtjjCno
9NmM45iwh7OcKlu+NSoThehNrHqaRqMTnbsSB6Wo8cEZr+fxZtfEKnvAh3COeuLy1LkTQKSh
ER6JDZs5X9sWvtP7TkPAOK+dt9+W85vKyIjjkAPV48gLEf36Gj++roQ+7jcDNF6SsVy0kVSQ
gChsaAiDVJ8DHPNxhj0UgJK1Wm3WtKeXhycXFq+H+NRJ+ZX63N2Q10I5e4rapHG5PRjZZXVL
k1fWnJljASJBd9Qb83dDUvjl0UVTfijzUH1ysGdKRVDNmFKjVlsYrPG6dcpCqMcIWbZQOPX0
cpVjbn2Phgbe5oGzfFlbOfJiXpBbzK3D1rzc5q8NjAw/xDGVDGfpSA/XW8vVfHxUyQKOHlsV
bC3oD9ibVi0XL5WnzNmjDpR9w4umi0NKyGN2OYhcd1vWTl7hQMxjshUxVp8R2Ls4/HhBa/XF
dTVk3fuk8LK+rxHEEdvFLXur8ObVA+pOGKjpLhsV84DMmm1lusRHB18fUzDp8oizKnmtLfn3
tyWyDhhXFO4yVbLBshzj+AJJpsnWEErG3LcIy8oKS259gxuDDzZMPdX9aXXbZ9bP2swSB+zP
JknuV3lsWDxfnY+3WHI+zmZOt03KOsdoCduunFbzl9SlnD1S/MuOCE1Dkj7vDNSDPObBR9fS
olqVZB/lZbaA1xv5bBlw6qDptxz2Pg4TBxw3O6lzLxpEcaRy3DutXzte9IpeUPXQiD+srrgy
qym8ALrmoQK7Yu2ZR0a8d7gu+BOvtTfKYGvDEU2oB8SQ8YbGF3s0b46UDOPCdy3CRKCqVgh/
Uu+e66K/TbL8+jtG3VP68S/nX28674HrT21d66P166wdGVUy+PxhK2NaGQGWPxmUIpDcvZRU
6wTyZfvqcQUxleDhSpAHZGcN8lZbz3o6KzlmYUD19a2xTizJXoSNJ2AFs5SVURJv+9MKZ80R
TY8ntcnQjJv8iiybMqfvWwdRz08Qq1APr/MyVXdr0JRfXpXAtv0N+H6WdX2y1YEHKQGDAWsp
Ky6O85LUVTgfajIKjA3khQGOtzFDZzZejCaU+NFvr0/MXiqcix/eNJWvAigMPy02KEHqYWQH
XXWoD6Z2wAg1+3I6LIFhqgB5eeHEAKW1kZEwmNwwH2Jlr/7BnSxkayvLraYWOc2uOPTAeQVX
sbaO9owPIzxwO96BNAr13QjrsOtyOM/ulJv+t5OjBuNZlwZL4t/Leem8q6g/Z4bZ51glXpp1
RpO8Q1YI2XlkG06K79+pHqcN9IOiZvAF9YeyuhxlfLZ9nioBlOSwMjrzA1+05Odzanz5Qsds
MvmwgL3bIeV3VvaHwRryPjPl6D7SzsjFVopWkI7eQKCpvjsLSxgjLhLY0CNxfaq+W95SbSfL
XQlsm0ATM4P6VKO8dHQ+YeJurDe1EBMtWSD4+PFptVg6p+WwvCBjg5opNWuqUkxX1NjHytzj
fbiIJh88MSp4FBs52pCvMweo5Iz1odz1ra/c7AmAPuTbOw7f0xL6rq77YMlTEUsfj6mG6Lya
ZwOVOBaPVmqRhDmYT0rqa7GlMP3mwNumHY2bzAJigbCvOg/Zz9tk8eTDai5D6hdClSqvfemJ
h4oVubyhwGr4vhChgsXayYGd4JaDkggf5IhcLOdYdVfLmsOpyxza8zznDwR9QjW8Eds2kg4f
fGhECD9mzKJj6KVtqL9M6umwPyun0ywfF7/wbrg2gsxwsu/QooX3e62JVwQ0CHmqEPUg3lIA
ajuGOAxwBo3z/1f2/TuVmPKeiF2FJk1yhc1uFlfY2jnP+ATlW3i5GNwXBuFMvbTBlXWHOWgs
qNSRB1FgpAoZ/wDagwwNhxRoebQCLCbG/dVu7DNF6CschlE55okTOL1X1O2pcyOp9ydn75xb
QMwZBYaexPQ/HU3H/SzPF2YE50v80Ijpm4rvtLiwPQcuhFhPEeh+Y3nkqOk5e+p6JA7irBuc
8kn29bmRQZMP1oqzktaHJ+e3Pk82p+fve07FoCB4tVjCfcdRHCuTnQhDgWVROeurg77Kw8no
GrxRYrTAKBAXRTYxvJEL3gcP1rqGIw4xamtUYeejvvWC1UP5tGqJDCE4sctZSKZUNUAsxhpB
iMmFvv9ExiM35p09hL5C6v7j9RZJRtB7sOyR4fAYFPZBjsDiiADooeGdR1jl0mjOccprXl0Q
+7TCphFhoA9s38oDdytdKBBF9VA2QoshBlLCgwGnhiHyEZDN25+5sbcYeL5xvAA2x9mbkzUq
aVygySemYal0EtOsIw2f8lDPTiyOBPi1nC4slZZ0JR0rhYSDgZm+iby+IiOL7MqWhepMRM85
ovq6mrXxzQnQUQN/y7nrObAvth+yZi4hAWS7levhY9osgVq36nQ+DfzHr7FZhrGTsYFooXkg
adwI47rZqWDcIU9DB2l6spf+wknulU4RewJufEWStn1z4yI3vh/RHpLEO4MExIJ8IX8AUKfx
HzNH/CMn9D3TNWJaxBMHnP1k09A/B+Ifzuf3h2dOTzvFaKEXG3KaJxD7X87y9iw5QqzNrop7
YNYRRE5N+AfyYwY2WrcDMkAl0FPnIuF50H4NDmRAHIphUPbLQ0n4nsURo0MkM66eE3WwGTWU
nPNe1ErQBugTP/qB0dkzI1Tistf0QY7Q4ohCO55+OK3vD9YHvfDgXTXx98XsejtdosOl1kLi
q2m3qnWWaKjsSt/UWoLg3D+dalZMb2vGFUqdD/Tg3CqUIUe95ME8W2SzbHFteClfWL3PxnX/
qq5SNQ+87X3YUGsS+AgUJuNJ3cKHZQH/0SghNGVbLSkhAzKyqD8ff+ydfDgj41vgjhJ9QExR
BjD33X/zjyUvQpP/b5LXAgyyPBJIelShdhhUTs9VtCkf+cXth0E76ME3h9WtIW4uJ3xm5jig
gfg2SyJ16Hpz7ORE3Yx4sP2P4QQOx58NNSWx/l26nqrTA+NceYZVyLrSiDSAsalTQCshw7q5
z5KlIz7eZvAkLJMVBlrEw/T45lxQl0kdmzj214nfX/Sc9s8Kse/DmFjPtUDyjCEiDGnA90NY
ch0sfb8Sn4IAwZBp7vOMLMYocNcZz6lS20MPgAC08hR6undY9I3ebxuD384ZrXrCzULIbaqP
gihcl53NB8DfUKfPbeJYRFqTChTPKijPeqlFGgV+c3+b41ofEp4/ceGX6+630dL7TgHrbd+5
Lq+u953Pe677HHHVH/fwb4//bprEvnOkPp9aY4gUrgccHBYs9tvAow3BntgQ3NwpyoIFCxaW
YMG4AyxY7hK8meMHBEvfbwR7O1TheY8V7PH6gQX7uwT7jxXsMxIkCw6etPKCGC5JFhzu0nH4
2ByHHHTHgqNdgqPHCo7Zkc2C412C48cKTtixwYITWzBfvGsJTh4pmMY20QjOnrLyEEnSCB7Y
gtdz/OqxOZZhKzjfpePXjxXsRUHT84a7BB89VrAfB80gVOwSfPxYwWT2NF16tEvwm8cKjoTQ
XVo86XgsY3b4smDxpIITz9U6FvIpBSNKTLcKsWs8frxgwXFaLHjXePx4wZJvCWLBTzoee14s
Gx2HTyrYTyLdjkX0pIKVwwZmCa15cD8pwvRx+ju1aPimQqJRVwCn0nwi2y7kT+oG31RYnxgb
nj6pS3JTz/rEV4rQJ3XHbeqbT7HLF1V//Ie6ojYNrE98Ozh9Ulc+p6H1icPm6JO6szk1ViMu
B434k7p0OY2tT36gPqlbk9PE+sToVyiXLrPxM0rfFTo10ZRaWB8DT3+U+qO0PiZYROKjVoow
WkGku/6o1WIWcPQxjFXh9d29qXHlSV8yXP09S4+VP86wmhp/D3HGgGXSl9GdnzhnVad3TSvS
fLlYcSlIsu/5KoXsquhXd1NsMtdrh/ZA5TPMeLsEX8yXNR+m3FiFSz9IsI2O7TjsQKvVF9nj
PhU7TANTF34YI1SCw8yOj46cUZaXY+xS3uLuJg6W6vy+nHZkgEOhW05IQUYUYeUDduuqt9Xo
FEsriQsL88MbWh4tZ2O1OYrtPzhdmotSO1jm71PJ1Jkb6j1/HzbEHbx7Jv7eSgxEhCn52bNn
znDB+3T8u24A4ZbTcsFvO+p6TIDM1UWht6aaLQIjTkENI4Pdlfx0ZwqnTp2V7ebVtF5Oinkn
syGNrwpKvSHMi/G47kzKmpsAfH07Jc7m1W05LOamwQd+iFPc/x15IcPH/em8jAA0qgmNyMiX
P1+87SJjjsd5lMhsfrXkuxLJLple8YWD2RSeqlkxX3wzohO+wvU/IRo3EGAnSB+3RJCuhhxX
GMJbqqs9f1rjZ+46fzPSvBhrrfUOAZiI1e5Ag+I9R74hxY9ks02sA1eBMWGmrjAQIW/kA3vr
fVXN4AZ3hPWdT84p9KzTi/PDz5sb27wlbm1mA5gQ5kODqLmcMprlDY6WjFtgTVr0xe8slhgr
wEsg5LF/Ect/7TjSjIvi6yJ1ktj3bwybukxwFxt2YDu4D5vdjqkTeGFsBEQu+ynOvnS2cyse
4YZeaDGpe6Zt0Lc/HEwIDLD25wYYHPNIjgu9PPx4dnL2Nl0B0OKgNMBTdAGvM5l0GU8KM4na
TTrIU+kF6C8FvwWgkgCgUjAwcxxQDCkBJSF13nCbQ2grh+Fc/u+XxnDhxHSwXqyhmoHpo38a
gX4MR9tqRhXSV32Ho4rz7qNgvlgmGazBfwbmi8VHfF/OOlSX/oRJ8n6oLpvo14d0ren6fSrF
FIhcQFEy8XwtAT7363F1B3d3fzRZABkJEFSe3KD9sSRnCy7BXTa+6c+ugLZDa2G+BwNsMYCl
pD/6UTZEOdx9BWfIuFgbfJNsftOfV+gG9A8RjiQRjrItKpsDcgQxZUSVIR/ZJpXqVQ2VDIBX
tVnGnVhSCV9RB5ccdzsMiAxR54TDwhsVfuTmeS6HScId0fD4bMc33eM1Sk5t1uoXNXWaw5P3
x0f7ThLyB76veuXkCAQFvAOodaJQPNDeFPjGHUaAeslX446WbZiSTHCZCJ/RmC6cPRr6dkL8
hrHv2hC/3WKRd+d572DY7bnuaFAXC8Bm8GlYj2ayelBOu2SN6vMvZxWycE2TKzYM5xo5mkbd
JjseDWHY8jPCKE+B+0Ce5Eqe/udchZvcZdjHR9ygDmrpNYAGS5pxVrPuLfl8Cuc7kpRxoLV0
6291VzWM7nW1mI1xmOPBIpDR6+GMECRmwwnlP3xAp5Hrr8MmBzSSBK5Ew8ivyWh39gI/2i0l
AOC6kfKumZsY7ucVbur58O5vjfAA8DIACqGhraJWBwAnMsxTZ+XMubNU33mqcvaaXOLpeSsJ
10qJJ5GEUIXkSSQBrv7fy5MrHD5Yq/+vJAOF1vWx2/oZ8GXtnSNafieXjsKLq8iIBDDa3nMA
244PnI8F4p3RZGiRMAcwfjb/dtBKTWSIBfKEgZRaacLZC3V/BJrpjBpappZkRNdHA+RRuaZU
qKWqhHq09Diq8mWLJNW9nXTXGQ4WXxdt4sKP+I6Au6Y0GqjI+b82I94vquXB/LDygUQXY0ff
f4L0VcROK5nMZcRC3KMs7+eUJYIkwh7/E0sNheffX7HiZ6WGDAbztHmVQvK1x5acvfChQRJw
yuuDTHIQuSJGy7NacD4jMYuXXdjDdV9fDKQRAplD+us4q2RWa/vLknOhjK/UeevoP5f63wfM
MU7E82Di/SfMMUv8ujlmfbrfHNsgumbEd1DBNBK5u0H2qwNIkz5jRy6nDG9KizCYJco68mFu
BFv5+sS5KMa4agE4mgMiLKINwopMkptyPO7rvovMwBzytHtrhXa56FejvlrtMDooKGU22qDs
c+3naszoI1ZFQ21mOezyItvMyCYLkQeAJg43i8f4GpqB6pTjIxs7cwSNC39T5YqJFiDsz7oa
zRj8WLBRmm/RoA0mS6QF8jLydouFSKC9yvvoGC9dgXsSbYh6j4YbtPqodl/HrSquxiYXg02F
9PsNC4/VKhUgsyNDPhvCyUYjpjI2XIqBbeeasW1RTSK4P2ebyXgoS5JtcNyOaiZpC+Hz0izY
IGQillvDpVa0DCJnQNd4WyXpKzK28nkot7cxNGjDq6HOYIOhNaOHeFvqTZFppkXVMgjP45re
bMu/OtWsnNGUOS/QyDK0nCzezEfVXxFOpDngbotiKyktC1BKpDwIeU20WaO9b72WMPSBbQvV
FVt0UAEpLHb7ev7vexJdn6tmUyxCM771T84uiIEJGftYbnT8Y5zXx7o7yUa+3Pj65v3h256O
rKCpSM8EG2SHX1JHAfEPM+f41RfNIYTvHL9eeTqip4gmMK9Z5Ntieiep44ciwl3cREpPA1+F
dJBQyudQjLI88EOipKdoNAQO6mYtHXGOowGR6R9vdBkcVRjPc3r6U8ssfYnzpafFpHMyHVWp
9SHCDom6qIvGrmqaygB3qdBEbb0TkYykU9YVn+9W79x1IY0UVHYqjQR+dg23et7gXk7hPVPB
KIFIIvQLMnVdh/sPnGb0ezmtFcUmfz3OBn1qt+OsnDCJ59MKld8up/Z7mqWjDW6FDJUK4HWq
sTH13SRxHeMjIi0IWoUtp/m25EfzokjD0OMf/Vk+S8lO4d/5JLPpE4ndpTNGflpRvHBhZ968
WtN9mLhxTG9tbcY2ldInvbE1KHGwCVRa63uQ9ZzJ2ldgVK906dFywaQ1T78s3dOT0kv7q7+4
JivfPM4mQy2IXyJFRSJwSmVFXH8xmek8NxVKD2qyrXGuj4S4WPSv1t2vzje9BQFVwkeBgN7T
Q6X9RCLzk5JU6Un6RQZfKkJoFHuTqUhCo0alcT/x3Q2FS39N2+6D2m7LNqPBDqYxl0adDkzJ
zk8kKxnH04Z4FsjJBDM6ygkFrjdeIZu3q40XxNrFwzZdqzfdRvHYtFH62TZGl/VBQ2v7ZNrm
zSuj0kji0jjSHCpU31D6x58wkMkkbf6zyGOEq51hN2usKoGGCr+phcgLdTVIEcZNPcjQddcq
Ig5Df2vLD3++5d9bH2T2B1FoVYgEGoFr1Ygfb60SwBZur5VE9ZuVigm5kq2qCZl7W+UIIVeq
Rz1vrSAayHGCdlsF8f8swgjOG+ocqSNfIOW9T8fPHe9FzD9P6bd8wVncO+X33GXUB/9F6NtU
Mm7YxQta3PDDc8d9EXA+3RfQH//AFXn8A4d66MdLh/ukyZRC0lHtJXXiRGUMyQSByhknGVo5
E6HOGh5clTNX58nV2fmhrKiWafISem7YDsTXy6tCDT+LasG3Upk3qIiVF/VyPlt9UX4HvPz/
t/dlzZEcR5rP7F9RJpsHarbRHfdBM9guJeNKYxqKY5S0D9smgxXqADEEUGCh0GTPzvz3dffM
yIq8I7Mq0E1N00xCV6WHexxZcXzu8bmqtdWSHxqXfL8gpfQyFNcNHitfKok6AtUNrLyihES/
//rb6DE561j56I/wI4KV/O23u/f4Yn33cPchEiVqC+e0LKXLV+S4dVZeohfj3eLxdr1Av9Mz
/F0cbm7XRS2v3t8Xp9v909PiYX/1iEdt/It07eiWKJiOkOoJMfGr5frf6VRbGUCaWY0GFsRf
if+xBX0o9GrDin9IVX6z0OVfEU7YLPxjcUG8bYhBHpugMfafLEgKuCsLwIdSnS0VwgjPtCCZ
NaUFGVuQZ7OgBF7mgY+K4s7KAvChVMeDIhkUDVgoPiFEfLe7iYxoVYz1wsTNMKEZNhjRqvxm
EZrTa2R/PPeU2XpRvYzGwYQaW1Y2RvlQ9wH1RS/9xfuL/eoNTYZHQ47IG8gQjw2FzoJ1qegr
HdoxOhz75wek3Tkcf4baC4TsyYqNrdjQnNBbPDRjtDmeXZRQUmXGMMoihmbwlmllRhVKNPOi
7LTwi4GzxYiZlg1uVdlhKh74cpi7bISOS7eBJN2lDYWzl5aKbFBtoYgu+s3AKl7aGO2uALuh
U/9oSFFcLRkycWOqCSXoteVILUY77Olus3k8WoBfY2iKi5viyqb4QqGBF7FUzPotYP+yCHI9
mjFWly8Y3o+uzBTV5khuVY4KU5PNHKEC4+giJppxLDJT1D0yI10YfJds5niMNl7w8h3DuLCj
GRE6rVCC1COTzRw3MhaWVQw0eqYopRDb8CcMTwoAP47Tl8f+/u2CVqaFgdltt188LVf72y1x
tP1we3ecHC2sSDDYqKm4BNatixbFi/d4HpS4bXxNB5sLWB2/go2kwC9wH0pfwBEO9wAlnW/x
FTci3sBZQ2tWl2+kF/IWpu1XA1WuALAjqPr24f0Ofa6wOl8gjIrRbDfbR8osdInQm2Bstfzy
D//7367++C9/+OPf/vLN91fffvd/vv7dv2JUcwBGL798eL67gy8WZVKd1/Xl/lJH8IZTRU7E
dNzdaaIKz4u7OzhyZsTdnaVNVBfuXj4axt1rQv24exCbirtH5YZx9yCYgrtXsqO4e5CcgLv3
F+nA3YPwJNy9XmgMdz/24Aju3qm2A3evyw3j7kE2GXc/9t4U3P3YxmTcvVmzcdw9lBjF3YPg
BNz92IApuHv120vC3atxS8fdj9UaxN2reozj7rHoEO4e5EZx90hhAu4epEdx91KwB3cPT0dw
9yB2Iu4e1JyIu4e2z8HdHaxPyMXXwt0d8nOwJu6uXBt3574Xdw9K5uHuVemZuHtVfhbuXpUO
uDuzcPwpcXfOtK7h7rj9aeDulYIO3N124O4O9hwYSdONu/su9NHZE9DHSbi7gpNUHtwdT07n
xt0dNx7Px59x97Ph7k5whjdREnF3EDfWnwN3t4x1vvnqHwl3J4i4E3en0hHuTp+7B8gQcf0o
7g6CHsklPync3QlHXBRN3J3saBtXzZZ1+9u3YFRXlTsn8u4kvOsuH/LuJHfoYlUGtkbDyLuT
8AKqXuQdHlsMl05A3h265/0g8g4iDtHLbMi7k5o5kRN5d9IIq3Mi705apURO5N1Jp73JjLw7
mLO4zoa8O9ojvQDy7pSQkuVG3p2SGu9vZ0benVLOZUbeHRw1uMyLvDtlKatYduQds/RJkxN5
d8rb0F0ZIXGnOdFUZYbEnRYytCYjJA6Dok05/njj7WhGlmbK8ZdKlmo5HxuWzvHXikj7B7F3
aMkRL5cBe9duCHt3GiZC08bem7pi7F03sHflR7F3eLlMtC/Ac73/yHi5g60Gn4SXQwmPN1yy
4uXOGMp2nAkvD+o78PLwaBAvrwv14uWV2ES8PC43iJdXggl4+VF2DC+vJNPx8oEibby8Ep6C
lzcKjeDlUQ8O4+Xdatt4eUNuEC+vZFPx8qj3JuDlURtT8fJWzUbx8qrEGF5eCabj5VEDJuDl
x99eCl5+HLdkvDyq1hBefqzHKF5eEx3Ayyu5Mbw8VjiOl1fSY3h5EOzGy6unw3h5JXYaXl6p
OQ0vr9o+Cy93juhw2ni58wojjRp4uZqGl5dKZuLlofRcvDyUn4eXh9IVXq6Z7cXLNWvj5UFB
Gy+3vgsvR2Ii24eX26449ZfEy5n4FeHlviCF/4yXnw0v90zSLYpEvBzEvRJniVN33Z6ifyi8
nPUNjuSmNjzF5+4BgrdeJeDlnnnKLvJJ4eWec6JjrvByHuPlPq6aifFykwUv91yywtuTBy/3
cG5Gip8EvNxzrfD6QQ9eDo8d00l4OUwtdJ9tAC8HEVfAXJnwcs9Bv8yJlyPNu+E58XIPY6mz
Rqp7mBPLqNV8eLkXglKKZsLLPcybzr4AXu7x9mR2vBxeKm3z4+VeFNe7cuLlXnjOdF68HFY9
aV8CL/ewIHKfEy/36JE02YFsL1WYGXMC2V5q4V8CyPbSUOZvMhS/AU6d25D1xH44hJjDWB1R
blEh5lYOIOaYgRzZiZqIeVPXIGLORxFzQVvHyigcLX2NVOUrWqsXBCEW/KVIh/i833xVYN9f
Mcr7DPvGieD50aTSSAmDq/Z+A0v4HhONwd/+NqOun4/NZLU2suH2OYUTQxSMP+4RcH2N+s+r
K/z6/37z/XdTnAP0MtVq5Go1GnEPYAnXcg/IpnuAn+QeICOZWAWD+m4aG3yENMiD7gESGncP
kNgMGhsop5HTddQ9QIKJ4fQkq1PcAyQ5jcYGi/CixpSe+PlhTd2C6tmRGzFI6l5HAnXEqiaM
NSmIXK/u768IRkbJJSGmchPLEhH51dV6R1orWcUR2dXa12Sx34hmsCXPCWPmR5CZ5IuB/PE9
zRNr8mfgCeJw9bjFb5526CkQjiDwWkFf4LjLpw8Pq7ohkla1JtAmDvrwfvdwtflltXnESQ9B
8mVbNI58tnq5qtVX1pFcOP3BfryO5PrS3U5ILiKlZqt4ieR6sZSraxchuXBaLJBcfKbYqq4m
MI6EtDEFknssiEguc0vrkXOwQnL1htXV+JlILhamLeOcEVJdIdP0wLUhYD4FAg5K5kHAVemZ
EHBVfhYEXJWOQqYHIGDbgoArBR0QcBdVCcpr2QsBm48dMu1+PRAwdaX7DAGfEwIuuzQVAgZx
Y88DAf83CJmm17MbAq5TlcheqhLq8Z4BqkPAIGg/OQgYKuX8JwMBK2cQCs0GAaN+kwYBo6jt
h4DxsUuDgFF0OGQaRYqr7LkgYDSQFwJGCyYrBIwWXFYIGCwInhsCRiP5yEpI/UuQlZAhlx0C
BivFZYK8EDCaUZkhYLRhMkPAaMO/BAQMhhTPCgGjBZUAAS+sOgUCRjP56T3IjE+BgJ0KA5P6
gkXUK2gmUK+kAsCi38yiJ86czMgx+FdE8CWr4F+jh+BfUGxEB/zb0BXDv4Y14F/mGvAvw01i
jaxE8Shg2hvGcamfAo8yJlaC4NE/ffP9n7/51xIURaz022++LT/9+TtM0jIzghprxdkkiBRL
ZIdI0UhGiBTVm26IFB8NJl4phUSFo/ZDpCg2g3GEyukUiBQFTSJEirIuCSIFSVrUJ0CkWESk
Ap8oXAQMv78vxFEQGvpQBC8rbKVgolbAtAqEjlN1zQWUWQqiOpTh9aq6tvXt3fKGwo4JHl3H
4oqNq8RlakQCm4zZrH5ZHg77EIO8ljUZXcbPbmNBivFVriaYzPNM0j4hfhYFMR93d/wsPeWj
8bMkJgbiZ9k2Ql0ZK+NnYfLE5AV1a4FvQhYRs6JAXTnzMH4wVRPqWpjYrrrjZ0nN3PhZKqy7
wFN84E8FT0slM8HTUHoueBrKzwNPQ+kjeCqmgadBQRs8NZ3gKcibXp7njw+eZuJ5zgKeYlea
z+DpOcHTsktTwVMQt2eKn/3vDJ4KWwdPi899A2RlCniKgp8azzNWytkIPO3geX457BQq4zPS
TQT9Kdgpig6EzxomMM4gBTstRYewUxTJSTdBBlRW7BQtZKWbIAs2K3aKFnxu7BSMcJ4PO0X1
4iWwUzSksmOnaMXkx07RjMuMnaINnxk7BRuCvwR2ioZkVuwULej82CmasYOgZqEdjh5ishle
M+NTQE1f8ldPMROf8kXggMEgwKMZ3TBzavAsGhqjeoYu7KB61vDmDaCnqFh3oKeyl+pZCDUd
PfUN9FQYHeOUXwW05auOANrX4TuoIBxcsT3bhfEGupSon6O4Wui/AYx1ILYWa+QnIqd0zy43
cipwr5sPORU93BP0yIwjpwJDcotM0wEtu8awNc5rmyHrBxDCtWghhMLxNIRQODEK5wknpyCE
wukElWYEIRSUuX4YIRSUcDoBIRR4cSYZIaQLeikIoehnpKWn4zfsSUyfAyEUSDx2OkIo/NxM
cFS4KxMcPJCY/OJUhJCUzEYIi9LzEcKi/FyEsCh9AkJYKEhHCCXTnxHC8yCElHD7M0J4ToSQ
eKrSEULJz5MJ7jNCmIoQUo+nIISS+08PISReyU8FIZSKZUUIiTw4DSGUSgwhhBKP+WkIoVTD
qeC8tXSZNEq/PhbfYZljKxadPa6+/v3vv/vbn/8aXX6rgjz++v3Xv//T3CgPqJtntbqNnVWw
hGyeVVTzrCJPO6ugkXw8eaRed59V8JEbO6vAgNJNtZEoDxSbE+WB5VJ48kgwNcoDZZPyuZOk
nxblAUUwvnfxeNiUhXYP1DLsElerBC8CPCpJPPFg9zpTk9J0IezxQ3F1LJzvxDVaNqqu0f29
YsTbb+42yycSJUo8sa11K8Hbhdqqp1aS6OTUal2TpEMjHJO2uz29AkSct1zVZELyH6Kmu9pd
/zsxt8HUhLEtxILGajUVYVSpCofdFfzU9ld3d3jSxeGq16AM9IllkUGQ3jJWexkp1AfPfqu7
ot8Lmr96013ysQ+kCX8ePfahIO899uFT0Tz2qdZ1PBTrSUTCBXGp1Y59LBz7iv9qalT3dTy3
WS7dxhXHvuKgh3f8jsc+VxtWxLDmHftsweTQPvbBA9VORGKnHftKJTOPfaH03GNfKD/v2BdK
H499clIikkpBeezjx82cYl3HPpTvvVXnPjaxmv8VEatRV35ORHLWY1/ZpanHPhDXsnnsKxo3
8djnReebL37Fxz5qUVoiElMfnuJz3wDpJGI1FPzkAkPwwBEFhsBsezz3qdqtOpXn3Ffz0EBt
XM7IENTv0859pWjfuQ8e+8TIEBTlY+c+50XOyBA0kDUFOFnIe6sOLeS9VYcnXJY7MgSNiHyR
IahevkRkCBrS2SND0IrNHxmCZnzmyBCwEbJAZ4sMQRviJSJD0JDKGhmCFl4gMgTN2KGQjfJW
HUwC5Whwn2xG1sz4aSEbA/216Lu8Zwu2MzJjYjOmYeZ4eW9wBuuJc0Ezo3EhqjMNiR28VYeK
u+JCVH8aktatunFSNUmpSo5GHcMZ7GhgCqnaOQDYWk3MNIzVMUSyM2OsYERkxFgL1tdOjBUe
jcaDoNB4PAhI6cEbaeutamKVUCQJq3SU/GsMq3SU8igNqwRZn4hVOmZ4GlYJkmoMqwQZMwmr
hAIuGat0zLJErBJExRhWCTLJSSBI2iRhlSDo+rFKR+TPo1ilYxhNdDJW6SiD4MlYJaiZfYkN
1xQ+wgBZn6CnMEA2JmNvbI1vcdwFdn4GyNjtBfVxfNKUjCVMc0q2Z56S0YjNNyWjetc9JcMj
ivQanJJRSI+7vVBsDv8jlvMpbi8P20We6PZCWZHk9vIFD/oUtxcWKebVzXuYgOBl+2GzvqLk
SWJF+XdWm5pwt1ut4yY0CBOzZAoFJMoWV6zHKSBRFhuZSgGJ8rMoILFg6XFKoIAE6dI1N0oB
iaKilwIyPB2hgEQxFVFAXovlkQLyerPWEQUknhYqCsjr7drU1eheCsiiYDcFJJzc62rM3Hkc
C7uZIyQ6YxThgWzHKLppzqpSyUxnVSg911kVys9zVoXSlbPKm35nVVeMYlDQjlGUXVmASN70
Oat6IPsXc1bhqfLX46zCrvwco3hWZxV0qZoQo4ji54lR9N3Rub9mZ1V6jCLX9SxAxefeAUqK
UUTBTy5GESplWOysqnFA8rhu+gWiFLE6OdMAgX6bmAYIRXm/twofizRvVSk65K0CkSLlRS5v
FRrwWb1VYMHnTQOEFmRWbxVaULm9VWjE5PNWoXr3Et4qNOSze6u88ewFOCDRjMzsrUIbKrO3
Cm2Yl/BWoSGX1VuFFnx+bxWYCbQCOd1IaEbmdyOhmeDis7EZW+80xcI0wG2yGVkzY8a8VbbT
WwXvxYC3ChTj6tHyVtl+b9WMFEBcqfquwys211s1FyutWZcT4VCPAWy54VCPLqB8cCip74ZD
vR5Nh4NCctRDhVKDsGLbQ4VFJsCKXrt0WNGTByoNVvQmNbMMyk7JLIPyah5o5WnzmAorenJj
JcGKHrf9vbCix037OKzoLT8HrOhtj3toGqzo8cL/XFjRWz1rhCydbwb9Sna2X6k5bVrPx9KY
ncWYYW8k7PJ1LU3b4CxZlKDbVfVZkjVnSTF/liQjUuFCmGOWjNQ3Z8noUf8sGQv1z5KxVOIs
OVwEpzM0YFhLuAAliwL4Pi9XqwOVRG+1J996u+pFoZvNgSabm+0jzmlbjnPg9aolXXr3l6uf
nm/Jz0XO/a0cVls5wvvkCLq6ut7c0Dpg0Olm1y3Zm83DZn8LnbHZb3f7shR2OM7u/LrdIVdX
oQj+Ckor8L898e1iXAD3rZcB2hhKFQUoqIAoMCjxGdf9NWubkdgWv2yVeL99IpGqEcR64XRL
kIRI79PjHWzoqgJ8ZWly6hqk9YZWjc5yEtstWz8xxMApaqKQXq4Ouz0FeqB0x7gVYmWhw64q
wImVQ8j2u/w/F7vH28fN1eN+gy/ZEt+cpWvXY3dVU46RISv8ebR/UCi6eVhjK4mhhCI9VHtE
MSIjCBoFoo72Ax19MBqWEUsPhmVEgh1hGfHTAeaQWKyPOQSOS8ewDPqE6641mskQlhGrwXVX
GW431bp7rcIqjOvumm+XKw1HvjZzSNz2yesuFlaWSz2JDP5lLgtT3ZyS6cRGRQm6iFBfAM0Z
iY3QiMaXIt8CWKrvWgDLR8MLYE2oO2oiFpsSNdEo1x81EQuORU3UZAejJmLJxKiJuMhQAF4s
1z6s2I2JDiv1agwfVmLZlMNKvYcnbIVrIz96WImlRw4rkWg1aWq+Ni2z9cNKPZYtFvu6Fq9G
k6bjckWffl99cmUsm7V6s9LtRhaHFTiQXHuMV6vSYHLKrflvsYlq0lRy1Wr9rElz9ggZaXiL
yZ0egEpZ2+t/CTv33y5gulsvbkDfAX6QC/rJw07i8fDDVwvthCpI5BZ3m+3hqMoQP37C3V9r
O8MpIiUzwini0nPCKeLy08Mp4tLHu7+8P5xCyXo4RaygHU7heDOcAuUtnKh9XzhFz91f9mJ3
f3814RTUlYo8RaeFU7hWh38a4RTmxcMpqEu9Yj1XS5vhFIW49627v9T3k8MpOuJaDDJBTR4L
wQr6qPOHU+A+uyecQtAI18Mp6FcbDY2mV7Ezoya9clFGTfrcOUBOWTZKCk+CmmhuP51wCqoU
zH48CqfgvjecgofKnTWaQoq4Ns5pnSmagvR7jyHwGE3hBqIpUNQzuqzVFU1Bj7nkCdEUhShR
jfRFU5CIEEWgQI5oCjIAJ8V80RRkQRmdjxWeLGhX3mvMEU1BFixdQnqXLZqCjDgZvMTnjqYg
9V6FRIT5oinAEEy9RKP9Ll80BVmBHZjMG01BZiRl53qXK5qCbCipc7LCkw2tlc4dTUGGDNEw
vcsTTUEWistT7yaEOaTHH7CjGS+r+INMYQ5oBk4uIdUpXqo5mnG9rRn81XeEOZAZbtVoqkvT
TdYu+8IcSLHkuHK2whzMAFm7q4c5SMeaZO2i4ULzPtoNKA7rtK9ztX+EO7lUk4IaYNBxWO+J
KY7DequFkTVIl33Ey29lfWqxJmwMxqUSrctvugnjspNgXDKS6fJbUO87YVx8RCEaQzAuCVXE
kL0wLoqZGTAulRvlfAyCKZyPQdanwLgoafkkGJeK2JTAkyCcEnhSyrpELJdkU++zBfnJ99lC
QZ+K5aK0T8NySVR1Bp6Ep3o48CSI2SOWyzcw7lXgyfJ65VlP4MlytfK1RmLg7imBJ4UaRfSo
c7BcKjwHy6WCqgPLpQftrJywPLcBWNMHwAYliwbgmgbAVqVrACxMT4kAbFW+DcBqpnoAWNkq
fQRgYfd4BGB9/T6bbgGwlYI2AAs91gZgUR5vmfYAsKKNByIAOx0SDDDUVPJFQqZyALCExZ0V
gKWuPPk+22cAltX2Y0ok3mcL4v48nPvuHw6Abd9n6xscyRoALOsDYLHHZc8A1QBYElSfGACL
ldIxACtkDMCquG4ivs+mzn+fraxOwQWZB4El/S4JgSXRfgQWH9sE9sUgOsC+GESysS8GAyYn
AksWfE4EFi24rAgsWch6ny0YsdkQWFTv2UsgsGhIZEdg0YrOj8CimWx5ORG6/Pvi6/Ua8/jB
OOAqib/OJ1hRdveLt/AORhXRLCdFY7AhXwKmRUM6K0yLFtwQTFve35LOlYomcCfGa7euLr0N
wbQLcRJMi2ZkfpgWzZSXHguC4WDG95qZnrwzGLJjeLCOkEt2xIPVEB4MipE5p4UHN3SdeO3N
m/pGT6sYD2YvduuttI6w3yQcVCMGmBsH1ciHkA8H1XitqxsH1SYBB9Vm9D4HSXXfSuu7z4FF
bHckaSeeqIkkMA1P1NYk44macMp0PFFTetEZaJWmVKKpeKKmLKFJeKLGvVAvnqhxGhzHEzXu
eE7HEzXGopyOJ2o/6yJbKGxmjZCj7K2DLqL65DjJRVSfCJ0UY/fYzmVLW6vcJ+SOgvrUrtWN
T8NYojkN+9a1uhOnYTCScxpG9T3TMD6yY9MwCNnqhnK/OwrF9Ax3FJYLBLCD7ihtiUkzyR2F
sjLJHaWLlHlT3FG6yGSXtnygcPfVgvbygbKpy4cus8elLh/aFkyWkycnXaaWS1s+dJknLmH5
QFHXu3zoIjXc2PIBYjy6B8230tWWDzuwfNhaI3Hvfuryocukc7OWDyw8y2Goi8R0bXeULhLH
NekVRdsd5frdUaWSme6oUHquOyqUn+eOCqWDO4pD84/uKKfqucBE2x0VFLTdUUJ2uaN0kf2u
j16x0x2lXsodpRnP5I6SGdxRukjW99kddT53lC4SF6a6o3RIbHc6vWKnO8qKfyR3lOqjV/T1
DNC+MwF06O/RTGBB8JMiVywrZUzkjAqZwMiQES/tjNJFgq1szihdZOVSRlg54oxCUdnvjMLH
Ks0ZpYs0XEPOKB3yaOVyRukqyVUuZ5SuUlDlckbpKvdULmcUWnC5nVFgJADbOZxR+pijKa8z
Cg2Z7M4ofUyhlNMZpYvcRnmcUZGNnOSKwYZ9CT8TGJIsq58JLaTQEZ7oAEIzJr8DCM24IQdQ
YQ9eY15qCxNnMlVkaUaVk4uPGSl9YKQMic3gIFW2Jp1ckdXMjN468BEgKSovk+slVywV48zb
8jI1dNW8TKLpZTJjXibtrIl2BUZxPP8Ntgb6rdNn5oZaA4plxx2Kpq6hxGYJdygEi69UolHz
8ZxmYN3qSWgtlMAYk7xoLRqR+dBaVK+70VqMzxzjgCGhcacZSk10mmEoo0xFPVFYJ6KeKOsT
UU+QxR1PMuqJ8pO5BUNBm4x6IiMCT0M9UVT2op74VI2jnihmTkc9Uc0ZgvBRjZ+LemIs86wg
fPQbjjiyGrPjFEdWcybUXo1c4jqfMacZXvYfXkR455Jo+NAigop9xyLCB5bE6YEXIqayVB6v
ro6t766TPFkPru+gGDcOrfXd9ZInj94q9LLZlgie0cwZPD8MD4voXtt7k5aWikXX2i5613ZK
eVcbFuaaazuSz9QpRrmot+bjBcSg9WkBMVjCNAlOoYfOuraTkXz8bqS+I1FpeORG1nYUIk/s
4NpOUt0Ldd/aTkUK19MIDXQp7FLdnySc6P4kWZ22ESDZCe5PlPdsxjJDBZPdnySd5v4k0d7o
GXo67v4EMcti9+eS2yMN9JpvXB8N9FpsfF3NiTTQQc1c9ycVnuP+1EjsJUbWZjF7bW5Mm3iJ
Tb2UMckpv8HwitOdJrs/8UCpuCvxQFPXYJrslBUnPhtrxc3oSd/Lzm3N4E4AFeuu1sjebc2J
OwHNOf50j8o/FrkA1EQwNYUoHEvwZsJv6KmzEoWTkYzrKKrvWUfhEfkMBtdRFFKj6yhKTSMK
xyKElI/wjZKc7FwVW3yjJJu6KqKsnbAqgryatSpiwWS+UZJOXBVR1PXxjdLT1qrY4htFMc1n
8I1yz9asZk0P8I0yt07hGyU1s1dFLDwnplTDHD+WdLsxQU5ZqOLZ0Em6EjU8r9vu4+rQPQFU
7DtOeE1dp65SPF6lDChho2uu6V5z7UBrUDHvuPXQ1HVqsh8be6mNshKTOw+2RsBrsF+FVvjB
NoA6025D0FDVvWAejapOfRzX3HvT+0YZvEeqxsbAdZ+0hwAQUtwFgLiz3jxR0tQaYxn7WAdt
sj7poE0lfHOD4M570EYjPF/IM6nvDnmmR2OZREjIj20QUEoMMtm0NghURCYetEk4lfaGhF3a
QdvQ7zhtS0GyEyjMSX4O4k4F0/ItBWmftKVAUXRkHg/ay/Wy9qqokTTuQUymbCkYLt/WHfMt
xXkfSI0KWwovlsvr7XFLwUuluIkwG76ClSg+aK9qg41UfbO2FFR4zkHbGG352NnXzT77NmZN
TS18GVsFz9XwctPtgh5ZbgpSrNZyM+SCnr7cSBthBsYyuks01BgMQvoyBBOFprChhoBSjDtr
NKSh57j6s+bq32hE/9HackHTzVD1YUHrHoshBzoqVu1wgJauIZAgZTNZi4lEnn01spHBqKPO
zeTQm0WK229WS9epbxY3cWM83dQb+Ek27U/5STZt0Wi9iC04AuvRQZKdu81BXAoVm/aOv6Xr
bLiUhY342I1ty7pPYnawJUZQnGSrJQMnsfbrNhpLI62JPIfWMudHpwLd/eMZ4iMlxbajNfqs
Px4bQ7kWI7bNyAutZ7/QdVtOeLT1SFu2xfIAm9wfsAt/87ZUv7j4aXHxy+IG1vv97vr56XB1
d/t0WFz8eeHpv9+8s+ha/3n5hKU394+wz19cf5imwPw9VMhxI+3IAgtnju6RHJrUUbHr+oX5
3pGcwyxbj/x2glFyxuHWmO7T6ZAfmBS3T9ctXafiHcKbuDWC22HvSbMCkxwaTWNiJInmOY1J
yUawD3jNu7cSQ7shUtzeDbV0nYrkOBY3pvCNDjeGwYEZzKds6VCh79oPVTqq6nNn6r8ZXZ/J
Ve+C5KSSmLd4cLyDwZnwo9NG6LFh5j0hl4M/R1Tc8XNs6jr150jvRmXUKGKZHeoxPj/QqGVM
yZHhOacxq8feYN69Fx7cZqFi03b/tXSdbZvlGUw0I4FAlvfEZw0B3qBYso6NSVPXqRMLiy9K
eWYFG9s08hnbX1TMO2aYpq7zjQuXjo9tM3i3u3y4Jai447TV1HW+lmC20LEtBu92Qgy3BBV3
zWn9TohTW2LF6Cae2xlvFyruWISbus7YEifsyA6+YXzmigaWaH/xIpasGx0d3TmTjYyOI1aN
1ujo3pnsxNExTMux0akbn9tnrrjNObwT4+k7MVLYheXwM+7EMLOPGNvm89N2YmCD+I+G36Ye
HHXowA6KDes45jV1nZpAxFXLIn/DGKfLXPGNtY/AXkS32eI6xek0qE6D7ryyTDMvsmrGzZKm
+Q690ozL5NAr1Xel1Cge6WGHXinkRziMCjEjOzmM0B1C1EGrmnDhR9mvngs/SiWLLihR11tw
HOHwXi/XDwVvEWea3Gc2lqQQ3xZxkbmOiYtKycEw3wZxUVmk8M2tdvePu+eHNfUFqkdRKWqS
Psn1WAinxfiWsknRTKVscjRTIT8jxrcsmBjNVErrBNdjKVqP8dXXtX7zLYa8Rsp5FBOMVQx5
3m2XW/QZ/q76tIlifIVfldFMxad1XQ2PoplgHEKMb/WpK8Z3u7TLTV3NPIa8srCbNUIwG7AW
xVH5QDcpjjASp0VxpHk3xdFRyRyKo6j0LIqjqHxXyuMRiqOodEVxhDdcA8URZ/WMG8o1KI4i
BQXFkVYRxVE740YhL1gPxZEQpoviyLxYxg1jdSaKI3VuiqOyK/VniqOzURyVXWoSKY4Kcakb
FEfGVaOQTnFkpeiiONKfVMYNSfScyRRH9B7FKY9JpmtweCPjBu/JuFH2eM8ARSRHhSBudj8h
kqOiUtodSY6cOVZMu3+urAgbGI6+iRmOvjmR4YjezLguNlvC41K/IYYjP5huoxS1PQxH5WOX
wHBUivoBhqNCxLFsDEelAZWP4ai0YPMxHJUWfD6Go8JClUEiHztQaUjnZQcqrdjM7EBkhlcZ
IjrYgawqOW40C4aT2YEiVp3SkOynCIoNBfqWVIqgtiGTnSeoNOTy8QQVFrIniijNFPMLRYaH
UugKLWptbFPbKDcYGqkZMKUBHhsIv8hzGChmF8sjpiP4UO8o6VQ5BPNfrpJMy4qIhMgKVjcE
Rx0x1dBK1szgDXza/sC683C7WlwsHnaHBcIBuP+qo5pwNFjD4wWCgLiEBUxy8/TmzZum1trn
l4DiBHEQZYPiQH0fFCe4rJjCe6E4QUxGRS/Dc78hEG5TEzBdEJjVTQgMJLtRqn4ITHDF0yAw
kFTJEBgIm1QIDGST+G4KWZ3Md1PKy3kAC0fvfCoEBtIuEQIDUd8PgcG5iqVAYBwjKU+HwLhR
54DAin3hTAiMm5kQmIjmqO+2Wyjw1WJ9+4QT0PrVq2/ulo9PG9gD3+LP3bJXr37a3D9f3N7f
LFag9LBZXGwXP612Pwss9OPFh93qsLvAeeaOiwshL9gCZpE/TC3FZ5USs0rJWaXUrFJ6VilT
lHoFY3v55asvqPTTh6fD5v7iF2eujHr1xcXmAUfsAkTgw+rxGWbqp583d3ev/8fT/eYR/3/5
CE+Ks/jin4q/8AWuDzB1v909waH9ZvOWjBf/H7aZF7fSmTerm/8A8XusCvx9un9ccPi7RoRh
s9jgGvj6YXOAz5fwh8Gj4tPiGQ5ar2/X4VuM7C/9Ug8rlNpd7Df4Jfz75+Vh9cN6d7O4RQKI
zdN19N0Fghu7h8V6c/18A9/vD6vF9fJpc0nbenw9sTb72/cbcsdd9ryNr+8369slPX19u718
f7sHrSkl+eySYnZJObukml1Szy5p+krCC3ALx/ynw7pQdPv0eLf8ADudBxwzmOpvD7v9An2W
r3776hVCpQ9rfM/38FZcYia8t/vlPbw7Pzw/3FwdYA2+olX+Et6/8m1YPsLH8t/ww9j/BKvr
z8sPT1fFr2INulbPj2v4qb1Brxr8PHAjcXd3he8N7Agu4fV99QW8oW9ut5SF7xI+PsLbf/jx
Ddj/8f7p5nL3AF+R3Qsw/LTbHhAWe348Vubh/vYqvK6X9O2rL3a7x6fw77sdTMvQFOygS4EG
YLNwqL4Bk+v99frN/e3Dbn+1gl3E4dJRe+CHvobj683V3eb95u5ys9+/+uL25gFhBviWvnz1
xWr38LSDwTkcPoCmzXJ/96FoAX7zF/aacy2wlZFc9O37m+XlA+FP0Fc/v/rier98WP1weXf7
8PwL/sg3d2/p/y9W2MDnxwvYvTmmcK8EG4Uvfvfdd3+9+pdvv/7DN5dvH3+8eUvl3uK8cQGK
1mBze3tz8cCoGJdvb1arC/u23Giu5LVcMr+VGymtZsulYBvJ1ZZfO7bR0vC37+9R4X9cdO5T
u7sNB3yz3755+uH5sN79/ADdCy/Xb/7p/8EM+e5//f2/frO4KN60BXxX/OvdP8PXr/4/WkAB
sGkrAgA=

--ktpplqomzai76t5t
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-quantal-ivb41-100:20180403043612:i386-randconfig-n0-201813:4.10.0-11075-ge2679ae:258.gz"
Content-Transfer-Encoding: base64

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

--ktpplqomzai76t5t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-yocto-intel12-23:20180403040553:i386-randconfig-n0-201813:4.10.0-11076-g2b232e0:256"

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

--ktpplqomzai76t5t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.10.0-11076-g2b232e0"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 4.10.0 Kernel Configuration
#
# CONFIG_64BIT is not set
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
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
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
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_32_SMP=y
CONFIG_X86_32_LAZY_GS=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=3
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
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
CONFIG_KERNEL_LZMA=y
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_FHANDLE=y
CONFIG_USELIB=y
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
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_IRQ_DOMAIN_DEBUG=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
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
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y

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
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_TREE_RCU_TRACE is not set
CONFIG_RCU_KTHREAD_PRIO=0
# CONFIG_RCU_NOCB_CPU is not set
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
# CONFIG_CGROUP_HUGETLB is not set
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_DEBUG=y
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_NAMESPACES is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
# CONFIG_RD_LZMA is not set
CONFIG_RD_XZ=y
# CONFIG_RD_LZO is not set
CONFIG_RD_LZ4=y
CONFIG_INITRAMFS_COMPRESSION=".gz"
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
# CONFIG_UID16 is not set
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
# CONFIG_SYSFS_SYSCALL is not set
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_POSIX_TIMERS=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
# CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
# CONFIG_PCSPKR_PLATFORM is not set
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
# CONFIG_EVENTFD is not set
# CONFIG_BPF_SYSCALL is not set
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_ADVISE_SYSCALLS=y
# CONFIG_USERFAULTFD is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_MEMBARRIER is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SYSTEM_DATA_VERIFICATION is not set
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
CONFIG_KEXEC_CORE=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_JUMP_LABEL is not set
# CONFIG_UPROBES is not set
# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK is not set
CONFIG_HAVE_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR is not set
CONFIG_CC_STACKPROTECTOR_NONE=y
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_HAVE_COPY_THREAD_TLS=y
# CONFIG_HAVE_ARCH_HASH is not set
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
# CONFIG_CPU_NO_EFFICIENT_FFS is not set
# CONFIG_HAVE_ARCH_VMAP_STACK is not set
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX is not set
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
# CONFIG_MODULES is not set
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
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
CONFIG_FREEZER=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_FAST_FEATURE_TESTS=y
CONFIG_X86_MPPARSE=y
CONFIG_X86_BIGSMP=y
CONFIG_GOLDFISH=y
# CONFIG_INTEL_RDT_A is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_LGUEST_GUEST is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
CONFIG_NO_BOOTMEM=y
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
CONFIG_MWINCHIPC6=y
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=5
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_MINIMUM_CPU_FAMILY=5
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_CYRIX_32 is not set
CONFIG_CPU_SUP_AMD=y
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_TRANSMETA_32 is not set
# CONFIG_CPU_SUP_UMC_32 is not set
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
CONFIG_NR_CPUS=32
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=y
# CONFIG_X86_LEGACY_VM86 is not set
# CONFIG_VM86 is not set
# CONFIG_X86_16BIT is not set
CONFIG_TOSHIBA=y
CONFIG_I8K=y
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_NOHIGHMEM is not set
# CONFIG_HIGHMEM4G is not set
CONFIG_HIGHMEM64G=y
# CONFIG_VMSPLIT_3G is not set
CONFIG_VMSPLIT_2G=y
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0x80000000
CONFIG_HIGHMEM=y
CONFIG_X86_PAE=y
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
# CONFIG_NUMA is not set
CONFIG_NEED_NODE_MEMMAP_SIZE=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
# CONFIG_MEMORY_HOTREMOVE is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
# CONFIG_BALLOON_COMPACTION is not set
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
# CONFIG_CLEANCACHE is not set
# CONFIG_CMA is not set
# CONFIG_ZPOOL is not set
# CONFIG_ZBUD is not set
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
# CONFIG_HIGHPTE is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
# CONFIG_ARCH_RANDOM is not set
CONFIG_X86_SMAP=y
# CONFIG_X86_INTEL_MPX is not set
# CONFIG_EFI is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
CONFIG_PM_WAKELOCKS_GC=y
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
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
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
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
# CONFIG_SFI is not set
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
# CONFIG_CPUFREQ_DT is not set
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
CONFIG_X86_POWERNOW_K6=y
CONFIG_X86_POWERNOW_K7=y
CONFIG_X86_POWERNOW_K7_ACPI=y
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
CONFIG_X86_SPEEDSTEP_ICH=y
CONFIG_X86_SPEEDSTEP_SMI=y
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_CPUFREQ_NFORCE2 is not set
CONFIG_X86_LONGRUN=y
# CONFIG_X86_LONGHAUL is not set
# CONFIG_X86_E_POWERSAVER is not set

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK=y

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
# CONFIG_CPU_IDLE_GOV_MENU is not set
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
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
CONFIG_PCI_BUS_ADDR_T_64BIT=y
# CONFIG_PCI_MSI is not set
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
# CONFIG_PCI_STUB is not set
CONFIG_HT_IRQ=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# DesignWare PCI Core Support
#

#
# PCI host controller drivers
#
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_SCx200 is not set
CONFIG_ALIX=y
# CONFIG_NET5501 is not set
CONFIG_GEOS=y
CONFIG_AMD_NB=y
CONFIG_PCCARD=y
CONFIG_PCMCIA=y
# CONFIG_PCMCIA_LOAD_CIS is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
CONFIG_I82365=y
CONFIG_TCIC=y
CONFIG_PCMCIA_PROBE=y
CONFIG_PCCARD_NONSTATIC=y
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
# CONFIG_COREDUMP is not set
CONFIG_COMPAT_32=y
CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_NET=y
CONFIG_NET_INGRESS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=y
CONFIG_UNIX=y
CONFIG_UNIX_DIAG=y
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
# CONFIG_XFRM_USER is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
# CONFIG_XFRM_STATISTICS is not set
CONFIG_XFRM_IPCOMP=y
CONFIG_NET_KEY=y
CONFIG_NET_KEY_MIGRATE=y
CONFIG_SMC=y
# CONFIG_SMC_DIAG is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=y
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=y
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=y
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_INET_UDP_DIAG=y
# CONFIG_INET_RAW_DIAG is not set
CONFIG_INET_DIAG_DESTROY=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=y
# CONFIG_INET6_ESP is not set
CONFIG_INET6_IPCOMP=y
CONFIG_IPV6_MIP6=y
CONFIG_IPV6_ILA=y
CONFIG_INET6_XFRM_TUNNEL=y
CONFIG_INET6_TUNNEL=y
# CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
CONFIG_INET6_XFRM_MODE_TUNNEL=y
CONFIG_INET6_XFRM_MODE_BEET=y
CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=y
CONFIG_IPV6_VTI=y
CONFIG_IPV6_SIT=y
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
CONFIG_IPV6_SEG6_HMAC=y
CONFIG_NETLABEL=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=y

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=y
CONFIG_NETFILTER_NETLINK_ACCT=y
CONFIG_NETFILTER_NETLINK_QUEUE=y
CONFIG_NETFILTER_NETLINK_LOG=y
CONFIG_NF_CONNTRACK=y
CONFIG_NF_LOG_COMMON=y
CONFIG_NF_LOG_NETDEV=y
CONFIG_NF_CONNTRACK_MARK=y
# CONFIG_NF_CONNTRACK_SECMARK is not set
# CONFIG_NF_CONNTRACK_ZONES is not set
CONFIG_NF_CONNTRACK_PROCFS=y
# CONFIG_NF_CONNTRACK_EVENTS is not set
# CONFIG_NF_CONNTRACK_TIMEOUT is not set
CONFIG_NF_CONNTRACK_TIMESTAMP=y
# CONFIG_NF_CT_PROTO_DCCP is not set
CONFIG_NF_CT_PROTO_GRE=y
# CONFIG_NF_CT_PROTO_SCTP is not set
# CONFIG_NF_CT_PROTO_UDPLITE is not set
CONFIG_NF_CONNTRACK_AMANDA=y
CONFIG_NF_CONNTRACK_FTP=y
# CONFIG_NF_CONNTRACK_H323 is not set
CONFIG_NF_CONNTRACK_IRC=y
CONFIG_NF_CONNTRACK_BROADCAST=y
CONFIG_NF_CONNTRACK_NETBIOS_NS=y
CONFIG_NF_CONNTRACK_SNMP=y
CONFIG_NF_CONNTRACK_PPTP=y
CONFIG_NF_CONNTRACK_SANE=y
CONFIG_NF_CONNTRACK_SIP=y
CONFIG_NF_CONNTRACK_TFTP=y
# CONFIG_NF_CT_NETLINK is not set
CONFIG_NF_CT_NETLINK_TIMEOUT=y
CONFIG_NETFILTER_SYNPROXY=y
# CONFIG_NF_TABLES is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=y
CONFIG_NETFILTER_XT_CONNMARK=y

#
# Xtables targets
#
# CONFIG_NETFILTER_XT_TARGET_AUDIT is not set
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=y
CONFIG_NETFILTER_XT_TARGET_CONNMARK=y
CONFIG_NETFILTER_XT_TARGET_CT=y
CONFIG_NETFILTER_XT_TARGET_HMARK=y
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=y
CONFIG_NETFILTER_XT_TARGET_LED=y
# CONFIG_NETFILTER_XT_TARGET_LOG is not set
CONFIG_NETFILTER_XT_TARGET_MARK=y
CONFIG_NETFILTER_XT_TARGET_NFLOG=y
# CONFIG_NETFILTER_XT_TARGET_NFQUEUE is not set
# CONFIG_NETFILTER_XT_TARGET_NOTRACK is not set
CONFIG_NETFILTER_XT_TARGET_RATEEST=y
CONFIG_NETFILTER_XT_TARGET_TEE=y
# CONFIG_NETFILTER_XT_TARGET_TRACE is not set
CONFIG_NETFILTER_XT_TARGET_SECMARK=y
CONFIG_NETFILTER_XT_TARGET_TCPMSS=y

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=y
CONFIG_NETFILTER_XT_MATCH_BPF=y
CONFIG_NETFILTER_XT_MATCH_CGROUP=y
CONFIG_NETFILTER_XT_MATCH_CLUSTER=y
# CONFIG_NETFILTER_XT_MATCH_COMMENT is not set
# CONFIG_NETFILTER_XT_MATCH_CONNBYTES is not set
# CONFIG_NETFILTER_XT_MATCH_CONNLABEL is not set
# CONFIG_NETFILTER_XT_MATCH_CONNLIMIT is not set
CONFIG_NETFILTER_XT_MATCH_CONNMARK=y
# CONFIG_NETFILTER_XT_MATCH_CONNTRACK is not set
CONFIG_NETFILTER_XT_MATCH_CPU=y
CONFIG_NETFILTER_XT_MATCH_DCCP=y
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=y
# CONFIG_NETFILTER_XT_MATCH_DSCP is not set
CONFIG_NETFILTER_XT_MATCH_ECN=y
CONFIG_NETFILTER_XT_MATCH_ESP=y
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=y
CONFIG_NETFILTER_XT_MATCH_HELPER=y
CONFIG_NETFILTER_XT_MATCH_HL=y
CONFIG_NETFILTER_XT_MATCH_IPCOMP=y
CONFIG_NETFILTER_XT_MATCH_IPRANGE=y
CONFIG_NETFILTER_XT_MATCH_L2TP=y
CONFIG_NETFILTER_XT_MATCH_LENGTH=y
CONFIG_NETFILTER_XT_MATCH_LIMIT=y
CONFIG_NETFILTER_XT_MATCH_MAC=y
CONFIG_NETFILTER_XT_MATCH_MARK=y
# CONFIG_NETFILTER_XT_MATCH_MULTIPORT is not set
CONFIG_NETFILTER_XT_MATCH_NFACCT=y
# CONFIG_NETFILTER_XT_MATCH_OSF is not set
CONFIG_NETFILTER_XT_MATCH_OWNER=y
# CONFIG_NETFILTER_XT_MATCH_POLICY is not set
# CONFIG_NETFILTER_XT_MATCH_PHYSDEV is not set
# CONFIG_NETFILTER_XT_MATCH_PKTTYPE is not set
CONFIG_NETFILTER_XT_MATCH_QUOTA=y
# CONFIG_NETFILTER_XT_MATCH_RATEEST is not set
CONFIG_NETFILTER_XT_MATCH_REALM=y
CONFIG_NETFILTER_XT_MATCH_RECENT=y
CONFIG_NETFILTER_XT_MATCH_SCTP=y
CONFIG_NETFILTER_XT_MATCH_STATE=y
# CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
# CONFIG_NETFILTER_XT_MATCH_STRING is not set
CONFIG_NETFILTER_XT_MATCH_TCPMSS=y
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# CONFIG_IP_SET is not set
# CONFIG_IP_VS is not set

#
# IP: Netfilter Configuration
#
# CONFIG_NF_DEFRAG_IPV4 is not set
# CONFIG_NF_CONNTRACK_IPV4 is not set
CONFIG_NF_SOCKET_IPV4=y
CONFIG_NF_DUP_IPV4=y
CONFIG_NF_LOG_ARP=y
CONFIG_NF_LOG_IPV4=y
CONFIG_NF_REJECT_IPV4=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_AH=y
CONFIG_IP_NF_MATCH_ECN=y
CONFIG_IP_NF_MATCH_RPFILTER=y
CONFIG_IP_NF_MATCH_TTL=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_SYNPROXY=y
# CONFIG_IP_NF_MANGLE is not set
CONFIG_IP_NF_RAW=y
CONFIG_IP_NF_SECURITY=y
# CONFIG_IP_NF_ARPTABLES is not set

#
# IPv6: Netfilter Configuration
#
# CONFIG_NF_DEFRAG_IPV6 is not set
# CONFIG_NF_CONNTRACK_IPV6 is not set
# CONFIG_NF_SOCKET_IPV6 is not set
CONFIG_NF_DUP_IPV6=y
CONFIG_NF_REJECT_IPV6=y
CONFIG_NF_LOG_IPV6=y
CONFIG_IP6_NF_IPTABLES=y
CONFIG_IP6_NF_MATCH_AH=y
CONFIG_IP6_NF_MATCH_EUI64=y
# CONFIG_IP6_NF_MATCH_FRAG is not set
CONFIG_IP6_NF_MATCH_OPTS=y
CONFIG_IP6_NF_MATCH_HL=y
CONFIG_IP6_NF_MATCH_IPV6HEADER=y
CONFIG_IP6_NF_MATCH_MH=y
CONFIG_IP6_NF_MATCH_RPFILTER=y
CONFIG_IP6_NF_MATCH_RT=y
CONFIG_IP6_NF_FILTER=y
# CONFIG_IP6_NF_TARGET_REJECT is not set
# CONFIG_IP6_NF_TARGET_SYNPROXY is not set
# CONFIG_IP6_NF_MANGLE is not set
CONFIG_IP6_NF_RAW=y
CONFIG_IP6_NF_SECURITY=y

#
# DECnet: Netfilter Configuration
#
CONFIG_DECNET_NF_GRABULATOR=y
CONFIG_BRIDGE_NF_EBTABLES=y
CONFIG_BRIDGE_EBT_BROUTE=y
CONFIG_BRIDGE_EBT_T_FILTER=y
CONFIG_BRIDGE_EBT_T_NAT=y
CONFIG_BRIDGE_EBT_802_3=y
CONFIG_BRIDGE_EBT_AMONG=y
CONFIG_BRIDGE_EBT_ARP=y
CONFIG_BRIDGE_EBT_IP=y
# CONFIG_BRIDGE_EBT_IP6 is not set
# CONFIG_BRIDGE_EBT_LIMIT is not set
CONFIG_BRIDGE_EBT_MARK=y
# CONFIG_BRIDGE_EBT_PKTTYPE is not set
CONFIG_BRIDGE_EBT_STP=y
CONFIG_BRIDGE_EBT_VLAN=y
CONFIG_BRIDGE_EBT_ARPREPLY=y
CONFIG_BRIDGE_EBT_DNAT=y
CONFIG_BRIDGE_EBT_MARK_T=y
CONFIG_BRIDGE_EBT_REDIRECT=y
# CONFIG_BRIDGE_EBT_SNAT is not set
CONFIG_BRIDGE_EBT_LOG=y
CONFIG_BRIDGE_EBT_NFLOG=y
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
CONFIG_TIPC=y
CONFIG_TIPC_MEDIA_IB=y
# CONFIG_TIPC_MEDIA_UDP is not set
CONFIG_ATM=y
CONFIG_ATM_CLIP=y
# CONFIG_ATM_CLIP_NO_ICMP is not set
# CONFIG_ATM_LANE is not set
CONFIG_ATM_BR2684=y
# CONFIG_ATM_BR2684_IPFILTER is not set
# CONFIG_L2TP is not set
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_HAVE_NET_DSA=y
CONFIG_NET_DSA=y
CONFIG_NET_DSA_TAG_BRCM=y
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
# CONFIG_VLAN_8021Q_MVRP is not set
CONFIG_DECNET=y
# CONFIG_DECNET_ROUTER is not set
CONFIG_LLC=y
CONFIG_LLC2=y
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
CONFIG_LAPB=y
CONFIG_PHONET=y
# CONFIG_6LOWPAN is not set
CONFIG_IEEE802154=y
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=y
CONFIG_MAC802154=y
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
# CONFIG_NET_SCH_CBQ is not set
CONFIG_NET_SCH_HTB=y
CONFIG_NET_SCH_HFSC=y
CONFIG_NET_SCH_ATM=y
# CONFIG_NET_SCH_PRIO is not set
CONFIG_NET_SCH_MULTIQ=y
CONFIG_NET_SCH_RED=y
CONFIG_NET_SCH_SFB=y
CONFIG_NET_SCH_SFQ=y
CONFIG_NET_SCH_TEQL=y
CONFIG_NET_SCH_TBF=y
# CONFIG_NET_SCH_GRED is not set
CONFIG_NET_SCH_DSMARK=y
CONFIG_NET_SCH_NETEM=y
CONFIG_NET_SCH_DRR=y
CONFIG_NET_SCH_MQPRIO=y
# CONFIG_NET_SCH_CHOKE is not set
# CONFIG_NET_SCH_QFQ is not set
# CONFIG_NET_SCH_CODEL is not set
CONFIG_NET_SCH_FQ_CODEL=y
CONFIG_NET_SCH_FQ=y
CONFIG_NET_SCH_HHF=y
CONFIG_NET_SCH_PIE=y
CONFIG_NET_SCH_PLUG=y

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
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=y
CONFIG_NET_CLS_FLOWER=y
# CONFIG_NET_CLS_MATCHALL is not set
# CONFIG_NET_EMATCH is not set
# CONFIG_NET_CLS_ACT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=y
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=y
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
# CONFIG_MPLS_ROUTING is not set
CONFIG_HSR=y
CONFIG_NET_SWITCHDEV=y
# CONFIG_NET_L3_MASTER_DEV is not set
CONFIG_NET_NCSI=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=y
# CONFIG_NET_DROP_MONITOR is not set
CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=y
# CONFIG_AX25_DAMA_SLAVE is not set
CONFIG_NETROM=y
# CONFIG_ROSE is not set

#
# AX.25 network device drivers
#
CONFIG_MKISS=y
CONFIG_6PACK=y
# CONFIG_BPQETHER is not set
CONFIG_SCC=y
CONFIG_SCC_DELAY=y
CONFIG_SCC_TRXECHO=y
CONFIG_BAYCOM_SER_FDX=y
CONFIG_BAYCOM_SER_HDX=y
# CONFIG_YAM is not set
CONFIG_CAN=y
CONFIG_CAN_RAW=y
# CONFIG_CAN_BCM is not set
CONFIG_CAN_GW=y

#
# CAN Device Drivers
#
# CONFIG_CAN_VCAN is not set
CONFIG_CAN_SLCAN=y
CONFIG_CAN_DEV=y
# CONFIG_CAN_CALC_BITTIMING is not set
CONFIG_CAN_LEDS=y
# CONFIG_CAN_GRCAN is not set
# CONFIG_PCH_CAN is not set
CONFIG_CAN_C_CAN=y
CONFIG_CAN_C_CAN_PLATFORM=y
# CONFIG_CAN_C_CAN_PCI is not set
CONFIG_CAN_CC770=y
CONFIG_CAN_CC770_ISA=y
CONFIG_CAN_CC770_PLATFORM=y
CONFIG_CAN_IFI_CANFD=y
CONFIG_CAN_M_CAN=y
CONFIG_CAN_SJA1000=y
CONFIG_CAN_SJA1000_ISA=y
# CONFIG_CAN_SJA1000_PLATFORM is not set
CONFIG_CAN_EMS_PCMCIA=y
# CONFIG_CAN_EMS_PCI is not set
# CONFIG_CAN_PEAK_PCMCIA is not set
# CONFIG_CAN_PEAK_PCI is not set
# CONFIG_CAN_KVASER_PCI is not set
# CONFIG_CAN_PLX_PCI is not set
CONFIG_CAN_TSCAN1=y
# CONFIG_CAN_SOFTING is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_STREAM_PARSER is not set
CONFIG_WIRELESS=y
CONFIG_CFG80211=y
CONFIG_NL80211_TESTMODE=y
CONFIG_CFG80211_DEVELOPER_WARNINGS=y
CONFIG_CFG80211_CERTIFICATION_ONUS=y
# CONFIG_CFG80211_REG_CELLULAR_HINTS is not set
# CONFIG_CFG80211_REG_RELAX_NO_IR is not set
# CONFIG_CFG80211_DEFAULT_PS is not set
# CONFIG_CFG80211_DEBUGFS is not set
# CONFIG_CFG80211_INTERNAL_REGDB is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
# CONFIG_LIB80211 is not set
CONFIG_MAC80211=y
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_MINSTREL_HT=y
CONFIG_MAC80211_RC_MINSTREL_VHT=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
# CONFIG_MAC80211_DEBUGFS is not set
CONFIG_MAC80211_MESSAGE_TRACING=y
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_WIMAX=y
CONFIG_WIMAX_DEBUG_LEVEL=8
CONFIG_RFKILL=y
CONFIG_RFKILL_LEDS=y
# CONFIG_RFKILL_INPUT is not set
CONFIG_RFKILL_GPIO=y
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_NET_9P_RDMA=y
CONFIG_NET_9P_DEBUG=y
CONFIG_CAIF=y
# CONFIG_CAIF_DEBUG is not set
CONFIG_CAIF_NETDEV=y
CONFIG_CAIF_USB=y
CONFIG_CEPH_LIB=y
CONFIG_CEPH_LIB_PRETTYDEBUG=y
# CONFIG_CEPH_LIB_USE_DNS_RESOLVER is not set
CONFIG_NFC=y
CONFIG_NFC_DIGITAL=y
CONFIG_NFC_NCI=y
CONFIG_NFC_NCI_UART=y
# CONFIG_NFC_HCI is not set

#
# Near Field Communication (NFC) devices
#
# CONFIG_NFC_WILINK is not set
CONFIG_NFC_SIM=y
CONFIG_NFC_FDP=y
CONFIG_NFC_FDP_I2C=y
# CONFIG_NFC_PN533_I2C is not set
CONFIG_NFC_MRVL=y
CONFIG_NFC_MRVL_UART=y
# CONFIG_NFC_MRVL_I2C is not set
# CONFIG_NFC_ST_NCI_I2C is not set
# CONFIG_NFC_NXP_NCI is not set
# CONFIG_NFC_S3FWRN5_I2C is not set
CONFIG_PSAMPLE=y
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y

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
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
CONFIG_FW_LOADER=y
CONFIG_FIRMWARE_IN_KERNEL=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
CONFIG_MTD=y
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_OF_PARTS=y
CONFIG_MTD_AR7_PARTS=y

#
# User Modules And Translation Layers
#
CONFIG_MTD_OOPS=y
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
# CONFIG_MTD_CFI_NOSWAP is not set
CONFIG_MTD_CFI_BE_BYTE_SWAP=y
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
CONFIG_MTD_OTP=y
CONFIG_MTD_CFI_INTELEXT=y
# CONFIG_MTD_CFI_AMDSTD is not set
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
# CONFIG_MTD_ROM is not set
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
# CONFIG_MTD_L440GX is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=y

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_SLRAM is not set
CONFIG_MTD_PHRAM=y
CONFIG_MTD_MTDRAM=y
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
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
CONFIG_MTD_NAND_IDS=y
# CONFIG_MTD_NAND_RICOH is not set
CONFIG_MTD_NAND_DISKONCHIP=y
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=y
# CONFIG_MTD_NAND_DOCG4 is not set
# CONFIG_MTD_NAND_CAFE is not set
# CONFIG_MTD_NAND_CS553X is not set
# CONFIG_MTD_NAND_NANDSIM is not set
CONFIG_MTD_NAND_PLATFORM=y
# CONFIG_MTD_NAND_HISI504 is not set
# CONFIG_MTD_NAND_MTK is not set
CONFIG_MTD_ONENAND=y
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
CONFIG_MTD_ONENAND_GENERIC=y
# CONFIG_MTD_ONENAND_OTP is not set
CONFIG_MTD_ONENAND_2X_PROGRAM=y

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
CONFIG_MTD_UBI_FASTMAP=y
CONFIG_MTD_UBI_GLUEBI=y
CONFIG_DTC=y
CONFIG_OF=y
CONFIG_OF_UNITTEST=y
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_ADDRESS_PCI=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_MDIO=y
CONFIG_OF_PCI=y
CONFIG_OF_PCI_IRQ=y
CONFIG_OF_RESOLVE=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set
CONFIG_PNPACPI=y

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
# CONFIG_ISL29003 is not set
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
CONFIG_DS1682=y
# CONFIG_PCH_PHUB is not set
CONFIG_USB_SWITCH_FSA9480=y
# CONFIG_SRAM is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=y
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_IDT_89HPESX=y
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
CONFIG_TI_ST=y
CONFIG_SENSORS_LIS3_I2C=y

#
# Altera FPGA firmware download module
#
# CONFIG_ALTERA_STAPL is not set
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

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
CONFIG_VHOST_RING=y
CONFIG_ECHO=y
# CONFIG_CXL_BASE is not set
# CONFIG_CXL_AFU_DRIVER_OPS is not set
CONFIG_HAVE_IDE=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_SCSI_DMA is not set
# CONFIG_SCSI_NETLINK is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
# CONFIG_NET_CORE is not set
CONFIG_ARCNET=y
CONFIG_ARCNET_1201=y
CONFIG_ARCNET_1051=y
CONFIG_ARCNET_RAW=y
# CONFIG_ARCNET_CAP is not set
# CONFIG_ARCNET_COM90xx is not set
CONFIG_ARCNET_COM90xxIO=y
CONFIG_ARCNET_RIM_I=y
# CONFIG_ARCNET_COM20020 is not set
# CONFIG_ATM_DRIVERS is not set

#
# CAIF transport drivers
#
CONFIG_CAIF_TTY=y
CONFIG_CAIF_SPI_SLAVE=y
# CONFIG_CAIF_SPI_SYNC is not set
CONFIG_CAIF_HSI=y
CONFIG_CAIF_VIRTIO=y

#
# Distributed Switch Architecture drivers
#
# CONFIG_NET_DSA_MV88E6060 is not set
CONFIG_NET_DSA_BCM_SF2=y
CONFIG_B53=y
CONFIG_B53_MDIO_DRIVER=y
CONFIG_B53_MMAP_DRIVER=y
CONFIG_B53_SRAB_DRIVER=y
# CONFIG_NET_DSA_MV88E6XXX is not set
# CONFIG_NET_DSA_QCA8K is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
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
# CONFIG_LANCE is not set
# CONFIG_PCNET32 is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_NI65 is not set
# CONFIG_AMD_XGBE is not set
# CONFIG_AMD_XGBE_HAVE_ECC is not set
CONFIG_NET_VENDOR_AQUANTIA=y
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
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CIRRUS=y
# CONFIG_CS89x0 is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
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
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
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
# CONFIG_I40E is not set
CONFIG_NET_VENDOR_I825XX=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_MVNETA_BM is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX4_CORE is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_8390=y
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2000 is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
# CONFIG_ULTRA is not set
# CONFIG_WD80x3 is not set
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
# CONFIG_QCOM_EMAC is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
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
# CONFIG_SMC9194 is not set
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
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
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
CONFIG_LED_TRIGGER_PHY=y

#
# MDIO bus device drivers
#
CONFIG_MDIO_BCM_UNIMAC=y
CONFIG_MDIO_BITBANG=y
CONFIG_MDIO_BUS_MUX=y
# CONFIG_MDIO_BUS_MUX_GPIO is not set
CONFIG_MDIO_BUS_MUX_MMIOREG=y
CONFIG_MDIO_GPIO=y
CONFIG_MDIO_HISI_FEMAC=y

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=y
CONFIG_AQUANTIA_PHY=y
CONFIG_AT803X_PHY=y
CONFIG_BCM7XXX_PHY=y
CONFIG_BCM87XX_PHY=y
CONFIG_BCM_NET_PHYLIB=y
CONFIG_BROADCOM_PHY=y
CONFIG_CICADA_PHY=y
CONFIG_DAVICOM_PHY=y
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=y
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
CONFIG_LXT_PHY=y
CONFIG_MARVELL_PHY=y
CONFIG_MICREL_PHY=y
CONFIG_MICROCHIP_PHY=y
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_NATIONAL_PHY is not set
CONFIG_QSEMI_PHY=y
# CONFIG_REALTEK_PHY is not set
CONFIG_SMSC_PHY=y
CONFIG_STE10XP=y
CONFIG_TERANETICS_PHY=y
CONFIG_VITESSE_PHY=y
CONFIG_XILINX_GMII2RGMII=y
CONFIG_PPP=y
CONFIG_PPP_BSDCOMP=y
# CONFIG_PPP_DEFLATE is not set
CONFIG_PPP_FILTER=y
# CONFIG_PPP_MPPE is not set
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPPOATM is not set
# CONFIG_PPPOE is not set
CONFIG_PPP_ASYNC=y
# CONFIG_PPP_SYNC_TTY is not set
CONFIG_SLIP=y
CONFIG_SLHC=y
CONFIG_SLIP_COMPRESSED=y
# CONFIG_SLIP_SMART is not set
# CONFIG_SLIP_MODE_SLIP6 is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
# CONFIG_WLAN is not set

#
# WiMAX Wireless Broadband devices
#

#
# Enable USB support to see WiMAX USB drivers
#
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=y
CONFIG_IEEE802154_FAKELB=y
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_ISDN is not set

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
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADC=y
CONFIG_KEYBOARD_ADP5520=y
CONFIG_KEYBOARD_ADP5588=y
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
CONFIG_KEYBOARD_QT2160=y
# CONFIG_KEYBOARD_LKKBD is not set
CONFIG_KEYBOARD_GPIO=y
CONFIG_KEYBOARD_GPIO_POLLED=y
CONFIG_KEYBOARD_TCA6416=y
# CONFIG_KEYBOARD_TCA8418 is not set
CONFIG_KEYBOARD_MATRIX=y
# CONFIG_KEYBOARD_LM8323 is not set
CONFIG_KEYBOARD_LM8333=y
CONFIG_KEYBOARD_MAX7359=y
CONFIG_KEYBOARD_MCS=y
# CONFIG_KEYBOARD_MPR121 is not set
CONFIG_KEYBOARD_NEWTON=y
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
CONFIG_KEYBOARD_GOLDFISH_EVENTS=y
CONFIG_KEYBOARD_STOWAWAY=y
CONFIG_KEYBOARD_SUNKBD=y
# CONFIG_KEYBOARD_OMAP4 is not set
CONFIG_KEYBOARD_TC3589X=y
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_KEYBOARD_CROS_EC=y
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
CONFIG_TOUCHSCREEN_AD7879=y
CONFIG_TOUCHSCREEN_AD7879_I2C=y
CONFIG_TOUCHSCREEN_AR1021_I2C=y
CONFIG_TOUCHSCREEN_ATMEL_MXT=y
CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
CONFIG_TOUCHSCREEN_BU21013=y
CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=y
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
# CONFIG_TOUCHSCREEN_CYTTSP_I2C is not set
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP4_I2C=y
# CONFIG_TOUCHSCREEN_DA9034 is not set
CONFIG_TOUCHSCREEN_DYNAPRO=y
CONFIG_TOUCHSCREEN_HAMPSHIRE=y
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX is not set
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
CONFIG_TOUCHSCREEN_FUJITSU=y
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
CONFIG_TOUCHSCREEN_EKTF2127=y
CONFIG_TOUCHSCREEN_ELAN=y
# CONFIG_TOUCHSCREEN_ELO is not set
CONFIG_TOUCHSCREEN_WACOM_W8001=y
# CONFIG_TOUCHSCREEN_WACOM_I2C is not set
# CONFIG_TOUCHSCREEN_MAX11801 is not set
CONFIG_TOUCHSCREEN_MCS5000=y
CONFIG_TOUCHSCREEN_MMS114=y
CONFIG_TOUCHSCREEN_MELFAS_MIP4=y
CONFIG_TOUCHSCREEN_MTOUCH=y
CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
CONFIG_TOUCHSCREEN_INEXIO=y
CONFIG_TOUCHSCREEN_MK712=y
# CONFIG_TOUCHSCREEN_HTCPEN is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
CONFIG_TOUCHSCREEN_EDT_FT5X06=y
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
CONFIG_TOUCHSCREEN_TOUCHWIN=y
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=y
CONFIG_TOUCHSCREEN_PIXCIR=y
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_MC13783 is not set
CONFIG_TOUCHSCREEN_TOUCHIT213=y
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
CONFIG_TOUCHSCREEN_TSC200X_CORE=y
CONFIG_TOUCHSCREEN_TSC2004=y
CONFIG_TOUCHSCREEN_TSC2007=y
CONFIG_TOUCHSCREEN_RM_TS=y
# CONFIG_TOUCHSCREEN_SILEAD is not set
CONFIG_TOUCHSCREEN_SIS_I2C=y
CONFIG_TOUCHSCREEN_ST1232=y
CONFIG_TOUCHSCREEN_SX8654=y
CONFIG_TOUCHSCREEN_TPS6507X=y
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
CONFIG_TOUCHSCREEN_COLIBRI_VF50=y
CONFIG_TOUCHSCREEN_ROHM_BU21023=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM80X_ONKEY=y
CONFIG_INPUT_AD714X=y
# CONFIG_INPUT_AD714X_I2C is not set
CONFIG_INPUT_ATMEL_CAPTOUCH=y
CONFIG_INPUT_BMA150=y
CONFIG_INPUT_E3X0_BUTTON=y
# CONFIG_INPUT_MAX77693_HAPTIC is not set
CONFIG_INPUT_MAX8925_ONKEY=y
CONFIG_INPUT_MAX8997_HAPTIC=y
# CONFIG_INPUT_MC13783_PWRBUTTON is not set
CONFIG_INPUT_MMA8450=y
CONFIG_INPUT_APANEL=y
# CONFIG_INPUT_GP2A is not set
CONFIG_INPUT_GPIO_BEEPER=y
CONFIG_INPUT_GPIO_TILT_POLLED=y
CONFIG_INPUT_GPIO_DECODER=y
CONFIG_INPUT_WISTRON_BTNS=y
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
CONFIG_INPUT_KXTJ9=y
# CONFIG_INPUT_KXTJ9_POLLED_MODE is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_REGULATOR_HAPTIC=y
CONFIG_INPUT_RETU_PWRBUTTON=y
CONFIG_INPUT_AXP20X_PEK=y
# CONFIG_INPUT_UINPUT is not set
CONFIG_INPUT_PCF50633_PMU=y
CONFIG_INPUT_PCF8574=y
# CONFIG_INPUT_PWM_BEEPER is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
# CONFIG_INPUT_DA9055_ONKEY is not set
# CONFIG_INPUT_DA9063_ONKEY is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_IDEAPAD_SLIDEBAR=y
CONFIG_INPUT_SOC_BUTTON_ARRAY=y
# CONFIG_INPUT_DRV260X_HAPTICS is not set
CONFIG_INPUT_DRV2665_HAPTICS=y
CONFIG_INPUT_DRV2667_HAPTICS=y
CONFIG_RMI4_CORE=y
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
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
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_APBPS2=y
CONFIG_USERIO=y
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
CONFIG_N_GSM=y
CONFIG_TRACE_ROUTER=y
CONFIG_TRACE_SINK=y
CONFIG_GOLDFISH_TTY=y
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
CONFIG_SERIAL_8250_CS=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_FSL is not set
# CONFIG_SERIAL_8250_DW is not set
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
CONFIG_SERIAL_SC16IS7XX=y
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
CONFIG_SERIAL_TIMBERDALE=y
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
# CONFIG_SERIAL_ALTERA_UART_CONSOLE is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
CONFIG_SERIAL_ARC=y
# CONFIG_SERIAL_ARC_CONSOLE is not set
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
# CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE is not set
# CONFIG_SERIAL_MEN_Z135 is not set
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_TTY_PRINTK=y
CONFIG_HVC_DRIVER=y
CONFIG_VIRTIO_CONSOLE=y
# CONFIG_IPMI_HANDLER is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=y
CONFIG_DTLK=y
CONFIG_R3964=y
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=y
CONFIG_CARDMAN_4000=y
CONFIG_CARDMAN_4040=y
CONFIG_SCR24X=y
CONFIG_IPWIRELESS=y
# CONFIG_MWAVE is not set
# CONFIG_PC8736x_GPIO is not set
# CONFIG_NSC_GPIO is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
# CONFIG_TCG_TIS is not set
CONFIG_TCG_TIS_I2C_ATMEL=y
CONFIG_TCG_TIS_I2C_INFINEON=y
CONFIG_TCG_TIS_I2C_NUVOTON=y
# CONFIG_TCG_NSC is not set
# CONFIG_TCG_ATMEL is not set
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
CONFIG_TELCLOCK=y
# CONFIG_DEVPORT is not set
# CONFIG_XILLYBUS is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
CONFIG_I2C_MUX_GPIO=y
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
CONFIG_I2C_CBUS_GPIO=y
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
CONFIG_I2C_KEMPLD=y
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_PXA is not set
# CONFIG_I2C_PXA_PCI is not set
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_PARPORT_LIGHT=y
CONFIG_I2C_TAOS_EVM=y

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_PCA_ISA is not set
CONFIG_I2C_CROS_EC_TUNNEL=y
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set

#
# PPS support
#
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
CONFIG_NTP_PPS=y

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
# CONFIG_PTP_1588_CLOCK is not set
CONFIG_PTP_1588_CLOCK_PCH=y
CONFIG_GPIOLIB=y
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
CONFIG_GPIO_ALTERA=y
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_AXP209 is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_GRGPIO=y
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MENZ127=y
CONFIG_GPIO_MOCKUP=y
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_XILINX=y

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_104_DIO_48E is not set
# CONFIG_GPIO_104_IDIO_16 is not set
# CONFIG_GPIO_104_IDI_48 is not set
CONFIG_GPIO_F7188X=y
# CONFIG_GPIO_GPIO_MM is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WS16C48 is not set

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
# CONFIG_GPIO_ADP5588_IRQ is not set
# CONFIG_GPIO_ADNP is not set
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
CONFIG_GPIO_MAX732X_IRQ=y
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_PCF857X=y
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
# CONFIG_GPIO_ARIZONA is not set
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_KEMPLD=y
CONFIG_GPIO_LP873X=y
CONFIG_GPIO_MAX77620=y
# CONFIG_GPIO_TC3589X is not set
# CONFIG_GPIO_TPS6586X is not set
CONFIG_GPIO_TPS65912=y

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set

#
# SPI or I2C GPIO expanders
#
# CONFIG_GPIO_MCP23S08 is not set
CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_DS1WM=y
# CONFIG_W1_MASTER_GPIO is not set

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=y
CONFIG_W1_SLAVE_DS2408_READBACK=y
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
# CONFIG_W1_SLAVE_DS2760 is not set
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
# CONFIG_W1_SLAVE_BQ27000 is not set
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_GPIO is not set
CONFIG_POWER_RESET_GPIO_RESTART=y
# CONFIG_POWER_RESET_LTC2952 is not set
# CONFIG_POWER_RESET_RESTART is not set
# CONFIG_POWER_RESET_SYSCON is not set
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
CONFIG_GENERIC_ADC_BATTERY=y
# CONFIG_MAX8925_POWER is not set
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_DS2780=y
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
# CONFIG_BATTERY_DA9030 is not set
# CONFIG_BATTERY_DA9150 is not set
CONFIG_AXP288_FUEL_GAUGE=y
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
# CONFIG_CHARGER_PCF50633 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_LP8788 is not set
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_MAX14577=y
CONFIG_CHARGER_DETECTOR_MAX14656=y
# CONFIG_CHARGER_MAX77693 is not set
# CONFIG_CHARGER_MAX8998 is not set
# CONFIG_CHARGER_BQ2415X is not set
CONFIG_CHARGER_BQ24190=y
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
CONFIG_CHARGER_BQ25890=y
# CONFIG_CHARGER_SMB347 is not set
CONFIG_CHARGER_TPS65090=y
CONFIG_BATTERY_GAUGE_LTC2941=y
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
CONFIG_CHARGER_RT9455=y
CONFIG_AXP20X_POWER=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ABITUGURU3 is not set
CONFIG_SENSORS_AD7414=y
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM9240=y
# CONFIG_SENSORS_ADT7410 is not set
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_ASC7621=y
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_DA9055 is not set
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_MC13783_ADC=y
# CONFIG_SENSORS_FSCHMD is not set
CONFIG_SENSORS_FTSTEUTATES=y
CONFIG_SENSORS_GL518SM=y
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_GPIO_FAN=y
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IIO_HWMON=y
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=y
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC4151=y
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX6639=y
CONFIG_SENSORS_MAX6642=y
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=y
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_MENF21BMC_HWMON is not set
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM73=y
# CONFIG_SENSORS_LM75 is not set
CONFIG_SENSORS_LM77=y
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=y
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=y
# CONFIG_SENSORS_LM92 is not set
CONFIG_SENSORS_LM93=y
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NTC_THERMISTOR is not set
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT7802=y
CONFIG_SENSORS_NCT7904=y
CONFIG_SENSORS_PCF8591=y
# CONFIG_PMBUS is not set
CONFIG_SENSORS_PWM_FAN=y
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=y
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=y
# CONFIG_SENSORS_EMC1403 is not set
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=y
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
CONFIG_SENSORS_SCH5636=y
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS1015=y
# CONFIG_SENSORS_ADS7828 is not set
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
# CONFIG_SENSORS_VIA_CPUTEMP is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_HWMON is not set
# CONFIG_THERMAL_OF is not set
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR=y
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
CONFIG_THERMAL_EMULATION=y
CONFIG_MAX77620_THERMAL=y
CONFIG_INTEL_POWERCLAMP=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
# CONFIG_SOFT_WATCHDOG_PRETIMEOUT is not set
# CONFIG_DA9055_WATCHDOG is not set
CONFIG_DA9063_WATCHDOG=y
CONFIG_DA9062_WATCHDOG=y
CONFIG_GPIO_WATCHDOG=y
# CONFIG_GPIO_WATCHDOG_ARCH_INITCALL is not set
# CONFIG_MENF21BMC_WATCHDOG is not set
# CONFIG_WDAT_WDT is not set
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
CONFIG_DW_WATCHDOG=y
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_MAX77620_WATCHDOG is not set
CONFIG_RETU_WATCHDOG=y
CONFIG_ACQUIRE_WDT=y
CONFIG_ADVANTECH_WDT=y
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=y
# CONFIG_SP5100_TCO is not set
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
CONFIG_IBMASR=y
CONFIG_WAFER_WDT=y
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=y
# CONFIG_IT87_WDT is not set
# CONFIG_HP_WATCHDOG is not set
CONFIG_KEMPLD_WDT=y
CONFIG_SC1200_WDT=y
CONFIG_PC87413_WDT=y
# CONFIG_NV_TCO is not set
# CONFIG_60XX_WDT is not set
CONFIG_SBC8360_WDT=y
# CONFIG_SBC7240_WDT is not set
CONFIG_CPU5_WDT=y
# CONFIG_SMSC_SCH311X_WDT is not set
CONFIG_SMSC37B787_WDT=y
# CONFIG_VIA_WDT is not set
CONFIG_W83627HF_WDT=y
# CONFIG_W83877F_WDT is not set
CONFIG_W83977F_WDT=y
CONFIG_MACHZ_WDT=y
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
CONFIG_MEN_A21_WDT=y

#
# ISA-based Watchdog Cards
#
# CONFIG_PCWATCHDOG is not set
CONFIG_MIXCOMWD=y
# CONFIG_WDT is not set

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
# CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC is not set
CONFIG_SSB_POSSIBLE=y

#
# Sonics Silicon Backplane
#
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
# CONFIG_SSB_B43_PCI_BRIDGE is not set
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
CONFIG_SSB_PCMCIAHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
# CONFIG_SSB_SILENT is not set
CONFIG_SSB_DEBUG=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y

#
# Broadcom specific AMBA
#
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
# CONFIG_MFD_ACT8945A is not set
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_AS3722 is not set
CONFIG_PMIC_ADP5520=y
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_ATMEL_FLEXCOM=y
# CONFIG_MFD_ATMEL_HLCDC is not set
# CONFIG_MFD_BCM590XX is not set
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_CROS_EC=y
# CONFIG_MFD_CROS_EC_I2C is not set
CONFIG_PMIC_DA903X=y
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_MFD_HI6421_PMIC is not set
# CONFIG_HTC_PASIC3 is not set
CONFIG_HTC_I2CPLD=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77620=y
CONFIG_MFD_MAX77686=y
CONFIG_MFD_MAX77693=y
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=y
CONFIG_MFD_MAX8925=y
CONFIG_MFD_MAX8997=y
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
CONFIG_PCF50633_GPIO=y
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RTSX_PCI is not set
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_RK808 is not set
# CONFIG_MFD_RN5T618 is not set
CONFIG_MFD_SEC_CORE=y
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
CONFIG_AB3100_OTP=y
# CONFIG_MFD_STMPE is not set
# CONFIG_MFD_SYSCON is not set
CONFIG_MFD_TI_AM335X_TSCADC=y
# CONFIG_MFD_LP3943 is not set
CONFIG_MFD_LP8788=y
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
# CONFIG_MFD_TPS65086 is not set
CONFIG_MFD_TPS65090=y
# CONFIG_MFD_TPS65217 is not set
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TPS65218 is not set
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TIMBERDALE is not set
CONFIG_MFD_TC3589X=y
# CONFIG_MFD_TMIO is not set
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
CONFIG_MFD_CS47L24=y
# CONFIG_MFD_WM5102 is not set
# CONFIG_MFD_WM5110 is not set
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8400=y
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
# CONFIG_REGULATOR_88PM800 is not set
CONFIG_REGULATOR_ACT8865=y
# CONFIG_REGULATOR_AD5398 is not set
# CONFIG_REGULATOR_AB3100 is not set
CONFIG_REGULATOR_AXP20X=y
CONFIG_REGULATOR_DA903X=y
CONFIG_REGULATOR_DA9055=y
# CONFIG_REGULATOR_DA9062 is not set
# CONFIG_REGULATOR_DA9063 is not set
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_GPIO=y
# CONFIG_REGULATOR_ISL9305 is not set
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
# CONFIG_REGULATOR_LP872X is not set
CONFIG_REGULATOR_LP873X=y
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LP8788=y
CONFIG_REGULATOR_LTC3589=y
# CONFIG_REGULATOR_LTC3676 is not set
CONFIG_REGULATOR_MAX14577=y
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX77620=y
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8907=y
CONFIG_REGULATOR_MAX8925=y
CONFIG_REGULATOR_MAX8952=y
# CONFIG_REGULATOR_MAX8997 is not set
CONFIG_REGULATOR_MAX8998=y
# CONFIG_REGULATOR_MAX77686 is not set
CONFIG_REGULATOR_MAX77693=y
# CONFIG_REGULATOR_MAX77802 is not set
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
# CONFIG_REGULATOR_MC13892 is not set
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_MT6323=y
CONFIG_REGULATOR_MT6397=y
# CONFIG_REGULATOR_PCF50633 is not set
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_PWM=y
CONFIG_REGULATOR_RT5033=y
CONFIG_REGULATOR_S2MPA01=y
CONFIG_REGULATOR_S2MPS11=y
CONFIG_REGULATOR_S5M8767=y
# CONFIG_REGULATOR_SKY81452 is not set
# CONFIG_REGULATOR_TPS51632 is not set
CONFIG_REGULATOR_TPS6105X=y
# CONFIG_REGULATOR_TPS62360 is not set
# CONFIG_REGULATOR_TPS65023 is not set
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65090=y
CONFIG_REGULATOR_TPS6586X=y
CONFIG_REGULATOR_TPS65912=y
CONFIG_REGULATOR_WM8400=y
# CONFIG_MEDIA_SUPPORT is not set

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
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_VM=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
CONFIG_DRM_I2C_SIL164=y
CONFIG_DRM_I2C_NXP_TDA998X=y
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_BOCHS is not set
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_SIMPLE=y
CONFIG_DRM_PANEL_JDI_LT070ME05000=y
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=y
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=y
# CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set
CONFIG_DRM_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
CONFIG_DRM_DUMB_VGA_DAC=y
CONFIG_DRM_NXP_PTN3460=y
CONFIG_DRM_PARADE_PS8622=y
# CONFIG_DRM_SIL_SII8620 is not set
# CONFIG_DRM_SII902X is not set
# CONFIG_DRM_TOSHIBA_TC358767 is not set
CONFIG_DRM_TI_TFP410=y
CONFIG_DRM_I2C_ADV7511=y
# CONFIG_DRM_I2C_ADV7533 is not set
# CONFIG_DRM_ARCPGU is not set
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_MXSFB is not set
CONFIG_DRM_TINYDRM=y
CONFIG_DRM_LEGACY=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
# CONFIG_DRM_LIB_RANDOM is not set

#
# Frame buffer Devices
#
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
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
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_SVGALIB is not set
# CONFIG_FB_MACMODES is not set
CONFIG_FB_BACKLIGHT=y
# CONFIG_FB_MODE_HELPERS is not set
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
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
CONFIG_FB_OPENCORES=y
CONFIG_FB_S1D13XXX=y
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
CONFIG_FB_SM501=y
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_GOLDFISH=y
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_BROADSHEET=y
CONFIG_FB_AUO_K190X=y
# CONFIG_FB_AUO_K1900 is not set
CONFIG_FB_AUO_K1901=y
# CONFIG_FB_SIMPLE is not set
CONFIG_FB_SSD1307=y
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
CONFIG_BACKLIGHT_LM3533=y
# CONFIG_BACKLIGHT_PWM is not set
# CONFIG_BACKLIGHT_DA903X is not set
CONFIG_BACKLIGHT_MAX8925=y
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_PM8941_WLED=y
CONFIG_BACKLIGHT_SAHARA=y
# CONFIG_BACKLIGHT_ADP5520 is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_PCF50633=y
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=y
CONFIG_BACKLIGHT_LP8788=y
CONFIG_BACKLIGHT_SKY81452=y
CONFIG_BACKLIGHT_GPIO=y
# CONFIG_BACKLIGHT_LV5207LP is not set
CONFIG_BACKLIGHT_BD6107=y
# CONFIG_VGASTATE is not set
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_SOUND=y
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_RAWMIDI=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
# CONFIG_SND_PCM_OSS is not set
# CONFIG_SND_PCM_TIMER is not set
CONFIG_SND_HRTIMER=y
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
# CONFIG_SND_PROC_FS is not set
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_VERBOSE=y
CONFIG_SND_DMA_SGBUF=y
# CONFIG_SND_RAWMIDI_SEQ is not set
# CONFIG_SND_OPL3_LIB_SEQ is not set
# CONFIG_SND_OPL4_LIB_SEQ is not set
# CONFIG_SND_SBAWE_SEQ is not set
# CONFIG_SND_EMU10K1_SEQ is not set
CONFIG_SND_MPU401_UART=y
CONFIG_SND_OPL3_LIB=y
CONFIG_SND_OPL4_LIB=y
CONFIG_SND_VX_LIB=y
CONFIG_SND_DRIVERS=y
# CONFIG_SND_DUMMY is not set
CONFIG_SND_ALOOP=y
CONFIG_SND_MTPAV=y
CONFIG_SND_SERIAL_U16550=y
CONFIG_SND_MPU401=y
CONFIG_SND_WSS_LIB=y
CONFIG_SND_SB_COMMON=y
CONFIG_SND_SB8_DSP=y
CONFIG_SND_SB16_DSP=y
CONFIG_SND_ISA=y
CONFIG_SND_ADLIB=y
# CONFIG_SND_AD1816A is not set
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_ALS100 is not set
CONFIG_SND_AZT1605=y
CONFIG_SND_AZT2316=y
# CONFIG_SND_AZT2320 is not set
CONFIG_SND_CMI8328=y
# CONFIG_SND_CMI8330 is not set
CONFIG_SND_CS4231=y
# CONFIG_SND_CS4236 is not set
CONFIG_SND_ES1688=y
# CONFIG_SND_ES18XX is not set
CONFIG_SND_SC6000=y
CONFIG_SND_GUSCLASSIC=y
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
CONFIG_SND_JAZZ16=y
# CONFIG_SND_OPL3SA2 is not set
CONFIG_SND_OPTI92X_AD1848=y
CONFIG_SND_OPTI92X_CS4231=y
CONFIG_SND_OPTI93X=y
CONFIG_SND_MIRO=y
CONFIG_SND_SB8=y
# CONFIG_SND_SB16 is not set
CONFIG_SND_SBAWE=y
CONFIG_SND_SB16_CSP=y
CONFIG_SND_SSCAPE=y
# CONFIG_SND_WAVEFRONT is not set
CONFIG_SND_MSND_PINNACLE=y
CONFIG_SND_MSND_CLASSIC=y
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ASIHPI is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5530 is not set
# CONFIG_SND_CS5535AUDIO is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SE6X is not set
# CONFIG_SND_SIS7019 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
# CONFIG_SND_HDA_INTEL is not set
CONFIG_SND_HDA_PREALLOC_SIZE=64
CONFIG_SND_PCMCIA=y
CONFIG_SND_VXPOCKET=y
CONFIG_SND_PDAUDIOCF=y
# CONFIG_SND_SOC is not set
# CONFIG_SND_X86 is not set
# CONFIG_SOUND_PRIME is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
CONFIG_UHID=y
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
CONFIG_HID_ASUS=y
CONFIG_HID_AUREAL=y
CONFIG_HID_BELKIN=y
# CONFIG_HID_CHERRY is not set
CONFIG_HID_CHICONY=y
# CONFIG_HID_PRODIKEYS is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELECOM=y
CONFIG_HID_EZKEY=y
CONFIG_HID_GEMBIRD=y
# CONFIG_HID_GFRM is not set
CONFIG_HID_KEYTOUCH=y
CONFIG_HID_KYE=y
CONFIG_HID_WALTOP=y
# CONFIG_HID_GYRATION is not set
CONFIG_HID_ICADE=y
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
CONFIG_HID_LOGITECH=y
# CONFIG_HID_LOGITECH_DJ is not set
# CONFIG_HID_LOGITECH_HIDPP is not set
CONFIG_LOGITECH_FF=y
CONFIG_LOGIRUMBLEPAD2_FF=y
CONFIG_LOGIG940_FF=y
CONFIG_LOGIWHEELS_FF=y
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_MICROSOFT=y
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
CONFIG_HID_ORTEK=y
# CONFIG_HID_PANTHERLORD is not set
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
# CONFIG_HID_PICOLCD_FB is not set
# CONFIG_HID_PICOLCD_BACKLIGHT is not set
# CONFIG_HID_PICOLCD_LEDS is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_SAITEK=y
CONFIG_HID_SAMSUNG=y
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=y
CONFIG_SMARTJOYPLUS_FF=y
CONFIG_HID_TIVO=y
# CONFIG_HID_TOPSEED is not set
CONFIG_HID_THINGM=y
# CONFIG_HID_THRUSTMASTER is not set
CONFIG_HID_UDRAW_PS3=y
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=y
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
CONFIG_HID_SENSOR_HUB=y
# CONFIG_HID_SENSOR_CUSTOM_SENSOR is not set
# CONFIG_HID_ALPS is not set

#
# I2C HID support
#
CONFIG_I2C_HID=y
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_USB_PHY is not set
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
# CONFIG_USB_GADGET is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=y
# CONFIG_UWB_WHCI is not set
CONFIG_MMC=y
# CONFIG_MMC_DEBUG is not set
# CONFIG_PWRSEQ_EMMC is not set
CONFIG_PWRSEQ_SIMPLE=y
CONFIG_SDIO_UART=y
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_SDHCI=y
# CONFIG_MMC_SDHCI_PCI is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=y
# CONFIG_MMC_SDHCI_OF_ARASAN is not set
CONFIG_MMC_SDHCI_OF_AT91=y
CONFIG_MMC_SDHCI_CADENCE=y
CONFIG_MMC_SDHCI_F_SDH30=y
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
CONFIG_MMC_GOLDFISH=y
# CONFIG_MMC_SDRICOH_CS is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_BCM6328=y
# CONFIG_LEDS_BCM6358 is not set
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3533=y
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
# CONFIG_LEDS_LP3944 is not set
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
# CONFIG_LEDS_LP5523 is not set
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
CONFIG_LEDS_LP8788=y
CONFIG_LEDS_LP8860=y
# CONFIG_LEDS_CLEVO_MAIL is not set
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA963X=y
# CONFIG_LEDS_DA903X is not set
# CONFIG_LEDS_PWM is not set
CONFIG_LEDS_REGULATOR=y
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_ADP5520=y
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
# CONFIG_LEDS_MAX8997 is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_OT200 is not set
CONFIG_LEDS_MENF21BMC=y
CONFIG_LEDS_IS31FL319X=y
# CONFIG_LEDS_IS31FL32XX is not set

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
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_GPIO=y
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
CONFIG_LEDS_TRIGGER_CAMERA=y
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=y
CONFIG_INFINIBAND_USER_MAD=y
CONFIG_INFINIBAND_USER_ACCESS=y
CONFIG_INFINIBAND_USER_MEM=y
# CONFIG_INFINIBAND_ON_DEMAND_PAGING is not set
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_NES is not set
# CONFIG_INFINIBAND_OCRDMA is not set
CONFIG_INFINIBAND_IPOIB=y
# CONFIG_INFINIBAND_IPOIB_CM is not set
CONFIG_INFINIBAND_IPOIB_DEBUG=y
CONFIG_INFINIBAND_IPOIB_DEBUG_DATA=y
# CONFIG_RDMA_RXE is not set
# CONFIG_INFINIBAND_BNXT_RE is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_AUXDISPLAY is not set
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
# CONFIG_UIO_PDRV_GENIRQ is not set
# CONFIG_UIO_DMEM_GENIRQ is not set
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_VIRT_DRIVERS=y
CONFIG_VIRTIO=y

#
# Virtio drivers
#
# CONFIG_VIRTIO_PCI is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=y
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# CONFIG_STAGING is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_BUS=y
CONFIG_GOLDFISH_PIPE=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=y
CONFIG_CHROMEOS_PSTORE=y
CONFIG_CROS_EC_CHARDEV=y
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_MAX77686 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI514 is not set
# CONFIG_COMMON_CLK_SI570 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CDCE925 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_S2MPS11 is not set
# CONFIG_COMMON_CLK_NXP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_PXA is not set
# CONFIG_COMMON_CLK_PIC32 is not set
# CONFIG_COMMON_CLK_VC5 is not set

#
# Hardware Spinlock drivers
#

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# CONFIG_ATMEL_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=y
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=y
CONFIG_MAILBOX_TEST=y
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y

#
# Rpmsg drivers
#

#
# SOC (System On Chip) specific Drivers
#

#
# Broadcom SoC drivers
#
# CONFIG_SUNXI_SRAM is not set
# CONFIG_SOC_TI is not set
# CONFIG_SOC_ZTE is not set
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
CONFIG_EXTCON_ADC_JACK=y
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX14577=y
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_MAX77693 is not set
# CONFIG_EXTCON_MAX8997 is not set
# CONFIG_EXTCON_QCOM_SPMI_MISC is not set
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
# CONFIG_IIO_BUFFER_CB is not set
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
CONFIG_IIO_SW_TRIGGER=y

#
# Accelerometers
#
# CONFIG_BMA180 is not set
# CONFIG_BMC150_ACCEL is not set
CONFIG_DA280=y
CONFIG_DA311=y
CONFIG_DMARD06=y
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
CONFIG_HID_SENSOR_ACCEL_3D=y
CONFIG_KXSD9=y
CONFIG_KXSD9_I2C=y
# CONFIG_KXCJK1013 is not set
CONFIG_MC3230=y
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7660 is not set
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
# CONFIG_MMA9553 is not set
CONFIG_MXC4005=y
CONFIG_MXC6255=y
CONFIG_STK8312=y
CONFIG_STK8BA50=y

#
# Analog to digital converters
#
CONFIG_AD7291=y
CONFIG_AD799X=y
CONFIG_AXP288_ADC=y
# CONFIG_CC10001_ADC is not set
# CONFIG_DA9150_GPADC is not set
CONFIG_ENVELOPE_DETECTOR=y
CONFIG_HX711=y
CONFIG_LP8788_ADC=y
CONFIG_LTC2485=y
CONFIG_MAX1363=y
# CONFIG_MCP3422 is not set
# CONFIG_MEN_Z188_ADC is not set
# CONFIG_NAU7802 is not set
# CONFIG_STX104 is not set
CONFIG_TI_ADC081C=y
# CONFIG_TI_AM335X_ADC is not set
CONFIG_VF610_ADC=y

#
# Amplifiers
#

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
# CONFIG_IAQCORE is not set
CONFIG_VZ89X=y
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
CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Counters
#
# CONFIG_104_QUAD_8 is not set

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5380 is not set
CONFIG_AD5446=y
# CONFIG_AD5593R is not set
# CONFIG_CIO_DAC is not set
# CONFIG_DPOT_DAC is not set
# CONFIG_M62332 is not set
CONFIG_MAX517=y
CONFIG_MAX5821=y
# CONFIG_MCP4725 is not set
CONFIG_VF610_DAC=y

#
# IIO dummy driver
#

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#

#
# Phase-Locked Loop (PLL) frequency synthesizers
#

#
# Digital gyroscope sensors
#
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
CONFIG_HID_SENSOR_GYRO_3D=y
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
CONFIG_IIO_ST_GYRO_3AXIS=y
CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
# CONFIG_ITG3200 is not set

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4404=y
CONFIG_MAX30100=y

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
CONFIG_DHT11=y
CONFIG_HDC100X=y
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
CONFIG_HTU21=y
CONFIG_SI7005=y
CONFIG_SI7020=y

#
# Inertial measurement units
#
# CONFIG_BMI160_I2C is not set
CONFIG_KMX61=y
# CONFIG_INV_MPU6050_I2C is not set
# CONFIG_IIO_ST_LSM6DSX is not set

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=y
CONFIG_AL3320A=y
# CONFIG_APDS9300 is not set
CONFIG_APDS9960=y
CONFIG_BH1750=y
# CONFIG_BH1780 is not set
# CONFIG_CM32181 is not set
CONFIG_CM3232=y
CONFIG_CM3323=y
CONFIG_CM3605=y
CONFIG_CM36651=y
CONFIG_GP2AP020A00F=y
CONFIG_SENSORS_ISL29018=y
CONFIG_ISL29125=y
CONFIG_HID_SENSOR_ALS=y
CONFIG_HID_SENSOR_PROX=y
CONFIG_JSA1212=y
CONFIG_RPR0521=y
# CONFIG_SENSORS_LM3533 is not set
CONFIG_LTR501=y
CONFIG_MAX44000=y
CONFIG_OPT3001=y
# CONFIG_PA12203001 is not set
# CONFIG_SI1145 is not set
CONFIG_STK3310=y
# CONFIG_TCS3414 is not set
CONFIG_TCS3472=y
CONFIG_SENSORS_TSL2563=y
CONFIG_TSL2583=y
CONFIG_TSL4531=y
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
CONFIG_VEML6070=y

#
# Magnetometer sensors
#
CONFIG_AK8974=y
CONFIG_AK8975=y
# CONFIG_AK09911 is not set
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
# CONFIG_MAG3110 is not set
CONFIG_HID_SENSOR_MAGNETOMETER_3D=y
CONFIG_MMC35240=y
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=y
CONFIG_HID_SENSOR_DEVICE_ROTATION=y

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=y
CONFIG_IIO_INTERRUPT_TRIGGER=y
CONFIG_IIO_TIGHTLOOP_TRIGGER=y
CONFIG_IIO_SYSFS_TRIGGER=y

#
# Digital potentiometers
#
# CONFIG_DS1803 is not set
CONFIG_MCP4531=y
CONFIG_TPL0102=y

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set

#
# Pressure sensors
#
CONFIG_ABP060MG=y
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
# CONFIG_IIO_CROS_EC_BARO is not set
CONFIG_HID_SENSOR_PRESS=y
CONFIG_HP03=y
# CONFIG_MPL115_I2C is not set
CONFIG_MPL3115=y
# CONFIG_MS5611 is not set
CONFIG_MS5637=y
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=y
# CONFIG_T5403 is not set
CONFIG_HP206C=y
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y

#
# Lightning sensors
#

#
# Proximity and distance sensors
#
# CONFIG_LIDAR_LITE_V2 is not set
CONFIG_SX9500=y
CONFIG_SRF08=y

#
# Temperature sensors
#
CONFIG_MLX90614=y
CONFIG_TMP006=y
# CONFIG_TMP007 is not set
CONFIG_TSYS01=y
# CONFIG_TSYS02D is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_CROS_EC=y
CONFIG_PWM_FSL_FTM=y
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=y
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set
CONFIG_FMC=y
CONFIG_FMC_FAKEDEV=y
CONFIG_FMC_TRIVIAL=y
# CONFIG_FMC_WRITE_EEPROM is not set
# CONFIG_FMC_CHARDEV is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_PHY_PXA_28NM_HSIC is not set
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_BCM_KONA_USB2_PHY=y
# CONFIG_POWERCAP is not set
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
# CONFIG_ANDROID is not set
CONFIG_DEV_DAX=y
CONFIG_NR_DEV_DAX=32768
CONFIG_NVMEM=y
# CONFIG_STM is not set
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_GTH is not set
CONFIG_INTEL_TH_MSU=y
CONFIG_INTEL_TH_PTI=y
# CONFIG_INTEL_TH_DEBUG is not set

#
# FPGA Configuration Support
#
# CONFIG_FPGA is not set

#
# FSI support
#
# CONFIG_FSI is not set

#
# Firmware Drivers
#
CONFIG_EDD=y
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DELL_RBU=y
CONFIG_DCDBAS=y
CONFIG_DMIID=y
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
# CONFIG_FW_CFG_SYSFS is not set
CONFIG_GOOGLE_FIRMWARE=y

#
# Google Firmware Drivers
#
# CONFIG_GOOGLE_MEMCONSOLE is not set
# CONFIG_EFI_DEV_PATH_PARSER is not set

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_QUOTACTL is not set
# CONFIG_AUTOFS4_FS is not set
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
CONFIG_OVERLAY_FS=y
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set

#
# Caches
#
CONFIG_FSCACHE=y
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_FSCACHE_OBJECT_LIST=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_VMCORE=y
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
CONFIG_CONFIGFS_FS=y
# CONFIG_MISC_FILESYSTEMS is not set
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
CONFIG_SUNRPC_XPRT_RDMA=y
CONFIG_CEPH_FS=y
CONFIG_CEPH_FSCACHE=y
# CONFIG_CEPH_FS_POSIX_ACL is not set
CONFIG_CIFS=y
# CONFIG_CIFS_STATS is not set
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
CONFIG_CIFS_DEBUG2=y
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SMB2 is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_NCP_FS is not set
CONFIG_CODA_FS=y
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=y
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=y
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
CONFIG_DYNAMIC_DEBUG=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_DWARF4=y
CONFIG_GDB_SCRIPTS=y
CONFIG_ENABLE_WARN_DEPRECATED=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=1024
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_READABLE_ASM=y
CONFIG_UNUSED_SYMBOLS=y
CONFIG_PAGE_OWNER=y
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
CONFIG_ARCH_WANT_FRAME_POINTERS=y
CONFIG_FRAME_POINTER=y
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
# CONFIG_PAGE_POISONING_NO_SANITY is not set
CONFIG_PAGE_POISONING_ZERO=y
CONFIG_DEBUG_PAGE_REF=y
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
CONFIG_DEBUG_OBJECTS_FREE=y
CONFIG_DEBUG_OBJECTS_TIMERS=y
# CONFIG_DEBUG_OBJECTS_WORK is not set
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_DEBUG_SLAB is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
# CONFIG_DEBUG_VM_RB is not set
# CONFIG_DEBUG_VM_PGFLAGS is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_DEBUG_HIGHMEM=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_HAVE_ARCH_KMEMCHECK=y
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
# CONFIG_LOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=1
# CONFIG_WQ_WATCHDOG is not set
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
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
CONFIG_DEBUG_LOCK_ALLOC=y
# CONFIG_PROVE_LOCKING is not set
CONFIG_LOCKDEP=y
CONFIG_LOCK_STAT=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=y
CONFIG_WW_MUTEX_SELFTEST=y
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_KOBJECT_RELEASE is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_LIST is not set
CONFIG_DEBUG_PI_LIST=y
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_PROVE_RCU is not set
# CONFIG_SPARSE_RCU_POINTER is not set
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=y
# CONFIG_RCU_TORTURE_TEST_SLOW_PREINIT is not set
# CONFIG_RCU_TORTURE_TEST_SLOW_INIT is not set
# CONFIG_RCU_TORTURE_TEST_SLOW_CLEANUP is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAIL_MMC_REQUEST=y
CONFIG_FAIL_FUTEX=y
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
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
CONFIG_IRQSOFF_TRACER=y
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
CONFIG_PROFILE_ANNOTATED_BRANCHES=y
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_TRACING_BRANCHES=y
CONFIG_BRANCH_TRACER=y
CONFIG_STACK_TRACER=y
# CONFIG_UPROBE_EVENT is not set
# CONFIG_PROBE_EVENTS is not set
# CONFIG_DYNAMIC_FTRACE is not set
# CONFIG_FUNCTION_PROFILER is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
CONFIG_TRACEPOINT_BENCHMARK=y
CONFIG_RING_BUFFER_BENCHMARK=y
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_TRACE_ENUM_MAP_FILE is not set
CONFIG_TRACING_EVENTS_GPIO=y

#
# Runtime Testing
#
# CONFIG_TEST_LIST_SORT is not set
CONFIG_TEST_SORT=y
# CONFIG_BACKTRACE_SELF_TEST is not set
CONFIG_RBTREE_TEST=y
CONFIG_ATOMIC64_SELFTEST=y
CONFIG_TEST_HEXDUMP=y
CONFIG_TEST_STRING_HELPERS=y
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=y
CONFIG_TEST_BITMAP=y
CONFIG_TEST_UUID=y
# CONFIG_TEST_RHASHTABLE is not set
CONFIG_TEST_HASH=y
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
CONFIG_TEST_FIRMWARE=y
CONFIG_TEST_UDELAY=y
CONFIG_MEMTEST=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
CONFIG_UBSAN=y
# CONFIG_UBSAN_SANITIZE_ALL is not set
# CONFIG_UBSAN_ALIGNMENT is not set
# CONFIG_UBSAN_NULL is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=y
CONFIG_DEBUG_WX=y
# CONFIG_DOUBLEFAULT is not set
CONFIG_DEBUG_TLBFLUSH=y
# CONFIG_IOMMU_STRESS is not set
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
CONFIG_DEBUG_NMI_SELFTEST=y
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_BIG_KEYS is not set
CONFIG_TRUSTED_KEYS=y
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HAVE_ARCH_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_PAGESPAN=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE=1
# CONFIG_SECURITY_APPARMOR_HASH is not set
CONFIG_SECURITY_APPARMOR_DEBUG=y
CONFIG_SECURITY_APPARMOR_DEBUG_ASSERTS=y
CONFIG_SECURITY_APPARMOR_DEBUG_MESSAGES=y
CONFIG_SECURITY_YAMA=y
# CONFIG_INTEGRITY is not set
CONFIG_DEFAULT_SECURITY_APPARMOR=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_DEFAULT_SECURITY="apparmor"
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
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
# CONFIG_CRYPTO_DH is not set
# CONFIG_CRYPTO_ECDH is not set
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=y
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
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set

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
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_RMD128 is not set
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_TGR192=y
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_586=y
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_SALSA20_586=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_LZO is not set
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
# CONFIG_CRYPTO_USER_API_HASH is not set
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_KVM is not set
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_BITREVERSE=y
# CONFIG_HAVE_ARCH_BITREVERSE is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_IO=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_AUDIT_GENERIC=y
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
# CONFIG_XZ_DEC_BCJ is not set
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
# CONFIG_DMA_NOOP_OPS is not set
# CONFIG_DMA_VIRT_OPS is not set
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_CORDIC is not set
# CONFIG_DDR is not set
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
# CONFIG_SG_SPLIT is not set
# CONFIG_SG_POOL is not set
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_MMIO_FLUSH=y
CONFIG_STACKDEPOT=y

--ktpplqomzai76t5t--
