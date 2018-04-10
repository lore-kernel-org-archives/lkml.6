Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4870zZGpL0S03CNp7bfJLe5eFAZHblS/vZTGW1ffplYjBm1FCJVMChQwHT2gcbteuG4eM6n
ARC-Seal: i=1; a=rsa-sha256; t=1523399437; cv=none;
        d=google.com; s=arc-20160816;
        b=q+O3t8Okds/kmP9HOEd5Q/OciyxCgl1Xof5Mjh/0EQYISEm2Doc2S+Y6EbT5UtMkcM
         1bBbpE38wk4CZ/r+lKe7bwz/ArMLBz9ixJGMmnH+ZVmSncipFN+tevWicQ2y3EkYZ0kg
         QwGp2YQro5x4/akRznkzSbq8yYDdNM67k1+mc0MTx/32wFkY42J+ryWl3P4NU4zCp1BN
         u6gtgKwYwfqjOf8GJrjSK3C3m9icDDJGjVsktkfZ1qQsEtKRicgi5G7cGLMwdscZP5gi
         G2rXUCmInT7sxF/KBaUnykCUBy2qCWJ5x7AAd3KvaitfW89IwASRauKOralhV8qibqGx
         lE7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TW1nQiZEKCZq7SxWZEhCudeAlaOTe2mxUcVIiat/NhE=;
        b=PnkhuM+y8MmRrgogXuGvHZylhcZs3Fff/d3lBHij7WR5C9fpAmSMaWyxnslOMUM9uX
         qtdJf1vu2Iwx6XRtYeqliZpkWRsb3zv7MYxe8DL+mhu/bt2CE63JAePBdYJ6df6egluh
         9KTweOu5i2ibcH4MCxfXQvDZOMQMSB/lBwChSD2Q1voWbt2OIAfIpycT+Ie/QI8Ym76n
         q+nedjGWLd2pR4HVkDNCxx+/LXU4aX+xqSr9zPMYsrAX5AXMQ6LMAW39unheC55o55CD
         NyUaiQQ9d2Cv6eogJAxjyVZEkwrnTRXExhA0ursc+sQyxfnn42bMnPzuq4FtUy1ujvtE
         zY1w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kai Heng Feng <kai.heng.feng@canonical.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Radhakrishna Sripada <radhakrishna.sripada@intel.com>
Subject: [PATCH 4.15 107/168] drm/i915/cnp: Ignore VBT request for know invalid DDC pin.
Date: Wed, 11 Apr 2018 00:24:09 +0200
Message-Id: <20180410212804.801933664@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400088915581501?=
X-GMAIL-MSGID: =?utf-8?q?1597400088915581501?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rodrigo Vivi <rodrigo.vivi@intel.com>

commit f24c606c21a8cb6f75adc20edcd80b6d851991bf upstream.

Let's ignore VBT request if the pin is clearly wrong.

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=104139
Cc: Kai Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180123174050.4261-1-rodrigo.vivi@intel.com
Reviewed-by: Radhakrishna Sripada <radhakrishna.sripada@intel.com>
(cherry picked from commit a8e6f3888b05c1e7b685800a3371ce050720368f)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_bios.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/i915/intel_bios.c
+++ b/drivers/gpu/drm/i915/intel_bios.c
@@ -1115,9 +1115,14 @@ static const u8 cnp_ddc_pin_map[] = {
 
 static u8 map_ddc_pin(struct drm_i915_private *dev_priv, u8 vbt_pin)
 {
-	if (HAS_PCH_CNP(dev_priv) &&
-	    vbt_pin > 0 && vbt_pin < ARRAY_SIZE(cnp_ddc_pin_map))
-		return cnp_ddc_pin_map[vbt_pin];
+	if (HAS_PCH_CNP(dev_priv)) {
+		if (vbt_pin > 0 && vbt_pin < ARRAY_SIZE(cnp_ddc_pin_map))
+			return cnp_ddc_pin_map[vbt_pin];
+		if (vbt_pin > GMBUS_PIN_4_CNP) {
+			DRM_DEBUG_KMS("Ignoring alternate pin: VBT claims DDC pin %d, which is not valid for this platform\n", vbt_pin);
+			return 0;
+		}
+	}
 
 	return vbt_pin;
 }
