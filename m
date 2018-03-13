Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv+Tn6FWF6UvInfSbALRcpdt4WJT/5X7dvPRdZpl8mfKC4hRbmnRSosKUFHrEEQP3zFwoIf
ARC-Seal: i=1; a=rsa-sha256; t=1520954898; cv=none;
        d=google.com; s=arc-20160816;
        b=Lb3rAhYjOunqVpI6LhW185QDh1opvz/83Emp2dMYqCCIkUJtXNocVgpqPcev4bDT3W
         cPLVT9/m7Oi3B4Q/dMFrwvCsfsnRVNwrd5eoJkAOS9clLRKkJIySe5fwSxfGT8xe9+Nz
         2u4CdwbFiU8BdkG6BhcLAkoUz2oTeP12FV3euDA5Rwwjdw/YFK61M4cogjTJJBL3A7qJ
         0CKuxG6mMyH5crx1CLIj4+bMrTUE5UcNMk9hhMkq+tnuCyyeleMiZrhkKemf4T5OGD6q
         JSA0AexQXH8cndDkHZVCIwUrUapnnD6Cq9skJqTdQ4VXHGTHUYlmwyO4+LIT+h5ybIJK
         YNxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TN9mL5w4OswSh8MQ5JpNFRl6tTQ6Le56j/EHn3jiO20=;
        b=F3ed04a3j5GONJzbZ0Lpb36qGZx8OSZHcK0tHwPqMSnTaooYxChCjJohXQWXFFoErb
         7GPdfRLZXINdpQfS4CVeVwQ4KWLWSR/FoQ1qRznrjy/Tf3mB35mUYav8enEDp9EgDopp
         5mk/WrZBh46DTQw1jzwPI3cPxKHD2tk+Aw2jVhJE/bmmjncnaPIATeqY4kwq7qG1kz12
         gbfS/pJPqdf3/rTAijYP4U3xJnj0/KmNSubz9Ao6jca9cqAU5QYUaAMy8jQA7xu6SSJw
         BmS5VmdCUotGslst+iTCw3W0EUDhRvCzNi7Bs4c7j2aw5bx3LTd/KQuXYNA1NLup2zeR
         GtWw==
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
Subject: [PATCH 4.15 013/146] drm/i915: Disable DC states around GMBUS on GLK
Date: Tue, 13 Mar 2018 16:23:00 +0100
Message-Id: <20180313152321.596554483@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836803674032941?=
X-GMAIL-MSGID: =?utf-8?q?1594836803674032941?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
