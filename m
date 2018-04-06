Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49xMAh0qQQsRcE6SbeT7GL01MEKyt8bV2vclrvSoq/CQGCjfKR/1sHxLOrIjIW9KmZe2fA9
ARC-Seal: i=1; a=rsa-sha256; t=1523022039; cv=none;
        d=google.com; s=arc-20160816;
        b=pEJNThjMXy1WCYDplmafKB/D1cpyGfU8Biv8xJUybclvWaShp4PCYyrpwQeWK7A7pa
         gLFqMUdf+QyQLPzuniZ4Z+dZWZeDlhHu+KOSbd3feCMu22v+hXNu3P9LQHvEFuEO6d+C
         ZaIOr+73lWXePPOJvFYpdguiiDOjQWz+/fTWorziiXeHt3deRNBOTNryLLbJELFoJyWl
         KNg2B9REVxJL+44ztLBQ4rsrGCADSTAu2Dvb/f5w2nPNs7A/hgXllSQt/wPuXvAVFbP7
         eGRrxJzNxysoYDA48gkquMbrWxvIZGlEFSt2p5g1bAfrY6RM5bhT74C0I/G5cHG6JLCQ
         Akaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1MXPkt8Ih/5sy4DREQGt1S0NQ2nqsWyzrvQfgi7/i8E=;
        b=doV8qvLbDqKiVM2V49XG8GHbX6oBrVxamKWGwLlCCL3VxN38i5hlTULEz+mI+Und76
         e6WCI9ri/Fhw9PMbsJxnFgnBA0ZlZgbi0NP+vGZBaAVSyWzqJhxHHHw/O3i3fIYzfRRP
         J1EFyeB/PsFQNAerkPAiSeeiWbLoXxz9dVdx9SOSFr1sueDAlO+LoB13El2rV6y9KmBA
         0CDNpdanY8CAPmIIk0sFBuQY44YSqXLWaPP81cqfjiUlExWGtxG5NiJ8Q0GGCPYU15D6
         3OK0ZwqROfVXNAD2I9XHu7gS8+xECXiqRVLNzf3vOai30oXNrqjX4PmkPc/YQMJRK2pc
         yVYg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 32/67] netfilter: drop template ct when conntrack is skipped.
Date: Fri,  6 Apr 2018 15:24:02 +0200
Message-Id: <20180406084345.618318674@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004358237408018?=
X-GMAIL-MSGID: =?utf-8?q?1597004358237408018?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

commit aebfa52a925d701114afd6af0def35bab16d4f47 upstream.

The ipv4 nf_ct code currently skips the nf_conntrak_in() call
for fragmented packets. As a results later matches/target can end
up manipulating template ct entry instead of 'real' ones.

Exploiting the above, syzbot found a way to trigger the following
splat:

WARNING: CPU: 1 PID: 4242 at net/netfilter/xt_cluster.c:55
xt_cluster_mt+0x6c1/0x840 net/netfilter/xt_cluster.c:127
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 4242 Comm: syzkaller027971 Not tainted 4.16.0-rc2+ #243
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x194/0x24d lib/dump_stack.c:53
  panic+0x1e4/0x41c kernel/panic.c:183
  __warn+0x1dc/0x200 kernel/panic.c:547
  report_bug+0x211/0x2d0 lib/bug.c:184
  fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:178
  fixup_bug arch/x86/kernel/traps.c:247 [inline]
  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
  invalid_op+0x58/0x80 arch/x86/entry/entry_64.S:957
RIP: 0010:xt_cluster_hash net/netfilter/xt_cluster.c:55 [inline]
RIP: 0010:xt_cluster_mt+0x6c1/0x840 net/netfilter/xt_cluster.c:127
RSP: 0018:ffff8801d2f6f2d0 EFLAGS: 00010293
RAX: ffff8801af700540 RBX: 0000000000000000 RCX: ffffffff84a2d1e1
RDX: 0000000000000000 RSI: ffff8801d2f6f478 RDI: ffff8801cafd336a
RBP: ffff8801d2f6f2e8 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8801b03b3d18
R13: ffff8801cafd3300 R14: dffffc0000000000 R15: ffff8801d2f6f478
  ipt_do_table+0xa91/0x19b0 net/ipv4/netfilter/ip_tables.c:296
  iptable_filter_hook+0x65/0x80 net/ipv4/netfilter/iptable_filter.c:41
  nf_hook_entry_hookfn include/linux/netfilter.h:120 [inline]
  nf_hook_slow+0xba/0x1a0 net/netfilter/core.c:483
  nf_hook include/linux/netfilter.h:243 [inline]
  NF_HOOK include/linux/netfilter.h:286 [inline]
  raw_send_hdrinc.isra.17+0xf39/0x1880 net/ipv4/raw.c:432
  raw_sendmsg+0x14cd/0x26b0 net/ipv4/raw.c:669
  inet_sendmsg+0x11f/0x5e0 net/ipv4/af_inet.c:763
  sock_sendmsg_nosec net/socket.c:629 [inline]
  sock_sendmsg+0xca/0x110 net/socket.c:639
  SYSC_sendto+0x361/0x5c0 net/socket.c:1748
  SyS_sendto+0x40/0x50 net/socket.c:1716
  do_syscall_64+0x280/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x441b49
RSP: 002b:00007ffff5ca8b18 EFLAGS: 00000216 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000441b49
RDX: 0000000000000030 RSI: 0000000020ff7000 RDI: 0000000000000003
RBP: 00000000006cc018 R08: 000000002066354c R09: 0000000000000010
R10: 0000000000000000 R11: 0000000000000216 R12: 0000000000403470
R13: 0000000000403500 R14: 0000000000000000 R15: 0000000000000000
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..

Instead of adding checks for template ct on every target/match
manipulating skb->_nfct, simply drop the template ct when skipping
nf_conntrack_in().

Fixes: 7b4fdf77a450ec ("netfilter: don't track fragmented packets")
Reported-and-tested-by: syzbot+0346441ae0545cfcea3a@syzkaller.appspotmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- a/net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c
+++ b/net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c
@@ -159,8 +159,20 @@ static unsigned int ipv4_conntrack_local
 	    ip_hdrlen(skb) < sizeof(struct iphdr))
 		return NF_ACCEPT;
 
-	if (ip_is_fragment(ip_hdr(skb))) /* IP_NODEFRAG setsockopt set */
+	if (ip_is_fragment(ip_hdr(skb))) { /* IP_NODEFRAG setsockopt set */
+		enum ip_conntrack_info ctinfo;
+		struct nf_conn *tmpl;
+
+		tmpl = nf_ct_get(skb, &ctinfo);
+		if (tmpl && nf_ct_is_template(tmpl)) {
+			/* when skipping ct, clear templates to avoid fooling
+			 * later targets/matches
+			 */
+			skb->_nfct = 0;
+			nf_ct_put(tmpl);
+		}
 		return NF_ACCEPT;
+	}
 
 	return nf_conntrack_in(state->net, PF_INET, state->hook, skb);
 }
