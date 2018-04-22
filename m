Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48L2nmlAO0poEb/VehE0rICDIujaTbypRBvwRzfzDkvbOv4hsdo9o+2U7l9y1AFdv5VzrtL
ARC-Seal: i=1; a=rsa-sha256; t=1524405650; cv=none;
        d=google.com; s=arc-20160816;
        b=PjPRlih1eS2PiT/pgUz0vA12TgKWtcDoEICWJ/eZKsgt7VG7OuMTjyjsYz9U3XuxP8
         0jHoybooodG0BVS89Rc8n/bNBBKIs4NGWAVYwRvQQu4ZfUipYl/0AQMxha37PhwO0JL0
         1XhJmaISOovPF8y8mg9ylK0hzgMsaDKYElrhtXEtu/Jo+oJ4IBU2SZLu0I24lC2dqJ1Y
         MeOBj2/GXin10MyyrKppb7w0xCuaRbaJ8g/qKnLfeivTZraN64mk3rrmObSTiAPeo80L
         JggXHbNu0la7vqOkME+/vcD6zLJW5k6mSdMsprsUu1/HsbWVUH4p6vjbQYqoCFPxCFA/
         D8iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yelcw4EGyCFgi1XTVusKbBfzuAxQUd8akiIJdBsZfaI=;
        b=zLyb4H4rIbhWF/M3nVUkXYCMLug3SeG9PPCs7atc0VLvU+BHhu14F9808naWTkUHu5
         5Mn8zUUoS8JUE0d0x/U668Pa0Oqe/33mIb64Q7474/kJbPq75WNgGEAQ1RZU9f/xax3C
         nXW96oOQUTrezo4v8EmxmhYrIxOWRXgTHsTpWYEbzJr9BAF9LTX670tUxX8JNTkT+HAE
         mAmFYd1m4m/QCmyRlyOhucB+0+2kqATzsnBhS9rFeT4F2VbJ6bJ//zdmH5vAhH47DOtY
         xxMtQTyg0HEsy29LSrKjklyivEfMQAUde53EWymaFtaA8/w8YMCVhtZkKBEFIAlmcuQd
         JYbQ==
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
Subject: [PATCH 4.16 144/196] pwm: rcar: Fix a condition to prevent mismatch value setting to duty
Date: Sun, 22 Apr 2018 15:52:44 +0200
Message-Id: <20180422135111.678772845@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455179558779076?=
X-GMAIL-MSGID: =?utf-8?q?1598455179558779076?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
