Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225B/2y1DJGa3GFWvHYOIQ4Hzvy/LK0IMVfGiqoyLlIlvceGsUoY2XAsKMO3Tj2fsgYTSQ29
ARC-Seal: i=1; a=rsa-sha256; t=1518707990; cv=none;
        d=google.com; s=arc-20160816;
        b=QEkzwQBsl7ecJjJHwI9bq1cjtq1cwMtvZlzF9ikBgXMvGJjF9bPJwBWpqTdil5tRDS
         dJid2TcVDLCkpKKLv+2WzxIVomS2Vw1y0d0ZO7EX6RCe3j8LG6sNzXbVztofnVR04fLU
         Mt1YyJoFuLqFK+2v2ld6DB8u8KRg5gI7oxDuyFgRKibSrBDSyYe3tMGRsKIMeA9FW+yb
         sePBsirkUWh9xNxHqE0Yevt//wLpItW2Mj7aEOEbun4frKme5jl984nofo4X4uJ6xl9Z
         8UX9pTvTm5a0sleLBUF/YCq8tzEp1tJz9FjJT5X0FW9TEHYx7mP9iQk4ytM7jwyNgIWi
         X4Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fJ3NBOBpyT2MPhXo0xTMovJH/HTuu2Mxrur+WRQS/9U=;
        b=mZrfQjEAMCYYVr+7uQGbxuxJGmPL7jLV9hF4K2zPwuzfyPe1B7z0Ksq67ZqVKLghz/
         NJYtuSiiDCiS07DZeoBbjD366kKLNqGD7WKTlFlmHN8QmvUWCJTwB1iiIHpnsDjU9ykv
         74h3k9XYcp5cLvA9CYIaLsPzgeWjQLx8yFqCglC0hUo/yQJPYT06/lRQl3dTAqOR6VkT
         1L/x+AGT07NH7ENxG0tMHLuLCwYEZBqpFbpdkSrrpKp2/mP40soOOA5zuiyfBydzudrJ
         /FhjvUakcSx3gjNFb8yd0+eYEzXuyx1ajfBiezt+I7ydBaCSQLNIwea6QOeQ08ALQoBi
         hc9g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Enrico Mioso <mrkiko.rs@gmail.com>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Subject: [PATCH 3.18 35/45] media: cxusb, dib0700: ignore XC2028_I2C_FLUSH
Date: Thu, 15 Feb 2018 16:17:26 +0100
Message-Id: <20180215144123.369352051@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480749615627706?=
X-GMAIL-MSGID: =?utf-8?q?1592480749615627706?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <mchehab@osg.samsung.com>

commit 9893b905e743ded332575ca04486bd586c0772f7 upstream.

The XC2028_I2C_FLUSH only needs to be implemented on a few
devices. Others can safely ignore it.

That prevents filling the dmesg with lots of messages like:

	dib0700: stk7700ph_xc3028_callback: unknown command 2, arg 0

Fixes: 4d37ece757a8 ("[media] tuner/xc2028: Add I2C flush callback")
Reported-by: Enrico Mioso <mrkiko.rs@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/dvb-usb/cxusb.c           |    2 ++
 drivers/media/usb/dvb-usb/dib0700_devices.c |    1 +
 2 files changed, 3 insertions(+)

--- a/drivers/media/usb/dvb-usb/cxusb.c
+++ b/drivers/media/usb/dvb-usb/cxusb.c
@@ -923,6 +923,8 @@ static int dvico_bluebird_xc2028_callbac
 	case XC2028_RESET_CLK:
 		deb_info("%s: XC2028_RESET_CLK %d\n", __func__, arg);
 		break;
+	case XC2028_I2C_FLUSH:
+		break;
 	default:
 		deb_info("%s: unknown command %d, arg %d\n", __func__,
 			 command, arg);
--- a/drivers/media/usb/dvb-usb/dib0700_devices.c
+++ b/drivers/media/usb/dvb-usb/dib0700_devices.c
@@ -431,6 +431,7 @@ static int stk7700ph_xc3028_callback(voi
 		state->dib7000p_ops.set_gpio(adap->fe_adap[0].fe, 8, 0, 1);
 		break;
 	case XC2028_RESET_CLK:
+	case XC2028_I2C_FLUSH:
 		break;
 	default:
 		err("%s: unknown command %d, arg %d\n", __func__,
