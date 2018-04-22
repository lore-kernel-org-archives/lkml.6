Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+ZC1MI4B3v1zvtiJdwZymreLj7hoVoedX7L1q6xne/nr9tOqVb5OL6wybQaNV1RfDJib7C
ARC-Seal: i=1; a=rsa-sha256; t=1524405892; cv=none;
        d=google.com; s=arc-20160816;
        b=Q17TyYDshtPtrV4N6q+lMnqSa+qbiG26T2iCqfQD2eJ8GdxNOe0dDUR+A+ITBdbhrF
         mK2ZwSHTojMfbUGq+qAY8pEoHdCEDUG5LJ66FUc/B/srbT4tfmYrAcaccmWDyM8AA04E
         IAj0Ccrkm/wFNbilC1KyZ3Q3p+7Fhk4WHCOCpl88gJQ+JGq41jVA27PW6BXB/uw6ksmY
         OBtJEbF1M1ZUSXf6+lH2N9cia2uTqfBl7ir5D7EnXwDpr3aOkO49K+sGOLmesBDlqG6n
         NbwMtCNfnFqC87xZd7sg/PIQYGP1fPHdp9BDCIf/ti9ytoatvcyM03TWKNh1gpcc8ndY
         64rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DMIykGJ+2Lohdd0u4II/C7Ohu2IwwU9YcA1oz/YEoEI=;
        b=lJDlLHLzgOHGQt2m6yRqnTW12PTi8tp/AFg9cHz7upQmOdzzmFHgkuJa7cLo1UQkg/
         DyF79iSpSGdCiK1wdF7WHxi3+br/n+wbnZ7hw8WS2s5P+I+VaiCYT7q0YNP47mT0GDJ5
         xklWBpxL74kFPLveFhRNNHK0N8fjFaL6unZDpbIQdlNpIzyphUbK+XvFp165lvIa45aB
         GMc+wt3CROZJN1TlwnVpR0T00CoIwyahYwls0sMkIPynxfL88mp5uGTQbTWR2wDEC2qI
         +8vE0pCI39gWkoSdh7oodlM3XKlz7S6T8cundUe6JjObqk5HQzl6OpCTgfboXVCG1nQm
         P7Wg==
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
Subject: [PATCH 4.14 009/164] mm/hmm: hmm_pfns_bad() was accessing wrong struct
Date: Sun, 22 Apr 2018 15:51:16 +0200
Message-Id: <20180422135135.774796494@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454894526944837?=
X-GMAIL-MSGID: =?utf-8?q?1598455432916805707?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
