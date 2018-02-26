Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtP/mQi/whUNmVI7rE4sPCJD1Nz57FaKPyUWDQq+CXax9hbfC37vSiXeRr5dDsnbJrmKIj/
ARC-Seal: i=1; a=rsa-sha256; t=1519676569; cv=none;
        d=google.com; s=arc-20160816;
        b=GU8otIl8/CWZ3qhkxwsir1/1RLZ72XhX0IIc2HHm33FOGeR4naNFpnWIe96r879OFk
         nECGRX4btGDJEsAZcEy7FMVYx5a+fwW1GN61YRGVEL3OpH2DpgSo3WH2bURRxJTTXwGS
         pTx86JCRCvS9B2IARIEggrWE8MuEZvUPbGihvKazVGdSiaTZm+pz8hR/wjMudjyUeOQf
         Jg+ABe1PrKSjdEnjQtk+8ZsJWtdfGYHS8cTvCbnq3qhcAwWLKMNHZYPUuHfRtGC7sWCU
         bM8JanDct40qTWTnxnSl8+Qf8KJrliLSsDxFDvPSttMacSNiCIIcdXSG3uxnjbN1EhC8
         4Y/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CNc5RtQf+jf9V6AALc/Xiti2eexPaIHh0fS9xxF+itE=;
        b=SCpF8F9Z0NDpglNAznNn8KDG999Z2Na218QhC/ONeO/grt+fqrtoZR88yCqOOkLWP8
         sV3PiBkMhemp7LP0zWK+9oMEVOM/jQMCr6rjAjDXagiUPUBUwSuWRVAadxGf5waLNAg6
         z26GKq3JU6Jt5O85XfbLaCelsTC7wQAmyHmLYQQjEsgFKs9YssXHFT65i8FRnTfY1Vdz
         FAI26LE3+k0R8soUWCucVmpUElMp753fDWhenK8uIlBiU7BdfxB+tnAczZd3cJa3spW0
         W0oSxrkjOKqRx+Tw3rdFAPx4+uoOZkUtGyoTQW7L/3874sL5XVbmiQOlaB2aRj21p1TU
         JFjA==
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
Subject: [PATCH 4.9 08/39] iio: buffer: check if a buffer has been set up when poll is called
Date: Mon, 26 Feb 2018 21:20:29 +0100
Message-Id: <20180226201644.041990353@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495967737475956?=
X-GMAIL-MSGID: =?utf-8?q?1593496378463371142?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -174,7 +174,7 @@ unsigned int iio_buffer_poll(struct file
 	struct iio_dev *indio_dev = filp->private_data;
 	struct iio_buffer *rb = indio_dev->buffer;
 
-	if (!indio_dev->info)
+	if (!indio_dev->info || rb == NULL)
 		return 0;
 
 	poll_wait(filp, &rb->pollq, wait);
