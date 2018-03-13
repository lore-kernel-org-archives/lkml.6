Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtCpq7yZSTKST7AGFjqyWurEKBMP6NqjLDsBSTDK4MjLNYnzIoIpPOEeKKvfhkHR0b8VpPs
ARC-Seal: i=1; a=rsa-sha256; t=1520955127; cv=none;
        d=google.com; s=arc-20160816;
        b=Pnk7YNP0eIQNmwbQ/9fyYqRF/2UpKb+Am/x0KTeb69XP3S+o3t1pc1lq+3aLJOKlqq
         neYEietfjcN43kSIces+YNvwoBTyLMTUSjVqAKIc3yPTcUHRCouLkPdMOH2DlCcOhl6S
         BWoj/vOUH1hHtQduD/uOvklQ2tdr5B7/xROqVCYYTEW8fIAeKHa5CNFaQx+njfZ7uSlB
         vdfZdNkNxqS/zyuOGbLcZwrQGJ3Vq10BL8e8VNhxRBi/3SFcn3UEDb4A6TssSVkjn1K2
         2o3wmTY24Y/mqIv+eneutLxhqoSBzVW+DvlfOlhYqBS/d4F1Ky9Q1TdCUX+tcADA/lhH
         PkvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JtJxmmDLb6QFsMgnTTEVWnCK7ZOadCOec1Q6LlqdGZw=;
        b=C3OF9T8AYgONYrXiStdmE0abonal++369bt2AimMtL00cWCVUJ2xr4XLQNjvNjfWCC
         /4YorrMJHBU7BUqxpT32CZbQjv4sW59qI5Q2GAJpTM69BoHjYTVwwOA241MHFS3lENOG
         8Kgj+UuFdB9/PwF8pUjVXhfci+qUSxQLHC+GuNhTq49lriz4hFwIBnYAuLs66JLamOCp
         zGeCRmY7RODGC7CoezC+3Yq/d5vWcYXkKHg3nRhrrp5RKgP9XlzW104fVu/TOZLfIPF9
         U3zv/3iUNgumxhl+Lmg75bjgElF6lXDzPEkRmVf0tTjEbW6cwWVcoyGJZnjX9kFrfFb4
         V8Yw==
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
Subject: [PATCH 4.15 071/146] ALSA: seq: Dont allow resizing pool in use
Date: Tue, 13 Mar 2018 16:23:58 +0100
Message-Id: <20180313152326.219194796@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837043077835045?=
X-GMAIL-MSGID: =?utf-8?q?1594837043077835045?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1838,6 +1838,9 @@ static int snd_seq_ioctl_set_client_pool
 	    (! snd_seq_write_pool_allocated(client) ||
 	     info->output_pool != client->pool->size)) {
 		if (snd_seq_write_pool_allocated(client)) {
+			/* is the pool in use? */
+			if (atomic_read(&client->pool->counter))
+				return -EBUSY;
 			/* remove all existing cells */
 			snd_seq_pool_mark_closing(client->pool);
 			snd_seq_queue_client_leave_cells(client->number);
