Return-Path: <mchehab@smtp.s-opensource.com>
X-Google-Smtp-Source: AIpwx492YeZsVtoGb1WTJ/M1cvGEVaEOr9nSMHxZrIxT+XWAVAps7moWEqINXECJ93ag5YlvclV9
ARC-Seal: i=1; a=rsa-sha256; t=1522260777; cv=none;
        d=google.com; s=arc-20160816;
        b=tLZ1yQsUg3pXY+Fh1lvR9ycHzjJ55us/4wH/zAkKvLFrAvqn1lC2LlQdIHFDzTlN3N
         XNR6BdV5SICM+wJ6aqtWjpJ5wTXBxZ4kxFcz6SC/e+nmI3dgGIa+9Ot8tdqMkJ4qoK6+
         f2W8rK/TCfzrRFnYRsUByKYKkDDtaLIXpowJ1xpounMabO7j8RlShJAmkplRwYPCatgt
         uvcdp7E26XfPK86B6rgnknabVQHhEUXEKkiu65uA6yWAF4PmQ8flx5Jc337zRK3y2+En
         n7Cjk//bHESVw/YN5JHi9DORjjH4qLJwyL36Xke010Cz387trdari3RNARpRn4dleu6C
         R0lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=f7ohqIMNjlxCzYvP5+I449Jhhuk78Qa0YSfPGOGgBdg=;
        b=ZciVcnL7z41yOuX8w1sOeT6ka7PkH4k78er2Erafit6d5D4hznjpwhfPmZAXpvL4Y3
         RImnDZVt5q1cKfjD/WzDZtUaA+vm9GZ/LPl5YuxilnIio/mjXRShDOCpQZCmT/P8inZK
         dN61CHcyKiYuxGbx5DGxcVXbkGOkHiNZ5m7pVjqWIb2OtPvZPnbCL0F2Fh/hj0P1jwhF
         GTyITxivI7zBHUDFvqAlZkQV7vp//mNcSBiYjXzdUoUTtUR2xkIgB70awKQUEKFu5/oE
         yosI7E06M/R0VaurztDJMLGdaGHYV5BimDESIDuW77/c8VcpxXGNqmFH22Kp9jkfOhao
         BlCg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 64.30.133.232 is neither permitted nor denied by best guess record for domain of mchehab@smtp.s-opensource.com) smtp.mailfrom=mchehab@smtp.s-opensource.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 64.30.133.232 is neither permitted nor denied by best guess record for domain of mchehab@smtp.s-opensource.com) smtp.mailfrom=mchehab@smtp.s-opensource.com
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Linux Media Mailing List <linux-media@vger.kernel.org>,
	stable@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Mauro Carvalho Chehab <mchehab@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Inki Dae <inki.dae@samsung.com>,
	Brian Warner <brian.warner@samsung.com>
Subject: [PATCH for v3.18 00/18] Backport CVE-2017-13166 fixes to Kernel 3.18
Date: Wed, 28 Mar 2018 15:12:19 -0300
Message-Id: <cover.1522260310.git.mchehab@s-opensource.com>
X-Mailer: git-send-email 2.14.3
Sender: Mauro Carvalho Chehab <mchehab@smtp.s-opensource.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596206117324180738?=
X-GMAIL-MSGID: =?utf-8?q?1596206117324180738?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

Those are the backports meant to solve CVE-2017-13166 on Kernel 3.18.

It contains two v4l2-ctrls fixes that are required to avoid crashes
at the test application.

I wrote two patches myself for Kernel 3.18 in order to solve some
issues specific for Kernel 3.18 with aren't needed upstream.
one is actually a one-line change backport. The other one makes
sure that both 32-bits and 64-bits version of some ioctl calls
will return the same value for a reserved field.

I noticed an extra bug while testing it, but the bug also hits upstream,
and should be backported all the way down all stable/LTS versions.
So, I'll send it the usual way, after merging upsream.

Regards,
Mauro


Daniel Mentz (2):
  media: v4l2-compat-ioctl32: Copy v4l2_window->global_alpha
  media: v4l2-compat-ioctl32.c: refactor compat ioctl32 logic

Hans Verkuil (12):
  media: v4l2-ioctl.c: don't copy back the result for -ENOTTY
  media: v4l2-compat-ioctl32.c: add missing VIDIOC_PREPARE_BUF
  media: v4l2-compat-ioctl32.c: fix the indentation
  media: v4l2-compat-ioctl32.c: move 'helper' functions to
    __get/put_v4l2_format32
  media: v4l2-compat-ioctl32.c: avoid sizeof(type)
  media: v4l2-compat-ioctl32.c: copy m.userptr in put_v4l2_plane32
  media: v4l2-compat-ioctl32.c: fix ctrl_is_pointer
  media: v4l2-compat-ioctl32.c: make ctrl_is_pointer work for subdevs
  media: v4l2-compat-ioctl32.c: copy clip list in put_v4l2_window32
  media: v4l2-compat-ioctl32.c: drop pr_info for unknown buffer type
  media: v4l2-compat-ioctl32.c: don't copy back the result for certain
    errors
  media: v4l2-ctrls: fix sparse warning

Mauro Carvalho Chehab (2):
  media: v4l2-compat-ioctl32: use compat_u64 for video standard
  media: v4l2-compat-ioctl32: initialize a reserved field

Ricardo Ribalda (2):
  vb2: V4L2_BUF_FLAG_DONE is set after DQBUF
  media: media/v4l2-ctrls: volatiles should not generate CH_VALUE

 drivers/media/v4l2-core/v4l2-compat-ioctl32.c | 1020 +++++++++++++++----------
 drivers/media/v4l2-core/v4l2-ctrls.c          |   96 ++-
 drivers/media/v4l2-core/v4l2-ioctl.c          |    5 +-
 drivers/media/v4l2-core/videobuf2-core.c      |    5 +
 4 files changed, 691 insertions(+), 435 deletions(-)

-- 
2.14.3
