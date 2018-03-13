Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsm0IKkUDhjf1nj6A6tRyfuCxSz8YmjoFuTpCcCefhDBf6YHexHQ0k7Aowbq2MB9w3qFYcP
ARC-Seal: i=1; a=rsa-sha256; t=1520955587; cv=none;
        d=google.com; s=arc-20160816;
        b=a5V0FRemZYBIaPDhtj5Pkuw3Yf+qcx5oSKEH9UlQzyrQbNGR0V+4HvNNQJhb98AZqJ
         OK1D9OIuSMI/RGD+C1DxEovkEpUL9ANaJtVzA2N/snyctrI6nvnp1XEbi6d/NMxqvYtx
         HCAUU2PaNHtCOlXkRCDFwFPIiI9N1qseURy9Lz1B9m1PB6m+mN52tkufw4MS5uu8B0VI
         Dl7VIWOHPfI0bG/V3LjMw+ZNx90OCyblHC5O1SuI9X9xMJObyi+ebSGmwLWFCScx/SyA
         0cGs7o/S5/0WETSN0tcRvE+kWgr5fM6XbnT2F+kE3H6GQturiOtiCzBea+7RhqYwkKjI
         HT5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=k2cPhOCsekz1gFFEajo9kMCmd8ihTGT00haOZPCU+Bw=;
        b=cRtGZKzZh7y/FYkwXnn19fRjjuQtd4GqX7t/tWzE3A8myHajZ0eu4Opa2Rgh2NB1F+
         wF18gber5p8fh67VxJiIytW4mTqkWs3BAi7KSaOMfmnNe+QkwKqp6/W3oj1lTPV6uRBZ
         2iG80knmpgj8WZrDl9dp2LJb3FI/bOH2nzwy3j3tgUSL41uHKgoPq9bJtiaUhQ0zvMkb
         9qhfKKdqR+1mkNrzY4wImfQ09H7zfE0mdXZU8uAN558lFlZn2sO6dYdtb2j+QZkQr+qT
         gDi/DcL0qK9V3YfYluCdnLSlDTxmTDxfqGVi++cayfmYhPcBr0skfltMy6Rfy1L98c1R
         N99Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Lyle <mlyle@lyle.org>,
	Tang Junhui <tang.junhui@zte.com.cn>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 096/140] bcache: dont attach backing with duplicate UUID
Date: Tue, 13 Mar 2018 16:24:59 +0100
Message-Id: <20180313152504.603720689@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836931424200756?=
X-GMAIL-MSGID: =?utf-8?q?1594837526557280664?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Lyle <mlyle@lyle.org>

commit 86755b7a96faed57f910f9e6b8061e019ac1ec08 upstream.

This can happen e.g. during disk cloning.

This is an incomplete fix: it does not catch duplicate UUIDs earlier
when things are still unattached.  It does not unregister the device.
Further changes to cope better with this are planned but conflict with
Coly's ongoing improvements to handling device errors.  In the meantime,
one can manually stop the device after this has happened.

Attempts to attach a duplicate device result in:

[  136.372404] loop: module loaded
[  136.424461] bcache: register_bdev() registered backing device loop0
[  136.424464] bcache: bch_cached_dev_attach() Tried to attach loop0 but duplicate UUID already attached

My test procedure is:

  dd if=/dev/sdb1 of=imgfile bs=1024 count=262144
  losetup -f imgfile

Signed-off-by: Michael Lyle <mlyle@lyle.org>
Reviewed-by: Tang Junhui <tang.junhui@zte.com.cn>
Cc: <stable@vger.kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/bcache/super.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -938,6 +938,7 @@ int bch_cached_dev_attach(struct cached_
 	uint32_t rtime = cpu_to_le32(get_seconds());
 	struct uuid_entry *u;
 	char buf[BDEVNAME_SIZE];
+	struct cached_dev *exist_dc, *t;
 
 	bdevname(dc->bdev, buf);
 
@@ -961,6 +962,16 @@ int bch_cached_dev_attach(struct cached_
 		return -EINVAL;
 	}
 
+	/* Check whether already attached */
+	list_for_each_entry_safe(exist_dc, t, &c->cached_devs, list) {
+		if (!memcmp(dc->sb.uuid, exist_dc->sb.uuid, 16)) {
+			pr_err("Tried to attach %s but duplicate UUID already attached",
+				buf);
+
+			return -EINVAL;
+		}
+	}
+
 	u = uuid_find(c, dc->sb.uuid);
 
 	if (u &&
