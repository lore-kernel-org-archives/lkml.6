Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48KtO4ENoIPi10CG+za8pJK+hToj3yYpiPwzvI744JTYh0K8ZDVMuQFSkzO+n9qVDFwqt3Z
ARC-Seal: i=1; a=rsa-sha256; t=1522168982; cv=none;
        d=google.com; s=arc-20160816;
        b=B+GELyb6rYU1EjZST2MSu/FBxAQf11QGfP8a8CJDq0cHCgloBCOIuhvQK25gLOFsgR
         o68Fh3wqYS8AX7gifB+1Yw1OMNZeCpEredyOmjrorRubSPfMyODN/7NejxugBuQhSC8s
         XqKf19VEhYsV2SWPtiMgIXSSMGwpMUerCHIqvmmee5CCXwpwYCfkGwXwdPrMayj0RR8W
         NpFSGOKr04C5Pf2l/7MD9Oe4TREKNXHbsPSS6T9vZZgd30qcXoPP+ZLww6uvQraB3kPx
         zsf5ZGjhgoan2Uq0dDGIL45mfkBIztp4rbpHSpFE4CU5yO6LU3omf76oeTDwKQ2u+9ju
         e6Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EF4CqCaH+72kR/CPRBJuLPuudd8UhTvTI6Rhp3uNvFc=;
        b=Vgq08p7NSOP9GFw1nHHxFdSG8vkfoiiYt6OhK1OArvNTIC6MANpiPWmYOKsrmi6h4T
         dPurKPG7oYHfo6w43PZikzAqEuqPUKBjpS5iCJZufrPK2wzUNVRBD4gn7Wlntaj/wFJm
         sTveX/pXn8vNLogYCdIUi4OL6zJK1KeQU1CFR/zO7AFzIeb2yclZQXc7jAnCeR5k1eQi
         uT7+fJHLKX6K4302gCbGA1rLsuJp3SVCvvwKIbdD5QMOqljIMtiFIsoHIku9XG5ERQSA
         NefAN+Hisl/PfeIMGndAaWx94uT8tG8KARrVpdjYVGWqMaOYAF0hkBN/V/fn32FfliqX
         KI5g==
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
Subject: [PATCH 4.15 100/105] iio: imu: st_lsm6dsx: fix endianness in st_lsm6dsx_read_oneshot()
Date: Tue, 27 Mar 2018 18:28:20 +0200
Message-Id: <20180327162804.082521634@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109545391866602?=
X-GMAIL-MSGID: =?utf-8?q?1596109862366894944?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -448,7 +448,7 @@ static int st_lsm6dsx_read_oneshot(struc
 
 	st_lsm6dsx_sensor_disable(sensor);
 
-	*val = (s16)data;
+	*val = (s16)le16_to_cpu(data);
 
 	return IIO_VAL_INT;
 }
