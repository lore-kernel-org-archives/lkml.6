Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224OkB6q6Yvy5gNH+LaNM9YMVsqNnpH+FwtqBfNr5yjF/mUVw/A8BK62Swnf+MPyCc5sq8lq
ARC-Seal: i=1; a=rsa-sha256; t=1518708564; cv=none;
        d=google.com; s=arc-20160816;
        b=p0CRSnr2gHXzFP9nkkML3/M/Cb/uQSgkO5gysRpFU0Awe72f0uDPCs2/aoO+23t+xb
         Ni58lVsTy1gXRJZIZd3dyD9EecunWq95B4xETn8hzORV/wWE89KHk7fINQahjV866CrT
         CcHJowyJMKzKl/CKxHysOH/4GrUadEwbkwCzG6PxxPkBNt16HF0VWFs2w1rV1ZPzvu6X
         b/fZhUjTi2m4pTZnpJHGppJpKJUs47KSSSaB+Ikfg+7HQYK6Cu4MDoX4OGBPZ44Qi2JQ
         BCHfQkttJ2NusNErUcl8iInmFetsoWAJRln02fFjEZMMW8VSM4212TYUimnBTK+r5MY6
         lr0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ywz8n4/b3GDPP4HRS5738QrPuForXjQ2vGUcFAaabNA=;
        b=c2pzf2vk+SDoDfDfDqVc+8V8lla642kuHBDc0wsx9A2ZAKrajInUi+Iaf6gSHemfgJ
         zYWSxoA7m27lbIpnLTCjabQ0enhonCwxG4bgAI01PaWeUw4DcFf2vHTKmPtaF3xSlmsZ
         9XXza0mt05pA4zXN2L5VwxWoDNs0gZSbajReceEEc7Z3Q16pbFI2i3ezUatjTncDXESc
         l/YEqcL2jOSRFtaMtObA2r05UBgjI/W+DpMzZrcQH0dyTLkpAWLWEZRecEhw1XM75Syo
         F3IR61IMK/6aadOuiTDqwuOT5OHSRVmmTQQU0q8Kl/PmqTHzLgThDfNLnYssIUZ4y5Pc
         CEHg==
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
Subject: [PATCH 4.9 60/88] media: cxusb, dib0700: ignore XC2028_I2C_FLUSH
Date: Thu, 15 Feb 2018 16:17:27 +0100
Message-Id: <20180215151230.953933674@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480749615627706?=
X-GMAIL-MSGID: =?utf-8?q?1592481351485037620?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -820,6 +820,8 @@ static int dvico_bluebird_xc2028_callbac
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
