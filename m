Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/lJuzaxpPF2LI0m/kx20a2VXhvv3m/nskLKyXyYg0KM8e/5FtHye4GUGnIOMlDoW7gr5xi
ARC-Seal: i=1; a=rsa-sha256; t=1523021540; cv=none;
        d=google.com; s=arc-20160816;
        b=bqVOt7XwqFear+Ul85rfqI6fKgzm4rIpfLKwp3344HhF6mmvDA3cD3zbC4umStTn5Z
         mQ3hC6USXbiMta512v3vsPogfrk5lkUsl/fUbjDgkwfb2ve/t/Bjr2OlRG19USesvE3H
         CljR4mYF7B6nFWH8GCDopk2zxyBRVNiE4n6dnc2NSQFCvfYli67U/Jzaa/B22b8F/XWP
         ghqZNe/cccI0xQ35jyLTb2UUxhT/5jW5eQ1nP+PSSM2a7jLx2b6/SRv9bkTT7TRXsBgl
         5XV1FGEmlU15qsLG6hiCESZGCsY2EJFxK0oLrSo0oa8NNBCvtK/2/ZlPrO5ux0CTHUVe
         Q8WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LU8Lh3MMYd3K2I2PsBjBbI7NjJJYFYpZKAiALJx+DCM=;
        b=clwLirAotuh4zybtyYVRWo838i7vrgJ7rGzibbiF98mNwFWGLukcKWV5KkNnNYBcPm
         syik4sfu7JOWV5OKH45a10RSaJoqhFyt+M7C4QF9oNMWCwlTQ8f/klyRdloAntZdqsFP
         piSIiPXKncS/rSGRqMRAH8eJ2AOayvvFteXAmcVQrNZq6zcM1+MLFzGUBmSHxm+nd8yA
         vuBfigVxEYZaJWaFlnqONrbNOQTJOi97DAjGQmfbTRGqWkRZZ0ahWa47T2pzl5/MXkvv
         y+oW5t4UhZrfyy4QWEtzLzyrPwfmQDP3S52kXDRXjtCl0xPzEHx9tB6A+m+iNVN2ydJ3
         WFyQ==
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
Subject: [PATCH 4.4 49/72] media: usbtv: prevent double free in error case
Date: Fri,  6 Apr 2018 15:23:50 +0200
Message-Id: <20180406084309.317246829@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003583168556365?=
X-GMAIL-MSGID: =?utf-8?q?1597003835146480498?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
