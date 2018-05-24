Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrQzK9eAaHWCe+C1ZZCb8mcmqxWvdT9og1s/HvAxMmQX3c2v1CyHWx4cwsgv7XTyN469xHa
ARC-Seal: i=1; a=rsa-sha256; t=1527156193; cv=none;
        d=google.com; s=arc-20160816;
        b=P9zmpKUH1HdDv+y7XJQTe8XrHaCNHxn4EeM4irokVe/N+plpKsYpUyrRhm8e10ydJI
         YVRHdCGTFtZCJUIypdnm6TETFFstWZyJLnng18k0og0EvXKA6YL6n7b7Rb6dXJjvn49M
         Ii5hh7ZoP7/jYoBJaHSNynwfg/stsYmmSm4JHWUpkE+1EIRF6UuAQ8ICAk3aYyynD1X8
         ytYUye05LAOKooQ14hQiMINqO/VwmesNVodDLC54WgsZMU/eNEaNmMNfkvSOfYH7ol/X
         CwKnRr0AsPvNWhnaJm+pGwEHzCKm3y8hTIylSWfqsuPDEIvOBgoLj4ImGKN40sfA7fRK
         CrNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Lg6SXfWraEynMrS7HAdBNxj0jOjQ+vMvHQjLFbsBFbQ=;
        b=BxzYk6hiVhkmmBoW4U+CkTC6q+YJx0eXOrTy2x+VSzkBGxc7N/05qaBaQshEzEYsuW
         +saf0x/ApF6SJz/z1/3yFA7LYsYy8q12RfPU8zIO60Ontx+BPmhVWyGpMmvYojazROpY
         RbzWsr5GTlAkehvAqR9Bydq+qxv8l3iBI8hqTTSOMZJ8d63fsakjcuvIP6P+exHAay4o
         MN+A3nZX59RGBAO69OtxuvLdo9zpr5Cbk/TEjvaPz70k9Q5rHpjzE2ANqmVpP8ia1DrI
         cRK8va7fGC8wKwGx8c/wS0OhPJoH3ZLtTDuipwzJaA3TmHrrG38pi0aBv0YgrazUHrT6
         sHDg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=KUt8DjHZ;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=KUt8DjHZ;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+7d26fc1eea198488deab@syzkaller.appspotmail.com,
	Alexander Potapenko <glider@google.com>,
	Douglas Gilbert <dgilbert@interlog.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.16 064/161] scsi: sg: allocate with __GFP_ZERO in sg_build_indirect()
Date: Thu, 24 May 2018 11:38:09 +0200
Message-Id: <20180524093026.158541287@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338018885033421?=
X-GMAIL-MSGID: =?utf-8?q?1601339332035293535?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Potapenko <glider@google.com>

commit a45b599ad808c3c982fdcdc12b0b8611c2f92824 upstream.

This shall help avoid copying uninitialized memory to the userspace when
calling ioctl(fd, SG_IO) with an empty command.

Reported-by: syzbot+7d26fc1eea198488deab@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Potapenko <glider@google.com>
Acked-by: Douglas Gilbert <dgilbert@interlog.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/sg.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1894,7 +1894,7 @@ retry:
 		num = (rem_sz > scatter_elem_sz_prev) ?
 			scatter_elem_sz_prev : rem_sz;
 
-		schp->pages[k] = alloc_pages(gfp_mask, order);
+		schp->pages[k] = alloc_pages(gfp_mask | __GFP_ZERO, order);
 		if (!schp->pages[k])
 			goto out;
 
