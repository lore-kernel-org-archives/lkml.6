Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvgLX2twTJ8cfDswvDtq4A7MfllRmV5/E1Ira3G42tiaZ7rEwskzs/qnceQdszlA0zBl9kI
ARC-Seal: i=1; a=rsa-sha256; t=1520955616; cv=none;
        d=google.com; s=arc-20160816;
        b=LMWW3ZNUREc3nRMH0PHkufjmzUiVm9AX0Pk1BOMvnoDgg60y0T7ZXDlV7bG8vkGICe
         bewwFM/EH6g8+DVNNe2MyzhW/YSUj0gbMWjSeWc80rJDEYMO/FbO2Krl5dtrWaXuRoOv
         M47oHoaW7pusSO7hPJYS2v7dX9CvLyvcwPBOBHkr2Sdn2Dg+3RlCfpo4CbilW66UIQBZ
         QvwLnEqTz2nTYJpZoMJSR/6kz6xy5mrS7hpdtXWTO98VglnE+7jla8rFBSBCC075+KNC
         2zHLEYPHnVoeq64Jik3wQxe4O8tO9h9GK0OtdVd2FZ/ED3ypCoAVWRLRgnRaxfI0RiLM
         om5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ycH8jAUk0mBA2TPxRlCME4u5YcVehyy2Hck2z2FPz/0=;
        b=TUtHTPF9Wm6qSwM7Hmls8FaIU93g++M124h8pg33Bigb+I+ikr2WUfVC4LAahrWe9H
         uNdWbgNjGt7k4WIKtorVmzT3wrrx4Xk9mw7+xmRLQDbKKKLvoZ2UYxsAYJ2qPrTpVhQP
         GaE075q3J/o91Mqeoi6+SwoHxc9ZVYf8tRAAgpxca/z88bsmmioxgOWYpgxxODfnoeP/
         GjIPZzKf6FtXC9Z3TtAtEW91uVnR9pVNqOCSGKr2ZaFytQA2j1IQGScuVYsAY9OTimni
         mUX93e0Ex+5Bk8lNqb431xiMf1kTN1FXu81aeErYgiSwE+FkEB+jWzxxrxEcChUuFvVV
         PI7g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?=E8=8C=83=E9=BE=99=E9=A3=9E?= <long7573@126.com>,
	Nicolai Stange <nstange@suse.de>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 106/140] ALSA: seq: Dont allow resizing pool in use
Date: Tue, 13 Mar 2018 16:25:09 +0100
Message-Id: <20180313152505.261594111@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837043077835045?=
X-GMAIL-MSGID: =?utf-8?q?1594837556809337482?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1834,6 +1834,9 @@ static int snd_seq_ioctl_set_client_pool
 	    (! snd_seq_write_pool_allocated(client) ||
 	     info->output_pool != client->pool->size)) {
 		if (snd_seq_write_pool_allocated(client)) {
+			/* is the pool in use? */
+			if (atomic_read(&client->pool->counter))
+				return -EBUSY;
 			/* remove all existing cells */
 			snd_seq_pool_mark_closing(client->pool);
 			snd_seq_queue_client_leave_cells(client->number);
