Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49yQoQPO5hxC3VAIhT9Mho2i0BjRiwPYxgtvfoERcvg1KZsG/ymflQM54WPbBnNJQAG0qyX
ARC-Seal: i=1; a=rsa-sha256; t=1524406221; cv=none;
        d=google.com; s=arc-20160816;
        b=uQyrBXiM3djY55kskF/hDTRrnt2O/P652PRxrQYVhahX8AfpYLjvsi1urUWRcys7fa
         6pdP/wo0GJivIAM5ABYTsg1Q1kO8tUnq2W/GxrTfxz47jaOlQjyAJQnW2e3kpppsmq0o
         dfaKcv0Np1kqlO2a8puJ+Oe3ZvTNLN9KlNzlXosjSSgbwfkqugD58lC70JSDA9vZ+jil
         w/+COEePj6TSoQDuxjMtJlF/0HSKaPhf1CQLulMtcfjCFLcFccN6euhVPdMOtQVbqbwW
         Mwtf8Fab2eSiPR4xubFOu7Kw668PZjuaJo9PFGsZdGiqEk7+lyOIYQP7h1bN20quIyxs
         3fEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7w2afgKWmBqlJNRH9eUUR4hSEDA4yjRAEvkghhfiHiU=;
        b=s5eJPnR1SUcR1/54+EVx/4gCITNUUIXK7hu/0mAbubpDKskkrjXCPJIrTDY/i6QF0i
         zpngQrAjHaU5Qbb9Yp+AU/ojCIKDO/vgVnPTYZ41yjAjuhkfAevEr70NtG47Ih4tL+zv
         OB4Czo4iNz+lnx/zQRJ2yxU055UAV90ls18EW47IBesg3kR5wmAngeqPvZVwWh+mYtwB
         aKSDpJW4VVolzKBgsvKew9yf3AUQvjK+tRyXD9qqYIIeb0+N0uqmzGQYKW+If1qf3Kt7
         6IL6SIcVwGu8Un2NIL07pL0eR7lL1+TnJTg4BRQZDpxmNK48S2RUqu56imjTPbIQOlse
         1big==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 157/164] autofs: mount point create should honour passed in mode
Date: Sun, 22 Apr 2018 15:53:44 +0200
Message-Id: <20180422135142.022131370@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455319452829195?=
X-GMAIL-MSGID: =?utf-8?q?1598455778424542129?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Kent <raven@themaw.net>

commit 1e6306652ba18723015d1b4967fe9de55f042499 upstream.

The autofs file system mkdir inode operation blindly sets the created
directory mode to S_IFDIR | 0555, ingoring the passed in mode, which can
cause selinux dac_override denials.

But the function also checks if the caller is the daemon (as no-one else
should be able to do anything here) so there's no point in not honouring
the passed in mode, allowing the daemon to set appropriate mode when
required.

Link: http://lkml.kernel.org/r/152361593601.8051.14014139124905996173.stgit@pluto.themaw.net
Signed-off-by: Ian Kent <raven@themaw.net>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/autofs4/root.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -749,7 +749,7 @@ static int autofs4_dir_mkdir(struct inod
 
 	autofs4_del_active(dentry);
 
-	inode = autofs4_get_inode(dir->i_sb, S_IFDIR | 0555);
+	inode = autofs4_get_inode(dir->i_sb, S_IFDIR | mode);
 	if (!inode)
 		return -ENOMEM;
 	d_add(dentry, inode);
