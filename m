Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoam2sn8v3mI1tJscOSu/+9DfqwHvWaagfMa43e/cigLqdZqM7lnarAJNSFx0H67FrM0SNQ
ARC-Seal: i=1; a=rsa-sha256; t=1527155694; cv=none;
        d=google.com; s=arc-20160816;
        b=ALmN4kvJdMnBz0e570/90oPqCOae76Qop2po1+NI9Mcrh7URatic0TZjIs9TMEUV0u
         kX8WGE0PbM2WfQumqONt9RLjvCQy0nODay+YJ5cx6BdyTD8H+hmld29vCTPszWbMCnby
         UcBMnSaAEz8/jsH+jWlio6ZHNJ1n7NqG7pNfua6C+XonrKPrd5TS3IvqmASHcuZXQ9Bl
         jbPtdOTujy6VD5Qk23ykikMxbkMt7z6BxYV4X6p4c8ChBXzddmj7eroAzclRTSC9lYW3
         eQ/vBfYlpNZu4eu3xRDKt5fEDXg4anEuep1cpWWYWYVhHJ/QwXBI8ThFNkhTlt2XItZp
         VMfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=FMO+h2LxTKspnEtYnhGAFaWIPwzM6IJPgvvciGl1YbQ=;
        b=ykWqmmT5/pFySoiRkALh9bnH5CM0WhWm3oG3MEOyc1VjugeZKJQviNJfMaGC919995
         fVDWvZGT8xC9xeG5bfwK6kXtyy0VyWC4VfUoo+1fyouwd0p/GwpSKHLjP0UPJxWD22Mg
         9GthXW1Bvz4/hVfKq/BohtWrDyUIiybi74LtPgu7GpcnE2lzhtuY2WtgmurmoR9uabyw
         CBIovrqnobSSSczpI8j8C8JZ1tvPZQN42+UKU3QA/UUsBHA6f//9KrRlO0htotjFGNa4
         y4AUaTEJSmxzWInuRZCD023tJAAtE+s3q9k46z/8vf3xb4yNwkoK+G0t3ZZtAy9dLMUY
         h7hQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=FC93qlYG;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=FC93qlYG;
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
Subject: [PATCH 4.14 047/165] scsi: sg: allocate with __GFP_ZERO in sg_build_indirect()
Date: Thu, 24 May 2018 11:37:33 +0200
Message-Id: <20180524093623.931009664@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338018885033421?=
X-GMAIL-MSGID: =?utf-8?q?1601338809197981192?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
