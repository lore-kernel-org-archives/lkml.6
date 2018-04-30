Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo9P8QRtJo6NraOB0FGRBo/xuQ8zOfaJM2TAnK9jne/NUY/NP1m5Vb8ug3nWpRqVX04LvWN
ARC-Seal: i=1; a=rsa-sha256; t=1525116539; cv=none;
        d=google.com; s=arc-20160816;
        b=NDvjwYvQd3sBh6WrYqF2OBbnKiGne7TX53q2N/QXIQnGHUHxizFcFLgt/ZNvA9gWZE
         SU+l9Thjb4+vyMbVf3SZJBHKkiJrY6TbBnpXMEOyNQqmlRy0etYDWpUCeagj+VHVvm00
         fKUZtAFLLEazP6C14BCXwFaCVOv3GUHHbR49AiiP6ADeMrPjm7+E1CEYPdnYX2+Xu7lE
         27+4D+/XZs9FNlLjyx8eNVsa6v7evpb0jppzK9V8bwt3DO8CJPAsjpJzZV7HL8TnOCGp
         L76YY2HT24gzKok+Doq8WhL9uTx2ZUcb9Fl3aRGt+4xxPLXwyyUFvjHUVgfEdQ89WXrL
         ziFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=ThtO/3JhJsrDdm9vIlTMGCVBtzOPeaspu2+pjV7s2tQ=;
        b=VhzijwWvwR/a0gKTWl6K3kfAxP1AiEvfLcurTdEju6vYb1t4mgpVR1pph/T0yqdVby
         PGSozV/ClvgNWlyBTow49xUxxxU+g9xRuSpgobCwRvFIiH7nN0I8Q60BwpMj1uIBiUF/
         C56mSbuJIRCwlT7GszMMPLQH3HAG8oBRhiRarhF0WnzBWA12CEFAkK8Y7teNOnjUesJl
         EJc1YlwNZBER0uYlUTZ7wVnIf3dnjf4CAsm8S/E9sAom0SAjRF04H//bkAKL6adRrQaT
         Qs7leHTNqx++rDI7gEwywGw+5Q/+XMnKUzXsRZ2t3QuwGdjvDMdooDnljyxT5EztmcJO
         xB/g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81AF122E72
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Balbir Singh <bsingharora@gmail.com>,
	Reza Arbab <arbab@linux.ibm.com>,
	Rashmica Gupta <rashmica.g@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.16 080/113] powerpc/mm: Flush cache on memory hot(un)plug
Date: Mon, 30 Apr 2018 12:24:51 -0700
Message-Id: <20180430184018.566463069@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200526410353909?=
X-GMAIL-MSGID: =?utf-8?q?1599200599878446809?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Balbir Singh <bsingharora@gmail.com>

commit fb5924fddf9ee31db04da7ad4e8c3434a387101b upstream.

This patch adds support for flushing potentially dirty cache lines
when memory is hot-plugged/hot-un-plugged. The support is currently
limited to 64 bit systems.

The bug was exposed when mappings for a device were actually
hot-unplugged and plugged in back later. A similar issue was observed
during the development of memtrace, but memtrace does it's own
flushing of region via a custom routine.

These patches do a flush both on hotplug/unplug to clear any stale
data in the cache w.r.t mappings, there is a small race window where a
clean cache line may be created again just prior to tearing down the
mapping.

The patches were tested by disabling the flush routines in memtrace
and doing I/O on the trace file. The system immediately
checkstops (quite reliablly if prior to the hot-unplug of the memtrace
region, we memset the regions we are about to hot unplug). After these
patches no custom flushing is needed in the memtrace code.

Fixes: 9d5171a8f248 ("powerpc/powernv: Enable removal of memory for in memory tracing")
Cc: stable@vger.kernel.org # v4.14+
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
Acked-by: Reza Arbab <arbab@linux.ibm.com>
Reviewed-by: Rashmica Gupta <rashmica.g@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/mm/mem.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -143,6 +143,7 @@ int arch_add_memory(int nid, u64 start,
 			start, start + size, rc);
 		return -EFAULT;
 	}
+	flush_inval_dcache_range(start, start + size);
 
 	return __add_pages(nid, start_pfn, nr_pages, altmap, want_memblock);
 }
@@ -169,6 +170,7 @@ int arch_remove_memory(u64 start, u64 si
 
 	/* Remove htab bolted mappings for this section of memory */
 	start = (unsigned long)__va(start);
+	flush_inval_dcache_range(start, start + size);
 	ret = remove_section_mapping(start, start + size);
 
 	/* Ensure all vmalloc mappings are flushed in case they also
