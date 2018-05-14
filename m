Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoBLwZDcLVqYzvGFI7Q9jpHcSbev4X8/OILnSH7OFgiRiASfTRub/VWKv7l5j0qEE6f9zRC
ARC-Seal: i=1; a=rsa-sha256; t=1526281053; cv=none;
        d=google.com; s=arc-20160816;
        b=jWuHmdO5NcevzSWsw/jLgYX5idj/3FvPyX7ZjGfkRJU52QGZPqjVlYu/MHG57S4AfF
         2dIQeVNw6f+G4fxk5ecmKSNrnLw3dwtXA1J4ecodc28x2srKSXVj6EciYcWt/CFMINjW
         ilcBsr/6AEb+Ibyu7Ws9h8to8kuiNYmW3w/dbeULUeRxlo+odhjSkqtoZPC9RcR38GUs
         6GzmW0iNef4rlI0qiYrbrkB4nWG3w7kVMYa0L9i4IN/ebfJFll8jLCwZUbX1fJZdQ/lM
         fTgm5fnAO+C0NVe+yQS3Cb9L64dhLK8zRBBbRWxTyqjgklnkCfPB/d7OWu2GSLp1b0th
         nbDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Zn58Qme2KS1bMXDz+/leNCSinjvz/6HkjH6SDu7nd8k=;
        b=mUASZ0/uzuL9fxHCeXyHTSBYMyZUlELVB00Ek1D75VGrfWOZ1h7f/Fx/WkZmCwvHzr
         hVmb7M7gesaDTYA+hzKK/S2T5sJoI3k9DJRVzvekZtRgzAq/nGqm1X2xD84aFr2zf3Jd
         HaCbKthzYsdk3twP3YxgbkhwaNQxqp5Cfvqiw413eOayD4qtIxNCcZ0ltWy3xMxSLY8U
         blZ4rvelUfTuxLSG7W3I1U/Q6+um9QlCKAvwqOe4z+XMmeTVLJwL995nTmRde5iTrD8b
         CSTLIFQ99n3mQ9vX/0rTex94O7JjklcLSN0yNl0jIb5AXdE3JR/y1yK7dmizTxfY3n9c
         TTXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=S+/pIWtt;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=S+/pIWtt;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Mika=20Penttil=C3=A4?= <mika.penttila@nextfour.com>,
	Wanpeng Li <kernellwp@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 4.14 62/62] KVM: x86: remove APIC Timer periodic/oneshot spikes
Date: Mon, 14 May 2018 08:49:18 +0200
Message-Id: <20180514064819.929970573@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421681693060384?=
X-GMAIL-MSGID: =?utf-8?q?1600421681693060384?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1418,23 +1418,6 @@ static void start_sw_tscdeadline(struct
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
 static bool set_target_expiration(struct kvm_lapic *apic)
 {
 	ktime_t now;
@@ -1491,6 +1474,26 @@ static void advance_periodic_target_expi
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
