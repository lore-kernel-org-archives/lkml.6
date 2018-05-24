Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo4JP++gjSR9ToHI40Izpy4E1z9P2KF43xqPcNd1wp9vm1ImzVabLXZgMVg1upPn2H4J2nZ
ARC-Seal: i=1; a=rsa-sha256; t=1527155672; cv=none;
        d=google.com; s=arc-20160816;
        b=OMH5i4xOD5PHCclEv+YG6Kzcdwt+alh1H7AjTWyvTdYnvTvHPBlVZqvnpKmEz9CBA9
         zjdN/t4Yhac+PP5bgZa5AP7TCk6i3y8m6uPrMwGaeqCogKVJA+fZTjv8gw9aNsFePZ3V
         EoPd8PSQsS/qKH9kagoTNjmWtNcjzL9Oy1deUnipCeHTf9+EJSXaj7+rL4j8jFYsJC56
         Hv+aoTysmLPLDK/Q1qphm12Oqwv3erbXubtMYS7CtPwSriWnsqLUfLoozqPRxBoyYKoQ
         /VnnnhxYoGwEgHd74ZpDPmp0QqnT2ppn/4UuRIULMZdJpqYZciN5xtEnX2/xPr8ZyErv
         /gtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=fe1B6IV+0BHhMC1aOYZL46mO23ugesSZdugOHtHs1e8=;
        b=rlV9eVXnnKO7n7Iw0Q0dyJwNOjDI9ItcRNLutlYnuDeyE/LgMDLaJYJr5O1tS7ytyC
         ufI5ic583HUWhjgA+PWygNzO4J0ofZi5QVmp+eNVFC5Ri6Vv3qhx+XjTGiOfcZ3fCtZw
         /VXRkIWya18aPwuGtgPZttuPhTF57B5YuVtQCLkCXCig011WtHWFxfJ7nwmY1UitKUDm
         MC+N1OjVE7q0a905qQnjRvCWMpL/ZI7YoNL+fA96dr3Ws0beNuRcu0AjAp48ppzLJ4Ci
         Pfo2i/5xLJuq8jYxYnKRlrqbYOQLElOk/1xb/Skr3oUGRg+tjw1il0dZQen3Jf9nuYHo
         7ueQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=EzqdgrdW;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=EzqdgrdW;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Grigor Tovmasyan <tovmasya@synopsys.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 073/165] usb: dwc2: Fix interval type issue
Date: Thu, 24 May 2018 11:37:59 +0200
Message-Id: <20180524093624.969066759@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338403036137519?=
X-GMAIL-MSGID: =?utf-8?q?1601338786187179259?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Grigor Tovmasyan <Grigor.Tovmasyan@synopsys.com>

[ Upstream commit 12814a3f8f9b247531d7863170cc82b3fe4218fd ]

The maximum value that unsigned char can hold is 255, meanwhile
the maximum value of interval is  2^(bIntervalMax-1)=2^15.

Signed-off-by: Grigor Tovmasyan <tovmasya@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc2/core.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -216,7 +216,7 @@ struct dwc2_hsotg_ep {
 	unsigned char           dir_in;
 	unsigned char           index;
 	unsigned char           mc;
-	unsigned char           interval;
+	u16                     interval;
 
 	unsigned int            halted:1;
 	unsigned int            periodic:1;
