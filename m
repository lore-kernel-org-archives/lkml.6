Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvSAekrjLSHKvJ5IJe6WyEL9K7Gv5MLnTZwHzCRURMDTvsynZ7Z6j7ZVAkJ/j8IyKGSw/93
ARC-Seal: i=1; a=rsa-sha256; t=1521214920; cv=none;
        d=google.com; s=arc-20160816;
        b=LBhpABlmVvomQhifYVi2y3dr7FqIZyjP9RcJfalcl4IVeErJ/sOtLI2rjCAhjU9uZO
         dfI//uKtF8vjkM+I9iSyOC/jZ1tzgSy6DpTi584AH2N+0qwLxJUHG1O8B2mc1Y4eYNZG
         m+pT7WHXYfez/S5MfdPv0GVHNEL55GOXrvr6GhxoZMp9tUkveyikhrHXPS/cDQC5uPc0
         riEUIZ2b5TUPcAHh/1Q4/fdG1Q8MCUIPCFLGQT4SGW9rIIbsP8yzy628VcXZF5KxSmSM
         ulVL4oBMhTsDnYi1CctZNVav2oBqKS4OZicARWHbvjTHIvsmTJZYyhyRz1+aQ0JoKmt5
         x4DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SexQPr8ffgAcYf34Iq4p/9YegS7+HgjgdJ+jO4KIxKo=;
        b=rP8DgwtSoalYOR+N6knS4rktXcgFvJVyhzvIqWCP53aGjyiPx5Rw/9Rc+e2HmALR/H
         7DawbPOic1YbREThyPCwtIazsvY3vYfI8pau5PDC8qmeoNftryTObmcLb/IOgnvW9aaQ
         9qbI8W2vkDar+kCl6/VfrH6fOdeSeMRFRU0dCQG6GdfN1TEWkdOfpt1FOhzqEL5NvL0W
         aFUGH8i39tJZaT8noOKlgVVev/tMEfnuIZetf7fOJdkDtVVO8IsrYn8B4cIaxmlYvq5L
         uXZSNQ8IZZ7Je0zwsQXiqoWwk40zBYBHXYN7NckpUnzhLITH+pQ3mRvEng1hKVNv0wnV
         x34Q==
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
Subject: [PATCH 4.15 064/128] userns: Dont fail follow_automount based on s_user_ns
Date: Fri, 16 Mar 2018 16:23:25 +0100
Message-Id: <20180316152339.965605773@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109090594701612?=
X-GMAIL-MSGID: =?utf-8?q?1595109456470016958?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
