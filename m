Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpRnR2DY5vOG9fFbYT2gZJJMEMrQr84egKy5Ofy67LO/Yd19jdxMcIeRP2d76Jj31+PgLpS
ARC-Seal: i=1; a=rsa-sha256; t=1525767204; cv=none;
        d=google.com; s=arc-20160816;
        b=b3DLGBxCsm7w5xm3E6VHJc6njEfAXAK7egphpsNuxjBzlsGeIl72dQHYN8A8C0AsxY
         J8rXFJF6BLE1aQkbCtIafTIONmDHQBhsvlR7eqkaJyreGOtbbDv7mGlCAeu9JMt7sSDS
         Xt6TUKJgm7UrjiBkvBUXjI+3BcdSmcasuce0m/9RmUHlx53oKNpDPQHe82+zoKfPii0a
         0PCMP3wIx/lXa1QC76Eyyy/JkCFQ8q+c1f6TcQv35ZybOwoetw4WAWGnBuTduYLSFivD
         ERT8S1HX2hIoaLiG3VdPRiTxiiGCtV1airpEWmRDYd5TQQXxjH1nxiirwY8rOuLERV8s
         1c7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=tuWHCtS5N/4RB7S4q9ZyVTNVH/tdD8UN2qUMf40zV+o=;
        b=DFRP/HnhDW6mp+MiMavU02n2ej8nQUo8l37aDc2dKBgfzYStH85OqqO144uzYu+guu
         TfCnjN+6RYsjUj4glRwO2DA/flc43ynxT1FseNS9WEgBRjEcQ9ErQElGNCZaNEr2gx6Z
         W+Pb/8fMY2b6n6BMviDBC8CVNXRh6CC181yEQcZNV31PrErJuuvPb7qh4PDND4GJruiN
         GNOsRb+L1FD0Fy6GTHkrKZmsTpSZXoYKkjy76ftCpglRXY/XkEjdm6s3KahBtrdQcK9p
         eKC3mB9ijtwu2ejJQALAMG90Kz1ca4cRIgoAv8+s/HFRHSuWPNzfblxrZIByzC+dFsLN
         Fvlg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=U7ocl0gZ;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=U7ocl0gZ;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Mika=20Penttil=C3=A4?= <mika.penttila@nextfour.com>,
	Wanpeng Li <kernellwp@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 4.16 45/52] KVM: x86: remove APIC Timer periodic/oneshot spikes
Date: Tue,  8 May 2018 10:10:43 +0200
Message-Id: <20180508073934.484645372@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882872966936921?=
X-GMAIL-MSGID: =?utf-8?q?1599882872966936921?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>

commit ecf08dad723d3e000aecff6c396f54772d124733 upstream.

Since the commit "8003c9ae204e: add APIC Timer periodic/oneshot mode VMX
preemption timer support", a Windows 10 guest has some erratic timer
spikes.

Here the results on a 150000 times 1ms timer without any load:
	  Before 8003c9ae204e | After 8003c9ae204e
Max           1834us          |  86000us
Mean          1100us          |   1021us
Deviation       59us          |    149us
Here the results on a 150000 times 1ms timer with a cpu-z stress test:
	  Before 8003c9ae204e | After 8003c9ae204e
Max          32000us          | 140000us
Mean          1006us          |   1997us
Deviation      140us          |  11095us

The root cause of the problem is starting hrtimer with an expiry time
already in the past can take more than 20 milliseconds to trigger the
timer function.  It can be solved by forward such past timers
immediately, rather than submitting them to hrtimer_start().
In case the timer is periodic, update the target expiration and call
hrtimer_start with it.

v2: Check if the tsc deadline is already expired. Thank you Mika.
v3: Execute the past timers immediately rather than submitting them to
hrtimer_start().
v4: Rearm the periodic timer with advance_periodic_target_expiration() a
simpler version of set_target_expiration(). Thank you Paolo.

Cc: Mika Penttilä <mika.penttila@nextfour.com>
Cc: Wanpeng Li <kernellwp@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>
8003c9ae204e ("KVM: LAPIC: add APIC Timer periodic/oneshot mode VMX preemption timer support")
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/lapic.c |   37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1455,23 +1455,6 @@ static void start_sw_tscdeadline(struct
 	local_irq_restore(flags);
 }
 
-static void start_sw_period(struct kvm_lapic *apic)
-{
-	if (!apic->lapic_timer.period)
-		return;
-
-	if (apic_lvtt_oneshot(apic) &&
-	    ktime_after(ktime_get(),
-			apic->lapic_timer.target_expiration)) {
-		apic_timer_expired(apic);
-		return;
-	}
-
-	hrtimer_start(&apic->lapic_timer.timer,
-		apic->lapic_timer.target_expiration,
-		HRTIMER_MODE_ABS_PINNED);
-}
-
 static void update_target_expiration(struct kvm_lapic *apic, uint32_t old_divisor)
 {
 	ktime_t now, remaining;
@@ -1538,6 +1521,26 @@ static void advance_periodic_target_expi
 				apic->lapic_timer.period);
 }
 
+static void start_sw_period(struct kvm_lapic *apic)
+{
+	if (!apic->lapic_timer.period)
+		return;
+
+	if (ktime_after(ktime_get(),
+			apic->lapic_timer.target_expiration)) {
+		apic_timer_expired(apic);
+
+		if (apic_lvtt_oneshot(apic))
+			return;
+
+		advance_periodic_target_expiration(apic);
+	}
+
+	hrtimer_start(&apic->lapic_timer.timer,
+		apic->lapic_timer.target_expiration,
+		HRTIMER_MODE_ABS_PINNED);
+}
+
 bool kvm_lapic_hv_timer_in_use(struct kvm_vcpu *vcpu)
 {
 	if (!lapic_in_kernel(vcpu))
