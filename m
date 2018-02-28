Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELsCTn8sZv2L3FehsWbGhkKzza725gRyrRZSPif8Yo/ssbvPcz0AAIDrJkKQtzoASOOJ5H+x
ARC-Seal: i=1; a=rsa-sha256; t=1519831332; cv=none;
        d=google.com; s=arc-20160816;
        b=xB5T9lSxqEvUbxVSN2Us8jLWNDr4Ic+0fnPq4HrQw4hro9c9j62w6oVg+mAlRFdpfl
         TOriSzo0TmykNlXA4558CFjg6o0zo82OG00Z4rPB4GQqWYk4VBlSANvlvCaS0llG4XXX
         c9Cby2fwEvtmXGy/i0Rv86UHg7vnJfHK+25Ez9q6uMxS2x68nB7jA+msZwiLUTZkcw9D
         uT7mWWrDBuXLg/VFneuMgPAwlKLT2vhoHSWFjWfKkPUa1uoyQNwtS1b0lDyxbhHop25O
         K7q91u7wB2TAM6XlHV8a9qPtXZm86VCwu6rvUv5d2QQfRZfRdsb0Iwtw6bjiGuQov+eJ
         ETVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=WVR6M3y5bx7IMlwZBgJ3kHqAJT0eLT8UDzqLkdTsNdQ=;
        b=DRTZD1VdX4FbAmJi8JyVY3Fwrl/kF/Ws0RMkEkzdDK/OP2RnjXQ/8Pm/pgLE1ayDXR
         vmZLsAB0a86m4URDCvIc/VyAqLL1cx0ECKXPJRw8yxhoaZQkZqSYWp6XQDzTgtr3Qk3T
         LLyoYNu4QZtROJF4Zefn/KrcgkhiMyWx1V8r0kteJgHDVHc+Ll4OB22pOAq3skY8giWB
         Ckzk0G/83feSrUcWQPnoAlAb7+ZdXoMlwCKdyGYg/ncCeYII1r0l3hQJOYbxjmIIF9sF
         YAlOLcY3Xa8WmoqY2d6jdMbHr94CgNPOlv5Ky64Vx2YLKjcEDtr3BsTo4JG1zxf2dcLS
         5Nmg==
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
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.690096961@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 001/140] ALSA: seq: Fix regression by incorrect
 ioctl_mutex usages
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593658658692902793?=
X-GMAIL-MSGID: =?utf-8?q?1593658658692902793?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

This is the revised backport of the upstream commit
b3defb791b26ea0683a93a4f49c77ec45ec96f10

We had another backport (e.g. 623e5c8ae32b in 4.4.115), but it applies
the new mutex also to the code paths that are invoked via faked
kernel-to-kernel ioctls.  As reported recently, this leads to a
deadlock at suspend (or other scenarios triggering the kernel
sequencer client).

This patch addresses the issue by taking the mutex only in the code
paths invoked by user-space, just like the original fix patch does.

Reported-and-tested-by: Andres Bertens <abertensu@yahoo.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/seq/seq_clientmgr.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -2189,7 +2189,6 @@ static int snd_seq_do_ioctl(struct snd_s
 			    void __user *arg)
 {
 	struct seq_ioctl_table *p;
-	int ret;
 
 	switch (cmd) {
 	case SNDRV_SEQ_IOCTL_PVERSION:
@@ -2203,12 +2202,8 @@ static int snd_seq_do_ioctl(struct snd_s
 	if (! arg)
 		return -EFAULT;
 	for (p = ioctl_tables; p->cmd; p++) {
-		if (p->cmd == cmd) {
-			mutex_lock(&client->ioctl_mutex);
-			ret = p->func(client, arg);
-			mutex_unlock(&client->ioctl_mutex);
-			return ret;
-		}
+		if (p->cmd == cmd)
+			return p->func(client, arg);
 	}
 	snd_printd("seq unknown ioctl() 0x%x (type='%c', number=0x%02x)\n",
 		   cmd, _IOC_TYPE(cmd), _IOC_NR(cmd));
@@ -2219,11 +2214,15 @@ static int snd_seq_do_ioctl(struct snd_s
 static long snd_seq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct snd_seq_client *client = file->private_data;
+	long ret;
 
 	if (snd_BUG_ON(!client))
 		return -ENXIO;
 		
-	return snd_seq_do_ioctl(client, cmd, (void __user *) arg);
+	mutex_lock(&client->ioctl_mutex);
+	ret = snd_seq_do_ioctl(client, cmd, (void __user *) arg);
+	mutex_unlock(&client->ioctl_mutex);
+	return ret;
 }
 
 #ifdef CONFIG_COMPAT
