Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7B1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18DFB208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18DFB208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405000AbeKWGju convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:39:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728657AbeKWGiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:38:01 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D5A94C049D79;
        Thu, 22 Nov 2018 19:57:06 +0000 (UTC)
Received: from llong.remote.csb (ovpn-121-14.rdu2.redhat.com [10.10.121.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB02D60920;
        Thu, 22 Nov 2018 19:57:03 +0000 (UTC)
Subject: Re: [PATCH v2 07/17] debugobjects: Move printk out of db lock
 critical sections
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <1542653726-5655-1-git-send-email-longman@redhat.com>
 <1542653726-5655-8-git-send-email-longman@redhat.com>
 <2ddd9e3d-951e-1892-c941-54be80f7e6aa@redhat.com>
 <20181122020422.GA3441@jagdpanzerIV>
From:   Waiman Long <longman@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 xsFNBFgsZGsBEAC3l/RVYISY3M0SznCZOv8aWc/bsAgif1H8h0WPDrHnwt1jfFTB26EzhRea
 XQKAJiZbjnTotxXq1JVaWxJcNJL7crruYeFdv7WUJqJzFgHnNM/upZuGsDIJHyqBHWK5X9ZO
 jRyfqV/i3Ll7VIZobcRLbTfEJgyLTAHn2Ipcpt8mRg2cck2sC9+RMi45Epweu7pKjfrF8JUY
 r71uif2ThpN8vGpn+FKbERFt4hW2dV/3awVckxxHXNrQYIB3I/G6mUdEZ9yrVrAfLw5M3fVU
 CRnC6fbroC6/ztD40lyTQWbCqGERVEwHFYYoxrcGa8AzMXN9CN7bleHmKZrGxDFWbg4877zX
 0YaLRypme4K0ULbnNVRQcSZ9UalTvAzjpyWnlnXCLnFjzhV7qsjozloLTkZjyHimSc3yllH7
 VvP/lGHnqUk7xDymgRHNNn0wWPuOpR97J/r7V1mSMZlni/FVTQTRu87aQRYu3nKhcNJ47TGY
 evz/U0ltaZEU41t7WGBnC7RlxYtdXziEn5fC8b1JfqiP0OJVQfdIMVIbEw1turVouTovUA39
 Qqa6Pd1oYTw+Bdm1tkx7di73qB3x4pJoC8ZRfEmPqSpmu42sijWSBUgYJwsziTW2SBi4hRjU
 h/Tm0NuU1/R1bgv/EzoXjgOM4ZlSu6Pv7ICpELdWSrvkXJIuIwARAQABzR9Mb25nbWFuIExv
 bmcgPGxsb25nQHJlZGhhdC5jb20+wsF/BBMBAgApBQJYLGRrAhsjBQkJZgGABwsJCAcDAgEG
 FQgCCQoLBBYCAwECHgECF4AACgkQbjBXZE7vHeYwBA//ZYxi4I/4KVrqc6oodVfwPnOVxvyY
 oKZGPXZXAa3swtPGmRFc8kGyIMZpVTqGJYGD9ZDezxpWIkVQDnKM9zw/qGarUVKzElGHcuFN
 ddtwX64yxDhA+3Og8MTy8+8ZucM4oNsbM9Dx171bFnHjWSka8o6qhK5siBAf9WXcPNogUk4S
 fMNYKxexcUayv750GK5E8RouG0DrjtIMYVJwu+p3X1bRHHDoieVfE1i380YydPd7mXa7FrRl
 7unTlrxUyJSiBc83HgKCdFC8+ggmRVisbs+1clMsK++ehz08dmGlbQD8Fv2VK5KR2+QXYLU0
 rRQjXk/gJ8wcMasuUcywnj8dqqO3kIS1EfshrfR/xCNSREcv2fwHvfJjprpoE9tiL1qP7Jrq
 4tUYazErOEQJcE8Qm3fioh40w8YrGGYEGNA4do/jaHXm1iB9rShXE2jnmy3ttdAh3M8W2OMK
 4B/Rlr+Awr2NlVdvEF7iL70kO+aZeOu20Lq6mx4Kvq/WyjZg8g+vYGCExZ7sd8xpncBSl7b3
 99AIyT55HaJjrs5F3Rl8dAklaDyzXviwcxs+gSYvRCr6AMzevmfWbAILN9i1ZkfbnqVdpaag
 QmWlmPuKzqKhJP+OMYSgYnpd/vu5FBbc+eXpuhydKqtUVOWjtp5hAERNnSpD87i1TilshFQm
 TFxHDzbOwU0EWCxkawEQALAcdzzKsZbcdSi1kgjfce9AMjyxkkZxcGc6Rhwvt78d66qIFK9D
 Y9wfcZBpuFY/AcKEqjTo4FZ5LCa7/dXNwOXOdB1Jfp54OFUqiYUJFymFKInHQYlmoES9EJEU
 yy+2ipzy5yGbLh3ZqAXyZCTmUKBU7oz/waN7ynEP0S0DqdWgJnpEiFjFN4/ovf9uveUnjzB6
 lzd0BDckLU4dL7aqe2ROIHyG3zaBMuPo66pN3njEr7IcyAL6aK/IyRrwLXoxLMQW7YQmFPSw
 drATP3WO0x8UGaXlGMVcaeUBMJlqTyN4Swr2BbqBcEGAMPjFCm6MjAPv68h5hEoB9zvIg+fq
 M1/Gs4D8H8kUjOEOYtmVQ5RZQschPJle95BzNwE3Y48ZH5zewgU7ByVJKSgJ9HDhwX8Ryuia
 79r86qZeFjXOUXZjjWdFDKl5vaiRbNWCpuSG1R1Tm8o/rd2NZ6l8LgcK9UcpWorrPknbE/pm
 MUeZ2d3ss5G5Vbb0bYVFRtYQiCCfHAQHO6uNtA9IztkuMpMRQDUiDoApHwYUY5Dqasu4ZDJk
 bZ8lC6qc2NXauOWMDw43z9He7k6LnYm/evcD+0+YebxNsorEiWDgIW8Q/E+h6RMS9kW3Rv1N
 qd2nFfiC8+p9I/KLcbV33tMhF1+dOgyiL4bcYeR351pnyXBPA66ldNWvABEBAAHCwWUEGAEC
 AA8FAlgsZGsCGwwFCQlmAYAACgkQbjBXZE7vHeYxSQ/+PnnPrOkKHDHQew8Pq9w2RAOO8gMg
 9Ty4L54CsTf21Mqc6GXj6LN3WbQta7CVA0bKeq0+WnmsZ9jkTNh8lJp0/RnZkSUsDT9Tza9r
 GB0svZnBJMFJgSMfmwa3cBttCh+vqDV3ZIVSG54nPmGfUQMFPlDHccjWIvTvyY3a9SLeamaR
 jOGye8MQAlAD40fTWK2no6L1b8abGtziTkNh68zfu3wjQkXk4kA4zHroE61PpS3oMD4AyI9L
 7A4Zv0Cvs2MhYQ4Qbbmafr+NOhzuunm5CoaRi+762+c508TqgRqH8W1htZCzab0pXHRfywtv
 0P+BMT7vN2uMBdhr8c0b/hoGqBTenOmFt71tAyyGcPgI3f7DUxy+cv3GzenWjrvf3uFpxYx4
 yFQkUcu06wa61nCdxXU/BWFItryAGGdh2fFXnIYP8NZfdA+zmpymJXDQeMsAEHS0BLTVQ3+M
 7W5Ak8p9V+bFMtteBgoM23bskH6mgOAw6Cj/USW4cAJ8b++9zE0/4Bv4iaY5bcsL+h7TqQBH
 Lk1eByJeVooUa/mqa2UdVJalc8B9NrAnLiyRsg72Nurwzvknv7anSgIkL+doXDaG21DgCYTD
 wGA5uquIgb8p3/ENgYpDPrsZ72CxVC2NEJjJwwnRBStjJOGQX4lV1uhN1XsZjBbRHdKF2W9g
 weim8xU=
Organization: Red Hat
Message-ID: <c8c29a58-f356-d379-2bf4-cea09b03dc3e@redhat.com>
Date:   Thu, 22 Nov 2018 14:57:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181122020422.GA3441@jagdpanzerIV>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 22 Nov 2018 19:57:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/2018 09:04 PM, Sergey Senozhatsky wrote:
> On (11/21/18 11:49), Waiman Long wrote:
> [..]
>>>  	case ODEBUG_STATE_ACTIVE:
>>> -		debug_print_object(obj, "init");
>>>  		state = obj->state;
>>>  		raw_spin_unlock_irqrestore(&db->lock, flags);
>>> +		debug_print_object(obj, "init");
>>>  		debug_object_fixup(descr->fixup_init, addr, state);
>>>  		return;
>>>  
>>>  	case ODEBUG_STATE_DESTROYED:
>>> -		debug_print_object(obj, "init");
>>> +		debug_printobj = true;
>>>  		break;
>>>  	default:
>>>  		break;
>>>  	}
>>>  
>>>  	raw_spin_unlock_irqrestore(&db->lock, flags);
>>> +	if (debug_chkstack)
>>> +		debug_object_is_on_stack(addr, onstack);
>>> +	if (debug_printobj)
>>> +		debug_print_object(obj, "init");
>>>
> [..]
>> As a side note, one of the test systems that I used generated a
>> debugobjects splat in the bootup process and the system hanged
>> afterward. Applying this patch alone fix the hanging problem and the
>> system booted up successfully. So it is not really a good idea to call
>> printk() while holding a raw spinlock.
> Right, I like this patch.
> And I think that we, maybe, can go even further.
>
> Some serial consoles call mod_timer(). So what we could have with the
> debug objects enabled was
>
> 	mod_timer()
> 	 lock_timer_base()
> 	  debug_activate()
> 	   printk()
> 	    call_console_drivers()
> 	     foo_console()
> 	      mod_timer()
> 	       lock_timer_base()       << deadlock
>
> That's one possible scenario. The other one can involve console's
> IRQ handler, uart port spinlock, mod_timer, debug objects, printk,
> and an eventual deadlock on the uart port spinlock. This one can
> be mitigated with printk_safe. But mod_timer() deadlock will require
> a different fix.
>
> So maybe we need to switch debug objects print-outs to _always_
> printk_deferred(). Debug objects can be used in code which cannot
> do direct printk() - timekeeping is just one example.
>
> 	-ss

Actually, I don't think that was the cause of the hang. The debugobjects
splat was caused by debug_object_is_on_stack(), below was the output:

[    6.890048] ODEBUG: object (____ptrval____) is NOT on stack
(____ptrval____), but annotated.
[    6.891000] WARNING: CPU: 28 PID: 1 at lib/debugobjects.c:369
__debug_object_init.cold.11+0x51/0x2d6
[    6.891000] Modules linked in:
[    6.891000] CPU: 28 PID: 1 Comm: swapper/0 Not tainted
4.18.0-41.el8.bz1651764_cgroup_debug.x86_64+debug #1
[    6.891000] Hardware name: HPE ProLiant DL120 Gen10/ProLiant DL120
Gen10, BIOS U36 11/14/2017
[    6.891000] RIP: 0010:__debug_object_init.cold.11+0x51/0x2d6
[    6.891000] Code: ea 03 80 3c 02 00 0f 85 85 02 00 00 49 8b 54 24 18
48 89 de 4c 89 44 24 10 48 c7 c7 00 ce 22 94 e8 73 18 62 ff 4c 8b 44 24
10 <0f> 0b e9 60 db ff ff 41 83 c4 01 b8 ff ff 37 00 44 89 25 ce 46 f9
[    6.891000] RSP: 0000:ffff880104187960 EFLAGS: 00010086
[    6.891000] RAX: 0000000000000050 RBX: ffffffff9764c570 RCX:
0000000000000000
[    6.891000] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
ffff880104178ca8
[    6.891000] RBP: 1ffff10020830f34 R08: ffff8807ce68a1d0 R09:
fffffbfff2923554
[    6.891000] R10: fffffbfff2923554 R11: ffffffff9491aaa3 R12:
ffff880104178000
[    6.891000] R13: ffffffff96c809b8 R14: 000000000000a370 R15:
ffff8807ce68a1c0
[    6.891000] FS:  0000000000000000(0000) GS:ffff8807d4200000(0000)
knlGS:0000000000000000
[    6.891000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.891000] CR2: 0000000000000000 CR3: 000000028de16001 CR4:
00000000007606e0
[    6.891000] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[    6.891000] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[    6.891000] PKRU: 00000000
[    6.891000] Call Trace:
[    6.891000]  ? debug_object_fixup+0x30/0x30
[    6.891000]  ? _raw_spin_unlock_irqrestore+0x4b/0x60
[    6.891000]  ? __lockdep_init_map+0x12f/0x510
[    6.891000]  ? __lockdep_init_map+0x12f/0x510
[    6.891000]  virt_efi_get_next_variable+0xa2/0x160
[    6.891000]  efivar_init+0x1c4/0x6d7
[    6.891000]  ? efivar_ssdt_setup+0x3b/0x3b
[    6.891000]  ? efivar_entry_iter+0x120/0x120
[    6.891000]  ? find_held_lock+0x3a/0x1c0
[    6.891000]  ? lock_downgrade+0x5e0/0x5e0
[    6.891000]  ? kmsg_dump_rewind_nolock+0xd9/0xd9
[    6.891000]  ? _raw_spin_unlock_irqrestore+0x4b/0x60
[    6.891000]  ? trace_hardirqs_on_caller+0x381/0x570
[    6.891000]  ? efivar_ssdt_iter+0x1f4/0x1f4
[    6.891000]  efisubsys_init+0x1be/0x4ae
[    6.891000]  ? kernfs_get.part.8+0x4c/0x60
[    6.891000]  ? efivar_ssdt_iter+0x1f4/0x1f4
[    6.891000]  ? __kernfs_create_file+0x235/0x2e0
[    6.891000]  ? efivar_ssdt_iter+0x1f4/0x1f4
[    6.891000]  do_one_initcall+0xe9/0x5fd
[    6.891000]  ? perf_trace_initcall_level+0x450/0x450
[    6.891000]  ? __wake_up_common+0x5a0/0x5a0
[    6.891000]  ? lock_downgrade+0x5e0/0x5e0
[    6.891000]  kernel_init_freeable+0x51a/0x5f2
[    6.891000]  ? start_kernel+0x7b8/0x7b8
[    6.891000]  ? finish_task_switch+0x19a/0x690
[    6.891000]  ? __switch_to_asm+0x40/0x70
[    6.891000]  ? __switch_to_asm+0x34/0x70
[    6.891000]  ? rest_init+0xe9/0xe9
[    6.891000]  kernel_init+0xc/0x110
[    6.891000]  ? rest_init+0xe9/0xe9
[    6.891000]  ret_from_fork+0x24/0x50
[    6.891000] irq event stamp: 1081352
[    6.891000] hardirqs last  enabled at (1081351): [<ffffffff93af7dab>]
_raw_spin_unlock_irqrestore+0x4b/0x60
[    6.891000] hardirqs last disabled at (1081352): [<ffffffff93af85c2>]
_raw_spin_lock_irqsave+0x22/0x81
[    6.891000] softirqs last  enabled at (1081334): [<ffffffff93e006f9>]
__do_softirq+0x6f9/0xaa0
[    6.891000] softirqs last disabled at (1081325): [<ffffffff921b993f>]
irq_exit+0x27f/0x2d0
[    6.891000] ---[ end trace 15e1083fc009a526 ]---

All the messages above were printed while holding a raw spinlock with
IRQ disabled. Further down the bootup sequence, the system appeared to hang:

   11.270654] systemd[1]: systemd 239 running in system mode. (+PAM
+AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP
+GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN
+PCRE2 default-hierarchy=legacy)
[   11.311307] systemd[1]: Detected architecture x86-64.
[   11.316420] systemd[1]: Running in initial RAM disk.

Welcome to

The system is not responsive at this point.

I am not totally sure what caused this. Maybe it was caused by disabling
IRQ for too long leading to some kind of corruption. Anyway, moving
debug_object_is_on_stack() outside of the IRQ disabled lock critical
section seemed to fix the hang problem.

Cheers,
Longman


