Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrThBsVhhjN9HSGL2uuPkAa5EJtn7UKG5aqxotWVy3GQDJJCqWso471aSI4NB4fchkh343M
ARC-Seal: i=1; a=rsa-sha256; t=1525116423; cv=none;
        d=google.com; s=arc-20160816;
        b=VswBNqsEBhLh4TsuQBta/EZnnl7eGrcKzvSisGc5y6mUG5sJCm3R7h7QoxnkDSARPt
         OZ4zUH3Ewh6w4i/3Y75xJGrtjFDb7IGfCP8We2ay8zJd57zWfPKzKUSE+U653B1RvTJ2
         0fsOY84y4Oz/VKLHpTbNEbO14rEr7Y3/5CheXr26n5yIoTRG50iOTmo993Lwbrm49oC5
         jBnACsqKaFZyh14Lp4HTEKWT6J5RaDdAtE7vdjFZpHqOa3DijczMOc9i4pP2TgBTyHDt
         kkfwjcVu0Agr0PNGStb1UjW5Qc2GyvXVQaSWV1BWs3lMXjXZ1UCUtF+WnWAXKYBl9kCa
         ZKtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=ERtOmHMNwXqfZbRkV3PII5qylkUNGwRwzSJ/Bd0Nqjc=;
        b=q+emBCQLD0TFna56fMSfi/y+jQzbzO+aozx8C98y5uINk0RaNBaZw759a7ZpXC3tHL
         WJIjnpz7Cxw8ujLh02fuy5aNu5nsNJQU2+Zrut3ybqndMdSogGBYryO+RD40Fscx8lDP
         5+6J440P+gFDuqDR/QfnoiLMLEUdP7c55w4AItIptfHqRwi8iJH6iWlZGY72PkIOJs0c
         KQoX5onbsEgd0wnfU7VgIMlWRb6GKOrYI+6r5KCUVx+jmfQMDfu2qbo8yFLuawzplXS2
         8e3sDC2bAx7qjOkMdExZPEhDraRo8SQe5XeLbwKmNeN9uP/0YViY/VhpHb1h9qtFEORf
         Sovw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455A022DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4.14 22/91] virtio: add ability to iterate over vqs
Date: Mon, 30 Apr 2018 12:24:04 -0700
Message-Id: <20180430184005.367272127@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200278542184373?=
X-GMAIL-MSGID: =?utf-8?q?1599200479353702772?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael S. Tsirkin <mst@redhat.com>

commit 24a7e4d20783c0514850f24a5c41ede46ab058f0 upstream.

For cleanup it's helpful to be able to simply scan all vqs and discard
all data. Add an iterator to do that.

Cc: stable@vger.kernel.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/virtio.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -157,6 +157,9 @@ int virtio_device_freeze(struct virtio_d
 int virtio_device_restore(struct virtio_device *dev);
 #endif
 
+#define virtio_device_for_each_vq(vdev, vq) \
+	list_for_each_entry(vq, &vdev->vqs, list)
+
 /**
  * virtio_driver - operations for a virtio I/O driver
  * @driver: underlying device driver (populate name and owner).
