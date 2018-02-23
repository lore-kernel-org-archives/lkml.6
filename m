Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226lDR6ET7cCSulJUpgb2lQewEc/Il3tPmPRfWDaOBOfpLsYTt6XBpRFOFUPTrjDX1b2a9si
ARC-Seal: i=1; a=rsa-sha256; t=1519411830; cv=none;
        d=google.com; s=arc-20160816;
        b=K6lKCGUb1YjF961zmjIUZ3Y1ezef5qsqCy+qs9fru+hy2HObM2ipJVPUHffT9DYzw7
         HVwkymSm4nozLSn4ByIOoxDJ88ir0Av0EiJCwXMfcdkUC1XEW/4M1T7gHqZB9AIM70jI
         FSJmIKmoqTwXFN6ZwMnWsKK522egEQ0RpbeClBFf3POFY+UsG+ux7gjOaw8zSg7kEOUw
         wVuwjcF9l+L8TESYe5AZRISg7DeX95/5sDCJAWarXTrAlnALJlL2lR9v/kxCDq+FocEO
         xo6GlIJ95yvs3DjujJRkKoFfFqZMRNmUqAZh0bZ1e+mfvOzkSLdx+ZkcTC9i3zVwvG6O
         WF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MGqeJVWlTs77Zs5uQM5LOceGqw+Ip1coA5MQd0omzz0=;
        b=RuNEHIjwUpDRrfwU8KygfCGcGkzgcpDrNOp+l8ZLWAw1YrBFqmZFn581oh30hCqawT
         tUIW7upZKN6OxVZ+Qf8g7xJjhgJdNNqmvtqrnzdf101VB6YgbVStZntuwgduNQgoq8k6
         Hi9s4UzsCnBRl2DE5+FmpIPTlJev+UyTXwZEea5fCWF/sVaGHXLUzp+h6pd/c96l9L1m
         xHKHBF42nuO4NqafJ7ezNzsSGBZUAoUssKstrvleV5dCOXmtQYhalzj3SrpvVtWiaR/1
         fkrPlwpvHlqqSPBja+oKGmOv/aLyhZbL+v8ivdyC7sd3AaoCWhmcWHONuWdPUdDAn+XH
         LbFQ==
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
Subject: [PATCH 4.14 030/159] staging: android: ion: Add __GFP_NOWARN for system contig heap
Date: Fri, 23 Feb 2018 19:25:38 +0100
Message-Id: <20180223170746.899807571@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217532024569347?=
X-GMAIL-MSGID: =?utf-8?q?1593218779299364746?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -371,7 +371,7 @@ static int ion_system_contig_heap_alloca
 	unsigned long i;
 	int ret;
 
-	page = alloc_pages(low_order_gfp_flags, order);
+	page = alloc_pages(low_order_gfp_flags | __GFP_NOWARN, order);
 	if (!page)
 		return -ENOMEM;
 
