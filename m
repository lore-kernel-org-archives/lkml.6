Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx499T52GLlC2BmN5F0899Swzf0A57S6Gax1rVRX8oNamB/xQDp8IVZl4w8mAl2YvvYSSnz9z
ARC-Seal: i=1; a=rsa-sha256; t=1523021948; cv=none;
        d=google.com; s=arc-20160816;
        b=jz9Gje0tKEl9t9V77dN5ynN5Vq7gLt+vzYZ2VhMOnTAaB9T16hPbQTBmLjez67CvKP
         wT+TzVOs9od3+n1Oqk/vtOEvvhPS8C4rWKU7JYYCiwBfjOdi9knAtmc3j8BYIrVEnjp4
         p2dc4Yovpno3IrqkNT6oyQNUpxieJUtd+/YXMt3MqZOwZfnudJGqJ//t/GgjeG8vTIG/
         Ud43kvvPYlcuJLjFaDJsEmmlaXlhBZyU4ni+ood9OfcTJ5Q8/CLOqI2+VO9gymO9EIgU
         52Xe53gE3vHpaAMijW4AG3S8D4v24Ey3mdnKhV1GQLyKNZTQke3vH1czB7SJlGiMoCsh
         aGaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=F1htOeUtAeiZB/Fxfu/0mBIeTuhHZmIf/S6cC1C6kE8=;
        b=ONBtWn3rk1DZFDXAwBgSHfl7M9Xn51Y8HgzcAzI8Nut1Ez/pF6MXGnMHg7h5WAjSrS
         VLLDEnc4XB84fl/yflh09wlNzo/kg/fQaEJNemMkknE7XGO1F+HTGsBOJzjUcynP1GaG
         O9/wbqFBVqR8E/1fxuDq/AmX/gDgHLjKl2KHobGrHewOOM/dRuYBovtDOZoWW/s5gafp
         BLPkzvlbcrvlt+udH21SvLkxTh0sX1C8B6C6V+40s5EtK3ho680oKRfDELjfhmgnUgqE
         XFN7TH2KFRE2sZ/MDVvt+aP1YeghlRx/bAPtcaWcXt81j7wW5PzVyYaHsd/RfhbaGk3r
         9zLg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Yavuz, Tuba" <tuba@ece.ufl.edu>,
	Oliver Neukum <oneukum@suse.com>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.14 44/67] media: usbtv: prevent double free in error case
Date: Fri,  6 Apr 2018 15:24:14 +0200
Message-Id: <20180406084347.207654052@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003583168556365?=
X-GMAIL-MSGID: =?utf-8?q?1597004262292058482?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit 50e7044535537b2a54c7ab798cd34c7f6d900bd2 upstream.

Quoting the original report:

It looks like there is a double-free vulnerability in Linux usbtv driver
on an error path of usbtv_probe function. When audio registration fails,
usbtv_video_free function ends up freeing usbtv data structure, which
gets freed the second time under usbtv_video_fail label.

usbtv_audio_fail:

        usbtv_video_free(usbtv); =>

           v4l2_device_put(&usbtv->v4l2_dev);

              => v4l2_device_put

                  => kref_put

                      => v4l2_device_release

  => usbtv_release (CALLBACK)

                             => kfree(usbtv) (1st time)

usbtv_video_fail:

        usb_set_intfdata(intf, NULL);

        usb_put_dev(usbtv->udev);

        kfree(usbtv); (2nd time)

So, as we have refcounting, use it

Reported-by: Yavuz, Tuba <tuba@ece.ufl.edu>
Signed-off-by: Oliver Neukum <oneukum@suse.com>
CC: stable@vger.kernel.org
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/usbtv/usbtv-core.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/media/usb/usbtv/usbtv-core.c
+++ b/drivers/media/usb/usbtv/usbtv-core.c
@@ -112,6 +112,8 @@ static int usbtv_probe(struct usb_interf
 	return 0;
 
 usbtv_audio_fail:
+	/* we must not free at this point */
+	usb_get_dev(usbtv->udev);
 	usbtv_video_free(usbtv);
 
 usbtv_video_fail:
