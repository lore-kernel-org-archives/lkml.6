Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvnL/6f7AbqulL6RTqRRR6x2djzH7ENys4YnXzp3BEPTEmvZSLzHn4pAiWv2ydriQEynIn1
ARC-Seal: i=1; a=rsa-sha256; t=1521214046; cv=none;
        d=google.com; s=arc-20160816;
        b=LxtX4YKQmC2RDVpST26Yiwq0vcszF2WmZVQ5B6u03yAfEv0QrqZ2YfxlrPm6BJAKZ9
         BCCrEgEzmrRVQjN5H/DSBSrFUn10BJVsJkn0d2Srf/ZFT2daKuA8c6zAHGMrkyZmaCFh
         1QcDlof5tIw/Q7+Uzv7lt7d3aPmqYhESDNvAon+a2ph6vzxOCfsUROsxagcg+WQwa0Vu
         xUs8xoXvVDF+L48B/NeEo9EP8OcS2EPjwghRviriOO3crvIcGN3WgznI7Qltyq03cbFp
         VxOs5J4p2MHe7x1+HsQWVqt0y4dWn4bgncGDF0SyDKexUGUEBemjeHAUZWvZzeYlAHyO
         sdoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VpslRA0AlsFSB2vl1gDieOtWC9kCkrsa7+rRoL9KKDU=;
        b=YQQDx9rTKAuORVaNk7h4aPJr8Wh3cikUmy/870fmxNJsNqRWzmnte6nAOQv8dxUyGW
         L5NzXAlkRFTzG/bTKG9eRzvxxp1dJFRkprvLAF3hR3rnDretMuto7KQLF4HsJC/+HfKZ
         dsoYaLLge5HLSalwqzK76AKwCceeJeECpLdom5es6vZzfXUCYoUNbfz3Vzzx9iiwwl/v
         YdyZONE8CLKxcQ+OR1XTGrd+uXn06ASVt5R+Vck2bnhsB4H1rkSRlyHHsFJBgaKkV5u0
         65+qTVBa8q8YI/1qRkLam2ntlKTxpIii6+MfMb5yQzEeuw3IFDmzm80Iyl/h899b+guN
         gWTQ==
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
Subject: [PATCH 4.4 22/63] ALSA: seq: Dont allow resizing pool in use
Date: Fri, 16 Mar 2018 16:22:54 +0100
Message-Id: <20180316152302.553681772@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108296499067445?=
X-GMAIL-MSGID: =?utf-8?q?1595108540113884954?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1924,6 +1924,9 @@ static int snd_seq_ioctl_set_client_pool
 	    (! snd_seq_write_pool_allocated(client) ||
 	     info.output_pool != client->pool->size)) {
 		if (snd_seq_write_pool_allocated(client)) {
+			/* is the pool in use? */
+			if (atomic_read(&client->pool->counter))
+				return -EBUSY;
 			/* remove all existing cells */
 			snd_seq_pool_mark_closing(client->pool);
 			snd_seq_queue_client_leave_cells(client->number);
