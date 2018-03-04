Return-Path: <shreeya.patel23498@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520167396; cv=none;
        d=google.com; s=arc-20160816;
        b=HYAczxOSgjIn9zMbOa+PEFE7OM0eqkLcByv/TEgQkoACemA+veVUe8/MtN1yL3jZJk
         O188c7ywMqQ9UT3h2EUGLXxU+3mnH3cZE8dkzee8DGFEyGH6/DlIr7GscTqgqIDPeVZz
         dT606rXIFdPAcWwsrDdLPLrb6JuCBKY4x2dQrdrFLARgVfRMkXvRJfBYpWEjRnJ7Vty2
         mVwgJGjjur7Kvc6iViavUEEJR4GqZLnIJQq5ApilWKLZuy8qsgNzkpPAL6//I+HwYBIn
         tRcqf55s0lxHiJApoPPMMFITPcTPy1poTA67yjzITZIw4uU7dYtqNqrhOoXCSrIbWXIG
         0SZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=9+KosTM0HsuJ5G1V9461G0Qc8AXadDq/HJSXhjDOhvc=;
        b=uv9sE4r9T6qGgoJNBKV4j3IICk6msLzJjfmCjCJ+Rcy4O/qnoH7Xjj+ucGUGjal1XX
         W2uSV5zItp3iEpopaU66Brp4oYp4pG+EOQrqeLKOXeFzOkYJldMbs2Me37xb+6b3kK+/
         pOv5rdEDJh+u2gGt/Ev81n1DLjOD6dqGVpS6BpWzc6014V8tlN04go1gEUmbI26CmQPM
         eWJB5wYArPzvu1C5q5ug6fqixYr1O6PTxw1lHRVuPhmftTCncZKuJEdMGDf+AkJ/SQJU
         eJW5zlRljjKp5ZBrpFkZ7mTR2IrmdSo/qCuocTYSOblw1qTUKe8oUkezYt3BOaNIBYYL
         5NPg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=T1dNjPlW;
       spf=pass (google.com: domain of shreeya.patel23498@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=shreeya.patel23498@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=T1dNjPlW;
       spf=pass (google.com: domain of shreeya.patel23498@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=shreeya.patel23498@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELsGBDPyZL9KbudlKno+CM04M0q19TSS6BdwNXMoNMgUIBulE0VnXPI2Nlp2Pj0lXKhV7CnBlg==
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	daniel.baluta@gmail.com
Cc: Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: [PATCH v3 3/4] Staging: iio: adis16209: Adjust a switch statement
Date: Sun,  4 Mar 2018 18:13:12 +0530
Message-Id: <5c523865f71eb68181bd2b207685bdf5e9b8da83.1520164945.git.shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1520164945.git.shreeya.patel23498@gmail.com>
References: <cover.1520164945.git.shreeya.patel23498@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594011047925308246?=
X-GMAIL-MSGID: =?utf-8?q?1594011047925308246?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Adjust a switch block to explicitly match channels and
return -EINVAL as default case which makes the code
semantically more clear.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---

Changes in v3
  -After split patch.

 drivers/staging/iio/accel/adis16209.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
index eb5c878..9cb1ce0 100644
--- a/drivers/staging/iio/accel/adis16209.c
+++ b/drivers/staging/iio/accel/adis16209.c
@@ -155,10 +155,16 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
 		switch (chan->type) {
 		case IIO_VOLTAGE:
 			*val = 0;
-			if (chan->channel == 0)
+			switch (chan->channel) {
+			case 0:
 				*val2 = 305180; /* 0.30518 mV */
-			else
+				break;
+			case 1:
 				*val2 = 610500; /* 0.6105 mV */
+				break;
+			default:
+				return -EINVAL;
+			}
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_TEMP:
 			*val = -470;
-- 
2.7.4
