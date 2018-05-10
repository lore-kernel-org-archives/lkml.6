Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AB8JxZqlz9ORF7qlWhdIR4SvZ6J8z6UDR7uZFhtyTFlLakxBtleAK+N9XPupy0yfIfmKkX7QOkKN
ARC-Seal: i=1; a=rsa-sha256; t=1525916689; cv=none;
        d=google.com; s=arc-20160816;
        b=sXXoJDHmu36Pjof8MKTTPKmNhuCrJQtUDE4NNcb5lbqZCySrm+5/7Q4YnKQXsmYtjQ
         iZE0pdUs19IH338zwSiCKRiNaAckyYXjpqlHEyM7OIxwD8QGmj7+rJNxZ/IKnDvqdLHM
         8mca9W0YtxuvlAtxAAyacXVhgIEPVaYVrvTPhqT4yYpcUl10Iu0cx8w8VgWDH/I9NclQ
         FQIMp64CL4He7IvsmIxIo1L4lyDuxw5iL0zsgGpj16KDfWIXtI1Qmx6aiSvONaEM2fvI
         A+hq5sVUhp7V7GoDlGrPDH6WvIbXIrYXyQBIAy13taPUPlCQ+Bb7vZMYtzwO6oEY7/Ur
         3I+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=dQIqhhKrHpWAMVIGoDY+eahNLTylyMsY+bPO0r337ns=;
        b=v4DGpEwBgTFEjzif+e3bqNLt2ak5NUubeuAHqk2lhbopbrxGyftb5RTggp6yiMUZp9
         bXFnBEsz1fa/Y727vXsWBdCLxC0WLKcYl6ZCq1tQhIUJ7MZH5J9Pwg9KePQ1/FNLoO7P
         Ugr4aKcEXPA5JbaWtJIEv3FNoczKWM+y12XKMODx3PYZlOsCBLW32gmDMicT/7Cdz/5y
         eE9K+APGesRpiCRSwpPdKEa0wmF+h1ZIHptXirT0gK4sPhOCD0yeP25cx1X4kPnpKWey
         ag+oqMCeJzPUVzehoDTKwsAyOm7VRSiDGBMo1DQpcEHd6z43ChGTC9FYELn/Uqy43cHk
         HhgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=TK54O2gt;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=TK54O2gt;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: arnd@arndb.de
Cc: gregkh@linuxfoundation.org,
	willy@infradead.org,
	geert@linux-m68k.org,
	linux-m68k@lists.linux-m68k.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v2 0/2] mm: PAGE_KERNEL_* fallbacks
Date: Wed,  9 May 2018 18:44:45 -0700
Message-Id: <20180510014447.15989-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600039618816101704?=
X-GMAIL-MSGID: =?utf-8?q?1600039618816101704?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

While dusting out the firmware loader closet I spotted a PAGE_KERNEL_*
fallback hack. This hurts my eyes, and it should also be blinding
others. Turns out we have other PAGE_KERNEL_* fallback hacks in
other places.

This moves them to asm-generic, and keeps track of architectures which
need some love or review. At least 0-day was happy with the changes.

Matthew Wilcox did put together a PAGE_KERNEL_RO patch for ia64, that
needs review and testing, and if it goes well it should be merged.

Luis R. Rodriguez (2):
  mm: provide a fallback for PAGE_KERNEL_RO for architectures
  mm: provide a fallback for PAGE_KERNEL_EXEC for architectures

 drivers/base/firmware_loader/fallback.c |  5 ----
 include/asm-generic/pgtable.h           | 36 +++++++++++++++++++++++++
 mm/nommu.c                              |  4 ---
 mm/vmalloc.c                            |  4 ---
 4 files changed, 36 insertions(+), 13 deletions(-)

-- 
2.17.0
