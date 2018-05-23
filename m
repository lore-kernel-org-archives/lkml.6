Return-Path: <david@redhat.com>
X-Google-Smtp-Source: ADUXVKJveTFQdERg9c3rpk2GdMU5vZILwtdPXLq/rJEChfncJmoNnuNSs2d0Z+jKskFuoH9hmccy
ARC-Seal: i=1; a=rsa-sha256; t=1527099860; cv=none;
        d=google.com; s=arc-20160816;
        b=UGd+1VUyMrSsimZxUpoytUGm04aQYnwBnSyRfLhxDuMAKKF11owzk2o8d9ShjVDhlG
         U6I/AAvzmgMUATghwcFSHwvEvZC/qxH5iG/26phHmPOVCPXV6ed0z7Kdo/OwfsJtm8x4
         Vai/+q0knsDqq8xHB3/RWGrbXrHRVuVdqOCeI+9BYzrjz8+vWivrQzS/QviqgcCegfSg
         bRe2ltEqxwXvSAS7RTYcHcLBOPLOhjdm1+curkFDHEQwU8Cz7o906rPnpr4pCZtnI8hY
         EKMiruFDpJ2J9LkgQ23mu1ycOyoR6qQuaHMXh/m0Y0tLqVm4b5LG7nfdw1HD4U9l9Et6
         BkiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=REPMrlCXk+bNlz+Pg6nTiOLOP5N73fEEXA1YvcSxsVE=;
        b=ww6fa/Rpt4s0PNiZHONNnNE6Vzadd1DKmLo6tIcUWfAsj1vHpracmWQgMvNEODWyJn
         doEYMQZSRwzU7/aXJkVezHCB26y0GOs3UpulfFlS0Jj/7KmMF+jkPcJmINnLeqekhwcF
         AIB29bJ9bXfifGoo2t4yoX6n/y/KyFp9W/IEQ87gPqHFSeWSzx6rD+JFjW8SrDWYnHHq
         JuS5v2yI4XMjBvA5qeipimNriPEnozuEgJJ0OImH6jGvHTqhzLOgvOHTk+R0qgSzRRqx
         b4uftttpYKlJxFkk/DvVrF+XoqV8+N1o4oLt01ihY0XuAZ+1B0KDYfyb6Uro2QHxOeME
         Hs3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: David Hildenbrand <david@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-s390@vger.kernel.org
Subject: [PATCH RFCv2 3/4] s390: numa: implement memory_add_physaddr_to_nid()
Date: Wed, 23 May 2018 20:24:03 +0200
Message-Id: <20180523182404.11433-4-david@redhat.com>
In-Reply-To: <20180523182404.11433-1-david@redhat.com>
References: <20180523182404.11433-1-david@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601280263006044533?=
X-GMAIL-MSGID: =?utf-8?q?1601280263006044533?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The common interface to be used with add_memory().

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-s390@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/numa/numa.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/s390/numa/numa.c b/arch/s390/numa/numa.c
index 06a80434cfe6..8902652ab3e5 100644
--- a/arch/s390/numa/numa.c
+++ b/arch/s390/numa/numa.c
@@ -44,6 +44,18 @@ int numa_pfn_to_nid(unsigned long pfn)
 	return mode->__pfn_to_nid ? mode->__pfn_to_nid(pfn) : 0;
 }
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+int memory_add_physaddr_to_nid(u64 addr)
+{
+	int nid = numa_pfn_to_nid(PFN_DOWN(addr));
+
+	if (nid < 0)
+		return 0;
+	return nid;
+}
+EXPORT_SYMBOL(memory_add_physaddr_to_nid);
+#endif
+
 void numa_update_cpu_topology(void)
 {
 	if (mode->update_cpu_topology)
-- 
2.17.0
