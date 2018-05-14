Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrEhnU1gd4tRhBPjv5GHo0SDzbY1rz0MMw6vC1fz4xQJWLnttMt2aB/NTitGwmFlKM+90pM
ARC-Seal: i=1; a=rsa-sha256; t=1526281162; cv=none;
        d=google.com; s=arc-20160816;
        b=G0AukNeLiMjEBD18REaavJioIsHLxcHC1YZimb+eWOF5doSp+kQV3YWxIBdvF2OvMk
         vW4DcXvN84IbVd2momSfZ6N45GzcTuZsOkEGVoOYe64xNZ+yb4AuvQ9eF2jMlZ+wMd0E
         dlX25KvslmJx/SoleKpkt1epc2An4CFNUlbzs+44dAxFPQsLXgB/RNvHpEj7+C+R1Hud
         Tdk9XfG0Y6/IjGyl9xQlIQcSme6Tkwg4IVz6Nvq/edGSAuUozHHz8lJ3Sp2Np/i1jYRA
         1Fmva/hjbqW4a1+NZcRptcjwGik222GFWomaixj9nxykSHkR+dBWXr5X6xH0KNCJhMLx
         R1fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=uAsefOj+mFI/ZWZgjDYwUNbhOAFWqkIaT2eIeSVKyHQ=;
        b=NyBU4gPbeIzHjtupYJ++TKrakKozCZRM3p1aD9eKNx+ULE4DZgRi4QCl7qMCo/WiZm
         DyLSfnwdsy2tmQstfT9h7LFKJSB3/gEGZgj2lEeaqsf0WJBO+NbgxD2r66gNaZ+sXLr7
         bNkOdpWtJWfpcuSoi7aiCiqiX+awNfgFfAG8klj0+9VKUHFyxPW81FGiR45gbhcW7cL7
         WZKrLOXAdNyRgasJRLZRWgIIxRnSCMzF57kD55lG1n3EJ4NaFXfmudRQLR++Re9bOTeg
         or8J7dJ5MblBAHGvS4yhu6HIzUA4/SBzCI4fgWHCKzmJ3anfyealUYzgddhC5O9mdZDh
         4c1w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GIVFS63U;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GIVFS63U;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Steven Sistare <steven.sistare@oracle.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.16 32/72] mm: sections are not offlined during memory hotremove
Date: Mon, 14 May 2018 08:48:49 +0200
Message-Id: <20180514064824.476481364@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421687228109067?=
X-GMAIL-MSGID: =?utf-8?q?1600421796023472305?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Tatashin <pasha.tatashin@oracle.com>

commit 27227c733852f71008e9bf165950bb2edaed3a90 upstream.

Memory hotplug and hotremove operate with per-block granularity.  If the
machine has a large amount of memory (more than 64G), the size of a
memory block can span multiple sections.  By mistake, during hotremove
we set only the first section to offline state.

The bug was discovered because kernel selftest started to fail:
  https://lkml.kernel.org/r/20180423011247.GK5563@yexl-desktop

After commit, "mm/memory_hotplug: optimize probe routine".  But, the bug
is older than this commit.  In this optimization we also added a check
for sections to be in a proper state during hotplug operation.

Link: http://lkml.kernel.org/r/20180427145257.15222-1-pasha.tatashin@oracle.com
Fixes: 2d070eab2e82 ("mm: consider zone which is not fully populated to have holes")
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Steven Sistare <steven.sistare@oracle.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/sparse.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -666,7 +666,7 @@ void offline_mem_sections(unsigned long
 	unsigned long pfn;
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
-		unsigned long section_nr = pfn_to_section_nr(start_pfn);
+		unsigned long section_nr = pfn_to_section_nr(pfn);
 		struct mem_section *ms;
 
 		/*
