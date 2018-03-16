Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELth0Q2xrVwokEOe07fZw2Yj9qblecaYP7c8A/MTYIFrb9GsmPCU41ohKb4EhmXvDnjSrp5p
ARC-Seal: i=1; a=rsa-sha256; t=1521214847; cv=none;
        d=google.com; s=arc-20160816;
        b=QdIpRxiXgD5hwQNY5ZM9yGvG8yf4uzB/uPB3cQDQYDDoUY1LamB3x7/DpDvFoG+NTR
         DDXA7Dwp3eI4tOtHpgDRClPsoQte9tBIkP/c6D3FONe0IXm0EpRK2uf7YzJFUHSC9yAq
         x4jOsosBOnKwIPRhxSXghuQTi3g8hdSudyFeVRa6UnZhVg1uYCFKEFgwib10nq2S/AnW
         Mkpq9HQ2aQuQ735HhH/5gCt59sS+k+bP4jk6JuoXHICTCPEIcdpGNjHT95M3kHvfKSJE
         e/q0mir6K/2JpmuPqRgXZncyDYJKKS1sVXe6+54z7KRU6BakGIVhyuyLvGfAEvkJb196
         8ufA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=V5mWBP9nShsOOIR1iz5RjakU7+rG8iW23cxBC0Ki27M=;
        b=twkHe+xQrtiZ37z9kVROtP7x6UI8j4DV8u/7IYp/YmP/DYb9NDFeTTVeMrzMe72R0y
         q7SY/1atQY2VRjMOKo+yAhI/CFSQyBbpFeXLQMAJZs9C6iL0Ti65RzV8CHTnX2bW1IBG
         46QWOcSKqOtCahKGD6OhlAUIdA7J7F7X3wSL6zxOoAfWP5EzmjLNniKUbS1qfkc7GI7o
         Gm22FhFiFfkURsZ9kUgq3s1VB5874TIpgVa0kUf+dqCDu/P1kOZ1ki14LjZh9f8GAaiV
         G/XKJN0QUzbH16FyJTDMLpLEbnuoGcB4gyO2B5mV8dB8b5JijVA9LUPDspcfKKQsAhBn
         RM9A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.15 005/128] ASoC: rt5651: Fix regcache sync errors on resume
Date: Fri, 16 Mar 2018 16:22:26 +0100
Message-Id: <20180316152336.481323916@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108886987469592?=
X-GMAIL-MSGID: =?utf-8?q?1595109379709545047?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 2d30e9494f1ea320aaaad0cff9ddd92c87eac355 upstream.

The ALC5651 does not like multi-write accesses, avoid them. This fixes:

rt5651 i2c-10EC5651:00: Unable to sync registers 0x27-0x28. -121

Errors on resume (and all registers after the registers in the error not
being synced).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/codecs/rt5651.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1722,6 +1722,7 @@ static const struct regmap_config rt5651
 	.num_reg_defaults = ARRAY_SIZE(rt5651_reg),
 	.ranges = rt5651_ranges,
 	.num_ranges = ARRAY_SIZE(rt5651_ranges),
+	.use_single_rw = true,
 };
 
 #if defined(CONFIG_OF)
