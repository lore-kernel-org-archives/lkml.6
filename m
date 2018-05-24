Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoJT96fW48JmvXxhmucXLXvUYT886C7syHwSYBe7VpG/7v85ImtsDd5B6GAZKwyz5SKN/D5
ARC-Seal: i=1; a=rsa-sha256; t=1527156270; cv=none;
        d=google.com; s=arc-20160816;
        b=J4eAMHYPqGlfnBvVk/PrTtyDZBhbhy9u+4fjsv3rP4P206+9oKnMfsB1okIsxlMLzZ
         rS7rvbwH1Yjb2Rt0DQrytFqYYp9AqP6NkIYJkvkXOZcI4LmjCQfO7tkIcDQpB6OSDLWe
         xZhyzfjpTtJYKRfrjUx+fyYHkP/zCQq72DsF+KDhIrgpgJS6vzwnF+x9nzFabWYzCLYU
         6NH6453mMhNZUNAkIrxGvwNwhicD5rWcFou3P8i94z3wzoP9psNGtijpeje58VfWe8j2
         6UwovI1Oj+0p4zAly/FD1JbXLPz9Ep0C9Gb9W8AxPxtU4owT9UptAw0buCXi4kOwKf/n
         gw6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ZJXV6cFI66zld1YvpxoTwgMS5FvcTWcU5znmCj8kWRI=;
        b=Uv87IeQ1PgM5X57ebq+Ls24S1YwKHdjbKVEcIHChBFJlscuQxzOQEUKVbOUJhMfUao
         iRkFFdn/eGI4l72iGrPcWSspgAsr9bmNg6QlC8Hvj+dtDhn1bq9dzk6C/sjd5pXazWkD
         BEHPqi+OXxyhk3DEuZho3gl+QLBSM4/VzJDR9ui0sChharXaG8tsEywBbTfmXTCpcjxS
         qt0njVHjI+YLXAro2DTLmPPKXwbCmSx9GM+50lBqj2B82kbtLE5karul94Ag9iwbccVc
         0QcbLWoxc2Xi8xhQSPWDC9dt7yi/GwzUzn7JXz+zKu9A+ES/JqaV7GRYxf/pr6EJnWV3
         np7g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=dJldi74D;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=dJldi74D;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 125/161] clk: rockchip: Prevent calculating mmc phase if clock rate is zero
Date: Thu, 24 May 2018 11:39:10 +0200
Message-Id: <20180524093033.285232799@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338506602768448?=
X-GMAIL-MSGID: =?utf-8?q?1601339413220140392?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shawn Lin <shawn.lin@rock-chips.com>

[ Upstream commit 4bf59902b50012b1dddeeaa23b217d9c4956cdda ]

The MMC sample and drv clock for rockchip platforms are derived from
the bus clock output to the MMC/SDIO card. So it should never happens
that the clk rate is zero given it should inherits the clock rate from
its parent. If something goes wrong and makes the clock rate to be zero,
the calculation would be wrong but may still make the mmc tuning process
work luckily. However it makes people harder to debug when the following
data transfer is unstable.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/rockchip/clk-mmc-phase.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

--- a/drivers/clk/rockchip/clk-mmc-phase.c
+++ b/drivers/clk/rockchip/clk-mmc-phase.c
@@ -58,6 +58,12 @@ static int rockchip_mmc_get_phase(struct
 	u16 degrees;
 	u32 delay_num = 0;
 
+	/* See the comment for rockchip_mmc_set_phase below */
+	if (!rate) {
+		pr_err("%s: invalid clk rate\n", __func__);
+		return -EINVAL;
+	}
+
 	raw_value = readl(mmc_clock->reg) >> (mmc_clock->shift);
 
 	degrees = (raw_value & ROCKCHIP_MMC_DEGREE_MASK) * 90;
@@ -84,6 +90,23 @@ static int rockchip_mmc_set_phase(struct
 	u32 raw_value;
 	u32 delay;
 
+	/*
+	 * The below calculation is based on the output clock from
+	 * MMC host to the card, which expects the phase clock inherits
+	 * the clock rate from its parent, namely the output clock
+	 * provider of MMC host. However, things may go wrong if
+	 * (1) It is orphan.
+	 * (2) It is assigned to the wrong parent.
+	 *
+	 * This check help debug the case (1), which seems to be the
+	 * most likely problem we often face and which makes it difficult
+	 * for people to debug unstable mmc tuning results.
+	 */
+	if (!rate) {
+		pr_err("%s: invalid clk rate\n", __func__);
+		return -EINVAL;
+	}
+
 	nineties = degrees / 90;
 	remainder = (degrees % 90);
 
