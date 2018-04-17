Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/8mIIjMoMXFZc9htV4XEOcSk/3rxRv9detbjz0dAc2JdST5JzaSO6wzTlHDxIdcszLxac/
ARC-Seal: i=1; a=rsa-sha256; t=1523981380; cv=none;
        d=google.com; s=arc-20160816;
        b=J749vO5GCrM9hdPgdtPl92e4zxRIwhFnmWowPcdGziigejJMWPkOlFwBabjaPwtAuU
         Uu2L+wtT+9zKLGo8tyohZh6VNERt7xpB2+Eaqbo5Mv3iTdA6pxlW/AP/Z+3+9tkRRWGg
         sS/6+pc9HB5ImcVzCyhKBa2yjFRMIzKoyprvHZc+WbZIIDnW/h64uvIqHSjhKYPVIdVL
         eD93UKqQWFIbTKKAIaoHaDpEWoG44aCV4Hv+bq6gvTAnC3YD3cKmzQFF1DNHoAgI5klz
         Qf107yusHUJ5RMHJ8PTXOBqBZKThEECgFfkP8lI4Ghmmh3u/SkFtZfZSrzTgUybmyyTl
         jcsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bqu8DOh3L0m5Nm4VeIRvCvjsFjDIjiAr2RH1ZTSS+Mk=;
        b=qnrdN0RxjzpNovaKcAX13L0rBJzRvfbNrgwAUM0/+YAAPVOVWTV51Db3H9wrcdUiZS
         W05x2KzQyOGbefBoFGzudn3JuwOPjtxfSGTfHw5H3cX2QcU3RtWem4iunL4Fc/QA0u6K
         xrEb7Q8uPYOJAnteXJjUNO+pjRbFcpWUsomCtYyRfHTQXKPdG76IoyO14AwcEiDJ4xxH
         OaYe/oeNyPu0lYNQ3IfqpX4m88jJLPTax/gaD+uo1aUE26Zg4me5uDSvLA43F7CvuXRe
         nhlSgSOdwJ483KE64JbT6DA6+vwZdmEaZ1mheBc52kyyPNf+yvkLvYDudlkVf/b8BIa8
         8/eQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Christoffer Dall <christoffer.dall@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.9 44/66] arm64: KVM: Add SMCCC_ARCH_WORKAROUND_1 fast handling
Date: Tue, 17 Apr 2018 17:59:17 +0200
Message-Id: <20180417155647.792347331@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598010299680802271?=
X-GMAIL-MSGID: =?utf-8?q?1598010299680802271?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>


From: Marc Zyngier <marc.zyngier@arm.com>

commit f72af90c3783d924337624659b43e2d36f1b36b4 upstream.

We want SMCCC_ARCH_WORKAROUND_1 to be fast. As fast as possible.
So let's intercept it as early as we can by testing for the
function call number as soon as we've identified a HVC call
coming from the guest.

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
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
@@ -79,10 +80,11 @@ alternative_endif
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
@@ -101,6 +103,20 @@ alternative_endif
 
 2:	eret
 
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
