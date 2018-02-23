Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227GeuEuajDLMQMDe3rvKm4+kc9+5hh0AyreqGtg9LVYo7aBsLHMTiNhvIQQTHlFB/r3LDrI
ARC-Seal: i=1; a=rsa-sha256; t=1519412293; cv=none;
        d=google.com; s=arc-20160816;
        b=scf3XRipni6lCZoUcH8v1XL1gVEBW2rwT1Pb0vDQph+ryMt04SY4G4g4Xo4sGcsThl
         53Yd0CWUPQcP6b7Peo7m//0fhaMYcaDoJFXhMYtaVTPja+yv6cgfB6RO9lHwTp83EEFr
         t24TyLQq/PDJR9mj+sXADznTl4X7hGDMFzuUDBWauyBkEVq15x+/VM0E+Z8T86o1Qk4V
         ohLq2U9GFDSb3mHFJGYiamKyCaG5DsxMRyim3xqnpXxw0pFYLzLK70uGIykRYu8NuLoy
         UYymhy8DigRI/LQrXox2IaLXbG0bPGu1P7AMJYOxmTYruOmBRbRHVgelndJSwCmep3kM
         MbJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vCg2FwEmIJDv6VxTIXPJfFqPzmgJIXZBsOUyXfWuYFo=;
        b=yfdZCBaXrqS8kKBpAj/MMZX0aSuBhT0ROBkszTkIgAbcWGkUqorujREU31I3WPfwJW
         iuoyZW0SnGpbSJkTQNGFlxjnh8kpRPV9BKz/Cp4aXMmlrqCxBT+3SJFt4A4fVFawj3cS
         lig4d0+IDQ5aOT1g6SknPa2BkmQMsAGtBoXzcoEbue/nyL3OdtGzw8b3DnDypvNG85rm
         BDN2ER93M0bpQ0YD3i7dgVOcKdAvo4p79ZY4KOP/L1g9gnMHlKvTMQd1QvzUqjdl8xQD
         jdR7GkyB8Q/j/1iEHo6RIXGy1lzEeKmUSYayE57n5PXhH/zQbsqTwxCtGSJSZaMPUdav
         rd3Q==
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
Subject: [PATCH 4.15 08/45] staging: android: ion: Add __GFP_NOWARN for system contig heap
Date: Fri, 23 Feb 2018 19:28:47 +0100
Message-Id: <20180223170716.609721878@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217532024569347?=
X-GMAIL-MSGID: =?utf-8?q?1593219265385221035?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
