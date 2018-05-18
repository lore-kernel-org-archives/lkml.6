Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr/DBNxxRqGGE4wsFpvxLv1hm1K3sYE9xB7UuHEkjLrkOrA+kuuNt5+HRG3gOk1wq6XGZmf
ARC-Seal: i=1; a=rsa-sha256; t=1526631636; cv=none;
        d=google.com; s=arc-20160816;
        b=Acgpr4Oal+9pnjunihdraORIOdmH5OWc5+JwVKOtNNHIxHysPWuOlrbUU3Ewt5o3YZ
         Xc8dUNalgCAPCzR+epw74LTWjb32QlTNmePcot5HIeGlXYo+Y2kEeD6e34U6yEKzvdCq
         Oy/5npagXX3s/7F9+GlSzCS3biU6KLIKvlsCbU0rLKPFj3l0aM8sn4nDrbd8xlH7Wv8Q
         98wzmzm8Mza9JVRGC7sp63KFOTmSGFfQWb8TvEja6LEjolmAdQtjuTJddtd6391AJ2Np
         fTcmdSncipKr+WsjbgQH6D0sfPmy4X5IiiLOE/gno8QiIcRfKcd3Pw1Dd1tKnTfx0irX
         lPZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=DweJyP0V/ltHsWICkH8ls+yZB97/xZHASrLlmDiOyj4=;
        b=XpRMdVwHFvsLWCG23Up+MB085RxT58rnT12NRqQqS0Xt2ZHTIT7ekBpsyX/Q4om/3s
         L9J2WkVQuhBXdlJs0m1Ce/aFo0nWZ8qkUOE3u/7HPLU8ip0z0IRK17iP0CrS9hvQnUXP
         PTbVlyeqllTogxuVEkL0ySemOX8qXbwiRifM5xYUy2pRMfxO0jVypg5o6s+w1Va6aiu7
         V6NaSUJfx/3tbZoy5XbKo9qHT+vuqYPYu8llwOldU/UNFzrvfkKhkIZG9UqFMQi5p0sV
         zim3Je4mtQz+BA4df5WfC60y4ZbhzfkAZFxZiGu4SIU1Mx9wtA8RlkFBn7gspZ46uYXc
         o9mw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=mGMlPDf+;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=mGMlPDf+;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Slava Kardakov <ojab@ojab.ru>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 20/45] r8169: fix powering up RTL8168h
Date: Fri, 18 May 2018 10:15:37 +0200
Message-Id: <20180518081531.356360387@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789187415727149?=
X-GMAIL-MSGID: =?utf-8?q?1600789294545464820?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4886,6 +4886,9 @@ static void rtl_pll_power_down(struct rt
 static void rtl_pll_power_up(struct rtl8169_private *tp)
 {
 	rtl_generic_op(tp, tp->pll_power_ops.up);
+
+	/* give MAC/PHY some time to resume */
+	msleep(20);
 }
 
 static void rtl_init_pll_power_ops(struct rtl8169_private *tp)
