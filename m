Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x225oFdEFbOvEPc/xwP/fIqM3KcyIiUruk1S/OStSVSzc+CBGMYinIIIieAtyWccusEK/UU/O
ARC-Seal: i=1; a=rsa-sha256; t=1518323637; cv=none;
        d=google.com; s=arc-20160816;
        b=Eu/VqQ7FKPIX4syvEznWS66uHPF1bRZgG5GvAza3VG/Ubn8jok4nuCy1uvHJ+6dP43
         hl7g3TbBSykiL6+GB+f6GVgTMZJfiw5mIBSNSldGdlFjelhuQB73SQnhJk8KLpgPHc3Z
         W/Qg+zHR1XmnnZX2EyunYuCfUBxFIk4gQ0FyKbreSrjc8pZAAQZCv8xi83v1XfXZrIM7
         aHpi4lYaW7MGgOpy9lqRiD9rRYQPJiV33xUtVhszT+oKT0MHrQZwkTWZUxu17LawhR+x
         +ml81P8ZY23unrcR6EVq6JxBmnOMiSdV7xNJHDxt2EDwR9HpvI4WiXNrZW6RF+WZSP3N
         YhIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=xeZ4L5azdYCr7DF9exH1PjZ0Gfr5cqoTWAJ/Y98G/iQ=;
        b=CLquhgp/69ZjQDYDSufVnDtjcMuu5p1Yxio+aV1glBU/+ZOiykV7YZIQQggPpVzwUi
         pXWz9kjbsR2XoPJpi0IsQTEV4MlHUwjHwuVLjgJO1G5iuX8bSGswepLt/ARC8zXaDUHX
         LebXhSeP4keHtUcnVGnJr7koR88cQwCjMoNDXV/f623K7pCJTuziVTKkH1EtqmVOSon8
         mabFSYLOsly17ixlriELQrqY30TAmkwNFEn0pDlYrdo6visSxMKZ5PjGStPg27bYT8jy
         Z/+R6k1twQ0uDQcjZwRIPGlKgd7UoviAynr6QzkZRpUBWm4md4HfaAQRT5Z4wIqnnNuW
         BHew==
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
 "Kees Cook" <keescook@chromium.org>,
 "Luo Quan" <a4651386@163.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Takashi Iwai" <tiwai@suse.de>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.611326538@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 121/136] ALSA: seq: Make ioctls race-free
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592077710316431011?=
X-GMAIL-MSGID: =?utf-8?q?1592077726010752305?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.16: ioctl dispatch is done from snd_seq_do_ioctl();
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
@@ -2200,6 +2201,7 @@ static int snd_seq_do_ioctl(struct snd_s
 			    void __user *arg)
 {
 	struct seq_ioctl_table *p;
+	int ret;
 
 	switch (cmd) {
 	case SNDRV_SEQ_IOCTL_PVERSION:
@@ -2213,8 +2215,12 @@ static int snd_seq_do_ioctl(struct snd_s
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
 	pr_debug("ALSA: seq unknown ioctl() 0x%x (type='%c', number=0x%02x)\n",
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
