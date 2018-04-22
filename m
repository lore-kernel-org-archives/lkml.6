Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+G+tMVOJjKngPNiG/MLpPWNDkwofNGvzVFaCvJGw+13FfZQNnatGO6EAz+SQwFvmownW+A
ARC-Seal: i=1; a=rsa-sha256; t=1524406743; cv=none;
        d=google.com; s=arc-20160816;
        b=ZeVkvZkgY7PMIhTkkotvP3axuc0moxRfS7wYEhNtm3wUB4BXVDZBeHmXrrVetdjGpz
         UYb/vhRPON1cFbjnZQUA/NVlQ7edaIiYvR7vqsMkUsIPDtO6Bx4MmmGFBDm00KQG3roi
         iYBHkj0HNRNwGOrITTqR0atyvHdGhnY6V+MpYPb8AQbL2/5QWHxL4xsCQwmUNtYxiu5+
         MH976kZb9p+rho/qZR8aDzy4B5MrzYupkmuo9+6ZKg5FUgFRmEVZHCFPUgRs8tBrwnOO
         9aCrwVcKJLwxGDbfS8ktB93LxPRJ3eG9MNS+sHQ7kOh9b3X+DdZSZxW35WX98kWZjb7y
         sF1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hBQ+ZQUD2QSp1XU14UWyeq3O3IZSGeYaE0oJzy8aa4Q=;
        b=gXjiC2bZDUPoqAcy728urB/ybejgBxbO1Xx+atgG3MGj4luShCfhgJFv9UnwLo4/ls
         UDC0RwML824V4zHml4rm0zRTFB+GAydKe11T4EfWcFSXxatpvdE+wr1bNrkH/UFJ8OBo
         rNfJizbrcRMUkajpGADYS9qYUMPrXRDeQd9kRRwz8dgNGd9GZbuMeNeelRiCo/T3l1tW
         gyQhpro+cqeOfvF6hIIPDVnyTVqz4ou2MFd3ZW/aKRe1VH7nOBq33fobJ9BAJdDQEHej
         U1e0thPIenJAD8et4Hnbpkbi0hnjt72gE2ux3yCGoGQJfmwVZvHabUGDDkVoLY8kv4uH
         rL8A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	stable@kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.4 88/97] jffs2_kill_sb(): deal with failed allocations
Date: Sun, 22 Apr 2018 15:54:06 +0200
Message-Id: <20180422135310.002516046@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455296001564501?=
X-GMAIL-MSGID: =?utf-8?q?1598456325930570604?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit c66b23c2840446a82c389e4cb1a12eb2a71fa2e4 upstream.

jffs2_fill_super() might fail to allocate jffs2_sb_info;
jffs2_kill_sb() must survive that.

Cc: stable@kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/jffs2/super.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -345,7 +345,7 @@ static void jffs2_put_super (struct supe
 static void jffs2_kill_sb(struct super_block *sb)
 {
 	struct jffs2_sb_info *c = JFFS2_SB_INFO(sb);
-	if (!(sb->s_flags & MS_RDONLY))
+	if (c && !(sb->s_flags & MS_RDONLY))
 		jffs2_stop_garbage_collect_thread(c);
 	kill_mtd_super(sb);
 	kfree(c);
