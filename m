Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+JYYUYBznu4IS7yf4g1/xd6GgLRh5QY7z91axOTW8EDW3omKMVwQCfyzFDS9S0hJw9Usbi
ARC-Seal: i=1; a=rsa-sha256; t=1523472415; cv=none;
        d=google.com; s=arc-20160816;
        b=brDazcz6M5TcwVLXvqDfHab1CZMh2CNWXhxOkXfSaSs0AqoSsMO7cLPsXCBTjT6yyT
         J3cqyrJ2xyU7iupw6IL9kwvRO3eW/M8g2Mw20HRQlDURHa866+buDw7uvm81Qs225L5e
         nvnP85DWuxWm0PTrn/C+nWSOrR7FU+iqjOyeAsHUlZ9BijFYYzOxB+m3tN88RIonrTwe
         66YofuDvOl2iksII9DGQhoTKaVbAtjUFI9xdPZ/srrH2p0+RRQMF0a2INiI89yk21Yp9
         uVNNRqvIXIdUmgqHdeJKwsBmTQ9O75slzayE1qlLIr2uyB/NYeVI+DLFNQiT0W7IL7xy
         RIrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3so4XL8kDfwCaxLyAf/k/NHSocISugdWZAu6HM/NHq4=;
        b=zg1ZCWcwKGG3hZbiaJyVcLsGlCzHZ36ZIEva3I4VQWK/zvbefo3+nA4MRTu5L5EntH
         T5dQwAo7sVHMt0rDyeQ6T/RUsIbjrqQRZrdNKsqPqV0mbh0w8XtCrLkmekoyec1F0PAv
         Afs1doI4Nnq/xRsZHIfBXKzLFMT8eczmpQmIQnHkiNfFiwbxcjFP1iC7W6rvRbaaaXEz
         z2ciTj483qGDEfQs8a/XlOiaTO5XvNaJ3CfYWXGkaFJvW48++9NsYkphXqEZwv6teJ3z
         dqM7vd++iHkPmkCrb0JP3W0GErkzPO9q+rKAEYXfUu0N3M3zzAOUEnLnmXu8a4OPdygG
         rvEw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"=?UTF-8?q?Jan=20H . =20Sch=C3=B6nherr?=" <jschoenh@amazon.de>,
	Wanpeng Li <wanpeng.li@hotmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 079/190] KVM: nVMX: Fix handling of lmsw instruction
Date: Wed, 11 Apr 2018 20:35:25 +0200
Message-Id: <20180411183555.163798408@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476294885821216?=
X-GMAIL-MSGID: =?utf-8?q?1597476611366594762?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Jan H. Schönherr" <jschoenh@amazon.de>


[ Upstream commit e1d39b17e044e8ae819827810d87d809ba5f58c0 ]

The decision whether or not to exit from L2 to L1 on an lmsw instruction is
based on bogus values: instead of using the information encoded within the
exit qualification, it uses the data also used for the mov-to-cr
instruction, which boils down to using whatever is in %eax at that point.

Use the correct values instead.

Without this fix, an L1 may not get notified when a 32-bit Linux L2
switches its secondary CPUs to protected mode; the L1 is only notified on
the next modification of CR0. This short time window poses a problem, when
there is some other reason to exit to L1 in between. Then, L2 will be
resumed in real mode and chaos ensues.

Signed-off-by: Jan H. SchÃ¶nherr <jschoenh@amazon.de>
Reviewed-by: Wanpeng Li <wanpeng.li@hotmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -7657,11 +7657,13 @@ static bool nested_vmx_exit_handled_cr(s
 {
 	unsigned long exit_qualification = vmcs_readl(EXIT_QUALIFICATION);
 	int cr = exit_qualification & 15;
-	int reg = (exit_qualification >> 8) & 15;
-	unsigned long val = kvm_register_readl(vcpu, reg);
+	int reg;
+	unsigned long val;
 
 	switch ((exit_qualification >> 4) & 3) {
 	case 0: /* mov to cr */
+		reg = (exit_qualification >> 8) & 15;
+		val = kvm_register_readl(vcpu, reg);
 		switch (cr) {
 		case 0:
 			if (vmcs12->cr0_guest_host_mask &
@@ -7716,6 +7718,7 @@ static bool nested_vmx_exit_handled_cr(s
 		 * lmsw can change bits 1..3 of cr0, and only set bit 0 of
 		 * cr0. Other attempted changes are ignored, with no exit.
 		 */
+		val = (exit_qualification >> LMSW_SOURCE_DATA_SHIFT) & 0x0f;
 		if (vmcs12->cr0_guest_host_mask & 0xe &
 		    (val ^ vmcs12->cr0_read_shadow))
 			return true;
