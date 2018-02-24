Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AH8x226evJ3d/VlCFY0MUvglMmM8TLPMadBzTZnzMIIQgxxsOWfvaeJY8V+PAXPhegDHGvs3GJbm
ARC-Seal: i=1; a=rsa-sha256; t=1519440376; cv=none;
        d=google.com; s=arc-20160816;
        b=ldGC2wXARv+wUID2GyqiMnWwmX1YrBH3LJW/K+XF6WoRBFNf7sqNOKmgcKhbwyR2jf
         0vJuH+IUMyLN8X9nccMwz/1U6nI5LZzjDuI9sp3DsIY2n6cW8YrYQmU0dbN1uKa/88iw
         +MKWP54vnPSO8+weKoXNept+/Y3G59byHlvMXrbiyGGHADMR7a7jpr/XS0WdhbfB+KUm
         H9LjsMAagsyJJZ6DqHbJS1EhFKCl0IxrIeBsSljoTwCHeT8zZ1Wd5rljlMf4C3zJBV73
         Jz+LUf9V7dTjssrXELaFQ0HQAZlxLZB97tASdnGyWaqC/JBs5A/czBYOi5pSzUAT9enW
         GQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dmarc-filter
         :arc-authentication-results;
        bh=EL4ci2kizKwP/ycgMj3/XuX7yyqhDaVbIO8XbS1KiqI=;
        b=KU7Lj6WKLURgHv7FmCJ0ieDyJ9ZSY7DfLq9pW9/N5GY/AKEiChcXq1kj4imxHgABjv
         809KF8B3MBG2SFS04l9M8xyNfZ+g6X1BwxRqM1DQgj8nb3JKbxv9bKkEWrvjVgLvAu6w
         ZphiMnLM4lFvaSH7dlhLpq3qmewAhjB+WKlf/KVFge3l5LD1qyCjUBXjnTAebTymjc2M
         pPygs8r26dChMRp/5Eg57MN7+msYWUER6EOm37rUnZWNAzTnAnF1rOXHQ5CaeAlcdapN
         1wNRzrAeUAAZPyAuV0cbup987HqNFWClQWrdMMn25NeX81aiGPKtU6guMpjIhbL9jIef
         MHwg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D7921717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mcgrof@kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	keescook@chromium.org,
	shuah@kernel.org,
	mfuzzey@parkeon.com,
	zohar@linux.vnet.ibm.com,
	dhowells@redhat.com,
	pali.rohar@gmail.com,
	tiwai@suse.de,
	arend.vanspriel@broadcom.com,
	zajec5@gmail.com,
	nbroeking@me.com,
	markivx@codeaurora.org,
	stephen.boyd@linaro.org,
	broonie@kernel.org,
	dmitry.torokhov@gmail.com,
	dwmw2@infradead.org,
	torvalds@linux-foundation.org,
	Abhay_Salunke@dell.com,
	bjorn.andersson@linaro.org,
	jewalt@lgsinnovations.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v2 00/11] firmware: cleanup for v4.17
Date: Fri, 23 Feb 2018 18:46:02 -0800
Message-Id: <20180224024613.24078-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592334920498977895?=
X-GMAIL-MSGID: =?utf-8?q?1593248712379803440?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Greg,

this v2 series addresses some corner case build issues. One was spotted
late by 0-day after I used Linus' tree for build tests rather than
linux-next, and another I found on my own. 0-day covers more ground
with testing if you use Linus' tree.

The one cought by 0-day was in that in the case when the firmware loader
is modular (actually rare these days) the new sysctl table for the
configuration of the fallback interface needs to be built in as well, as
otherwise the proc sysctl interface can't access the configuration. The
other build issue was a misplaced "static" on a fallback call.

0-day now gives its blessings for both, on linux-next and on Linus' tree.
Questions, feedback, rants all equally welcomed.

  Luis

Luis R. Rodriguez (11):
  test_firmware: enable custom fallback testing on limited kernel
    configs
  test_firmware: replace syfs fallback check with kconfig_has helper
  firmware: enable to split firmware_class into separate target files
  firmware: simplify CONFIG_FW_LOADER_USER_HELPER_FALLBACK further
  firmware: use helpers for setting up a temporary cache timeout
  firmware: move loading timeout under struct firmware_fallback_config
  firmware: split firmware fallback functionality into its own file
  firmware: enable run time change of forcing fallback loader
  firmware: enable to force disable the fallback mechanism at run time
  test_firmware: add a library for shared helpers
  test_firmware: test three firmware kernel configs using a proc knob

 drivers/base/Makefile                              |   5 +-
 drivers/base/firmware_fallback.c                   | 667 ++++++++++++++++++
 drivers/base/firmware_fallback.h                   |  67 ++
 drivers/base/firmware_fallback_table.c             |  55 ++
 .../base/{firmware_class.c => firmware_loader.c}   | 765 +--------------------
 drivers/base/firmware_loader.h                     | 115 ++++
 kernel/sysctl.c                                    |  11 +
 tools/testing/selftests/firmware/Makefile          |   2 +-
 tools/testing/selftests/firmware/config            |   4 +
 tools/testing/selftests/firmware/fw_fallback.sh    |  39 +-
 tools/testing/selftests/firmware/fw_filesystem.sh  |  61 +-
 tools/testing/selftests/firmware/fw_lib.sh         | 173 +++++
 tools/testing/selftests/firmware/fw_run_tests.sh   |  67 ++
 13 files changed, 1193 insertions(+), 838 deletions(-)
 create mode 100644 drivers/base/firmware_fallback.c
 create mode 100644 drivers/base/firmware_fallback.h
 create mode 100644 drivers/base/firmware_fallback_table.c
 rename drivers/base/{firmware_class.c => firmware_loader.c} (61%)
 create mode 100644 drivers/base/firmware_loader.h
 create mode 100755 tools/testing/selftests/firmware/fw_lib.sh
 create mode 100755 tools/testing/selftests/firmware/fw_run_tests.sh

-- 
2.16.2
