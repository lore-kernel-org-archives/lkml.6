Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224uc/+CFTwYQ+/T8pdV1lhomS+RaK3WL53BsTZC1zREWM6ADK2NTM61AapI4sVsPBdhX7R6
ARC-Seal: i=1; a=rsa-sha256; t=1517591105; cv=none;
        d=google.com; s=arc-20160816;
        b=XDobfAADZIjF6VK9pcKyVLZ+RnlWCBxIKvaGFfzbF0wL4j3q/1DqUtJzUo/c5pW3hI
         8DLwk1UWsuX+ZSd/hDYS2J8DG/BPeLrUHGWIKszWJTez8uw/20pb2T8W6rF1o86eDaWh
         uMGcYLzqXXr1sTCNoVDhRewBNQ7yt5ExL9TjEYXSUDfZTebzn0Tjy7One7YuJLwB4t7z
         PVtWGO7WVJw+3DKhH11swVm+rRA6z5Pl+HgZlSk3bx0XGbIpsZcDBncntZ0JeZZd7Zzy
         rxNampWtAxwSH3PCp1xXD2Y6NWcFKSifvMphDbkDucQfG5VdhwYLnXQarrBvctuxIih/
         hPDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Esku0FL3Bl7hWFgrA9k/m/D7RapOcGpT/Xgz6L5TUws=;
        b=AbQrBth8nM+B0xPyr7r8tqUd3klR9xlK9G0bdFFce0TyxqOhPoJAwuxLDF4Ld4jaQu
         5q7bgazOeHRu92s5f1wobd97aGmKRmQhvjL20DHllu3gJOJ03eyRt9Hi1mzt6LrPPEss
         48yIvjNZomeeJ6V+TS54jqGdIvI9PvKB+Y1A8TvLge+0oEawjvs6EgCmZ71rcG8t/12+
         Qr0pVqkEVwEJnI0rIz3ID6kDdAmMmqkBIDgLIrF32g1varcVL/5fip35sGlJjmV/5Gjh
         AhugvczRwzUbSnMmkT7ed33kFYzzw+iFPg17guI6uOdUjiv4SE1qot6ENT9l2KzAea5E
         OqXw==
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
Subject: [PATCH 4.9 20/86] KVM: x86: emulator: Return to user-mode on L1 CPL=0 emulation failure
Date: Fri,  2 Feb 2018 17:57:40 +0100
Message-Id: <20180202140824.609324467@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309303116688752?=
X-GMAIL-MSGID: =?utf-8?q?1591309610952442297?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5308,7 +5308,7 @@ static int handle_emulation_failure(stru
 		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 		vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_EMULATION;
 		vcpu->run->internal.ndata = 0;
-		r = EMULATE_FAIL;
+		r = EMULATE_USER_EXIT;
 	}
 	kvm_queue_exception(vcpu, UD_VECTOR);
 
