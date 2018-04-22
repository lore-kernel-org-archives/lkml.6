Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx493t8hYLpB17/8jLol+gvbIkogIDdwcjg3rcywQDR+aB4HUHz+hHLpKZWICVy/oKsUDMLmh
ARC-Seal: i=1; a=rsa-sha256; t=1524405767; cv=none;
        d=google.com; s=arc-20160816;
        b=QQ8ujFfXPI0RGmlZ/fS4ByO+mFmcOW61jNC3bT8gKNecXxe0U3Q/HiEH37ia1vxjhw
         /pdS5x/nOLM/0yynTbO88+aWkvpBUSnp7CZh3rRnbERo7gK6LJ6DWGKUIe+E3Hw0smiA
         cd8WotuCNYlcLd3mPdbLk4GCXdUZCxMcKQOeRlXhZAHsfjtW2q2DhiOZ16skWc/nfhcZ
         ghtkFIYJJC5kVlIT51ZWkxuC8UwdpvkS9lQLmslTmpfNkKc2XsS1CGR0LvcYL8xfPWbf
         i3k7VGlR93xbFupiT1dJAHt4Ck26o/GtPOFzUSYLSfWswsRlO9Py9rZy24ZRd3DUGR5O
         pUdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jIQ4j+2fivIVxSJ+XKJ4MxPhGHhhhqnl48Yh9zJFLhY=;
        b=KLYDKjmQDiKzx1XBoVg8fdD6STBgLCyUWrmn7t3W8OpEj39c3F34mU+8ELMSCuB+2i
         7Zk9wId5y8N1PsgL/KD0nFg1Qxp9CMVqZbHXmdx2f4btJOf/7ftZ9cIktfORis27BTqg
         LMLACoZpXo3HHF7XAoOILhlcBJyYXlMDK+l+MW3DcJn4oIoIFx0xBkEUKtUgfEICbfiD
         b10YP1QUfdRdKqKJC8KeRowsvQKmaGS/GUG4hnZI8fA4aQ9Ufa6N6Y6jH+ajj9ZViDN+
         1qNQrpf5JJXLaRvRqwYg+rEdXtCJsosTuZ1ycQuc4Nv+DD0C6gR+4Nq+88X7t9utT0YT
         Baxw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.16 186/196] hypfs_kill_super(): deal with failed allocations
Date: Sun, 22 Apr 2018 15:53:26 +0200
Message-Id: <20180422135113.878389697@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455302039543864?=
X-GMAIL-MSGID: =?utf-8?q?1598455302039543864?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -320,7 +320,7 @@ static void hypfs_kill_super(struct supe
 
 	if (sb->s_root)
 		hypfs_delete_tree(sb->s_root);
-	if (sb_info->update_file)
+	if (sb_info && sb_info->update_file)
 		hypfs_remove(sb_info->update_file);
 	kfree(sb->s_fs_info);
 	sb->s_fs_info = NULL;
