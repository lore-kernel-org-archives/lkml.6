Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AB8JxZogfz70Ai6zLbCoGsbAHCUYXKRusdtxwy/sbTCUqj1aNsGyIWjbARpwXFLn8HvBPndIMMuF
ARC-Seal: i=1; a=rsa-sha256; t=1525146782; cv=none;
        d=google.com; s=arc-20160816;
        b=PPCXkuT69CSQENR/XRP3nb4hmj7UkPaLAovUYGYg0wsuSS70sco0mv3jAGMciqJXvg
         4lftv5xDXMPyjS6OC6lCGury7Hcw0ehQkHUp2kRDCDDBlhyhezZHLV5t85fF8uBo6nb5
         +hsX9NV+QLIBXI+Cec4KFb9uENFWTOo2XdcotgUXqspq1gl/D7LOBhxHMicC5O9WHuOQ
         3VCgTa7W6raVzaeenOzFx0io0ettiCAqq6xCm2wVpmgT54iaFz4jPMI0hnrmmYgObSPJ
         20rzVIGK+QAUpp2VgUI8EyC5hVYqb7oSGbsBSVLgL3B5MGAc6Z+7QF3Ub5uOp7TsSd4s
         zirQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:message-id:cc
         :subject:date:to:from:arc-authentication-results;
        bh=JMQrrGzG8gY3knOo/YVSCjDCKUb/pDXY9XXb4P5H5Eg=;
        b=lQmP/0p6uo4r577QtTrTKT5dR9eExHjWjkHIsnWdhlf9/cpAntAAbDDe0yMPU7D4K1
         XcyKr/wEaqo2ekRpngsdIfS8kf2ls7CtSAhY0em5ab16rN1YMVwpUpCg+3WigU6BL3uA
         jUE0e+etdfa5ZJclLEZsSniajOkQx96oQNmVbvuDBKGfFSfRX1qgXYov53Odb6nAmRY7
         FJL3Ao4mx6/uEC6Zb2j9IODozMErOY7A2CxuLlHxILARCBHlaBL4bwzUNxYcyx7kx6D1
         GaeAbYpAQr/jNxK69kldgDxiSayFYA4eKKVnka2IbDCQ/lL2vYcuEZXcQft5IjuxyCrY
         qE3w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Tue, 01 May 2018 13:52:38 +1000
Subject: [PATCH 00/10] staging: lustre: assorted improvements.
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152514658325.17843.11455067361317157487.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599232311872588583?=
X-GMAIL-MSGID: =?utf-8?q?1599232311872588583?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
 drivers/staging/lustre/lnet/libcfs/module.c        |  162 ++++++++++++++++-
 drivers/staging/lustre/lustre/include/lu_object.h  |   36 ----
 drivers/staging/lustre/lustre/include/lustre_dlm.h |    5 -
 drivers/staging/lustre/lustre/ldlm/ldlm_resource.c |    5 +
 drivers/staging/lustre/lustre/llite/lcommon_cl.c   |    8 -
 drivers/staging/lustre/lustre/llite/namei.c        |    8 +
 drivers/staging/lustre/lustre/llite/vvp_dev.c      |  169 ++++++++---------
 drivers/staging/lustre/lustre/lov/lov_object.c     |    8 -
 drivers/staging/lustre/lustre/obdclass/lu_object.c |  169 ++++++++---------
 12 files changed, 341 insertions(+), 432 deletions(-)
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/linux/linux-module.c

--
Signature
