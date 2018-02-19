Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752344AbeBSN5T (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 08:57:19 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47884 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751528AbeBSN5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 08:57:17 -0500
Message-ID: <1519048631.2870.25.camel@redhat.com>
Subject: Re: BUG: sleeping function called from invalid context at
 net/core/sock.c:LINE (3)
From: Paolo Abeni <pabeni@redhat.com>
To: Jon Maloy <jon.maloy@ericsson.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+749d9d87c294c00ca856@syzkaller.appspotmail.com>,
        Ying Xue <ying.xue@windriver.com>
Cc: Andrei Vagin <avagin@virtuozzo.com>,
        David Miller <davem@davemloft.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Florian Westphal <fw@strlen.de>, LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        "roman.kapl@sysgo.com" <roman.kapl@sysgo.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tipc-discussion@lists.sourceforge.net"
        <tipc-discussion@lists.sourceforge.net>
Date: Mon, 19 Feb 2018 14:57:11 +0100
In-Reply-To: <BN6PR15MB155309E2A35F66298DAD8E2E9AC80@BN6PR15MB1553.namprd15.prod.outlook.com>
References: <001a1143e44e58485f05655fa8ae@google.com>
         <CACT4Y+bxubQ0yqi777mgQdT6paPS+wWQo79T+jPqztPJ=gTYhw@mail.gmail.com>
         <b6b1e370-d3ba-4db7-228f-a3ccaf502992@virtuozzo.com>
         <BN6PR15MB155309E2A35F66298DAD8E2E9AC80@BN6PR15MB1553.namprd15.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-02-19 at 13:23 +0000, Jon Maloy wrote:
> I don't understand this one. tipc_topsrv_stop() can only be trigged
> from a user doing rmmod(), and I double checked that this is running
> in user mode.
> How does the call chain you are reporting occur?

tipc_topsrv_stop() is called also at net namespace destruction time:

static void __net_exit tipc_exit_net(struct net *net)
{
	tipc_topsrv_stop(net);
#...

I *think* the following should fix the issue, but I'm unsure if it's
safe.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git master

---
diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index 02013e00f287..63f35eae7236 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -693,9 +693,9 @@ void tipc_topsrv_stop(struct net *net)
        }
        __module_get(lsock->ops->owner);
        __module_get(lsock->sk->sk_prot_creator->owner);
-       sock_release(lsock);
        srv->listener = NULL;
        spin_unlock_bh(&srv->idr_lock);
+       sock_release(lsock);
        tipc_topsrv_work_stop(srv);
        idr_destroy(&srv->conn_idr);
        kfree(srv);
