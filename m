Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+bHPf29+mHzQK9Fuh4EJhhjP58j1nWvZCPKbDz2+3j99dZHTjEzT1KQEg0hfKqbNyJsWNd
ARC-Seal: i=1; a=rsa-sha256; t=1524406262; cv=none;
        d=google.com; s=arc-20160816;
        b=i3sv+cAnHP1JLfAyZjvfy1DhfURi/tJpky0IjW4nsD9jLUzKeG8yvcmf6lIM/Ia/A2
         bzDu+FYsmAKhMlI9wPJjMFVEGCKjjOQV+AJI5GJngBGfiW7pDlQ3FsMKF1kFgqaO6PWo
         qBlXD9i8mnb30KhTE0vwWuq6g7YM2ovzsUQRfzDIKerhjxuQFVN+59RHl5rqKCr1Q4oB
         NtcHwJW6IynNiyt7/fsxGfV4quHwYOgQDqSqSlS+X7M+M5RnAFXn+oHczlSHv6+qKVqk
         b4PaQuaALovWDXtS+0yNbsgPn1A4b80RmgHJKSfHM5AZL8oV4o5InLRJMPhySjxytxso
         KY2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SPgPOEtQYJEUlciZCf+BCJekdOcNTLYmdPsRy4GZPvE=;
        b=eYokL2eoiQBrV8V9F3qwkJQ3twxahiYfIeDHU5VXEV5jJmHHfGoacPEO4MQvD4O3SY
         yIevdhodmoiWoMZsiD5XbYZq1AA0ipuwXHpMwewBx9bwOzBTJbqSXhmTul/Q8n2TJi65
         Z3GG8+CE+u/dOFsgCw7fgmi5bBD4WRWhHRto+l5uc+CVl8rwDkf07iqexAeAQ1QeLRd/
         VXJcybehmeQr+k1PnttWaO60kW1vGzGYI4k3ZweJ8OaW2PoYDx50Rk3EfPUQ5EJE4gvV
         xjz8RKc7ZGsESmWkjMsIsPJm4lqm4SGXtX+UEoPqFL6OZfk0AeOHp9XNO6XGJtuFQWF3
         W0KA==
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
Subject: [PATCH 4.14 152/164] jffs2_kill_sb(): deal with failed allocations
Date: Sun, 22 Apr 2018 15:53:39 +0200
Message-Id: <20180422135141.786393380@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455296001564501?=
X-GMAIL-MSGID: =?utf-8?q?1598455821026131573?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -342,7 +342,7 @@ static void jffs2_put_super (struct supe
 static void jffs2_kill_sb(struct super_block *sb)
 {
 	struct jffs2_sb_info *c = JFFS2_SB_INFO(sb);
-	if (!sb_rdonly(sb))
+	if (c && !sb_rdonly(sb))
 		jffs2_stop_garbage_collect_thread(c);
 	kill_mtd_super(sb);
 	kfree(c);
