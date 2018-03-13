Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsQ8/6cqsz6mobeIEQQh75f+mqSKS5/pZGerNPaJAbVa9ZD7xbv3Z6bTqVqtkAF3+fYyW6p
ARC-Seal: i=1; a=rsa-sha256; t=1520955033; cv=none;
        d=google.com; s=arc-20160816;
        b=RyGwruInxn1cmSogDbVu2P455LxKgn+D+fZdWT7uKS8j6vso0fTWq4JmXL08W1FMVP
         nPwDiT02hOdrcEhOz3noh2Pc8bsdcG7W9YWyIPU8JteA4uoc2lnRbE10tu6YbqwL66O3
         /CW2bR59Xx7zTxfVB5NK3TMXF6yQu2sk2HkbEcipgHF5QMYvhLj/yGFJdo7xrQDFv1bh
         K75bRTrsCcbmNtDmgQGwiug9TxA5vjVIysxtxNlPZNLwfCIPatPx+gjRc60LrLAySK6Z
         ZoL5wfbEG9t+3FkDAiW6g3lXCLBzoTLspaIdfDhRkGZe1uxA5sOUxUET7a90aF9nJz8t
         wQow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=n2sDtL28jD8LxC5Zrb+P6i3f7ykOQ/v8THrmJ6pbz7c=;
        b=I0KH7RtmyrgRNltuKqspinjtE6UJNgyFlkD9qPnepo0pl42qIpeqSKHhzhwFjCSTE4
         w2sUl9CXzwEaPQPDzQsfy+QYJb+cUJWbBErhSXgYqTQRht7BFj0V6ET8vIQTiDeLAWAS
         SN0va8d3vLqyJn2jFbzNu+4sLXAPTU445EmLcRb2wzPQSwJiZAttzddrW2GGwhYd+rDY
         6CC7aUiR/4EbINQFqmeEGGPyQy4ZjL9zYHnX1cSOFoWSIvnGLlIHBojKeyypdDga+KxQ
         nqbEhKfL3pmttVc7lE0xMqzzuk/BrMFoQIpND5MgZzD1B/laDyqPDLfgTgSnN8cIO11O
         tzVg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Wanpeng Li <kernellwp@gmail.com>,
	kvm <kvm@vger.kernel.org>,
	=?UTF-8?q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 4.15 065/146] x86/spectre_v2: Dont check microcode versions when running under hypervisors
Date: Tue, 13 Mar 2018 16:23:52 +0100
Message-Id: <20180313152325.709436160@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836945138568039?=
X-GMAIL-MSGID: =?utf-8?q?1594836945138568039?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 36268223c1e9981d6cfc33aff8520b3bde4b8114 upstream.

As:

 1) It's known that hypervisors lie about the environment anyhow (host
    mismatch)

 2) Even if the hypervisor (Xen, KVM, VMWare, etc) provided a valid
    "correct" value, it all gets to be very murky when migration happens
    (do you provide the "new" microcode of the machine?).

And in reality the cloud vendors are the ones that should make sure that
the microcode that is running is correct and we should just sing lalalala
and trust them.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Wanpeng Li <kernellwp@gmail.com>
Cc: kvm <kvm@vger.kernel.org>
Cc: Krčmář <rkrcmar@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180226213019.GE9497@char.us.oracle.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/intel.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -144,6 +144,13 @@ static bool bad_spectre_microcode(struct
 {
 	int i;
 
+	/*
+	 * We know that the hypervisor lie to us on the microcode version so
+	 * we may as well hope that it is running the correct version.
+	 */
+	if (cpu_has(c, X86_FEATURE_HYPERVISOR))
+		return false;
+
 	for (i = 0; i < ARRAY_SIZE(spectre_bad_microcodes); i++) {
 		if (c->x86_model == spectre_bad_microcodes[i].model &&
 		    c->x86_stepping == spectre_bad_microcodes[i].stepping)
