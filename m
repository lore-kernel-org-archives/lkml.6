Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZpMAVdSzoFAHtE4ck+qfPovhP04YT8LrZ4EgnIlo2/5wGkR6xq7wEWx0gUgQgJsf9ADaG9B
ARC-Seal: i=1; a=rsa-sha256; t=1525215307; cv=none;
        d=google.com; s=arc-20160816;
        b=lnmoYXABH5CI+HnrrqroftirHWG4GCV0/KT1xQb0uiFo4V0rOSceB+BcFuBaZNJ28c
         Sjs4Tjen18zpD1Asc9yVT9OjjLYJlP9YdnJyH9myaitytLSRsEeZhgxzJU+Gf73i2raz
         hOqVMWCV4T8q9NVEpuz3Us00lZBLdn0fbDnqHTiLzEkK/cURj8VX3lHQaC7EteOo3idD
         zx9g6BjEdPyydp8n8L73Ts4BJZgx5FGK3F6T8jkgcR9qD0Un7pmFBklPpzELpKtyHx/s
         8z6Q2jl80hjEB50qCFMP3kqVKC4w9W0I/NT4mhArAHApP3lULvh9idcL5iQHYcWkiuhV
         fi6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=WS5TRV9y8MX0x1Z4AEQ/ammxwL4K29vOMQGJFMZ3/58=;
        b=KPVBNgGXE4dbbaoNFPC6muDHNgpg4MnW1lbfW2jIGA4/ohTce6IAL2ZggWH6Dok/aG
         xWcn9tiPzw2T5kjqN9zRhNaIzT/R+XgQ3TF8RfVZeeuLuXyqwF6nhfSVh60GP9EbIKGG
         CmdS1CcHYzXaxI4UKWDoAfFhPFR1pbSTMzqJEQeEgFRgiWz3oMqeOhmIIrSPzYjUrcIW
         xy9UgyoGtYwddkNOVp2h7RwFujUOPsQfdcRxe/PVLtJ70eGex2N/u/a/rWHEWnrnYKap
         qjvpylHRKDJvPUcA1ay0TPYegr5o2glSSSNhUgJaKd52vDhe93EC2NtZU/DmPiZ2fCym
         3TQA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbeEAWzG (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 1 May 2018 18:55:06 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:38343 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbeEAWzF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 May 2018 18:55:05 -0400
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] Kselftest framework SKIP handling
Date: Tue,  1 May 2018 16:54:32 -0600
Message-Id: <cover.1525212671.git.shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599304165769785836?=
X-GMAIL-MSGID: =?utf-8?q?1599304165769785836?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Kselftest framework currently treats all non-zero return codes from tests
as failures. When tests are skipped with non-zero return code, because of
unmet dependencies and/or unsupported configuration, it reports them as
failed. This will lead to too many false negatives even on the tests that
couldn't be run.

This patch series fixes the problem by adding SKIP handling:

The common RUN_TESTS and EMIT_TESTS functions are changed to test for
SKIP=4 return from tests. This change enables the framework and tests
that return SKIP=4 will report SKIP, other continue to report FAIL/PASS.

KSFT_SKIP has been changed to report Skip code of 4 instead of KSFT_PASS
to clearly differentiate the skipped tests.

I am working on Test changes to report SKIP instead FAIL/PASS when they get
skipped. I will be sending them out later this week.

In addition, I made changes to improve the reporting and cleaned up both
RUN_TESTS and EMIT_TESTS define to remove duplicate test output strings.

Shuah Khan (Samsung OSG) (7):
  selftests: lib.mk: cleanup RUN_TESTS define and make it readable
  selftests: lib.mk: add SKIP handling to RUN_TESTS define
  selftests: lib.mk: move running and printing result to a new function
  selftests: lib.mk: Include test suite name in the RUN_TESTS output
  selftests: lib.mk: add SKIP handling and test suite name to EMIT_TESTS
  selftests: lib.mk: add test execute bit check to EMIT_TESTS
  selftests: kselftest: change KSFT_SKIP=4 instead of KSFT_PASS

 tools/testing/selftests/Makefile    |  3 +-
 tools/testing/selftests/kselftest.h |  2 +-
 tools/testing/selftests/lib.mk      | 55 +++++++++++++++++++++++++++----------
 3 files changed, 44 insertions(+), 16 deletions(-)

-- 
2.14.1

