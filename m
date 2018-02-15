Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227HaoZl2b1c7yvfGaevfWgLrKWaqD8I580n/AIuC3BRoMYhhtOZphHZRg6nNRGPP+PLaRNv
ARC-Seal: i=1; a=rsa-sha256; t=1518709639; cv=none;
        d=google.com; s=arc-20160816;
        b=WZH46L/P/xJbxFEwI1M5Paa3IDa+t4kM0Xdr9fa9gDuNCLRCiAQZuo4arZQ4s8fSLE
         tpbNXkeGUN83IVd1z9iMbIM12PP+OVFaXCtOcY+ZkAQTFxSvWqBYA29vkDcMTPA858BK
         EyE/G8OxlK2QNlmF80tg5zvEFOfgdfX0221GK1eZQCwB8mgS79Thare8lhmu79F4Tth5
         Hp8+fnz77SJSZ+PC/uMYRt63txqpEVg+dmHgywqHSc4ohWG3GNFg6bSnsmXn7XQ0JlJj
         YAvqFYAJrRwjL1/Cq4RANBc3TFoH49twFKaYkYwNEbzKsH2HjndBDTFbl8v33JSyEm7+
         ibYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zkv/84itfVUpidm9OOByjVQeQwcHFQ1uiHXCebwKJs0=;
        b=aqdz8Oxm2kPoo6LhCYSvjWgZDproItvve2ENlHD7RsLr0XmwgR+xcj4wl522e1QgT6
         rUzClySOYskKmnkSSQrx3FP4YaEe4/CVhk7vV7WJzYGcTI5vuTaeyrSW/gA76bujRZdu
         QnupCsXNdbr93WBQwJkMexzNAl6/ZoResqGb28eCTOE18eCcx2rqLUNJf2zBX/cWDtD7
         AVedotabvDWkK5Fc+KIngO0zK3PLb8gHydjiJgLVb2i4u44Iu+DpHgTaiALzI7/0AXiD
         7Dlg1HnjezjCxff8VOPyaNAhidA8dTxveOTkUkKvIXLblRB+BEoOp/IsRABC2B6GoxtW
         CUCg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	joks <joks@linux.pl>,
	Imre Deak <imre.deak@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Subject: [PATCH 4.15 189/202] drm/i915: Avoid PPS HW/SW state mismatch due to rounding
Date: Thu, 15 Feb 2018 16:18:09 +0100
Message-Id: <20180215151722.653090788@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481339940516531?=
X-GMAIL-MSGID: =?utf-8?q?1592482478370497292?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Imre Deak <imre.deak@intel.com>

commit 5643205c6340b565a3be0fe0e7305dc4aa551c74 upstream.

We store a SW state of the t11_t12 timing in 100usec units but have to
program it in 100msec as required by HW. The rounding used during
programming means there will be a mismatch between the SW and HW states
of this value triggering a "PPS state mismatch" error. Avoid this by
storing the already rounded-up value in the SW state.

Note that we still calculate panel_power_cycle_delay with the finer
100usec granularity to avoid any needless waits using that version of
the delay.

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=103903
Cc: joks <joks@linux.pl>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20171129175137.2889-1-imre.deak@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_dp.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/gpu/drm/i915/intel_dp.c
+++ b/drivers/gpu/drm/i915/intel_dp.c
@@ -5336,6 +5336,12 @@ intel_dp_init_panel_power_sequencer(stru
 	 */
 	final->t8 = 1;
 	final->t9 = 1;
+
+	/*
+	 * HW has only a 100msec granularity for t11_t12 so round it up
+	 * accordingly.
+	 */
+	final->t11_t12 = roundup(final->t11_t12, 100 * 10);
 }
 
 static void
