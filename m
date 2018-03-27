Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+9chKJJjBotHtGkutDWoUltpTkNifz75/usmi9K1UgbeFYP4hcVrNZs1iQj99snakbmPT7
ARC-Seal: i=1; a=rsa-sha256; t=1522168346; cv=none;
        d=google.com; s=arc-20160816;
        b=YRQxbvAR+NYwZrFyiUBBX+UwC+zMcHfIBgknniBDuwi3HabXsuVnD06xI8wKztBPHY
         R36j1JUIzBpdfIG7YmKI7SsLDSwz9tcmG74uCNBm4gHaC20R6zE3SKYOd5YmO5qar5Us
         3aZbRXDpfGpWuhZtIdUKqx+8jqvFXBNEtAHnsbb/bcenCwra/xZwpOQNp5x98INUqOOA
         a0k5FebSJbMP5HXmpsbEfC5luLRNufY1km9a/MDPIJfr8sFWdZzAjj0gmSdj4ZAdn3kv
         596C+Y7wyiz0O3Gxqn+4unaamRBFOsXShePwA0ZPw00bJ31+eWpJjYeWtjRpQdmyscRu
         kZSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BZEBjdTXvYxGgJiZzEaNOjXUei3cUNWQwnHuc3ZaDC4=;
        b=QUzhf6R2I2grGVIjOKYbFLIxmQGDKhq/GdUB+OiQ+ZT6bG7TyEt6DMUyRsWmApDkZs
         v80p397HAO8z6yfkukW8BRuqPxHi0uIiqRFD82WEdb3pqJNf5a6Xenro439UBKL4CZpM
         IeLciqjsFAiOlzDmWxsDG5k6UibNNnGZ74uhYaf25kfwKzUFRqfi8w4yAaS1k3mQLLOB
         BBH5lMfzmQNz3OmGj83ls8Oy2U6ymITUGdHj3OasxT0dJrsDmgUjTCmS5O69pUs6zoHg
         m5L9VapoWRj8jc5AmXj9SmdxQ1tWlptXBlcm/E9vMg6r81V738XKupB58GRJgSiEMMCH
         IqBw==
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
Subject: [PATCH 4.9 12/67] clk: sunxi-ng: a31: Fix CLK_OUT_* clock ops
Date: Tue, 27 Mar 2018 18:27:04 +0200
Message-Id: <20180327162727.374174062@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109196133514805?=
X-GMAIL-MSGID: =?utf-8?q?1596109196133514805?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -750,7 +750,7 @@ static struct ccu_mp out_a_clk = {
 		.features	= CCU_FEATURE_FIXED_PREDIV,
 		.hw.init	= CLK_HW_INIT_PARENTS("out-a",
 						      clk_out_parents,
-						      &ccu_div_ops,
+						      &ccu_mp_ops,
 						      0),
 	},
 };
@@ -771,7 +771,7 @@ static struct ccu_mp out_b_clk = {
 		.features	= CCU_FEATURE_FIXED_PREDIV,
 		.hw.init	= CLK_HW_INIT_PARENTS("out-b",
 						      clk_out_parents,
-						      &ccu_div_ops,
+						      &ccu_mp_ops,
 						      0),
 	},
 };
@@ -792,7 +792,7 @@ static struct ccu_mp out_c_clk = {
 		.features	= CCU_FEATURE_FIXED_PREDIV,
 		.hw.init	= CLK_HW_INIT_PARENTS("out-c",
 						      clk_out_parents,
-						      &ccu_div_ops,
+						      &ccu_mp_ops,
 						      0),
 	},
 };
