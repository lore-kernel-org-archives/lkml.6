Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq9XSDhwoXo2oDkLS5n/T+6zfN5BOigX6WIYMr5VmAfWe6Lje8HrH7q7oNJd8q/ySXZDM2i
ARC-Seal: i=1; a=rsa-sha256; t=1527157775; cv=none;
        d=google.com; s=arc-20160816;
        b=eBhvzoB2CgmquCwI2e/Znt8rZleBx4R1bupe4FpFdgeM6Rk0ntkzAsG2rT7flx3bgO
         lTyG1rt93pjsfBfseAkDHe7MIfaCTFOLz0yMXLGorZtAxNeCVprOL2PaTcP+1+X1WfLn
         +ZCjsb/3SDOPLsCm2NJZESWr1wLoKy5Nhup+Psgoc69NWmqRKbAZV7CN9PO5+XaGseRq
         DzFeRhJI/s2PrTaQcr2xgBdY9EOQXlXIe8KpsFB53ZXrrCY5NR1Mz0XmQI1cVzZTyy7T
         zHOkGRwFnaVL7gd7dykyIBZKq5K7GmV8Tzoks9k3QqKhIykGJFH1/JZ+35gG/Lv7bGGp
         tA0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=u80s+RbabLXBU6Ju0k81ByUEXJ56k653XlzSto9osKs=;
        b=HIVQiY3CYKAdZXie9znRtaBOj3rj5oJkAq8TzJ4SfLsGe+LgFMLGVq5CIbSMthc3GM
         nbnhnOWYvI1Aep0yU9Q91PWEEL6pydfPADxuXHJLRwvZwtx8T/RLN4C9bmsp9ao8hDgr
         vteg1n8nX5WchepbeBSZzCwxoKzTSet5GWVcvk8l64t0cy3IOjsrp20trPxeRma2GYyo
         2P0SsrGyRrGWq8gmUGzyElS/j2UR6REKv6SSWUYzuMk4+1m2W75wwbH9w51t1hM8Qefa
         jlBgDpy6+iuPD6r6y3+DUuvN65Qkp631a25/SpKEt23cNTjIuGIJO97HcudElNbRiV0i
         RDWg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=lB4qlxA1;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=lB4qlxA1;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.16 034/161] ext2: fix a block leak
Date: Thu, 24 May 2018 11:37:39 +0200
Message-Id: <20180524093022.449554719@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601340960342171264?=
X-GMAIL-MSGID: =?utf-8?q?1601340991516152501?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit 5aa1437d2d9a068c0334bd7c9dafa8ec4f97f13b upstream.

open file, unlink it, then use ioctl(2) to make it immutable or
append only.  Now close it and watch the blocks *not* freed...

Immutable/append-only checks belong in ->setattr().
Note: the bug is old and backport to anything prior to 737f2e93b972
("ext2: convert to use the new truncate convention") will need
these checks lifted into ext2_setattr().

Cc: stable@kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext2/inode.c |   10 ----------
 1 file changed, 10 deletions(-)

--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1261,21 +1261,11 @@ do_indirects:
 
 static void ext2_truncate_blocks(struct inode *inode, loff_t offset)
 {
-	/*
-	 * XXX: it seems like a bug here that we don't allow
-	 * IS_APPEND inode to have blocks-past-i_size trimmed off.
-	 * review and fix this.
-	 *
-	 * Also would be nice to be able to handle IO errors and such,
-	 * but that's probably too much to ask.
-	 */
 	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
 	    S_ISLNK(inode->i_mode)))
 		return;
 	if (ext2_inode_is_fast_symlink(inode))
 		return;
-	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
-		return;
 
 	dax_sem_down_write(EXT2_I(inode));
 	__ext2_truncate_blocks(inode, offset);
