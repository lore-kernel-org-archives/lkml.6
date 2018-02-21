Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225NWHCwPdZGH8hnQ/45S0I40o8IRu1x6hyQyfxtlv0jjwDDs/tjP6f3XykhR1pu3bla36tY
ARC-Seal: i=1; a=rsa-sha256; t=1519218670; cv=none;
        d=google.com; s=arc-20160816;
        b=DnXC9mGIp2IbYZLgrJFzd1mS5c56tsHgbEF50aHniCMBXtrBWKod3PiKmxIlpp0u5E
         bic/gC7CNzU6CIOgK95C/ANenbm9P2camgm52x7jXRlLsKT+4JmKiXEkHPq+26NQkqJZ
         xSbDjTD5oizYvvibevwGK/CFjsjh6fN+RAZ1dBVZ1e6z540b9mJ5HCMHC4YhzBlm+5Ui
         PYe8Ppgdw1Ugx51sqFtrsgabnZhD+9C2WtilJSM3Fa2JVz7s8ri+edxMvnB/f7hdOXYZ
         lf0N5w3ZMcNfu7AQMNT+IQIzbTBDiMZW3TOSn8H0KTLOQZg0QUN000e3WpUdAfD9RLA9
         /8zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=z68s5DxPYEnvRZPAjRehVSXpJaiAyG5TaNTTgsTZJEY=;
        b=mg1G4JepUGJCvNno9HPIWKauSe05Jfnkb0WztIeuVgJFUG80hasU049HBiQBXOy2Tb
         mrGH8HmZiOPa4rT+1qpyTLviCblP+fd2ZPNBx93n3w4Nc+FXpp00VcGu9Rw6ZI2v1N8y
         CFUCPV7fEBgn4rUx772Q5Cko95ta1Cxfmh87HogiahWLlvoO9lJ+qOf7LPq3K69IsDkb
         MQGrf5zp5nSTteqYoAjYd5wVvVfRpbxj0X+DOIlt6VbwgyvrgFm1RvMlN9OK8OET5HgX
         bnluUllB+p7Ip9Frw1WJVNYJgWmuhQKEA6BaqNlQFXe5xxdaQr5zqnoG4sM2CJra70uI
         2K+g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.15 110/163] mm: hide a #warning for COMPILE_TEST
Date: Wed, 21 Feb 2018 13:48:59 +0100
Message-Id: <20180221124536.278089927@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014626139492093?=
X-GMAIL-MSGID: =?utf-8?q?1593016236548739769?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit af27d9403f5b80685b79c88425086edccecaf711 upstream.

We get a warning about some slow configurations in randconfig kernels:

  mm/memory.c:83:2: error: #warning Unfortunate NUMA and NUMA Balancing config, growing page-frame for last_cpupid. [-Werror=cpp]

The warning is reasonable by itself, but gets in the way of randconfig
build testing, so I'm hiding it whenever CONFIG_COMPILE_TEST is set.

The warning was added in 2013 in commit 75980e97dacc ("mm: fold
page->_last_nid into page->flags where possible").

Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/memory.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/memory.c
+++ b/mm/memory.c
@@ -81,7 +81,7 @@
 
 #include "internal.h"
 
-#ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
+#if defined(LAST_CPUPID_NOT_IN_PAGE_FLAGS) && !defined(CONFIG_COMPILE_TEST)
 #warning Unfortunate NUMA and NUMA Balancing config, growing page-frame for last_cpupid.
 #endif
 
