Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AB8JxZp4oydPD/Awo7t68/bux6xNIKJCIpHrhN+0MgH2oakwFQCr86n4OiPbzu/8OxaWPJDRqlH0
ARC-Seal: i=1; a=rsa-sha256; t=1525982934; cv=none;
        d=google.com; s=arc-20160816;
        b=wacCgUgoxpsQilCDX1yJqSipZEz1qf141TSFBmLcI/cYU1+Y31IQlhTC/kylXYtVQp
         NKE3KpX0wNqHE6RmwYl1+AOH8s1AhIsTiCdx+E61KyiQmXSniSTkS2T0RqeMF40pkJry
         sPGaZWJz62pOBKCQTAZTLq9rCgvaYHKA3eN1FiUKJaQVXJ6KlgS8fb97qlBkbO4anwoQ
         VHLyMPKbP+bZWtaZt6lFTpIMWeADryqAZjHG0MvMEKaA8Qp5ubPJR3VTmAUO9P7TL4Jr
         myNnbHION/6hDq11YSc8lEuEHh1qsMntBee6FqkyA1dfmbm/FDnPF7Cp8MLtPqW7bRNf
         CJ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=xWEoIuICtW+b0ypqG3SpSfMPRnoJkZO6MjjcYgDqcoo=;
        b=GOuGQLCLLX6jVXomUXtUgHduDAVFqpL6UYADQx+EOPk07sZYMT9HvlovIRzSIh8N0u
         OgozDMCpXGG8+ue+6WtAwpigvO8NVisZLehn96BkunjsWOgZc46uSVsca8tMMNJLADHB
         J3Kc655ddJaib7FsgPmwY3sKJIhYACXXkLo9vL8oj3WE5z/IR7P/JrPfLQgRvdOvMSJi
         EKiwqnfdi8c9J3fvE6rPN2es9Xi0E3BudCifT/2Fx82lyCeFswmqgeWEkvFsSwXSZV8f
         a2veQAiWxYoYrZxa+A5jKs1ui7YW1KPbyWsUyBCyEbQf2zlNjS8REvpD/A9FCF3i53sj
         thow==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=goHW682i;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=goHW682i;
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
	khc@pm.waw.pl,
	arve@android.com,
	tkjos@android.com,
	corbet@lwn.net,
	mchehab+samsung@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v7 00/14] firmware_loader changes for v4.18
Date: Thu, 10 May 2018 13:08:36 -0700
Message-Id: <20180510200850.5958-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600109081261448571?=
X-GMAIL-MSGID: =?utf-8?q?1600109081261448571?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Greg,

This is what I have queued up for the firmware_loader for v4.18. Below
is a changelog of the changes, mostly addressing Andre's changes and a few
other set of cleanups and documentation updates on my part and a few
others pointed out by others.

Mimi will still be working on her changes later to add IMA firmware
signature support, that should not touch the firmware loader code at all,
and should help provide a generic alternative to the wireless regulatory
signing work -- for all firmware.

Hans's EFI changes are still being worked on.

These changes are available in git form on my linux-next [0] and linux [1]
trees on kernel.org on the branch name firmware_loader_for-v4.18. Hans,
feel free to work off of that for your next iteration.

Questions, and specially rants are greatly appreciated.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20180510-firmware_loader_for-v4.18
[1] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20180510-firmware_loader_for-v4.18

v7:

- Annoted Reviewed-by tags.

- Installed codespell and am now using checkpatch.sh --codespell to check
each patch for spell check and blunders. Edited all files for
corrections missed by other reviewers.

- checkpatch complained about using ---help--- when I moved the Kconfig
file for the firmware loader so I replaced that now with what it
suggests.

- fixed the other series of typos pickd up by reviewers

v6:

- Added the firmware_request_nowarn() patch again, now that we've decided
on not to warn even for the fallback case.

v5:

- I took up Andres' patches and cleaned them up a bit further with
minor details which would have otherwise have taken a few more
iterations to do.

- Dropped the firmware_request_nowarn() patch since there was some
inconsistencies over actually not warning on the fallback case

- Added some further firmware loader Kconfig clarifications which have
come up through recent discussions.

- I dropped my firmware API rename changes for v4.18, so I adjusted
Andres' patches accordingly.

v4:

- Andres removed the async nowarn API call firmware_request_nowait2()
  from his series, given we got into a discussion over how to properly
add a new async API to the firmware loader and there was no real
consensus. Given I was tired of the bikeshedding I offered for folks
recommend a solution and for us to just go with it. None solution was
provided by any.  To not leave Andres hanging during patch review, I
made a set of recommendations but suggested that the asycn API be
punted until *after* we get the simple sync nowarn API added. The
recommendation still stands and my hope is that Andres will follow
up with it later:

https://lkml.kernel.org/r/20180422202609.GX14440@wotan.suse.de

- Andres dropped the drm/amdgpu/brcmfmac driver changes based on feedback
and becuase the async nowarn call was dropped in favor of addressing
this later.

v3:

- Andres fixed typos picked up by Randy Dunlap.

v2:

- Andres added request_firmware_nowait2()

- Based on feedback Andres extended his patches to include use of the new API
on the drivers amdgpu, ath10k and brcmfmac.

v1:

Andres only posted one patch to add request_firmware_optional() without
any users

Andres Rodriguez (6):
  firmware: wrap FW_OPT_* into an enum
  firmware: use () to terminate kernel-doc function names
  firmware: rename fw_sysfs_fallback to firmware_fallback_sysfs()
  firmware: add firmware_request_nowarn() - load firmware without
    warnings
  ath10k: use firmware_request_nowarn() to load firmware
  ath10k: re-enable the firmware fallback mechanism for testmode

Luis R. Rodriguez (8):
  firmware_loader: document firmware_sysfs_fallback()
  firmware_loader: enhance Kconfig documentation over FW_LOADER
  firmware_loader: replace ---help--- with help
  firmware_loader: move kconfig FW_LOADER entries to its own file
  firmware_loader: make firmware_fallback_sysfs() print more useful
  Documentation: fix few typos and clarifications for the firmware
    loader
  Documentation: remove stale firmware API reference
  Documentation: clarify firmware_class provenance and why we can't
    rename the module

 Documentation/dell_rbu.txt                    |   5 +-
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
 13 files changed, 320 insertions(+), 131 deletions(-)
 create mode 100644 drivers/base/firmware_loader/Kconfig

-- 
2.17.0
