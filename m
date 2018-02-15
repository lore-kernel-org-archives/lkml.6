Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225lBLrnfLkYNNEam1SHmBtY2SGqGfXK5Cw3IWfgFu8T9pFjZ+he2WuA7MzvnwtQeQ4hNOYD
ARC-Seal: i=1; a=rsa-sha256; t=1518708855; cv=none;
        d=google.com; s=arc-20160816;
        b=vYYTocA1US56o76wmXZPwWnfy+L4b/dv72tfpP5XYudab3/9T61z3wI+1vg//jnqZ+
         b+gUlQsDSg7nsngGb3HpDbdAXBvIub+auARXn5vAFNkTcyOHj5ser6jb4/fc1AbWpX9u
         57j1xITKd8onbMMz3NULioQAB6AXjGFc9LdzXfGP2OHdmbOSizv89Oe3ViSroPMF2L0V
         sIHEU9Pvn8EC+my95fkfyzhu7ov7y0uYNQqCRFRm3A73PzJzFMnPh+43OMaIVpBKU2mt
         LGmxgyGWA9REjdW0W6cbEN6rQNPM+byu8yJGaSNJNNLOle/Heg1OpsevEmmBH0HezL3X
         qeEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aIVFRr3V4NKkHJJKq5E0ZtgPqFrVxyxmTAgegRS3uzw=;
        b=BWktfdIPSqMraDjen7fFD6mqjBHTHfq/AIufhbw9lKM4ZoKHKvieFfaMd6rnSHMwbe
         o6T+7vPMe8zmVYICSKM1w6izQz5W7bceKH9Ptc3Vr2Hof96tmM5jQy8HhxOSmEyhhBgy
         RBZvz+2ZYba66xXCPHGXs+TkvPcMBxz9xmQ61fVQSyTmT2EwBwQLXAFzO7D09UDUko5W
         DXcMUQHpfWWlDdAMjcXjs9PRiWerPUZv39g97huNqYoEijzwXVql659CEOevm5uOgQCh
         dlundlybrA8inmNKczpSA+E+ciwzJXftzNEu7FZEuRikEJzm4/S0NQ/4RkOo7UZl42Tf
         1yWA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Christoffer Dall <christoffer.dall@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.14 088/195] [Variant 2/Spectre-v2] arm64: KVM: Add SMCCC_ARCH_WORKAROUND_1 fast handling
Date: Thu, 15 Feb 2018 16:16:19 +0100
Message-Id: <20180215151710.112283299@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481657378343357?=
X-GMAIL-MSGID: =?utf-8?q?1592481657378343357?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>


Commit f72af90c3783 upstream.

We want SMCCC_ARCH_WORKAROUND_1 to be fast. As fast as possible.
So let's intercept it as early as we can by testing for the
function call number as soon as we've identified a HVC call
coming from the guest.

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/hyp/hyp-entry.S |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -15,6 +15,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/arm-smccc.h>
 #include <linux/linkage.h>
 
 #include <asm/alternative.h>
@@ -64,10 +65,11 @@ alternative_endif
 	lsr	x0, x1, #ESR_ELx_EC_SHIFT
 
 	cmp	x0, #ESR_ELx_EC_HVC64
+	ccmp	x0, #ESR_ELx_EC_HVC32, #4, ne
 	b.ne	el1_trap
 
-	mrs	x1, vttbr_el2		// If vttbr is valid, the 64bit guest
-	cbnz	x1, el1_trap		// called HVC
+	mrs	x1, vttbr_el2		// If vttbr is valid, the guest
+	cbnz	x1, el1_hvc_guest	// called HVC
 
 	/* Here, we're pretty sure the host called HVC. */
 	ldp	x0, x1, [sp], #16
@@ -100,6 +102,20 @@ alternative_endif
 
 	eret
 
+el1_hvc_guest:
+	/*
+	 * Fastest possible path for ARM_SMCCC_ARCH_WORKAROUND_1.
+	 * The workaround has already been applied on the host,
+	 * so let's quickly get back to the guest. We don't bother
+	 * restoring x1, as it can be clobbered anyway.
+	 */
+	ldr	x1, [sp]				// Guest's x0
+	eor	w1, w1, #ARM_SMCCC_ARCH_WORKAROUND_1
+	cbnz	w1, el1_trap
+	mov	x0, x1
+	add	sp, sp, #16
+	eret
+
 el1_trap:
 	/*
 	 * x0: ESR_EC
