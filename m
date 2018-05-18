Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqF/Wrxjs9456bzg81ULTII+8kiAga+NKwctaGxl+GJe9NIh5jwCb8gsdZ2kaC2F3Adsf2o
ARC-Seal: i=1; a=rsa-sha256; t=1526631693; cv=none;
        d=google.com; s=arc-20160816;
        b=H74DiBQ4cL6/Tm40PurEjgGfy/VEclEmBZJk5RQ74rTfABt3IfnvZ8F0rDwh3C+Lv3
         CbqI9Rb0sUzNMLMaREh1w0sJUT//I2+Juo1pTHksFsa8cWusw/AAzXMWMm4W5zx6dZx/
         Idthi9zO7xUXsYZGpSCrgeBGSOIM4+X72EchmJQZkPrgxDWLi/PlCCNZukib2NRnJCxj
         JrFmkmR+gszRgTuydvDjHQHKpLvw6SKBkOai/iI6ukS3JHuD4b/n77eGwRLGywhyouxV
         Joyn+PnsBKyPY99NLmf6hGTHa08P/Gfqu5BpVVEjN1USRHU71qKDex1koOLBs5aAd9y+
         c1gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=TV9RFeGad/LEQGCX8lc7PxUkIl7y7khCeELk0MSXQP0=;
        b=B3DJ3hNib9HAPa62jUplCDDMxWSxSge2+Pl2mkHHXy1HMFo5Q6mCOhthNu0bbHRZk2
         Kwe9IZ7syvcHDQ4gk1Siikz18tSadpnbO+ezi6KJLF8AIovR+bntUOwnC4Py4B6LczGC
         n7RXWgiPv2KMxDAQ1rprdYibfbrzlTacAS7Ff18edZEMR1tkcOezqFldkA6tB7w8HiB6
         PqkGqd0F6C7WiWJf41EIZXSJJEE1r3SR7iUDRLFwzNK4iif6rwtvTOpa8yz30yHHNfT7
         8XW3G6RvmdB+YWns5vCHjFzFIpLQ8C/x9GPHKQe4yZrrUo16EWsmSbw/4LsT5n3Mht31
         Bdxg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=a9ByyGXd;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=a9ByyGXd;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Slava Kardakov <ojab@ojab.ru>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 14/33] r8169: fix powering up RTL8168h
Date: Fri, 18 May 2018 10:15:53 +0200
Message-Id: <20180518081535.668741058@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081535.096308218@linuxfoundation.org>
References: <20180518081535.096308218@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789187415727149?=
X-GMAIL-MSGID: =?utf-8?q?1600789355152121511?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4861,6 +4861,9 @@ static void rtl_pll_power_down(struct rt
 static void rtl_pll_power_up(struct rtl8169_private *tp)
 {
 	rtl_generic_op(tp, tp->pll_power_ops.up);
+
+	/* give MAC/PHY some time to resume */
+	msleep(20);
 }
 
 static void rtl_init_pll_power_ops(struct rtl8169_private *tp)
