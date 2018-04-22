Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/F/DNB7P8TDGfMfspYVrObrqZ8wCQeko8MeJlSYITr5ozmZTOXhYkSh3RuCNuP01x40x/o
ARC-Seal: i=1; a=rsa-sha256; t=1524405378; cv=none;
        d=google.com; s=arc-20160816;
        b=MszHDwZDA5M2np7ZIDdbIVdlEuPGzuZlg82vThyNxrT0WUy9P7TXsDkoEnRSOfAc3u
         9MnpybxC9Jh673t4nNQWmUeBNCGv9qK+rfVBSuYFiQfGKtOeLyGwzfLuP4V0+iN96PK7
         7vIAqIvXcWxPxLNW/pjRZd797XCFdUFJumnLFyTM9zYGpHS/5lik2pySbtSih9EATVaT
         y5icJvAwrwLShiDcvaIqMX7hGwVU5qEGZKkXZu8uinhs458qSm/3vasNPpDkyEWsWMCv
         9K+L0pWjgD49grfvBqMRF3KbOolLGxXbCjC9lKdCtMXQqXKKkxghtnJZQ0NnjLVJZ2XB
         Axmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=74xc7ktNPh/eThOxzyOvtCZ1uH3Lf2vZ+mpK9u9Jthg=;
        b=Z5zqMwfC9XB9j58INURSmaMJhL94aInX/iW07XSu+2d4Bjyp4cR/x/ecUoRvXFHD0I
         B2it96htyYjT020t0uxk26JYhUYNuXguLi45G3jV02gTgBx+U3dmxOOpEmgtjvBE0+Yq
         nW7ccOgHEQOgrw6nyuTgtZaRummi4rNZBYmJxFG26twD74pxMbtvVL9hB8T7DrO1j7+X
         F+RhtvT5uumZWjfRSE4jHlnKU9mYZ0mP0tw+GfHVoZhCa831W5TYsQO1zL69ICp/0Ffk
         Yfo+k7x4VYinjfgwRKSBXa2lq0/73c8CGGYs+RP78Cdx4Sn9i5SRs2hoyFHrXde0fhUY
         c55g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Evgeny Baskakov <ebaskakov@nvidia.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Mark Hairgrove <mhairgrove@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.16 010/196] mm/hmm: hmm_pfns_bad() was accessing wrong struct
Date: Sun, 22 Apr 2018 15:50:30 +0200
Message-Id: <20180422135104.717719826@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454894526944837?=
X-GMAIL-MSGID: =?utf-8?q?1598454894526944837?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jérôme Glisse <jglisse@redhat.com>

commit c719547f032d4610c7a20900baacae26d0b1ff3e upstream.

The private field of mm_walk struct point to an hmm_vma_walk struct and
not to the hmm_range struct desired.  Fix to get proper struct pointer.

Link: http://lkml.kernel.org/r/20180323005527.758-6-jglisse@redhat.com
Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Evgeny Baskakov <ebaskakov@nvidia.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Mark Hairgrove <mhairgrove@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/hmm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -277,7 +277,8 @@ static int hmm_pfns_bad(unsigned long ad
 			unsigned long end,
 			struct mm_walk *walk)
 {
-	struct hmm_range *range = walk->private;
+	struct hmm_vma_walk *hmm_vma_walk = walk->private;
+	struct hmm_range *range = hmm_vma_walk->range;
 	hmm_pfn_t *pfns = range->pfns;
 	unsigned long i;
 
