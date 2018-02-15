Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227fWNJpxPoOjwFq0wPk6l0JNGVDXeKDgeaTm3KVqo8G9gYsiLndANqwkt5h4XHexEN5uwfb
ARC-Seal: i=1; a=rsa-sha256; t=1518708703; cv=none;
        d=google.com; s=arc-20160816;
        b=SHZyeF/DoWGy4LmpAu1gPqxqjpw3xwyJNT72+/S/iY1AyZoIRDoKpR5b6OMyaGqJAi
         EpaZ6hSF/kmzSQQoaXpbOv5R0dt+x6jUeom5eueLb26Nr1JqzINdyxnxFywAQybWD4GV
         +ui3wUspURmn4lC4U+BXumojxnwYJYL4SugdGge5KTGGpr3XDhiK13SERAw3L3d2ClAC
         GpXHs4pR7RQU4wZe8vOlIWAKIrvbyI9bG9jwuHLyAgNGmKo+oBHzcC2S2JSowv88AvWy
         KykJsPO7sd1DzZ2kY2WrpfPyOusUIaZ+PHiLou9aNmKBT3Ponu+66GmEVAZ4KaMYtteH
         uahQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=v0sSDV5B+gn5GbMgmhDOMWg92FxhvJ+kBppV13C+avs=;
        b=VLD6pxfiqVtp13enxtSAlMysAnd5cmOnW0cUbbpWqFcqwGb8KmkZGg+HuHr72hHQ/w
         osxce3FLJk8sQvB4Jl0tzxDeRWxodg32j4a9Evhtf/XJc+HPlA0QxDZheXzgm7BeJUfB
         s45CyXVJDDTHE63JGT59T9vW9AOgh4AkH8U3vpg+Gyt5bI7ZoK/IHlQ3cKEQYQyBhd8A
         bBXLReNTwX9Jr04iDTVh02IXTOwQC79IuNdv1CXJVOk5XRhja/5e1ik3m9msmZqnvMtX
         jzuLyqpAbiunMGFTmAjIrf5VjI4wr2HBxBkhJKVBtfYBcM45tQfX9Ue2GY4JjAvXdreX
         8usw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ross Zwisler <zwisler@gmail.com>,
	Alec Blayne <ab@tevsa.net>,
	Haozhong Zhang <haozhong.zhang@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.14 012/195] KVM MMU: check pending exception before injecting APF
Date: Thu, 15 Feb 2018 16:15:03 +0100
Message-Id: <20180215151706.351835188@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481497423068683?=
X-GMAIL-MSGID: =?utf-8?q?1592481497423068683?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haozhong Zhang <haozhong.zhang@intel.com>

commit 2a266f23550be997d783f27e704b9b40c4010292 upstream.

For example, when two APF's for page ready happen after one exit and
the first one becomes pending, the second one will result in #DF.
Instead, just handle the second page fault synchronously.

Reported-by: Ross Zwisler <zwisler@gmail.com>
Message-ID: <CAOxpaSUBf8QoOZQ1p4KfUp0jq76OKfGY4Uxs-Gg8ngReD99xww@mail.gmail.com>
Reported-by: Alec Blayne <ab@tevsa.net>
Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/mmu.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -3784,7 +3784,8 @@ static int kvm_arch_setup_async_pf(struc
 bool kvm_can_do_async_pf(struct kvm_vcpu *vcpu)
 {
 	if (unlikely(!lapic_in_kernel(vcpu) ||
-		     kvm_event_needs_reinjection(vcpu)))
+		     kvm_event_needs_reinjection(vcpu) ||
+		     vcpu->arch.exception.pending))
 		return false;
 
 	if (!vcpu->arch.apf.delivery_as_pf_vmexit && is_guest_mode(vcpu))
