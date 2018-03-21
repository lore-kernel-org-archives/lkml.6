Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AG47ELurAxuuSZZG1shiBqlBCJ3Q4O+jt5AtADbFX74wEiyC/II+ERZYhoH/KDvRAfj8KX5rOsmK
ARC-Seal: i=1; a=rsa-sha256; t=1521671674; cv=none;
        d=google.com; s=arc-20160816;
        b=o85ZeKnvum8fH07XJx/nmNyzT5eYFO5Rq8hM8HoF0AZWOkymDMa7SpCcPku+r2r2vP
         NCwLxUb3gYecunZq+Cr5tOFULfyN2ex/tXRZicy4p/jsL0ykRd+4uKnPxQKc1BmJSTOy
         op1HVt548BXKjkYzmiiLCjw9Pv0Jp4cS+Otarz5xj3tI6dgeMuNNsLE1pbhJqj3KopJP
         2QjfPF4Q4NuOVn1FLPHQyaDkUacm9uqJ0d2OlRl0FPfqESDrp5pDcEsT/bEyMBlt/wz3
         s7u2L2M7FGOBR3y3XDIMWaIIU0d3YBdVmnTJx/MCo6C5mcEtsXau7TFuagBa29d0NLbe
         Stkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dmarc-filter
         :arc-authentication-results;
        bh=rTFt30UpAqnbjyyHfHUno7jn8G9v24zwy0Wyoxg7U+U=;
        b=olvDLo8ATXiNL/AmAXSPOF+EroXZrMEYoM2J+4SuebKoy5TZ+SgGzgaMNdRFkbNzvz
         GPdO9ZKF7BAz8RJBryimMIguag3e/vUyddXmHnbMhAl6CTBBGzZc+z5JFtDljdRjSYF1
         kxhsu7YmB3cuVGm/pb3Ey022d8qHUBrPHoWYfYuJuM1w6f1qEoIiNxLCButbzky2hbr5
         b23JMXgvRKxe/C//AVOQcobP9+WHgcC94NpK/h1RBn/mLpFcj20fcMgmNhQh1O5OnJWa
         AMw2BwY92cQpVDAYqRbnN68hJ5YeQCLWC5LilMZN0JJw//2uoigkKhYV4gn5J67qzdbo
         S6/g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABC27217D8
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
Subject: [PATCH v4 0/3] firmware: add firmware_request_cache()
Date: Wed, 21 Mar 2018 15:34:27 -0700
Message-Id: <20180321223430.21388-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595588397118895563?=
X-GMAIL-MSGID: =?utf-8?q?1595588397118895563?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Greg,

Here are the last straggler patches to clean up what was left which you
requested and to add the new firmware_request_cache() call to fix a
corner case suspend issue.

The extra space character you found in earlier patches no longer needs
to be fixed as that assignement was replaced with a new line in later
patches which does not have the extra space in the assignment. The only
other straggler fix needed which you had pointed out was the debugfs typo.

The new API call was renamed as suggested to firmware_request_cache(),
with the API name first. I'll use a separate series to start addressing
the firmware API rename for the rest of the callers. That will take some
time as I'm running quite a bit of tests on those changes and I am going
to wait for 0-day to give me its blesssings.

Question, feedback, and specially rants are greatly appreciated.

  Luis

Luis R. Rodriguez (3):
  firmware: fix typo on pr_info_once() when ignore_sysfs_fallback is
    used
  firmware: add firmware_request_cache() to help with cache on reboot
  mt7601u: use firmware_request_cache() to address cache on reboot

 .../driver-api/firmware/request_firmware.rst       | 14 +++++++++++++
 drivers/base/firmware_loader/fallback.c            |  2 +-
 drivers/base/firmware_loader/main.c                | 24 ++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt7601u/mcu.c        |  2 +-
 include/linux/firmware.h                           |  3 +++
 5 files changed, 43 insertions(+), 2 deletions(-)

-- 
2.16.2
