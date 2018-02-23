Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225/JDimcVF6xHDWynYjDKX3ySMs0j+VZ4bi2vcU3BuXohD2i23lNhel5sP1tqC9ub7Ui530
ARC-Seal: i=1; a=rsa-sha256; t=1519412340; cv=none;
        d=google.com; s=arc-20160816;
        b=KJWbo63iR5EcaiH8lUCRNX8bPVSKIFxfa+qqrJkb4sRbcbzOjrdh4h2yJa8/QOAo+x
         joJnpxa4l0SAUV8VNlltuM/yK8BZQjGqNLCgyfEkmOtTLNVzEoqnIKDB43J3wtZaGNi0
         ZGtifbacZOOGY/41rnkg/c4Pw4IqY9NcQRgIAVHsxP3uzUxfbv0na+BC79b6qJIlLz+5
         92hU4zE47M6XrembRebjQNAOLHjkoJXI2ObWV5HzSbsWWgJVVjAMDlyM+7GC7XTSJKwy
         QeM6DWUk93YFBvPi8iW+DFP3J6XeCpt5n4UbMFtXTp2/Nwa6ZjItbRBE9BATZks6K43w
         agxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=P0Q61X9yJ6XWd4NmJM+Z0bUyD2jxgshEpI0TZT4p3eo=;
        b=S1d/m4BFQwg90RDrHBoi8kFDvbzM5qc46y0mkjgRgFD9aQiNnG5Myo3xUzDABNtkqS
         cIoFMiBfp2h1XxY9IgXRHod+6mqDTc3eAy8yJy7dKSBEx+L+ULf3MTkvoQua5j9/euMX
         Y+2MAwxmrKNhl/yH/faMWofZHdto0WnM18I7X8yCqHp1nB7+nsC1o3QEEFzHTpVTfKEf
         kNxPP6siUoMDXo+7W8Q9jj4xeCNOFG1q9bNcTqk9mMEHggjzvNwsAOWfEj0h5VvYw/8N
         5VqsQTaSYa0MEqjaCc63ixfTejyIB8iTVAUvVQWQREcoIyOet29YoCFf3+ce4QtHZ452
         Eokg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>,
	Kai Heng Feng <kai.heng.feng@canonical.com>,
	Matthew Wilcox <willy@infradead.org>,
	Laura Abbott <labbott@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.15 45/45] vmalloc: fix __GFP_HIGHMEM usage for vmalloc_32 on 32b systems
Date: Fri, 23 Feb 2018 19:29:24 +0100
Message-Id: <20180223170722.526398632@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219205208783102?=
X-GMAIL-MSGID: =?utf-8?q?1593219314307145156?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Hocko <mhocko@suse.com>

commit 698d0831ba87b92ae10b15e8203cfd59f5a59a35 upstream.

Kai Heng Feng has noticed that BUG_ON(PageHighMem(pg)) triggers in
drivers/media/common/saa7146/saa7146_core.c since 19809c2da28a ("mm,
vmalloc: use __GFP_HIGHMEM implicitly").

saa7146_vmalloc_build_pgtable uses vmalloc_32 and it is reasonable to
expect that the resulting page is not in highmem.  The above commit
aimed to add __GFP_HIGHMEM only for those requests which do not specify
any zone modifier gfp flag.  vmalloc_32 relies on GFP_VMALLOC32 which
should do the right thing.  Except it has been missed that GFP_VMALLOC32
is an alias for GFP_KERNEL on 32b architectures.  Thanks to Matthew to
notice this.

Fix the problem by unconditionally setting GFP_DMA32 in GFP_VMALLOC32
for !64b arches (as a bailout).  This should do the right thing and use
ZONE_NORMAL which should be always below 4G on 32b systems.

Debugged by Matthew Wilcox.

[akpm@linux-foundation.org: coding-style fixes]
Link: http://lkml.kernel.org/r/20180212095019.GX21609@dhcp22.suse.cz
Fixes: 19809c2da28a ("mm, vmalloc: use __GFP_HIGHMEM implicitly”)
Signed-off-by: Michal Hocko <mhocko@suse.com>
Reported-by: Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Laura Abbott <labbott@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/vmalloc.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1943,11 +1943,15 @@ void *vmalloc_exec(unsigned long size)
 }
 
 #if defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA32)
-#define GFP_VMALLOC32 GFP_DMA32 | GFP_KERNEL
+#define GFP_VMALLOC32 (GFP_DMA32 | GFP_KERNEL)
 #elif defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA)
-#define GFP_VMALLOC32 GFP_DMA | GFP_KERNEL
+#define GFP_VMALLOC32 (GFP_DMA | GFP_KERNEL)
 #else
-#define GFP_VMALLOC32 GFP_KERNEL
+/*
+ * 64b systems should always have either DMA or DMA32 zones. For others
+ * GFP_DMA32 should do the right thing and use the normal zone.
+ */
+#define GFP_VMALLOC32 GFP_DMA32 | GFP_KERNEL
 #endif
 
 /**
