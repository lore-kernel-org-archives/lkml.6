Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x224bW7/D5+binUUbT5V77gRr4FVhJ1SOVk1hOHCTWzJTdf3GWjldZy+5M89/tdZUVBBmA2J7
ARC-Seal: i=1; a=rsa-sha256; t=1518323622; cv=none;
        d=google.com; s=arc-20160816;
        b=su+Cq/My75KbDURhYYXme+PcQ+Nk9Kd8m8EfH06A5tgkx/WGfxuiLLqzna9NE9n3Et
         Wl8uBky4S6CXGejTo11E1qcys34oND4rbgIEmj2VGYHI9r2E0x2eUs9AO2ZvuWY6LNG4
         tavuxaklNraAYRV9+pJ5avJ/7xPvtZaivAmY4ucFQAfmGJ6NtJun+ZByzZ0TyoZnLDHg
         fDVCJ+WMaa52Q1S8u+5Hdoc6a+EzDbhuT3pQldBSzrjWDN/m/YHZh/DAZDBQrgy7LR5y
         L5ieFU+uJi2VU4dLjowqPn3PHTsSTUgGaDOEU+xO78A/YAnpQ+1j7HSwPow+J/5neyoH
         6brw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=PYYdXhr7+ju1Z8tP74DwCtpkWj1WtxVC4xT8V9hq5Ag=;
        b=sL+NoSf39HrMnZsDw7a1VWxO3iQw8Qh5L6HBqh3xzzV1QI2LgPUAOcpXUTvbvc5Ezu
         o6Eo6TrpB81gYeFNDthDWnnN4xrE5MgvpB4PuNYVkiQYcW4YT25uIKp6OybiA104zLO+
         03t9OpWxosLxnYpbX/jeNjmbpPLzMzuHAFtY7k+XT53No059soMgYfSGsh3SN7KPfdy5
         yciMIUdHmuOPHU2scyVJYNWfhb8DEF+B3ydqX4qODDMpuyGJz5X6ow7WDZc533xvGM+I
         4rQyNgZ2YXCVIsBQ7dsDC6sDQtFuSiVKCBabU0ivHWw+CsSq5Xu2P8NH0aoazcemO1Ux
         mWxw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Takashi Iwai" <tiwai@suse.de>,
 "Luo Quan" <a4651386@163.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Kees Cook" <keescook@chromium.org>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.135220295@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 69/79] ALSA: seq: Make ioctls race-free
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592077710316431011?=
X-GMAIL-MSGID: =?utf-8?q?1592077710316431011?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit b3defb791b26ea0683a93a4f49c77ec45ec96f10 upstream.

The ALSA sequencer ioctls have no protection against racy calls while
the concurrent operations may lead to interfere with each other.  As
reported recently, for example, the concurrent calls of setting client
pool with a combination of write calls may lead to either the
unkillable dead-lock or UAF.

As a slightly big hammer solution, this patch introduces the mutex to
make each ioctl exclusive.  Although this may reduce performance via
parallel ioctl calls, usually it's not demanded for sequencer usages,
hence it should be negligible.

Reported-by: Luo Quan <a4651386@163.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[bwh: Backported to 3.2: ioctl dispatch is done from snd_seq_do_ioctl();
 take the mutex and add ret variable there.]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/seq/seq_clientmgr.c |   10 ++++++++--
 sound/core/seq/seq_clientmgr.h |    1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -236,6 +236,7 @@ static struct snd_seq_client *seq_create
 	rwlock_init(&client->ports_lock);
 	mutex_init(&client->ports_mutex);
 	INIT_LIST_HEAD(&client->ports_list_head);
+	mutex_init(&client->ioctl_mutex);
 
 	/* find free slot in the client table */
 	spin_lock_irqsave(&clients_lock, flags);
@@ -2188,6 +2189,7 @@ static int snd_seq_do_ioctl(struct snd_s
 			    void __user *arg)
 {
 	struct seq_ioctl_table *p;
+	int ret;
 
 	switch (cmd) {
 	case SNDRV_SEQ_IOCTL_PVERSION:
@@ -2201,8 +2203,12 @@ static int snd_seq_do_ioctl(struct snd_s
 	if (! arg)
 		return -EFAULT;
 	for (p = ioctl_tables; p->cmd; p++) {
-		if (p->cmd == cmd)
-			return p->func(client, arg);
+		if (p->cmd == cmd) {
+			mutex_lock(&client->ioctl_mutex);
+			ret = p->func(client, arg);
+			mutex_unlock(&client->ioctl_mutex);
+			return ret;
+		}
 	}
 	snd_printd("seq unknown ioctl() 0x%x (type='%c', number=0x%02x)\n",
 		   cmd, _IOC_TYPE(cmd), _IOC_NR(cmd));
--- a/sound/core/seq/seq_clientmgr.h
+++ b/sound/core/seq/seq_clientmgr.h
@@ -59,6 +59,7 @@ struct snd_seq_client {
 	struct list_head ports_list_head;
 	rwlock_t ports_lock;
 	struct mutex ports_mutex;
+	struct mutex ioctl_mutex;
 	int convert32;		/* convert 32->64bit */
 
 	/* output pool */
