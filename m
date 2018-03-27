Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48w7XyXUNR7806XsvMLS08hTVIn7lBopyoOJ2nk/u6gl8kmGPohDKDtHizMLWRgMFpUbTG+
ARC-Seal: i=1; a=rsa-sha256; t=1522168905; cv=none;
        d=google.com; s=arc-20160816;
        b=xyDaLFMhHdKal1ubttbEAh1f12JHidnCE/YdyHEt1v8LuuvIf+cmmYozP3bw9h6aY0
         4KY0inJsZW3ngm64NBwrij60Xcv1IVBBtyG4vfzlyxy+ioEkGCy6J+DHzoIy1ulCODPT
         oMOooipVbksR3ZzOsHTmQVgmAQVnAPB/hOHdp4cZnHVnak/Ox6IqxIqulKTB5m7WG7NV
         8BhbjxpkRn/oIb0EaO13Gb2BfjRNS8gsydVMlnqaAEIPrz7CFNS+uhtCp8aJ/5YlIF1m
         WZTln0ww4XvsEDg8ukrBOSlTdc2gAfxJA8gU+V9Rfmgqk61CI9T8yKg1DdUQ1f/D6D6p
         uydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ih0Zk1O6vwYTcm7AUhdhdwZOyBlBiPLWGEY0YukqtDs=;
        b=iur2/rn8MKGNy67/DRW1FAy0BHl4e/wmSFXcGKjic9TqfYdGebCys43lu8p7L16ZG1
         rLjFYvevzLgEdKT83UPFbgdQs0mgeCTcqb+DtaG6ftIsGm65UazjOCMfUJrlILYh+hgz
         o0MkgyJ7ENqC8gBzCSpQRsX7PH+fn2C3syR6SmBgIBl1V4JlIu5z9NgCTj4qr74+pQ0u
         dDoOdqsqB/2kPoodBRkkPyFJ8AsP3TG+l27U+Y3modWvmcCeGm7TgWqKKheh41MuKUoO
         Xi12DVTn/KjyTHl6AlgbSSslnYztRO8klQYgpvf0ELlTUWmhBtQs5lAuqf56zCL6Gs+I
         2zOw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Park Ju Hyung <qkrwngud825@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.15 039/105] libata: Enable queued TRIM for Samsung SSD 860
Date: Tue, 27 Mar 2018 18:27:19 +0200
Message-Id: <20180327162759.687986732@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108977196194202?=
X-GMAIL-MSGID: =?utf-8?q?1596109782294172963?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ju Hyung Park <qkrwngud825@gmail.com>

commit ca6bfcb2f6d9deab3924bf901e73622a94900473 upstream.

Samsung explicitly states that queued TRIM is supported for Linux with
860 PRO and 860 EVO.

Make the previous blacklist to cover only 840 and 850 series.

Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-core.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4549,7 +4549,9 @@ static const struct ata_blacklist_entry
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Crucial_CT*MX100*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
-	{ "Samsung SSD 8*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+	{ "Samsung SSD 840*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "Samsung SSD 850*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "FCCT*M500*",			NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
