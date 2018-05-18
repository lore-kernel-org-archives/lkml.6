Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpWmWo85jr6w7gPujaX30MeWGbeXu3Of/IVtFMVs4q6Su6b/UInee9bUh5+1IE6Lb0Kvh/R
ARC-Seal: i=1; a=rsa-sha256; t=1526631534; cv=none;
        d=google.com; s=arc-20160816;
        b=DpZlCr/logZPR5t600qBwZO/yLVjhkiHkram2sNqmZHCyDyOwstXSLYbVxG6w8V8Fh
         n8zU0B/SE+S6Yn7V7eB8RE3Sm44zTZwYNLMdcrG2g+FuPKSSY8KYK/5XpB8hYHZ1lMsU
         OLSDRBqi4kLVvf3itBhmN7WM0vTiOIV4wIghwvCTuyg2/S3UNkxCldeWla7fhnw08dUt
         LicgXG239JrtZkwqHJobfmpahDsLn9GnM4HrmkJKoPVRcR7o/7o0Q9nOVNS/UwYmGADa
         VeB/x+JAIp2RjpWt9uVaotORyBuyxM860CYV4OcZn0OZ1Wopovfioe6iUzakWRMWQfZ3
         hnqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=DJH0KmN4g3pmPQjqwii382LIAuO53zbsm4OJezsBGKY=;
        b=NMo7vlcQ+Zfn+UTr8hqDalLd/IGDevOHCIorTIDC20KQLt9y+uqOhYzFpIFzlOJ/2D
         dW/bgU2uzswJQwUpD920mpVLRhDRUIHJP+D7QvTguxFUO4xPuI2V1klyWKZvxTo0UBJy
         u7WsLvgl2gIOtjQensx6EhIf4YoW04F8oprlM0CUdknycZHkhWB05WkFrPnCS0xh8vlc
         V/Xeq14yNi74tkJgeYU7fpezXcpGBp70o3aO2b7VpROv62kbbX2yhhUUElfTpsvBihEu
         stkNcOiF3tda/h8ScbzPO6VOZRfbPdYr2YpgXE5W5AJEepTgIn6gWt4U7l60zyqeS9bL
         r7/g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Aogh2utU;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Aogh2utU;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Slava Kardakov <ojab@ojab.ru>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 21/55] r8169: fix powering up RTL8168h
Date: Fri, 18 May 2018 10:15:17 +0200
Message-Id: <20180518081458.469033641@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789187415727149?=
X-GMAIL-MSGID: =?utf-8?q?1600789187415727149?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 3148dedfe79e422f448a10250d3e2cdf8b7ee617 ]

Since commit a92a08499b1f "r8169: improve runtime pm in general and
suspend unused ports" interfaces w/o link are runtime-suspended after
10s. On systems where drivers take longer to load this can lead to the
situation that the interface is runtime-suspended already when it's
initially brought up.
This shouldn't be a problem because rtl_open() resumes MAC/PHY.
However with at least one chip version the interface doesn't properly
come up, as reported here:
https://bugzilla.kernel.org/show_bug.cgi?id=199549

The vendor driver uses a delay to give certain chip versions some
time to resume before starting the PHY configuration. So let's do
the same. I don't know which chip versions may be affected,
therefore apply this delay always.

This patch was reported to fix the issue for RTL8168h.
I was able to reproduce the issue on an Asus H310I-Plus which also
uses a RTL8168h. Also in my case the patch fixed the issue.

Reported-by: Slava Kardakov <ojab@ojab.ru>
Tested-by: Slava Kardakov <ojab@ojab.ru>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -5087,6 +5087,9 @@ static void rtl_pll_power_down(struct rt
 static void rtl_pll_power_up(struct rtl8169_private *tp)
 {
 	rtl_generic_op(tp, tp->pll_power_ops.up);
+
+	/* give MAC/PHY some time to resume */
+	msleep(20);
 }
 
 static void rtl_init_pll_power_ops(struct rtl8169_private *tp)
