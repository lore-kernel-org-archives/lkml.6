Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtrf5HhvmzSrOc6XTdj4cSuYFKNBvnS0O5alIPKK3rB+KhWwVZdFnEZR94r91gvByIJSB4e
ARC-Seal: i=1; a=rsa-sha256; t=1519981467; cv=none;
        d=google.com; s=arc-20160816;
        b=n79S7Nace/iMK6AzZOBaQe4CfyCxVKLp3DeTHSTe7tvl9MJYN3rNj7XEtiIGWpCIq7
         IMz9jZKqzhwwSSsKech4G9pajXaIjUWzYcVgw6EqjOwclqPiocslNTNolAHkxGrc2D94
         XME6VmMHRR9T+wd7mM8KW01twZELtXiXjKT1e2bT6Nw15coqP3s2Gt3t5bgbpUAmZYi+
         vINxZEM2yczzYWCK3Q8TEOxG9SR3oOGoEWxAgaWpTauk4FYVpVjTcMSRyJsqaw+y87p9
         kStZdUTSNAok6AYvK/xOW57weA+8zK2IJjtNQB9XDGMcYv2UoUJVa34jbH3/XdJMB2iP
         M4bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IRhZEC2QKmEMozRqAsjDp8rrildZvYsuHm+2WBW07SA=;
        b=FQkIg5Zehaon8i1fROZI84rwbVDc8MBN+G5TNeEGytAuNhiq0cQnOzdK+lSS9fqhbG
         3Cz6o7iKcsuEVZAfzaqOlXDNxKPsa/HYUtmYA2WkQz9oyz0xg+4VUO+GQU4zZ8Hfqsyi
         xBV6RPECkIKJdus82tTcFVrUeWIPjyCNbH32K8hK3L+P0SL7Lg7VtDBkKWHSiNugRg4n
         rOkRK1oX1wOaUDuXnDZBf9fLt/IIP0p+tL35szhasrXo7HjNjWdUAQMo6Y+uPETLvC6g
         MtJ0ihUzpRQoyxcOf4dm45CzKqu0DQsSJYLnK/UT872epMZwagERykcH5/LXfeTGldWX
         8uOg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	David Howells <dhowells@redhat.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 065/115] afs: Fix missing error handling in afs_write_end()
Date: Fri,  2 Mar 2018 09:51:08 +0100
Message-Id: <20180302084506.501337925@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593816087580422158?=
X-GMAIL-MSGID: =?utf-8?q?1593816087580422158?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>


[ Upstream commit afae457d874860a7e299d334f59eede5f3ad4b47 ]

afs_write_end() is missing page unlock and put if afs_fill_page() fails.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/afs/write.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -282,7 +282,7 @@ int afs_write_end(struct file *file, str
 			ret = afs_fill_page(vnode, key, pos + copied,
 					    len - copied, page);
 			if (ret < 0)
-				return ret;
+				goto out;
 		}
 		SetPageUptodate(page);
 	}
@@ -290,10 +290,12 @@ int afs_write_end(struct file *file, str
 	set_page_dirty(page);
 	if (PageDirty(page))
 		_debug("dirtied");
+	ret = copied;
+
+out:
 	unlock_page(page);
 	put_page(page);
-
-	return copied;
+	return ret;
 }
 
 /*
