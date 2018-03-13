Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtzTxiEQ5nqyRd/hxDhWplMn1ehWKOU5iwyZ0z87NwSCOgFFmnPQwbiROz5dWY7OmE0xXeO
ARC-Seal: i=1; a=rsa-sha256; t=1520955226; cv=none;
        d=google.com; s=arc-20160816;
        b=gt0NTzOJSgT9SwmyVdk6f0SkHHkn1CXl+SuZB56mamap6khdpu8AkrDktTR7vWierl
         bkg+NiX2WKB68Kzt0VyctB/zihT6j5LUsCmVBIrWQZk1fvkWh2Y1acNd3oO/uo5/51la
         BM9P0w94FSOdUa32LJwnLvWmSTTct/col9f2a5psVzXsUP4Gw0LCx0jf12uYJKZBWHOa
         s0H04vwghg/BXk4mh+pHDiTa748rF7Kbl180t9+HhFsER0jwCERS3TIDixUFKfyUeZ9S
         uGFE9BlEMjYXp3fcWIIO76UNNGQ5HVE4TCy8Z1vwLu7qDKGyd+xWMnbkLfCmLyTZc53B
         QgUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rJa5enpvuauSh7Y6GKnJg9a8Ump+zcvo5n2lk3GBt8g=;
        b=Uyl8ARVmj6nran631KWaNIGvr64v1013hCIrhQR/mTtS5xxJwZu9JtP9ejX8m0W30g
         6sEY5ETFO2z3b38WATp/5TFiA9JGYk6I+xLpBr7CaayPiVnUk0nSk2RyDorsaZmKX7je
         tEXb6/UZ2Uvrw79/GF+gjxL3IN4FfkWuV2/nEq/m7+/Cqj1L8FlBgw/GNirTmhzT6ZYm
         lIjBRjfDwW5z8ipiYaiLlT2iRD2tSLF3ukEavIOPizFQeRqFkP0S716lGNeZyRdw0YBs
         7ftBoDsir6WWmTUk4kGrd9IOZKERd/9WqWyTiWU+14ilRXITFjXNRPkL+YZS2EjUUisj
         PawA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Jerry Hoemann <jerry.hoemann@hpe.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 4.15 106/146] watchdog: hpwdt: fix unused variable warning
Date: Tue, 13 Mar 2018 16:24:33 +0100
Message-Id: <20180313152328.603942038@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837147473792096?=
X-GMAIL-MSGID: =?utf-8?q?1594837147473792096?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit aeebc6ba88ba3758ad95467ff6191fabf2074c13 upstream.

The new hpwdt_my_nmi() function is used conditionally, which produces
a harmless warning in some configurations:

drivers/watchdog/hpwdt.c:478:12: error: 'hpwdt_my_nmi' defined but not used [-Werror=unused-function]

This moves it inside of the #ifdef that protects its caller, to silence
the warning.

Fixes: 621174a92851 ("watchdog: hpwdt: Check source of NMI")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Jerry Hoemann <jerry.hoemann@hpe.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/watchdog/hpwdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -475,12 +475,12 @@ static int hpwdt_time_left(void)
 	return TICKS_TO_SECS(ioread16(hpwdt_timer_reg));
 }
 
+#ifdef CONFIG_HPWDT_NMI_DECODING
 static int hpwdt_my_nmi(void)
 {
 	return ioread8(hpwdt_nmistat) & 0x6;
 }
 
-#ifdef CONFIG_HPWDT_NMI_DECODING
 /*
  *	NMI Handler
  */
