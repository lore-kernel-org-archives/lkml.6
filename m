Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+fGo2cE37IbcKZkmeaFQnzzJBIfi3+ezjMC3wiVWDn7Q7hMA0SMfH8oFaEM4vQfPLrUdqa
ARC-Seal: i=1; a=rsa-sha256; t=1524406645; cv=none;
        d=google.com; s=arc-20160816;
        b=taFvilvOZSk97+s6rIFAPKI4Dcsz7oMdPNubYmOUwgoQdbly5ari3VpMiCBjWWkXR5
         T/JhYPJO3ONorBXvYnn2pyC9GXc7LSS2ZhR8lIlTpcYLjVgh59Qx4QjdlvDmaJmenr8m
         RAWTya7Py3hy7Ck4btKL3QxfGbO3S/YrP6KBOq5AviiOQjONcWK+67/aPvr9/dc+qKYX
         rUTxbB1+LjkB0i9N118qtl00pVPLbEUdar/+QSjBe5H86RLnNeQZFmD0E9ZY+DdMB8KA
         8OAscm8/AStZjpfpLJ4EbLaUg+8Qe81aTmVhMHYGuOKehwhDHGYglzp5vLOOZakYJDlS
         WD3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/XWvsGxuoFNoAai+Kg3VzLuu4Zklwxib8NhDfFg3Mpk=;
        b=dH/1Q40IerJBZP2+qNbJ5q0Yf4560mrorjGliJA5Xh+1/NftAp2wzeJl8xTiu537Xl
         KGQC/TarAgiWwkMa4S5YOPfR4QLq8YLP5FoI3AQhL2tPydVXvGUF7Hdfg2t9RyyFObhB
         K7UtkFAi/inwRzlVOU1Yf923yAnpEkDQGSOndS4itumzQco8jcCcYvdmtQInqNg8S1/q
         arGDJBRQYJxhbNa91OU/6oWVLVIkhq1uLpntFiuWWgU/xS9hYV5bb0cf9lLCrP1iNuAp
         OKtISOJCG1Ip2H2h0OrugQ9ZbP4hGYj3UXuD/abnxnatsHVWl+XmU6hyFkxwy0VgWFiq
         B42A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.4 34/97] regmap: Fix reversed bounds check in regmap_raw_write()
Date: Sun, 22 Apr 2018 15:53:12 +0200
Message-Id: <20180422135307.247294276@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454873954222137?=
X-GMAIL-MSGID: =?utf-8?q?1598456222823117730?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit f00e71091ab92eba52122332586c6ecaa9cd1a56 upstream.

We're supposed to be checking that "val_len" is not too large but
instead we check if it is smaller than the max.

The only function affected would be regmap_i2c_smbus_i2c_write() in
drivers/base/regmap/regmap-i2c.c.  Strangely that function has its own
limit check which returns an error if (count >= I2C_SMBUS_BLOCK_MAX) so
it doesn't look like it has ever been able to do anything except return
an error.

Fixes: c335931ed9d2 ("regmap: Add raw_write/read checks for max_raw_write/read sizes")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/regmap/regmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1582,7 +1582,7 @@ int regmap_raw_write(struct regmap *map,
 		return -EINVAL;
 	if (val_len % map->format.val_bytes)
 		return -EINVAL;
-	if (map->max_raw_write && map->max_raw_write > val_len)
+	if (map->max_raw_write && map->max_raw_write < val_len)
 		return -E2BIG;
 
 	map->lock(map->lock_arg);
