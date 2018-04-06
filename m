Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48YlHkP/vWZDBB3I2Bx+8CcSxgd434vHGFVfHlNxFn66c0O2zK5g78Znwi800sAdwxplxaQ
ARC-Seal: i=1; a=rsa-sha256; t=1523022158; cv=none;
        d=google.com; s=arc-20160816;
        b=smn/Z6BoahlFctEdCAVVirbX6Gm7k9SHn5X5v5g0IroEsslAI9U+GnM4DVvkuJ9nVl
         zCr8pW73njs3oDLXYXjC++1dSShvkWTcjpbQWfn/qtghIF8MoqXuGRKtglOkrrz4RCbe
         LSzhA6QEBAxWkKkAUoKhdZgM4xpFBDXBGZ0NLbjHWCGIyvRYxTAWa3PABdGYcm/n0PnF
         0anuv29U+sXGIcROzBNQ/2QbopII7sm4oLRSW2E010xaWR7BSvhNIgOcG2xXcQBACCKW
         DDOYW7Xxe1WBmlo/r3v4FSPr8W5VxTgssf/ehXYuzeBkZcbg2ZFb9ZaIqA33c02v+HXP
         1Hew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dPWEFRWw/iST29T6ryeYzoYL8mU3X6dUuTys2avpZjM=;
        b=dwDPKiE7EljTKeQG8iDLobLvVfGlhYWtgOTochllVCH4ln9ZYKmfefNuFT2ZzRodff
         R870sCk5STV/ViuoApA8qKtc6iX2UhDnmPSJofW7ZBmIolbMA04swEvOZPHkWyeXV2dq
         DbzdslbBZVxdJPJ87rZ9NP1Sbii2vppKs/avchSHnuR+nIMpijwDG2KRmD7/bIqgkKCr
         i5tRSmPiKmv3+CBAX1cr2KGDxejTldKW9Dy7reNMm+BAfF9anVqk8rtgPJhds1KFwgMK
         RgHusbXSRkculBFAhlj9y1JSnuQBlWqoubOk8B1VZ2eshUy/Oebo4RnFjt4SVK4AwLru
         IzRg==
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
Subject: [PATCH 4.15 47/72] media: usbtv: prevent double free in error case
Date: Fri,  6 Apr 2018 15:24:22 +0200
Message-Id: <20180406084352.843302321@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003583168556365?=
X-GMAIL-MSGID: =?utf-8?q?1597004483075302909?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
