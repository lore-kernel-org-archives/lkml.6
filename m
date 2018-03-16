Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsr5sjna4eZZTY7mUnlTOQyloYlik0jNt8e9Ff7N/BJYSV0UND0CBYVQmT6q6rhwuL/yb7X
ARC-Seal: i=1; a=rsa-sha256; t=1521214263; cv=none;
        d=google.com; s=arc-20160816;
        b=s1OpO7FKbEz34OSWRKkdJaQfJq8Z6i1xAaGeT5M1QtUZ8tomVw/JzMoB9yqWr94VEk
         Y1si0S3YMj9zcpST2MLgMYpy9qQoxywxI3nVYvK2vNsFUU7MXKfFpYKf5GjkFXux8awT
         PClBNzwLG1F9NZWM40KA8aBJX25pUXspIhEft44hdbvCkjnB5KWJDXjhtLkHSVyjPNLK
         /WM9wgZ7VPQTqTKZUrJl9TcBTJZ7dEHeXErLx74UhKT/R92ymAEH0Gtf82NtFG9Ln4Af
         pPLBOIzapfKN9ju/YgZoY+AhhGyyHntp8R02A7Jr6CG822V0MNrefFjL2Ry82LpHVGzA
         n4YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XBHB2qL143kwZ7/3alYEv4mM1MJ8A44/ENJVOUyJuc0=;
        b=sgrNXl70T4Zy+IwiajTyP61EagYCNkmXnl/guMUOT6SujicCvo/vhen48oETCbzayg
         eNNbI/kK4UA57y8Fi+reFUfTLIPqOm7JWtMJeXwnFLoBFqeIN8UyiJyEng0N7+gBc9xt
         2f+KORouoW+U7UUG5bgj+WWLvJtWtNLk5NA8ZGx6wvEo/Ug9oOnVnh5fOxP4AArkwcIF
         y7xOTRIKdBrEOoG98NASFgsN/tGtHIac4OjUzBQZdfhu4mmzq61MN20EX+avoZW6Fx1s
         qRWTG11LWo7ZNmwaszgQG8cIL118LcnddUJDyx6aoI12KoQYPR++CvM+lDWjFoetX4Up
         fFhg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
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
Subject: [PATCH 4.9 30/86] x86/spectre_v2: Dont check microcode versions when running under hypervisors
Date: Fri, 16 Mar 2018 16:22:53 +0100
Message-Id: <20180316152319.440878939@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108767836984209?=
X-GMAIL-MSGID: =?utf-8?q?1595108767836984209?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -103,6 +103,13 @@ static bool bad_spectre_microcode(struct
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
