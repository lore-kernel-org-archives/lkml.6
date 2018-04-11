Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/RZXBdg0FRfd7jFMow2Al0ykZMfy0uhNskboGzmcFbz8L1Q4LARWIbz5pKqjjE5MtcXAx2
ARC-Seal: i=1; a=rsa-sha256; t=1523473354; cv=none;
        d=google.com; s=arc-20160816;
        b=pC0DzrknlEzNsnQyaSsGBkHg72QFYdZ1Rzl93FABYvS4gwHacpuCzFfHuc6Qt+L0Dl
         m5iD4ShvmImVtHBCciomjp7C40XVLq2/8k3GjVnJm4/Hg3/bVCjwHIc5Pk+pihll/pEj
         CmUUO7EQOXcHf2rlfMiXExLVJg03M+rUPy7XSzjylvG6aqn6fl5wLyqTEDOZx76m2h4r
         lHwkNJZ/yMA+iyH4aPiYSnVyjIQ6Yp9Tjq4rfkSnANU2FGMknQMnYYcDHLU2j1t22VFE
         +YelJM2jv/stE1dhEqM+bZbt/Od7VFRWQsW3IPPe3E79+1uCwHmUXwlJTpjMCHD65ISZ
         cNhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AqOvUD777U90TECoOTLeA081K6o9iatqI5gcTocQHac=;
        b=bi94pXRKkjlGcc+lqlHjadNket9Sy/gopzkjjblZ2+gZYPLbr4VGiyAOUIK7L/LC+D
         Yy36KuWp7Vxaf+L3xdS1c2cLDr/zY2/8XvxVZmqYnJ8IHOQBD3gXf5JQQ+zuJUVx+T0y
         Hmb7Bj2WGTg47dQW1ktGwxL25zD3ATLZxsgSBH3nZkLL1ToEgA+bYvr4ZZ3eABIIDab8
         yZ9RWZ1MpT8luGKpm9UAbPSg4ZMf6Rf4hgtjphQ03kIwK1vvCNhbAFViTFceVnzW8XmS
         NtfJX4zAVmVVi3EXbcjBfWobqNzVDCVEkNyqj6zDwMLCjzlb9QP/PkXaBkHBXCZQiZhK
         dY6w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bryan ODonoghue <pure.logic@nexus-software.ie>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 173/310] clk: Fix __set_clk_rates error print-string
Date: Wed, 11 Apr 2018 20:35:12 +0200
Message-Id: <20180411183630.073353150@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476691990597069?=
X-GMAIL-MSGID: =?utf-8?q?1597477596021818135?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bryan O'Donoghue <pure.logic@nexus-software.ie>


[ Upstream commit ee177c5d6369f8e5d3e4793dce501cf4431313a1 ]

When failing to set a clock the printout emitted is incorrect.
"u32 rate" is formatted as %d and should be %u whereas "unsigned long
clk_set_rate()" is formatted as %ld and should be %lu as per
Documentation/printk-formats.txt.

Fixes: 2885c3b2a3da ("clk: Show correct information when fail to set clock rate")
Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/clk-conf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/clk-conf.c
+++ b/drivers/clk/clk-conf.c
@@ -106,7 +106,7 @@ static int __set_clk_rates(struct device
 
 			rc = clk_set_rate(clk, rate);
 			if (rc < 0)
-				pr_err("clk: couldn't set %s clk rate to %d (%d), current rate: %ld\n",
+				pr_err("clk: couldn't set %s clk rate to %u (%d), current rate: %lu\n",
 				       __clk_get_name(clk), rate, rc,
 				       clk_get_rate(clk));
 			clk_put(clk);
