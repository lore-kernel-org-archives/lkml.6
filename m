Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49tSKoMJSiZRmHyIwNrWuG0/Jmb6ub7CH0q5hz6XQVDaBbWGWQNUXsSrh7yohYyYMq6o9w6
ARC-Seal: i=1; a=rsa-sha256; t=1524405510; cv=none;
        d=google.com; s=arc-20160816;
        b=GjsA/PgMV/GzBGigfqWgjJu3gv+S6Rf63ptmP4tnxKmSF0/Nolus/I76tXhSf2Ng+2
         ygkWGdVspG7F3co/3J0af8OU7KoO/3Rp7D+4Zl57su6jGJZPDBlOOHlmaIfYqtGQtM8q
         GENhR3N8nA0TxgQPWcVYjyYYyrp7tJ3JXwe8W81aSkkW1agQSpeijA5JHTUZCWOLGMMU
         7Ivh0WNh9fvHWBR1THteIOWLryCIr6qgaiZOvDs8805zpQWTyoFGdKlOSJX7lbuwBjrK
         pa/SY4lIRAXe3hg4Q2knVaksRwnCuDtFVHT47kM+/wepYPYWrVUA/KCABHWnAHohc+/w
         2vcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Kf+dlfNjlFz3IPp8dKf4tRj9yffeV4dsSWBtKh2hj2I=;
        b=y0QsDg7xYFQjytvtLbeP5R7Jf9vFwEy7NQvgHYA/VRW934PIaB5iLKW9I2gXgsbesN
         uhwyI7Qbzq9XqxXDEIg45BDNbgkguLMQp8g/jcCNpV/g3WkBsxrNSMl/r5xBJjs8r1vb
         3YUaMuXrIqFGnpJe/nUYm6eyZkpcvCUVYMvBnYQy2JqeHx7ViGWCJ95SD8G2iTpIFDLa
         aKeHsOGzQuo+PeJRqgjRtF8mEQi8B2cnN6O13MqdkrUz21qDeOiKgXxYm2iTDXlb+2Fi
         sqGn8dn2UPiKuhRJJtcr2I8CQIpP3uin4NsgDrCJgIXH1ao+2PviqGFrCJQaf2j6TM11
         eTXA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.16 094/196] ext4: always initialize the crc32c checksum driver
Date: Sun, 22 Apr 2018 15:51:54 +0200
Message-Id: <20180422135109.151839245@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455032822394961?=
X-GMAIL-MSGID: =?utf-8?q?1598455032822394961?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
