Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/FhSX43S51cr7g/zrJnTp2iyHPHH8BopoPNOLtt+d0q7e/yT9XiPInwctO5Lx7BtwRoGhr
ARC-Seal: i=1; a=rsa-sha256; t=1523021270; cv=none;
        d=google.com; s=arc-20160816;
        b=v9bdfYVFKfE9YOPIu6ryENYCv19X93nAsal4pQvTgVilWVhuIHX78x8a+shsP4Sibi
         YXsQMSpjZVoH0TPfXtpNS+PGFnatVVMCtdgRG4Uzn8cV90S7ejq/xZ0rGk3SE9LQKC3L
         qBVIQa2lDvd2RQMWa2z0ee6v/PH2FfKJMDQGf2z3TIg3NigQ7kpkTtED6tG3lqCzZ05b
         VEYWP3LT2WB8zDUqY805iR4bshuDd1TAgI63Y47rOEaFK+oYDmIcFA2SvGxxkpNRIyWL
         L3zuBziwHUDCghFfnp/scZlxsBwc23fd59gQvVdYY/VYycsEOmyDQP6kn3YxTM00BPJb
         rroQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TFfXeXz349M+Z2ZXY7TgSzQNXzWhp+pAyxAwBzTzn3Y=;
        b=ywzyF8STomVoz1TNiQGRuIAJyGx2JPBDmExrPYbgo9GPH7E6H3AXqdckQRa7DvNLoz
         9JcRo9sVDL8dw2S18gNjgZwka9bh7DQRbDSlHoKJSxZqyjpJ0u1wXeiSHAr3d+wUJASn
         OeoVHxZ3DyMOkFauKXU9L0jK+UM4IE9ud3brlfwaUXdk7KoEn28Xgziy1upCkbNSclEa
         F2mLOktlcJWR776/kKGbvv6CMWO6uQYAZzl960ZyPB2kyXEkUoZqRkGfyrRlTL5hh27Y
         9SBSwhpGDIGh0S/ic1eVVMn98rOix38hVKbVV2bLqMU6Vne5+kKQJfYkPGdm1va8oLOQ
         BoWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 69/93] media: v4l2-compat-ioctl32.c: dont copy back the result for certain errors
Date: Fri,  6 Apr 2018 15:23:38 +0200
Message-Id: <20180406084228.029672883@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003552140376931?=
X-GMAIL-MSGID: =?utf-8?q?1597003552140376931?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hans.verkuil@cisco.com>

commit d83a8243aaefe62ace433e4384a4f077bed86acb upstream.

Some ioctls need to copy back the result even if the ioctl returned
an error. However, don't do this for the error code -ENOTTY.
It makes no sense in that cases.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -943,6 +943,9 @@ static long do_video_ioctl(struct file *
 		set_fs(old_fs);
 	}
 
+	if (err == -ENOTTY)
+		return err;
+
 	/* Special case: even after an error we need to put the
 	   results back for these ioctls since the error_idx will
 	   contain information on which control failed. */
