Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+UCrsw7yKbcm8bfdF3QZqG58c09uNI+/ET4ViBaben7efL5gJhRmTusaG7VuNCnU7AQpXS
ARC-Seal: i=1; a=rsa-sha256; t=1522168897; cv=none;
        d=google.com; s=arc-20160816;
        b=efiWdOv3jZY7oO7O+v3/L0OJhV9jKX6cAnYgYkudZbwdSS2cert2ntvZTUWYi17p1E
         69EczkQx45DHJTOKbusm1QPZ5a3bRFs8yoJ8gvqsvPbDmSp215kAMKJ1fIMeP9J68hk+
         UYG2ZJon/k0yq//AnqeJIkRwR7fRe9/6RHJ9N/B35HRfe48ABFL4YgHBnysaeuFOxuV7
         tt2rGX//5H1/C0M2jaIPZVbBc1uHoiOdEmM77fwgwsiF0O97BpPXKoA86WHF3BcLM2W5
         8Q6FzyBBGp7d6nodki7fSn2NGe9RyyuKXpakHQsYfgINEeKQVSCFMkCCdvA9iAiNvuy7
         t5Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5bfJzpgMDJemkyco9b8GyBdrzwwhG2SUQNKW2NjFP4Q=;
        b=FHvc9XsYSRXnDhkZi8EWUdDJMsQ8VKYvEcnIjYah9E9R419BzWlNJUbc6LkKVLs02D
         1r6lpyoefU/9f+MPRVg5xDL6dO2e1EyDALglKQmRcJi7UXCQAZbq+Eiogx96W/g+4ctb
         oizuZZKH/xKV3g8ltNS2h4Hajubar+/ji7GLRaAGgY/vD/gj1nBOVRJ2Q9gUThMTqNhs
         7Zig/+A8WsFEhXxVqOrB2i4tq2d9kC7GAxlLVOo5NKLLlzmd1KQV1Dlb3InLgVtXYD7H
         REYqhqAjcoHlNuE42d4DlE2Zm0OYvH98d/z3Gp1Z+MRrplHwsh24nI3c6T2PhJ0ATmEZ
         K7Mw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	OuYang ZhiZhong <ouyzz@yealink.com>,
	Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.15 070/105] mtdchar: fix usage of mtd_ooblayout_ecc()
Date: Tue, 27 Mar 2018 18:27:50 +0200
Message-Id: <20180327162802.278281258@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109173619457635?=
X-GMAIL-MSGID: =?utf-8?q?1596109773574800638?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: OuYang ZhiZhong <ouyzz@yealink.com>

commit 6de564939e14327148e31ddcf769e34105176447 upstream.

Section was not properly computed. The value of OOB region definition is
always ECC section 0 information in the OOB area, but we want to get all
the ECC bytes information, so we should call
mtd_ooblayout_ecc(mtd, section++, &oobregion) until it returns -ERANGE.

Fixes: c2b78452a9db ("mtd: use mtd_ooblayout_xxx() helpers where appropriate")
Cc: <stable@vger.kernel.org>
Signed-off-by: OuYang ZhiZhong <ouyzz@yealink.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/mtdchar.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -479,7 +479,7 @@ static int shrink_ecclayout(struct mtd_i
 	for (i = 0; i < MTD_MAX_ECCPOS_ENTRIES;) {
 		u32 eccpos;
 
-		ret = mtd_ooblayout_ecc(mtd, section, &oobregion);
+		ret = mtd_ooblayout_ecc(mtd, section++, &oobregion);
 		if (ret < 0) {
 			if (ret != -ERANGE)
 				return ret;
@@ -526,7 +526,7 @@ static int get_oobinfo(struct mtd_info *
 	for (i = 0; i < ARRAY_SIZE(to->eccpos);) {
 		u32 eccpos;
 
-		ret = mtd_ooblayout_ecc(mtd, section, &oobregion);
+		ret = mtd_ooblayout_ecc(mtd, section++, &oobregion);
 		if (ret < 0) {
 			if (ret != -ERANGE)
 				return ret;
