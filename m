Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2275lrQhUi5hxuxlFWkvPSpG1HL5j3gkZOOaqZU1jkm+b9ZScinwTTIgwOD6saX2nR4MUjfm
ARC-Seal: i=1; a=rsa-sha256; t=1518708553; cv=none;
        d=google.com; s=arc-20160816;
        b=APvz7mPP0v3QYjgq/JujadgGQQg9tpmBUCU5aXBnjZ91SMlcHMhpzaYX7+RI7H13As
         aeCWGEqz78KE2uvZUCkh11+yRr39f+lQujjezv5HYnNx79NcLDDo6Od00vZAyCwVfzdK
         kSqN95FD0VvKOxuHUSXesRjZmIyMnpPun4MgAVVpIUSe9U9eVIyDnugarTOTCoU4W4f6
         VCpK/w7CCIuKUz230iOYV8NhVUnIZjgpMC1taduXm2rdvxHFA5MEXHmyWPK8zzQ5yW86
         4IudZ6ZFDoX2u+45RrkVVWTJdts5A/KFHxos123kfDI2TuVT4GAT6hTwjVo5H5M+Jng8
         VI0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PYCmHvv/KMomvRALwghLJTnlAQX4JMBlSC7TUspA3TQ=;
        b=Z7KEx+dkplzOolq4tRC1OSlF0okmCLM/ArzmmMfckqTqgKSIc2IsnnWLbun2xDCyY3
         lD/N+Ns44H/qt70jQDDiDG6WYyhQWz4vgugGPdqEQb0d0DOJvWrSVl+2jz6EEFBkPQQi
         wW7lHuI0hROulXaNed7XNQqano1rYYXr+n2qUGCNhYzR6zfFiAly4LnwL54jZQBXHG5B
         EvnCqKWa7Vl1l8TEFH/NES8LbFFqvLejYich+RJ0ZXQdDoPiTyo3VHx1QeFrEq3NT6fn
         fuCSLJvcdnpTY8ETHtT1uJIyejFyB5hPEx/cfSDGa1CRrQ7BYwdmpIjQVfa40BMumOnK
         Lbjg==
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
Subject: [PATCH 4.9 83/88] drm/i915: Avoid PPS HW/SW state mismatch due to rounding
Date: Thu, 15 Feb 2018 16:17:50 +0100
Message-Id: <20180215151233.956071720@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481339940516531?=
X-GMAIL-MSGID: =?utf-8?q?1592481339940516531?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5063,6 +5063,12 @@ intel_dp_init_panel_power_sequencer(stru
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
