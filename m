Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr5mskuhGXFjIw3LtXP0TE67gQLMd6X66nAHn7KSD9M/h7KqQoIhEGe2K4iFhM65LL692bl
ARC-Seal: i=1; a=rsa-sha256; t=1525116531; cv=none;
        d=google.com; s=arc-20160816;
        b=fTts9FIqDeBqAnx7A9lvW47XYranBpZm+xmXqbIITNv/xTFsGw8Qh6ue0yKh39dl1N
         YutHPcQumGyK0kXL17Ns0QHI2ZvL1MAskfii0UTWV2JjXwyDrc9relTEV9R80Ezcc7yW
         s6XYpcB4Yf2+0vrPRdNre3Hq+NfhEDP275qNqQo9MYKbtUKWEgoa8RDnJJEooFP7Ja3T
         Cbq14kJ/3LFHAsZUbFzJmuJXO+uDFarq16QXwrKhLnrqjMPOjpA6eblMyaiaprOCQWmy
         V743sHQiPeqtfcwClNaaxTBMaeYKyKEcoF8v3McY37ffE5oDLWTzyOssVjxZsSrStTkz
         YTDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=/XvnXsc/41L68U7cjQCLa2gjS30EO6JFHccmLV+knss=;
        b=0mZ+vcBPL2MqSeedFKuwHj8yvnRrFpMxxRrtcvYlr0riKTl91gUW3lmG7EjPhJt73h
         b2/YQP5iXAb4px/x5KwgSG79jDWIkvm4lsVTHPrBfbIkZut8yRqPrtB7c94Ihqzk2Ugw
         28Rvdtjo/5c5mAYMfq2kOUKUvvY8SAoSpd4lXJUedC2lohJLig1RGa/eQVqvSQh++kJF
         mRepf32TjO7iY4vLvrO4tQpE9d4rcv+GCkE9SPVeWhbF8zEYwJjCcy0H0OB03w/mSde+
         idY9zUWJH9/mo6XQZ42I/UB+YTp5CmbYlzKKVYerkERu2A7cc4+03mnjtsPfkOjFvJkj
         +TKw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8513A22DCC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Imre Deak <imre.deak@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.16 102/113] drm/i915: Enable display WA#1183 from its correct spot
Date: Mon, 30 Apr 2018 12:25:13 -0700
Message-Id: <20180430184019.516776000@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200517538425005?=
X-GMAIL-MSGID: =?utf-8?q?1599200591394157411?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Imre Deak <imre.deak@intel.com>

commit ac315c621f01d4b8a53dec317c7ae322fd26ff38 upstream.

The DMC FW specific part of display WA#1183 is supposed to be enabled
whenever enabling DC5 or DC6, so move it to the DC6 enable function
from the DC6 disable function.

I noticed this after Daniel's patch to remove the unused
skl_disable_dc6() function.

Fixes: 53421c2fe99c ("drm/i915: Apply Display WA #1183 on skl, kbl, and cfl")
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: <stable@vger.kernel.org>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180419155109.29451-1-imre.deak@intel.com
(cherry picked from commit b49be6622f08187129561cff0409f7b06b33de57)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_runtime_pm.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/drivers/gpu/drm/i915/intel_runtime_pm.c
+++ b/drivers/gpu/drm/i915/intel_runtime_pm.c
@@ -624,19 +624,18 @@ void skl_enable_dc6(struct drm_i915_priv
 
 	DRM_DEBUG_KMS("Enabling DC6\n");
 
-	gen9_set_dc_state(dev_priv, DC_STATE_EN_UPTO_DC6);
+	/* Wa Display #1183: skl,kbl,cfl */
+	if (IS_GEN9_BC(dev_priv))
+		I915_WRITE(GEN8_CHICKEN_DCPR_1, I915_READ(GEN8_CHICKEN_DCPR_1) |
+			   SKL_SELECT_ALTERNATE_DC_EXIT);
 
+	gen9_set_dc_state(dev_priv, DC_STATE_EN_UPTO_DC6);
 }
 
 void skl_disable_dc6(struct drm_i915_private *dev_priv)
 {
 	DRM_DEBUG_KMS("Disabling DC6\n");
 
-	/* Wa Display #1183: skl,kbl,cfl */
-	if (IS_GEN9_BC(dev_priv))
-		I915_WRITE(GEN8_CHICKEN_DCPR_1, I915_READ(GEN8_CHICKEN_DCPR_1) |
-			   SKL_SELECT_ALTERNATE_DC_EXIT);
-
 	gen9_set_dc_state(dev_priv, DC_STATE_DISABLE);
 }
 
