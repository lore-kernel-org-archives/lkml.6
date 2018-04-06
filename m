Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/0R77WYXv6uBNREyKSi09pvUdNk1Th95i6ZKPTaV2FRe4AU27VVIj9YeQ83JRATFLrWzS4
ARC-Seal: i=1; a=rsa-sha256; t=1523022134; cv=none;
        d=google.com; s=arc-20160816;
        b=vHgY010Ti7IN6fMtt0Ppkzt+TTOE7hiLizAIbPMCiQjm7Lhc5sqTA8GZq3uuD47B9l
         lfD0CrSdK+j3FD4oW7GZLOCIeVUhz7JET3zstW9gP7YiB6FfQTAuT0nXOYJN7uD9soOR
         jXKvnp4U+AI3UUNkjlVyQyZuwkEbpudy+p/uXC64CNEiMKaO8Jmq+/XRmMuPSW8w6TJH
         CtkVR/VjMXVRmXKbAtsuBdexCgmE+wJkucK2uBeRqiNPwzAQUPvNqS3YfyCBR/0yjNxu
         O08WkZpg0rD0s3cPpaLUXjDWAmb5BEbDsNwa6qPZO77CSmmc+pafOt2yzkiTp/xmRbPk
         cAXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sWWqjPkb4XViTnve5Iu3Nr77EVmmUZPPqs074fdupo0=;
        b=oxSrpH4LXpGnJxOT/ki/jJ3NkwdHG2TcO6u/A7tHiurKcr5cL6FErvVC1wHmJPbIHB
         GZMgVGxLRLArir2HcAg8CyfGiQM4yuQy77wQmwciCbXdwOceg8t0ZjVlatIE2Gwyi4Os
         63yaCqJqzqQgg0N+ad1+HbPb4o+pUv3JlqZUctkZ6SUuz3y3XpkVXfvk6TzdxiYaYy43
         56+isqCOtdowOK5LY3psmg2q/o074NMslmWkAHh3KgOa3YhShGU57dQ7OwnyHcF8x4f8
         O1x+oJ0SrWHEGJW/qsW70iuJ/3uu7iD37/hg00SHqKLYVXOGlbLULnS6/FGle/FXYaJg
         ta5g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Laura Abbott <labbott@redhat.com>,
	Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 4.15 39/72] drm/i915/dp: Write to SET_POWER dpcd to enable MST hub.
Date: Fri,  6 Apr 2018 15:24:14 +0200
Message-Id: <20180406084352.434407979@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004457960647958?=
X-GMAIL-MSGID: =?utf-8?q?1597004457960647958?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>

commit b1e314462bba76660eec62760bb2e87f28f58866 upstream.

If bios sets up an MST output and hardware state readout code sees this is
an SST configuration, when disabling the encoder we end up calling
->post_disable_dp() hook instead of the MST version. Consequently, we write
to the DP_SET_POWER dpcd to set it D3 state. Further along when we try
enable the encoder in MST mode, POWER_UP_PHY transaction fails to power up
the MST hub. This results in continuous link training failures which keep
the system busy delaying boot. We could identify bios MST boot discrepancy
and handle it accordingly but a simple way to solve this is to write to the
DP_SET_POWER dpcd for MST too.

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=105470
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Reported-by: Laura Abbott <labbott@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 5ea2355a100a ("drm/i915/mst: Use MST sideband message transactions for dpms control")
Tested-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180314054825.1718-1-dhinakaran.pandiyan@intel.com
(cherry picked from commit ad260ab32a4d94fa974f58262f8000472d34fd5b)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/intel_ddi.c |   12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

--- a/drivers/gpu/drm/i915/intel_ddi.c
+++ b/drivers/gpu/drm/i915/intel_ddi.c
@@ -2208,8 +2208,7 @@ static void intel_ddi_pre_enable_dp(stru
 		intel_prepare_dp_ddi_buffers(encoder);
 
 	intel_ddi_init_dp_buf_reg(encoder);
-	if (!is_mst)
-		intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_ON);
+	intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_ON);
 	intel_dp_start_link_train(intel_dp);
 	if (port != PORT_A || INTEL_GEN(dev_priv) >= 9)
 		intel_dp_stop_link_train(intel_dp);
@@ -2294,19 +2293,12 @@ static void intel_ddi_post_disable_dp(st
 	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
 	struct intel_digital_port *dig_port = enc_to_dig_port(&encoder->base);
 	struct intel_dp *intel_dp = &dig_port->dp;
-	/*
-	 * old_crtc_state and old_conn_state are NULL when called from
-	 * DP_MST. The main connector associated with this port is never
-	 * bound to a crtc for MST.
-	 */
-	bool is_mst = !old_crtc_state;
 
 	/*
 	 * Power down sink before disabling the port, otherwise we end
 	 * up getting interrupts from the sink on detecting link loss.
 	 */
-	if (!is_mst)
-		intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_OFF);
+	intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_OFF);
 
 	intel_disable_ddi_buf(encoder);
 
