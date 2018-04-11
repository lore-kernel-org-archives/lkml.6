Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx499RNXDH/2xp34Fsy8m827Y4juddndhbBzI6xpP6mN6xnyqDqldT3Knc8puFPQbfUvPmY6L
ARC-Seal: i=1; a=rsa-sha256; t=1523473494; cv=none;
        d=google.com; s=arc-20160816;
        b=lQDmS2Ljj/Fy/0vK7et2jjsPqiGKA7n2XgnigT/BHx2EIqk2GG0eHlc+KRN7BXx8Bw
         T4rSNeMj369qMVyZzyBKONaDYzZX9H2xvM8B+b4GGnHL5vNEK858AZIa9Og0bkrhX0t7
         FKBdaivUBgT07b/L2A83PrZ0OL32CfKa84OXGX1KF2HQjNkRnjwTcZn/Jqb4T9yu7Xqu
         p4PHd7LwBRC+drXAhEaksFa2U/OWWj1knCNvNDf3oGXd8npES5mxDzyNMA0hYtN22kQT
         k3bLcc8eftOyCmP6gvi4bbIBIf85iEcXSUITPy69v078NMLN8aFzH0w7VpELo/L6UKJC
         29tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=P488JksD0DhqI89FSbxWoft9hE1NhkHIZu3HmygmRn4=;
        b=nOVTDm5rFYJStUhTJxlXHkhGkIkpUTHuFdLFrW5RAOK60lglP2ds3vVpwu5lRo8peE
         NEtX0D0I6zlZ2okuoEFQcX2l314NX3D6ci4TIhQa4kiTX2wqlHF7tdUIVvF7M/kqOHCi
         96KaKnOjjvsJFImR/JeoKhefpT+j/90a3DPy8qZNKQFWPdwqzTsHsBBDYdjz7Rb8UjYJ
         CnpCiDZVV8f8wjj2ot5iC6EXSN3larUpuuk6A9xnTeuy+q18Weg1o6iKlsUoPEN3T2Um
         zNo4OMsyc8XsLM6NfCxc2tuk2uIbfXs5Ma49QzlOr2u8poKdvBBLpTsdM4FlJ5Q28tMS
         vEGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Miquel Raynal <miquel.raynal@free-electrons.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 268/310] mtd: mtd_oobtest: Handle bitflips during reads
Date: Wed, 11 Apr 2018 20:36:47 +0200
Message-Id: <20180411183634.179579250@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477743166211618?=
X-GMAIL-MSGID: =?utf-8?q?1597477743166211618?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miquel Raynal <miquel.raynal@free-electrons.com>


[ Upstream commit 12663b442e5ac5aa3d6097cd3f287c71ba46d26e ]

Reads from NAND devices usually trigger bitflips, this is an expected
behavior. While bitflips are under a given threshold, the MTD core
returns 0. However, when the number of corrected bitflips is above this
same threshold, -EUCLEAN is returned to inform the upper layer that this
block is slightly dying and soon the ECC engine will be overtaken so
actions should be taken to move the data out of it.

This particular condition should not be treated like an error and the
test should continue.

Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/tests/oobtest.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- a/drivers/mtd/tests/oobtest.c
+++ b/drivers/mtd/tests/oobtest.c
@@ -193,6 +193,9 @@ static int verify_eraseblock(int ebnum)
 		ops.datbuf    = NULL;
 		ops.oobbuf    = readbuf;
 		err = mtd_read_oob(mtd, addr, &ops);
+		if (mtd_is_bitflip(err))
+			err = 0;
+
 		if (err || ops.oobretlen != use_len) {
 			pr_err("error: readoob failed at %#llx\n",
 			       (long long)addr);
@@ -227,6 +230,9 @@ static int verify_eraseblock(int ebnum)
 			ops.datbuf    = NULL;
 			ops.oobbuf    = readbuf;
 			err = mtd_read_oob(mtd, addr, &ops);
+			if (mtd_is_bitflip(err))
+				err = 0;
+
 			if (err || ops.oobretlen != mtd->oobavail) {
 				pr_err("error: readoob failed at %#llx\n",
 						(long long)addr);
@@ -286,6 +292,9 @@ static int verify_eraseblock_in_one_go(i
 
 	/* read entire block's OOB at one go */
 	err = mtd_read_oob(mtd, addr, &ops);
+	if (mtd_is_bitflip(err))
+		err = 0;
+
 	if (err || ops.oobretlen != len) {
 		pr_err("error: readoob failed at %#llx\n",
 		       (long long)addr);
@@ -527,6 +536,9 @@ static int __init mtd_oobtest_init(void)
 	pr_info("attempting to start read past end of OOB\n");
 	pr_info("an error is expected...\n");
 	err = mtd_read_oob(mtd, addr0, &ops);
+	if (mtd_is_bitflip(err))
+		err = 0;
+
 	if (err) {
 		pr_info("error occurred as expected\n");
 		err = 0;
@@ -571,6 +583,9 @@ static int __init mtd_oobtest_init(void)
 		pr_info("attempting to read past end of device\n");
 		pr_info("an error is expected...\n");
 		err = mtd_read_oob(mtd, mtd->size - mtd->writesize, &ops);
+		if (mtd_is_bitflip(err))
+			err = 0;
+
 		if (err) {
 			pr_info("error occurred as expected\n");
 			err = 0;
@@ -615,6 +630,9 @@ static int __init mtd_oobtest_init(void)
 		pr_info("attempting to read past end of device\n");
 		pr_info("an error is expected...\n");
 		err = mtd_read_oob(mtd, mtd->size - mtd->writesize, &ops);
+		if (mtd_is_bitflip(err))
+			err = 0;
+
 		if (err) {
 			pr_info("error occurred as expected\n");
 			err = 0;
@@ -684,6 +702,9 @@ static int __init mtd_oobtest_init(void)
 		ops.datbuf    = NULL;
 		ops.oobbuf    = readbuf;
 		err = mtd_read_oob(mtd, addr, &ops);
+		if (mtd_is_bitflip(err))
+			err = 0;
+
 		if (err)
 			goto out;
 		if (memcmpshow(addr, readbuf, writebuf,
