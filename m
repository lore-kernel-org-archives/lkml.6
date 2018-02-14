Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AH8x2240y9UprGFJcVSve5Ua5a2t2fQA0Gqp6QDR5hzEUox0hObTuHG5TMNtM57PmowDB9x/ESPT
ARC-Seal: i=1; a=rsa-sha256; t=1518568916; cv=none;
        d=google.com; s=arc-20160816;
        b=qgGkD2sY1uCb9BP1QP4i6GRwm49sRdj590tmZRtuc7RBTlcruc9eoGY4giOG3QAQQt
         Fo0wsf9AIXGahUMq+jrAryPSZon45vRQtC0UIc/6QF2jnc5mp0Io4jieLHloVvdOJxq5
         QuwVrbR6b2FFG+vVzJn3drxZwfROhF3yROTCJtvUW+xLY6RkDqLjt3Q61Vt3fkbP/pXe
         SyIMpnDxqCsprUfSxRXuM0Do8vYTbSiZEeB4+5Ld3r+dVM+wfWacc8B+iIV7rwUAgzxj
         SJv1oMQcMyX3F6+5ByzkdrbcSkgC1+G8rE7prjXXcSfMD6mZsDHz6R2rkj6/Wh6cG/rE
         jecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dmarc-filter
         :arc-authentication-results;
        bh=kSMC93UtCh7RFgVADTW8/LqFRMK8ZHIC9DnSU+SIon0=;
        b=SAWQd6bBZ60ZQu0S18vp3opfXx+B1EWKo3Ehou2Zlu24qfsE05NjAEpCq0GAPqfiS9
         lZpyLi81lNghAEBSfNydgYJHZJWBG5dDuveU6a/WYjPop10oJSYI5DptOymuq5KoMeh9
         2MqKLyIxYD0Ztuxyo1VMT2xL/vw58EmpTdIb7BhqP58C3B4nqTlr9KoHxxLelU+QAraT
         +mN4q4AlsjW+Tbq2FAXdpcjTR8NuFGyg5l+FIzEKJjC+Dr9QOAeKxi1SSnmAlOJu9JV7
         Ix3uweiHBCNQ3Z9JfharN1XJExgFQpCRDdyCiUXv3UOY7mQRR0S1bIZ38bSOvLHb+BY9
         h7Hw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BDA521782
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
Date: Tue, 13 Feb 2018 16:41:37 -0800
Message-Id: <20180214004148.14452-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592334920498977895?=
X-GMAIL-MSGID: =?utf-8?q?1592334920498977895?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Greg,

Now that v4.16-rc1 is out...

This is the pending cleanup I have for v4.17. Its based on my last
iteration of cleanup patches I had submitted for v4.16. You took in
most patches except a few patches which added some selftests bash
helpers like kconfig_has() as it was observed perhaps we could share
this. We poked Shuah Khan to see what she thought and her recommendation
was to keep these things within the firmware helpers alone, given
sharing a helper script would currently just add more complexity [0].

The biggest advantage of the missing patches was that we'd be able to
test at run time all firmware kernel configs usign only one kernel
build.

In this series I also decided to switch from debugfs to proc sys for
the knobs to help dynamically modify the firmware behaviour, this proved
less code and easier to maintain.

I also went ahead and finally shifted all fallback code onto its own
file, a goal I've been aiming for a while now.

0-day has given me its blessings on these builds.

Questions, feedback, rants all equally welcomed.

[0] https://lkml.kernel.org/r/938069cf-4478-2e46-f195-386830ce1a97@kernel.org

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

 drivers/base/Makefile                              |   2 +
 drivers/base/firmware_fallback.c                   | 720 +++++++++++++++++++
 drivers/base/firmware_fallback.h                   |  44 ++
 .../base/{firmware_class.c => firmware_loader.c}   | 765 +--------------------
 drivers/base/firmware_loader.h                     | 115 ++++
 kernel/sysctl.c                                    |  11 +
 tools/testing/selftests/firmware/Makefile          |   2 +-
 tools/testing/selftests/firmware/config            |   4 +
 tools/testing/selftests/firmware/fw_fallback.sh    |  39 +-
 tools/testing/selftests/firmware/fw_filesystem.sh  |  61 +-
 tools/testing/selftests/firmware/fw_lib.sh         | 173 +++++
 tools/testing/selftests/firmware/fw_run_tests.sh   |  67 ++
 12 files changed, 1166 insertions(+), 837 deletions(-)
 create mode 100644 drivers/base/firmware_fallback.c
 create mode 100644 drivers/base/firmware_fallback.h
 rename drivers/base/{firmware_class.c => firmware_loader.c} (61%)
 create mode 100644 drivers/base/firmware_loader.h
 create mode 100755 tools/testing/selftests/firmware/fw_lib.sh
 create mode 100755 tools/testing/selftests/firmware/fw_run_tests.sh

-- 
2.16.1
