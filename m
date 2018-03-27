Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49Ryk6KqUii4cvwCcLLzoZzoPln8HUsDhki98F0uclWslGw9FBqm4z52MGLBEhL5TXAMIdA
ARC-Seal: i=1; a=rsa-sha256; t=1522168679; cv=none;
        d=google.com; s=arc-20160816;
        b=ww0nzU6tcd+a15HkW0dNcf+A0xYQ59KRIJNRQBhPjAUYBj7EYEGzdLj2AOOkd4L8wM
         xSRVEGZXk5vAj/z8SEndQNIxC/ofcAJnJEu7pu2cO3dAfQT55yRabPffvy5v6gMedmKB
         YNRYbg6bEMuzi99pxQwTQ0vsFdMt0sDfVdWsL7Nzk8hLTL/2AnkpgOphajipeo/4y6Rr
         EiDZl1ZgViB09680cYxJpMQXqhSv9BiVN/GjmPmbvrT/d4W73jOEAB0tLZVfWbBUROgt
         RLJfxv4laM24oL2iKNdmUAMkjJwCyLvoB6PRXJk8t6Or6hh6aiwymYCR+ap7oBgslAeq
         qcow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sS82UDfQSs+CUISp7xfsDqFGfmzWzDXSFlWuaZSLsDc=;
        b=xkltOulXWqaYt5tvb2WX3rjrJ6urI4QZQMvpceTXVVTylOyQYXK9SUVir8Qsyk+Vhd
         c1C3GTsarPv/L/74a8+YofPrH7TbEl3SEd+sWd0asEczqNzTfzKhudFrUb45tkhgr8T/
         uAqBwKrxCKJq8XUAMdMvXKDcmpXHEX/N27b9MiYZoZNh/isLVeV5bq6YXzKVuQEgKEQB
         wyRaEUBnLyU048HWZ/etwXjRQS5N36gMNkBRNdxfmmokzUOirMNsqIAc2W/heD6zF57M
         oCHBTAWRepPauBR7ZpG2USG4pnx84+cZB6CbVLXPXDvvAfMJmq/9rizD737xC2PV0F//
         EtFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.14 093/101] iio: imu: st_lsm6dsx: fix endianness in st_lsm6dsx_read_oneshot()
Date: Tue, 27 Mar 2018 18:28:05 +0200
Message-Id: <20180327162755.726085555@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109545391866602?=
X-GMAIL-MSGID: =?utf-8?q?1596109545391866602?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

commit 7b9ebe428266fb7e0a6d769bb3ff3fcb6044b15e upstream.

Apply le16_to_cpu() to data read from the sensor in order to take into
account architecture endianness

Fixes: 290a6ce11d93 (iio: imu: add support to lsm6dsx driver)
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -392,7 +392,7 @@ static int st_lsm6dsx_read_oneshot(struc
 
 	st_lsm6dsx_sensor_disable(sensor);
 
-	*val = (s16)data;
+	*val = (s16)le16_to_cpu(data);
 
 	return IIO_VAL_INT;
 }
