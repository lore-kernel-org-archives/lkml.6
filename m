Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+eqyYt1y2SaK3OAW6Iwbac47wMkr0H8uPprqMf+5IyrFMh8vEZCKSv+XtjJMCFETAi0GZB
ARC-Seal: i=1; a=rsa-sha256; t=1523021300; cv=none;
        d=google.com; s=arc-20160816;
        b=WTnoY0InZdYy/outdrZq4PMIBOO/AvYCrjMLmUEfCMfYdVUeLu3V6wJ94+59s0v/o/
         NlZ5BT+G26KybyL8FnpCyNsYpilJTAYNqswoxwMUxYWoHISdvqYMk7ootRFJBGxbjWgj
         fWooOu1iK3BdUM9N98SGE8HHx8kMqI1KHVwkATprOctiQGEl2mq6AnhezNDVcaiPJKix
         ID9i2zEIJa3M7j9DPVRgILOUiQ25sRooK+8i4b93tN51AfuGAX0WEMwWdTiBbvi6IXwB
         C47qiz6dFWJj+sg5aQXwDlqzjOB5BGS6c/s2mpTs2YWUDzjPYlEntG2tTK+N3juBz4lA
         +4CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=18dKjHAGpV+EA22cHsOz7y+iYgFT8ZCvgha0u86wFL4=;
        b=p3dojPEI2W1LGQp991d+o9KoVBF4xvNEQuWV+AlJED3KJRMlYMKzTiU9Eddl3Wt9Dk
         IBwhDBxOogRO9EsNwJ8Ltc9IHm8CSFDYwHO5DEDMv0guET7pRxrNXJrnTUcEROGb+/Bu
         exm9OaSglNp3GEAFhio1jKSeUfguf6Xdqh+at/p9zHG1FeWaeitDlYb9oJfgG8OMGpLD
         khNL09eN0mxDjL83SBRoms5XQwHioovKFKTHiJZAep0M2DIuBwcnQORlqJjvheFop+XE
         8j74/u3W+wfe/LXSM59vNdeNjA8zIAwRhlKOPNht2+0OrvUtN2mRt9gWxxLMRuAaB8Hz
         EG4A==
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
Subject: [PATCH 3.18 79/93] media: usbtv: prevent double free in error case
Date: Fri,  6 Apr 2018 15:23:48 +0200
Message-Id: <20180406084228.620670984@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003583168556365?=
X-GMAIL-MSGID: =?utf-8?q?1597003583168556365?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -95,6 +95,8 @@ static int usbtv_probe(struct usb_interf
 	return 0;
 
 usbtv_audio_fail:
+	/* we must not free at this point */
+	usb_get_dev(usbtv->udev);
 	usbtv_video_free(usbtv);
 
 usbtv_video_fail:
