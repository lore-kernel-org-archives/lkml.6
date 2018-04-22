Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48zxRRKb9HXFQ+l+mLiKzxk0UBtgg1SCTJA63nFpWcwTsLCOuhvZpcvqp8XImrsWFGvyKdC
ARC-Seal: i=1; a=rsa-sha256; t=1524405359; cv=none;
        d=google.com; s=arc-20160816;
        b=mtXG0M46RsHLyts42HlR3fPE/EOEMGGQ6kL20xqRPPMqoWdccUh8LHujpXqcpNoKpE
         iZZUK6ANIOgEpkJM3jIspkVagzvgBhu3y2rCf/vaMoSpmUnt15F+/uaPL2dgQbXaMhvu
         WkaSJamJnEhd9yxGEcANfxdZUMo8OQqx/bUbiNqHhPxcUlhOoiNhy1PYSQanWbb+d2yN
         cW2fVrYYErPAq18uU3qsm2qV0uSYbn8V55SWVarLEAhDNO2Gd8RNkgOeVM5z7mOCcxrm
         fnRk31mldE2s97EUsUDxd5Ank/nTpu/JEhLV5UvrqCFFPBOyNAgJOJr7Fgv2yj7rOg1m
         wIrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UQQsLldgQDJTvyJF5ZX2HgcsJTLGMC12aMzg8Lb1SOw=;
        b=KoxqtQa1BMJc8ADwhIwoRwg3xcOvSCDQdwV7JUhowfe8wTWI1zW6MHJAl+HPch7GZ9
         nKW7TbL8X9ohLBCUf8A73HgW81/qX/h51kO9Fs0ZVeveD2jox+WF6AZVNS3YG/Z/96i6
         0Z/GYO0qLq5Elv8f2q3cDEU3iDKdPg756q2KoICk4oIukyOsedJo9VwfGaorJf5uPdOi
         PZ4RJYDoZMd3O+d7GnSt3xB71mP9Yl4pifA+zywNanllKU3asJMsHW2I0wxZgdT/Sc2g
         yqH2AgbSeEkGSmfFfc62EywgO8d5BWSA1mYYunWIo8BI13KrFPOVWfVaAdl8gA/CmSy8
         er0g==
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
Subject: [PATCH 4.16 036/196] regmap: Fix reversed bounds check in regmap_raw_write()
Date: Sun, 22 Apr 2018 15:50:56 +0200
Message-Id: <20180422135105.964617622@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454873954222137?=
X-GMAIL-MSGID: =?utf-8?q?1598454873954222137?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1831,7 +1831,7 @@ int regmap_raw_write(struct regmap *map,
 		return -EINVAL;
 	if (val_len % map->format.val_bytes)
 		return -EINVAL;
-	if (map->max_raw_write && map->max_raw_write > val_len)
+	if (map->max_raw_write && map->max_raw_write < val_len)
 		return -E2BIG;
 
 	map->lock(map->lock_arg);
