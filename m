Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225LB7mpgOoJDJCvOReY0qHmUPw5+TQnervs4IvFm4LwOiTvU86iwjaAPPdlCd554qZ5kKh4
ARC-Seal: i=1; a=rsa-sha256; t=1517855210; cv=none;
        d=google.com; s=arc-20160816;
        b=tpQI8cG4JfM4+IobyPss88nFy7lArc8ZNpIPf9pRQPlfP31GJik+ipJgAIOrmjWtAW
         Urt8gD67xUBBD6MkKjeybdL8Rc38Lm/iZiDJ9cIxeTirzF6Z1jPLiol9ZNVcR9R7VX3L
         6fzCSmljRZXExncBvfeowIC/FA1vhIW4fvThItKaOeSau0XRDG0aSeL063hvRsD1O4A1
         Os/CGIxAlCJYUQm/e9URIUQ/J1dibzH7lWDa55zeOk0YVnAxtMwBYoYkiJW7Y9RySEep
         ZhMHawh+i4HFZw7KypvRfH51GsX6k/jIu/lV2hEKpOLJHEgVFQvz1lpW8ELrSdy25l8s
         F5FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MIN+ci1deAFs/m8VJ+RThw21P1X9cWZdbdHVkBEp9m4=;
        b=X0WkZ5cd4i0DDrWalRMrT530n5udiOiIG5QRhvFMK+ImLljA7iI4N6AFaI/fGtouWa
         ELnmHYmIP+PS11dD8C1pGSEw0MI/CepHOML0MijX/46mtmyL/APebRT9jnBsGFqBkVLO
         9swemusUNl65aoWF2u8TMxfMbkntYYIyQ9J42klpTUifWqXOInw7OWvhJc02to14Y1h8
         2l6HDa8rdKpu/Hv6j2dNjv1gjCfz28IT97ig4yNfJWOnYddtkCCaO+kA2jYxHFvYwNRf
         GGR0VBRLbJpVt/eM+cAtermxwe3DN+4zdBj5c+rulehK87XzJc2lMIByaMZRdnts+1pH
         LxgA==
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
Subject: [PATCH 3.18 09/36] KVM: x86: emulator: Return to user-mode on L1 CPL=0 emulation failure
Date: Mon,  5 Feb 2018 10:23:37 -0800
Message-Id: <20180205182352.162500091@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586545133110618?=
X-GMAIL-MSGID: =?utf-8?q?1591586545133110618?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5109,7 +5109,7 @@ static int handle_emulation_failure(stru
 		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 		vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_EMULATION;
 		vcpu->run->internal.ndata = 0;
-		r = EMULATE_FAIL;
+		r = EMULATE_USER_EXIT;
 	}
 	kvm_queue_exception(vcpu, UD_VECTOR);
 
