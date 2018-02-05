Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226oDmZFpnDBefFRDqf8hyIEb1sdiNvt2k82lRVS5iN2jXFQvJMkNRyt9Nbh6VpgXDnBr6Ew
ARC-Seal: i=1; a=rsa-sha256; t=1517855207; cv=none;
        d=google.com; s=arc-20160816;
        b=E4IpxjAqVCv3MHGmzeHjnWZ5IBtaI1Gb2VgKKH7GrVmIt8m07Jmj0/2C5EiRqyUoEH
         GgmotI+DhDVX6UbICMBW3lwFAGBRntq607FGQFBfRzPYiT4WglQlucc6wU+K2d+3fPyk
         tUxMQO40SdW75z3zy356yH7QsqqyuH1nr0yGhMMNxacfTFnoTTzI9Y3YUJt1+LV+R9bB
         Mm9wuWy8fCJK7ioNzJr0AFwbCfyGrudJ0xQjMDyrb18tVF28IOj1SHzkUriPJoffKgoV
         lu9RWBKM0vOIpmo6cCkuUfmL79OZDH9BXJMypEJI+ZvjPSRmA3pXL1YYf1D3KcdvO5zT
         GBZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1rMCqWie0ZtnSd3HzOA+KjQO3mcvZBFeDd8Vmv8ACys=;
        b=xFqp1sMgKfgPlz3Y48VFPAVzJAdfqn4EojJpSUgjhKbCPnv6ZrwLv9lOElGYwTQddc
         G+NS+uBrEdMUQh5Hq6lwm/uytvreWmCO4ZiSjjgsZFljw0OVy9oq8zaKYh9RatqmwMpW
         aO/r08kZg0ht69iR+SuOnqJYJBHpw2PwhGUCKPkQkgOqcaneuFifkIDm759uVGaOAXrr
         Xr6r3mw35YasSUKZGtSVzuLnRvYQFvOJuFNRbMsiAbvHmF01OoyrPxMSqjsW+m1W5VWB
         xniursaHLSMuYn+bTnlzPIO7l0peTPfmVOBaOpHN9KBs/odr4JGJiN4xIwhwyEwDHCei
         aIwg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Luo Quan <a4651386@163.com>,
	Kees Cook <keescook@chromium.org>,
	Takashi Iwai <tiwai@suse.de>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 3.18 06/36] ALSA: seq: Make ioctls race-free
Date: Mon,  5 Feb 2018 10:23:34 -0800
Message-Id: <20180205182352.043115245@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586542382367716?=
X-GMAIL-MSGID: =?utf-8?q?1591586542382367716?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 4.4: ioctl dispatch is done from snd_seq_do_ioctl();
 take the mutex and add ret variable there.]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

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
