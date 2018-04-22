Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/SC48wrL3v+0IMoYDselPfF3jotb37I57VVe5F/1BL4FYXbmAODz3l8AdTVTYsz4l+W4Jd
ARC-Seal: i=1; a=rsa-sha256; t=1524406495; cv=none;
        d=google.com; s=arc-20160816;
        b=nspZpkiqmUwGX+7JRWWtlUxVTddstXxn0p47x+ufYKo37hbEK2cn2DUQt/I158I4NE
         sr+Yeb9rV/V4cLQjld8klAy4IFsl8u+S6MGUu8tGr9LiXJp1VJlxs5q7G5FXOlQE6v2N
         ebouf63fQf7Iy9uLTzzG0PRswg64apcEcOZADkEyORz47VusvbN1C+2fiyzGBl9Z3PmQ
         2CO5m0vYtlAKawUNrX5+N1Lt+0zui8DFYs3+Of2Syk5FBa6slja/V9Yg0Q+EFFwzT12X
         6IdRLqpCzV8KHEILPM1xafZHGnOsYfb/WiLk0f2aQg/hY41Z1fPitzSGDzvcHDFt3J/b
         wvFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=upzuxZzo7QRNgqgw9UwmoXMkA9K4FKkNO2RFb4FpwZY=;
        b=gn6KnGytIiAmsSLu74Wl630LFLap4HaTDEHlNcKWSWGlEqZvUU8xwe05e8yCIaYmR7
         JjrxYiGAC59KVFFcTq5/NUuGeYCYMSTqwHLqyh8QOm0457fuefwjXthHj5uspj/yUAk3
         zJzx+1fHr5PwbYl3jykJFUwtys3wJxeSDQx/jq4ZoePVCZJe+cT5D8kEjMZCz/eSCXlL
         ZM3Vr3qWO0U9tvkMXNcsC7oOxEsqC0EOPUdu5SwXdNRNem5bCnwlogE6I/KvSVr3shdd
         M3km4VnY7791XGQ1iKd+L+sgeM+Lh63aERKBhg66ncJsaHyM7uvgMWHIWp0oMBhHe5ro
         BTow==
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
Subject: [PATCH 4.9 91/95] autofs: mount point create should honour passed in mode
Date: Sun, 22 Apr 2018 15:54:00 +0200
Message-Id: <20180422135214.147188186@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455319452829195?=
X-GMAIL-MSGID: =?utf-8?q?1598456064879034568?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -746,7 +746,7 @@ static int autofs4_dir_mkdir(struct inod
 
 	autofs4_del_active(dentry);
 
-	inode = autofs4_get_inode(dir->i_sb, S_IFDIR | 0555);
+	inode = autofs4_get_inode(dir->i_sb, S_IFDIR | mode);
 	if (!inode)
 		return -ENOMEM;
 	d_add(dentry, inode);
