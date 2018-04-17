Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/n4jpvkH6LmvXFe8jE2dQ4xpi8ajG9Tz7MgQi2iBcuErOszECJHuS7qs2VWaumHrZlmQnV
ARC-Seal: i=1; a=rsa-sha256; t=1523980991; cv=none;
        d=google.com; s=arc-20160816;
        b=aRPhCeu93+08c1Z6rkM+B6m4ePgAmUsotc4TPDDzVfdxvxSMZjRwg2WJWA+gIVMEUw
         cg3jwoj2gOXF0eKwJuarSKREKK6HAgHOl2Q9UxSTRgEgnwnzvEsA8eUmMWey3ajIzL1D
         btvaUHnnsOoxtetWtQcWSdvCIrsspCbKMh3rDM49Ni69ycr3CmZZoptEpQ7m0m818jTZ
         lcJdijrHQPyhIpMqh5Owh2jtN+K23u4rEjX7O0qZCctlRlWfXvVC/3mpq40bLvxOBtIO
         eKhU7iJtmVgCGAPaX2U9sW+6X6/bRsrFOhBjGUmmBmd23wn5nnC7lFY0Py9ypJvNYpjB
         eOMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DG8qGGE/ZC8ITk1346BCRxkWHquc/6xm1qRQeg0DRoE=;
        b=1Lq971wprYSww7Tw86AxCpNiGCUtp9KeBlT9qO7llZMYZXJbuW0kQknzEhq6a1+RM1
         L4HDmBJF0MSA++hFfsfCofkCTO6qmcHdeaWFTBnqhaHioTkQbuJ9VsPdzDgpSIyGzSFb
         O2b5xwJ2edwx4LVa0tqNmWsj1J+RnnIk6mfQEzt2M4dT+NHXPn03BCy494gqWLf/oq7f
         jtTsTb42096HNOfFh58pcbrAY7e1mQ6MwhgPMzSHEO/Dzf50PvyY1Fe7L7B2WySpvQlh
         jccwfF7GImbDmhuVxP3JrBR0GkVWiww72X8w4aEiRo6rKdSDX/DT671ja2eft/lAtpTB
         LtVg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Clinton Taylor <clinton.a.taylor@intel.com>,
	Jim Bride <jim.bride@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Ville Syrjala <ville.syrjala@linux.intel.com>,
	Dave Airlie <airlied@redhat.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Manasi Navare <manasi.d.navare@intel.com>,
	Imre Deak <imre.deak@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 4.15 01/53] drm/i915/edp: Do not do link training fallback or prune modes on EDP
Date: Tue, 17 Apr 2018 17:58:26 +0200
Message-Id: <20180417155723.147213348@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009892187489876?=
X-GMAIL-MSGID: =?utf-8?q?1598009892187489876?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manasi Navare <manasi.d.navare@intel.com>

commit a306343bcd7df89d9d45a601929e26866e7b7a81 upstream.

In case of eDP because the panel has a fixed mode, the link rate
and lane count at which it is trained corresponds to the link BW
required to support the native resolution of the panel. In case of
panles with lower resolutions where fewer lanes are hooked up internally,
that number is reflected in the MAX_LANE_COUNT DPCD register of the panel.
So it is pointless to fallback to lower link rate/lane count in case
of link training failure on eDP connector since the lower link BW
will not support the native resolution of the panel and we cannot
prune the preferred mode on the eDP connector.

In case of Link training failure on the eDP panel, something is wrong
in the HW internally and hence driver errors out with a loud
and clear DRM_ERROR message.

v2:
* Fix the DEBUG_ERROR and add {} in else (Ville Syrjala)

Cc: Clinton Taylor <clinton.a.taylor@intel.com>
Cc: Jim Bride <jim.bride@linux.intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Manasi Navare <manasi.d.navare@intel.com>
Reviewed-by: Ville Syrjala <ville.syrjala@linux.intel.com>
Reference: https://bugs.freedesktop.org/show_bug.cgi?id=103369
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1507835618-23051-1-git-send-email-manasi.d.navare@intel.com
(cherry picked from commit c0cfb10d9e1de490e36d3b9d4228c0ea0ca30677)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_dp_link_training.c |   26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

--- a/drivers/gpu/drm/i915/intel_dp_link_training.c
+++ b/drivers/gpu/drm/i915/intel_dp_link_training.c
@@ -328,14 +328,22 @@ intel_dp_start_link_train(struct intel_d
 	return;
 
  failure_handling:
-	DRM_DEBUG_KMS("[CONNECTOR:%d:%s] Link Training failed at link rate = %d, lane count = %d",
-		      intel_connector->base.base.id,
-		      intel_connector->base.name,
-		      intel_dp->link_rate, intel_dp->lane_count);
-	if (!intel_dp_get_link_train_fallback_values(intel_dp,
-						     intel_dp->link_rate,
-						     intel_dp->lane_count))
-		/* Schedule a Hotplug Uevent to userspace to start modeset */
-		schedule_work(&intel_connector->modeset_retry_work);
+	/* Dont fallback and prune modes if its eDP */
+	if (!intel_dp_is_edp(intel_dp)) {
+		DRM_DEBUG_KMS("[CONNECTOR:%d:%s] Link Training failed at link rate = %d, lane count = %d",
+			      intel_connector->base.base.id,
+			      intel_connector->base.name,
+			      intel_dp->link_rate, intel_dp->lane_count);
+		if (!intel_dp_get_link_train_fallback_values(intel_dp,
+							     intel_dp->link_rate,
+							     intel_dp->lane_count))
+			/* Schedule a Hotplug Uevent to userspace to start modeset */
+			schedule_work(&intel_connector->modeset_retry_work);
+	} else {
+		DRM_ERROR("[CONNECTOR:%d:%s] Link Training failed at link rate = %d, lane count = %d",
+			  intel_connector->base.base.id,
+			  intel_connector->base.name,
+			  intel_dp->link_rate, intel_dp->lane_count);
+	}
 	return;
 }
