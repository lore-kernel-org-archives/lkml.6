Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751955AbeBAIe0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 03:34:26 -0500
Received: from a.mx.secunet.com ([62.96.220.36]:37718 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751542AbeBAIeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 03:34:21 -0500
Date: Thu, 1 Feb 2018 09:34:18 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: syzbot <syzbot+e1a1577ca8bcb47b769a@syzkaller.appspotmail.com>
CC: <davem@davemloft.net>, <herbert@gondor.apana.org.au>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: stack-out-of-bounds Read in xfrm_state_find (4)
Message-ID: <20180201083418.rfarzrodccdy54xx@gauss3.secunet.de>
References: <001a1148251a36716f0564148ba9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <001a1148251a36716f0564148ba9@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 2BB93A50-9C1A-41AB-9C7C-554B61C614EF
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 07:58:01AM -0800, syzbot wrote:
> Hello,
> 
> syzbot hit the following crash on upstream commit
> 72906f38934a49faf4d2d38ea9ae32adcf7d5d0c (Tue Jan 30 21:04:50 2018 +0000)
> Merge branch 'x86-hyperv-for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> 
> So far this crash happened 4 times on net-next, upstream.
> C reproducer is attached.
> syzkaller reproducer is attached.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.
> user-space arch: i386

Looks like we forgot to refuse to insert socket policies
when userspace is 32 bit and kernel is 64 bit. We do this
already for policies inserted with netlink because we don't
have a compat layer for xfrm. This means that userspace
and kernel structues don't match, leading to broken
configurations.

I don't have 32 bit userspace on 64 bit machines, so I
can't test this myself. Can you please test this patch:

Subject: [PATCH RFC] xfrm: Refuse to insert 32 bit userspace socket policies on 64 bit systems

We don't have compat layer for xfrm, so userspace and kernel
structures have different sizes in this case. This results in
a broken confuguration, so refuse to configure socket policies
when trying to insert from 32 bit userspace as we do it already
with policies inserted via netlink.

Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index a3785f538018..25861a4ef872 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2056,6 +2056,11 @@ int xfrm_user_policy(struct sock *sk, int optname, u8 __user *optval, int optlen
 	struct xfrm_mgr *km;
 	struct xfrm_policy *pol = NULL;
 
+#ifdef CONFIG_COMPAT
+	if (in_compat_syscall())
+		return -EOPNOTSUPP;
+#endif
+
 	if (optlen <= 0 || optlen > PAGE_SIZE)
 		return -EMSGSIZE;
 
-- 
2.14.1
