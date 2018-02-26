Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224qCGJHRJxwnf4a+5kyWDAsnkVxUQZ5Tnka/eZmVxZVA9fOIOohGSJ9sAnOsjlKky8HQ4y3
ARC-Seal: i=1; a=rsa-sha256; t=1519676817; cv=none;
        d=google.com; s=arc-20160816;
        b=d4bXbdJPRtyJkLQRCYF50AoxVZZlMMhofCxWabUCXEldSY8At+UZSK5HkoDZcLmZ6o
         xo4VDUsfn6gpr+zkYQsQ9QZgAOjZUIzNzTYOcy9dlZ5Wmb+3zBLSLZz2fguV7vMmAz6y
         UAZaAgqPo5KnbMAHAwsW5eg1P8baO2I9mW527Fo9g/El0VAr4IPU8lBG5vk6s4FvulbD
         L/+nGZFsYi3TDosjXcUpPsX10fFwbbmfkMuvnUxvudHosjDUFWEVD3FaCZjv9RPcEVwZ
         srlCsrpVwSNY2pqvq0XDcq9SzpKnKL5RyyBuAOx/LNRvNkz5IQ0Rzdf4g3hpk5lW6pFO
         P6FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fc8SEl8SlLLcE5rC1jStBgJLbqh0LoLbz/t9WOQ1UyM=;
        b=ePOZjCUZ8oJEXmts1pW56f9l3YBGKeF5SqVYbPPF3AI6PwNoPe5k+okyhcIP/PLWtq
         BpAqPxdEhVWOMUDmFZqSKr0Ma7zD3XmBt+lW5X7BH1V4qcd5JbsBzMdYCmfWhAzqo2me
         4jRbbPKaFuts30Aph6Jg6VV0IzfCtu+lyYxlAUbKOWGfKpXLJNi5aXKUJLL8tG6kaesa
         uWsGHJFqCcNw56NJakZo+AWSzJkxYLsR3tKZLobpuu/oLe7Ucvv427wT6CQoSJL/lrCE
         bh3Rk0hx4dUOwM0Hd3iJQ3tQS8s3fzdvzpWERcvHo7WDPDNzbW9wYCcejRnlSoScbDPt
         kwJQ==
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
Subject: [PATCH 4.15 24/64] iio: buffer: check if a buffer has been set up when poll is called
Date: Mon, 26 Feb 2018 21:22:01 +0100
Message-Id: <20180226202154.498076659@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495967737475956?=
X-GMAIL-MSGID: =?utf-8?q?1593496638273667091?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
