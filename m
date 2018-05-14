Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqZur5Rtk19BDt2uDOkSQuuYxC2avFYk0loLla0QOgkadgtl1qD2DNoAL1qoT7rt31bK3HG
ARC-Seal: i=1; a=rsa-sha256; t=1526281058; cv=none;
        d=google.com; s=arc-20160816;
        b=CVzku/e5/gAP/HeE3HsAmhTZ1xChqG73VyK9rHBCbXKa9zH0HjYY3pK+buH8I5evAy
         OUKglF9KQ67+qDTD8N4BNPkbLQMTtGI3Cl396V32CZ8CNQEfQFD6OG7tAMT/nYFS9ooo
         ISSnJmsNqF2BSG6UHKAHj1FvrFkIDpNFubGaIIA8tQxyD/LUWcfcyqdEfIlROt+SICzY
         Xjb2+TccNuTyPjYqy0SHxtfCh9lMMc0co/Nk5RV+vdBI+QlmokGgIC1cCSDw5eyLPsg0
         i1md9QIUDENJ8c/p57jgxJQK1brlmzH+FaNJy6aSJTHYjWSuBW9AuPUcfjL/qNMFa63b
         VCTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=CpJBqIRp2V7pJVI6ZEtchvvWfOo7YKCYjwfm5rPEjSM=;
        b=UVO19M0pUqGN/uZCsVzn7ZJ6ZuyHhia0Ap7ZMugSppjat9wnHN/e13s/K+xpoKBlVe
         XbX+V0vRpNrRlwvgGpWJB3EIs6q+T02RbraYG5VWyYUkG8l1fno5yOuAssIon5MlilSb
         ETsABEQDxVGjpL1JXYBZbYlkyCWn1tKLHDM5m6WTSg4pe0XyTPTlK0x2nliYefePmr9a
         q8tnEOydgqLCKp7C18l8z6eLVUK8X90nPBRpuyBkKExCaEyFslh4THTn5SGkQFk4jqzf
         XwP9m6jDu8COE2AZpdCmYMlQnrdvX/vKUNIR5MxWxK74KWzq+Os7p/VZkRJkXoq+Cc2b
         1b5w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=sfMM/G77;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=sfMM/G77;
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
Subject: [PATCH 4.14 31/62] mm: sections are not offlined during memory hotremove
Date: Mon, 14 May 2018 08:48:47 +0200
Message-Id: <20180514064818.091284600@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421687228109067?=
X-GMAIL-MSGID: =?utf-8?q?1600421687228109067?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -661,7 +661,7 @@ void offline_mem_sections(unsigned long
 	unsigned long pfn;
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
-		unsigned long section_nr = pfn_to_section_nr(start_pfn);
+		unsigned long section_nr = pfn_to_section_nr(pfn);
 		struct mem_section *ms;
 
 		/*
