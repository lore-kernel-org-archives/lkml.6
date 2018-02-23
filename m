Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224jvZxmx/E0lDQLe0hDoEEg0cPgQitl3Vv9xZMS+p66Zo9+nn9/bYZX9DNXALcR2bTqOBnW
ARC-Seal: i=1; a=rsa-sha256; t=1519410783; cv=none;
        d=google.com; s=arc-20160816;
        b=W54TZ8538KWhNuwr/V4v+mCypuBpPsygt9g6nk8plbngmp5vLDSSEyUtBczQhdpxkP
         w6Xwu1iTpP/gwwDX7kmmg/DQfyUB7Yc4Tkq03x+wx1etmaLXiOXoNMZCYVUMCPIxDPRn
         AuAQgtUefObp+eo0IS3KFhU6W4OzMXKIONbVhiWh8JUtnb1I331TKgXYj2y4AGnP4ZJU
         jzFz4Gnzrmcr3N5pQv9w1WRnoBGU47OFM+hf8Md+3J6pbsXQmhjG0nQbFqj6rLePmi9T
         PeuUfr06GjR1zHExHtDOnO5GfOGn19MO3/Ttdpz2BB6E+5hqwNvKwnjyJKvYtOFi/BzW
         VHag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=w9Fxtu/rZidrOtpgnVkUPBmFCCoPmmVJOeY3udARYeA=;
        b=knPdj+lEcabJvnH8GyHuNIKJ4gTq4bD6uUq/SniSNvByl3lVPYjhu9hYakVXLYettF
         5qpZ1NbwaSI1b91KO4xGoEG1nOUmdQIalQd/VyGRbcG+28tjeWEUwhtJD1zmy7Ex5Yme
         4am8yVipZMc8wXqixtfEl5IUhDTF58YBKcuCG7q4TSb6xGulIpqd3Kjj7LGjAAWJc7YX
         Qw4Zg5hD/bIK8UKnE+bB6PSR2M3NPqTMELXP4aIt2lR9BEn7JK+CZ867Wj668lIwyN/O
         aHqxZ5RPD40Bl3IfzkwE7RZHbQZPH85G+U+8QaFmZl8J1rOF4CqxgGjGJAeUzaIcBter
         itJA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+76e7efc4748495855a4d@syzkaller.appspotmail.com,
	syzbot <syzkaller@googlegroups.com>,
	Laura Abbott <labbott@redhat.com>
Subject: [PATCH 4.4 013/193] staging: android: ion: Add __GFP_NOWARN for system contig heap
Date: Fri, 23 Feb 2018 19:24:06 +0100
Message-Id: <20180223170328.219713270@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217532024569347?=
X-GMAIL-MSGID: =?utf-8?q?1593217680931505096?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Laura Abbott <labbott@redhat.com>

commit 0c75f10312a35b149b2cebb1832316b35c2337ca upstream.

syzbot reported a warning from Ion:

  WARNING: CPU: 1 PID: 3485 at mm/page_alloc.c:3926

  ...
   __alloc_pages_nodemask+0x9fb/0xd80 mm/page_alloc.c:4252
  alloc_pages_current+0xb6/0x1e0 mm/mempolicy.c:2036
  alloc_pages include/linux/gfp.h:492 [inline]
  ion_system_contig_heap_allocate+0x40/0x2c0
  drivers/staging/android/ion/ion_system_heap.c:374
  ion_buffer_create drivers/staging/android/ion/ion.c:93 [inline]
  ion_alloc+0x2c1/0x9e0 drivers/staging/android/ion/ion.c:420
  ion_ioctl+0x26d/0x380 drivers/staging/android/ion/ion-ioctl.c:84
  vfs_ioctl fs/ioctl.c:46 [inline]
  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
  SYSC_ioctl fs/ioctl.c:701 [inline]
  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692

This is a warning about attempting to allocate order > MAX_ORDER. This
is coming from a userspace Ion allocation request. Since userspace is
free to request however much memory it wants (and the kernel is free to
deny its allocation), silence the allocation attempt with __GFP_NOWARN
in case it fails.

Reported-by: syzbot+76e7efc4748495855a4d@syzkaller.appspotmail.com
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/android/ion/ion_system_heap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/android/ion/ion_system_heap.c
+++ b/drivers/staging/android/ion/ion_system_heap.c
@@ -336,7 +336,7 @@ static int ion_system_contig_heap_alloca
 	if (align > (PAGE_SIZE << order))
 		return -EINVAL;
 
-	page = alloc_pages(low_order_gfp_flags, order);
+	page = alloc_pages(low_order_gfp_flags | __GFP_NOWARN, order);
 	if (!page)
 		return -ENOMEM;
 
