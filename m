Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtaWwfmwpBic1oeDstvXNygWTvlGlVq42bnkIUyjVQYwZlfIHGAS8Xnaj+JeUTnc3jqyTCj
ARC-Seal: i=1; a=rsa-sha256; t=1519412127; cv=none;
        d=google.com; s=arc-20160816;
        b=IWqtYtO6jQdzLeRWK49XwMJj7LI0erDJ9Ld2m74SKUOrimK7uJIQRuGlvkybqXE0Vu
         Tui+QkJGZK/Cz0oSgL2zmEOf1zCISZgLCiPxN+4fyIRl5ianmncjNn2rRUK0W/Vgami2
         9+3wzY8I/WvJiBlklpRYoFy978RJKGe2G7tL+Ntrti+KsAgj0t5bSsZqJyM+h2iU1KhI
         lWsEe7kOjNOwVSjqx4UYjWYUn6pDosG/TiJnlqwFnGCNpvW05gx9jqw/Y72HvNuacXn0
         sA2zkxHe1id3r1H3Wd3DtYpUdUovRxom91PT2ttfN76ODtx5GuRO9mkT7fymu1zmarSt
         mztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KhTOrif3K/gWeA59BpXZXdnAwpwwUaZOUShTwV3PaTc=;
        b=REFto+j93nnuwwHa2B/tyCgxH5QTKJg6GWBWSC/KjUi3t5YWMKp0Lhe3NXdET59zb+
         65GE6VsWJoKvMOJn09eLXs381wxupbwoO/f7qRflKfylndE7AlVl7YtKlgE9Cl15BQwt
         y2MVKidQ0jH4nD+07I9PTUrjHFM/uBjHIMc8UZxKGK3MjQry9UI5cSQVRxHgXNeUymV/
         /qQX7F+1pHHQJuBMkcKXKvkMXJDRLGcZ4dMm9EbvikfoaHUHue/ryrz3571QMvgLWHcC
         vfhx7elwA1ehrFqiPMBiuBs3uLcrx/rCwStN8zQPmofJWKOOQ5fCMbzdsLXncag4eEcv
         73FA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 134/159] netfilter: xt_bpf: add overflow checks
Date: Fri, 23 Feb 2018 19:27:22 +0100
Message-Id: <20180223170759.302965027@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219091787853569?=
X-GMAIL-MSGID: =?utf-8?q?1593219091787853569?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>


[ Upstream commit 6ab405114b0b229151ef06f4e31c7834dd09d0c0 ]

Check whether inputs from userspace are too long (explicit length field too
big or string not null-terminated) to avoid out-of-bounds reads.

As far as I can tell, this can at worst lead to very limited kernel heap
memory disclosure or oopses.

This bug can be triggered by an unprivileged user even if the xt_bpf module
is not loaded: iptables is available in network namespaces, and the xt_bpf
module can be autoloaded.

Triggering the bug with a classic BPF filter with fake length 0x1000 causes
the following KASAN report:

==================================================================
BUG: KASAN: slab-out-of-bounds in bpf_prog_create+0x84/0xf0
Read of size 32768 at addr ffff8801eff2c494 by task test/4627

CPU: 0 PID: 4627 Comm: test Not tainted 4.15.0-rc1+ #1
[...]
Call Trace:
 dump_stack+0x5c/0x85
 print_address_description+0x6a/0x260
 kasan_report+0x254/0x370
 ? bpf_prog_create+0x84/0xf0
 memcpy+0x1f/0x50
 bpf_prog_create+0x84/0xf0
 bpf_mt_check+0x90/0xd6 [xt_bpf]
[...]
Allocated by task 4627:
 kasan_kmalloc+0xa0/0xd0
 __kmalloc_node+0x47/0x60
 xt_alloc_table_info+0x41/0x70 [x_tables]
[...]
The buggy address belongs to the object at ffff8801eff2c3c0
                which belongs to the cache kmalloc-2048 of size 2048
The buggy address is located 212 bytes inside of
                2048-byte region [ffff8801eff2c3c0, ffff8801eff2cbc0)
[...]
==================================================================

Fixes: e6f30c731718 ("netfilter: x_tables: add xt_bpf match")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/xt_bpf.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/net/netfilter/xt_bpf.c
+++ b/net/netfilter/xt_bpf.c
@@ -27,6 +27,9 @@ static int __bpf_mt_check_bytecode(struc
 {
 	struct sock_fprog_kern program;
 
+	if (len > XT_BPF_MAX_NUM_INSTR)
+		return -EINVAL;
+
 	program.len = len;
 	program.filter = insns;
 
@@ -55,6 +58,9 @@ static int __bpf_mt_check_path(const cha
 	mm_segment_t oldfs = get_fs();
 	int retval, fd;
 
+	if (strnlen(path, XT_BPF_PATH_MAX) == XT_BPF_PATH_MAX)
+		return -EINVAL;
+
 	set_fs(KERNEL_DS);
 	fd = bpf_obj_get_user(path);
 	set_fs(oldfs);
