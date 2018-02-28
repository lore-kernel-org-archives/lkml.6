Return-Path: <merlijn@wizzup.org>
X-Google-Smtp-Source: AG47ELvcGQf/dx8eGPPSQY1GAMG/eft7oHvKrr0+mups1p7ekK2WYfLSe3j7HMhKLxa2qkyO8FNg
ARC-Seal: i=1; a=rsa-sha256; t=1519779969; cv=none;
        d=google.com; s=arc-20160816;
        b=EQfjSbKik5rMHKhxvBBxX0b0ZscNE8jvI8Fx5qcaR8HANzqSPogBxGyw/xjicHYN3C
         8Lt1f/KU+kl5jeUC/ArUlsCiHWf3SzqtiCOXgS7TXv/qMElyTkljY6hbV6SuHMTH0Rou
         go5Mi7B3hrwLiEMjnZUteuXaAe9dBzpbY8+ZrHltMswh2/XinQbohm1TjnYv0z0+qj1m
         hbILpZTNqHWteUSD7ybOnEHPJJ/zQd7LWOseCOfSMnh/ZEBq0Edv8hU7p0xBHwDIMnpH
         xNY972yINvVvoIFtFipu7qPw4ArUNoLvMU/EaI57LCi7EREJKl5d6YHtiP4npcWdBOh/
         e7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=pbUxWgrB3rq4rLIGVROlSWz+qQVHMq8j388JMG/Y95Y=;
        b=aaEzyQU06Ocx09DHBsrtxl+GiRDQq4LHLRepL7l9gkDnQHoGhQ9qYUfjPY/9IXs39t
         CESqmYvQnwL23M2IjP95GTBsxcCfRg6TUS06X8RBmKliRCqNe4qXTSnDGGyPoe9+VJgP
         LObCnp9yOzTm/VW/2EkRb2tRGAUW1RguFJ7SbYisVSJ5xzcM9D7XY4Eg8NMTjLGxZxtq
         WQDuQ/CqUpBTgCfQyIz5f4FtBRTtGzOKfj1PdZuh7Mal1aCwV/73yo5S8YqiNH+w108z
         dS7a7sQmgtaeDNg112kpFrQf1KBBW1J3lghw71tKNsSwd3MRhN9/reC1c+F1bjfaLcWp
         7eUA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 188.165.243.101 is neither permitted nor denied by best guess record for domain of merlijn@wizzup.org) smtp.mailfrom=merlijn@wizzup.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 188.165.243.101 is neither permitted nor denied by best guess record for domain of merlijn@wizzup.org) smtp.mailfrom=merlijn@wizzup.org
From: Merlijn Wajer <merlijn@wizzup.org>
To: linux-omap@vger.kernel.org
Cc: merlijn@wizzup.org,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
	"Andrew F. Davis" <afd@ti.com>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Breck <kernel@networkimprov.net>,
	Matt Ranostay <matt.ranostay@konsulko.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/1] power: supply: bq27xxx: Call power_supply_changed on status change
Date: Wed, 28 Feb 2018 02:04:43 +0100
Message-Id: <20180228010452.1713-1-merlijn@wizzup.org>
X-Mailer: git-send-email 2.16.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593604801076921688?=
X-GMAIL-MSGID: =?utf-8?q?1593604801076921688?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

It seems that bq27xxx_battery_update does not call power_supply_changed when the
charging status changes, and instead only when the capacity changes.

This can cause considerable delays in reporting charging status changes to
userspace. This patch turns the battery status reading function into one that
returns the value directly (as other *_read functions), adds the status to the
cache, uses the cache when reporting the values and finally will trigger
power_supply_changed when the charging status changes.

There is still a noticable delay in detecting charger status, but that seems to
have a different cause.

Cheers,
Merlijn
