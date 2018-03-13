Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv2xONXf1jUSUD5mkL5NFFRTYggacEPY8V99SOFQ2oA29SXEjFpDHLNAt1BLGH0jb9FYZl2
ARC-Seal: i=1; a=rsa-sha256; t=1520955158; cv=none;
        d=google.com; s=arc-20160816;
        b=KeUPu4hj+8DrNcoI8tlS9sw0TRcBWak1ujbybCM9O793XPLCZF+DxvGWoSB51MakFF
         Qh2t90/8ptMbXlH6uAxnvq00ZHZT7HktmsLlgekv5JX7j01StkIgdM6vTwwT2uEWNIcx
         cfwd2JCC/h7zS9tty6dIjYmSwd7x/gEn//18awQqtH6r7xmz/DXHCz95Q4woCPfopiXH
         jdO1GNRmqf1LKjj1lB86dmk9MFbM54SAwKmvGXFJGiZU6Q2hmkMefxHHsw8ttAA0PaXl
         adsM1b8HOAgUI4TihFmV0+QFghUPes041USfB2GuZVSwAVfzyRi8OM9Rm234V2xg28rl
         Veqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=muiWVM/8avRqGZge6boG4JGqnWzA9gUb08dTn90cNxw=;
        b=yQUavsMkPqQ/fCUQPkcbVjk0JCPEG1qaNuAyZVierrIYJI9/ytCXBUV9BrMDIHYNmd
         ah/1ARRn+0c5xBjDNAPwZyin23a/UDKWA31jkOqL1pKkxFq0kM0ryjjQv7nQPTEVkUmH
         1H7YTwuHBN2zfRz8m9Si54j4CDRFEF6CsAIuUGzxlCrnCEsP0Tb+GjQV0jm/tRoQl0nj
         vJbLaW8WNY4NehCd+ujboB8tyPRmP/fgO+KIoH87pwRwxL8pq4fTOLKrdE2PT24IQi2o
         uqIOnqkYBfu1EGb4fLv/PbWaf6FcCEQP2LGKJCyOjb9Yj7yMkgoP2vDTcBRSLvnwOIDX
         AjEA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+03218bcdba6aa76441a3@syzkaller.appspotmail.com,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH 4.15 109/146] netfilter: ipt_CLUSTERIP: fix a race condition of proc file creation
Date: Tue, 13 Mar 2018 16:24:36 +0100
Message-Id: <20180313152328.815536418@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837076516274876?=
X-GMAIL-MSGID: =?utf-8?q?1594837076516274876?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

commit b3e456fce9f51d6276e576d00271e2813c1b8b67 upstream.

There is a race condition between clusterip_config_entry_put()
and clusterip_config_init(), after we release the spinlock in
clusterip_config_entry_put(), a new proc file with a same IP could
be created immediately since it is already removed from the configs
list, therefore it triggers this warning:

------------[ cut here ]------------
proc_dir_entry 'ipt_CLUSTERIP/172.20.0.170' already registered
WARNING: CPU: 1 PID: 4152 at fs/proc/generic.c:330 proc_register+0x2a4/0x370 fs/proc/generic.c:329
Kernel panic - not syncing: panic_on_warn set ...

As a quick fix, just move the proc_remove() inside the spinlock.

Reported-by: <syzbot+03218bcdba6aa76441a3@syzkaller.appspotmail.com>
Fixes: 6c5d5cfbe3c5 ("netfilter: ipt_CLUSTERIP: check duplicate config when initializing")
Tested-by: Paolo Abeni <pabeni@redhat.com>
Cc: Xin Long <lucien.xin@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Reviewed-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/netfilter/ipt_CLUSTERIP.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/net/ipv4/netfilter/ipt_CLUSTERIP.c
+++ b/net/ipv4/netfilter/ipt_CLUSTERIP.c
@@ -107,12 +107,6 @@ clusterip_config_entry_put(struct net *n
 
 	local_bh_disable();
 	if (refcount_dec_and_lock(&c->entries, &cn->lock)) {
-		list_del_rcu(&c->list);
-		spin_unlock(&cn->lock);
-		local_bh_enable();
-
-		unregister_netdevice_notifier(&c->notifier);
-
 		/* In case anyone still accesses the file, the open/close
 		 * functions are also incrementing the refcount on their own,
 		 * so it's safe to remove the entry even if it's in use. */
@@ -120,6 +114,12 @@ clusterip_config_entry_put(struct net *n
 		if (cn->procdir)
 			proc_remove(c->pde);
 #endif
+		list_del_rcu(&c->list);
+		spin_unlock(&cn->lock);
+		local_bh_enable();
+
+		unregister_netdevice_notifier(&c->notifier);
+
 		return;
 	}
 	local_bh_enable();
