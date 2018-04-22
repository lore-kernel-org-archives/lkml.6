Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/rzU+xJNS/wDkz9EJMNSpac9MaAOHpl1NEvnAJ8NXkLX3JrZNzcyRYQ4m6ZIhN5czvqmV4
ARC-Seal: i=1; a=rsa-sha256; t=1524406908; cv=none;
        d=google.com; s=arc-20160816;
        b=efLSoOfPFhyIjhFzekhMc6x8Pxh44urgQyF32ASiD83RMlUcthgqTYsFNA/XbjabvN
         2W1E03Dn8MOCfnjiCNTmN7gYRCgc+iuM4JRmSGy/gmDhzJ5NPkcvIpIOA+usi5X3j8U2
         xKAypc4x8/7cS6oeThc/joGRQ0MuYl4y4Iz7TEgRISI7ElHe6pq8rkeeuQ4FZKqquaML
         ldLlPMU43NC4xA5GUeCLDKO++owXWseonrnvrRPsrjymGiKtum5XNtsyPIquwYWLNZyn
         DXZOgcJlakajAV8/cbzHA3obC/GrkP8I/QY7iGMBzs2O42sKzxqzW2kOPjusGo209ztG
         QATA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=a/8OH5sWdgySRpzqDrCaGicZkblPrBqirTLHKU2vRMY=;
        b=HcpvlPBrAYI9sdWWZdGRsTFz8anJmFzIBa2vsHj6y3feza2rbR5F/yn9rp60abs38y
         iv0dJhkV65RVRZWDZ7PqyAsBzMcZMqvYUiII2lhAA5j/s1dASEVtMI/VY1Jb2rz/UBS0
         BYHE5p86+KiYxTjGI2odKATU5PgupPMPb9i1ESQlSAuZsqX9AiadRcDs/cqbA5WTjeu0
         IPLZz5zl14ZPUVhQm+ecwYGb4etnwr+gf/k3aNILXvNZxxQq1obh6Kulx8G+mb2S8HzV
         9zZ/RZb1s6jZMfDuMtUoR/U3Q8QpHg+2loTcYoRRTZRIcwX0squyhDYlh20udGPXXnwY
         PE0A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 3.18 48/52] hypfs_kill_super(): deal with failed allocations
Date: Sun, 22 Apr 2018 15:54:21 +0200
Message-Id: <20180422135317.558902601@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455302039543864?=
X-GMAIL-MSGID: =?utf-8?q?1598456497931168157?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -326,7 +326,7 @@ static void hypfs_kill_super(struct supe
 
 	if (sb->s_root)
 		hypfs_delete_tree(sb->s_root);
-	if (sb_info->update_file)
+	if (sb_info && sb_info->update_file)
 		hypfs_remove(sb_info->update_file);
 	kfree(sb->s_fs_info);
 	sb->s_fs_info = NULL;
