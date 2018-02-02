Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226NQLVIRrBk9rgQVnj2wuWeCBLzxx1lIFi0Jlb6LduSe2PI1IRIUXflvmOUw7/pibp+PC0g
ARC-Seal: i=1; a=rsa-sha256; t=1517591179; cv=none;
        d=google.com; s=arc-20160816;
        b=vE/RN/33uDtyMsQIGnguoMWSwvmFe3ySM3KmxcONNBcI3kWcuyfI1CQtVkOF4sDT4t
         tSZ4UPD9kFhkoOaeHLnFjBw82X5bYR6tVZ8zQiur9L0+8xyngE10ArgM0hy7EMTlhRuM
         OVXYyeV01xAjStAp2fNr+aK/LbUxq3bK8EaR+HzzAn1xVu85ys7NRH5viY8L7TNEE3f9
         3l8UA7k8bk6kRpzuJ8kxD1PhOlFlXNvPPMPkbYvw0X7y5rBQULvMtj6XBONm23Um7Z6l
         9m4p1IH4zf+Oiq0eDLvBrS+v4vZYKcCVUCuT+bUt5hqGzFzZMgPSKx8QPjiMuyBr3Z7n
         d8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=prigABS2+24XOsdEmsRllpLwvgsSh8peInd4P4uzu+w=;
        b=Ol949AwbnzYq8Hf1iDscUB4c4/4ys5/uulDRLx1sdoMrwKRe9nuaDEuZPhj44NMrS0
         p7SxdO7/4Hdo0Hsop76WdMtsnu1a3csoGohM86sTtfHfeMPkfpZY3m/wUoBBPKYdFxjv
         RsiUrMvDvGWCeWiqQo2rGQpUmH56TSvxtm6p6iFGCsg3IC+4y8P9Pqf9UFD1MF/My9Ye
         AqSvz6KF8XUTOcIJzVCqLL2BLHUUCbjmVsJz8TYqJy3Z5GPzMRNOEW0XfsJXz/7iUmLZ
         vv0NPro7cFK8xgKD4zyJhPN74YGmEkv7RJwrby2fheJ25xzSAnCVyJomZ+S+jTfscn8Z
         Qk7w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@gmail.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 77/86] USB: serial: io_edgeport: fix possible sleep-in-atomic
Date: Fri,  2 Feb 2018 17:58:37 +0100
Message-Id: <20180202140829.747307495@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309422775128641?=
X-GMAIL-MSGID: =?utf-8?q?1591309688376981593?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jia-Ju Bai <baijiaju1990@gmail.com>

commit c7b8f77872c73f69a16528a9eb87afefcccdc18b upstream.

According to drivers/usb/serial/io_edgeport.c, the driver may sleep
under a spinlock.
The function call path is:
edge_bulk_in_callback (acquire the spinlock)
   process_rcvd_data
     process_rcvd_status
       change_port_settings
         send_iosp_ext_cmd
           write_cmd_usb
             usb_kill_urb --> may sleep

To fix it, the redundant usb_kill_urb() is removed from the error path
after usb_submit_urb() fails.

This possible bug is found by my static analysis tool (DSAC) and checked
by my code review.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/io_edgeport.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -2215,7 +2215,6 @@ static int write_cmd_usb(struct edgeport
 		/* something went wrong */
 		dev_err(dev, "%s - usb_submit_urb(write command) failed, status = %d\n",
 			__func__, status);
-		usb_kill_urb(urb);
 		usb_free_urb(urb);
 		atomic_dec(&CmdUrbs);
 		return status;
