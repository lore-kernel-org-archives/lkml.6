Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751727AbeBBHWn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 02:22:43 -0500
Received: from a.mx.secunet.com ([62.96.220.36]:44400 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751579AbeBBHWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 02:22:37 -0500
Date: Fri, 2 Feb 2018 08:22:34 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Dmitry Vyukov <dvyukov@google.com>
CC: syzbot <syzbot+e1a1577ca8bcb47b769a@syzkaller.appspotmail.com>,
        "David Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: stack-out-of-bounds Read in xfrm_state_find (4)
Message-ID: <20180202072234.knjilchejpb6uudo@gauss3.secunet.de>
References: <001a1148251a36716f0564148ba9@google.com>
 <20180201083418.rfarzrodccdy54xx@gauss3.secunet.de>
 <CACT4Y+a1DEqBWSXvVC+=pV_J_aMnof3Ky5W5t1FpwiCHZUTqJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACT4Y+a1DEqBWSXvVC+=pV_J_aMnof3Ky5W5t1FpwiCHZUTqJA@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 1C617599-0AF3-4398-92D9-7079867A4870
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 11:30:00AM +0100, Dmitry Vyukov wrote:
> On Thu, Feb 1, 2018 at 9:34 AM, Steffen Klassert
> 
> Hi Steffen,
> 
> Please see the email footer:
> 
> > If you want to test a patch for this bug, please reply with:
> > #syz test: git://repo/address.git branch
> > and provide the patch inline or as an attachment.

Thanks for the hint, I've overlooked this. This is very usefull
for the case that I can not reproduce the bug, but I think I know
how to fix it.

There are two more cases that come to my mind where syzbot could
help.

1. I can not reproduce the bug and I don't know how to fix it,
   but some debug output would be helpfull:

   syz test-debug-patch-and-send-dmesg-output: git://repo/address.git branch

2. I can not reproduce the bug and I have absolutely no idea what it
   could be:

   syz bisect: git://repo/address.git branch commit a commit b

I don't know if this is possible, but it would bring the bugfixing
process a bit coser to the case where a real user does a bug report.


#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


Subject: [PATCH RFC] xfrm: Refuse to insert 32 bit userspace socket policies on 64 bit systems

We don't have compat layer for xfrm, so userspace and kernel
structures have different sizes in this case. This results in
a broken confuguration, so refuse to configure socket policies
when trying to insert from 32 bit userspace as we do it already
with policies inserted via netlink.

Reported-by: syzbot+e1a1577ca8bcb47b769a@syzkaller.appspotmail.com
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
