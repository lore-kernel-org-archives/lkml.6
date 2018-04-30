Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZruiW3Ud2fFVMyk5mK4zkxp89AY8SVB0g2FlvpxhY4yoXUyMq+Krl9M/6Htd7ISHEE2Ipsn
ARC-Seal: i=1; a=rsa-sha256; t=1525116482; cv=none;
        d=google.com; s=arc-20160816;
        b=qrL7qucnf4XNqsNJvR7eS+ssYaOr6dcJ8HnK9fOQ1CbbkcLx5Ocj4MtZQ5I5Qi0e8k
         qLThVDtgC5ZTr/I4PAthlSf+4eKrjQeVmZxH5AWVpJOYgbshT6H/4sbgGWOYU+ryuI3T
         J92j45A9mWYgrx4HVJANWJRvNxtL+2Zn56qNZsYw0Qov17OD8m8Eo00doIFN8J1FQ8Nt
         Q8zfA7rE5KKJeur5bsKKd2YeQ4NiZhlCQT5MbPA2xsL+qVfKY3gAxxPC2Th+VETxtLVA
         gceh1aE+zspXE+DSjFck8GNG9pfRTL25bgiR7Sq2pMVd8MPlue9kIkQ1NvB4LCixECwI
         nWIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=DXmLEwqcm3602wV4OVpIlUmzF5ozFjrM6jAnFTnRmCc=;
        b=0yIVLAzv/WfVX+lruD6E6DUt6FVo9xfMIsks3CmvFE0XtdmMr8PcSS6f4jpeSUT6jj
         dUV5PW/gVXEcz07VrOxhy7wDekDbhY8+8f1/8DXajnQWvAGVuR4HNcwV8CxKd/eFGuej
         FPjOm9GKnjnKHG/OkdIkzB3vKk35X4ARN55CMD118jwz7MVkE+CLlPDevNvU1xMPaIWm
         FPNeIJQ8dFq5j+fXEEWNN55njDTSfl85/HGImhvaxUaoIKV8ASzGSdooOY9OEl2aO+uV
         VWSi2+m3ZfaxxgTgMWR/ccgnjwBUxyzkhxl3ORVZU9SmeRtBSF3OxonUPTWpfgsz9a8F
         40BQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2607022DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4.16 024/113] virtio: add ability to iterate over vqs
Date: Mon, 30 Apr 2018 12:23:55 -0700
Message-Id: <20180430184016.096303975@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200278542184373?=
X-GMAIL-MSGID: =?utf-8?q?1599200540993654077?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
