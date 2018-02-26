Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuWTmKgIfiqaXvsw+EC6cHX0uWvWw+Zt33nOyg6aBZ6aHc0WiUi9TUn2J4daYwclovSQCPH
ARC-Seal: i=1; a=rsa-sha256; t=1519676177; cv=none;
        d=google.com; s=arc-20160816;
        b=gJ+6NjgTSQfk1xMZd2jea6BZ8odDiiCHYgwSIM8vZiLUUeiJpySmWlb041BRJzGjKr
         b3GgfOgaybvZcYJIGMd8yqLknpHInTtVRk92YSGdSSiLntxBNyjgUiASXCGntNCf6Cod
         LnwinDe703zR4KiiY6r00h9dtpOJ9M+kIdsoKL7SV1tA6QoOfZMZLG4rT2daxdfhQfc4
         3TPBl0JwAZC8ngdDDb8qu4rFrocPfWVTJ2hT6M3UG9ev04GPR/zF0yD/UBGMV9u3W/3U
         RYQK/aRcpcQS+Zy2Nz2n5c1e7IlP4G44zgu9e3wceD8Mj2nZD56tEQl2T6bjLkfenclv
         7MTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=blIoa2Zrvg1J5+zMFUNbNTGPhpovIONJxo/raiflKis=;
        b=vMREh4VQEXxsbtomVcnsyokN4tWZjg04JmVu0v3ntdpQyQA/lHntp6q8ib8vFJkvRI
         lbrNzBbVSK1QTH538hQZOB63FctWUwBC/2rRzAlqCjyaJaQZckLPc7cMm/PebCNF05sD
         nNm+/6Ue127+kpipM5ukEZc0MsCtGtoXAfHeaodQUYjxFy6tf7tn3vO02xVOOszKFHyH
         5JObqQfQbROoexexZ0/VY8NVdlG6azVYtmKeabuRgaJo8rq2pj8kOnYjKaGdMOXkKAnC
         oH+5WV2z1niIEWlvo4+m+ORbLmyvkVDWSTRUNdsOyiEaLiE68l1q59GdU+SON4U9dmoR
         CbiA==
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
Subject: [PATCH 3.18 06/13] iio: buffer: check if a buffer has been set up when poll is called
Date: Mon, 26 Feb 2018 21:15:34 +0100
Message-Id: <20180226201527.519431581@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201527.242286068@linuxfoundation.org>
References: <20180226201527.242286068@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495967737475956?=
X-GMAIL-MSGID: =?utf-8?q?1593495967737475956?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -92,7 +92,7 @@ unsigned int iio_buffer_poll(struct file
 	struct iio_dev *indio_dev = filp->private_data;
 	struct iio_buffer *rb = indio_dev->buffer;
 
-	if (!indio_dev->info)
+	if (!indio_dev->info || rb == NULL)
 		return 0;
 
 	poll_wait(filp, &rb->pollq, wait);
