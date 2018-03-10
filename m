Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AG47ELsYFteYRsfTSfVx+b486200+FXPLiEGXgFn0DpKQrrv+mSc5LMey5iLq4thOzjezD24ruwy
ARC-Seal: i=1; a=rsa-sha256; t=1520691311; cv=none;
        d=google.com; s=arc-20160816;
        b=H10hpaga/eCBRPdb+sgNHN5c0reE0LbR/u2Ot7LNM9KrXRyqSJjakZIqABih59Lwrg
         8Fb6rN7NcvfAChDm7DzJC2FVB9550L9wu4YU90iU/bE582R1Fqc6E7qQnWQl5Tu5U1Tl
         rbElO11eHSwVhg8DsJajafCyLtFGut5j1ewqg7J2h+L/SHy20E6ZtNOq1U7kHgqW2FHd
         x3z5GWfbVx/U+bz2XB0Sxxo9m5BZA58RE74v/sPgZS7Kr7CgmFj4GFI+nmb0ijN/pDaR
         IJDAwMxPtwrnldVBv8NnQ214Su8H8tWG4DOpggKyCo19vAMcHkls4IyfSR/fbs67mGXn
         hhUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dmarc-filter
         :arc-authentication-results;
        bh=2m0ivgrVXMyWy9p4BQCo/GjMqUvOx98nzItDvbC7RhU=;
        b=rp7yfdDfhY1WpkREE6vciDZ+Rmdl9ECzLGbeWphKOu6A+h749LJGKzLrm67fpyNGGR
         pSRRiEVNYSheKlffTxwpxJ46FCeK17Ufj+PWQrDWiQZ/1emI9E/ugSY3PF4iJHBwW0sR
         eoIzMnSh6lkyA3/wmZw/p30xJSALW8wZpryLdtRg47BnM6wlMH7eq+swj1Msunj4VEws
         /pnGR14PCMkVzHN3hpeCKkSL0t/rVXv4o2hF1dQDjKru68f1eqZDU9lRgyHDr9r7ZY54
         ld1F5iIUNUNrPXH3clyy1rpK8aP3LKVkdaciL/JDWJrM6/KLp0ShUwg0A9T4q0bprVls
         yBsA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220D420685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mcgrof@kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	cantabile.desu@gmail.com,
	kubakici@wp.pl,
	linux-wireless@vger.kernel.org,
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
	broonie@kernel.org,
	dmitry.torokhov@gmail.com,
	dwmw2@infradead.org,
	torvalds@linux-foundation.org,
	Abhay_Salunke@dell.com,
	bjorn.andersson@linaro.org,
	jewalt@lgsinnovations.com,
	oneukum@suse.com,
	ast@fb.com,
	andresx7@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v3 00/20] firmware: development for v4.17
Date: Sat, 10 Mar 2018 06:14:41 -0800
Message-Id: <20180310141501.2214-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594560413093563327?=
X-GMAIL-MSGID: =?utf-8?q?1594560413093563327?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Greg,

Here's a respin of what I have queued up for v4.17 for the firmware API. It
combines the cleanup I've been working on and the addition of the new API call
request_firmware_cache() for fixing a corner case suspend issue on some type of
cards with an optimization in place where the firmware is *not* needed on
reboot.

The cleanup work allows us to test the firmware API with one kernel
configuration. I've addressed Kees' feedback on this respin and
combined the code into drivers/base/firmware_class/.

I've made one new test_firmware change in consideration for one firmware
change, the patch "firmware: ensure the firmware cache is not used on
incompatible calls" requires us to modify our tests scripts to use
the APIs sanely as well.

I've put up these changes on my git tree, refer to the branch
"20180307-firmware-dev-for-v4.17" based on linux-next [0] and
the same name based on Linus' tree [1].

Questions, feedback, and specially rants are always welcomed.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20180307-firmware-dev-for-v4.17
[1] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20180307-firmware-dev-for-v4.17

Luis R. Rodriguez (20):
  test_firmware: add simple firmware firmware test library
  test_firmware: enable custom fallback testing on limited kernel
    configs
  test_firmware: replace syfs fallback check with kconfig_has helper
  firmware: enable to split firmware_class into separate target files
  firmware: simplify CONFIG_FW_LOADER_USER_HELPER_FALLBACK further
  firmware: use helpers for setting up a temporary cache timeout
  firmware: move loading timeout under struct firmware_fallback_config
  firmware: split firmware fallback functionality into its own file
  firmware: move firmware loader into its own directory
  firmware: enable run time change of forcing fallback loader
  firmware: enable to force disable the fallback mechanism at run time
  test_firmware: expand on library with shared helpers
  test_firmware: test three firmware kernel configs using a proc knob
  rename: _request_firmware_load() fw_load_sysfs_fallback()
  firmware: fix checking for return values for fw_add_devm_name()
  firmware: add helper to check to see if fw cache is setup
  test_firmware: modify custom fallback tests to use unique files
  firmware: ensure the firmware cache is not used on incompatible calls
  firmware: add request_firmware_cache() to help with cache on reboot
  mt7601u: use request_firmware_cache() to address cache on reboot

 .../driver-api/firmware/fallback-mechanisms.rst    |   2 +-
 .../driver-api/firmware/request_firmware.rst       |  14 +
 MAINTAINERS                                        |   2 +-
 drivers/base/Makefile                              |   2 +-
 drivers/base/firmware_loader/Makefile              |   7 +
 drivers/base/firmware_loader/fallback.c            | 674 +++++++++++++++++
 drivers/base/firmware_loader/fallback.h            |  67 ++
 drivers/base/firmware_loader/fallback_table.c      |  55 ++
 drivers/base/firmware_loader/firmware.h            | 115 +++
 .../{firmware_class.c => firmware_loader/main.c}   | 833 ++-------------------
 drivers/net/wireless/mediatek/mt7601u/mcu.c        |   2 +-
 include/linux/firmware.h                           |   3 +
 kernel/sysctl.c                                    |  11 +
 tools/testing/selftests/firmware/Makefile          |   2 +-
 tools/testing/selftests/firmware/config            |   4 +
 tools/testing/selftests/firmware/fw_fallback.sh    |  65 +-
 tools/testing/selftests/firmware/fw_filesystem.sh  |  72 +-
 tools/testing/selftests/firmware/fw_lib.sh         | 194 +++++
 tools/testing/selftests/firmware/fw_run_tests.sh   |  70 ++
 19 files changed, 1332 insertions(+), 862 deletions(-)
 create mode 100644 drivers/base/firmware_loader/Makefile
 create mode 100644 drivers/base/firmware_loader/fallback.c
 create mode 100644 drivers/base/firmware_loader/fallback.h
 create mode 100644 drivers/base/firmware_loader/fallback_table.c
 create mode 100644 drivers/base/firmware_loader/firmware.h
 rename drivers/base/{firmware_class.c => firmware_loader/main.c} (60%)
 create mode 100755 tools/testing/selftests/firmware/fw_lib.sh
 create mode 100755 tools/testing/selftests/firmware/fw_run_tests.sh

-- 
2.16.2
