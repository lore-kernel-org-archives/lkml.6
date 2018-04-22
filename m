Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx493oofapoHQgaY9kn+SV/pL+d3pearYVSYxOIuTiKAc5gZcVqYkt5iyySiClYbAVY2Rk7/B
ARC-Seal: i=1; a=rsa-sha256; t=1524406481; cv=none;
        d=google.com; s=arc-20160816;
        b=fLInrwMCyCE63ePydMdK1zj9CMR6GizRNaU5BESmCPl4UWLsr3uNKtXGL3BLHtPWZE
         VUZi7X2gvaqA+eGHUJIO8YXU2+TeEzvZGfLDb51vTLD+X9NDKSlROWkgWfHytP4hsikQ
         9UTjVqBI8DCTjQQ3i7ANMs2B2nWJbOocFt321cDh+mCDIDDgTqurRiL+BeArrIrfe3mX
         FEOhQqk/x9h8Vwj0SeU2/EKUOAERTlqL0jbjOq6SjKnDQolUaNhga4pqIYWrC74Tw7mx
         WWRcClNTSw+W2vTGoYzl+rlUNd7V9+GpTTrckaz1DwzDCsZEAynvJ8vCUdR64K3q8NTo
         eS8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pchBYdmlN/OU/58Vd2kRogWXiNB2roeVaDqh7bCPgw0=;
        b=VZHrXyDzhXN6IP2H/U1466PXgDCZSEedrVCoUKG425wxIC5k/3YtUeseveglJwOaWf
         R7zCAyP7DMbvM53aSkb1FiPbG35TGBz8LlSkZmS2wy3J9bxhxiz4Ee83ojzlrbyB/YP2
         CSQKQPkKRKSudQIlysS044o3Ub1icn+ZbEqnlHUGW4+gShCr8aG0/gFASBQDX9PXuR8Y
         /Ca5A6mr/jnuMWVqNQSjE/9yq4VZTOwBSxb31UECRFDSW4YsF2QUzqSzCb4U8kGL03pX
         yBGPqhTx91Cs9xzRjLRFMnvcktJA5JVZ5vTZiKyq2zRK3VJj643L0CheF0ekrtHrzIxX
         w4bw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.9 87/95] hypfs_kill_super(): deal with failed allocations
Date: Sun, 22 Apr 2018 15:53:56 +0200
Message-Id: <20180422135213.992770641@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455302039543864?=
X-GMAIL-MSGID: =?utf-8?q?1598456051134325113?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
