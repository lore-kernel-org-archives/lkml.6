Return-Path: <dan.carpenter@oracle.com>
X-Google-Smtp-Source: AH8x224M+vyk9qCSRowFYEBQLDo8k1p92f7JIBOw7/tDfxl392+M53eqjfYbAKfbNQ7TQtxudCRA
ARC-Seal: i=1; a=rsa-sha256; t=1518074738; cv=none;
        d=google.com; s=arc-20160816;
        b=Sbc00ksoceTy12taEQwdxN1bF++0XONYAh4ZbpBO+vfHT+IZl5Mno9cFKxCSHVazjS
         A5Zn++St4RAefs2++QTow6UVBVDHc//6/QN03QWvM78niBtXx985UtZvYW5WI7MHJgjs
         YLNMeOhpAsIoqsmLPAekc5Jacl+IHvJrWj/I6Ni4NP/e+SI6O7CrlYhb1j8sSigOovcF
         I6rZtFbcOA8peIHb8UXgmKcWoCQuxNg6Qh0jo+ukvR4XU22oZcbuzlAbr6Qd75B4E/yI
         H8uoiOQ+SrhZp2HyvrfNFvmPEcu75GNigXtebLloVxODYReHqdXKSbeU2YVSUg3CyTMW
         eExg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:message-id
         :subject:cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=6mFzCh3KVdbvFuqMP/yr0oJOfg9Z4UQZYHgc9jATRB4=;
        b=bm8OKWhdhrtO2JcYBSqig6cgSXld7TqZr935FKj1FbJSFP9QADExd1iDuPfVuaEdhy
         Cbjpea5+IV2QD+DXplJ/eW3qVi5aTR/1aT0RRxRldBcX6Wrzu++fmydYrgnd+MEdH66P
         sCUqX9UFgsU6DgfgFfwZKqRfrBilk4xIQ8OYsg/234TmnDiuU6rXEbPZDQhrHgUE4mP4
         oHDJJ6aTY7Fc+EqHD8xvU0jfb+Zu+8nHxHLJ56mar9gLWJmOsOgGcusmEiEKYCVET/MH
         I032DJOII6hoSnF9nOU5ksJ0Likucm3ay86xvQ+ZQHxRN4qR1HXQPru8YepU+lwRQbcF
         pZ4g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=DFcBoENX;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=DFcBoENX;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Thu, 8 Feb 2018 10:25:28 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Mark Brown <broonie@kernel.org>, Markus Pargmann <mpa@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] regmap-i2c: Off by one in
 regmap_i2c_smbus_i2c_read/write()
Message-ID: <20180208072528.GB18158@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208072344.GA18158@mwanda>
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8798 signatures=668663
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802080078
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591816737545967751?=
X-GMAIL-MSGID: =?utf-8?q?1591816737545967751?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The commit message says that we are allowed to read and write up to 32
bytes but the code only allows us to write 31 bytes.  In other words,
the ">=" should be changed to ">".  But this is already checked in
regmap_raw_read()/write() so we can just remove the if statemetents.

Fixes: 29332534e2b6 ("regmap-i2c: Add smbus i2c block support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Not tested.

diff --git a/drivers/base/regmap/regmap-i2c.c b/drivers/base/regmap/regmap-i2c.c
index 4735318f4268..056acde5e7d3 100644
--- a/drivers/base/regmap/regmap-i2c.c
+++ b/drivers/base/regmap/regmap-i2c.c
@@ -217,8 +217,6 @@ static int regmap_i2c_smbus_i2c_write(void *context, const void *data,
 
 	if (count < 1)
 		return -EINVAL;
-	if (count >= I2C_SMBUS_BLOCK_MAX)
-		return -E2BIG;
 
 	--count;
 	return i2c_smbus_write_i2c_block_data(i2c, ((u8 *)data)[0], count,
@@ -235,8 +233,6 @@ static int regmap_i2c_smbus_i2c_read(void *context, const void *reg,
 
 	if (reg_size != 1 || val_size < 1)
 		return -EINVAL;
-	if (val_size >= I2C_SMBUS_BLOCK_MAX)
-		return -E2BIG;
 
 	ret = i2c_smbus_read_i2c_block_data(i2c, ((u8 *)reg)[0], val_size, val);
 	if (ret == val_size)
