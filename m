Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49WghezUgrJiwV8UAVBDvg43Mza6gtx5dRRqp8z7Gr5YJqMpS5bMdOxbRmpJE1Om+na4sLX
ARC-Seal: i=1; a=rsa-sha256; t=1523021758; cv=none;
        d=google.com; s=arc-20160816;
        b=Jm+iRK4zwrJhuIa4WbQC/GSoXD5N0IyHBxL76ksWS3Lh/Y5wvm2wkQHv1OLjWGM24H
         cMGfkkFve9xPQVxYgmZN3rzHR9UF4vjZ47wm4j5Y7OesOek1JePDlbyTMNE5ckLmMu26
         qYp6ZHL3AMKcSqOjpkP/QIsESjQbmilvYkgYmRB4fVpQlwHjbHm1Nz8Q85WdZSBgwqfy
         pP6gClcSAvVH2zibTpI4HufBypRGBoIu7YK3RaZjDdE6q9YFpERb04wKmrTIRgdmnKJ4
         j+0EQaLznQm5/EHd+LWUzNrq6Mol0E8L0RaH9VP2JUk0l2D+aH6uvp1xFAbY9lX61/aJ
         9ohw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0jCAW01MRQnETiWDAj3ipy/incCS9SPKpzpc58SNTis=;
        b=t2YbUE657ZPDWF5ok8dF8hw9Pg2ULPx+RyTQdnK8q6q35Zcz98/fVu2kwT/9QdU0fb
         5+YArOLms7cpXOgqVwsAZdJaalfsryS0jIh79cNTvwYusvlKmte3k0rZEDy7Uvrpd3ba
         R144lH2Cwm/UF7jd46re3VCRPeZY8MxEbASHD30VfEJkLHdruIf0mWBK4iOtA1SeBbOj
         +sNV3vJP32wyYwa5CG2TiByKnDFEDj9BL63zUXOa96iJpR38UswKyeNcN9iLCtrI8qth
         PlHdaR1CKhVAirru+mkqziKTI38WawXQXD1zN8wsh5aVxhuZC2zIA0HlBKns3k+rzJgB
         lM5A==
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
Subject: [PATCH 4.9 081/102] media: usbtv: prevent double free in error case
Date: Fri,  6 Apr 2018 15:24:02 +0200
Message-Id: <20180406084342.882386215@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003583168556365?=
X-GMAIL-MSGID: =?utf-8?q?1597004063848071781?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -109,6 +109,8 @@ static int usbtv_probe(struct usb_interf
 	return 0;
 
 usbtv_audio_fail:
+	/* we must not free at this point */
+	usb_get_dev(usbtv->udev);
 	usbtv_video_free(usbtv);
 
 usbtv_video_fail:
