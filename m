Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C62C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50FF20815
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oioqjDJS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730897AbeLTLfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 06:35:42 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43735 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbeLTLfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 06:35:42 -0500
Received: by mail-pl1-f196.google.com with SMTP id gn14so747998plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 03:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bZCzQdqxiW2iBUnMGNevk9yTBHQSBSAPpliQf9nIytg=;
        b=oioqjDJS8AXHQHXwxxGpVTe/jYetLW1D4LZCyAVmFf1/Rg0bhXAOo9f5+tDxobKtlz
         DeiLsVe3nghBfTFi18dzNkQZl9DFSQ3oD3xWlb7++D37Tzer8PYib+MnNI8gE8eYHB9O
         ZYn6HQvs6ujXIDp1BV0CDUfKWEYzSAcPqNUSl7s0Br2QDqLUN8tzFhYim0ChmTHDCEQB
         mFnNWpZiqrfBVaNx5ViWpm2cK012MQ1GJ2PpIbTG1Mpw7gdoz2EPiCFpMCLLOo/9LjTH
         2HSVHV1rmKXimijMgOVXQ5a8h1VJ2LHHmT6S14m8Bcetu4FwwggByM8hdGW9/OsTl3Ao
         X5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bZCzQdqxiW2iBUnMGNevk9yTBHQSBSAPpliQf9nIytg=;
        b=fhKLgwpsUxszg0ZoTX0PWVPDs0cGMYpy8VSDjMgdYGg6+UFfJe3Vt6y0vxlV7dpWNo
         tERgU+zu70yK6mS70UALsZhkQ37aYPGIV8FGOcJxkRxsi7zieHA2LDcKrJhVkxQxHIm9
         q9e2ImO22IQ3T4Whf6EebReX0KkShRwDj5vtEMUG0ji46xwwWSTBh54FvQNZd+yRDJnm
         vy5+7sghF5K8l4xc9mGXbTq79DrCmUHS5ypCIsM/n266bPS5kywEBw+o5uEvBuALUNuN
         vwo15/HvMHulXRgHLSkU+yaunZKIi+i6fbfJbz7K8bBEzkBn8YoDSel/xFc8A3mKNY/l
         QEaA==
X-Gm-Message-State: AA+aEWYljZoaaqs8CznI7TG2Ody0jFf0UVEIVSswYuWKSnvla6KeS7+7
        dO5vQrokZJbJD1f6EF9nclo=
X-Google-Smtp-Source: AFSGD/WMH6F33KLwxwCxt3K3d94XiI4gC9HKoaAnIc/1wStZ3M31G9RBnDPoZTGqUrq64hQ+ieWK7w==
X-Received: by 2002:a17:902:28c1:: with SMTP id f59mr23726894plb.37.1545305741266;
        Thu, 20 Dec 2018 03:35:41 -0800 (PST)
Received: from localhost ([175.223.27.218])
        by smtp.gmail.com with ESMTPSA id u69sm44078550pfj.116.2018.12.20.03.35.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 03:35:40 -0800 (PST)
Date:   Thu, 20 Dec 2018 20:35:37 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] printk: increase devkmsg write() ratelimit
Message-ID: <20181220113537.GA701@jagdpanzerIV>
References: <20181218114709.GF7485@zn.tnic>
 <20181218130750.GA665@tigerII.localdomain>
 <20181218142623.GH7485@zn.tnic>
 <20181218145558.GD665@tigerII.localdomain>
 <20181218150313.GI7485@zn.tnic>
 <20181218151455.GE665@tigerII.localdomain>
 <20181218152413.GJ7485@zn.tnic>
 <20181218165217.GA534@tigerII.localdomain>
 <20181218172109.GK15430@hirez.programming.kicks-ass.net>
 <20181218123748.3aadd16c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218123748.3aadd16c@gandalf.local.home>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/18/18 12:37), Steven Rostedt wrote:
> > 
> > Again, complain to system-doofus for printing so much crap to somewhere
> > it should not print to begin with.
> 
> I've been saying that it would be good to make the kmsg be a separate
> buffer that just gets interleaved with the kernel buffer.

Hmm, this is interesting.

> Userspace processes should never be able to overwrite messages
> from the kernel.

I would agree.

It's a bit funny that kernel people first take the patch in and then,
when user-space begins to use the feature, start to object and ratelimit.

By the way, systemd seems to be OK with alternative logging targets

/etc/systemd/system.conf

---
	[Manager]
	#LogLevel=info
	LogTarget=syslog console journal
---

Everything looks fine with read-only devkmsg (running the patched
kernel). "journalctl -f -b" gives a nice system log:

