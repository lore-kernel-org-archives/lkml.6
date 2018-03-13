Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuFf+9KsdvjxkPZ+oRkLxaqdqG6nhU98eUWX9qAhVbgWB1j87YHuDqhCYcr4+v6NluXdrO9
ARC-Seal: i=1; a=rsa-sha256; t=1520955304; cv=none;
        d=google.com; s=arc-20160816;
        b=kmggRW+Bi+tkji0aD9ao4/CWJEQIwreGMrOJgN+myCLfXUN9IfWCzkG34t0F7/ZRZK
         mdlsaGEvyOXP84HnOhEfbunKHAqmVupMq56ebkw0ESFNfTbSiGkHWjwaEFtQlNgq9++M
         jgmucXB3bI+y3aMIpsXoSn/+e53N6CofW/qlwwlxAZLZNzc3weR/nqNkc4/BgWWoASFp
         ICwuMQaQJ2RLrEZCO7Lf1Hxjx9yuTEiocioQ1YaGjmFvTDaDoSKMlrMqYKzmbJTc3rv6
         /u3sce/ENWeYd6hUmZZy8L9bn6URYnu6qex6qcIZQHBhQXEliwP/f1APVfwiqjfWO+HT
         ClrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CCqHFv6ac79hnf8yC3c+OQiixSK9VYGpKFdXEv4DFN8=;
        b=YZz8YQhLB5pE896Rm/7tz28ZCjN1uJaN4EVOcybzaIjvxR7UavFWXQElG6EWv/weo4
         vzevOhnefVHJaLQk0a9hTIBqsJQ2HCtYEpXCl0zE5Ess18f28dGEiDHKuicbG/r3A9nv
         hFza6Ymt3jvvToYJEupYOc1a+qjWBKtQ0Dq7boXnFpBCCLnYYGKMbeYIqRT9ESNC9W2h
         ooSLdzyAgdAcS7C3Hp2TdQ1oJBDP0f9I/tev68JOnLf7g9wlwu4eX5Yer7Il6sO7a27u
         vF8JjF7NHGSS/2YDVUvPsQeU3nXU9ctCyIwqV/ZtYqFgJyVZ4cx2lCVCxfVKCcJAYHXm
         Sa7w==
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
Subject: [PATCH 4.14 004/140] watchdog: hpwdt: fix unused variable warning
Date: Tue, 13 Mar 2018 16:23:27 +0100
Message-Id: <20180313152458.475865971@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837147473792096?=
X-GMAIL-MSGID: =?utf-8?q?1594837228899639338?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
