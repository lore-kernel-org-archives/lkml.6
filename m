Return-Path: <kernel-hardening-return-12798-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48fVf/be2hZPmAyRBEfj/ex6Me0SvGKeF2QuLGM0X0CwUz9wdUbbsl5CvciTxnP3iLfJORO
ARC-Seal: i=1; a=rsa-sha256; t=1522260036; cv=none;
        d=google.com; s=arc-20160816;
        b=voUk35ydhZHRXjDQ7wzWZ9rtDXqamBHJK4BnTQcespf518LnU670IWbtU4yMzeQryl
         iz4fR+zVgYOiG2Kb4dJKM8+oqtAb3NGtJyFPtTtldz2AiAjzKj76VNIi5d6/zeoAZg+o
         d+DH2qrIC6x5P4v8k0S4wIFRI/P/UIPTBKrVYhkcbC+vgBIycl2GJ+gsAN+wKzDPyu5B
         hFfIExdTI/epnMlHc3U2KdkBDYrNjCV1knHxcH41RTQBuKwOWs3LtMbjmIqjfdgiO+Yz
         qOe4agPi7CP0U78/VoBnpq4cOIEIDZM/1aFvtu1V+zRM2WNSFszIMWz8l2y/dkreeOn0
         mueA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=NHdieeeSjaiY6HtBJW1vciGM6wbi5+/JgzJYPQWlW60=;
        b=S+0O1Kr/Td33+iIuNWlNWLf2HrjDw1Se71EMVe0Lp2JnHFrJ5oGA1GVsaaE1dm67W9
         4TqspLWXKwiobz0jsfUd2LYHtvh90AGMM7trpRtE5azm2REWvogu7kioHU38/XWa0Cz0
         zi38goU8Q2VqfxW+B9yEZEJr7FiO/AJCCQdVQ1NODxbvNMVUl7sxGJlFk+SLcGgTJqUr
         Alf9ntMbgBySJ/S7PoxNh18Bw76IPprzbwmBfJZ26Y778OeFzSpKLnfrK52SBaLh6PO6
         H/eLea8m5y66aOVX54Etl0lEE+MMFqX17CuD9kwusxRLMTNp/0/BeXyW/mJNDmFSFigk
         iQ1A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12798-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12798-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12798-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12798-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Laura Abbott <labbott@redhat.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Patrice Chotard <patrice.chotard@st.com>
Cc: Laura Abbott <labbott@redhat.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: [PATCH v3] gpio: Remove VLA from stmpe driver
Date: Wed, 28 Mar 2018 10:59:57 -0700
Message-Id: <20180328175957.23904-1-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596205340288651646?=
X-GMAIL-MSGID: =?utf-8?q?1596205340288651646?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The new challenge is to remove VLAs from the kernel
(see https://lkml.org/lkml/2018/3/7/621)

The number of GPIOs on the supported chips is fairly small
so stack allocate to a known upper bound and spit out a warning
if any new chips have more gpios.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: Split this off from the rest of the series since some of the
patches had been picked up. Switched to just hardcoding an upper
bound for the stack array since it's only a few extra bytes
of stack space.
---
 drivers/gpio/gpio-stmpe.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c
index f8d7d1cd8488..8d6a5a7e612d 100644
--- a/drivers/gpio/gpio-stmpe.c
+++ b/drivers/gpio/gpio-stmpe.c
@@ -363,13 +363,15 @@ static struct irq_chip stmpe_gpio_irq_chip = {
 	.irq_set_type		= stmpe_gpio_irq_set_type,
 };
 
+#define MAX_GPIOS 24
+
 static irqreturn_t stmpe_gpio_irq(int irq, void *dev)
 {
 	struct stmpe_gpio *stmpe_gpio = dev;
 	struct stmpe *stmpe = stmpe_gpio->stmpe;
 	u8 statmsbreg;
 	int num_banks = DIV_ROUND_UP(stmpe->num_gpios, 8);
-	u8 status[num_banks];
+	u8 status[DIV_ROUND_UP(MAX_GPIOS, 8)];
 	int ret;
 	int i;
 
@@ -434,6 +436,11 @@ static int stmpe_gpio_probe(struct platform_device *pdev)
 	struct stmpe_gpio *stmpe_gpio;
 	int ret, irq;
 
+	if (stmpe->num_gpios > MAX_GPIOS) {
+		dev_err(&pdev->dev, "Need to increase maximum GPIO number\n");
+		return -EINVAL;
+	}
+
 	stmpe_gpio = kzalloc(sizeof(*stmpe_gpio), GFP_KERNEL);
 	if (!stmpe_gpio)
 		return -ENOMEM;
-- 
2.14.3
