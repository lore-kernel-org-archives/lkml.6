Return-Path: <arend.vanspriel@broadcom.com>
X-Google-Smtp-Source: AH8x224x7pMSxo0EwAmRQKMOkCGIP0LEI7+012IOBOWzdVXbnzAShaopoci7BJeWSVu7hg1nMfL3
ARC-Seal: i=1; a=rsa-sha256; t=1519210241; cv=none;
        d=google.com; s=arc-20160816;
        b=HIvP65o4PZy1Iz9g++ghfGcWaeUIazVkrMU8M1QLmzQubf09hL27jmSL1K36QHmaAT
         mg1RJ/CA918DKsrvt+z+/i4MyHtpxI0Sf64X8+AX6inWsE9HNgZy+5ZW/+Tq5HD0AiFz
         KAXqg+LNlFB1plKtQxOl3oSo0G+tg/uCXgF+rfq35/wH7o4Hp4ckuk3A6sTYOhCMk6ad
         mZN650sAnRxjUywipV7FYsONjUuf3SCELQi/YQh3XhMG005wPzPBNbDiweTnMmJsciWR
         rXjce6OSssdMzlS1ge5L/cv6VzbabuUfsB0wV8BgXwxvC94ir/CHsTnMUjOUMfzbY0jY
         hw1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=h7B7Cayff3+sxPAQJUBJ/PYpSfS7fMUMwOyQkvTrOGM=;
        b=ce3JZCq6afJtKHRM5hehPMTC1q/zxFAJMaBVx3SrZl6LxKyrQpO3O/3cjjBnCkj3e4
         2kTWl4aL3Rvq7BYWwv16RXryaQ0TC5+5jA+sapqmxllRV84gZti3G9bD/fEPX9HTXt+Q
         crV3WT460WYfQ75hZS2Ycto5twQ3dRrD9uy6vIs3B/m34TvVqaM7kCunpLDuAF5Bynqi
         hRha9UiA/xWX9suPMpXPcSzeHu3gJX5tokq8QiRVCKkmhdMbrlCI2QGUKmuPbM3auvoX
         t4cvImB0vfgP2xe56oR/GPX52ZbBcQyi/6Nj0F9PA2Jm1TRJ0ufM5q/ZKZLoXmIqFZ9+
         AsfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 192.19.229.170 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=broadcom.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 192.19.229.170 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=broadcom.com
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Kalle Valo <kvalo@codeaurora.org>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-wireless@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 0/3] drivers: support for sysfs initiated coredump
Date: Wed, 21 Feb 2018 11:50:17 +0100
Message-Id: <1519210220-22437-1-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593007398481717171?=
X-GMAIL-MSGID: =?utf-8?q?1593007398481717171?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This series is intended for 4.17 adding support for sysfs initiated
coredump. This uses new functionality that was added in drivers base.
Device drivers can now implement a .coredump() callback upon which a
sysfs entry is created when the device is bound to the driver. From
user-space a device coredump can be initiated. The easiest way is by
going the drivers entry and enter into the bound device folder like
this:

  # cd /sys/bus/pci/drivers/brcmfmac/0000:02:00.0
  # echo 1 > coredump
  # ls /sys/class/devcoredump/
  devcd1	disabled
  # ls -l /sys/class/devcoredump/devcd1/
  total 0
  -rw------- 1 root root    0 Feb 19 23:49 data
  lrwxrwxrwx 1 root root    0 Feb 19 23:49 failing_device ->
  	../../../pci0000:00/0000:00:1c.0/0000:02:00.0
  drwxr-xr-x 2 root root    0 Feb 19 23:49 power
  lrwxrwxrwx 1 root root    0 Feb 19 23:49 subsystem ->
  	../../../../class/devcoredump
  -rw-r--r-- 1 root root 4096 Feb 19 23:49 uevent

The device driver can implement the .coredump() callback as they like.
The use of the dev_coredump api is not enforced although the sysfs entry
is only created when CONFIG_DEV_COREDUMP is selected.

Apart from brcmfmac, the other drivers used dev_coredump api and had a
mechanism in place through debugfs, which is removed in these patches.
With these patches initiating the coredump can be done without selecting
CONFIG_DEBUGFS. No attempt was made to look for drivers providing some sore
of coredump functionality by other means than the dev_coredump api.

The first 2 patches apply to the master branch of the wireless-drivers-next
repository. The last patch applies to the master branch of the bluetooth-next.

Arend van Spriel (3):
  brcmfmac: add support for sysfs initiated coredump
  mwifiex: support sysfs initiated device coredump
  btmrvl: support sysfs initiated firmware coredump

 drivers/bluetooth/btmrvl_debugfs.c                 | 31 ----------------------
 drivers/bluetooth/btmrvl_drv.h                     |  2 --
 drivers/bluetooth/btmrvl_main.c                    |  6 -----
 drivers/bluetooth/btmrvl_sdio.c                    | 18 ++++++++-----
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |  1 +
 .../net/wireless/broadcom/brcm80211/brcmfmac/bus.h |  2 ++
 .../wireless/broadcom/brcm80211/brcmfmac/core.c    |  7 +++++
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |  1 +
 drivers/net/wireless/marvell/mwifiex/debugfs.c     | 31 +---------------------
 drivers/net/wireless/marvell/mwifiex/pcie.c        | 19 +++++++++++--
 drivers/net/wireless/marvell/mwifiex/sdio.c        | 13 +++++++++
 drivers/net/wireless/marvell/mwifiex/usb.c         | 14 ++++++++++
 12 files changed, 68 insertions(+), 77 deletions(-)

-- 
1.9.1
