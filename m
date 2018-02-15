Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226zVNk/UaGUcc8DjsxWH7msi36Yptt5aAOVdsUxzU3jKgl4JY5K5AkcimFC34kiWcNgWVV9
ARC-Seal: i=1; a=rsa-sha256; t=1518708415; cv=none;
        d=google.com; s=arc-20160816;
        b=aQzXhbwmwseOo4Yh+m+396z2O22ojcEUW62/jO8YWuiujwdN0hUesrBvXIc0rQmkpk
         8ANMJ2azSNNQtGBRI35EL+OmlUKvJXmdyxqfuf9I8PHQU/smRpHijg2xwRrC8I0yWYo4
         zA3WYXoFf9nXYLV0Wee7uE9Im0s4AEc9CNQ4a2iEkfebNkTizbqMrj9PXybTZLxLNkwt
         UtB/bMOD1RJytJdXlJJN8EFOeDIPBgBzHgWBTzbXzveIGz8oltJZYNvQ58Qx9pPeBigO
         E9F+2IH9aMIuQGgCynkKQ9Raqv/rXkTr/aD9m5TB74Kf936Cv6o27lWMiSRhE6sfhq3o
         iB9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Bv00ad9DCKZfh3Q+4gTFTRQaQCYhg0PU99Ntixrj5BM=;
        b=ge79naFe4gfZz1hPyHbEr9u63Ryz6PJ+r9xjYGdXrpty43GEMNfI31Ag85eZDAW3wU
         jt0qI30pKG40pdH81OMrKFRKj+Wx0b8GtpUXgy6rhfXOOaYPrDeRLPrevMLQW63K4cJ2
         tXm/rhAP90MG81m8L58e5hrzn3tfs0rECSyyCbPyme0jwURwGP9Ul0r55BecK5wCOtRE
         iIKcxs4D2eG2/cAJUBFLkJHQ4AcAq+H6IaNypxTSc/Rllsi9MyCx+rEXNZPerRu5Qo/q
         oFbECMEiObNqL77KJO5zv1PfOrJWq+m/+SdniYiqHuNaBAuAy9dTmmL0FZS8umY1DmEI
         j7qg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrey Konovalov <andreyknvl@google.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 4.9 35/88] nsfs: mark dentry with DCACHE_RCUACCESS
Date: Thu, 15 Feb 2018 16:17:02 +0100
Message-Id: <20180215151227.488773470@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480998844566928?=
X-GMAIL-MSGID: =?utf-8?q?1592481195805163420?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

commit 073c516ff73557a8f7315066856c04b50383ac34 upstream.

Andrey reported a use-after-free in __ns_get_path():

  spin_lock include/linux/spinlock.h:299 [inline]
  lockref_get_not_dead+0x19/0x80 lib/lockref.c:179
  __ns_get_path+0x197/0x860 fs/nsfs.c:66
  open_related_ns+0xda/0x200 fs/nsfs.c:143
  sock_ioctl+0x39d/0x440 net/socket.c:1001
  vfs_ioctl fs/ioctl.c:45 [inline]
  do_vfs_ioctl+0x1bf/0x1780 fs/ioctl.c:685
  SYSC_ioctl fs/ioctl.c:700 [inline]
  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:691

We are under rcu read lock protection at that point:

        rcu_read_lock();
        d = atomic_long_read(&ns->stashed);
        if (!d)
                goto slow;
        dentry = (struct dentry *)d;
        if (!lockref_get_not_dead(&dentry->d_lockref))
                goto slow;
        rcu_read_unlock();

but don't use a proper RCU API on the free path, therefore a parallel
__d_free() could free it at the same time.  We need to mark the stashed
dentry with DCACHE_RCUACCESS so that __d_free() will be called after all
readers leave RCU.

Fixes: e149ed2b805f ("take the targets of /proc/*/ns/* symlinks to separate fs")
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Eric Biggers <ebiggers3@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nsfs.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -90,6 +90,7 @@ slow:
 		return ERR_PTR(-ENOMEM);
 	}
 	d_instantiate(dentry, inode);
+	dentry->d_flags |= DCACHE_RCUACCESS;
 	dentry->d_fsdata = (void *)ns->ops;
 	d = atomic_long_cmpxchg(&ns->stashed, 0, (unsigned long)dentry);
 	if (d) {
