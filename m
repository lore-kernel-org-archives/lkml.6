Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrgItjC93D60ossq5WlcMFWZgm9dsFZsK55IUmOglTNj0UgojxzeIbl0TYthOytgTF/NYme
ARC-Seal: i=1; a=rsa-sha256; t=1526281136; cv=none;
        d=google.com; s=arc-20160816;
        b=QnhhQ8+LMHjOOmzRuic2uPcWUDLdszAm6oajVE4vlBBWhD04/o2nm8p9j4k3SjzA9d
         Dj567f4cAaIj7KZPeCgcEV14kITirY10g/v7NqitItu671PVNRRqgDXWwXvkYEjXyIqg
         ik4ixRiAZOkJS3Ruh2+WRyu4SW7RuvA4UCxEkodnb9KoAsMN5GceofTbeWHH66SAFZv5
         l0P2KdS2jS2ZrwnMQQHvhx/PxIp5uSXdX1YcAZ+RIkyhnUjiSVKUGdrcHn1DDyEckPwa
         rtXQYjJB+7F0bRSriFU6YbPVQOwXvdL/k5roFtudBjgynoGG2ZKs/JOps1OUnKV5eM44
         aDgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=8LQ1adNbsFDwTHeUYht1oewRgfB6ujfoj79NmxHiDfU=;
        b=XzGV4iPjliWvA+2sr6WYCBxOvtlWyOUEXtbKR3WoWwtAEGkIH6vsoeL/fxigaRb4Ut
         elZUsVBND9E+ckgaKqUa6HYDsdy34lwQIEsBMgtfVv1UreP8K0yBUOjukEppurfb94H/
         b0vYso6IZ9O8NNVYgCftoRcHQAJ9s4V6wasn2ZX63ytHpckggV5CT2Y6sMlHwy8KziOy
         Pkx6HGqkG9OvzzMO7ejeFW2CJUdJCmAhyx4kYb1K0cS4Rhkb/5f7kP7DXJIRhVz18BrK
         +hAyR0Mx9WIDN7kJRbtlq5PLCVMX2n2GLNc0NE0j43gqUFbiYpRcXyyYtgjG1YeER6hu
         FvGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=eAMWp2aj;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=eAMWp2aj;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tero Kristo <t-kristo@ti.com>,
	Christophe Lyon <christophe.lyon@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH 4.16 03/72] clk: ti: fix flag space conflict with clkctrl clocks
Date: Mon, 14 May 2018 08:48:20 +0200
Message-Id: <20180514064823.181891833@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421768900399456?=
X-GMAIL-MSGID: =?utf-8?q?1600421768900399456?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tero Kristo <t-kristo@ti.com>

commit 269bd202bc0fd04e841cb123867fd3f49e04ace9 upstream.

The introduction of support for CLK_SET_RATE_PARENT flag for clkctrl
clocks used a generic clock flag, which causes a conflict with the
rest of the clkctrl flags, namely the NO_IDLEST flag. This can cause
boot failures on certain platforms where this flag is introduced, by
omitting the wait for the clockctrl module to be fully enabled before
proceeding with rest of the code.

Fix this by moving all the clkctrl specific flags to their own bit-range.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Fixes: 49159a9dc3da ("clk: ti: add support for CLK_SET_RATE_PARENT flag")
Reported-by: Christophe Lyon <christophe.lyon@linaro.org>
Tested-by: Tony Lindgren <tony@atomide.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/ti/clock.h |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -74,6 +74,11 @@ enum {
 #define CLKF_CORE			(1 << 9)
 #define CLKF_J_TYPE			(1 << 10)
 
+/* CLKCTRL flags */
+#define CLKF_SW_SUP			BIT(5)
+#define CLKF_HW_SUP			BIT(6)
+#define CLKF_NO_IDLEST			BIT(7)
+
 #define CLK(dev, con, ck)		\
 	{				\
 		.lk = {			\
@@ -183,10 +188,6 @@ extern const struct omap_clkctrl_data am
 extern const struct omap_clkctrl_data dm814_clkctrl_data[];
 extern const struct omap_clkctrl_data dm816_clkctrl_data[];
 
-#define CLKF_SW_SUP	BIT(0)
-#define CLKF_HW_SUP	BIT(1)
-#define CLKF_NO_IDLEST	BIT(2)
-
 typedef void (*ti_of_clk_init_cb_t)(void *, struct device_node *);
 
 struct clk *ti_clk_register(struct device *dev, struct clk_hw *hw,
