Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49M+9q2tkCL60alaL68is7Xvs8/8Y0G2sG+3qzepUpre2VS1CYM4shSDa/s1gys8BSUOaMl
ARC-Seal: i=1; a=rsa-sha256; t=1523021868; cv=none;
        d=google.com; s=arc-20160816;
        b=hA4FgGKDGKRadTUu7iVHVnakpLNJO3+tWljLdotP/Q5aFm4P0eYSFM5H6FIHBwqSLe
         RdOmbr5tMHQ3ZGdTP2wNY7VyM4TifZVCukRt7K9anTeVut/aKUbYs4qxJLbOJ5N+fqGL
         ju31fZHAeoI6IuGTm2q9VTHAG8GLGB3v9ttqjLwMy7ZL+qWgQF1CALACXFdIeGbAWWkD
         YCiTrTNhsuOC1gmqGFk2Rq8o2kUGUq7XeBcE4A89eRzmfJOsaxo1kWYTRC5gMi0wvsyf
         iwuFe9ez4KCjsbqRURLAUZOubMwF/A42ae8FVC74HyyilmsvHg0bqN5O6BXR35h8SAr/
         PA3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=D2lHHchk3LmwELJf3DYBpTe5SdBfwOJ63GTdsRGDC5M=;
        b=nC5b3+rjJGOILdcTTRTaGWC5n4j4suqiWs4GtT0CipZvVvRyonJUIGboInpgSdM8MG
         373KMlcb+v2y1JzReSEhJ2O1xFB5uf5MPlR9UZsiewHL/M5aHjNMd12Xv0ztcnKCXcVx
         6WLiN5aXQB0p4FSX7Xsb7L+Yib33HTv4d4dyotcQcqVHXq5jy8AYJ03VIXvuxR9XaY97
         StCgI9cVp6QZ5f51eLDGkRi4G13vJvrLVhw2Zvjyz4p44J7R98UjJNz+xoAyk4o6Zov9
         exDaGaDYyejey1lW2/dUHjyvHUFm77RjvLwg45w575YSCmnHzu8z4AX2jjitjYlv/Xpt
         /ofw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Richard Narron <comet.berkeley@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 17/67] partitions/msdos: Unable to mount UFS 44bsd partitions
Date: Fri,  6 Apr 2018 15:23:47 +0200
Message-Id: <20180406084343.621695172@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003471959644591?=
X-GMAIL-MSGID: =?utf-8?q?1597004178646549497?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Narron <comet.berkeley@gmail.com>

commit 5f15684bd5e5ef39d4337988864fec8012471dda upstream.

UFS partitions from newer versions of FreeBSD 10 and 11 use relative
addressing for their subpartitions. But older versions of FreeBSD still
use absolute addressing just like OpenBSD and NetBSD.

Instead of simply testing for a FreeBSD partition, the code needs to
also test if the starting offset of the C subpartition is zero.

https://bugzilla.kernel.org/show_bug.cgi?id=197733

Signed-off-by: Richard Narron <comet.berkeley@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/partitions/msdos.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/block/partitions/msdos.c
+++ b/block/partitions/msdos.c
@@ -301,7 +301,9 @@ static void parse_bsd(struct parsed_part
 			continue;
 		bsd_start = le32_to_cpu(p->p_offset);
 		bsd_size = le32_to_cpu(p->p_size);
-		if (memcmp(flavour, "bsd\0", 4) == 0)
+		/* FreeBSD has relative offset if C partition offset is zero */
+		if (memcmp(flavour, "bsd\0", 4) == 0 &&
+		    le32_to_cpu(l->d_partitions[2].p_offset) == 0)
 			bsd_start += offset;
 		if (offset == bsd_start && size == bsd_size)
 			/* full parent partition, we have it already */
