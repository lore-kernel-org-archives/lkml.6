Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224M1CvVkNZ4uhqvP7aim+Me7CEv1u/O8GApqpzZ+zA47VejIEbv+aeLHwTODXwjx35ipxbS
ARC-Seal: i=1; a=rsa-sha256; t=1519411300; cv=none;
        d=google.com; s=arc-20160816;
        b=CnypD+YIQfXhuvbaTDcuHA9C8q8MhUs6ZOZG3NKVUsAlhXP/DIwvMS/Xclx+BPt4yV
         CPZw/t2UKtx9p6v+B/relqxQ67HGPnMKB8g4Wms/URP33wvlOKEpGzGtZzGaHA7LKRuu
         rNaWGPw1ChMGpzR/b5p/zP3L3Fzk8OdVcblvMoMnYtqzXGGtIOPi4G+yb05eJJ/XkXBi
         lykjmMu/x7Qmx3qfoN5RrdlJcEPj3FOa51a6WKScFMrjepnxTrr3VlMD7Mw8XyWBuEOi
         H55+FArvkIY+Mck6M00tVQQ/nyqd48JhSDvc1meC9zxejIHniEIwRFqUQH1OVqC8jt3k
         cavw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=trXJtMHPCOP+7yTpnwbNEPO+eLDAAcb5ojejMzntGNw=;
        b=0t2IMBBLHM83xkjrUAVucyiz0Hh2uWuIV6PcRNNkJHTFK0FgTDPbvCY4dumyou9dxY
         fRGu0N3M2XQl5QnodvPL5YG1ZTlaeKCvCHJOgMjrGoQaPvP2lX5Dw+FaxEBFNgBVg/s7
         7LIYNiN2PckwS37NS8pTijoRELtK+7EaO0BwgofQJ+f79kdqVVoXK4AtRVyzn0SJr3rU
         inBuaADT6zn11WoP6HbNyacMIhaIXUuvqd0pL8XOC83p9138LoMTR7yhE/Xezj/ktOLg
         h+Kwg2lIdv7SkjRa/f9sIq9xlD8n2Ui0a9ZGhRaFKlzOpBRv7E5WFW88K9V5dCXJXeF6
         0heA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 4.4 188/193] KVM: nVMX: kmap() cant fail
Date: Fri, 23 Feb 2018 19:27:01 +0100
Message-Id: <20180223170355.693925681@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218223869079414?=
X-GMAIL-MSGID: =?utf-8?q?1593218223869079414?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Hildenbrand <david@redhat.com>

commit 42cf014d38d8822cce63703a467e00f65d000952 upstream.

kmap() can't fail, therefore it will always return a valid pointer. Let's
just get rid of the unnecessary checks.

Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[jwang: port to 4.4]
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |    9 ---------
 1 file changed, 9 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -4532,10 +4532,6 @@ static int vmx_complete_nested_posted_in
 			return 0;
 
 		vapic_page = kmap(vmx->nested.virtual_apic_page);
-		if (!vapic_page) {
-			WARN_ON(1);
-			return -ENOMEM;
-		}
 		__kvm_apic_update_irr(vmx->nested.pi_desc->pir, vapic_page);
 		kunmap(vmx->nested.virtual_apic_page);
 
@@ -9238,11 +9234,6 @@ static inline bool nested_vmx_merge_msr_
 		return false;
 	}
 	msr_bitmap = (unsigned long *)kmap(page);
-	if (!msr_bitmap) {
-		nested_release_page_clean(page);
-		WARN_ON(1);
-		return false;
-	}
 
 	if (nested_cpu_has_virt_x2apic_mode(vmcs12)) {
 		if (nested_cpu_has_apic_reg_virt(vmcs12))
