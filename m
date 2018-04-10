Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx499oqiFmFSwyR6c/fBXwXUvHNQmLeS2OOlpKFjAFX3BuiA2tZ4i1UJLwd/TmA9YdpDLSTrO
ARC-Seal: i=1; a=rsa-sha256; t=1523399349; cv=none;
        d=google.com; s=arc-20160816;
        b=Q9+xK8L/gCaTq68WtudJ9NS/MwdQiEcPpSnYfbRJT9wA3NRQ1x47RiIBLvc0BX5qR4
         2Y/nafFYLNHXukaSymCl9O28ZSRj9UhLGTT6CjIwmVPiEkiJYQNF2aZYN032X8vtmBEG
         tWVLEOkAyMANJxv0RbVeiptOhlMw0TOrli6pNu6O8z1DZZck+m3BToya40SrwH6mPteM
         L5VI1aK7nlA0+I0l8ay618sFroMUqUqNBgedf52qzVb2gHC0TrMwPdvmEWn1dFO++okY
         HjCOUW8JPamvl1V5Ly9rX6jMS0HkgVnyduPePuzDWmG4E5nb2s23J/m7soUrm8Xq9e3S
         0qrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rxSFV+IHdrv43iuZdy9ytktt33Wf8Gdflps1pLV5xbI=;
        b=ZqGBlebzzeL6jLle0YXd1z8CBwcjeB4lX+q5fsQV1OQnthR+DGjtC202Q4AKwPdTpM
         Doic8jckluwbo+mGbW/z+WEM6q9zCxsSxyWc4G/+m4QqgnG63jJuCh36qwMq5QDMG+df
         V2jBG1WJYZnOSPyUiRUBtH0Sky+K2F438NrFFieRHlMlViqlMzePswiSBbH/gUxcUoq3
         4x4A6s4tp8Me3JgIr8DaRCITVMVA3NQEgLJ2Jiq+lbADHKrbG55tsjiTqWgeuDKF7reg
         DkHQyQ0UdhMwtM4J0NcsHj76wabojtJBjQ+bajCXMsEQMKWDMRCkQfE30p2vFs+u8PlD
         XJQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 057/168] pinctrl: baytrail: Enable glitch filter for GPIOs used as interrupts
Date: Wed, 11 Apr 2018 00:23:19 +0200
Message-Id: <20180410212802.637537235@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399996448030110?=
X-GMAIL-MSGID: =?utf-8?q?1597399996448030110?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>


[ Upstream commit 9291c65b01d1c67ebd56644cb19317ad665c44b3 ]

On some systems, some PCB traces attached to GpioInts are routed in such
a way that they pick up enough interference to constantly (many times per
second) trigger.

Enabling glitch-filtering fixes this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/intel/pinctrl-baytrail.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -46,6 +46,9 @@
 #define BYT_TRIG_POS		BIT(25)
 #define BYT_TRIG_LVL		BIT(24)
 #define BYT_DEBOUNCE_EN		BIT(20)
+#define BYT_GLITCH_FILTER_EN	BIT(19)
+#define BYT_GLITCH_F_SLOW_CLK	BIT(17)
+#define BYT_GLITCH_F_FAST_CLK	BIT(16)
 #define BYT_PULL_STR_SHIFT	9
 #define BYT_PULL_STR_MASK	(3 << BYT_PULL_STR_SHIFT)
 #define BYT_PULL_STR_2K		(0 << BYT_PULL_STR_SHIFT)
@@ -1579,6 +1582,9 @@ static int byt_irq_type(struct irq_data
 	 */
 	value &= ~(BYT_DIRECT_IRQ_EN | BYT_TRIG_POS | BYT_TRIG_NEG |
 		   BYT_TRIG_LVL);
+	/* Enable glitch filtering */
+	value |= BYT_GLITCH_FILTER_EN | BYT_GLITCH_F_SLOW_CLK |
+		 BYT_GLITCH_F_FAST_CLK;
 
 	writel(value, reg);
 
