Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48y/LglDs1tdeiZEntmMvOHWuQTNtyh8TZRtilePU8e/9NcW4tP915Cd+ccKdKeQ1q5s8kS
ARC-Seal: i=1; a=rsa-sha256; t=1524405784; cv=none;
        d=google.com; s=arc-20160816;
        b=pP0xv+Sqyj8vR3GwIo9j16RTOFuYb8SDtn09AQUDTaUob6O00wUiHvN7/41V2GXpwP
         n/L1j2kP1aUxvdIwdOCav8EseBSgJFm1AQwvio789zhTJjM3qZL8GktKguru7BNjrBlQ
         TYxy2boL02w2eCxA2vtC5MUsGCfwLmWxObziwKRkNyDz9t/XFfkk1geLONxbg+XRyU24
         +NwyAeEsyXKP8jEpoOO/V2nKSwnAdQJH1ZehzHVqOfBIM1ZXrDP0bqL0bmotC1fTJ2yE
         lcoudC1O2lD4mEhApC6MTQFxfw7yXOwH3MkVCJUTbQOsIquZAjX2eScAWy55mwpt0VR1
         tlmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Yj14zskGKYfxGAcBzNisLRHkbS/KBVj8mj/Bq5lF/Ps=;
        b=w3kZfGIZ9+0m9H8NmZnwghxNMMwDF2emJ2p6LEQUfrqRwp/5pDkZ2U/XJfAL9Z3yhO
         MQLRTfT2V5jdKbg9Cblu1p8EQOzUdo0Gw0hl6dKgsOa3bmVJZ/+vsN1Bmq3l6HC1a8yL
         yyoxG1BHs9KQwkcyqm7g+AS565uzsBMJ0WK2kREJFpqy/WwnSwfpahN37qFdr9OoLdOp
         6F+V2YyuyGu+HJCp1pyYaJWLBlSD5J3G5BTKQAzVeNZiWNarKODvxb/7jeNt41gY9cS2
         eRhuKHnSHASAEO57gaRLHdz1agGSZgHgAjhPw5fk12FsZ5iUaQu50AOsSzy7cHfJK+TG
         PVbA==
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
Subject: [PATCH 4.16 192/196] autofs: mount point create should honour passed in mode
Date: Sun, 22 Apr 2018 15:53:32 +0200
Message-Id: <20180422135114.183092879@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455319452829195?=
X-GMAIL-MSGID: =?utf-8?q?1598455319452829195?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
