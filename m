Return-Path: <dan.carpenter@oracle.com>
X-Google-Smtp-Source: AH8x224e+rma8RThOFjonJ+8zSdMgJj0if+3g0WUxTr6eaPvBY51hizgW+KX7Xz4K5nxFJ1IgHW3
ARC-Seal: i=1; a=rsa-sha256; t=1518074636; cv=none;
        d=google.com; s=arc-20160816;
        b=TZ8fIvSg2hoABLsag5fI8ckurHk4tqpN8q1rwWgD28ZGMH8rfE1Tp+j8yACbTFx/Ke
         sP9J9QrNrGdug6+pRE2Lyj5cYvC1fVUnpNBdvSmIxlV9fhf2sYouBdvyBL3WRUI7NYNX
         m7+OZ4IHrb1mBGQ7jm4KY2RVprryjTtonyCwNe++pBtsNofK3lK619NxTXTqXBodWTg0
         uohlzZqts3sWHgUEOBFz+76tQT3Jv8m2H7rOJCRy03/Hapv57HmjZGEB64+FEt9DYgZj
         dlziuNU1CDKdaGefGT/787h2RMbDBqsai1ZwHAEpP72izXsbrLrxtGYA/sPBvk0Yr84i
         m62g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=O85CdhTh6RmbphZFnMe9lIWUeFr+e41vH+eAn04FJpg=;
        b=du+iZeYclIssZXI2gVzzf0hmMH1oQk4UKy71r9HoMG06luBePGkalPOsJT+emznWWC
         5ivsfevfz9EkNqIylv6hg4ajVu5X+bPFbRfd7ID1XPN/HJuK4VOrrxGAypIL0pIZSmrQ
         6EYmCQaucy81i+tQ+lpeG6tvkIX/USXgsizboPKEShAoxN2dFoRoxV6uiqoRWju3fSsM
         YPw+OmMBrDR4Up9h/cvwf1cwm/dZsim0Y2H5zR+AyhjWemuWGA5tG7PZB6f+lvpNtTan
         Q/e+raM9efxo9nyQwl1xgHMvKo0OyXbx+on/DS4z7H0mnHM2EoOpoxFYQ2M+Xld2fZar
         750w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=fZ3aFIVS;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=fZ3aFIVS;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Thu, 8 Feb 2018 10:23:44 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Mark Brown <broonie@kernel.org>, Markus Pargmann <mpa@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] regmap: Fix reversed bounds check in regmap_raw_write()
Message-ID: <20180208072344.GA18158@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8798 signatures=668663
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802080078
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591816629664005749?=
X-GMAIL-MSGID: =?utf-8?q?1591816629664005749?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We're supposed to be checking that "val_len" is not too large but
instead we check if it is smaller than the max.

The only function affected would be regmap_i2c_smbus_i2c_write() in
drivers/base/regmap/regmap-i2c.c.  Strangely that function has its own
limit check which returns an error if (count >= I2C_SMBUS_BLOCK_MAX) so
it doesn't look like it has ever been able to do anything except return
an error.

Fixes: c335931ed9d2 ("regmap: Add raw_write/read checks for max_raw_write/read sizes")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This is from code review.  I can't test it.

Is it possible that there are other ways to reach
regmap_i2c_smbus_i2c_write() without going through regmap_raw_write()?
In that case, the temptation would be to just remove this check and the
one in regmap_raw_read().

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index ee302ccdfbc8..453116fd4362 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1831,7 +1831,7 @@ int regmap_raw_write(struct regmap *map, unsigned int reg,
 		return -EINVAL;
 	if (val_len % map->format.val_bytes)
 		return -EINVAL;
-	if (map->max_raw_write && map->max_raw_write > val_len)
+	if (map->max_raw_write && map->max_raw_write < val_len)
 		return -E2BIG;
 
 	map->lock(map->lock_arg);
