Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49/ZdRmi7kX3QOBz5nBEdJfHaMwqGJYPhBi9v1m7I0vduStPhFZ3Ndls62m9gEyQkvbD5mm
ARC-Seal: i=1; a=rsa-sha256; t=1523473467; cv=none;
        d=google.com; s=arc-20160816;
        b=q6dlz9rYXTCnqig4+m09c+jvI+2AGFd+6+8vgfzu+TB8TmH99/BDS0xqfNnv+kDBsq
         uKLyaLyVBIr8wS0wkMc9vYqRTqbp56Gzq36K75msSZyezQIuhHOFUp44Ft/KReqxHT3h
         GAwmjSpboqM+YQZ1H50TABYJjXFEy7x5WyCkJOj/FhKt9p0ox9nRR+ZrWtF5jO5sFWMp
         pXEP4lbdxqz8/QF6mqHRJJThpsNPX0Wz754+75foaQQyiqp86/U2gb9hgrKErTjdbHLj
         oBuF6mT0P12sQaYeqb+oned5duuzYilRaX5yuCUD1Uv24fcVqwSvdvyixscIEqup3R5Z
         3LUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FML9TpZp2uYDYw5OZenRNqdcYHaeJekBxnxTuU+8kVg=;
        b=s/oRasr98sUsfE1sAd77L3lQCEfb/PrCh+r43l5s5hiEae+BgUGX7JB4Tas5W/5aT4
         e7NWjpKXFGNCfiWzS4lGkY+rqubXROmTIOnIW/bhqHGpWA5WLxBYsRLXvu8j6mBqszig
         DG8W2T9adKQQbyoZeJVyaWwYD0BCndVbzqxgBx3rlF/gMLt3apUjCB+yKsryx62bOJiI
         8PJaZo00unHOLL4MWOtwj7RedLQXIxn6jzxVXPDifBxdX2nYRfdegqixd2TnNlohtngl
         bJsYGfJo+avQqBkt+sU2LAj8OalLhLtmLaXdED3r3jSFP1v6uIsxRsvleOatMC/A1WeM
         qvqA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jason Yan <yanaijie@huawei.com>,
	John Garry <john.garry@huawei.com>,
	chenqilin <chenqilin2@huawei.com>,
	chenxiang <chenxiang66@hisilicon.com>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 259/310] scsi: libsas: fix memory leak in sas_smp_get_phy_events()
Date: Wed, 11 Apr 2018 20:36:38 +0200
Message-Id: <20180411183633.751243928@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476394956038418?=
X-GMAIL-MSGID: =?utf-8?q?1597477714190865200?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Yan <yanaijie@huawei.com>


[ Upstream commit 4a491b1ab11ca0556d2fda1ff1301e862a2d44c4 ]

We've got a memory leak with the following producer:

while true;
do cat /sys/class/sas_phy/phy-1:0:12/invalid_dword_count >/dev/null;
done

The buffer req is allocated and not freed after we return. Fix it.

Fixes: 2908d778ab3e ("[SCSI] aic94xx: new driver")
Signed-off-by: Jason Yan <yanaijie@huawei.com>
CC: John Garry <john.garry@huawei.com>
CC: chenqilin <chenqilin2@huawei.com>
CC: chenxiang <chenxiang66@hisilicon.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/libsas/sas_expander.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -684,6 +684,7 @@ int sas_smp_get_phy_events(struct sas_ph
 	phy->phy_reset_problem_count = scsi_to_u32(&resp[24]);
 
  out:
+	kfree(req);
 	kfree(resp);
 	return res;
 
