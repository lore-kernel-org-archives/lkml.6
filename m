Return-Path: <kernel-hardening-return-11784-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x2274ZLidAwW9i5XsEY5XHNYm1n3mjmvAW02GDfzB0v+ildAzwJW1saiG/nVgNTxwOQMuhkt7
ARC-Seal: i=1; a=rsa-sha256; t=1518639224; cv=none;
        d=google.com; s=arc-20160816;
        b=UX2osO+T8IBqufPjFQHzWRQmR3M0mpSHhctJ64qA0GPkU45jWrNNWWD+NWP+cl+AOB
         FxaoJAaNFThloGEFjLZZDe9aJYAzm2Iqp5YPZSP2nK7ifBx5eTFkk5dEBqeLUYA5ulGu
         ayZnIPRshvGsmxD7Pz8eOm5UwgDDlbK/JofntZVnxjdE+E5KTzHXhbJ/aNpWncCrMK7K
         crWk3WUR5MY0Q6+toVVEJw9MMf5j5m945pfa8iUAJ59LO/2ridtw1NATBfuNXKxCWV7s
         55u8ijj5zAHIK+Oh3jRvW34o9DPZLH/hQ1LORMzVbkfuREVEv9KjCWxPJ9oYIi5tdJL4
         In1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=olh2B0R6Wdl2+qoHIDoYnXvwVK14NaW4Mu5R+lvAgNI=;
        b=dsQiMDNqojAiRLfR1z9VDPGGFBf1EpmuBgknq+L05fwuHUg8XjrpJSM/Io01jcgiTQ
         wLm3a9H65/eVCCpn4tuPXgEcqVkmf2ALr1T5GIIDg9qN44ROT/K5xwCE0Z5jEXFahBsU
         sua9CCILEG2g5aWPZpn6eH3DSR33/O+vMCHMGVjnyzvaTBvZ0deIfakvhIGpVv/2pVoO
         S9MukUDiql3x1IkBcP2RuXAgTEhmOBhe4zPaiUiZwkN0FCEsFH3m99cjUbKWyCNSC5ts
         2wRZrjwH10GT6x7xGZFQoIo+S7QAWvFfcPgc2fLX+bVZmKcDyKYLDyw3kCvEqUXbTLQL
         Tq0w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=Tk6HX5S8;
       spf=pass (google.com: domain of kernel-hardening-return-11784-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11784-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=Tk6HX5S8;
       spf=pass (google.com: domain of kernel-hardening-return-11784-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11784-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
	linux-mm@kvack.org,
	Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Joe Perches <joe@perches.com>
Subject: [PATCH v2 8/8] Convert jffs2 acl to kvzalloc_struct
Date: Wed, 14 Feb 2018 12:11:54 -0800
Message-Id: <20180214201154.10186-9-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180214201154.10186-1-willy@infradead.org>
References: <20180214201154.10186-1-willy@infradead.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592408644336868874?=
X-GMAIL-MSGID: =?utf-8?q?1592408644336868874?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthew Wilcox <mawilcox@microsoft.com>

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 fs/jffs2/acl.c | 3 ++-
 fs/jffs2/acl.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/jffs2/acl.c b/fs/jffs2/acl.c
index 7ebacf14837f..9df7feffd6ea 100644
--- a/fs/jffs2/acl.c
+++ b/fs/jffs2/acl.c
@@ -13,6 +13,7 @@
 
 #include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/mm.h>
 #include <linux/fs.h>
 #include <linux/sched.h>
 #include <linux/time.h>
@@ -133,7 +134,7 @@ static void *jffs2_acl_to_medium(const struct posix_acl *acl, size_t *size)
 	size_t i;
 
 	*size = jffs2_acl_size(acl->a_count);
-	header = kmalloc(sizeof(*header) + acl->a_count * sizeof(*entry), GFP_KERNEL);
+	header = kvzalloc_struct(header, a_entries, acl->a_count, GFP_KERNEL);
 	if (!header)
 		return ERR_PTR(-ENOMEM);
 	header->a_version = cpu_to_je32(JFFS2_ACL_VERSION);
diff --git a/fs/jffs2/acl.h b/fs/jffs2/acl.h
index 2e2b5745c3b7..12d0271bdde3 100644
--- a/fs/jffs2/acl.h
+++ b/fs/jffs2/acl.h
@@ -22,6 +22,7 @@ struct jffs2_acl_entry_short {
 
 struct jffs2_acl_header {
 	jint32_t	a_version;
+	struct jffs2_acl_entry	a_entries[];
 };
 
 #ifdef CONFIG_JFFS2_FS_POSIX_ACL
-- 
2.15.1
