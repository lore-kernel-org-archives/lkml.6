Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AB8JxZoWfMtHJUD3MOIonRlwSFGZJkxGAeQHKDk85mmbf4q1TH9p2WsHu26vMc68gqAhcyJE/m8w
ARC-Seal: i=1; a=rsa-sha256; t=1524653010; cv=none;
        d=google.com; s=arc-20160816;
        b=bZJ4kTTai655WyBSw1RIf7aoqUe8VVBdYtXkjYdPRQbYZOnPPoG4my8idW48MgAd0l
         vDnuTb2BKTjLsuphBtgQtoyvO7AKZRjHRBlIeOPorl6JHhhGbPqlIyKqKQtzotjeYZLt
         Isf+3M/qJiKw+9VlxoWlMIdULKsOG+lcQIarIrP8AFcexPN5heuSYWYBen6ZKdtHFcOk
         yxDx3kzec/q4wVzIyRJOrwDu/nqRB4L0Ud4InnOi8TsHid7Uasn+1Q/o6Oaj9tt1NpFK
         bDl6rpjvCrM3QMl3avI97yeudpPQMInxzbS+1+KDyuqpaKggTOT//so+WPQiRULIHvRB
         UYmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=K7dxIPf3nzbTyl5qrRIBsLn+f8RSHeZcSvNZHIA9MOU=;
        b=vCApXU67byuGr5qylH9ZpeIbHzeb+Z8VWjTlLTUgL37yaj8X7NB7UuJFpb0UOqupzB
         2NDNMeSCiuK2fU0DYNEFmS/VTnM0joxzAlV4Fr1NLLXdPRWnNjBHyX5NWlonbflwHel3
         v3kvcvnxtLbBQoQ3Oeg6L9rI+IV1+K1+awm12v3YOMGFrCqm35xF6/X4ygpqT+FAP2pv
         ahi7j4GHRvX2XfujyT6rdHMgVoxmJntm1HwpU2iCfu7ylqU+LASYhR1BX000ch6G+j2d
         1pyDahtIgppnCbPt1FX+2oC1TKITRKCdE8peM9s8V23rew4t7fUd43K4ancA8/+FVUWl
         e+0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	kvm@vger.kernel.org,
	KarimAllah Ahmed <karahmed@amazon.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 105/183] kvm: Map PFN-type memory regions as writable (if possible)
Date: Wed, 25 Apr 2018 12:35:25 +0200
Message-Id: <20180425103246.671364610@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714555037361339?=
X-GMAIL-MSGID: =?utf-8?q?1598714555037361339?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: KarimAllah Ahmed <karahmed@amazon.de>


[ Upstream commit a340b3e229b24a56f1c7f5826b15a3af0f4b13e5 ]

For EPT-violations that are triggered by a read, the pages are also mapped with
write permissions (if their memory region is also writable). That would avoid
getting yet another fault on the same page when a write occurs.

This optimization only happens when you have a "struct page" backing the memory
region. So also enable it for memory regions that do not have a "struct page".

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 virt/kvm/kvm_main.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1434,7 +1434,8 @@ static bool vma_is_valid(struct vm_area_
 
 static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 			       unsigned long addr, bool *async,
-			       bool write_fault, kvm_pfn_t *p_pfn)
+			       bool write_fault, bool *writable,
+			       kvm_pfn_t *p_pfn)
 {
 	unsigned long pfn;
 	int r;
@@ -1460,6 +1461,8 @@ static int hva_to_pfn_remapped(struct vm
 
 	}
 
+	if (writable)
+		*writable = true;
 
 	/*
 	 * Get a reference here because callers of *hva_to_pfn* and
@@ -1525,7 +1528,7 @@ retry:
 	if (vma == NULL)
 		pfn = KVM_PFN_ERR_FAULT;
 	else if (vma->vm_flags & (VM_IO | VM_PFNMAP)) {
-		r = hva_to_pfn_remapped(vma, addr, async, write_fault, &pfn);
+		r = hva_to_pfn_remapped(vma, addr, async, write_fault, writable, &pfn);
 		if (r == -EAGAIN)
 			goto retry;
 		if (r < 0)
