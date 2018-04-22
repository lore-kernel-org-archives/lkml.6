Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/TAlal+r1/9z9GRjAqGkxdUCTNvwMqdUeVImCKBKCBMFadmaI1WHs0ypEgc8SUj+Ogxv0h
ARC-Seal: i=1; a=rsa-sha256; t=1524406757; cv=none;
        d=google.com; s=arc-20160816;
        b=BKP9utuDZn1h760DRNecQxAgb5Pw9qso5B88rF5GcqgM7F7eJuUx3l4HNtRDTtXv/C
         ndb1pnYbofxJu6pYsxur32n+ctLhFYViGCgrdSl2PJe6z9n0lvnpoP7Frpmg8INUM5WN
         nam7fW8fqJpnOISqmxH/D7jbEKGWMMVy2XZ/8mSPARRsyFnTl/ohV4/GgECYaP+EXSRj
         YINrtqurw4apXadiSpzQCPhyIlrdm8xCbEnNdaIgAaiZUuWn7Jdn9SubpVYeA1tTh07J
         AIb8dRXYnyWBORqHeYc1m0vLgIEdvcvNCpeJexlXMTA1cta2ahxFzAOCjXbeeNoun5x8
         uuuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NBprD9BUEGl1EVnn1tlGZ1QRWqKI9OpnCmayTEbcQzY=;
        b=hw/7d5Voycx9DldZ7s25phk65QYlAV+E2ph6HCJdPYm2euFtFttKRKI+94Jo0+t/7C
         8hPTAqhKWFNIl/1phoZD8GjP29fM+27gDd7FDDSG+od70Fsl7i+odzN/pgPL4U3uZ7Mi
         LrDJYGQhlgxjtyW6v4MUb/a4wfqQZf9VVPcDvjQtEMUcYKcOQFSDBZ8w4YV0A+uaJiwe
         SzkjrMzzQgONuVu4hO6QSq8biGgRNIdArLTbiv9hl98puqw1JVNNWrQXPgS10Kb0FfyX
         I4y4frh7q1X9K27/UvvtiN4iM6laJ8chhWtc7+KA743r/Tp0/3ajgd+QFpYkoQdjirtV
         6v7w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 92/97] autofs: mount point create should honour passed in mode
Date: Sun, 22 Apr 2018 15:54:10 +0200
Message-Id: <20180422135310.216442138@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455319452829195?=
X-GMAIL-MSGID: =?utf-8?q?1598456339571822490?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Kent <raven@themaw.net>

commit 1e6306652ba18723015d1b4967fe9de55f042499 upstream.

The autofs file system mkdir inode operation blindly sets the created
directory mode to S_IFDIR | 0555, ingoring the passed in mode, which can
cause selinux dac_override denials.

But the function also checks if the caller is the daemon (as no-one else
should be able to do anything here) so there's no point in not honouring
the passed in mode, allowing the daemon to set appropriate mode when
required.

Link: http://lkml.kernel.org/r/152361593601.8051.14014139124905996173.stgit@pluto.themaw.net
Signed-off-by: Ian Kent <raven@themaw.net>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/autofs4/root.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -746,7 +746,7 @@ static int autofs4_dir_mkdir(struct inod
 
 	autofs4_del_active(dentry);
 
-	inode = autofs4_get_inode(dir->i_sb, S_IFDIR | 0555);
+	inode = autofs4_get_inode(dir->i_sb, S_IFDIR | mode);
 	if (!inode)
 		return -ENOMEM;
 	d_add(dentry, inode);
