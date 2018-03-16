Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu0AegdgA8q4VXC70X+aA6tQgw7OE+WCcJc5JXqY8ilbsc1aA3MRgRvlmKEGpy0qpNEO8m7
ARC-Seal: i=1; a=rsa-sha256; t=1521214268; cv=none;
        d=google.com; s=arc-20160816;
        b=xosvd8MtxXFQndC6cMvjA7eMHYPOfxKXfNOMlowgbC/lHDNT1pBW8BWjW/Elvvsl97
         Tplee0rNepBEMneYR52c86B/L73NwlUeCMbXk3cfLCfuHYteIZkNBqQZOTUA19vD0otR
         a9m13f+LnmE0cAwg+CDiLM+/Abv/H4goBSUxuU2xb3MHfCuR98rvTk87sHnA2n9pEAPy
         FB1WvDACzz6XN+fX7gOo/Pk7q9lIxn8k+wIhf10KCfy86PUh8+sEKyPWO/eWSqyKCqNi
         04ae4dE3POhztX1cqXCqcWzqjqQb9jBIjXhHzUh8mACAqeuptUBzfOSs9MTnKsR7tNal
         0+fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8UvWQd5B2C3QXIH18xLmAgHVcZBQJiUFrYh4huFMgnQ=;
        b=fBqKZ1LCMPXUe5ormBQBuGCU/Mr+hnJHp2Xn1ku96TQYFsxKg5kExi/9rT4LcQoGB+
         x+Aaf5Za18uv5WLxc0zjfK2TITciCzsAEocd1bd3eMx/moYuG8LBNH9igThRyy9uAXV8
         tDJxkgGbYyzaQ/7SNltVHmXXSVg6C90t0hDmcp5vF9PmGgsNQ4DTqEUrBTW16Kade6BV
         c/O3SWwDdcTNoKitO8lzRnn+TldrQNmHP/hvietEmcVoEAla7E1PUeTssaJDwRQ3Sy8J
         nnTLTEGaT/Xy6ki1sKHWAvIY4uwjNNx5U+rkjKvsgDTXJdi92+bIuCdSOBKtW3XjeY6Z
         PmQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?=E8=8C=83=E9=BE=99=E9=A3=9E?= <long7573@126.com>,
	Nicolai Stange <nstange@suse.de>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 34/86] ALSA: seq: Dont allow resizing pool in use
Date: Fri, 16 Mar 2018 16:22:57 +0100
Message-Id: <20180316152319.689117628@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108296499067445?=
X-GMAIL-MSGID: =?utf-8?q?1595108772834900598?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit d85739367c6d56e475c281945c68fdb05ca74b4c upstream.

This is a fix for a (sort of) fallout in the recent commit
d15d662e89fc ("ALSA: seq: Fix racy pool initializations") for
CVE-2018-1000004.
As the pool resize deletes the existing cells, it may lead to a race
when another thread is writing concurrently, eventually resulting a
UAF.

A simple workaround is not to allow the pool resizing when the pool is
in use.  It's an invalid behavior in anyway.

Fixes: d15d662e89fc ("ALSA: seq: Fix racy pool initializations")
Reported-by: 范龙飞 <long7573@126.com>
Reported-by: Nicolai Stange <nstange@suse.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/seq/seq_clientmgr.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1835,6 +1835,9 @@ static int snd_seq_ioctl_set_client_pool
 	    (! snd_seq_write_pool_allocated(client) ||
 	     info->output_pool != client->pool->size)) {
 		if (snd_seq_write_pool_allocated(client)) {
+			/* is the pool in use? */
+			if (atomic_read(&client->pool->counter))
+				return -EBUSY;
 			/* remove all existing cells */
 			snd_seq_pool_mark_closing(client->pool);
 			snd_seq_queue_client_leave_cells(client->number);
