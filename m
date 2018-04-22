Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48MkZoDbYsNvqDZrOwJi5VRdyrFTs8HbBQWDV7+9vWdUmHleNOiIrzrJ7wRIQjYndX+SE9W
ARC-Seal: i=1; a=rsa-sha256; t=1524406009; cv=none;
        d=google.com; s=arc-20160816;
        b=BLcJSkLiA/SgWgJBxHao4Qjf7G3s6T7jWa3X02/uDmSBEIgMm2L4lwt2bOiZIelrTO
         uE8Vpc1viT/Q1F4TGyu8VsGdWZ5nhwpNcXFwfguSCO7bReuf2SgpJ+kLDyAzBOEVzFkz
         F+xZGm0GcGjP47mFkR7SWApxFNDZP4bQ/TvJG2a0JOHdvaNRz7DsvTsrz13uNXaCEAaq
         zvIUsFl+iqvFtxBYQNcnt7XZtG6KdXIseZPOYYuO/YCqMUBqCRvLGvB2+rP4SvMpgZpk
         +b/GCaUfMPk+3iBO6JUf9OvC95m1wAPJ84YRjNMpVkKjecs4al5CQBgRaH0YlOlWwcLm
         ZMdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=slqCVVp8dcWiYHbZa9xJX1M1RYcoi0MBlNv4pa5gj88=;
        b=jNpDaz3FhsNQpetZqzHwukZgTGyIQiJPViJPOm5pKRaXkjVmK53qCEH51uhjOQdqH6
         z5lZx0xwXl4Hwc6THwrtcWVHBlF6GoLy1hNWwcrDGHgWfnMaXWTua142jFIKE5XD6SlB
         4gxd4WFsc+17S+XQVhy81ERDnaCVUguRqasyoixm3xPVSW1GaM9q9hmv3MH74s/0Juvo
         B4JHqxrFfmwpEd3ulwvyZf1Rq3hqa75WDlJ5J+Sd399il3eTJhfspZnT/r7LnhWCVy81
         i3YySjFkuqt66hTssImIulbr0UHphS4HlrL/E0IhPoVEyezmqN0o42kh4m83vkr5TgZL
         1VEw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.14 080/164] ext4: always initialize the crc32c checksum driver
Date: Sun, 22 Apr 2018 15:52:27 +0200
Message-Id: <20180422135138.722624895@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455032822394961?=
X-GMAIL-MSGID: =?utf-8?q?1598455556190364928?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit a45403b51582a87872927a3e0fc0a389c26867f1 upstream.

The extended attribute code now uses the crc32c checksum for hashing
purposes, so we should just always always initialize it.  We also want
to prevent NULL pointer dereferences if one of the metadata checksum
features is enabled after the file sytsem is originally mounted.

This issue has been assigned CVE-2018-1094.

https://bugzilla.kernel.org/show_bug.cgi?id=199183
https://bugzilla.redhat.com/show_bug.cgi?id=1560788

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/super.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3490,15 +3490,12 @@ static int ext4_fill_super(struct super_
 	}
 
 	/* Load the checksum driver */
-	if (ext4_has_feature_metadata_csum(sb) ||
-	    ext4_has_feature_ea_inode(sb)) {
-		sbi->s_chksum_driver = crypto_alloc_shash("crc32c", 0, 0);
-		if (IS_ERR(sbi->s_chksum_driver)) {
-			ext4_msg(sb, KERN_ERR, "Cannot load crc32c driver.");
-			ret = PTR_ERR(sbi->s_chksum_driver);
-			sbi->s_chksum_driver = NULL;
-			goto failed_mount;
-		}
+	sbi->s_chksum_driver = crypto_alloc_shash("crc32c", 0, 0);
+	if (IS_ERR(sbi->s_chksum_driver)) {
+		ext4_msg(sb, KERN_ERR, "Cannot load crc32c driver.");
+		ret = PTR_ERR(sbi->s_chksum_driver);
+		sbi->s_chksum_driver = NULL;
+		goto failed_mount;
 	}
 
 	/* Check superblock checksum */
