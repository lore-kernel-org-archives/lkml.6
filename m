Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtYpxi1Kp4DpJIPD20pUlHExv6Ctu7SolRcv9BcWxOdhdjhBPULWrgrxIAQQI5W3XeSHcKD
ARC-Seal: i=1; a=rsa-sha256; t=1520955451; cv=none;
        d=google.com; s=arc-20160816;
        b=x6dZ5lJTGAw8IdyC7BIMKUf4PsqL0KJzA0ZgjNSxSljRg31/6jv1+0wqr9xxI2ZKV/
         3K7NsX7lRbJHQJJNb5gpjtbC0G4xyp6cIYXvv2A/LEUmnqYzazIRGPDMCM/1z+csMY4M
         7m9tZtqyD8KMI+nI4BG8lS2OIVBrsqSClkUdB19jjd8/PwimeZaFuZOXvgspA6AklDou
         hXzds+84e239we5MJqXHWjKmT7LYBP++ZF4uZSmpjV37p63e9DDbxivPYJNAqaOp6spv
         98+NHDWWAFH+bFLuzZRxWRzjU2Ga/ywaok3ACfBwdctDS90pA6vsN+/jrqSOMk1NaFdf
         YpqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0qYUcqmtVaYRKdoplXsd/YxettsrP4WjA7D+TrM6Ydk=;
        b=jJx9ubSLPf+EBFDae3Xg3354PMA9ApqEk1H66VdXJzXt6HODpsEU6xX2cu+c75Xrw1
         VqbIf0dW22tDRnuUO4JInZG5thBxYTEkMys9ue3K9vidBvjblAdBceuv1rfkoxDaTWCd
         2xoZZC/8cgZzo+jh6OPSYm2/Wf821r6RWe3L0J9JCBnpV9uP6xU5BtQzzIn13YzeWlyS
         fu/BtgwURwU0xo8kw5P4fbLfcLV78mJxJ9zci9nFUbQq92qJGIh63TfN7jD3j4HOvLjv
         iJMqzXG3Ebs4Z7kPFiyN+tg+a1pxxniyp0M0Tr75+liRHRu7zjozSwU62zl8pKoibn8o
         cZMg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
Subject: [PATCH 4.14 054/140] drm/i915: Disable DC states around GMBUS on GLK
Date: Tue, 13 Mar 2018 16:24:17 +0100
Message-Id: <20180313152501.911883515@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836803674032941?=
X-GMAIL-MSGID: =?utf-8?q?1594837383323429268?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 156961ae7bdf6feb72778e8da83d321b273343fd upstream.

Prevent the DMC from destroying GMBUS transfers on GLK. GMBUS
lives in PG1 so DC off is all we need.

Cc: stable@vger.kernel.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20171208213739.16388-1-ville.syrjala@linux.intel.com
Reviewed-by: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_runtime_pm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/i915/intel_runtime_pm.c
+++ b/drivers/gpu/drm/i915/intel_runtime_pm.c
@@ -1844,6 +1844,7 @@ void intel_display_power_put(struct drm_
 	CNL_DISPLAY_POWERWELL_2_POWER_DOMAINS |		\
 	BIT_ULL(POWER_DOMAIN_MODESET) |			\
 	BIT_ULL(POWER_DOMAIN_AUX_A) |			\
+	BIT_ULL(POWER_DOMAIN_GMBUS) |			\
 	BIT_ULL(POWER_DOMAIN_INIT))
 
 static const struct i915_power_well_ops i9xx_always_on_power_well_ops = {
