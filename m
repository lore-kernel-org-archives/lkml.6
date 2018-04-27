Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrBIIsxwhmoGni018OMGQVq9ajh39vlDCG4jZ9DBz1yLfXJ/XgAefsSdWdN2y0FBj7C0CVQ
ARC-Seal: i=1; a=rsa-sha256; t=1524837767; cv=none;
        d=google.com; s=arc-20160816;
        b=QCqW8AURqtAb/EA4tWYi/rk4w+zy1KqZVgUVNx5ghlOBoCd9+U0LX6bhQ75HHH99DI
         wD1S1vQj3LTIaM6OqnnLhqOyH0G47qu7GwjDT7wNCevyxZ6MxYItumS/JeXAOc/22++1
         Yot7Y6ElKdmfNHF+FEYoVwwPQr0rpVf+gUGnmX/ut2Ex5PgSukJxV8qMF7A7vEybnad/
         755ud07JufDgk58RmlCiaroxxinGFqd6FxorQWwpaNZCvj22T+AnGc2v5v91f/bud3HR
         h27wVWWICchRc+bUwih42SB6973hErL64/AVCmjwYKRSKS9r2Qu8/lR4FLgq25kFS9AK
         o0GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=wRpDNQvWdABjGwWxYaDtP72aYv9H7qQvhRODD1tTZos=;
        b=C7Hp6NI3SxPYzOV4EpOm9HbcDJBZxK0YziG3gUOEUyzrdpq9wK+v8/s8imcY1C/Yum
         ntvIG1s8ELG2V3iXHtUEbvV2Vcti6EdSsj5aN6roN2n7SKM8xN9/3zJyL/2TE21loLPD
         K/QGSqV0E1UMluUUFkKWop0uOEx5oOgxuB2hDdloheVHThBQ3H5khucDTJa8a9ti0/m3
         TgEfTBBOZAhXmrWU+pA+705S8usuS35xIU1u5ahHo4H2ZyTU+KhCmmwjQ1yMBcnZhpBd
         2LrrG9nbmqZS01asLhTBNYzMfFYUGD0Rd9aU5Y72PcZn7xpRjHY7txwj31MZdBeKxnOj
         NFqw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2190218A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Colin Ian King <colin.king@canonical.com>,
	Pavel Shilovsky <pshilov@microsoft.com>,
	Eryu Guan <eguan@redhat.com>,
	Ronnie Sahlberg <lsahlber@redhat.com>,
	Steve French <smfrench@gmail.com>
Subject: [PATCH 4.9 01/74] cifs: do not allow creating sockets except with SMB1 posix exensions
Date: Fri, 27 Apr 2018 15:57:51 +0200
Message-Id: <20180427135709.955276222@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908003745859053?=
X-GMAIL-MSGID: =?utf-8?q?1598908286700356193?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <smfrench@gmail.com>

commit 1d0cffa674cfa7d185a302c8c6850fc50b893bed upstream.

RHBZ: 1453123

Since at least the 3.10 kernel and likely a lot earlier we have
not been able to create unix domain sockets in a cifs share
when mounted using the SFU mount option (except when mounted
with the cifs unix extensions to Samba e.g.)
Trying to create a socket, for example using the af_unix command from
xfstests will cause :
BUG: unable to handle kernel NULL pointer dereference at 00000000
00000040

Since no one uses or depends on being able to create unix domains sockets
on a cifs share the easiest fix to stop this vulnerability is to simply
not allow creation of any other special files than char or block devices
when sfu is used.

Added update to Ronnie's patch to handle a tcon link leak, and
to address a buf leak noticed by Gustavo and Colin.

Acked-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
CC:  Colin Ian King <colin.king@canonical.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Reported-by: Eryu Guan <eguan@redhat.com>
Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <smfrench@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/dir.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -673,6 +673,9 @@ int cifs_mknod(struct inode *inode, stru
 		goto mknod_out;
 	}
 
+	if (!S_ISCHR(mode) && !S_ISBLK(mode))
+		goto mknod_out;
+
 	if (!(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_UNX_EMUL))
 		goto mknod_out;
 
@@ -681,10 +684,8 @@ int cifs_mknod(struct inode *inode, stru
 
 	buf = kmalloc(sizeof(FILE_ALL_INFO), GFP_KERNEL);
 	if (buf == NULL) {
-		kfree(full_path);
 		rc = -ENOMEM;
-		free_xid(xid);
-		return rc;
+		goto mknod_out;
 	}
 
 	if (backup_cred(cifs_sb))
@@ -731,7 +732,7 @@ int cifs_mknod(struct inode *inode, stru
 		pdev->minor = cpu_to_le64(MINOR(device_number));
 		rc = tcon->ses->server->ops->sync_write(xid, &fid, &io_parms,
 							&bytes_written, iov, 1);
-	} /* else if (S_ISFIFO) */
+	}
 	tcon->ses->server->ops->close(xid, tcon, &fid);
 	d_drop(direntry);
 
