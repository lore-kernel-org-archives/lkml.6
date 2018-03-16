Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt6JHGCp53NiVPHpdsj1MCa7hrnY7A5eAvJkaBJR6IibDa4A1XTpuiKzviTJlBUajF+EaXA
ARC-Seal: i=1; a=rsa-sha256; t=1521213813; cv=none;
        d=google.com; s=arc-20160816;
        b=mKftqFR3LzaUmmnlDO0Wmtn3PDEbmRt34FVCf0n/soyjrUTbexdWxJawa4oD2NbJ9J
         OgeakwtvDaUqcjUJ5Hgu3amzihPLDnKQ4MZK2C8o1WMgoawIN36KJ181C2dcj2lumh6X
         mDdU+9NEF/2fX2rDlmJ2FbNDMWGgxzACSI74c+0JvwStuSz3wonjziFCtRhVBdQDFzIH
         Ud5Z2wSvPxBf+LFOrcpwfh/elSOtl9+cXUn0XCQDdnk71+OLKvEIMLvWX+p2NlyXI64l
         PCbif/X7GoTcw3yZhoB81cqLliPm5OXpMOjZ+AjFy3ecOETl8F6es7C7Qg11cU2YJV8V
         OjQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NXLNQusVcGXlCtosWL7GcgRjM9A5nNEIBYnHidHBVBA=;
        b=KkcJFkOJsuAyK2Y9zhTs0KlvufK8rdHo6Hzp+5KkEMEkm1kSKb+4xuNrJp4nz5GR5X
         0CIOFjvwTrALHeM631ULFyJeANr9sfAMed6D0ZJHz+nG7PUypFGulnXcVepZQ81AW4EB
         d3B5WFPF2JAi6GYgftRPSAYebNHEHe2fWSO14Q9huNAOQKlk4NggG+YgLGFausykTALA
         vTDE7GtIEU4lPVXhrIkT2GFa45kRuD/gXlnb+ih1r3eNfwNkokAwdt5ulRM6bRKsJOQf
         rn+k160pZf00CnTFqGFwGUXQC8JkG+IeLde30m8Hu1ApSzpOT4cBbzf1M433mWQg3+ou
         lWlg==
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
Subject: [PATCH 3.18 05/25] ALSA: seq: Dont allow resizing pool in use
Date: Fri, 16 Mar 2018 16:22:52 +0100
Message-Id: <20180316152232.980168335@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152232.750180431@linuxfoundation.org>
References: <20180316152232.750180431@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108296499067445?=
X-GMAIL-MSGID: =?utf-8?q?1595108296499067445?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1929,6 +1929,9 @@ static int snd_seq_ioctl_set_client_pool
 	    (! snd_seq_write_pool_allocated(client) ||
 	     info.output_pool != client->pool->size)) {
 		if (snd_seq_write_pool_allocated(client)) {
+			/* is the pool in use? */
+			if (atomic_read(&client->pool->counter))
+				return -EBUSY;
 			/* remove all existing cells */
 			snd_seq_pool_mark_closing(client->pool);
 			snd_seq_queue_client_leave_cells(client->number);
