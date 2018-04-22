Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/kMn6MZZMq0JjUaxtFTRk8xyM0InF52+WcCEKEhVYUijCzUjx/83cDOGksYvCsyMGXaMJ1
ARC-Seal: i=1; a=rsa-sha256; t=1524405594; cv=none;
        d=google.com; s=arc-20160816;
        b=cNjoFpyLBzgG4BDeVG1woa1e2sx5UTYnDuI2HmrRTsyQnpiEzqyz1u0sT08J6faOlE
         K1x+XH4CKrhUX3YtlKTPx/RQhiPf1JqV+CxSWktfgGcYbrC5++vk159py5gerIO8DVJz
         yakvYqyl+uBsX4IyxUBamHHsh7P2G2mKNccsAgpoOC0Oug6vEPt9CZV9B6avmh34R5S3
         SfPFpTGQiz0RxL90xGwbGjrkJLzwQVMTf1k5VrrmLG/OMnm96KLGMz73C6AfQaU++I5n
         dy23WEEX1H6FsuUZJSjlIpoCR01nePSN8iyfNy3SekiRgQ+a82w4q/UUMTFpXrnGJgVy
         K+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lFxBRI7IDNFcRNQ1iM4NvYcuPinLTWpPoUpHUAjMsPo=;
        b=DSFqOhRBXrgt/Gq+olmZ0Hutf153jn9CGqaFjvOfnqYap5JqtvVFU+1uEk+01BU3Zw
         7E/T8Fa2GgdhoT1Zbdy2+Wq8wo/10O8mDvGZ7eERopTHbGfSJ+JkTngckrnEcAGXKUZY
         JlMMhsbJtTIKWZg3P3Sask9GypOHMLPWLc+6/Hy4/ZOCh9iWf1VXvcbez1BnxtBVp+HH
         HYAk1h/ppymYdyBs376cVTpYoMnOKldaQDsWRisZZ+PhhSTYEO5ZfGRRKHcvIy97Zi62
         3D1YRsAycTlo8xAsTHxPzbgHhwpFMt1brALNVe+cPHr+DPwDhOoQWHGGi2+y93pf+xlK
         6FRg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jiri Slaby <jslaby@suse.cz>,
	Jan Kara <jack@suse.cz>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.16 090/196] ext4: fix offset overflow on 32-bit archs in ext4_iomap_begin()
Date: Sun, 22 Apr 2018 15:51:50 +0200
Message-Id: <20180422135108.945904552@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455121041638059?=
X-GMAIL-MSGID: =?utf-8?q?1598455121041638059?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Slaby <jslaby@suse.cz>

commit fe23cb65c2c394ea306f3714a17d46ab2e6a0af1 upstream.

ext4_iomap_begin() has a bug where offset returned in the iomap
structure will be truncated to unsigned long size. On 64-bit
architectures this is fine but on 32-bit architectures obviously not.
Not many places actually use the offset stored in the iomap structure
but one of visible failures is in SEEK_HOLE / SEEK_DATA implementation.
If we create a file like:

dd if=/dev/urandom of=file bs=1k seek=8m count=1

then

lseek64("file", 0x100000000ULL, SEEK_DATA)

wrongly returns 0x100000000 on unfixed kernel while it should return
0x200000000. Avoid the overflow by proper type cast.

Fixes: 545052e9e35a ("ext4: Switch to iomap for SEEK_HOLE / SEEK_DATA")
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org # v4.15
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3524,7 +3524,7 @@ retry:
 		iomap->flags |= IOMAP_F_DIRTY;
 	iomap->bdev = inode->i_sb->s_bdev;
 	iomap->dax_dev = sbi->s_daxdev;
-	iomap->offset = first_block << blkbits;
+	iomap->offset = (u64)first_block << blkbits;
 	iomap->length = (u64)map.m_len << blkbits;
 
 	if (ret == 0) {
