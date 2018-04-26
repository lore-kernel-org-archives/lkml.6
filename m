Return-Path: <ulf.hansson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524732797; cv=none;
        d=google.com; s=arc-20160816;
        b=n5XuARQdn54I8W59UzStHbp8qOempI2pQYxOkEQsvPZQZpHAFGt/NWIaQWHw5hkoub
         5vx2cEZN7N5YzdwpDGWYX3PtoQb8w8rs44PLAHALJ/HI+VEsUq7YxO3a3dqaxP3Iqdiw
         ookgCqvr3i9rTLImm0eLZWWj+SIsKuDDAj4msIHoYeqGNQjrxpg2SoEOAcur3ofr9TPw
         m2mEjrc/Cw5Xt/IrcALkVIJYTXNQRA1pAk2+zj1jy/ZOV5Ay5Z5b6pdg9Cr9hpLaiPnT
         pe0SGgCYTX5ZMA1Xc62fdIgrD9N/CHCv5b0gi0VlYyoSMzaIhfErV90FJvd1o0i/znTF
         EmXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=erb1SyGANxVl6gHWShUQ9kqj4ktELneZ9u3fj92lBqQ=;
        b=lBiLcZB4PepkxYDfTiedhfD/YlPE/O4JobKGeCt6VipfeWMtNZpyFK7ZL+/tNw+doU
         9Jv+hn/XF/uwEczNt0jcFtIQ0Gqzg0pELKiDpDWgk5KHa1i3KbWgPRLIDB/Zw/HoAsuS
         B8EqcNEUYG3ril4NpPFR0aOsQ+vbqEmzhTx4eaQjptdsB3svb2iqvGrDROiQst+Anofq
         um+vy45VKU9sFRXRV7qL1r0Fblvrls92i8lU3LEAWtgtrCYNGThl3m6feRfQlQuROsjh
         DTWxa1j7Lh3g5YcESFeghBofQCj12qzXmyvz0KJoItjgE7Vc4lMdS4JKKFD1fA/eJQxv
         HhHw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=cz1EUeiH;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=cz1EUeiH;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZqanroxBvuAAJhH4Qr5NuNHaCTuHoLRrKMou4quakAWpZv+8j2I/o5BAAS2MwMo/bEUcvrsag==
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Kevin Hilman <khilman@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Vinod Koul <vinod.koul@intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	"# v4 . 11+" <stable@vger.kernel.org>
Subject: [PATCH 01/11] PM / Domains: Fix error path during attach in genpd
Date: Thu, 26 Apr 2018 10:53:00 +0200
Message-Id: <1524732790-2234-2-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598798218210668919?=
X-GMAIL-MSGID: =?utf-8?q?1598798218210668919?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In case the PM domain fails to be powered on in genpd_dev_pm_attach(), it
returns -EPROBE_DEFER, but keeping the device attached to its PM domain.
This leads to problems when the next attempt to attach is re-tried. More
precisely, in that situation an -EEXIST error code is returned, because the
device already has its PM domain pointer assigned, from the first attempt.

Now, because of the sloppy error handling by the existing callers of
dev_pm_domain_attach(), probing is allowed to continue when -EEXIST is
returned. However, in such case there are no guarantees that the PM domain
is powered on by genpd, which may lead to hangs when buses/drivers tried to
access their devices.

Let's fix this behaviour, simply by detaching the device when powering on
fails in genpd_dev_pm_attach().

Cc: <stable@vger.kernel.org> # v4.11+
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 1ea0e25..ef6cf3d5 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2246,6 +2246,9 @@ int genpd_dev_pm_attach(struct device *dev)
 	genpd_lock(pd);
 	ret = genpd_power_on(pd, 0);
 	genpd_unlock(pd);
+
+	if (ret)
+		genpd_remove_device(pd, dev);
 out:
 	return ret ? -EPROBE_DEFER : 0;
 }
-- 
2.7.4
