Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvSGnKn38D1eZZ1orCgEpFecXdhP33a30aRPUMhkI+584q3p/65nxd4sJBLgrXSumhKWLjf
ARC-Seal: i=1; a=rsa-sha256; t=1521800342; cv=none;
        d=google.com; s=arc-20160816;
        b=gBrZFNPLzwv1NZi4E6Vb13BJgJuIcBs/YiEDy+UsqvQM9lyWBdAowYzaKL9enpk3So
         fA9c9VI9bxWWLPkMLXtKXyCqd4mOIj7YQYDVPyKbs3e4XhrYGhpWGeZtmkBPVHG/UWkm
         SDW35unOsp8U4lv6nM0P8jfN2B6MtBeHP0ryRq9YjINDO/Zm82ub/iXk4iRjWt5AEVco
         hm/oPCm75dW1ZDrCIWYGSTU7ViLQQYYPITszJUYiEuB5e/EVSp3ioT5tqxKCd/12Ntmz
         dydCC9szzC9upyJ3P8iqsp6H9vGoddZU7n/L6hXLgtWiwIOPGPb/0Akj3WG8eMugCVNr
         KiRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ut9X/8stI9vEVbt8tHJLSwC7+QO/146ob/PzWl5Tzco=;
        b=DsnGad/Gw60S2oIxo6KAAxYN4qCjoYPW/qkhhjhzFXibrRsJR0EKWMhxenjnS8M8ZW
         JL6p+754n2MPrpzpB3RpEwtCsSKiLgUkBMTFqLv2ZU9pgXiEd33mKf9LWpA2FDSXtZ7k
         nI79/wDvXZSJYwt7kLfR8Z78OyneOoRWLvqnbLz+cjm8mNF3h4iUpVFs8EK/rkj/6xF+
         98ENM3f+NL+SPJ7R2cfFYvTlwEz5XkfTUVC+/BkO0kiaiO583GhQUA+muPB17/Nifjvg
         ld+VAjZ2yQfeSWPngL91m3LU9YrqbGqVCCNnPaa1TvEAoD59wzEoFd9dKiwZJJ9rngmc
         zT1w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Maksim Salau <maksim.salau@gmail.com>,
	Bernie Thompson <bernie@plugable.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 34/47] video: fbdev: udlfb: Fix buffer on stack
Date: Fri, 23 Mar 2018 10:55:25 +0100
Message-Id: <20180323094249.578551667@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722800036610611?=
X-GMAIL-MSGID: =?utf-8?q?1595723315526499577?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maksim Salau <maksim.salau@gmail.com>


[ Upstream commit 45f580c42e5c125d55dbd8099750a1998de3d917 ]

Allocate buffers on HEAP instead of STACK for local array
that is to be sent using usb_control_msg().

Signed-off-by: Maksim Salau <maksim.salau@gmail.com>
Cc: Bernie Thompson <bernie@plugable.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/udlfb.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1490,15 +1490,25 @@ static struct device_attribute fb_device
 static int dlfb_select_std_channel(struct dlfb_data *dev)
 {
 	int ret;
-	u8 set_def_chn[] = {	   0x57, 0xCD, 0xDC, 0xA7,
+	void *buf;
+	static const u8 set_def_chn[] = {
+				0x57, 0xCD, 0xDC, 0xA7,
 				0x1C, 0x88, 0x5E, 0x15,
 				0x60, 0xFE, 0xC6, 0x97,
 				0x16, 0x3D, 0x47, 0xF2  };
 
+	buf = kmemdup(set_def_chn, sizeof(set_def_chn), GFP_KERNEL);
+
+	if (!buf)
+		return -ENOMEM;
+
 	ret = usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, 0),
 			NR_USB_REQUEST_CHANNEL,
 			(USB_DIR_OUT | USB_TYPE_VENDOR), 0, 0,
-			set_def_chn, sizeof(set_def_chn), USB_CTRL_SET_TIMEOUT);
+			buf, sizeof(set_def_chn), USB_CTRL_SET_TIMEOUT);
+
+	kfree(buf);
+
 	return ret;
 }
 
