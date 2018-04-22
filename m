Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48X/Hfotaw1h7JiMyQhKGRlP1Bu0PviKvpquMDFMEwGRPQq1x9vVDqa0O857jL7zDi7jYp+
ARC-Seal: i=1; a=rsa-sha256; t=1524406919; cv=none;
        d=google.com; s=arc-20160816;
        b=lJc5wwB+l7OICY5i4vYA4mhfnTOligc5zF9OMM04lpZ4Hj3w93k1RJmtOZ+rzjsFd0
         THOChI9oC+UYJvbBAkvM1T9DquDAZQ2qjIvwrQy7I2sjBNuPCPrNSOmC2ThCpQDQoLxA
         Bsfccn8RSetBvD5ubhUrL0jl7lAF9s37cSLA13IAMOxmRrlQMzDYxz4WLIIs0F/Fhb2L
         FlQkbhVJVdmDpCwaW0KThV6kx9HyZBPbZVK8wMjJSwovs2vd3aJl1g82jE8XKsc3HwmI
         woXWgWaAU11olAD9l3bzjJ6RFfi9TfKVqq/TSzgmx22x64ECZVi2nL5wUI0QRYARNHnq
         zyhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Fmt+AE5cj9F3CbvXQ50Ez0UnGa7KlYYhspBVWGgGkUI=;
        b=bMaM5A5OtJAsKfGmWODV9mIvcBmYXiaz/7astzNX+iErp0Up+MIxJ1XRCM0f6MkUg3
         rIGzn2MPbVYR6Bw7buaQaDdYFzwzyDoC9iKHBtzHzmtdnAPZSuVofePEkXm/3VSZmq6F
         Wu34KAhL1PpUh4qGqaer1pBfx3YOT5bnkSalnyoYvJK9rgrMBHYGPei9ompRqCAlTkM1
         HUjf65rDXurnp5dDkBpiZWdHEWphdnIaWLIyWPgxw9z0S70cAoEPnne++1CxdXIfVYId
         fNx253bIIreXxxz2Pdmkmw10Talk95K88EpFlFrY0K9akJzJjGDh/qD6LrYIN3Ld16ni
         fZPQ==
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
Subject: [PATCH 3.18 51/52] autofs: mount point create should honour passed in mode
Date: Sun, 22 Apr 2018 15:54:24 +0200
Message-Id: <20180422135317.677923694@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455319452829195?=
X-GMAIL-MSGID: =?utf-8?q?1598456509923808357?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -753,7 +753,7 @@ static int autofs4_dir_mkdir(struct inod
 
 	autofs4_del_active(dentry);
 
-	inode = autofs4_get_inode(dir->i_sb, S_IFDIR | 0555);
+	inode = autofs4_get_inode(dir->i_sb, S_IFDIR | mode);
 	if (!inode)
 		return -ENOMEM;
 	d_add(dentry, inode);
