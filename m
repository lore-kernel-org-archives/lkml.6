Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E03C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B33208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wAkXY1rj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B33208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932149AbeFTPYg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:24:36 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38941 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753938AbeFTPYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:24:31 -0400
Received: by mail-wr0-f193.google.com with SMTP id w7-v6so3730121wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 08:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=okiTSK1tdrD6CxI+XnDS0dRhQiJPuer6SaivSONRTCE=;
        b=wAkXY1rjeaSfKbTo0Fum9wsLODSwsEgrk0pDhSDejSI5AsqkzbqODUJgbynZFECj1h
         jRPDhd8j95hcADElXXMWCDwu9o9cZ8oymkItZbSXeoN638cCxyuhlnJ17JUo0iJa8uwG
         fI2Xde95xX8XXVl1dQMu0N/jI0F3Kym89rOFv69I3gGu1nY3L7veIPDCxDtlErufvzbN
         vr2ffmx/chvGAaBjRbBdQCEo6BBQn9pjVhWEtnEk5TflJo4IyUbKJccSCRqw25cfQqzO
         Zb3QA/pmbkeNum7VPxh19o6M8E8uMUbXe0vFafFfg8ndf2O9LDQ669AOFl9HgjuEWW9Z
         60lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=okiTSK1tdrD6CxI+XnDS0dRhQiJPuer6SaivSONRTCE=;
        b=Z1AWiEE0133thZSYCxrU4+6Wsl2Ma5df0yvAAgZYdHHqK+F5iNsUbLHY/R1l436eLy
         WfzvXBngLKOeL5MyWfGDWPACHJILlnnRO8CfiikKAFcSAmKWN33aVghF0aXtQeQ/prFM
         rurtrzV5UDxOMvFAl4YbwwNqvZCCWOiGtvUAlMxMPLg1YZCSg38W7C6XDmHyyUq8cQmY
         D8+BthTR3DwQ25pIZ6OqdCHk96EcN6tuXYUTPNLKGOGSfS/YzkN7sOadXisn+u/MW6RW
         ZpnpIamvVL6U9Z8Dbr+t3wd/qy+krKGJO2XiPHqcGhgqMnN5qySv3zMRzKcLfxihQU2y
         hl2w==
X-Gm-Message-State: APt69E2+69CTQOMJjhOWGpgUxPHhwc3jM1qBNeIf9Qq5r6UezSd/zMzL
        oKfji4+mLccCWOMMNltlLW3bsA==
X-Google-Smtp-Source: ADUXVKJEau/gfjiIEOl3/Ebp+0kZaJllVFcjuDsnKCcg3WW93hqn/jPNBrY2lLHfHWDppOl84MSryA==
X-Received: by 2002:adf:ebc3:: with SMTP id v3-v6mr18085294wrn.33.1529508270029;
        Wed, 20 Jun 2018 08:24:30 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id c11-v6sm3959244wrm.65.2018.06.20.08.24.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 08:24:29 -0700 (PDT)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v4 0/7] arm64: untag user pointers passed to the kernel
Date:   Wed, 20 Jun 2018 17:24:19 +0200
Message-Id: <cover.1529507994.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64 has a feature called Top Byte Ignore, which allows to embed pointer
tags into the top byte of each pointer. Userspace programs (such as
HWASan, a memory debugging tool [1]) might use this feature and pass
tagged user pointers to the kernel through syscalls or other interfaces.

This patch makes a few of the kernel interfaces accept tagged user
pointers. The kernel is already able to handle user faults with tagged
pointers and has the untagged_addr macro, which this patchset reuses.

We're not trying to cover all possible ways the kernel accepts user
pointers in one patchset, so this one should be considered as a start.

Thanks!

[1] http://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html

Changes in v4:
- Added a selftest for checking that passing tagged pointers to the 
  kernel succeeds.
- Rebased onto 81e97f013 (4.18-rc1+).

Changes in v3:
- Rebased onto e5c51f30 (4.17-rc6+).
- Added linux-arch@ to the list of recipients.

Changes in v2:
- Rebased onto 2d618bdf (4.17-rc3+).
- Removed excessive untagging in gup.c.
- Removed untagging pointers returned from __uaccess_mask_ptr.

Changes in v1:
- Rebased onto 4.17-rc1.

Changes in RFC v2:
- Added "#ifndef untagged_addr..." fallback in linux/uaccess.h instead of
  defining it for each arch individually.
- Updated Documentation/arm64/tagged-pointers.txt.
- Dropped “mm, arm64: untag user addresses in memory syscalls”.
- Rebased onto 3eb2ce82 (4.16-rc7).

Andrey Konovalov (7):
  arm64: add type casts to untagged_addr macro
  uaccess: add untagged_addr definition for other arches
  arm64: untag user addresses in access_ok and __uaccess_mask_ptr
  mm, arm64: untag user addresses in mm/gup.c
  lib, arm64: untag addrs passed to strncpy_from_user and strnlen_user
  arm64: update Documentation/arm64/tagged-pointers.txt
  selftests, arm64: add a selftest for passing tagged pointers to kernel

 Documentation/arm64/tagged-pointers.txt       |  5 +++--
 arch/arm64/include/asm/uaccess.h              | 14 +++++++++-----
 include/linux/uaccess.h                       |  4 ++++
 lib/strncpy_from_user.c                       |  2 ++
 lib/strnlen_user.c                            |  2 ++
 mm/gup.c                                      |  4 ++++
 tools/testing/selftests/arm64/.gitignore      |  1 +
 tools/testing/selftests/arm64/Makefile        | 11 +++++++++++
 .../testing/selftests/arm64/run_tags_test.sh  | 12 ++++++++++++
 tools/testing/selftests/arm64/tags_test.c     | 19 +++++++++++++++++++
 10 files changed, 67 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/arm64/.gitignore
 create mode 100644 tools/testing/selftests/arm64/Makefile
 create mode 100755 tools/testing/selftests/arm64/run_tags_test.sh
 create mode 100644 tools/testing/selftests/arm64/tags_test.c

-- 
2.18.0.rc1.244.gcf134e6275-goog

