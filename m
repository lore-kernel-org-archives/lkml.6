Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x225TV1Wr6oAUJgOI4R4XHobdz3DMvZeP5KJo7sufhCE9jagr1wqC2LtZUzxfM58ILfjV6Ot4
ARC-Seal: i=1; a=rsa-sha256; t=1518323621; cv=none;
        d=google.com; s=arc-20160816;
        b=SJ9gMJbmjAFGCho3zwoS/g3tgB7ygNJxEMVPY6t7Imj43SS+NlukZwYCCh3INPzOvz
         SsVpayCVQAUNg0Ve7R8j/c0wg66FRaMLh2u3Epa7NsGMSOV9nI5kOnliE684rWovxHKa
         J01M4vP8jxt9LtN2pg+MhychgaL3RB9BHR6Lrk/Lkk/XK+5Y9ZEIzqbuyA4mpyksMPU0
         5ZG9+MNBoJVf58eX6V7ZOA7SrBQvQdS61KL3k89g0wSgqWXwdVqf93Wk0ybIOJhXjDr4
         X2LOmemXp42NFCfJOYl4xEEQClO/lF5rv0oDc8pkaoWgpwGqpODoNDm89PSV1Qgp0Ism
         eZJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=gghBxDEHumiC1o6wR8V+iXXw8sH1zaeJmzPj1JJsM/o=;
        b=w7hUy57nYgW/oziJvv6p0+MmgijUaecJ55YnVMSqXY1LU/QE2p+aPEj3jrPz/E5PAK
         SSNmyvEdO9tiypiNEEuxDIaSPAkOXC4QdNU+2yKHnTuE7fkzGnBj4Q1JtCmHVAlYcpon
         Py4MjHc26Yi7fSA1VxHU0IEEcD/VwE8owGRfZneiS2hNINdCIjKuAK1C/Qln8tfwW05i
         XAG50FKmr8X+QAFcNwuzNNQOsv2tU0xRQtta6gb4De3cAu6Lrwk9czABX0LIIAW552YO
         e7OuupwzvjRWzdUipZfh9G1AaNbQ+TeyIF17/0EWQJpTr6KJDaxEwQ2M/BjfkHASBace
         QVHg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "lepton" <ytht.net@gmail.com>,
 "Guenter Roeck" <groeck@chromium.org>,
 "Juerg Haefliger" <juerg.haefliger@canonical.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.919963601@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 78/79] kaiser: Set _PAGE_NX only if supported
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592077709129408782?=
X-GMAIL-MSGID: =?utf-8?q?1592077709239445759?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <groeck@chromium.org>

This resolves a crash if loaded under qemu + haxm under windows.
See https://www.spinics.net/lists/kernel/msg2689835.html for details.
Here is a boot log (the log is from chromeos-4.4, but Tao Wu says that
the same log is also seen with vanilla v4.4.110-rc1).

