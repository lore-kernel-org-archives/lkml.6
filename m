Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+qY42/++jgLL8kLuOKto1Y/x9L2iEvuEN3KI+bR7/giSWAQGRY4tu70/MxOOmIJ556X+up
ARC-Seal: i=1; a=rsa-sha256; t=1522168589; cv=none;
        d=google.com; s=arc-20160816;
        b=RNq+K5iZ3fjmE+CjbuVeKe+aB3giURjOvcoOyNHPPVSjdq/Ytc6zbdQwbnfQ7runTd
         1TEnAwHYnJKHoAtTqga0q1D3m/rVh0iLKGZ3DKuS65EjlY1ABpYtN2G63gHxPN3R+VgJ
         1N/avrOtDcU9IUb6VmY0ymRS/5PTy1/vBooDf8wQMy1wHhk2dXbZ5HAkqUNxGXAGhB6O
         co7QFDtWyx7o1Lj/MnmmbKS5XZZ2Wch0T5oJXafEi9BzPOAutErkUTjtCXXhrgepu2l9
         5MWUupOD8EtQNr39GpQnw0YR6gET0DKNuHfgMRzAoG0UL/unPREvqfzFb8fVyNBW1JIH
         /3pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=u7zD8W0zcekjgmCdBvauc5gDm1yNKEwMcTjiDHQS3+k=;
        b=AlhOGfE1Banav2NZYwdZXdJd9A4nCBFG6oKBQA964baTu89CUmKVY4WqFUQ7PkxQ/W
         B365xCcp13T5/6w8qefk+DvOiSLgJ83CDZsMvhqRiSA6SyaTUWpGd45g5Y8AGtTQDWYn
         OrfZVd/dXIRg5PJAoaFKy6qJUk21osZNnsOIiGs/Hc3vIzqWHh/TdxiUAdLwrV9fvMJa
         QZGdF2HDKRepDTom1Pe4vHD21+MVrpfiZ02IPkqcJyZR3LUSh9DHqhEqAd/QclgTdb9n
         ih7Pi0MxWf2N2iweWne9L4FOHpMPI30zEzbGHwpKLo20YF6IlYjdoyECTZvFWTSJFh6L
         1tzQ==
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
Subject: [PATCH 4.14 027/101] clk: sunxi-ng: a31: Fix CLK_OUT_* clock ops
Date: Tue, 27 Mar 2018 18:26:59 +0200
Message-Id: <20180327162751.654694029@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109196133514805?=
X-GMAIL-MSGID: =?utf-8?q?1596109450328730866?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
