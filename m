Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+N6YcygO1Q1rt8NewqagOa1W6B5c0/7jjx+COiXIpFgI05JyA4NrEqEaGQ3/NNqXaDoIMK
ARC-Seal: i=1; a=rsa-sha256; t=1522346622; cv=none;
        d=google.com; s=arc-20160816;
        b=e6OHNtkcWRk3R1cjecsdatS0V/sPw2qeJUUDhJzMnsU9fti2UXSRGRMsXFyZJnE2gY
         RIi+XZ+ncdnl8Amo/Ln0uFylaYkTZ53mDzk6QwvXGSR6sbGeBosfoMpv6ZrZah0Gjv17
         TP1RMYMgseYHk8znp/c5pDdHqEhg8cLdpXQYLhBxn14296UcOjjgFtbhhodJIyeQonWX
         5c1vPuhzDhOrp6H7Mmy00xjbhXGHeC6ClLqrZFnoHG2mzwa2+myIV/YKlXqkVBDUuZ2c
         mXdocZEBTJLIkivw7BoYK+/3FfTZ/54zEcg/VHYKk7MypyEgZX7jCoQzyNdEPGX1z3QE
         gkoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hOQ2SRKGHD+etU06sng3SJnsWZMFsp6ohWJJLmMDBc8=;
        b=k1hehOjkMLKqAuzKBKC7iKdPUP3fTP9ebEeqO75IzyiYLG76+EROHRVB+YSL+aFXVF
         7MZVc4+vjVCsMkCiWYcuEDVqbMvm+EStnmNsnG13SO23CXnTkZq4Eh/YOgzYstQMz1hE
         dLnIsJVODhChcCMobc4pPi5vW4GfnNdbH+WBfws+2SZOCIkuYTjREGW20HXlJm9ilMRJ
         u9gZ/B7HnByhJ046an+mMKTwEAz5LlovwuI+1jkE/6yxrfJzx0DVmi9CVMTuiljh5COy
         jXn4KvkZoIfC3CsC4h+X0h8nEfLEJgojQ4tOrxQ/H63dFy/uqtyU2svfUprS+Mj7iME/
         +5GQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Lebrun <dlebrun@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 13/47] ipv6: sr: fix scheduling in RCU when creating seg6 lwtunnel state
Date: Thu, 29 Mar 2018 19:59:54 +0200
Message-Id: <20180329175730.075690629@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296131804343440?=
X-GMAIL-MSGID: =?utf-8?q?1596296131804343440?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Lebrun <dlebrun@google.com>


[ Upstream commit 191f86ca8ef27f7a492fd1c03620498c6e94f0ac ]

The seg6_build_state() function is called with RCU read lock held,
so we cannot use GFP_KERNEL. This patch uses GFP_ATOMIC instead.

[   92.770271] =============================
[   92.770628] WARNING: suspicious RCU usage
[   92.770921] 4.16.0-rc4+ #12 Not tainted
[   92.771277] -----------------------------
[   92.771585] ./include/linux/rcupdate.h:302 Illegal context switch in RCU read-side critical section!
[   92.772279]
[   92.772279] other info that might help us debug this:
[   92.772279]
[   92.773067]
[   92.773067] rcu_scheduler_active = 2, debug_locks = 1
[   92.773514] 2 locks held by ip/2413:
[   92.773765]  #0:  (rtnl_mutex){+.+.}, at: [<00000000e5461720>] rtnetlink_rcv_msg+0x441/0x4d0
[   92.774377]  #1:  (rcu_read_lock){....}, at: [<00000000df4f161e>] lwtunnel_build_state+0x59/0x210
[   92.775065]
[   92.775065] stack backtrace:
[   92.775371] CPU: 0 PID: 2413 Comm: ip Not tainted 4.16.0-rc4+ #12
[   92.775791] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1.fc27 04/01/2014
[   92.776608] Call Trace:
[   92.776852]  dump_stack+0x7d/0xbc
[   92.777130]  __schedule+0x133/0xf00
[   92.777393]  ? unwind_get_return_address_ptr+0x50/0x50
[   92.777783]  ? __sched_text_start+0x8/0x8
[   92.778073]  ? rcu_is_watching+0x19/0x30
[   92.778383]  ? kernel_text_address+0x49/0x60
[   92.778800]  ? __kernel_text_address+0x9/0x30
[   92.779241]  ? unwind_get_return_address+0x29/0x40
[   92.779727]  ? pcpu_alloc+0x102/0x8f0
[   92.780101]  _cond_resched+0x23/0x50
[   92.780459]  __mutex_lock+0xbd/0xad0
[   92.780818]  ? pcpu_alloc+0x102/0x8f0
[   92.781194]  ? seg6_build_state+0x11d/0x240
[   92.781611]  ? save_stack+0x9b/0xb0
[   92.781965]  ? __ww_mutex_wakeup_for_backoff+0xf0/0xf0
[   92.782480]  ? seg6_build_state+0x11d/0x240
[   92.782925]  ? lwtunnel_build_state+0x1bd/0x210
[   92.783393]  ? ip6_route_info_create+0x687/0x1640
[   92.783846]  ? ip6_route_add+0x74/0x110
[   92.784236]  ? inet6_rtm_newroute+0x8a/0xd0

Fixes: 6c8702c60b886 ("ipv6: sr: add support for SRH encapsulation and injection with lwtunnels")
Signed-off-by: David Lebrun <dlebrun@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/seg6_iptunnel.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -419,7 +419,7 @@ static int seg6_build_state(struct nlatt
 
 	slwt = seg6_lwt_lwtunnel(newts);
 
-	err = dst_cache_init(&slwt->cache, GFP_KERNEL);
+	err = dst_cache_init(&slwt->cache, GFP_ATOMIC);
 	if (err) {
 		kfree(newts);
 		return err;
