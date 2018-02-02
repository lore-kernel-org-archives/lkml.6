Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224HNA0sRT/LqdnjHiCUrzF1GWF9ckqQxl8CYi2wB3jZZnJiPubYc0gChTAl1BaqAd5RUcKP
ARC-Seal: i=1; a=rsa-sha256; t=1517591414; cv=none;
        d=google.com; s=arc-20160816;
        b=wtJPMNoYO7At3NwiNuxNWkLfVd/KYfZU8jxWnDiWOATVApkY+SwAX5dUJGegRI48fF
         jK0kgMwMZiO8gK2KBeWGA9tFZ/IWJBl3k9aDbR1WSKWI7vqw1CAcyQzcT2phTrlQtmap
         4mSr+l5iT7/jwKmLuw2U59S/LiqOiT3ji+7MbzuggwiKpqb5PFaRCdNOcvfAoLXOEV+q
         lpyrWgvgA5NjPreuHfwuToBRocwih2GeNE/iOTtWRV+FaxqTIfKiGGdpiLYABocJX6J+
         F6BrxJgSlTo0h1HmiGDX11ExBZfyJ8Zu9PuycytQPIUU+HNG9sZKU8ldSRdeKCdMmVHB
         f/BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4o7rZhWk3rLxzMsANYGsXviTmq7MBA+iuCGx7vAkJPI=;
        b=FOrCbWkXCnlsfxCOioWM+yj+Geai5BqX3LnQc1WBlPWKVX5yV1EQUfkRteZ9uDv1U9
         lGButK8fCzqUJmpVuHCdRSklbCW+IDfc4e2YxaPrhrNSypAL5PB+80QxBIR/J0dd/Vf+
         Zi4GOkIf3NvFL7987VS4XkbviMH7qrdnXjW2Ip4duYjPpRoyNPvpeePmzcatzXGZ3gFZ
         geugkqqBO4qvrI3zSTMCrqKqIpEFaSW5JxhoKMAr+cmSLNYT3QPq5ndktF5tovQwyKMZ
         bDTW3z9tZ22wZzIVugL4wBYPhoF1JuBA6rG1C2ByCtYWiT8HVwkPk/yxxFIbh39e39Q+
         X/9A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Liran Alon <liran.alon@oracle.com>,
	Nikita Leshenko <nikita.leshchenko@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Wanpeng Li <wanpeng.li@hotmail.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 037/156] KVM: x86: emulator: Return to user-mode on L1 CPL=0 emulation failure
Date: Fri,  2 Feb 2018 17:56:58 +0100
Message-Id: <20180202140841.977533176@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309303116688752?=
X-GMAIL-MSGID: =?utf-8?q?1591309935831558941?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liran Alon <liran.alon@oracle.com>


[ Upstream commit 1f4dcb3b213235e642088709a1c54964d23365e9 ]

On this case, handle_emulation_failure() fills kvm_run with
internal-error information which it expects to be delivered
to user-mode for further processing.
However, the code reports a wrong return-value which makes KVM to never
return to user-mode on this scenario.

Fixes: 6d77dbfc88e3 ("KVM: inject #UD if instruction emulation fails and exit to
userspace")

Signed-off-by: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Wanpeng Li <wanpeng.li@hotmail.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/x86.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5416,7 +5416,7 @@ static int handle_emulation_failure(stru
 		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 		vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_EMULATION;
 		vcpu->run->internal.ndata = 0;
-		r = EMULATE_FAIL;
+		r = EMULATE_USER_EXIT;
 	}
 	kvm_queue_exception(vcpu, UD_VECTOR);
 
