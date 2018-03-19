Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1521451046; cv=none;
        d=google.com; s=arc-20160816;
        b=V6wrA0RsNb/aBoPFKE4BTOBUfCSyAwOdgzQXax43ialO7mQ+kOWbLSuPhlYiQhn3yE
         tLm/544E0Ha+a857jOfjm5oZNny5bpbOnBsKi16saPHyMIjXMB7mmjUGRge5A8l+xiRe
         eZxTygYbC+TZkbHdoTQz1Vq+L+q/4NyYFKYwuldDSQo9/o2+kYvmyejpM0pwX6kSpQ8c
         XkqqjtkoRe1i6s7iFXogAy+cKMTBpEb7yfFyQ9XwCRa3PNI3IA7OO129n4Tmq06jeLLU
         piWMnQcshGtu1WLYAxnjOHsZN7yEa6emwPp5bLpR4ZrcKQGAQM+BjN7tun7n3COamrin
         n7kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=twaJgchGzbPjstC5R2goaXnmxf9HX61h6wh0xQ074gk=;
        b=eULRtYuUTwVLSQlYldouVba19wlXyrPd6GIhtrh1nFTbrOv8kr+9n62J4J7UPDfBNI
         i6D7b8SAvxMREzBbWnbM7rK1jtNJpn0Te6fsqTjeLNTncLaMlxJeK8HhhcibY+cVUgyl
         UrcjGpfJiIvkMxjROEero1V9NRUnLZUHJt4EMQTtpZ+kKg2D2Au6KhByDOea1DRT9r/S
         7lzwREPSQcdKD7XGP4W3V6O301W7KTH4Q+fThCI/dhyS7X0IEZAZ5p6uh8mkQtZtoiHX
         WQ96bZWyzX+vtJtsMhqGndGFZ7C7ySWMRDZ9Q3zanw0jA+SZdPKGJwRzeXAGoBCk2Adi
         eF/A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=fNzd7/6M;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=fNzd7/6M;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AG47ELtmEWxf7A5IpbMvmiKDR5DVXgTERZr30yxxZyxGsTpBgkMdrd8et/Nb4ptT1wU2Zsn9ejd1LQ==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 00/21] eeprom: at24: driver refactoring
Date: Mon, 19 Mar 2018 10:17:00 +0100
Message-Id: <20180319091721.18193-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595357052478188626?=
X-GMAIL-MSGID: =?utf-8?q?1595357052478188626?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This series contains what I hope to be a non-controversial refactoring
of the at24 eeprom driver.

Most changes revolve around at24_probe() which became quite complicated
and hard to read.

The only functional changes are: disabling the internal locking
mechanisms of regmap (since we already take care of that in the driver)
and removing an if checking if byte_len is a power of 2 (as we do
support models for which it's not true).

All other patches affect readability and code structure.

Tested with a couple models and different both for device tree and
platform data modes.

Bartosz Golaszewski (21):
  eeprom: at24: disable regmap locking
  eeprom: at24: remove nvmem_config from at24_data
  eeprom: at24: arrange local variables
  eeprom: at24: use SPDX identifier instead of GPL boiler-plate
  eeprom: at24: remove code separators
  eeprom: at24: drop redundant variable in at24_read()
  eeprom: at24: drop redundant variable in at24_write()
  eeprom: at24: make struct initialization uniform in at24_probe()
  eeprom: at24: don't check if byte_len is a power of 2
  eeprom: at24: rename at24_get_pdata()
  eeprom: at24: rename chip to pdata in at24_probe()
  eeprom: at24: use a helper variable for dev
  eeprom: at24: readability tweak in at24_probe()
  eeprom: at24: provide and use at24_base_client_dev()
  eeprom: at24: switch to using probe_new() from the i2c framework
  eeprom: at24: move platform data processing into a separate routine
  eeprom: at24: remove at24_platform_data from at24_data
  eeprom: at24: refactor at24_probe()
  eeprom: at24: tweak newlines
  eeprom: at24: fix a line break
  eeprom: at24: simplify the i2c functionality checking

 drivers/misc/eeprom/at24.c | 293 ++++++++++++++++++++++++---------------------
 1 file changed, 156 insertions(+), 137 deletions(-)

-- 
2.16.1
