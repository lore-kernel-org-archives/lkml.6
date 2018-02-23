Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvTn4Xvr7jqyDykBg5kSz2QExcgCGH61gA5hIvO1alJAQsbYpUdmZq8RL0KfYmSvH8eHL7L
ARC-Seal: i=1; a=rsa-sha256; t=1519411062; cv=none;
        d=google.com; s=arc-20160816;
        b=mXKr2jaiDmqZDrEpsQw/uFHQDad/wryoY8JKpF6P24wUabBMSOmmDG9uYwntO/oN/O
         OF3l80B47pIft6ZUp/G6vz/SdGJqaGedUZZ9JDL9k1u8VreTlO0+/FlKYTGOt4LUAXe9
         z3Wb6ntQTX9v2qW+zu3uEXaSKL0O9Qd+x4AxnzxqgWKiMVksk/1JPN/OTxcKAc29TK5H
         z7zbbmhE3lx+p01djnTUrMXadN1onVwcQaNr9Ew9jtFycaDdZTHS4jHq+b5bImYKdCQ6
         QiV+MgiswwWTicNQIffDC+btuT86f8RbmpOtkgNPhFlflxQa5MTHoWix/yeOElrHfAIZ
         2xBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+TxwMbq2Q4AmMlfogKWQ3TW+QLK0v5rhJQ6XQ+bVP68=;
        b=svvRcuhPNsmVhBPVmcmCV++lmEJhgxyoGt0qROP5R2uat47HKeOUrwYl3sODBOIUcJ
         hBIMcxNcdFaTlszmr14kVHir1rmMXUzjLEBZAt30uD95xJtfMRWHeaR7eWysUTma8NAK
         +bKP9Ko/aQiJ4BFpTUOW1z3DbsQ+z643oXCXJI7CSPuGP8cMnpF0V53hsngtKqiA+N3s
         IkXbQ3ZGYAfOx7yfW4eUgMp0MsidDZuCOHl63P5Soj42cnRBlUmMjNPFI+s3q1ZW5wtB
         e2ei/0YgfqLxmnp8ye+gOOsaXvzkSNmSYd6rBMzC+8aS/xkNIN51yAT7plJwmsYnJJKf
         Z3Rw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH 4.4 107/193] mtd: cfi: enforce valid geometry configuration
Date: Fri, 23 Feb 2018 19:25:40 +0100
Message-Id: <20180223170342.702974596@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217974695541908?=
X-GMAIL-MSGID: =?utf-8?q?1593217974695541908?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit f5f92b36fbbb8ac7d70ff5fa39ec2637cce3094c upstream.

MTD allows compile-time configuration of the possible CFI geometry
settings that are allowed by the kernel, but that includes a couple of
invalid configurations, where no bank width or no interleave setting
is allowed. These are then caught with a compile-time warning:

include/linux/mtd/cfi.h:76:2: warning: #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work.
include/linux/mtd/map.h:145:2: warning: #warning "No CONFIG_MTD_MAP_BANK_WIDTH_xx selected. No NOR chip support can work"

This is a bit annoying for randconfig tests, and can be avoided if
we change the Kconfig logic to always select the simplest configuration
when no other one is enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/chips/Kconfig |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/mtd/chips/Kconfig
+++ b/drivers/mtd/chips/Kconfig
@@ -67,6 +67,10 @@ endchoice
 config MTD_CFI_GEOMETRY
 	bool "Specific CFI Flash geometry selection"
 	depends on MTD_CFI_ADV_OPTIONS
+	select MTD_MAP_BANK_WIDTH_1 if  !(MTD_MAP_BANK_WIDTH_2 || \
+		 MTD_MAP_BANK_WIDTH_4  || MTD_MAP_BANK_WIDTH_8 || \
+		 MTD_MAP_BANK_WIDTH_16 || MTD_MAP_BANK_WIDTH_32)
+	select MTD_CFI_I1 if !(MTD_CFI_I2 || MTD_CFI_I4 || MTD_CFI_I8)
 	help
 	  This option does not affect the code directly, but will enable
 	  some other configuration options which would allow you to reduce
