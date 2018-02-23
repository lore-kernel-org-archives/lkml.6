Return-Path: <f.fainelli@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519420183; cv=none;
        d=google.com; s=arc-20160816;
        b=c0fjDoXkbypUWNbzowYjmPXCMjgw6ct43UDeJtQdQ3ZEh4aN3hJCLDuwWCTI+X4AZE
         ycgjgzCAB8/pAxaWLAKXkPsnQDkmSQbmawG7N0iW/pwUCfvUBRW8DFvjBc4fgO/6S9i7
         wGyE4fhuH41gqCvF6tukElW64FHA0XfLVOW6cYhrBWwjIOoZ+RLEMDLVaG8WgaPrGDE4
         fzQXqiQUVL7cVWlqdr4nBJLBBAp5IOp8lFNfWdSAMqhZiUBkCafzDG+IbLWLbsk2Qsev
         bxT17H5BMXdISPl15ggtmDZxm1bo8X1V5kyp9VVDhHfQuWIsPbehX68lHf1ICCD2RX79
         Lnzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=XvlsRPeeuk5bkVPvGsEReHare0jjT+yutFTyu2wXZVk=;
        b=T4h82TjN8DBJO0ygMAksSvGCCmOud9iQJITNhms1b3sy8sxBa9GxObEwk7kSs/q4Tm
         bZqdkeYQKd4uFvB4FC6mq/PxpxyxxIadk1E/sGwuSrsBS/6q7Kj/Jqfpu6Q/b4z3sZKP
         C49IdYhmjd2H9tUGLhxe6IAh6DLjeWGMYsm2TYMT+pAUNvAbaAS0dQsT8Z4g5ZcCdVA7
         pjbPgQTTKfquC56Kv1TH5oMatFVukQKLlcxnqqvXkOig4EBYYX6jfJxAJFvydMhRSh2L
         9cHMs0dCZgqpxvvCrJdoowIbUDpInVC4/voCa5q9CgJxn9O+6HVOD3vJnGsioR+AtlPV
         gg4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fJiCvM0T;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fJiCvM0T;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtAA/IDbGvtUzaOeDFrorvwvPRsuz0NrgvqL7MKSFObCY1PWQ1klDhqcKc5n+8mgwhKNyy0NA==
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Brian Norris <computersforpeace@gmail.com>,
	Gregory Fong <gregory.0xf0@gmail.com>,
	bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE),
	Doug Berger <opendmb@gmail.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/4] ARM: brcmstb: Add support for the V7 memory map
Date: Fri, 23 Feb 2018 13:09:19 -0800
Message-Id: <20180223210923.544-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593227538446054373?=
X-GMAIL-MSGID: =?utf-8?q?1593227538446054373?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi all,

This patch series updates the brcmstb.S DEBUG_LL routines to dynamically detect
one of the latest STB chip: BCM7278. This chip has a different memory map which
requires use to lookup the main ID register to know whether which register
physical offset we must use.

As a consequence of doing that, we do a number of things:

- allow the inclusion of cputype.h in assembly files to reduce the duplication
  of constants
- define the Brahma-B53 and Brahma-B15 main ID register values, which was long
  overdue
- finaly update brcmstb.S to detect 7278 and offset the base register address
  accordingly

Note that Doug had a slightly different approach in our downstream tree where he
actually added the same MIDR_* constants similar to what ARM64 has, I took that
part away in order to minimize the delta, but I can easily submit that patch
if this is the desired direction moving forward.

Thank you!

Doug Berger (3):
  ARM: Allow this header to be included by assembly files
  ARM: add Broadcom Brahma-B53 main ID definition
  ARM: brcmstb: Add support for the V7 memory map

Florian Fainelli (1):
  ARM: add Broadcom Brahma-B15 main ID definition

 arch/arm/include/asm/cputype.h   | 15 ++++++++++++---
 arch/arm/include/debug/brcmstb.S | 21 ++++++++++++++++++++-
 2 files changed, 32 insertions(+), 4 deletions(-)

-- 
2.14.1
