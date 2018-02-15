Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226W+s3xJ38ywj6EQsgyf2iNYmugVQOhQMuqHXefS5g3uZmszgQ9E+kyyJ8TkMVQ53AGqsDc
ARC-Seal: i=1; a=rsa-sha256; t=1518709338; cv=none;
        d=google.com; s=arc-20160816;
        b=SOIvm3F39KA6NHqUPfs+yJhPcXUzvxCl5BkF0EaHE85on0URepklYQeO2HwHeV//rF
         qyQD8sBcKDCfM2i21sDuplUG/lKJOeh79uIi3MiKPOw6o49X5lqiBL+rMhhi6uSfrxk2
         rtWNzuywiBmEquUosXNNKUV2FiZBQukU0bgBf+UAF6YpWWdbZ+d0WIy+/c03emyQONLE
         C66zl7PdYn0yRB6LxVufDWLJWvnKApwO6KlF9hpDXsD3Q5Q6mplTdxG8X9WmxNRDvuVT
         V4b6RqxuZ9ZlydA+HKAhrwbV+cQYTC75efObpvakuHBOzlZ7FvqQgS2h0oC/4bkHjNeT
         /4zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0bvr9oovb6P5lzZc5BV41DbSMEkkozz70rGB2SpDa18=;
        b=Rjzz9WGaDESRJkMq6Ue747Xg9sGnWDePnMSqa4yncRpMQ0j5CJxjBJaxFlYudVtKyK
         1ejHmfo+zO5jg30B4vWbv2zP3sD1uJB9mI1lA9hWBn0QAXxrnQyLFfyechEU2eCrtsqO
         SCH4XUIpOjljXyvtUvfKmwf1tmPxxrZCJAhDygK+eApCsmkXnsX3gm/Q+yOpDy3F9UD8
         0PnCcyuJJUyIoElPLxGBG/6txS87q9qgDFLu9aZBWImAcPEF5YGm3jA1QvTmK8gAJ0qK
         6e2pIIIYcQFv0nh6bQdxolM2P3wwb+3MwcciH66KqmFL0L0juhoElChIdR7g+nhB/3Dz
         /jnQ==
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
Subject: [PATCH 4.15 081/202] [Variant 2/Spectre-v2] arm64: KVM: Add SMCCC_ARCH_WORKAROUND_1 fast handling
Date: Thu, 15 Feb 2018 16:16:21 +0100
Message-Id: <20180215151717.705732110@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481657378343357?=
X-GMAIL-MSGID: =?utf-8?q?1592482163662949457?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
