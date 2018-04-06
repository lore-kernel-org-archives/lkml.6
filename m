Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/CBiKlNeD+0urnMVsF9ANgqDC526+peQS7juukzerbHj0yfqkqLIMoLR5XBktjEDSu0HZe
ARC-Seal: i=1; a=rsa-sha256; t=1523022105; cv=none;
        d=google.com; s=arc-20160816;
        b=axU9l9ZLRAoh7rx/wj5XHy0WwKoiu8y0Bi1VDbqJ5cUWdGYhv1LthFEa9GSUA+oW17
         1qTzErj0YxvISqgdo4DRtqUVR2qNfnqriRt4MJ8Ia+CgcscenyFs6PEyU1WGizB8RSUo
         WOLsfpKg/YzB+AlhESwmG7uKRnxY2YZUF6DwzVarVRVcxeGTu3pMlxmHwOcmYN183vV7
         tCZMwR/R4BOVN2Na50RRfAC7NX1RIHxRFy1niudK/xfoTZQQR9w09fcoys4KYiFjLypk
         asRvAiTky3fKkX0lYihUgLm1y/IUAYgv0HiF1qnfreUAFbDT835UsT/YYxXS16MvlUkc
         hP3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=k7wcjd5I1r21xUU1YRAytmrg9PK1hxACngYkSB1GvqA=;
        b=sQB43Hi+qzbxPV6Gcg4HRtmU6kwLGCsEsPOBAtVrZrQj/xYMs2+ouDeI1g8esb91+l
         z2QfBppwY1LQBx0jUBsuD8exmveJUiuG9GxBajGy52S1orF1WqnhagUsGxnXpR+441Ta
         V0ubXyOQziFBZyxjpbj3aTKoZ+l76/L7t2zgR3q/IweohTMiMixk+uNIQgeVQsrqNmuD
         mSltY9X8BiMluX9usFuAgt9HmqZcwsSApN8uEzZAWagTA2k5oMZ3Q1nc6g7VawnDlnqY
         iRGpZr2flToB3Om7pHgrqQLO+6T6TTbvlaRHdbdtlqQrUS/baRogkWnIrHBCNjc6iAbs
         1QNg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Greg Hackmann <ghackmann@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 4.15 29/72] net: xfrm: use preempt-safe this_cpu_read() in ipcomp_alloc_tfms()
Date: Fri,  6 Apr 2018 15:24:04 +0200
Message-Id: <20180406084351.789437640@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003592797913514?=
X-GMAIL-MSGID: =?utf-8?q?1597004426722820325?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Hackmann <ghackmann@google.com>

commit 0dcd7876029b58770f769cbb7b484e88e4a305e5 upstream.

f7c83bcbfaf5 ("net: xfrm: use __this_cpu_read per-cpu helper") added a
__this_cpu_read() call inside ipcomp_alloc_tfms().

At the time, __this_cpu_read() required the caller to either not care
about races or to handle preemption/interrupt issues.  3.15 tightened
the rules around some per-cpu operations, and now __this_cpu_read()
should never be used in a preemptible context.  On 3.15 and later, we
need to use this_cpu_read() instead.

syzkaller reported this leading to the following kernel BUG while
fuzzing sendmsg:

BUG: using __this_cpu_read() in preemptible [00000000] code: repro/3101
caller is ipcomp_init_state+0x185/0x990
CPU: 3 PID: 3101 Comm: repro Not tainted 4.16.0-rc4-00123-g86f84779d8e9 #154
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
Call Trace:
 dump_stack+0xb9/0x115
 check_preemption_disabled+0x1cb/0x1f0
 ipcomp_init_state+0x185/0x990
 ? __xfrm_init_state+0x876/0xc20
 ? lock_downgrade+0x5e0/0x5e0
 ipcomp4_init_state+0xaa/0x7c0
 __xfrm_init_state+0x3eb/0xc20
 xfrm_init_state+0x19/0x60
 pfkey_add+0x20df/0x36f0
 ? pfkey_broadcast+0x3dd/0x600
 ? pfkey_sock_destruct+0x340/0x340
 ? pfkey_seq_stop+0x80/0x80
 ? __skb_clone+0x236/0x750
 ? kmem_cache_alloc+0x1f6/0x260
 ? pfkey_sock_destruct+0x340/0x340
 ? pfkey_process+0x62a/0x6f0
 pfkey_process+0x62a/0x6f0
 ? pfkey_send_new_mapping+0x11c0/0x11c0
 ? mutex_lock_io_nested+0x1390/0x1390
 pfkey_sendmsg+0x383/0x750
 ? dump_sp+0x430/0x430
 sock_sendmsg+0xc0/0x100
 ___sys_sendmsg+0x6c8/0x8b0
 ? copy_msghdr_from_user+0x3b0/0x3b0
 ? pagevec_lru_move_fn+0x144/0x1f0
 ? find_held_lock+0x32/0x1c0
 ? do_huge_pmd_anonymous_page+0xc43/0x11e0
 ? lock_downgrade+0x5e0/0x5e0
 ? get_kernel_page+0xb0/0xb0
 ? _raw_spin_unlock+0x29/0x40
 ? do_huge_pmd_anonymous_page+0x400/0x11e0
 ? __handle_mm_fault+0x553/0x2460
 ? __fget_light+0x163/0x1f0
 ? __sys_sendmsg+0xc7/0x170
 __sys_sendmsg+0xc7/0x170
 ? SyS_shutdown+0x1a0/0x1a0
 ? __do_page_fault+0x5a0/0xca0
 ? lock_downgrade+0x5e0/0x5e0
 SyS_sendmsg+0x27/0x40
 ? __sys_sendmsg+0x170/0x170
 do_syscall_64+0x19f/0x640
 entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x7f0ee73dfb79
RSP: 002b:00007ffe14fc15a8 EFLAGS: 00000207 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0ee73dfb79
RDX: 0000000000000000 RSI: 00000000208befc8 RDI: 0000000000000004
RBP: 00007ffe14fc15b0 R08: 00007ffe14fc15c0 R09: 00007ffe14fc15c0
R10: 0000000000000000 R11: 0000000000000207 R12: 0000000000400440
R13: 00007ffe14fc16b0 R14: 0000000000000000 R15: 0000000000000000

Signed-off-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/xfrm/xfrm_ipcomp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/xfrm/xfrm_ipcomp.c
+++ b/net/xfrm/xfrm_ipcomp.c
@@ -283,7 +283,7 @@ static struct crypto_comp * __percpu *ip
 		struct crypto_comp *tfm;
 
 		/* This can be any valid CPU ID so we don't need locking. */
-		tfm = __this_cpu_read(*pos->tfms);
+		tfm = this_cpu_read(*pos->tfms);
 
 		if (!strcmp(crypto_comp_name(tfm), alg_name)) {
 			pos->users++;
