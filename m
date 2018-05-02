Return-Path: <amit.pundir@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525283295; cv=none;
        d=google.com; s=arc-20160816;
        b=VyjJrsWJ9fSgyyiLkcFqgO5oGXGytTSwyJ8OQe0mOcX0ihkWRDS0zqVSeoVOZYM1ax
         rIXWi71wlandQjBxGNZU+/ZDT+AsGnFGYG80Ewr2fWz1Z0Y08jRi4xxZ/5n+DfDSVD5/
         GDq84vPcKk90QWT/7ZTwrAfGcQC+Ak1PC+RBKFEoFmWo9JaJKT0i8A+wta1nDogMMw1f
         mPvZPlhy99urn4kQXNv+iDtWZFddmRqfg18hyfiq2oySJAraTQic1yTabKWJvUOPXYg6
         fiJ968R+iwo9/SNpT1kfl2DcfQ8zFxi+vlum1e0vNexw+8ZAPC2Pr+t+XIGBzqY7ieIv
         mM8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=author:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=ddeszqe6r7PdpAqnLUsnNOlTVyOTDhhGAYbJIrhZJOA=;
        b=CnwFnDpl1hIxil2vdeF0Jflui8NxMCg+w6/WMAy/lkPaY9ZHDAfYoCs3Mz9BsVsHpe
         od17E9RQHu8LVNZs4hldSFPz9eUgYTuNuHW9/7Buwfpud5JEHOxWQWQMaEJumRGuSzPG
         CKR7XHOxUEDuWyX3DiQnji/meToiqDJai5YjFMVJlmLXzziCRnI/b59pG4Q0Ug8Xs7bh
         MCn3GK/08hKLM4xJO3J3sdmTONJWMdavbREmcfT49yQuQ8uW4p7InZR0Mx6fyM6m/qIM
         ANtpw4oHR7hlLTRtbaEP9IQmuGHyQ1TrTWZ29MF2atDpIdO3kYYA+ee4P2WDt4whlCHc
         cSdg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=fX3YYUEd;
       spf=pass (google.com: domain of amit.pundir@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=amit.pundir@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=fX3YYUEd;
       spf=pass (google.com: domain of amit.pundir@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=amit.pundir@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZqDwdiCSL+0bnUzjaNdbnOYQODeGFVNQLM9fcO6zAePAmsnDVjyONjFd+OVo2FKKCL8G7nlsw==
From: Amit Pundir <amit.pundir@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>,
	linux-wireless@vger.kernel.org
Cc: Suren Baghdasaryan <surenb@google.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Christophe Ricard <christophe.ricard@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	John Stultz <john.stultz@linaro.org>,
	Dmitry Shmidt <dimitrysh@google.com>,
	Todd Kjos <tkjos@google.com>,
	Android Kernel Team <kernel-team@android.com>
Subject: [PATCH v2 0/3] Few NFC fixes from android-4.14 tree
Date: Wed,  2 May 2018 23:18:05 +0530
Message-Id: <1525283288-7027-1-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
Author: Amit Pundir <amit.pundir@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599375456929773839?=
X-GMAIL-MSGID: =?utf-8?q?1599375456929773839?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

Submitting v2 of NFC fixes I picked up from android-4.14 tree[1]
for review and comments.

Again like to point out that I have not feature tested these patches
at all. Only made small cosmetic changes to the original patches
(removed Android-only tag and internal bug ID) and build tested for
arm, before posting them here for review.

Really appreciate any comments or feedback on how to take it forward.

Changes since v1:
* Dropped "NFC: st21nfca: Fix memory OOB and leak issues in connectivity
  events handler" patch for now. I'm yet to verify if the additional
  aid_len and params_len checks for buffer size are really required, and
  I didn't want to hold up this patch series for one patch alone.
* Dropped redundant __func__ use dev_dbg() in "NFC: fdp: Fix possible
  buffer overflow in WCS4000 NFC driver" patch.

Also drivers/nfc/fdp/ is full of __func__ parameter usage in dev_dbg(),
so submitting a new patch separately to clean that up.

Regards,
Amit Pundir
[1] https://android.googlesource.com/kernel/common/+log/android-4.14

Suren Baghdasaryan (3):
  NFC: st21nfca: Fix out of bounds kernel access when handling ATR_REQ
  NFC: Fix possible memory corruption when handling SHDLC I-Frame
    commands
  NFC: fdp: Fix possible buffer overflow in WCS4000 NFC driver

 drivers/nfc/fdp/fdp.c      | 22 +++++++++++-----------
 drivers/nfc/fdp/i2c.c      | 29 ++++++++++++++++++-----------
 drivers/nfc/st21nfca/dep.c |  3 ++-
 net/nfc/hci/core.c         | 10 ++++++++++
 4 files changed, 41 insertions(+), 23 deletions(-)

-- 
2.7.4
