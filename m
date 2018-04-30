Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp1h9RFJPLoy26Tn2PUyQ5j/q64KVkOGeun3daphIaqpC/bULWJa7Mz4YmxyaQF3lrV7q5z
ARC-Seal: i=1; a=rsa-sha256; t=1525116530; cv=none;
        d=google.com; s=arc-20160816;
        b=E9mlShYMg4Hc4EtFWvjJ3+1OGar2dJm0esZd5SPaiCYWs2nt2RIniZZPEr2REvmHPI
         9TGUANo7dF8ehtydKy1jKlaeU5sZH3V5MUj3bJ1gO119YoXlPGb7t3lsD8snLxH5LUAJ
         4B3bVRHOk3I0XXteYyuLSfQ6fFE16H9nUivSy/XGVXmrLZ9fdGrk+91Mrqea6laY5OnQ
         9Iq30dQUThUlxXBxvof+sgl1Xt8+bKvJdVmwsFtCZEu3qz35OJS8D3PaQWaU245plzTA
         qx3ndQwDFaR7L1zZ219QF+UUysH9UA4w33tTykMkgH8ClG9bgoA7Q4xccmVe2vRXMp/t
         wH+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=i0V+5cj921W/DFwJw3r3nm36KlNnXJQvtpe1RkgI/XQ=;
        b=j2WEwjUQh+GbLbgbc2XKLT9kxUjh8bN5d6zyaVt34rSuooYHj4xTDXlyFL+U7fz7Pn
         ILY175O0Umd0q4og7xch7mDG3z9V84Q2WYAogK8FKs5NqdvR7hsQEziCNDVUn0LoLaeP
         OFiSZw/RIkcDlXhJZ7NT5IaGX49eB/SZwx/mdAZoXVOoNLg3HXDpDgbqhtcwdXjVJsus
         j1RWfpdQGsHtIM5zGcerN5E4MKJIO5wouB0aAHVkIXKKGmjXYrqdiH1LHssuAHAeWGXT
         TFY0pEhZ+EANbrIZIax/3adkgac0ZIxkvnRttx+UVIUurmkuWEyt7pKH0XgKcIEzwO7Z
         kKCg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E540722DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Dhinakaran Pandiyan <dhinakaran.pandiyan@gmail.com>,
	Wenkai Du <wenkai.du@intel.com>,
	Abhay Kumar <abhay.kumar@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.16 101/113] drm/i915/audio: set minimum CD clock to twice the BCLK
Date: Mon, 30 Apr 2018 12:25:12 -0700
Message-Id: <20180430184019.479034930@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200591168939802?=
X-GMAIL-MSGID: =?utf-8?q?1599200591168939802?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abhay Kumar <abhay.kumar@intel.com>

commit 904e1b1ff4c70044334f395aa751c8e73fb42714 upstream.

In GLK when the device boots with only 1366x768 panel without audio, HDA
codec doesn't come up. In this case, the CDCLK is less than twice the
BCLK. Even though audio isn't being enabled, having a too low CDCLK
leads to audio probe failing altogether.

Require CDCLK to be at least twice the BLCK regardless of audio. This is
a minimal fix to improve things. Unfortunately, this a) leads to too
high CDCLK being used when audio is not used, and b) is still not enough
to fix audio probe when no outputs are connected at probe time.

The proper fix would be to increase CDCLK dynamically from the audio
component hooks.

v2:
    - Address comment (Jani)
    - New design approach
v3: - Typo fix on top of v1

v4 by Jani: rewrite commit message, add comment in code

Cc: stable@vger.kernel.org
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Dhinakaran Pandiyan <dhinakaran.pandiyan@gmail.com>
Cc: Wenkai Du <wenkai.du@intel.com>
Reviewed-by: Wenkai Du <wenkai.du@intel.com>
Tested-by: Wenkai Du <wenkai.du@intel.com>
Acked-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=102937
Signed-off-by: Abhay Kumar <abhay.kumar@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180418103707.14645-1-jani.nikula@intel.com
(cherry picked from commit 2a5b95b448485e143ec3e004eabe53b31db78eb3)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_cdclk.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/i915/intel_cdclk.c
+++ b/drivers/gpu/drm/i915/intel_cdclk.c
@@ -1946,10 +1946,22 @@ int intel_crtc_compute_min_cdclk(const s
 		}
 	}
 
-	/* According to BSpec, "The CD clock frequency must be at least twice
+	/*
+	 * According to BSpec, "The CD clock frequency must be at least twice
 	 * the frequency of the Azalia BCLK." and BCLK is 96 MHz by default.
+	 *
+	 * FIXME: Check the actual, not default, BCLK being used.
+	 *
+	 * FIXME: This does not depend on ->has_audio because the higher CDCLK
+	 * is required for audio probe, also when there are no audio capable
+	 * displays connected at probe time. This leads to unnecessarily high
+	 * CDCLK when audio is not required.
+	 *
+	 * FIXME: This limit is only applied when there are displays connected
+	 * at probe time. If we probe without displays, we'll still end up using
+	 * the platform minimum CDCLK, failing audio probe.
 	 */
-	if (crtc_state->has_audio && INTEL_GEN(dev_priv) >= 9)
+	if (INTEL_GEN(dev_priv) >= 9)
 		min_cdclk = max(2 * 96000, min_cdclk);
 
 	/*
