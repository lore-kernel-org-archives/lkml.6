Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtoU0t7vcSxRlV0KjdMTMxD2u4nl56ymHHgd3+/e7tBmo0/XNoBiEHK7Xl3TRI7sg0HbI2d
ARC-Seal: i=1; a=rsa-sha256; t=1521800254; cv=none;
        d=google.com; s=arc-20160816;
        b=BtVTsrHxIS8Y0QA5EC3jOMEIEhQLJZy1lpN/X6niP9eXYxtAfmvhitGFYlyBoM26RI
         UVCRR60Gxneusjjg9qfqNX/xD644r6zMtFWWyAD5hSRNC+WxbhLpwUD64c5dYEkRKirq
         p0UwOZN3kc3MhBOatUKeD5ngtVSDyv46ASTtMLFNzZ1oE4Pd8bdU3NmrcS4cEKUGFH6f
         wHHVvTIymrsRJ4csx2SwEDfJGtDiAr5o82IJpTEVycNfQU26oBTMu7c/hYnxMANyiUoY
         fZPBpm58JoRKcQxVShN92/EH0SX8Kvml9Tq40jLdKi7MICW8AOr5tC32ggRRzqegIflL
         HCVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=e1V961cJs7u3WhR/VJ3+SvL7gqjgqcyxWlawoWEcOsM=;
        b=U2+lJzL3ifn0OF3c7xlTtW8t4X0VQX3DDYYCF71quFD3xp7gRHZLhtkrqrwSGYwXVz
         TyRd37ROePVfTR143epyldf2wtH/4bLIjTwA1bndGi0c+WX+Yi77rs5g+lldruNYQUYT
         x/+SsLlqbB+Zy0ZFtvjNf/h8zRmnMHZmDMu/TvQe68UweyTanINKGx9hbc44qXsk1VFp
         mcWrim5WLqSa6qCNX+DjpKCXSomE9msR9XB3FuO9O8y0LEr1w8akGWuevK1nkkOft7dk
         PTYAS6GbcxjgJtFxKRI2N9JhQvWuLDvLWzmQW7wS//RZjzYpSUC/PNAnVJr6NE6tsiLh
         txgg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sahara <keun-o.park@darkmatter.ae>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 88/97] pty: cancel pty slave port bufs work in tty_release
Date: Fri, 23 Mar 2018 10:55:15 +0100
Message-Id: <20180323094202.424498916@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722017335116713?=
X-GMAIL-MSGID: =?utf-8?q?1595723223906962805?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sahara <keun-o.park@darkmatter.ae>


[ Upstream commit 2b022ab7542df60021ab57854b3faaaf42552eaf ]

In case that CONFIG_SLUB_DEBUG is on and pty is used, races between
release_one_tty and flush_to_ldisc work threads may happen and lead
to use-after-free condition on tty->link->port. Because SLUB_DEBUG
is turned on, freed tty->link->port is filled with POISON_FREE value.
So far without SLUB_DEBUG, port was filled with zero and flush_to_ldisc
could return without a problem by checking if tty is NULL.

CPU 0                                 CPU 1
-----                                 -----
release_tty                           pty_write
   cancel_work_sync(tty)                 to = tty->link
   tty_kref_put(tty->link)               tty_schedule_flip(to->port)
      << workqueue >>                 ...
      release_one_tty                 ...
         pty_cleanup                  ...
            kfree(tty->link->port)       << workqueue >>
                                         flush_to_ldisc
                                            tty = READ_ONCE(port->itty)
                                            tty is 0x6b6b6b6b6b6b6b6b
                                            !!PANIC!! access tty->ldisc

 Unable to handle kernel paging request at virtual address 6b6b6b6b6b6b6b93
 pgd = ffffffc0eb1c3000
 [6b6b6b6b6b6b6b93] *pgd=0000000000000000, *pud=0000000000000000
 ------------[ cut here ]------------
 Kernel BUG at ffffff800851154c [verbose debug info unavailable]
 Internal error: Oops - BUG: 96000004 [#1] PREEMPT SMP
 CPU: 3 PID: 265 Comm: kworker/u8:9 Tainted: G        W 3.18.31-g0a58eeb #1
 Hardware name: Qualcomm Technologies, Inc. MSM 8996pro v1.1 + PMI8996 Carbide (DT)
 Workqueue: events_unbound flush_to_ldisc
 task: ffffffc0ed610ec0 ti: ffffffc0ed624000 task.ti: ffffffc0ed624000
 PC is at ldsem_down_read_trylock+0x0/0x4c
 LR is at tty_ldisc_ref+0x24/0x4c
 pc : [<ffffff800851154c>] lr : [<ffffff800850f6c0>] pstate: 80400145
 sp : ffffffc0ed627cd0
 x29: ffffffc0ed627cd0 x28: 0000000000000000
 x27: ffffff8009e05000 x26: ffffffc0d382cfa0
 x25: 0000000000000000 x24: ffffff800a012f08
 x23: 0000000000000000 x22: ffffffc0703fbc88
 x21: 6b6b6b6b6b6b6b6b x20: 6b6b6b6b6b6b6b93
 x19: 0000000000000000 x18: 0000000000000001
 x17: 00e80000f80d6f53 x16: 0000000000000001
 x15: 0000007f7d826fff x14: 00000000000000a0
 x13: 0000000000000000 x12: 0000000000000109
 x11: 0000000000000000 x10: 0000000000000000
 x9 : ffffffc0ed624000 x8 : ffffffc0ed611580
 x7 : 0000000000000000 x6 : ffffff800a42e000
 x5 : 00000000000003fc x4 : 0000000003bd1201
 x3 : 0000000000000001 x2 : 0000000000000001
 x1 : ffffff800851004c x0 : 6b6b6b6b6b6b6b93

Signed-off-by: Sahara <keun-o.park@darkmatter.ae>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/tty_io.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1694,6 +1694,8 @@ static void release_tty(struct tty_struc
 	if (tty->link)
 		tty->link->port->itty = NULL;
 	tty_buffer_cancel_work(tty->port);
+	if (tty->link)
+		tty_buffer_cancel_work(tty->link->port);
 
 	tty_kref_put(tty->link);
 	tty_kref_put(tty);
