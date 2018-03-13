Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs+yFVE090zMNdXNOrEEf68YBhurCBjv6CKGeDcr+9iYytjnkuiCHkZYvPgblh8SNMmFd99
ARC-Seal: i=1; a=rsa-sha256; t=1520955322; cv=none;
        d=google.com; s=arc-20160816;
        b=EFQMQcaijlAFFY5cB2kTlt4Uch+fRECR7kxSVusy5HoAeFmR16b+E51kWKDS2PRs4n
         lGL67u81LHMn3z8RIIj/EkD/1aDwGmiaelw8o61L4dCuZF9OTHktzpAplVXynAZw4CaF
         CFNA1srSiQiqY3QHZksqfQw9C//uKsFZEmVIeFRfnMaprBDwNjf2Jj2V5Up3KPA3J3S0
         i/k3AUwDJ8sfC2+masdgf/S9iaC3f7RgkcmEaVwqUf8tQFRwDTeyW8fGldfhr84ZTGnY
         /q1qBpli8dJRUGnYtHxADjENZp6ka76s/O9feKSuiyegeRXV47bYlLHZFMxgkAo2/OVE
         Estw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BuKetAszhdWL0BFzucOfWdQQic/cU2B55877HErNGhE=;
        b=V89E86ZRkUfSMw+F8CIDNY6Sg6B848q069XY7K1mbsOm5AVMqj4O7XRVyyW82arDX0
         I2Pn3PJtGIYo0Su/PsGkPXu3jKHOn978mDjbgcQfo3RdjchL9KbUzY2Ma975cpE1nLlw
         H2JjmTMxvsk1nXmXggidiZa9uWbNdX7ymozqOiC5JllMc6NVnWwDa18UnQ0NfysHmIhu
         lTVJTz9DN2f4pWyLU/F/4cv3bfkk8wUg8zv7YB5/RsEhH+VqzCv1JsB0fS/Dx6nk3CV+
         W003iLBkaSig403ZJaVh3jv6KL6M79wA/JXc5Ia8JVa+K/lw0kVyDZCKAO4v/GMC7+8f
         KhQw==
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
Subject: [PATCH 4.14 010/140] netfilter: ipt_CLUSTERIP: fix a race condition of proc file creation
Date: Tue, 13 Mar 2018 16:23:33 +0100
Message-Id: <20180313152458.810866282@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837076516274876?=
X-GMAIL-MSGID: =?utf-8?q?1594837247593495530?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
