Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsWB2+uSX4EOH3IGObwRWs7rPXPipSUCXbEOT8at0TtcftEYHc+r9RzlZj6nzRvD+lGuc92
ARC-Seal: i=1; a=rsa-sha256; t=1519410992; cv=none;
        d=google.com; s=arc-20160816;
        b=jCf+5ytegK6crOxHX436xzxDXaTyn7peQQmmeaXIx0+mxYcFf2cZTOBvcR4btZqPJE
         1VpkSPByzc1HYrknO8/40khBUhfbOcSo1mRolc6VpnyOgd7VTu3AY5S+qYJKeYExaz4M
         N0OZtu7KbT1C8x3WPUjgovfs1KlqTfbkOELaHhw8WNHWedZHNSCbfkyWqQpRTWCYnFEb
         IiCjQpAi/RLfS3JuGELfHpPJKZ7xScxYYq63Eq1bxhXbnw1/X5RPUQ59C1EZwz2m8ddo
         gPSQopv2sHEL8hh56wZJYbJLG+qM+1/4Keyt2UKciuxEZCjGyVn6oLbfTajf441Ghyov
         e6zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=b0f0i90u14GTMsRvMWhlVC59VE18XXwSbx4k2N1hAEs=;
        b=qorQP/xB7C6/oXaBl3MKKdZ2duBkzTWKaTeGJh+O2HqUtSMETyCq+WIPRDTT6yF+od
         8YPlSl9MPg7cqcbjNAF9a39RYqaRsEQBT6gpUdsWvKkbTs/UHERNmFAi1clqqjUts6i3
         VS/IE+6D8Q+7uGQqz+Bz/aISxCwybW/g0GM2ef/A9CTsYLPjTVUmnzj11QL1qOc/XjV9
         IbPQ23P2qoE00cGiKr7nOVHvuT/FlBzsE6WEgjCmvb0ZTM+92j4UHVwDlOSQpEAYcQ/9
         sqTe/F5wn4wTvB7aQgBAn1Fn3anhyqlInkUpCx/g9nrMh8CnTbu5kn9buTwp5BvwlWT1
         NbTg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sudip Mukherjee <sudip@vectorindia.org>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.4 084/193] scsi: sim710: fix build warning
Date: Fri, 23 Feb 2018 19:25:17 +0100
Message-Id: <20180223170339.216157820@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217901064285175?=
X-GMAIL-MSGID: =?utf-8?q?1593217901064285175?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

commit 648a0a7da34f281410e8e3a59de8c13ec6ea380a upstream.

We are getting build warning about:
 "Section mismatch in reference from the variable sim710_eisa_driver to
 the function .init.text:sim710_eisa_probe()
 The variable sim710_eisa_driver references the function __init
 sim710_eisa_probe()"

sim710_eisa_probe() was having __init but that was being referenced from
sim710_eisa_driver.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/sim710.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/scsi/sim710.c
+++ b/drivers/scsi/sim710.c
@@ -176,8 +176,7 @@ static struct eisa_device_id sim710_eisa
 };
 MODULE_DEVICE_TABLE(eisa, sim710_eisa_ids);
 
-static __init int
-sim710_eisa_probe(struct device *dev)
+static int sim710_eisa_probe(struct device *dev)
 {
 	struct eisa_device *edev = to_eisa_device(dev);
 	unsigned long io_addr = edev->base_addr;
