Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49MZggagcDX4yHIO9U2WBVST3YrWRYVtEbDJSYTbkA2mdgODxgZHBfo6TrTYb3XMpDdi8Ro
ARC-Seal: i=1; a=rsa-sha256; t=1523021864; cv=none;
        d=google.com; s=arc-20160816;
        b=gzms0yFCty6heCRvW8z8+QyQp3UH+xaKQak5+MWh6RcgaMCvBVsSUcLrWOfvCUQB61
         UzoPpoMNRONd7cUw2SctskTvzrqXBOhz8hOEEqw1ZBF6LOfkFhxZjejjDlLbf3pOxaur
         1lcl1iCcl9AQLTsXsPmW1/YNmHaA3Ydq2aEyK46G+ebdCxp71NK976Ib4tgYHCo76zu0
         x+3PC7e10vpR3zs7m7Xw1ednYAvdp/feawQSL2snFwBLME75Z5yec6wl9Y+76LacTXqy
         z0g3FKc0tdDUaAd7CHKqQMi7nIzPZVmiGK1MuLvmnvd+w9cHbj10UC5UNwwuRLwVkHJ+
         eEMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=joMytKz1UVEL9vfejkeFCSU+pWbR5OXcLCnax47YIX0=;
        b=RIQ0uSKPVMDpyAPzCan/FSNKTnw0NnbhZ+BZx/gCcp5czFVNRuflOurF/tjqSbkwYP
         14p6RjBQAhrD+HhK6cN9x8CRlqM2itVOPy41oPkCVi9zl04YhXBYEyggVHBmQUzYjbNB
         1L9qt4LkO13YSFWcKJ75T6K9Gzr5tLcQ7qwnfEiwcBGjP9oLpadeYXM6uKuFDOIb5cpr
         6Go+Y3kTqGFtM+oX2gs79hmSmKfEk1fCDmfNSzOoE7Xu2URpnAeiiziPQc5KXwZmdt9Q
         yAl7ilkqi0DmyhuEz5NC0jTjy7PFphDyWXg+r9T5l+COYq148FwHGBDD8z5TbE5s+4mh
         I2ag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
	Alexandre TORGUE <alexandre.torgue@st.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	stable@kernel.org
Subject: [PATCH 4.14 14/67] i2c: i2c-stm32f7: fix no check on returned setup
Date: Fri,  6 Apr 2018 15:23:44 +0200
Message-Id: <20180406084343.175222182@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004174064141518?=
X-GMAIL-MSGID: =?utf-8?q?1597004174064141518?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

commit 771b7bf05339081019d22452ebcab6929372e13e upstream.

Before assigning returned setup structure check if not null

Fixes: 463a9215f3ca7600b5ff ("i2c: stm32f7: fix setup structure")
Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-stm32f7.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -887,6 +887,11 @@ static int stm32f7_i2c_probe(struct plat
 	}
 
 	setup = of_device_get_match_data(&pdev->dev);
+	if (!setup) {
+		dev_err(&pdev->dev, "Can't get device data\n");
+		ret = -ENODEV;
+		goto clk_free;
+	}
 	i2c_dev->setup = *setup;
 
 	ret = device_property_read_u32(i2c_dev->dev, "i2c-scl-rising-time-ns",
