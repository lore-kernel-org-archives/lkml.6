Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/uF3LIhfvswE8gl7sZmqsfX7RrRAjl7BtWWDJPiLVzLc61Vq1bf9PoTODoep55zTUaRApq
ARC-Seal: i=1; a=rsa-sha256; t=1523473239; cv=none;
        d=google.com; s=arc-20160816;
        b=X4M9HJrH+LsS4jaR6qwHo3pfsjvaj39YE5SAH90DAkOkYs4wm7+fQ6vELhFzPSupjo
         BQ+5/G8Zm4SPEPDzu+St1IOOS7elDfHS4pJQIb5z/laFUiPPb5tqR4cxl056XnXn5ptU
         Mxa5x3dJn/BOfNwbM4ScYeJDCRmWx0H75jWiu74lkCoPk3vFfVAOSrFv4m0ZC7WjZgZ1
         8fsH/412k3+Ing5ltOGuLYp+hZ5UL2C20ITJLNq4mfjnhtjANIk3QlCYvLhIe8x9bN67
         +toxEZgzigx5Pb2uP9jpWh8NQ7ITPMETsYvF2cfGX726BDn4sIvj3JTOpcdUhDlXp844
         20bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+rXPQiRxA7nHQ3z2NBN629+bz7lqm2gp8RM1jM4YkTk=;
        b=hbTyuP5D4liBN0k5kj94nO0lVTMjkka5nnTTZpXJmEQyzEIAOaV3vhumDDi8WZZjCW
         ixg4mQPUnvXRi4e/edeapFyKEtJ7Lhzq4J8SQoy5UmBpZkO7QjyDcBVTn1yCm5GxgKlG
         4BkP1O8cKXl8o1G/12dlq3dbLTYcyEQtH3zU2VVHSNKoYBBfCV+T8na7qsVYZXpZ5QKB
         GKtwblvvrJpV0hpJXiDC2kbD4flK9xl1r5SPkc/4yM0z0Al6wT9ICyMJMr27lgistcH+
         k66BLGdJaldRma8YWege++Tc75Aqs4JkxNeqIXRYnk4iqdqawq0IbZc/BE/i/wDh3v6c
         112w==
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
Subject: [PATCH 4.9 144/310] pinctrl: baytrail: Enable glitch filter for GPIOs used as interrupts
Date: Wed, 11 Apr 2018 20:34:43 +0200
Message-Id: <20180411183628.637960764@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477475657950152?=
X-GMAIL-MSGID: =?utf-8?q?1597477475657950152?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 
