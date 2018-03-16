Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuc2L4qu5RhcVcPUfjn8jbyWF8CeivT4v/DNAYT5Lx6cawmannsnndj4ioDdt8TRxcXsH4q
ARC-Seal: i=1; a=rsa-sha256; t=1521214934; cv=none;
        d=google.com; s=arc-20160816;
        b=YqEMSEWyJeqbBWk2Pt4nedXxZzEO26xiCESKuF5vnNHnStGV5PxitM8RwAAVhoVX3J
         aIsUJy2T4bGt17hHxhxZwhtq4FC0VEibt7EHkJ7XvWmdO7WKv+o8Bpz6WShFNV77Cv1k
         5We8d//X7rJVg9R4tZvwSyGp7bre7Bkdzl0qSPUdEL9FynU+PKt/qh8Vb421ZAG370hH
         bS2csGTUxhP504KNJIcdeh8Idjr3BJy5Qgnpfe39zPWAuyLCrYmt/RRsUQwnOwWTqGNu
         ulvTJVOYhgKHQMU4DLbh18bCA2iGw5DqWMEvxbj3fM7GV5Y70Oua0cvRKN5aC7mMkB+P
         049A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Qh65zUzyRwEPT3NyHlasc+WXq6pf84g2sRV+NxottA0=;
        b=USIFuRYBaDR6iXICmrLhUGF6KOGWVvDaquGzsMMedaBOvi19eXUx63HT+KD2U56qoa
         mU9klxP/SnZMNLuSuwBDnixjmtLDEthwoPQTAPAyvvEAhnZeq/3pmjj3JC/fKtdvhuHr
         1NlYO2LBSPDiNf7Dl5v+089xYdFEma0kQKCR/p40dT91tWo+Q9cR+lxlbyNb73KLriwB
         3k96PMbhWbD97jAWNkemnHSf6mSPbZERJaZiRfp0o0P36KokQULymrebKuYk66bsEX5I
         Edf+vUp7GweZjY3rQKPL2Ce/m/EdBLhKA71rQmG7ltXxB6h5lAaHUv7oAq0ghXtDlGFC
         DoLA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tero Kristo <t-kristo@ti.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 068/128] clk: ti: clkctrl: add support for retrying failed init
Date: Fri, 16 Mar 2018 16:23:29 +0100
Message-Id: <20180316152340.124065634@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109102409915493?=
X-GMAIL-MSGID: =?utf-8?q?1595109471460140879?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tero Kristo <t-kristo@ti.com>


[ Upstream commit 729e13bf58e643b9accd2a14c55b555958702fb0 ]

In case the clkctrl node contains assigned-clock-* entries, registering
the provider can fail with -EPROBE_DEFER. In this case, add the
provider to the retry_init clock list so it will be cleaned up later.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/ti/clkctrl.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -400,6 +400,12 @@ _ti_clkctrl_setup_subclks(struct omap_cl
 	}
 }
 
+static void __init _clkctrl_add_provider(void *data,
+					 struct device_node *np)
+{
+	of_clk_add_hw_provider(np, _ti_omap4_clkctrl_xlate, data);
+}
+
 static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
 {
 	struct omap_clkctrl_provider *provider;
@@ -411,6 +417,7 @@ static void __init _ti_omap4_clkctrl_set
 	struct omap_clkctrl_clk *clkctrl_clk;
 	const __be32 *addrp;
 	u32 addr;
+	int ret;
 
 	addrp = of_get_address(node, 0, NULL, NULL);
 	addr = (u32)of_translate_address(node, addrp);
@@ -485,7 +492,10 @@ static void __init _ti_omap4_clkctrl_set
 		reg_data++;
 	}
 
-	of_clk_add_hw_provider(node, _ti_omap4_clkctrl_xlate, provider);
+	ret = of_clk_add_hw_provider(node, _ti_omap4_clkctrl_xlate, provider);
+	if (ret == -EPROBE_DEFER)
+		ti_clk_retry_init(node, provider, _clkctrl_add_provider);
+
 	return;
 
 cleanup:
