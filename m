Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49JcqvAbuUxITOZqywHbVG/o/S8nVQbFloVnPGbUyTqFlrViPaEXZylF3TAhKiYQ6RnQ4iA
ARC-Seal: i=1; a=rsa-sha256; t=1524406289; cv=none;
        d=google.com; s=arc-20160816;
        b=IUaQOTbvmoUF5fTzuiUo53bVRg9VfnpeOSLtSYDq7BSiVupqlqkFnVaQaCe8laOaiP
         pL+bRaV8+ebLJO7y5tARthHw+346BXCROrbd2Lvq2ot8CCwEr2QwUB1cMnVvi352jysr
         XPYSClOXiP57txHX8lGZvCXbaPrBog7Ky7uQrV4zM78ntPhvBlHhNVaskZTjFa6576ro
         lg4Aca/o9vZw+3wiKqPslUB3hTPXkRwCKis/LtkgDOJrUBcoM5RUu5C8NbXB0bFOaJv5
         aMRUkYKq3+hk4OaTJL/Iq57Lp1ThJLof45tDaZGU0X303UsjsOxx3R0uqyiAztI25OxI
         oCAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/JycSh8uK9DACxicAn5bGqFMYTBM7gOExI0w3J4m128=;
        b=Yl04e0T/46beemTm2mpIsWq9Ay5NNqMwTeu+SDRDd16+r8wtR/IQ7eKnhwdqpiAlnm
         jZMtAUmUlQyhkiVt4o393mKrRkIG0gh/m3YVSKYA03hJX23mgmxBit1dpXSS8LvbBezv
         sd8oQUrnqgodDPpgR1BVYRnT7QA2slvS7bY7DbrkmygGyowtExuWK/GFubfW7kIclYKI
         cFmWAoWAtcmCp805qTpfItEAn4rYkTshT34GWwl0uAT0flUzrbMfYaxgn2SqnSxILTSo
         YiCLmJBvMPPpjvAFnqEl2ygZULRU04vuSh9ORqkGR5f+rSMcTAaCzGGhshMffxMlynRw
         1hSw==
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
Subject: [PATCH 4.9 17/95] regmap: Fix reversed bounds check in regmap_raw_write()
Date: Sun, 22 Apr 2018 15:52:46 +0200
Message-Id: <20180422135211.145528929@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454873954222137?=
X-GMAIL-MSGID: =?utf-8?q?1598455849612657520?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1736,7 +1736,7 @@ int regmap_raw_write(struct regmap *map,
 		return -EINVAL;
 	if (val_len % map->format.val_bytes)
 		return -EINVAL;
-	if (map->max_raw_write && map->max_raw_write > val_len)
+	if (map->max_raw_write && map->max_raw_write < val_len)
 		return -E2BIG;
 
 	map->lock(map->lock_arg);