...
 kernel: r8169 0000:04:00.0 enp4s0: renamed from eth0
 kernel: snd_hda_codec_realtek hdaudioC0D0:      Line=0x1a
 systemd-udevd[180]: link_config: autonegotiation is unset or enabled, the speed and duplex are not writable.
 systemd[1]: Started Flush Journal to Persistent Storage.
 kernel: input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1f.3/sound/card0/input7
...


Given how often systemd hits ratelimits (I googled some bug reports),
I wonder if systemd people are still interested in /dev/kmsg logging
at all.


---

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 7b4e4de778e4..6d35115c5629 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -875,7 +875,7 @@ static const struct memdev {
 	 [8] = { "random", 0666, &random_fops, 0 },
 	 [9] = { "urandom", 0666, &urandom_fops, 0 },
 #ifdef CONFIG_PRINTK
-	[11] = { "kmsg", 0644, &kmsg_fops, 0 },
+	[11] = { "kmsg", 0444, &kmsg_fops, 0 },
 #endif
 };
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 829fe6fb098a..48c4ccac9fce 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -770,7 +770,6 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 struct devkmsg_user {
 	u64 seq;
 	u32 idx;
-	struct ratelimit_state rs;
 	struct mutex lock;
 	char buf[CONSOLE_EXT_LOG_MAX];
 };
@@ -788,69 +787,6 @@ int devkmsg_emit(int facility, int level, const char *fmt, ...)
 	return r;
 }
 
-static ssize_t devkmsg_write(struct kiocb *iocb, struct iov_iter *from)
-{
-	char *buf, *line;
-	int level = default_message_loglevel;
-	int facility = 1;	/* LOG_USER */
-	struct file *file = iocb->ki_filp;
-	struct devkmsg_user *user = file->private_data;
-	size_t len = iov_iter_count(from);
-	ssize_t ret = len;
-
-	if (!user || len > LOG_LINE_MAX)
-		return -EINVAL;
-
-	/* Ignore when user logging is disabled. */
-	if (devkmsg_log & DEVKMSG_LOG_MASK_OFF)
-		return len;
-
-	/* Ratelimit when not explicitly enabled. */
-	if (!(devkmsg_log & DEVKMSG_LOG_MASK_ON)) {
-		if (!___ratelimit(&user->rs, current->comm))
-			return ret;
-	}
-
-	buf = kmalloc(len+1, GFP_KERNEL);
-	if (buf == NULL)
-		return -ENOMEM;
-
-	buf[len] = '\0';
-	if (!copy_from_iter_full(buf, len, from)) {
-		kfree(buf);
-		return -EFAULT;
-	}
-
-	/*
-	 * Extract and skip the syslog prefix <[0-9]*>. Coming from userspace
-	 * the decimal value represents 32bit, the lower 3 bit are the log
-	 * level, the rest are the log facility.
-	 *
-	 * If no prefix or no userspace facility is specified, we
-	 * enforce LOG_USER, to be able to reliably distinguish
-	 * kernel-generated messages from userspace-injected ones.
-	 */
-	line = buf;
-	if (line[0] == '<') {
-		char *endp = NULL;
-		unsigned int u;
-
-		u = simple_strtoul(line + 1, &endp, 10);
-		if (endp && endp[0] == '>') {
-			level = LOG_LEVEL(u);
-			if (LOG_FACILITY(u) != 0)
-				facility = LOG_FACILITY(u);
-			endp++;
-			len -= endp - line;
-			line = endp;
-		}
-	}
-
-	devkmsg_emit(facility, level, "%s", line);
-	kfree(buf);
-	return ret;
-}
-
 static ssize_t devkmsg_read(struct file *file, char __user *buf,
 			    size_t count, loff_t *ppos)
 {
@@ -998,9 +934,6 @@ static int devkmsg_open(struct inode *inode, struct file *file)
 	if (!user)
 		return -ENOMEM;
 
-	ratelimit_default_init(&user->rs);
-	ratelimit_set_flags(&user->rs, RATELIMIT_MSG_ON_RELEASE);
-
 	mutex_init(&user->lock);
 
 	logbuf_lock_irq();
@@ -1019,8 +952,6 @@ static int devkmsg_release(struct inode *inode, struct file *file)
 	if (!user)
 		return 0;
 
-	ratelimit_state_exit(&user->rs);
-
 	mutex_destroy(&user->lock);
 	kfree(user);
 	return 0;
@@ -1029,7 +960,6 @@ static int devkmsg_release(struct inode *inode, struct file *file)
 const struct file_operations kmsg_fops = {
 	.open = devkmsg_open,
 	.read = devkmsg_read,
-	.write_iter = devkmsg_write,
 	.llseek = devkmsg_llseek,
 	.poll = devkmsg_poll,
 	.release = devkmsg_release,
