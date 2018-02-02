Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227VqQEnrx6ytbwDUL5w8MBAEQ1myJrTQTX/KTqIjPjKWZGTCbSxLrtxNWB7ink50b+Bp81u
ARC-Seal: i=1; a=rsa-sha256; t=1517590812; cv=none;
        d=google.com; s=arc-20160816;
        b=j4DkVmqqfu+RoyC1s5MTjcaNi+TbLW7NaRzzThbvFxOCtC2rxOqy4uFwfgS6D6YF2J
         xs82dJBCGPDfeqtQkb6XsnRzqOSpJieZTxGEGPxFEjCEE3Ygp1qDsDvVOcjl4Y0XKMK/
         PjNCsBHekD7O92+azxWE45IkmaP9QrK1AP7XKpKqYWkgNU71Ur4/NWibV7sv8HwxmNuR
         kvYKexv+J2JRu5WgKgVvmtrULX87m5/nuvrap4InOB0YjlIpor/FJQQ+twQTM5sCZG5J
         gg0+CGu4qttVjp4sWwoEu8Hu6EdCW7hO4a7xJY8x+BJiGg5QLYUNZcHX+5CrI//gbThL
         PN3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5cFXFyXVBOB2bcUbZZFUVEaCU7iYNhyfRubzLZQhfTE=;
        b=QbN/+OcfWay08ICP0FxKhfdw+LDYZL/dMa5XBmKkrH9fCE42ygEgfwW4+Rtvm6rFSk
         vXBkwrOHhQc7Vudl0arcMUvML4tDbYCc16VbMfOFxIjFqf6KiufSPevKPsS9THCe2v6v
         oQ30A1RiUaJ437je/dMCdIB9Z/UPYzXKcqX7P6/F5CLlaZwnDiraGgi/ie2jL3tvCwts
         4KVu35ECqPBDGzLSNJ5BiIe7oSFWpBiA22uFZ94pmVo1W1r26fXPWtbcREs6zyZCfObQ
         eFKstWZHX65pzVUdqdHPLpT0enyUOR7tLmTnOgjT7+8quYXAWyD7hzcWo9PJAWylyhY8
         TvEA==
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
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 21/67] KVM: x86: emulator: Return to user-mode on L1 CPL=0 emulation failure
Date: Fri,  2 Feb 2018 17:57:50 +0100
Message-Id: <20180202140817.686550277@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309303116688752?=
X-GMAIL-MSGID: =?utf-8?q?1591309303116688752?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/x86.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5153,7 +5153,7 @@ static int handle_emulation_failure(stru
 		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 		vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_EMULATION;
 		vcpu->run->internal.ndata = 0;
-		r = EMULATE_FAIL;
+		r = EMULATE_USER_EXIT;
 	}
 	kvm_queue_exception(vcpu, UD_VECTOR);
 
