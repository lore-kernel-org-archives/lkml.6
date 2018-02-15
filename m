Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x22640s5dYCtDyDb905DtJNep2bBCMcp+m/FTSIcDHl/NsowuobFeEDLWh/mE2t0VypsRJx4c
ARC-Seal: i=1; a=rsa-sha256; t=1518708477; cv=none;
        d=google.com; s=arc-20160816;
        b=L3y5LwrQ6aDLEs5RxOMLn483+V16HZpU1D7c8PRsQ34y93ATfj2jjouzxizWstcDjw
         7IiMYmE1qvvP58fdEtfk3oYzBywg7SIZbNDxsZUuteAvmpiuTLsB5AFpaVOh7Dw4P7vY
         jZRn/eoNNBTwuBoUmL5/PlCH7poneZiW+veUGdREWJH5seH6ovcSLJwgqJ6gW/XDohzX
         0vhLBnn0hW4b6ac4QuagPN1Y+2ph41SSa638d3msLF0LV0eVLXiIUS1cXgxYVJYqOLob
         IKFY+a781afRIbfuPJ0Ub3YUA6/mp/ggnWgJOcNx6ld83J7Zmpm6A9AXPiu6F3WD9Gwz
         QdQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1a4HLX3OWDhTRVEXRtJ7+uTdAImBP/pdsYOWsDp7inY=;
        b=bq+tAYieZ7ltM99mLYYAjbMVi2e9Hx02fwY06Rk0npJUS/76h0muOVOE9FvC9Kt75n
         xbk9RcQfmRayJjzxeTtRu6XSumXVhmGbfMOkzfSBwgMPLMAY4KWfKPa5HwFyAJvyZoot
         ARRDBN7aUNuhEq8juSP6/99by59XdcN5/oEP7gvixCmKWNUbfKg35CMBZkuukXtHpcWY
         eODVQyA7hSJ9fjssIRI3i/VdEwQduseyWGjrTb+IEhLX7qyBodVMoj1YPWAdl22VTQao
         5kZj0co1r1hsXi8DqQwlwUqgCMda1LLY59jBuT2IzgI24xk56vZ9x/7GH9uL6KcOqy/a
         EbTA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	John Keeping <john@metanate.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.9 55/88] ASoC: rockchip: i2s: fix playback after runtime resume
Date: Thu, 15 Feb 2018 16:17:22 +0100
Message-Id: <20180215151230.342425962@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481260348588269?=
X-GMAIL-MSGID: =?utf-8?q?1592481260348588269?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Keeping <john@metanate.com>

commit c66234cfedfc3e6e3b62563a5f2c1562be09a35d upstream.

When restoring registers during runtime resume, we must not write to
I2S_TXDR which is the transmit FIFO as this queues up a sample to be
output and pushes all of the output channels down by one.

This can be demonstrated with the speaker-test utility:

	for i in a b c; do speaker-test -c 2 -s 1; done

which should play a test through the left speaker three times but if the
I2S hardware starts runtime suspended the first sample will be played
through the right speaker.

Fix this by marking I2S_TXDR as volatile (which also requires marking it
as readble, even though it technically isn't).  This seems to be the
most robust fix, the alternative of giving I2S_TXDR a default value is
more fragile since it does not prevent regcache writing to the register
in all circumstances.

While here, also fix the configuration of I2S_RXDR and I2S_FIFOLR; these
are not writable so they do not suffer from the same problem as I2S_TXDR
but reading from I2S_RXDR does suffer from a similar problem.

Fixes: f0447f6cbb20 ("ASoC: rockchip: i2s: restore register during runtime_suspend/resume cycle", 2016-09-07)
Signed-off-by: John Keeping <john@metanate.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/rockchip/rockchip_i2s.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -476,6 +476,7 @@ static bool rockchip_i2s_rd_reg(struct d
 	case I2S_INTCR:
 	case I2S_XFER:
 	case I2S_CLR:
+	case I2S_TXDR:
 	case I2S_RXDR:
 	case I2S_FIFOLR:
 	case I2S_INTSR:
@@ -490,6 +491,9 @@ static bool rockchip_i2s_volatile_reg(st
 	switch (reg) {
 	case I2S_INTSR:
 	case I2S_CLR:
+	case I2S_FIFOLR:
+	case I2S_TXDR:
+	case I2S_RXDR:
 		return true;
 	default:
 		return false;
@@ -499,6 +503,8 @@ static bool rockchip_i2s_volatile_reg(st
 static bool rockchip_i2s_precious_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case I2S_RXDR:
+		return true;
 	default:
 		return false;
 	}