[    0.712750] Freeing unused kernel memory: 552K
[    0.721821] init: Corrupted page table at address 57b029b332e0
[    0.722761] PGD 80000000bb238067 PUD bc36a067 PMD bc369067 PTE 45d2067
[    0.722761] Bad pagetable: 000b [#1] PREEMPT SMP
[    0.722761] Modules linked in:
[    0.722761] CPU: 1 PID: 1 Comm: init Not tainted 4.4.96 #31
[    0.722761] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.7.5.1-0-g8936dbb-20141113_115728-nilsson.home.kraxel.org 04/01/2014
[    0.722761] task: ffff8800bc290000 ti: ffff8800bc28c000 task.ti: ffff8800bc28c000
[    0.722761] RIP: 0010:[<ffffffff83f4129e>]  [<ffffffff83f4129e>] __clear_user+0x42/0x67
[    0.722761] RSP: 0000:ffff8800bc28fcf8  EFLAGS: 00010202
[    0.722761] RAX: 0000000000000000 RBX: 00000000000001a4 RCX: 00000000000001a4
[    0.722761] RDX: 0000000000000000 RSI: 0000000000000008 RDI: 000057b029b332e0
[    0.722761] RBP: ffff8800bc28fd08 R08: ffff8800bc290000 R09: ffff8800bb2f4000
[    0.722761] R10: ffff8800bc290000 R11: ffff8800bb2f4000 R12: 000057b029b332e0
[    0.722761] R13: 0000000000000000 R14: 000057b029b33340 R15: ffff8800bb1e2a00
[    0.722761] FS:  0000000000000000(0000) GS:ffff8800bfb00000(0000) knlGS:0000000000000000
[    0.722761] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[    0.722761] CR2: 000057b029b332e0 CR3: 00000000bb2f8000 CR4: 00000000000006e0
[    0.722761] Stack:
[    0.722761]  000057b029b332e0 ffff8800bb95fa80 ffff8800bc28fd18 ffffffff83f4120c
[    0.722761]  ffff8800bc28fe18 ffffffff83e9e7a1 ffff8800bc28fd68 0000000000000000
[    0.722761]  ffff8800bc290000 ffff8800bc290000 ffff8800bc290000 ffff8800bc290000
[    0.722761] Call Trace:
[    0.722761]  [<ffffffff83f4120c>] clear_user+0x2e/0x30
[    0.722761]  [<ffffffff83e9e7a1>] load_elf_binary+0xa7f/0x18f7
[    0.722761]  [<ffffffff83de2088>] search_binary_handler+0x86/0x19c
[    0.722761]  [<ffffffff83de389e>] do_execveat_common.isra.26+0x909/0xf98
[    0.722761]  [<ffffffff844febe0>] ? rest_init+0x87/0x87
[    0.722761]  [<ffffffff83de40be>] do_execve+0x23/0x25
[    0.722761]  [<ffffffff83c002e3>] run_init_process+0x2b/0x2d
[    0.722761]  [<ffffffff844fec4d>] kernel_init+0x6d/0xda
[    0.722761]  [<ffffffff84505b2f>] ret_from_fork+0x3f/0x70
[    0.722761]  [<ffffffff844febe0>] ? rest_init+0x87/0x87
[    0.722761] Code: 86 84 be 12 00 00 00 e8 87 0d e8 ff 66 66 90 48 89 d8 48 c1
eb 03 4c 89 e7 83 e0 07 48 89 d9 be 08 00 00 00 31 d2 48 85 c9 74 0a <48> 89 17
48 01 f7 ff c9 75 f6 48 89 c1 85 c9 74 09 88 17 48 ff
[    0.722761] RIP  [<ffffffff83f4129e>] __clear_user+0x42/0x67
[    0.722761]  RSP <ffff8800bc28fcf8>
[    0.722761] ---[ end trace def703879b4ff090 ]---
[    0.722761] BUG: sleeping function called from invalid context at /mnt/host/source/src/third_party/kernel/v4.4/kernel/locking/rwsem.c:21
[    0.722761] in_atomic(): 0, irqs_disabled(): 1, pid: 1, name: init
[    0.722761] CPU: 1 PID: 1 Comm: init Tainted: G      D         4.4.96 #31
[    0.722761] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.7.5.1-0-g8936dbb-20141113_115728-nilsson.home.kraxel.org 04/01/2014
[    0.722761]  0000000000000086 dcb5d76098c89836 ffff8800bc28fa30 ffffffff83f34004
[    0.722761]  ffffffff84839dc2 0000000000000015 ffff8800bc28fa40 ffffffff83d57dc9
[    0.722761]  ffff8800bc28fa68 ffffffff83d57e6a ffffffff84a53640 0000000000000000
[    0.722761] Call Trace:
[    0.722761]  [<ffffffff83f34004>] dump_stack+0x4d/0x63
[    0.722761]  [<ffffffff83d57dc9>] ___might_sleep+0x13a/0x13c
[    0.722761]  [<ffffffff83d57e6a>] __might_sleep+0x9f/0xa6
[    0.722761]  [<ffffffff84502788>] down_read+0x20/0x31
[    0.722761]  [<ffffffff83cc5d9b>] __blocking_notifier_call_chain+0x35/0x63
[    0.722761]  [<ffffffff83cc5ddd>] blocking_notifier_call_chain+0x14/0x16
[    0.800374] usb 1-1: new full-speed USB device number 2 using uhci_hcd
[    0.722761]  [<ffffffff83cefe97>] profile_task_exit+0x1a/0x1c
[    0.802309]  [<ffffffff83cac84e>] do_exit+0x39/0xe7f
[    0.802309]  [<ffffffff83ce5938>] ? vprintk_default+0x1d/0x1f
[    0.802309]  [<ffffffff83d7bb95>] ? printk+0x57/0x73
[    0.802309]  [<ffffffff83c46e25>] oops_end+0x80/0x85
[    0.802309]  [<ffffffff83c7b747>] pgtable_bad+0x8a/0x95
[    0.802309]  [<ffffffff83ca7f4a>] __do_page_fault+0x8c/0x352
[    0.802309]  [<ffffffff83eefba5>] ? file_has_perm+0xc4/0xe5
[    0.802309]  [<ffffffff83ca821c>] do_page_fault+0xc/0xe
[    0.802309]  [<ffffffff84507682>] page_fault+0x22/0x30
[    0.802309]  [<ffffffff83f4129e>] ? __clear_user+0x42/0x67
[    0.802309]  [<ffffffff83f4127f>] ? __clear_user+0x23/0x67
[    0.802309]  [<ffffffff83f4120c>] clear_user+0x2e/0x30
[    0.802309]  [<ffffffff83e9e7a1>] load_elf_binary+0xa7f/0x18f7
[    0.802309]  [<ffffffff83de2088>] search_binary_handler+0x86/0x19c
[    0.802309]  [<ffffffff83de389e>] do_execveat_common.isra.26+0x909/0xf98
[    0.802309]  [<ffffffff844febe0>] ? rest_init+0x87/0x87
[    0.802309]  [<ffffffff83de40be>] do_execve+0x23/0x25
[    0.802309]  [<ffffffff83c002e3>] run_init_process+0x2b/0x2d
[    0.802309]  [<ffffffff844fec4d>] kernel_init+0x6d/0xda
[    0.802309]  [<ffffffff84505b2f>] ret_from_fork+0x3f/0x70
[    0.802309]  [<ffffffff844febe0>] ? rest_init+0x87/0x87
[    0.830559] Kernel panic - not syncing: Attempted to kill init!  exitcode=0x00000009
[    0.830559]
[    0.831305] Kernel Offset: 0x2c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[    0.831305] ---[ end Kernel panic - not syncing: Attempted to kill init!  exitcode=0x00000009

The crash part of this problem may be solved with the following patch
(thanks to Hugh for the hint). There is still another problem, though -
with this patch applied, the qemu session aborts with "VCPU Shutdown
request", whatever that means.

Cc: lepton <ytht.net@gmail.com>
Signed-off-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit b33c3c64c4786cd724ccde6fa97c87ada49f6a73 linux-4.4.y)
Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/mm/kaiser.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/mm/kaiser.c
+++ b/arch/x86/mm/kaiser.c
@@ -411,7 +411,8 @@ pgd_t kaiser_set_shadow_pgd(pgd_t *pgdp,
 			 * get out to userspace running on the kernel CR3,
 			 * userspace will crash instead of running.
 			 */
-			pgd.pgd |= _PAGE_NX;
+			if (__supported_pte_mask & _PAGE_NX)
+				pgd.pgd |= _PAGE_NX;
 		}
 	} else if (!pgd.pgd) {
 		/*
