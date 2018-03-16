Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtbrMPdRtUlIcsU0Lg8wjtmOciu3yY5putGIO0Q8WKcqFKV6SGNx96bE5hKrwfFb5FZT4+E
ARC-Seal: i=1; a=rsa-sha256; t=1521214412; cv=none;
        d=google.com; s=arc-20160816;
        b=YXkIO00tiyq47oZdRwx812kM4s/4bmfT0eymzW7o530I9ExxeQQHvtHnIRCdnryoSo
         3TW9C58cs3GG0JB8pUP1kgtOONXuL1lGzY0oQo3Wltu02rzZEuslQMfX2tn4dqrimy4G
         XjMlZ0NTXsvNnAqzt4R7HTe2RFDq6hPVIddZI/qn5bVghwMfE++ZvONpCNxkka5ebjy8
         zf09KDejtl0QVn8zpVEwC+eWw5BQa0oa7FsxxvEyOjx8W2i2pA56qCmcXrx84L5uOneG
         1cP4r1HxGTlyLLXk9O50RcAgxMHEp8bSqAz3hUxfNA6XPbUkAjE68gnS3c0QwBsoWC3P
         F6Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EPy6aBtOYfqDhw/JzAppY9imvH5x12hz0EAXYAn3sPw=;
        b=RHCJSLbXL+6Wx3cCzxwRWlgwl6kG73dFjCY9fdvBWTeMJkxbnLg9Qa5+HoOC+jo7Uh
         P4834WoPFo+A3Ft7FN/mIVrKaWTJYHzh5BmkahqWqH+gv5sHxDSKx8ucJIdlp95B8XgY
         EkLsZO/OQF3BW4DWK+v/kgGnx8Hudqm6Sawb7pOtsAVyjL1i8cUxb3+7Z+37SxM96Ejf
         rMbz41T4nAXOuzl666tAVDg5ZpjGAPNHZro1U7vQGyqOU7Atn8Xd5c0z/Z6hGsfe9fEM
         LxCbvQ60KesBK+pSkKjMjeYNCt78Oi0vxwrQgL1lLyJofRUmG/kE7UaS8Zt3Rb65aUel
         eXJw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Jerry Hoemann <jerry.hoemann@hpe.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 4.9 49/86] watchdog: hpwdt: fix unused variable warning
Date: Fri, 16 Mar 2018 16:23:12 +0100
Message-Id: <20180316152320.712143050@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108564315980358?=
X-GMAIL-MSGID: =?utf-8?q?1595108923492933019?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
