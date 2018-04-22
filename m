Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+eE3YQ9cmj2GAcOS/GAgfMVMboA9PkOLS+5eLf7e4EuA3oC63Gi2JX8Mzsr0C5YnOIq4AZ
ARC-Seal: i=1; a=rsa-sha256; t=1524406484; cv=none;
        d=google.com; s=arc-20160816;
        b=dXiJrD3Fhu8vQfRKZU28uv/22Z18dG+boPNkR7us6HbMXYt5fs0y0oJUyE9h8QO4GK
         wmt6pELnnB+rmRCSMrXrLnIUa6rmvoLD+b/X1AyWqFfJuMjt3dkXKHVu4fKmKL4NfODQ
         6aREgY5dorqkO9AxBY21FdXxwrCYDkVi2AWQ8WEbIg3ymsRMXRCpDYbn2IoV8A5hELHk
         JKcU1a4UHUKIUDSe3Iq9cjsoRYaQdQ1jV3/5aWEmhj5QhsnGcdkNsFJpgNEM6YH+Tke0
         jioj5NG0MTRdavKelqskzGKQOG9BDWj9+Xed/EROqgv7/9vA2PiNv1T7dnkQeaGWrv/2
         tZ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MQN15W2D1Aty2AY9piK6SMLSxj/2DZuYB1iDaJ4Wgvc=;
        b=x8cZNzsOTXdgkSbPHKDfDqSW69GOVoNZj7t1Si5JpTJ1A/tMQ2TadWhkfaSMbaBf3r
         ZRwg69AMtohmp3loWRC16ta17ccidXwH+FEcNxVsNdHuMNLlvM4dMHGg9rx3/AYcNR4b
         3K39oSLRlddB/60yQqxi0VduIPTarGUbN5q5dxdtS+BuAQ2yD05mc0PVVjbAMXBSvfK9
         CNmnGmAqVSqGm/SAjoSsO5pOz8szJdwFX5cxDBGv2Hj9Fy99SgvKPw1rQeKgTzvcUBm0
         eRQndcvaAe4ySCQdW1CYmAxizpo3RHiz8cKc8fi6nACimKWkuvuuxo1n8NPiMa+KFUsr
         m9Tg==
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
Subject: [PATCH 4.9 88/95] orangefs_kill_sb(): deal with allocation failures
Date: Sun, 22 Apr 2018 15:53:57 +0200
Message-Id: <20180422135214.031110159@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455304867595864?=
X-GMAIL-MSGID: =?utf-8?q?1598456053421924248?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit 659038428cb43a66e3eff71e2c845c9de3611a98 upstream.

orangefs_fill_sb() might've failed to allocate ORANGEFS_SB(s); don't
oops in that case.

Cc: stable@kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/orangefs/super.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -559,6 +559,11 @@ void orangefs_kill_sb(struct super_block
 	/* provided sb cleanup */
 	kill_anon_super(sb);
 
+	if (!ORANGEFS_SB(sb)) {
+		mutex_lock(&orangefs_request_mutex);
+		mutex_unlock(&orangefs_request_mutex);
+		return;
+	}
 	/*
 	 * issue the unmount to userspace to tell it to remove the
 	 * dynamic mount info it has for this superblock
