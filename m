Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+oI7+n1u306RATz6zQTf+MWOH5urnPalceai9zKe1V0YTPKne3YbU9fK6tbrX29WGskck6
ARC-Seal: i=1; a=rsa-sha256; t=1524406397; cv=none;
        d=google.com; s=arc-20160816;
        b=PLsbJkwSiViiqR01y5gdQyWpj3V5pl+ym7WxzoHn+6H3LXv3bW4a9mGe66Plj+mU4a
         0qyL2GFx2n+EflpX5hrSpJWibp/q9qMowmffr7NBHfFAffR6vDawOVljfSKIEnlo0J+4
         zjBrm9wRVNvRe2WAxuTEtSEpvVj9na2D1AA3hiVTVMvnGC25IkBrIpCr2pi3HtcB3vVj
         Oq+qGo5IxTD/sv346adAslJaaNEgh4fUQ1gjZDDjNSnRPxamzxQ5GrWA5VkenxdPlaDF
         25zGFrXOwfhBjtG2god8L+T9cPzKQ6jer5X1P2B//wAPEkAppNGCAtxo/SOGUYiwePEX
         M+tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ML/2hBxGPoiADxK77zuImUl377uibHk2n/IIVdMyGcw=;
        b=onyQU6Xnm88xPiogZbiPaGN0aR1uT4qeY9nvcdTLydMUBGwio/3EyXN+BxeoiCZ8Og
         it14ckd2h34n2T2clH4/O5yevKkMAymH/x11NT0A8MwgEA0JltH77YpYFMBr72AMtKKP
         uPH9q3Uj95tAKuz19AnXkZbhfqPftyB6cYQkUTMDCkuvHEenx2q1orZTY2+pLdJGBd7X
         5igC/arWN29WqI+kWDjGc4SJGDTFXugnFMmUSRs0V+49TRke+5XQ47LG3ckCcuDm5LyC
         Au0tgTmFDvS3+ggdovMcuAQ3USOceJ7T/gDoSad3EK1j/6TgVKsLloA2TpotuV9XYIqX
         0AzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ryo Kodama <ryo.kodama.vz@renesas.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 4.9 55/95] pwm: rcar: Fix a condition to prevent mismatch value setting to duty
Date: Sun, 22 Apr 2018 15:53:24 +0200
Message-Id: <20180422135212.672734362@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455179558779076?=
X-GMAIL-MSGID: =?utf-8?q?1598455962861710476?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ryo Kodama <ryo.kodama.vz@renesas.com>

commit 6225f9c64b40bc8a22503e9cda70f55d7a9dd3c6 upstream.

This patch fixes an issue that is possible to set mismatch value to duty
for R-Car PWM if we input the following commands:

 # cd /sys/class/pwm/<pwmchip>/
 # echo 0 > export
 # cd pwm0
 # echo 30 > period
 # echo 30 > duty_cycle
 # echo 0 > duty_cycle
 # cat duty_cycle
 0
 # echo 1 > enable
 --> Then, the actual duty_cycle is 30, not 0.

So, this patch adds a condition into rcar_pwm_config() to fix this
issue.

Signed-off-by: Ryo Kodama <ryo.kodama.vz@renesas.com>
[shimoda: revise the commit log and add Fixes and Cc tags]
Fixes: ed6c1476bf7f ("pwm: Add support for R-Car PWM Timer")
Cc: Cc: <stable@vger.kernel.org> # v4.4+
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pwm/pwm-rcar.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -156,8 +156,12 @@ static int rcar_pwm_config(struct pwm_ch
 	if (div < 0)
 		return div;
 
-	/* Let the core driver set pwm->period if disabled and duty_ns == 0 */
-	if (!pwm_is_enabled(pwm) && !duty_ns)
+	/*
+	 * Let the core driver set pwm->period if disabled and duty_ns == 0.
+	 * But, this driver should prevent to set the new duty_ns if current
+	 * duty_cycle is not set
+	 */
+	if (!pwm_is_enabled(pwm) && !duty_ns && !pwm->state.duty_cycle)
 		return 0;
 
 	rcar_pwm_update(rp, RCAR_PWMCR_SYNC, RCAR_PWMCR_SYNC, RCAR_PWMCR);
