Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/tJn/TXxYCrPg7LDuZXQTeFQRoq0Y58lUfjNCrIyb3QaFfLlTOPHqlciuUYGPWX+Ry3gRV
ARC-Seal: i=1; a=rsa-sha256; t=1524405583; cv=none;
        d=google.com; s=arc-20160816;
        b=OU8SnAKZl36C/cao4mlk+bnbOWs+uu8s2Ey22ODP0rd9gW9c4CtgFFDz2d2RWkvKSn
         2+SjNgLQpLRZkYHvF5fmKxru7Cntc+m0AYHppR6tra7b0Wi/WAlcO2lkp4mXtDJX5Axf
         Y6WUYk1ZtSC74Z6Wir5fgt/orAzR2eOenrZfuC8At68lgxVLVFxFGVX7VaiDhgIZrcvD
         XOmXr9e0GCjshScf09R7FScaPt5UlQIb6Z0jZIecNNMZbGGyPQgpZrh37r404CW9mpLu
         Vvkd++gJhTYupc5B+GwmeFVO+i4xxThzS4emC9ZW47dw+tDm7xF56MneTsjRvRLK+DRL
         jkvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+wu+htEJc56IAHtqghAdLDbOnDspHpA7GDloDIMgSt0=;
        b=EYhRpPmui32vVOtpi21vFv+k2Uj41h37+9BNOzhx3d87g7IH9cKlfF6FfnS1dsiRXk
         +RT+kcmjQ60aG3hBYSE2OWlZy43dX+gPk5UVKWUysxSSv1p0o13xxE+K/jEYJWFgCmi/
         XTXdg0k1mThLQbbxR2k5ODqTWsz7rwlDkLCOhxKAv8yj0JS1ig/dlPEFAF37MHKU8JK9
         qCRPM/EE6aLR6tR9vpuKLzIkBmDZY5Y7/kgPneVgnE7x9+6WT55gG8n4QUbOb8YRgY3D
         kN8Noq14rsrj+p++l6gPHEuYe+HvqPnCYsPZdiy8wXfkjLsTs/GYBAhFlxPscGg5YjYJ
         IObQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.16 086/196] ext4: eliminate sleep from shutdown ioctl
Date: Sun, 22 Apr 2018 15:51:46 +0200
Message-Id: <20180422135108.748190074@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455108516709851?=
X-GMAIL-MSGID: =?utf-8?q?1598455108516709851?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit a6d9946bb925293fda9f5ed6d33d8580b001f006 upstream.

The msleep() when processing EXT4_GOING_FLAGS_NOLOGFLUSH was a hack to
avoid some races (that are now fixed), but in fact it introduced its
own race.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/ioctl.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -497,10 +497,8 @@ static int ext4_shutdown(struct super_bl
 		break;
 	case EXT4_GOING_FLAGS_NOLOGFLUSH:
 		set_bit(EXT4_FLAGS_SHUTDOWN, &sbi->s_ext4_flags);
-		if (sbi->s_journal && !is_journal_aborted(sbi->s_journal)) {
-			msleep(100);
+		if (sbi->s_journal && !is_journal_aborted(sbi->s_journal))
 			jbd2_journal_abort(sbi->s_journal, 0);
-		}
 		break;
 	default:
 		return -EINVAL;
