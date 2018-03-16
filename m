Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvfsiKlIdG0VHWUOd9rL7ejh+Mw1adbevYVsu7RIVQ1Ml+8MMGSSFvXqoa7z+3L8qPGriZv
ARC-Seal: i=1; a=rsa-sha256; t=1521214571; cv=none;
        d=google.com; s=arc-20160816;
        b=BCf0YWfgo1gHRYe6hLksHwAWCut4dt9yD1B7Mov/4icz+ohrujufkRdPVHPH+RoMYm
         rjM79OdLtlh+riQYamRRjR71KGkZW0I7mAJNjAuanc8hGnr7MHZ9UQoTnpE+YjmPavvN
         Has0l7mT0ViYC3AWgCjXxxNY8Ar9wLP/vQ4BbFDyylNgJhbcMnSRXAKOLpgcdjLKKODQ
         rSx9YV9iMqhruqFumQpfQ2i7NW9vtZQ6LyMoh6YnCNPOPuuRbLquez/oGD9SWPuGlJVn
         QHKBKjj2FOdQtPCXXUwCrd5CWUDdE/OPtNeibzY+2oBZJ0Q3fWfuw7+/0VqZ8efk16yb
         X/7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Uz6UCUCMVHrky2aMmTpUd1/7de4sESoNCEx9jd4iGAg=;
        b=VJaNL9ML4MRi60eWI/c0DLl3pIob4MOczDk8l6PI3HdndSQPlCpSat+gJ+NgDEIwx8
         arwPrd7fAwVYbuTpJ3FOqTFekSA36LXUjHUW2Wq5Qs6qDsIQyuowID5tAm2jkUDUw0Z1
         SucLEl7cgK3a+kKouJE0xl5m+yD+TFOvOnkw++ixIvhWJIdwFhannk3E/x8XLY77mbCk
         OJ+Bd+uMnbg1RfUEt7cSjzRuheNVdCKOqXBObmTxPY13nWONIzwkO+rbCXyR5ZmmPHEp
         IuKdDdN4LkOVSCytYWddswJ/eGhwS/0HqojbE9RiXiEONSHzS3eV8fyO0cQXJNshUuhg
         pgmw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 053/109] userns: Dont fail follow_automount based on s_user_ns
Date: Fri, 16 Mar 2018 16:23:22 +0100
Message-Id: <20180316152332.845764016@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109090594701612?=
X-GMAIL-MSGID: =?utf-8?q?1595109090594701612?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Eric W. Biederman" <ebiederm@xmission.com>


[ Upstream commit bbc3e471011417598e598707486f5d8814ec9c01 ]

When vfs_submount was added the test to limit automounts from
filesystems that with s_user_ns != &init_user_ns accidentially left
in follow_automount.  The test was never about any security concerns
and was always about how do we implement this for filesystems whose
s_user_ns != &init_user_ns.

At the moment this check makes no difference as there are no
filesystems that both set FS_USERNS_MOUNT and implement d_automount.

Remove this check now while I am thinking about it so there will not
be odd booby traps for someone who does want to make this combination
work.

vfs_submount still needs improvements to allow this combination to work,
and vfs_submount contains a check that presents a warning.

The autofs4 filesystem could be modified to set FS_USERNS_MOUNT and it would
need not work on this code path, as userspace performs the mounts.

Fixes: 93faccbbfa95 ("fs: Better permission checking for submounts")
Fixes: aeaa4a79ff6a ("fs: Call d_automount with the filesystems creds")
Acked-by:  Ian Kent <raven@themaw.net>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/namei.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1133,9 +1133,6 @@ static int follow_automount(struct path
 	    path->dentry->d_inode)
 		return -EISDIR;
 
-	if (path->dentry->d_sb->s_user_ns != &init_user_ns)
-		return -EACCES;
-
 	nd->total_link_count++;
 	if (nd->total_link_count >= 40)
 		return -ELOOP;
