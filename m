Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsOov+FEhUdwAG9SnEo8tQk2mi5qLx2GNV1i5aqR0iV4SUEkvjJQOdQwGiEQ/o46oeND7at
ARC-Seal: i=1; a=rsa-sha256; t=1521483857; cv=none;
        d=google.com; s=arc-20160816;
        b=AY7C8hhzA6cmBIVja5nNM5WMnlkUd1I3DoJrFSbN+V9dhJcrfdBxY3vBCq20zV90MD
         xRLRqXhKrWYSL0J3YNR2T4h5HEcPy8p/N920SWhTjWf99ckMsHyhw7tlO9cUg8ZcU09r
         1gzw/sEtRUqWkgdy02MusG4BvqZ+EzFpSp5UAhlWBa4MTaRD/XZmaVWqbPL3O5oLnXDz
         psVUn0A8/YBfB4DMDgFYkru6OtPxYgpQjzqFuG+frjSyxbX0dcvAh29Q/59+uF5yqXdh
         0YLL5OvBxYeZo3ttr2JfEe06K99S0IrtVP8w/lWFnuI3kSHWNxcgfcHujIQm+9Y0kWX0
         j2/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nzWCiPfi+kBEZCcAxheY9G0eIVn+sDejiv4kULv1dRE=;
        b=M75yokQiYlQjc5XXLs1WE73IXPh87uN2u+j+TzIB4R1WysfsCgKBCJu6G4//0BKye5
         zC6iUuKkczdTkpZJSwXqJ0HxaAjhi40cuas/NljFx4GdfRc/homkA4a8x8vwRjV9BdXm
         ilmTuM/WEU1o+9NZX1fXbIUlrwBB8KBe4ORhinUW8Wvf92QuceXFwFkAq43UuAGuvl5a
         WEkczUOdrng+ASaDvJKdsEJ1e4RvC9eSyG0gVDh0vEZi0qZReJQNeCHp1IhyMBFaQcB/
         8TVFzRPpzx6M+uV3/53iW3DevA2tTNJCemEb5E3yTJrBiSNB9baknQVJaMfdpKkjOdT8
         23bA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chen-Yu Tsai <wens@csie.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 106/241] clk: sunxi-ng: a33: Add offset and minimum value for DDR1 PLL N factor
Date: Mon, 19 Mar 2018 19:06:11 +0100
Message-Id: <20180319180755.581634748@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391457702377115?=
X-GMAIL-MSGID: =?utf-8?q?1595391457702377115?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen-Yu Tsai <wens@csie.org>


[ Upstream commit 68f37d862403e8f95337b2eca90af15d0b8cd5d7 ]

The DDR1 PLL on the A33 is an oddball amongst the A33 CCU clocks.
It is a clock multiplier, with the effective multiplier in the
range of 12 ~ 255 and no offset between the multiplier value and
the value programmed into the register.

Implement the zero offset and minimum value of 12 for this clock.

Fixes: d05c748bd730 ("clk: sunxi-ng: Add A33 CCU support")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

--- a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
@@ -159,13 +159,17 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(
 					BIT(28),	/* lock */
 					CLK_SET_RATE_UNGATE);
 
-/* TODO: Fix N */
-static SUNXI_CCU_N_WITH_GATE_LOCK(pll_ddr1_clk, "pll-ddr1",
-				  "osc24M", 0x04c,
-				  8, 6,			/* N */
-				  BIT(31),		/* gate */
-				  BIT(28),		/* lock */
-				  CLK_SET_RATE_UNGATE);
+static struct ccu_mult pll_ddr1_clk = {
+	.enable	= BIT(31),
+	.lock	= BIT(28),
+	.mult	= _SUNXI_CCU_MULT_OFFSET_MIN_MAX(8, 6, 0, 12, 0),
+	.common	= {
+		.reg		= 0x04c,
+		.hw.init	= CLK_HW_INIT("pll-ddr1", "osc24M",
+					      &ccu_mult_ops,
+					      CLK_SET_RATE_UNGATE),
+	},
+};
 
 static const char * const cpux_parents[] = { "osc32k", "osc24M",
 					     "pll-cpux" , "pll-cpux" };
