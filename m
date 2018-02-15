Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225ZKiDb4Le8GVOUmHPasJogrCRvhBUY9f6mqe2M7qCDVoBeLD3JB9758l1CeneCuNsNYkYT
ARC-Seal: i=1; a=rsa-sha256; t=1518708997; cv=none;
        d=google.com; s=arc-20160816;
        b=aqDUNhIOyK+Oa1we91wHgmA/UiEz4clTxAwWY1ktxltySXiG8IFp6ZBY/Z9WdU2FxS
         9OrtGijLkhYQhTVa5Ux1N+WRosr6puGYnJzWXsILO7msyPRUB7LbmPPHH8eCVktN9wsL
         6bEmn+ttbo5ZjaGwkUM7Kgz5X1/Up5sQLswaRQ3B8T5kfVx8V3IHvl49kbju9qqnnTaV
         Eq4/jUIEu9dBzzDd1Bov+H+w+SZWaJlMCCA5/bUy1S0wyIvVAFOgi7UgktFWzcIwGUit
         p9XKRmLpMU1qAdgi7z2bbYZiJPkCut45oZPZRgrczcyhzTCOjGfxvGf/ViM/9aasodin
         S8RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UnW9Kw9xKOWbEvExYVOX4BD5FyST4jJ2w+IT7yBbNMk=;
        b=y/CRNmlzkW7niKmk0qS3mRkTkBqfTAS+ahz11BXO5dC+50Lzcl/8rjyx4YInXXwfoI
         vfgfACMIxVwf1O2FIJezHLJ3IQ0tR/PJOSmWODnOc6RlqPWwoFjIBTn2e9V7QvoRzd9k
         KFBgeXRgvFOOJCdIucMQotbNSiOr876tj7u+zbweYAMZQmQmomnbZZapusagce0t9hLi
         crJV8EcOIfbxdvnxqwWEoPCEdeFD4q4SaeN4u1gYYRWKOj9WopRJxHvTTM8+nswv7Jxd
         QiWxHrwUSDscU/doE5bZl77aqDPlH2H67w6WDxqfNoQu5Ur1nn7zz4+EjdBUmOBIyyxS
         s6kw==
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
Subject: [PATCH 4.14 151/195] media: cxusb, dib0700: ignore XC2028_I2C_FLUSH
Date: Thu, 15 Feb 2018 16:17:22 +0100
Message-Id: <20180215151713.433633618@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480749615627706?=
X-GMAIL-MSGID: =?utf-8?q?1592481806178753254?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -677,6 +677,8 @@ static int dvico_bluebird_xc2028_callbac
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
@@ -430,6 +430,7 @@ static int stk7700ph_xc3028_callback(voi
 		state->dib7000p_ops.set_gpio(adap->fe_adap[0].fe, 8, 0, 1);
 		break;
 	case XC2028_RESET_CLK:
+	case XC2028_I2C_FLUSH:
 		break;
 	default:
 		err("%s: unknown command %d, arg %d\n", __func__,
