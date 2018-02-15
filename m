Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226nXEQB8cTooc7E8WukG5sc5nqVc2vzYP0O1pJYVf2QXD1o7p6ko3IZ9X+ovbdy7bgIBJqR
ARC-Seal: i=1; a=rsa-sha256; t=1518709083; cv=none;
        d=google.com; s=arc-20160816;
        b=UDlhdgE5Zz68EGw7fAGZCW1rtwjt5jrfNNuFrLVcI/Xud+PMYm2t8Fu3d7nntqEDid
         7FIrkIB7ZZh31gKXxPYS+r6rnv8b+dzZUmG/i7u49PggDrKjMxJUUOtSt2HUvY+kFRdo
         121JauJjKmwqk5LdmwkcmI+ntdYQ48splTDko5mTLX1JSDdy0p1AY3vN/xWCsCSc/rGm
         cJa3EmPSBVDxnlEdNCEnQijFOXnUeZ49OtryqM5zjOAnhNjINUQCLQ+1uzJRYdlp6ryl
         qYot7nfZqbqATJ4PipsaBT2adJDLPL3QnHXfgVaiSdixJ7adedsZINY1eWmViEPqmRVz
         pGMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XT3i9fkWm4tlJAwlLBJeQBsmHAJmgForQOe+GWNZF58=;
        b=W8hOWoR3tsr+sK2raF9g3GT/Kp2/OrHnAedAvU+gaKegct371I2TkDZsYkV2Ncrb2d
         xavT4xho7+7Hr6krv7NfIasBkJ+m46xp23JIjn+J3lf5I6ZEIUMy9oEGm48237FLxtX4
         2D+wJ3LaQcU4XrHCAqDW4uwc/Eedy8R1HAwxWd/4CtXXTrJNTAIcFN/gDzfhf8ExgfLr
         i4D0p1mBvf3938Gc8kzP0vF2Fwvm8sfVhbS++Bwxw/buNMGjnDTSfXOled+TtG2mTzMw
         Oe2Ei14K0D3iITiDNCkeEHRg8/82Fmhf3SLpUn/lnlJu8TNF8oSwqO7qqv7qHlr70vyO
         +WBA==
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
Subject: [PATCH 4.14 185/195] drm/i915: Avoid PPS HW/SW state mismatch due to rounding
Date: Thu, 15 Feb 2018 16:17:56 +0100
Message-Id: <20180215151715.521617724@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481339940516531?=
X-GMAIL-MSGID: =?utf-8?q?1592481895181843114?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5340,6 +5340,12 @@ intel_dp_init_panel_power_sequencer(stru
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
