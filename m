Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqiAARGpGWbGJj4Vwdsm2Rfim1+ii8UtljAQ5fc3k5QXEOxfZi2cWlJZfPXp0p2M9QS+XC3
ARC-Seal: i=1; a=rsa-sha256; t=1526280941; cv=none;
        d=google.com; s=arc-20160816;
        b=PqmasNz2j55aGtUOIup8WmP1hLzMY3GhfYZ8r/pGXFY1ZvrXtMrpsmePejEReheHKS
         RG5OgPwPtbnq4YKq/Wkj8B1PAWqXUiw5guVO3KZ+zyUSBLLRdKOAd4YQF39hb9O53gc7
         ogJ7TNj+1TwR2PecsJUHPZ8eJ5KOpIzOV20E4Vqp7BAyKmPJsHux0hQkmyVFTOl2YQrh
         UAMcQ8A71GiX83WlOrBsEtvA0nPiVQP+w94x1w6AHTx9f26ECPIBKLjB4iCB2gmGMDs8
         o4g8j3Jpb3poDn/JHhyomUjV7CNrEne2NhiyO8/kExCXfV5Y5t0fBjlualBqfiRcmPSU
         cJeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=dmo//c2Vw+cID+vV1/sln7AfHWpah/R32PvAACHPbD4=;
        b=Sun1RD15n7ajsN8fWY1jiTWGEqa9PtoVL4MiEBScGGvMJoVLX7xxNFjklLk9P0Vmbr
         TJ5oqjRlkAUhRJUSkfTfKw+ta1jAY0QvRH9mGhbgY4U8J1S0vSa5edo6D+WOWte1dlnu
         /8QQ4aBdrAsSd6oG05CMGsQ5HXZKZE3MupK7MBa1iS/35JatzCJ9c/c5AQEPaCnmKfEa
         3OmtA2zhvvhB8g9WfoTA1q3veQ4h9yPrTZAVy4NhQfqWUtR1lsPdOPnRjObIpdmFfAB9
         oXO4r6OJb/3/ju/11QCoHCSAU8zx/JM5EspV1YFLeNjKEtqRHwQesInaHRgZRf7NCxXD
         BSHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=lzpKAk2q;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=lzpKAk2q;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH 4.14 20/62] KVM: PPC: Book3S HV: Fix VRMA initialization with 2MB or 1GB memory backing
Date: Mon, 14 May 2018 08:48:36 +0200
Message-Id: <20180514064817.540238713@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421564375442614?=
X-GMAIL-MSGID: =?utf-8?q?1600421564375442614?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Mackerras <paulus@ozlabs.org>

commit debd574f4195e205ba505b25e19b2b797f4bcd94 upstream.

The current code for initializing the VRMA (virtual real memory area)
for HPT guests requires the page size of the backing memory to be one
of 4kB, 64kB or 16MB.  With a radix host we have the possibility that
the backing memory page size can be 2MB or 1GB.  In these cases, if the
guest switches to HPT mode, KVM will not initialize the VRMA and the
guest will fail to run.

In fact it is not necessary that the VRMA page size is the same as the
backing memory page size; any VRMA page size less than or equal to the
backing memory page size is acceptable.  Therefore we now choose the
largest page size out of the set {4k, 64k, 16M} which is not larger
than the backing memory page size.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kvm/book3s_hv.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3618,15 +3618,17 @@ static int kvmppc_hv_setup_htab_rma(stru
 		goto up_out;
 
 	psize = vma_kernel_pagesize(vma);
-	porder = __ilog2(psize);
 
 	up_read(&current->mm->mmap_sem);
 
 	/* We can handle 4k, 64k or 16M pages in the VRMA */
-	err = -EINVAL;
-	if (!(psize == 0x1000 || psize == 0x10000 ||
-	      psize == 0x1000000))
-		goto out_srcu;
+	if (psize >= 0x1000000)
+		psize = 0x1000000;
+	else if (psize >= 0x10000)
+		psize = 0x10000;
+	else
+		psize = 0x1000;
+	porder = __ilog2(psize);
 
 	senc = slb_pgsize_encoding(psize);
 	kvm->arch.vrma_slb_v = senc | SLB_VSID_B_1T |
