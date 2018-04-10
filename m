Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/BxOrIINHmzc7VhCI8NVx/vB+nKoS/3XnfacMSj4uEGHlrHT+cjtuvL0BOQM5HpN2RBAQp
ARC-Seal: i=1; a=rsa-sha256; t=1523399828; cv=none;
        d=google.com; s=arc-20160816;
        b=U3CdxrCO/+hnrxCIYzMMEHEnB+C9VAdlOscABRSYmE6FtK5ZrVoVtHrIPFGNxNzw7r
         T/rpvZKw4N0pxeD5rZTpsduKdVlHWzS1a0QpD49cRKv+uGsxJ5SCvc7cDfjknamX3D9o
         dE084mLSA7cDd6cFQXGXDSXwaAw2KF0kUJPv50sPTUnpiOOTa3Mrddat3qx5bCebKMw+
         CMtttVGUUhwWg0cwWYuJc+upFY3C4Z/pNh+AmsDmhj9ELcC1MjhyxhXy7NyAsL23MRwW
         xI8VGX0dO7qnwcFS7MqDzgdsY+b9sbyMT3SQZJcKjrneopsrrrEVx7sh+/fbAwaNvwPW
         uybA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=K76yLd3ndQiBu4oLHvBiOkVA2zhw+Z6nXW2sgM/daUY=;
        b=IAD3Nz7R6XcPpBRs69AGc7M5c/IDDp9qB0UiliVRYE4fZ10GPHMDHEAEFEsvbGM3Bf
         Q7YkiYCWRqF1Ofa4iyOdSDwo6mErXMIg7ZsRoYgno3qU6sVj/eHs60LDmAkp9G5Rh7Cz
         3paq03EPi93pcYsnKIWI+ZtlCS+Qw1q48Jyh4dFBsEuFrYoFJIXLP1F+ohaEUZq85r2m
         nbI6PQoa2eEpg0of82s/6hyS7SWg+vpf6U5nF5ddD36aqNEy83miA1kdlj0bwhpiC2BK
         iVdubXv+FxqFxbA+DWsza1Tf+fQKjZzEAueYRL4sM9mgxLaQiRb3ZU6MlDFVX9LNJueu
         I9rQ==
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
Subject: [PATCH 4.14 078/138] mtd: mtd_oobtest: Handle bitflips during reads
Date: Wed, 11 Apr 2018 00:24:28 +0200
Message-Id: <20180410212911.198142284@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400125818326923?=
X-GMAIL-MSGID: =?utf-8?q?1597400498848617005?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
