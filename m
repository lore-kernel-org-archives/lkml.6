Return-Path: <rolf.neugebauer@docker.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517926176; cv=none;
        d=google.com; s=arc-20160816;
        b=R9/qptrDmZAnQrxke0wtcxm6b94tbzV0VNj8qhoE0KMygzwCTD2PrSJ3bOBGb+a0S9
         KhNXSlfg8kJsWC6Z9uLYtpRKj1pLRGwkSdLYWEKnNIaJVdqKm3ic8A5y/+Xod6dNFbjY
         lrwO/JYXXQL9l/rCbekt38RHcPayZ8QqjABsTGAT8T1JdOEtTK7T/walpOeDI0r6dLXN
         zqfkwAXXHvD/t06i8JFuXNjClZJj1QODIvK8bS2JjJUKFrl+vJqjusveV8RJXk3tSFM8
         DpFV3GL+VfAymYADkDpUG6qtB68nYMGPK6OV6wUNUR+23UN12UJ24SbT3G7xRT5uF3Xe
         /H2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:subject:message-id:date:from:mime-version:dkim-signature
         :arc-authentication-results;
        bh=BvXj21syNZNeG3rmFXoxClbMkcvSL5xtfzBbetaeN3A=;
        b=Gjw6TIBZflo0GApbDoxnAUgh0JwRJncj+xHH9ujo/ALrrA7mJJDXfNnz+AKd1BhQoB
         1j1qaVzCE0ntbMW7CBbN0qAFyGeF9xNq/B6fcdm8hhEhQWg68vRcLdPPPH6rb4kOnGYy
         a7W55IRl++D8MT88FwN3b1nEjQ0CZU/zFfdy/j1MJPVKaB0FDnG3n54hgeiyUnIKsP+C
         pgqwP4/V+a1CsMCMN3rgn75ECu9CxKtWPwUeORQOWOfQaCbc/VbWKnwkc35FrqndvNtD
         /t9P7wPchuyXm/cvjGr7bzVSoJ59nN7Z3d58qhCv2xktozG+3i+98Z5MhpamPnn4wGXf
         X2dw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@docker.com header.s=google header.b=Lt+oTFXt;
       spf=pass (google.com: domain of rolf.neugebauer@docker.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=rolf.neugebauer@docker.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=docker.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@docker.com header.s=google header.b=Lt+oTFXt;
       spf=pass (google.com: domain of rolf.neugebauer@docker.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=rolf.neugebauer@docker.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=docker.com
X-Google-Smtp-Source: AH8x226rWm5zmbnKixHO0u/IdCkmxpiqOQD03/vc/nT7o7mKsnfhHXqUARhEuckE4fo6gOs+eQO9emKF7K6aAt5h1Rw=
MIME-Version: 1.0
From: Rolf Neugebauer <rolf.neugebauer@docker.com>
Date: Tue, 6 Feb 2018 14:09:35 +0000
Message-ID: <CA+pO-2c6z6uc8EO7LwWkGe3g_ygMwfS=VfQPNHzvS4H7RJOt-w@mail.gmail.com>
Subject: x86/microcode/intel: Division by zero panic in 4.9.79 and 4.4.114
To: Borislav Petkov <bp@alien8.de>, Jia Zhang <zhang.jia@linux.alibaba.com>,
	Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>, Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>, Rolf Neugebauer <rolf.neugebauer@docker.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591660958258362388?=
X-GMAIL-MSGID: =?utf-8?q?1591660958258362388?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The backport of 7e702d17ed1 ("x86/microcode/intel: Extend BDW
late-loading further with LLC size check") to 4.9.79 and 4.4.14 causes
a division by zero panic on some single vCPU machine types on Google
Cloud (e.g. g1-small and n1-standard-1):

[    1.591435] divide error: 0000 [#1] SMP
[    1.591961] Modules linked in:
[    1.592546] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.9.79-linuxkit #1
[    1.593461] Hardware name: Google Google Compute Engine/Google
Compute Engine, BIOS Google 01/01/2011
[    1.595135] task: ffffa01b2b63c040 task.stack: ffffb24f40010000
[    1.596683] RIP: 0010:[<ffffffffb7d88ce3>]  [<ffffffffb7d88ce3>]
init_intel_microcode+0x49/0x5a
[    1.598018] RSP: 0000:ffffb24f40013e48  EFLAGS: 00010206
[    1.599016] RAX: 0000000001400000 RBX: 00000000ffffffea RCX: 0000000000000000
[    1.600093] RDX: 0000000000000000 RSI: ffffa01b2fffa9a8 RDI: ffffffffb7d8888b
[    1.601222] RBP: 00000000ffffffff R08: ffffa01b2fffa9a1 R09: 000000000000005f
[    1.602330] R10: 0000000000000067 R11: ffffa01b22164177 R12: 0000000000000000
[    1.603291] R13: ffffffffb7d787b6 R14: 0000000000000000 R15: 0000000000000000
[    1.604406] FS:  0000000000000000(0000) GS:ffffa01b2fc00000(0000)
knlGS:0000000000000000
[    1.606154] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.607493] CR2: 0000000000000000 CR3: 000000002ac0a000 CR4: 0000000000040630
[    1.609310] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    1.611122] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    1.613008] Stack:
[    1.613445]  ffffffffb7d888c1 0000000000000000 ffffffffb7d1ba40
0000000000000000
[    1.615423]  0000000000000000 ffffffffb7d787b6 0000000000000000
0000000000000000
[    1.617049]  ffffffffb74fed89 00000000fffffff4 00000000ffffffff
4eae7bc133547c47
[    1.617904] Call Trace:
[    1.618198]  [<ffffffffb7d888c1>] ? microcode_init+0x36/0x1de
[    1.619264]  [<ffffffffb7d787b6>] ? set_debug_rodata+0xc/0xc
[    1.620143]  [<ffffffffb74fed89>] ? driver_register+0xaf/0xb4
[    1.621841]  [<ffffffffb7d8888b>] ? save_microcode_in_initrd+0x3c/0x3c
[    1.623424]  [<ffffffffb70021b7>] ? do_one_initcall+0x98/0x130
[    1.624659]  [<ffffffffb7d787b6>] ? set_debug_rodata+0xc/0xc
[    1.626303]  [<ffffffffb7d79091>] ? kernel_init_freeable+0x166/0x1e7
[    1.627674]  [<ffffffffb77ce3d7>] ? rest_init+0x6e/0x6e
[    1.628942]  [<ffffffffb77ce3e1>] ? kernel_init+0xa/0xe6
[    1.630243]  [<ffffffffb77d8587>] ? ret_from_fork+0x57/0x70
[    1.631592] Code: 16 0f b6 35 a0 ac fb ff 48 c7 c7 c4 ea 99 b7 e8
82 3e 41 ff 31 c0 c3 8b 05 3b ad fb ff 0f b7 0d 54 ad fb ff 31 d2 c1
e0 0a 48 98 <48> f7 f1 89 05 f4 6a 14 00 48 c7 c0 00 d8 c2 b7 c3 4c 8d
54 24
[    1.638875] RIP  [<ffffffffb7d88ce3>] init_intel_microcode+0x49/0x5a
[    1.640382]  RSP <ffffb24f40013e48>
[    1.641320] ---[ end trace e88ef332e19594b9 ]---
[    1.642418] Kernel panic - not syncing: Fatal exception
[    1.644581] Kernel Offset: 0x36000000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[    1.647312] ---[ end Kernel panic - not syncing: Fatal exception

On these machines x86_max_cores is zero:

[    0.227977] ftrace: allocating 35563 entries in 139 pages
[    0.273941] smpboot: x86_max_cores == zero !?!?
[    0.274645] smpboot: Max logical packages: 1


4.9.78 (and earlier) as well as 4.4.13 (and earlier) worked fine so
this seems like a regression in stable.

4.14.16 and 4.15 (to which the above patch was backported as well)
work fine, but I noticed significant code changes for these kernels
around where x86_max_cores is set.

The obvious quick fix/hack is to check for x86_max_cores in
calc_llc_size_per_core() and return 0. I'm happy to submit a patch for
this, but a more correct fix might be back porting the relevant
changes around where  x86_max_cores is set.

Thanks
Rolf
