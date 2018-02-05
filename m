Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225ttRxD3DT7PRDnsEmfVIxz2pA+Q495GjXQnKYLw+B6T2j/ewpV9J8ONXeSQpoVzKcQn3fz
ARC-Seal: i=1; a=rsa-sha256; t=1517855171; cv=none;
        d=google.com; s=arc-20160816;
        b=fvmWehOtm9IbLrJSlaJyta0bIIzyMU5oWTm2X4Ettd93sr16wHl1Fe3CjidkI/W5g4
         yfPzhrN9z+BNgCUSF9GK2nzyonHgQ0S342qniofod41MSy8VufLsGVSE/YmnL++7Be6m
         sj2oXTw/Gi/6thnmNrYD6o211+g21XBCR39SDo94k9FpSyrnm3A5Fj12CSTmqQZ+4rPi
         GIW3Rc3PutKsIyB2sUW+9PZpr+4ZcPNY6HCjJ7nw7XDxi2LEJDqEMTjugYlnxlThfMPp
         f4E38YJatMrQmXWuXplinjUJyUQZfrwYu7YdoShRYNuL+gasUFHq9YW+esLobBCHNCZy
         PDCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=F/hzGlasSPkrikwKxwcuFv62Bp1IbBw1FrasY0gb8bg=;
        b=z7SidumJ+VJ5fVOVsB3+v3QSzEsYo65qjR5gAVT6kFBHZ/pzj8noQk4U+k4SNA47xs
         AQiMD39ZCpzws1lMEK7Gc6VlBF3/8qhzjP0HHFWYi2cNj6bduniG5YHEVJxRrdKsgcPw
         FXz4g+9CaO/pjT+fgc/TFSFikkGHbJ8mFCyn6m0Glzaq9FuQ6keVTCPMGs2vSgbZ1TZB
         W+KNRXwy7GW/4JRSMD/sEHC1OX3N2yW3YHP4wQWKo/oXYqpq+iuKTVdeuCoLHahdExhz
         6nGKbZJ3nck5BiqaxTa4ZI8uwkrBga53aChefx5cPYo9lE/sOdalicKgRltAF9qScPfs
         imjg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Liran Alon <liran.alon@oracle.com>,
	Nikita Leshenko <nikita.leshchenko@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Wanpeng Li <wanpeng.li@hotmail.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 10/36] KVM: x86: Dont re-execute instruction when not passing CR2 value
Date: Mon,  5 Feb 2018 10:23:38 -0800
Message-Id: <20180205182352.204595814@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586504784976644?=
X-GMAIL-MSGID: =?utf-8?q?1591586504784976644?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liran Alon <liran.alon@oracle.com>


[ Upstream commit 9b8ae63798cb97e785a667ff27e43fa6220cb734 ]

In case of instruction-decode failure or emulation failure,
x86_emulate_instruction() will call reexecute_instruction() which will
attempt to use the cr2 value passed to x86_emulate_instruction().
However, when x86_emulate_instruction() is called from
emulate_instruction(), cr2 is not passed (passed as 0) and therefore
it doesn't make sense to execute reexecute_instruction() logic at all.

Fixes: 51d8b66199e9 ("KVM: cleanup emulate_instruction")

Signed-off-by: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Wanpeng Li <wanpeng.li@hotmail.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/kvm_host.h |    3 ++-
 arch/x86/kvm/vmx.c              |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -849,7 +849,8 @@ int x86_emulate_instruction(struct kvm_v
 static inline int emulate_instruction(struct kvm_vcpu *vcpu,
 			int emulation_type)
 {
-	return x86_emulate_instruction(vcpu, 0, emulation_type, NULL, 0);
+	return x86_emulate_instruction(vcpu, 0,
+			emulation_type | EMULTYPE_NO_REEXECUTE, NULL, 0);
 }
 
 void kvm_enable_efer_bits(u64);
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -5707,7 +5707,7 @@ static int handle_invalid_guest_state(st
 		if (test_bit(KVM_REQ_EVENT, &vcpu->requests))
 			return 1;
 
-		err = emulate_instruction(vcpu, EMULTYPE_NO_REEXECUTE);
+		err = emulate_instruction(vcpu, 0);
 
 		if (err == EMULATE_USER_EXIT) {
 			++vcpu->stat.mmio_exits;
