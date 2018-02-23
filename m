Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuYlcwe3hJFOicWz7UgE71nT51Kt7OewNfMgBnw7P+6RpyV53vVAa9eeCjjDfMZ+e6MyjVo
ARC-Seal: i=1; a=rsa-sha256; t=1519411185; cv=none;
        d=google.com; s=arc-20160816;
        b=dR3T5ebMKV7mqDXXBLXIT1jgWPwUnPNo3KFbPQjaIPQesGXN+msKMRPdNkbCfnVLV2
         DSqsoOlw3FbSXV/6oQnHvsvOjf5AWqTYJuABqVnOfc9yDxr0HYnht3+UK2PlUmN9qqY8
         n62P5Rrrs1AxaBoLkt6K/OIM8f0s0tAAShdwwusrC/+HYLIIDoH4gvOZcSWd9m9uRL5b
         XDJsSeSmWtRVSyTnBgetAkUFvBVpdEDcphuYON03dzQ6cq30rmLqis6BIQb2E0XeKB6a
         hoRXrrYoSoa2egGPR0b82o49oXdeIOoI7pO6GSUrTyDBbrpzQyQdwVa7zAS+Q2YRYDOg
         1Luw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MuWEnTap80HOa8ekPmJT4mnpz3vfcU+QXVtFllqVzLk=;
        b=LtvGWWNSeZi9u/g9glRXmsuAlSGSTfJRy/Z1mwumh8VpyiXGgCTtS4rtGHi1VzE3je
         hNZCaYdqbn9Xy9mwDsDNV4ltMQlFRGUN9tvPqkq7OKwRKidWPUaYA3yhNQWFvqlsReSD
         klT8nA+L+hkBixValx9w44Bq8qZ/+6T6I6Tt9Y1q28Lr0gzh7G8+GgqJdnVFTPpUhc+Q
         ePL51oH3cfu6DN4KI2w1TA3eNw0tg4rYSMv445UXbwTrxGnuHoEM3CwTGYjBo53dWq/J
         yq9d/F2dPZYFbBJvYV1YB4g3UKVhkdeQoc6CvJdCuc1xO8uvXkz/r0XQl1zeuG/KeAi5
         2qsA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 149/193] Revert "power: bq27xxx_battery: Remove unneeded dependency in Kconfig"
Date: Fri, 23 Feb 2018 19:26:22 +0100
Message-Id: <20180223170349.259649068@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218102579603042?=
X-GMAIL-MSGID: =?utf-8?q?1593218102579603042?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

This reverts commit 6bd03ce3c12a22d86f59070f1da15aaa2bde8a51, it was applied
in error and cuased this link failure

drivers/built-in.o: In function `bq27xxx_battery_i2c_read':
core.c:(.text+0xa6da8): undefined reference to `i2c_transfer'
drivers/built-in.o: In function `bq27xxx_battery_init':
core.c:(.init.text+0x68e0): undefined reference to `i2c_register_driver'
drivers/built-in.o: In function `bq27xxx_battery_exit':
core.c:(.exit.text+0xc6c): undefined reference to `i2c_del_driver'

Later upstream kernels fixed this with a larger rework in commit
703df6c09795 ("power: bq27xxx_battery: Reorganize I2C into a module"),
but we cannot backport that to 4.4.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -159,6 +159,7 @@ config BATTERY_SBS
 
 config BATTERY_BQ27XXX
 	tristate "BQ27xxx battery driver"
+	depends on I2C || I2C=n
 	help
 	  Say Y here to enable support for batteries with BQ27xxx (I2C/HDQ) chips.
 
