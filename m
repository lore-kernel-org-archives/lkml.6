Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225qIhJ4Slb4prEyHcu20+O7rsNKDHt5fvYchs6NKOPBiQgScUxZVj+UOyholz69uS5Vk5Ht
ARC-Seal: i=1; a=rsa-sha256; t=1519217916; cv=none;
        d=google.com; s=arc-20160816;
        b=t6T5AAQAcl2bd9aVxTC8lZhjyp61Vmj78yF/6J68wf5BgfkAeEc8t7hd1M3L/uG2eC
         QNM64OhDDiAO02XljxxvcGdVGTAR/NB1thed0fNMYCmdH+4vkuItKM+CHOJJO2JTBaQl
         pNiYiTziXcCt/sC6x2ouqrngDTEwLe3koPH3shTZfhXOLRkkheiQ4GX3ZaTcbKiXgUWD
         DRi7o3H+0lWJqnPEsBxrcR0aRXk6byhk6NAaZYUJwUO4tzXhkW6sgmOCHtgQA8uBMs0K
         ++rWz8IhfdEy2YO34g8I1nuQ/oypENl3XYmqz0L/7bFdzlX+w2iJrJXpwAAj01uzg46Z
         nccg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nOX/y/0NpW7XAca7kZjYAt8iWbl9SEpT3dHzurtOG3o=;
        b=PYirJqHhojjrrNXlvgK9tVTsMdA3B00utKQs/XMscvBDWAC0qc1LJJxZtp1gsGfQKN
         AVkT8H6kWIAbZsWJv6iNbu5NYZ1beD7GMx+MdCWu/BQNprtPvAAcdx1yAFR1tRgOJmdI
         z9hsvcvSa9ygdZ7MquRTyq8zHSN9nBcO80giKXijKRGPwqJUtk3ebyCQepRUZiVdKLyb
         MgHf0uetT3tQiYFVB8NZYIwe9nglLWuNNvXHXAeEp4gTkJ1fT8I3En4Ng1hWuBR2/CSZ
         6HvPa+WA9DERRxrsPnNBuxAJWlnMXDH52a3Ft3tsMWPb/roC9CxC8updB87jH7fjc1iG
         Cm4g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Pedro Miraglia Franco de Carvalho <pedromfc@br.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: [PATCH 4.14 023/167] powerpc: Fix DABR match on hash based systems
Date: Wed, 21 Feb 2018 13:47:14 +0100
Message-Id: <20180221124525.888731903@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015445978597806?=
X-GMAIL-MSGID: =?utf-8?q?1593015445978597806?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit f23ab3efb1b30cc5c5ef5ae4ef294ed467f30675 upstream.

Commit 398a719d34a1 ("powerpc/mm: Update bits used to skip hash_page")
mistakenly dropped the DSISR_DABRMATCH bit from the mask of bit tested
to skip trying to hash a page.

As a result, the DABR matches would no longer be detected.

This adds it back. We open code it in the 2 places where it matters
rather than fold it into DSISR_BAD_FAULT_32S/64S because this isn't
technically a bad fault and while we would never hit it with the
current code, I prefer if page_fault_is_bad() didn't trigger on these.

Fixes: 398a719d34a1 ("powerpc/mm: Update bits used to skip hash_page")
Cc: stable@vger.kernel.org # v4.14
Tested-by: Pedro Miraglia Franco de Carvalho <pedromfc@br.ibm.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/powerpc/kernel/exceptions-64s.S |    2 +-
 arch/powerpc/kernel/head_32.S        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1617,7 +1617,7 @@ USE_TEXT_SECTION()
 	.balign	IFETCH_ALIGN_BYTES
 do_hash_page:
 	#ifdef CONFIG_PPC_STD_MMU_64
-	lis	r0,DSISR_BAD_FAULT_64S@h
+	lis	r0,(DSISR_BAD_FAULT_64S|DSISR_DABRMATCH)@h
 	ori	r0,r0,DSISR_BAD_FAULT_64S@l
 	and.	r0,r4,r0		/* weird error? */
 	bne-	handle_page_fault	/* if not, try to insert a HPTE */
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -388,7 +388,7 @@ DataAccess:
 	EXCEPTION_PROLOG
 	mfspr	r10,SPRN_DSISR
 	stw	r10,_DSISR(r11)
-	andis.	r0,r10,DSISR_BAD_FAULT_32S@h
+	andis.	r0,r10,(DSISR_BAD_FAULT_32S|DSISR_DABRMATCH)@h
 	bne	1f			/* if not, try to put a PTE */
 	mfspr	r4,SPRN_DAR		/* into the hash table */
 	rlwinm	r3,r10,32-15,21,21	/* DSISR_STORE -> _PAGE_RW */
