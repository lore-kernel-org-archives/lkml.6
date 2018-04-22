Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4953VrrfXToSd310UyudtmCgoK8VGthtZnBZ77xM7U0JTbH0Wx9ANR/57BJIVplJBHb2dHm
ARC-Seal: i=1; a=rsa-sha256; t=1524405524; cv=none;
        d=google.com; s=arc-20160816;
        b=fdncWoxjQBCaCjdc1ahEEexe+mJ5ZhKKAYoCTE/NF00kZEgfshRNF8zzRQ/lb72obg
         7hYkm9ca1qO5zx+QxbDYONHO9RqcSgea0qCViSMPHkkKRgbVhSekv2vB5X7f2Pmb5BA8
         Yv6fue6X0Rr1le2dAgrDRuNxTa9ZI1IMXDe8dZ1AHVsD22nZg/xQ2/B8gtvQ4oZb4472
         4SO0UUSPPZWgXNsfHBwzMZre87WI7QhpHsqNf1wSaQU/Ez1Qneaa5ibI42ODOtOAqNPF
         Fa1oTisgpu3fodtEZ9lewHd9LHxG6tTVNE1mNh40cHqF99clZ5awr1KstajDbabq3h6r
         kyAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BOMvre4Y2L+CrBehM12w019hXVq7C5NuYeRO1FTy23M=;
        b=kd0L285j3RHJgSayyOC72glKsGuLTB2+T5TxebnXWlEU1Z/3oMHbbT197S5CS+4lLj
         50ezqhtr7HoyPnQJOzuWJJ2nu/9H4RfRw/Q0Qi8xiKF1Go6jgVOT86Hq4eIpPuONMPf3
         Ne+OP/lAGli1q64GvFoHLHyQ1IsrH3Ah2t7OHZfWc/k90/Z5am56B651LTnt77HQBkUW
         mUKPHi8oKitu1XjFSjumGdeMAh/bdd0dLh2PFXnECXniI5DYW7RdJRM/445RnQdNg1cx
         V19lgsxs32mQZNCY0Q6sfYR5NxfQ95eGHqEbJQMeeotBGxj16ypsOuwCKayLobaNntDP
         OLJw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+1236ce66f79263e8a862@syzkaller.appspotmail.com,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.16 099/196] ext4: force revalidation of directory pointer after seekdir(2)
Date: Sun, 22 Apr 2018 15:51:59 +0200
Message-Id: <20180422135109.375117801@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455047206955441?=
X-GMAIL-MSGID: =?utf-8?q?1598455047206955441?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit e40ff213898502d299351cc2fe1e350cd186f0d3 upstream.

A malicious user could force the directory pointer to be in an invalid
spot by using seekdir(2).  Use the mechanism we already have to notice
if the directory has changed since the last time we called
ext4_readdir() to force a revalidation of the pointer.

Reported-by: syzbot+1236ce66f79263e8a862@syzkaller.appspotmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/dir.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -365,13 +365,15 @@ static loff_t ext4_dir_llseek(struct fil
 {
 	struct inode *inode = file->f_mapping->host;
 	int dx_dir = is_dx_dir(inode);
-	loff_t htree_max = ext4_get_htree_eof(file);
+	loff_t ret, htree_max = ext4_get_htree_eof(file);
 
 	if (likely(dx_dir))
-		return generic_file_llseek_size(file, offset, whence,
+		ret = generic_file_llseek_size(file, offset, whence,
 						    htree_max, htree_max);
 	else
-		return ext4_llseek(file, offset, whence);
+		ret = ext4_llseek(file, offset, whence);
+	file->f_version = inode_peek_iversion(inode) - 1;
+	return ret;
 }
 
 /*
