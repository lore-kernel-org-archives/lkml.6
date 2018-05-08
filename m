Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AB8JxZrc3fcpWoUZ5RNawZWI7ZUHE3CkZuVwMVPLbXTwJX26A7NiwCjEwkKVfEnvI8GdrpJOG5DJ
ARC-Seal: i=1; a=rsa-sha256; t=1525803170; cv=none;
        d=google.com; s=arc-20160816;
        b=R+mzRbP+wJWCbv0GGeBx1Yb7WHaKZFnCeeV/x9VFhfRKFWB7ODBm89S0vP+7P2N5NV
         deHSbLbr9RR3FmgEyAEAw51+RIzLsM8hJXwWSW6sC3sQdMy8n9tX6mMeaTkxph1sxgwI
         /VFGgsxbQgMUNEJBRrk2fDEkN8E3teWhIS75QiE2GWZTf/3wfKvTMRa2bhJcZCL5vL75
         jgbV3cmc46Iom4oYGhk9jo8Y8Cwgc7W7LTN1bpFr9UroYoSon/hLGMSq7nkt5P1t2db2
         O93lY+NMFMOMEVWhi5wrOJOpe2ODqw2rTpo60jApYHp2+qT71EfvYyvEGii1QfGaRBH6
         GXeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=/0KkHLQxJQcmrgbEtfNmZWsGT1wqYs48wGuD9kBBO6A=;
        b=OP7BphfrYx8u0vDhfbh/RaHYnQTcI2HAXBuPbJD5sjrAzZD1BsYbm1R1pELrMqkBzP
         dzWnRA9IRuAZLUdhodbbwwKOdSP/icAju8551CUaZqeuKmdDOJIaqcrh6qLZNut1VPww
         E6mqweGmce5cT7zHyZOJXRNEUCpBPrVWkU12yYnhNYq1SKepISsR0CJq9+CUItva5N0N
         0QMj/2fmDmf/QJfTz4ol6hC7ny4HaJVw4L3V3cOkhIx1SGUznzgb7olNlLEdqw2vW7Ee
         636F3TyWzsGa1Xw6yO2n3tZ5nlnAWQo6mn6630SW7W18GhGYudfbbOP2hJ9TxgNUlvwk
         9znQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=NagR71jH;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=NagR71jH;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	keescook@chromium.org,
	josh@joshtriplett.org,
	maco@android.com,
	andy.gross@linaro.org,
	david.brown@linaro.org,
	bjorn.andersson@linaro.org,
	teg@jklm.no,
	wagi@monom.org,
	hdegoede@redhat.com,
	andresx7@gmail.com,
	zohar@linux.vnet.ibm.com,
	kubakici@wp.pl,
	shuah@kernel.org,
	mfuzzey@parkeon.com,
	dhowells@redhat.com,
	pali.rohar@gmail.com,
	tiwai@suse.de,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com,
	zajec5@gmail.com,
	nbroeking@me.com,
	markivx@codeaurora.org,
	broonie@kernel.org,
	dmitry.torokhov@gmail.com,
	dwmw2@infradead.org,
	torvalds@linux-foundation.org,
	Abhay_Salunke@dell.com,
	jewalt@lgsinnovations.com,
	oneukum@suse.com,
	cantabile.desu@gmail.com,
	ast@fb.com,
	hare@suse.com,
	jejb@linux.vnet.ibm.com,
	martin.petersen@oracle.com,
	khc@pm.waw.pl,
	davem@davemloft.net,
	arve@android.com,
	tkjos@android.com,
	corbet@lwn.net,
	mchehab+samsung@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v6 00/13] firmware_loader changes for v4.18
Date: Tue,  8 May 2018 11:12:34 -0700
Message-Id: <20180508181247.19431-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599920585909697433?=
X-GMAIL-MSGID: =?utf-8?q?1599920585909697433?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Greg,

Here is what I have queued up for the firmware_loader for v4.18. It
includes a slew of cleanup work, and the new firmware_request_nowarn()
which is quiet but enables the sysfs fallback mechanism. I've gone ahead
and also queued up a few minor fixes for the firmware loader documentation
which have come up recently. These changes are available on my git tree
both based on linux-next [0] and Linus' latest tree [1]. Folks working
on new developments for the firmware loader can use my linux-next
branch 20180508-firmware_loader_for-v4.18-try2 for now.

0-day sends its blessings.

The patches from Mimi's series still require a bit more discussion and
review. The discussion over the EFI firmware fallback mechanism is still
ongoing.

As for the rename that you wanted, perhaps we can do this late in the
merge window considering we're at rc4 now. I can prep something up for
that later.

Question, and specially rants are warmly welcomed.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20180508-firmware_loader_for-v4.18-try2
[1] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20180508-firmware_loader_for-v4.18-try2

Andres Rodriguez (6):
  firmware: wrap FW_OPT_* into an enum
  firmware: use () to terminate kernel-doc function names
  firmware: rename fw_sysfs_fallback to firmware_fallback_sysfs()
  firmware: add firmware_request_nowarn() - load firmware without
    warnings
  ath10k: use firmware_request_nowarn() to load firmware
  ath10k: re-enable the firmware fallback mechanism for testmode

Luis R. Rodriguez (7):
  firmware_loader: document firmware_sysfs_fallback()
  firmware_loader: enhance Kconfig documentation over FW_LOADER
  firmware_loader: move kconfig FW_LOADER entries to its own file
  firmware_loader: make firmware_fallback_sysfs() print more useful
  Documentation: fix few typos and clarifications for the firmware
    loader
  Documentation: remove stale firmware API reference
  Documentation: clarify firmware_class provenance and why we can't
    rename the module

 Documentation/dell_rbu.txt                    |   3 -
 .../firmware/fallback-mechanisms.rst          |  14 +-
 .../driver-api/firmware/firmware_cache.rst    |   4 +-
 .../driver-api/firmware/request_firmware.rst  |   5 +
 drivers/base/Kconfig                          |  90 ++--------
 drivers/base/firmware_loader/Kconfig          | 154 ++++++++++++++++++
 drivers/base/firmware_loader/fallback.c       |  53 ++++--
 drivers/base/firmware_loader/fallback.h       |  18 +-
 drivers/base/firmware_loader/firmware.h       |  37 ++++-
 drivers/base/firmware_loader/main.c           |  57 +++++--
 drivers/net/wireless/ath/ath10k/core.c        |   2 +-
 drivers/net/wireless/ath/ath10k/testmode.c    |   2 +-
 include/linux/firmware.h                      |  10 ++
 13 files changed, 319 insertions(+), 130 deletions(-)
 create mode 100644 drivers/base/firmware_loader/Kconfig

-- 
2.17.0
