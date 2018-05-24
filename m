Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrAN4rW6hroeMoNCksacNYDef3Y/VXHELJkP4ykWtECwZl86YvnKkxj+bw2OqZX1NeUY8Wf
ARC-Seal: i=1; a=rsa-sha256; t=1527155650; cv=none;
        d=google.com; s=arc-20160816;
        b=rnhKvw0q4EQA08MvztlgxHu0ikmbJYO1xZYsDOxEwV+QuBNWex9acdLA4Q8ef/PbaW
         PE3rxPDGze/zNs+X+VyArlba/cdhiytiAUlSTXUisTK8eOv80cATR5ssqMBhm5PkiHwd
         9WCk6zaLxJB83YQeDVWTHaoY+UhFNvCG5L6pZhZor4YphtaSZ7GMYLm24x781QFF0uYf
         85cN9Nvf9bUw16VbXI1xvbbVrOh49tkW6fsr7NX2jS1Cu4WlABovDWv85QC5k/zzlvVm
         85FpK94szGi6gkROOPREldlchE11LFCoiXTRTKLSUeDGuitIiwV74Mo9Dqf7tkd+mmOl
         yYYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=2yJGQkSYmOJWzT+NDqs1QYmHVxiN2Dcz5lQ5I15zd0I=;
        b=uS4vxbiQwihzGffTsKvGAEqvSQTCeFyFmR4Tww13ZjKLtbU4OTTYONWKAhSTfG4hXt
         4Dwwqc7HZ69PYJQJeGu2V+g9P1ZgZg9fkoNdUFGQrCkUE1A6AhAku2TQnCHwG86rtOk4
         Cfv5ANEI94eECyLESBpGG7ETz21B/7USq65WgA61jVi0F9ouzuqJkf0cBq3oEzrJBTct
         Dxe3zfsqzGnm8tQ4hZ+vLpx2p+M0Wuef2joCGik3x/jBSoC6odwrv/einFtJNm4w9bkT
         LNhcRopejBhKNoSe42USWYZLqUNUL1IV38fdepL2AwHzwwLaHCq7BBRjdGHX9rkBluMr
         xuiw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=gReN7lCU;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=gReN7lCU;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Giuseppe Lippolis <giu.lippolis@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 066/165] net-usb: add qmi_wwan if on lte modem wistron neweb d18q1
Date: Thu, 24 May 2018 11:37:52 +0200
Message-Id: <20180524093624.692262147@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338386337055800?=
X-GMAIL-MSGID: =?utf-8?q?1601338763249750965?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Giuseppe Lippolis <giu.lippolis@gmail.com>

[ Upstream commit d4c4bc11353f3bea6754f7d21e3612c9f32d1d64 ]

This modem is embedded on dlink dwr-921 router.
    The oem configuration states:

    T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480 MxCh= 0
    D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
    P:  Vendor=1435 ProdID=0918 Rev= 2.32
    S:  Manufacturer=Android
    S:  Product=Android
    S:  SerialNumber=0123456789ABCDEF
    C:* #Ifs= 7 Cfg#= 1 Atr=80 MxPwr=500mA
    I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
    E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
    E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
    E:  Ad=84(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
    E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
    E:  Ad=86(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
    E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
    E:  Ad=88(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
    E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
    E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
    E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:* If#= 6 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=(none)
    E:  Ad=8b(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=125us

Tested on openwrt distribution

Signed-off-by: Giuseppe Lippolis <giu.lippolis@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/qmi_wwan.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1105,6 +1105,9 @@ static const struct usb_device_id produc
 	{QMI_FIXED_INTF(0x0846, 0x68a2, 8)},
 	{QMI_FIXED_INTF(0x12d1, 0x140c, 1)},	/* Huawei E173 */
 	{QMI_FIXED_INTF(0x12d1, 0x14ac, 1)},	/* Huawei E1820 */
+	{QMI_FIXED_INTF(0x1435, 0xd181, 3)},	/* Wistron NeWeb D18Q1 */
+	{QMI_FIXED_INTF(0x1435, 0xd181, 4)},	/* Wistron NeWeb D18Q1 */
+	{QMI_FIXED_INTF(0x1435, 0xd181, 5)},	/* Wistron NeWeb D18Q1 */
 	{QMI_FIXED_INTF(0x16d8, 0x6003, 0)},	/* CMOTech 6003 */
 	{QMI_FIXED_INTF(0x16d8, 0x6007, 0)},	/* CMOTech CHE-628S */
 	{QMI_FIXED_INTF(0x16d8, 0x6008, 0)},	/* CMOTech CMU-301 */
