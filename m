Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrwnUTjpDnyF6av1CJCk7vBuiT2OiA7ouvEN+QpI87LMtKklHDuZLkdDgeDabtWx82fZJZq
ARC-Seal: i=1; a=rsa-sha256; t=1527156345; cv=none;
        d=google.com; s=arc-20160816;
        b=eCWt4u3m1Ou9DqvprhWdYJE+kEoxaP5hClkVC75yxE1qWN22e+0f6FInTOboj9OTS/
         qkRwbYGV9hXgzKU3c6GnaOhWzH5FT62wijExjOF+zmst8W8L4IybCudKrWX1+0TZiqIZ
         HGLRkLZEzPS4CVFpWcHWomWQB4e44XF19p6nVtM1k6LBtODtlCBRAfifIFa498WY2Voa
         Cur4X/kBU034BCrfDsiTL4SgByTs/37n9atWLZ5+rwZjJOj8D+xpDKaHj/pdzg2iWoYV
         8DiK+f5SS3oW7xSfohUiWOtqaSmrcwvWSblZuCoxfrJOfI+qX6Q1jbpoYoqg33s6oXzY
         1DCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=0BV3oyOIl1N8+4XsGuzcDWeOkJ5GAKtzxS46InID/sM=;
        b=j3F0Cg+AOMsH+CEHlH86kxWlRAjlCY51/I4SCDFJwo30EdNQzCV8fEzceFyHEjJk0W
         riTh0dXj2CAON5mBY+rwcnkAweYbxx5Ptd1+dqQR8qHBu1HZWh/aS6Jvjn4ztNLxhrH1
         Gi1UU2drGg/2+LdStzklRc22BIeYqmDwVSOrrzsiXfFPMP8kLSly3h9961c29UJPFSkg
         rEQoRMlBjcRRJxvgO0jWil9f5TCk3SKTwbRYPM6L+Av0n10BKeEFJ1j4+KTYQYjL22Tk
         A34EDNLL+znHCwVIGXqydSVF0pMxTFqjLLnIth8dpO3c6vhi/4iNgb/Q1y7OPvGhDZta
         gSJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=nuF/NuJR;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=nuF/NuJR;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Brad Love <brad@nextdimension.cc>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 136/161] media: cx23885: Set subdev host data to clk_freq pointer
Date: Thu, 24 May 2018 11:39:21 +0200
Message-Id: <20180524093034.662367601@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338503075069796?=
X-GMAIL-MSGID: =?utf-8?q?1601339492613666352?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brad Love <brad@nextdimension.cc>

[ Upstream commit 5ceade1d97fc6687e050c44c257382c192f56276 ]

Currently clk_freq is ignored entirely, because the cx235840 driver
configures the xtal at the chip defaults. This is an issue if a
board is produced with a non-default frequency crystal. If clk_freq
is not zero the cx25840 will attempt to use the setting provided,
or fall back to defaults otherwise.

Signed-off-by: Brad Love <brad@nextdimension.cc>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/pci/cx23885/cx23885-cards.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/media/pci/cx23885/cx23885-cards.c
+++ b/drivers/media/pci/cx23885/cx23885-cards.c
@@ -2286,6 +2286,10 @@ void cx23885_card_setup(struct cx23885_d
 				&dev->i2c_bus[2].i2c_adap,
 				"cx25840", 0x88 >> 1, NULL);
 		if (dev->sd_cx25840) {
+			/* set host data for clk_freq configuration */
+			v4l2_set_subdev_hostdata(dev->sd_cx25840,
+						&dev->clk_freq);
+
 			dev->sd_cx25840->grp_id = CX23885_HW_AV_CORE;
 			v4l2_subdev_call(dev->sd_cx25840, core, load_fw);
 		}
