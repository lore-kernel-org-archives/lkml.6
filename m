Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt8x5hosx77PM9fhdnhEDU3J1ubSCmL07ahh+krj++rk9UO91VuCB6vrLALEEkxDZQNdlEe
ARC-Seal: i=1; a=rsa-sha256; t=1521214583; cv=none;
        d=google.com; s=arc-20160816;
        b=qhmyEXl/d7hz17b5FNJJk2QshR9Ifcrvg2TaZBjjawP5KxMI4KDuYntoghIBGzWHSo
         QhkAhVHFndFmXBuwR6TceuJHNmdfnzMmYggiJFbg4IITfFdp6JVHv183AFDW5uQMh4zu
         yjvHrI7W0pRQ8ZMwdY5JChdB/8lASq707JcxYzBmIqsNPXZWE9ZM4UhHWOJMLvyf9Dgh
         k17f/1XtYXO3ED40k67sOUG7BJOIHBq6hTateVCCtteVGkPmsyhertfVyZOWtsmSxTUP
         RvolVn5fjF/YJtrMId5yXVK3SWQkaa2TcJQliF1YKKXDpyZlBZOXp5+UkkxHzgN4Mh7c
         TTrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BjzqdbS3zTMHGvcn/Kigzy/lUUSAkXQhVB/PAZ4Z3RA=;
        b=AzqbGF/0jB8NxmU4mneuAUqWr6f9hk4IuUufWUGWVWvgtkoK8PSOGCKIpn+HG1BGgz
         IFw8uSkXmnlBO8mRoLrH4MYaO7+rZpsEEwpcVygjE7JDD+Qo891vPq8S/xY3CNLq6wSD
         3RHub7n3+IBULvZwEqX3W9+JgAbl3HMB7ncpisGC5++zAKZWns+ME5d30SSz/wbzpS85
         uiAZ0ofR8UrhlhmbTgEQBJtyMmJq+fpT8w5baa96edCJpq2Q0Q/8/xq10ZV+MZ06OvRv
         6yJcr3e0VtKn0AmN0sJJhARAxdHATtjAFXkT+RmdmB0z/fZp5u102PNPze9kYEuPSQfr
         q4iQ==
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
Subject: [PATCH 4.14 056/109] clk: ti: clkctrl: add support for retrying failed init
Date: Fri, 16 Mar 2018 16:23:25 +0100
Message-Id: <20180316152333.001660820@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109102409915493?=
X-GMAIL-MSGID: =?utf-8?q?1595109102409915493?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
