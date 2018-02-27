Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AH8x226VSE9OilDngU7Bsu2+BUns82vNKTYYzWSF17qt29klBOWLdcJOp5vAQ9iUzjjA4+kKz9Rw
ARC-Seal: i=1; a=rsa-sha256; t=1519773667; cv=none;
        d=google.com; s=arc-20160816;
        b=sY/idAt+kKTT6hLXdGPNea1tXNfBSOW3Ac/8eefTnGPuS5FVzrU1BhWEeOL1uzEZLn
         G/towYrGrWri/eNfnW+7XbeDc2S3X1Ge8KggiWT/17+tj8DiQPMhUegB3rQuhMAxcl5L
         WHypfZvtMFR/SHvpiH25WqhMJPuKH9pEWS47FYqSgM/xz7k1OSxczCQ1bTT+SJoCJr7Z
         0Wvox1XSTPIpZZM8lCQ1OxyaMQIABXSX98C1SS1RLoWYI+4PeQVav51KMz3EQy8jFCd/
         CBaobVS53M64B9wxMwJp5vlxpnfautvQT2+UmEvZHIDFCvQArHkT2iZLb09jLyS91vKr
         7CMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dmarc-filter
         :arc-authentication-results;
        bh=WapRW+yZIU6EXCfxzL0gK9R0UANP5Yoly5RhmDcm9Zo=;
        b=LR48eP3Ie8E7veJBwtfaTzCvZqEOzHR8n+XJT1Il7IjyWyn2/7AcCzZ/uvAGRPkqBJ
         vGsjNI+JP7EwS7851ZfcViE+WTpzJq+eZWcsIDXe5OvtjEOIPkSNcolxtUaZsvkqDkEz
         BWwToKvAUW2Mn5ZPq5QEeHH7pciteGen8vfqmRiUtWjXAqFK0q0eq/AA0mtjAK+MpVSD
         chy9hJ8Q4uD7RLVKUfsT90FLSDI7mrCPdrjBN9Kk2+gLVph1guwqC6S+occj7Ul+k0kd
         J6BsUSnSKWyK2YiZ9UkUnHsDhikV3TX2T88pyU++nIXb5aPLZwDfM0IpcHsfeUPOFyOZ
         4wiA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E2721784
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mcgrof@kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: cantabile.desu@gmail.com
Cc: kubakici@wp.pl,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
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
	stephen.boyd@linaro.org,
	broonie@kernel.org,
	dmitry.torokhov@gmail.com,
	dwmw2@infradead.org,
	torvalds@linux-foundation.org,
	Abhay_Salunke@dell.com,
	bjorn.andersson@linaro.org,
	jewalt@lgsinnovations.com,
	oneukum@suse.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [RFT 0/7] firmware: enable caching of firmware for reboot optimization
Date: Tue, 27 Feb 2018 15:20:54 -0800
Message-Id: <20180227232101.20786-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593598192477821921?=
X-GMAIL-MSGID: =?utf-8?q?1593598192477821921?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Some devices have optimizations in place which enable devices to retain the
firmware on reboot. Some drivers check for this and if present on probe they
don't request the firmware. This can be an issue if the system suspends after
this given the firmware is still needed on resume. Since the request firmware
call was not issued no cache was done.

This series exposes a way for drivers to setup the cache, while also
doing some minor sanity checks. This series only contains the delta from
my last submission of patches for the firmware API for v4.17.

Cantabile, please give these patches a spin and let me know if it fixes
your reported issue. They depend on other pending patches I have in line
waiting to be merged so the easiest I thing I think is for you to test my
20180227-firmware-cache branch [0], based on Linus' tree. To get that
tree, cd into your Linus git tree and do:

git remote add mcgrof https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
git checkout -b 20180227-firmware-cache mcgrof/20180227-firmware-cache

Please let me know if this resolves your issue and thanks for your report.

  Luis

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20180227-firmware-cache


Luis R. Rodriguez (7):
  rename: _request_firmware_load() fw_load_sysfs_fallback()
  firmware: fix checking for return values for fw_add_devm_name()
  firmware: make fw_add_devm_name() return 0 if cache present
  firmware: add helper to check to see if fw cache is setup
  firmware: ensure the firmware cache is not used on incompatible calls
  firmware: add request_firmware_cache() to help with cache on reboot
  mt7601u: use request_firmware_cache() to address cache on reboot

 .../driver-api/firmware/fallback-mechanisms.rst    |  2 +-
 .../driver-api/firmware/request_firmware.rst       | 14 +++++
 drivers/base/firmware_fallback.c                   |  4 +-
 drivers/base/firmware_loader.c                     | 61 ++++++++++++++++++++--
 drivers/net/wireless/mediatek/mt7601u/mcu.c        |  2 +-
 include/linux/firmware.h                           |  3 ++
 6 files changed, 77 insertions(+), 9 deletions(-)

-- 
2.16.2
