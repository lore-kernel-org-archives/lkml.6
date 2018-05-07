Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AB8JxZp6k6WYCL+M9DgNGJ1fJrusU2XE9e+rz6OoExWucudzpVcDyPrPJehSLrIyS/jiPOQO8ozF
ARC-Seal: i=1; a=rsa-sha256; t=1525654522; cv=none;
        d=google.com; s=arc-20160816;
        b=xDXHUNtMEGiDmdXZMgO+zqDehUbwHU3VRBCRcIJNg1gLe94LMVPGGBERe6dz8CTZju
         rcrPBZk+sDGrXWYvmm5n1GHbzlxgz9Pm7Lp8CBblr+1Nf92APKev3dQYp95cSpS1Yh0Z
         F6wOObC5zu2Rn+yELVjc7mI8ES3jwHfoOZZef23NHusGLpPbFukv3CFFx5KAYLwbT5Ha
         SX5UEUbSGmWZAXZmisgDiIUi1uhFWX3fS4aF+EobEKkAk+oZLpoOaH9mLJ25wyK5hk3P
         ifJhVBE5kDSI88BprKRBKA/v9aoGM48ZT4NIm5RXVWUQssj5OSMz94lYx57wCxzbneQt
         wPJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:message-id:cc
         :subject:date:to:from:arc-authentication-results;
        bh=T6l9RlqBVXqYL8zmXQilGtB0i+qZNZkeXsb8wpMi/MM=;
        b=lwoBupIZQCUgREJbGkb3/4PPzPsPjJh1bJbhIMkrCjdRX7FIm+BLWoWhtLkEkoXGZx
         7TwG4ErhhRkIn2CQM5Coggi4oTd8ch5SXDlpCSGjwafKhYgJSzqw8UJ7EpXOVE0370V1
         CuI7FSmz7k1Dmj4Cre/Nle2F6+dXWcFmS46NmC2JFhRfaGkr9c3EGWsFGrPsJiemYD8o
         34pk6doVnbIXm2BU5qmr/h3u5TFmbEwsQjZKmMnk67ixfrhH4qnOSUtC0l9nVULJ0UI1
         huQgLew5S/y6laJaCFqsz21cRIyHmB5L4Ip5LGXPWd/Vn3kxHcmbKD5kkmuZZ+KwiwDG
         V/+A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Mon, 07 May 2018 10:54:47 +1000
Subject: [PATCH 00/10 - v2] staging: lustre: assorted improvements.
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152565436690.30131.2229703651041382739.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599764716655163886?=
X-GMAIL-MSGID: =?utf-8?q?1599764716655163886?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This v2 series contains some fixes for issue found
during review - particularly the share/exclusive locking
confusion of the hash table in one place, and a missing
EXPORT_SYMPOL.  It also adds some reviewed-by tags.

original intro:

First 6 patches are clean-up patches that I pulled out
of my rhashtable series.  I think these stand alone as
good cleanups, and having them upstream makes the rhashtable
series shorter to ease further review.

Second 2 are revised versions of patches I sent previously that
had conflicts with other patches that landed first.

Last is a bugfix for an issue James mentioned a while back.

Thanks,
NeilBrown


---

NeilBrown (10):
      staging: lustre: ldlm: store name directly in namespace.
      staging: lustre: make struct lu_site_bkt_data private
      staging: lustre: lu_object: discard extra lru count.
      staging: lustre: lu_object: move retry logic inside htable_lookup
      staging: lustre: fold lu_object_new() into lu_object_find_at()
      staging: lustre: llite: use more private data in dump_pgcache
      staging: lustre: llite: remove redundant lookup in dump_pgcache
      staging: lustre: move misc-device registration closer to related code.
      staging: lustre: move remaining code from linux-module.c to module.c
      staging: lustre: fix error deref in ll_splice_alias().


 .../staging/lustre/include/linux/libcfs/libcfs.h   |    6 -
 drivers/staging/lustre/lnet/libcfs/Makefile        |    1 
 .../lustre/lnet/libcfs/linux/linux-module.c        |  196 --------------------
 drivers/staging/lustre/lnet/libcfs/module.c        |  161 ++++++++++++++++
 drivers/staging/lustre/lustre/include/lu_object.h  |   36 ----
 drivers/staging/lustre/lustre/include/lustre_dlm.h |    5 -
 drivers/staging/lustre/lustre/ldlm/ldlm_resource.c |    5 +
 drivers/staging/lustre/lustre/llite/lcommon_cl.c   |    8 -
 drivers/staging/lustre/lustre/llite/namei.c        |    9 +
 drivers/staging/lustre/lustre/llite/vvp_dev.c      |  166 +++++++----------
 drivers/staging/lustre/lustre/lov/lov_object.c     |    8 -
 drivers/staging/lustre/lustre/obdclass/lu_object.c |  174 +++++++++---------
 12 files changed, 346 insertions(+), 429 deletions(-)
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/linux/linux-module.c

--
Signature
