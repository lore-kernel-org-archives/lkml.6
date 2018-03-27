Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/GvKxLkFbu+7O++Q5fF4nuUcHAnPZyj7b9JimqrSeBgXnebUCEBkw/1b0xSJoyIomFvdQ9
ARC-Seal: i=1; a=rsa-sha256; t=1522168775; cv=none;
        d=google.com; s=arc-20160816;
        b=zKE6vEX1xK8GMs+YINF95EM1I8MOlY11xRDxnlb8bHI84Lcuo3iH5Ih0XGn/bSt+Jt
         2Qye2WkaW5Z5450KBLqAtV3skWIl1csBwvWHPl1B9Mh8B2FiU/a8uWNWjOCjZqhSrJuc
         z7Gkpx3I9saljm0phbEiu/0JvyYwchinAov25ZdIGWa/KG7fBj/l8RCvMVw6niVVoEgq
         cD5p2/eBUog/6CpogtAs6kakkNJfWH8XLEXR63i/a8y9N6/exyiuTPb/9rknU2+HNXGr
         brRI3dyNuQUEUCmaiZS0md4GgWL95oVkWhkTjwaFklqtQ/MNqUBR8Yk55bGvrRED1Urq
         IIzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uDuXOSdx6AV8yUglrXFzqE6rKNOs3tHcK0Glf7r2oWg=;
        b=m54d6ulLDaTiBAwgmwTVbTAlLMQhM9IGRpdiaRP3wv+dNMs4+edQExxsgTUOiz9N8V
         63iN3FPZOIjFFIwW0+nUSjYmRsSkHqV7sHLG2eTdx39rE+he5l/LuEXz0FU4u79e6d47
         XFUqXKbpUkaWm5V4wJnXe95NnmwrSk2Sy0Y2ZEpCrYz1JF9ZsML0x2jMNXJ0smlagGq7
         rk5ZJoq44XvX9hVFtq2bFGXDV6Ta3VO6zGgLSxZgbDLvuUzFWcD2OoJyLCPsnkcEKsdP
         AykY1sK+AI8KfFMB85ICnmvqGGLDb6CCOL82SFcWeVQOHyBnJh+gIQ2x+S6yC6KUkmms
         lnLw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Philipp Rossak <embed3d@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 4.15 027/105] clk: sunxi-ng: a31: Fix CLK_OUT_* clock ops
Date: Tue, 27 Mar 2018 18:27:07 +0200
Message-Id: <20180327162759.045645626@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109196133514805?=
X-GMAIL-MSGID: =?utf-8?q?1596109645756347393?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen-Yu Tsai <wens@csie.org>

commit 5682e268350f9eccdbb04006605c1b7068a7b323 upstream.

When support for the A31/A31s CCU was first added, the clock ops for
the CLK_OUT_* clocks was set to the wrong type. The clocks are MP-type,
but the ops was set for div (M) clocks. This went unnoticed until now.
This was because while they are different clocks, their data structures
aligned in a way that ccu_div_ops would access the second ccu_div_internal
and ccu_mux_internal structures, which were valid, if not incorrect.

Furthermore, the use of these CLK_OUT_* was for feeding a precise 32.768
kHz clock signal to the WiFi chip. This was achievable by using the parent
with the same clock rate and no divider. So the incorrect divider setting
did not affect this usage.

Commit 946797aa3f08 ("clk: sunxi-ng: Support fixed post-dividers on MP
style clocks") added a new field to the ccu_mp structure, which broke
the aforementioned alignment. Now the system crashes as div_ops tries
to look up a nonexistent table.

Reported-by: Philipp Rossak <embed3d@gmail.com>
Tested-by: Philipp Rossak <embed3d@gmail.com>
Fixes: c6e6c96d8fa6 ("clk: sunxi-ng: Add A31/A31s clocks")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
@@ -762,7 +762,7 @@ static struct ccu_mp out_a_clk = {
 		.features	= CCU_FEATURE_FIXED_PREDIV,
 		.hw.init	= CLK_HW_INIT_PARENTS("out-a",
 						      clk_out_parents,
-						      &ccu_div_ops,
+						      &ccu_mp_ops,
 						      0),
 	},
 };
@@ -783,7 +783,7 @@ static struct ccu_mp out_b_clk = {
 		.features	= CCU_FEATURE_FIXED_PREDIV,
 		.hw.init	= CLK_HW_INIT_PARENTS("out-b",
 						      clk_out_parents,
-						      &ccu_div_ops,
+						      &ccu_mp_ops,
 						      0),
 	},
 };
@@ -804,7 +804,7 @@ static struct ccu_mp out_c_clk = {
 		.features	= CCU_FEATURE_FIXED_PREDIV,
 		.hw.init	= CLK_HW_INIT_PARENTS("out-c",
 						      clk_out_parents,
-						      &ccu_div_ops,
+						      &ccu_mp_ops,
 						      0),
 	},
 };
