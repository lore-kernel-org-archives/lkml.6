Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEE6C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E6920815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T86KhqWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbfACOWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 09:22:33 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45620 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfACOWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 09:22:33 -0500
Received: by mail-lj1-f194.google.com with SMTP id s5-v6so29803249ljd.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 06:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=f6iOq0POHj82kuJ9vOuksRhtjIgtyuat0RT8EdWn87M=;
        b=T86KhqWp+RQ0FJ4yUD/lMVNq9HnPyhAZJrxZ7PjpPxduvZMaRQg+XUmImC59e/0cz+
         AkaqbPwuzPdGzuuVTmWyE7KCilsEe0VORV/0dbPbWblBqeH4tQd6mE17CMf2ErsDNOHw
         ZTa18JewfgO5f89d1jw3O5PGY7cFigf6OrudyKbEoqwGtMcl6IBguaZUQ+Hpf8O9T4Rd
         KSFHYIyfEO/JFsOtsPJ5WM7y6TnQiMCmSltumYNBuMUsY3gTMZhUDrbmsh8Q6ORXg6H2
         SJt3jcd3kF9ffWnKdy9hNu6GAQ7t3iVMT7Z+wsIpFPYlFCOJ6MX146WCosoFPYqotX5j
         XEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f6iOq0POHj82kuJ9vOuksRhtjIgtyuat0RT8EdWn87M=;
        b=sLrl3da7kaIuqGnkXjfZnsbVFvDjqheiEaFLBwpYz5brOuaERo9ZJ29bv/xAIv7JYg
         JrCIGmA7QmpXW7ORf5xwmc8joTEIK9K+vzO4UgVdL8J1JGy5MFAZPhy069zOoLRT7Etj
         eN7aGCsjQ4Qwn6Us31rsa7XLMlR4kEu25Ose/yhqKBXNtjgSAXZMvaRAtdL6J0/cAjWM
         3MaD0pEKljR9guaJAxKPB0otqjMghuq49lUWAK8fC5ZwXry4lW6lq/IEwoWvk1itDky2
         xg6C79lYmRmPRbKXduKcg1H2APOT89dlUPK8cf+W1yn5v6FXPbJAS91FYVVEcgYBPZfb
         anCw==
X-Gm-Message-State: AJcUukfJsca0EWBBbTCcjHf10QuiXe8zFa3gnCKwORLT4GQk564P64FJ
        nN59m2qA/HvnATLya0a6nn6I9LD717zXgA==
X-Google-Smtp-Source: ALg8bN7yn2PFzXoUoKHzjvxwxQQkCMPA8WLRFMUOk1gLnwDJNRTSpNXFm7n5RdAc99ZVKhlC/mOOCg==
X-Received: by 2002:a2e:4a19:: with SMTP id x25-v6mr25958077lja.19.1546525351199;
        Thu, 03 Jan 2019 06:22:31 -0800 (PST)
Received: from localhost.localdomain ([37.212.195.0])
        by smtp.gmail.com with ESMTPSA id b25sm10594690lfa.96.2019.01.03.06.22.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 06:22:30 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [RFC PATCH v4 0/3] test driver to analyse vmalloc allocator
Date:   Thu,  3 Jan 2019 15:21:05 +0100
Message-Id: <20190103142108.20744-1-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

This is v4. I think it is ready to go with, unless there are extra requests
or comments.

Changes in v4:
    - Since the test can take time, switch to wait_for_completion_timeout()
      with HZ sleep interval to prevent triggering of the trace about hung
      task;
    - Fix clean apply for v4.20 kernel.

Changes in v3:
    - Export __vmalloc_node_range() with _GPL-only prefix;
    - Add skip cases if the test can not be executed in current environment.
      That is kselftest framework requirement.

Changes in v2:
    - Code cleanup to make it more simple;
    - Now __vmalloc_node_range() is exported if CONFIG_TEST_VMALLOC_MODULE=m
    - Integrate vmalloc test suite into tools/testing/selftests/vm

I think it is ready to go with, unless there are more requests or comments.

Thank you in advance.

Uladzislau Rezki (Sony) (3):
  vmalloc: export __vmalloc_node_range for CONFIG_TEST_VMALLOC_MODULE
  vmalloc: add test driver to analyse vmalloc allocator
  selftests/vm: add script helper for CONFIG_TEST_VMALLOC_MODULE

 lib/Kconfig.debug                          |  12 +
 lib/Makefile                               |   1 +
 lib/test_vmalloc.c                         | 548 +++++++++++++++++++++++++++++
 mm/vmalloc.c                               |   9 +
 tools/testing/selftests/vm/run_vmtests     |  16 +
 tools/testing/selftests/vm/test_vmalloc.sh | 176 +++++++++
 6 files changed, 762 insertions(+)
 create mode 100644 lib/test_vmalloc.c
 create mode 100755 tools/testing/selftests/vm/test_vmalloc.sh

-- 
2.11.0

