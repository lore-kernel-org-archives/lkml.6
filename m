Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1524591079; cv=none;
        d=google.com; s=arc-20160816;
        b=sNkGeBsjc+piY3kzXP9oU/q0xdq4eFYkdGXxzIDYTvz0UyRh+gPfEOBuBDxHc/u5W8
         JQN7/Rqnimq611P6eZqfPbeoVYCHSqU0Uow1FmuVbZbYxz/EEDRR0MXwd2sTkVdHxIg1
         zW33EMRDPCY5lG6Rtej7p5YhHf3V2dSrtiyLpJPsKM4+bXWiyYv9tYYgz2C2owSLvbWH
         +XLwN6io6K+iZkKws6zscbKMqdPCHAoTCeb34dTVJhws7+bEY8YeDPVqW9He4ZpJZW5X
         q9tWTLtbxXqyBw80xx+9Y0Ebe76Woq0VrfPdnYtDTe9bA6nUqFTCk7hV3QdCuKPERGTX
         TZQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=HO1vCT495PoqQSJU4Cv873XTJwREw8E2vuRqgOze4IU=;
        b=pUySqVXiSWK4GslHEk/VJEQBYRcQC3qiCMlXtUds6weWYa3Br3wB0vp9xXE4aZa6GT
         Zvdvo1A/WtD66UKomBaKX8n8UlU5SDHcDn0hwL7nqMRUig67sody3MNj3SohkcH0in+z
         UMPjSQpdBlljqX84/2mt2Fzvk+dInx6NUolfuIGhO/Hyd98RYZ4Kfqd+Tur+bm7x6Vkm
         ADzaZWvXgPBZQDvLeuqVxMdBRCPuz/2i6nkyJECYrOZyysN32AeaQ/LufGca9sNe2YYQ
         4QQ6UkBK+Xp1rfgXbD/eeSe9wZubbWloaRW2HL5WIin2DuIm7QnGEnaSCNz0shK4zFpw
         2QYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=tWHd4dgd;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=tWHd4dgd;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AIpwx48htcRgPy/9Em2kE4xllKGuQtCXXp4tKDZdo5bDGFQ+CiyLzVmuwU8BoML7a21xow2c3T0SuQ==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>,
	Kevin Hilman <khilman@kernel.org>,
	David Lechner <david@lechnology.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	Frank Rowand <frowand.list@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Arend van Spriel <aspriel@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Michal Suchanek <msuchanek@suse.de>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 06/11] of: provide for_each_compatible_child_node()
Date: Tue, 24 Apr 2018 19:30:46 +0200
Message-Id: <20180424173051.15099-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180424173051.15099-1-brgl@bgdev.pl>
References: <20180424173051.15099-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598649615898746438?=
X-GMAIL-MSGID: =?utf-8?q?1598649615898746438?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a variant of for_each_compatible_node() allowing to only iterate
over all compatible nodes that are children of the specified root node.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/of.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 4d25e4f952d9..15e0dbf7a602 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1170,6 +1170,9 @@ static inline int of_property_read_s32(const struct device_node *np,
 #define for_each_compatible_node(dn, type, compatible) \
 	for (dn = of_find_compatible_node(NULL, type, compatible); dn; \
 	     dn = of_find_compatible_node(dn, type, compatible))
+#define for_each_compatible_child_node(dn, type, compatible, root) \
+	for (dn = of_find_compatible_node(root, type, compatible); dn; \
+	     dn = of_find_compatible_node(dn, type, compatible))
 #define for_each_matching_node(dn, matches) \
 	for (dn = of_find_matching_node(NULL, matches); dn; \
 	     dn = of_find_matching_node(dn, matches))
-- 
2.17.0
