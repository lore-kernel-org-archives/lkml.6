Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+NsMLOY0h5klNChzROIsK3WvgYXYGCszqMMw7q5UxKDDLern65iu61tZ35gXylixN0TyFB
ARC-Seal: i=1; a=rsa-sha256; t=1524406746; cv=none;
        d=google.com; s=arc-20160816;
        b=H9H7kdbjvHbhyOEviTf5qg6CgoVC3Q1XiUPBSNbFbXCzoJJjl2P9KnXosVc3OMFD1P
         VfuVj7pQ5JAEKXFEUWybxFJBf9PMkpg8A3kS0P9hZqoYdUQP8ADYVY0RIC33/a7ilWvC
         cFYK3TRpqXJa5uPBb9j4rIqR5zxTh+4CXutf+ow2SQu89bbC6IV0fu70w/2vKSIz6DwA
         isgAcZvaM5BgJOtNzyjXD+EwAxS5edzUJhUs0LbNzm00ifP238ft0HxNK43nRgCf2b1V
         UiRlyPxEfMW8psXxiR5fHbGwQQgCOYgdNvVjiyn/4ope+Wy+P9wJdikaarByypb16k2c
         rYlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Y0EUWVkC2+vewSGBSNybENDg7fBEQLLSwCsL1c07giI=;
        b=Y4ZyWxdzDGNHkU7YK6KIyA/ecwFFP3CXQNLONV6Tptps8UNxHvAAuqidGzMc8ZOD8l
         CGhOovKkOpWQjaH7jLlqtTZmzrOq5/6rNQjQGvdnnDUPQ6kCL4UL357jHtNIT+KpeWWi
         x6/5CBknj5sy7zPi+7uEnHIadm2xD8wCimq0UHGaCLWF6U8cTM338mZbYDSv5Lf50Ejw
         MqWB0Qg//6AhP6LnOhjsnOTl34JT2AdgKR7I66PvI1c92TjJ3nK2Fl42utfRfK63XZvX
         KhdinO05mRTsKFhsxdHt7v/VwE8iCnRPFgIEshl+BPZCyU9OVzRC+b07Mci9kKhnf46k
         /NwA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.4 89/97] hypfs_kill_super(): deal with failed allocations
Date: Sun, 22 Apr 2018 15:54:07 +0200
Message-Id: <20180422135310.057928574@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455302039543864?=
X-GMAIL-MSGID: =?utf-8?q?1598456328699148150?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit a24cd490739586a7d2da3549a1844e1d7c4f4fc4 upstream.

hypfs_fill_super() might fail to allocate sbi; hypfs_kill_super()
should not oops on that.

Cc: stable@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/hypfs/inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -318,7 +318,7 @@ static void hypfs_kill_super(struct supe
 
 	if (sb->s_root)
 		hypfs_delete_tree(sb->s_root);
-	if (sb_info->update_file)
+	if (sb_info && sb_info->update_file)
 		hypfs_remove(sb_info->update_file);
 	kfree(sb->s_fs_info);
 	sb->s_fs_info = NULL;
