Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225bJU5vYx2MdEfKKe7rKqwvC9o7rsdI5/1mn7Y2gB0r7efCsAFWW8wsJDfZpRl3U8VfGObq
ARC-Seal: i=1; a=rsa-sha256; t=1519676642; cv=none;
        d=google.com; s=arc-20160816;
        b=KNIy1zEoF2YxDxcsfJ3NEy36jgMu+/aw858WQ8T3WyFEzb4+RXH9uHs6fhC721Pi6x
         KDL2eOg04lps+exVLrSjWLbS+/zgc0iCdQbRrz3rZ0aCaj2X7WBLUccoc3aP+DWYxpK+
         8jeuyrGH5p/w3djHm728rAaiRQasc61MqwS/Tc2Ky1VKin6IhKkg+VVZJ354akFA9bM+
         y1nc2QbsaBdXWayHdNHrzksyHz9UWjUpDrj9QJAlUhrcjUjplySx+Z9+ksbd7A9U/w93
         KohpH1c4rX6lF1DipSm6OCbJPexxCFiO9ylcm0NZL2RPbM5lqEXRHTdBQG2pI4BzYhAO
         Vq7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AM0qu0UXdB6jLQ+Y+sCYWOo3uF7c2bpVT+g6+v+hddk=;
        b=dx6Rrm7FqxBkAbc0zVZ49zbxtwv5vThk2yrgsov2/SdSLqIZS+AWnLPzkRn7l7gXej
         eo5ereYejCtg6rjXKOB+2gfkAa3eeCmccmzuFLAUm/leSbFZ0veU/rppI47vL8WHCBVG
         N9sFN+0wUWDuWozQQhNYwuWs02qaUbtcRfoHmC7F9ZcVFDmMtiG/q8X3IrKEMqTrabuD
         Um7JYHc6RUaUsc7qiw6t0PU64aBLc66BadXWLjxXJEmt17kWH5rkRRYmAb34Bf+sndXs
         oyv0iA4JKcPUXHdFcmzzlOAStl2YYy/blnIc/nLofjXIP3NPJw5mALP/IDZ6/g/xR9TT
         /DUA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stefan Windfeldt-Prytz <stefan.windfeldt@axis.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.14 23/54] iio: buffer: check if a buffer has been set up when poll is called
Date: Mon, 26 Feb 2018 21:22:00 +0100
Message-Id: <20180226202145.551142113@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495967737475956?=
X-GMAIL-MSGID: =?utf-8?q?1593496454372710984?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Windfeldt-Prytz <stefan.windfeldt@axis.com>

commit 4cd140bda6494543f1c1b0ccceceaa44b676eef6 upstream.

If no iio buffer has been set up and poll is called return 0.
Without this check there will be a null pointer dereference when
calling poll on a iio driver without an iio buffer.

Cc: stable@vger.kernel.org
Signed-off-by: Stefan Windfeldt-Prytz <stefan.windfeldt@axis.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/industrialio-buffer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -175,7 +175,7 @@ unsigned int iio_buffer_poll(struct file
 	struct iio_dev *indio_dev = filp->private_data;
 	struct iio_buffer *rb = indio_dev->buffer;
 
-	if (!indio_dev->info)
+	if (!indio_dev->info || rb == NULL)
 		return 0;
 
 	poll_wait(filp, &rb->pollq, wait);
