Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68347C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 08:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3643A21871
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 08:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vWS158X6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbfABI7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 03:59:42 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33179 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728939AbfABI7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 03:59:42 -0500
Received: by mail-lj1-f196.google.com with SMTP id v1-v6so26475671ljd.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 00:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LoPv9h3JHGZrNUfT0fWlwewqhAaH98JnDN8RA+KY8Xs=;
        b=vWS158X6ZAZW1IKL+pwBmGt9WwFILn/UYOgPbvTEz/D08QT3OZuKHOWh/77CUq6FZ6
         LB/djVF2IxNOvuekZGYVk1uFSo7TfvYsOvdQvm88i0J1FlnyxSSstXR0LFXTPm8ejK0m
         6LPu+K/aFyrih0+Us4JnC3vWJSpvir0cH0r5kJ5EziEifedlq8nCBJ6gvaVd8w7jcZBL
         +IqBOOqn3d73hmVlWC6U+CHqU54TxV4Xm4b+PrI5s1VP442sU04tEK3yj62s5tOSV2vp
         yTB9+rsCAIJJC6pGrJtFFZpAefKo4VGM71NL6YknDku2yISD88n/53zMWr+esHqPFRMH
         LPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LoPv9h3JHGZrNUfT0fWlwewqhAaH98JnDN8RA+KY8Xs=;
        b=l3USyyoq+edZOutwdDcU1QJv/wzk1fZgk9S1Og+UyFfJH1UNQ86yJVf0zs2uJ9sW/J
         ntmS7f+GNWL82feS4MZOsDRKhd9L8sRHjTEd5+mnry/UrK5QYHw44JZ5utap4TvHohyE
         xzTfct8lnOYbKtAtiZPYHobSHQ9rV7u91PJ+S4/kPNoqyg7pQxkJAaKXuZjIs6Rcu/Kv
         Fb3N8PI9m8bAnezF8USNQxSewqiS26xNBrL2uLVBE6QhtuC2xTkDF5OJ60UG9jZpg+GD
         qJRbaYgVHeI5Yf1lfdBOUYZxlWUGr6tXc0xg1LEszAc3WTZi9bjWd/U7xaAPdmew+qJm
         mRDw==
X-Gm-Message-State: AJcUukcIk9RrYYWakR7ttG2c7oJUo1UcUD48ZM5LiUkwNQZ2PbsYvr0T
        NBjTqryx51f4lYwGtrFH1jY=
X-Google-Smtp-Source: ALg8bN7yu+VIFKbOf4p7ezfDAWAxkU+nTuly044jrjV0RJEkA2e+1LcbnsFS4B5xXrwv09bjIzWwzw==
X-Received: by 2002:a2e:4942:: with SMTP id b2-v6mr2750431ljd.168.1546419579053;
        Wed, 02 Jan 2019 00:59:39 -0800 (PST)
Received: from localhost.localdomain (mm-79-4-214-37.mogilev.dynamic.pppoe.byfly.by. [37.214.4.79])
        by smtp.gmail.com with ESMTPSA id 10sm7489670ljr.4.2019.01.02.00.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 00:59:38 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Michal Hocko <mhocko@suse.com>, Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [RFC v3 0/3] test driver to analyse vmalloc allocator
Date:   Wed,  2 Jan 2019 09:59:21 +0100
Message-Id: <20190102085924.14145-1-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

This is v3.

The first RFC was here: https://lkml.org/lkml/2018/11/13/957
Please have a look there for detailed description and discussion.

Changes in v3:
    - Export __vmalloc_node_range() with _GPL-only prefix;
    - Add skip cases if the test can not be executed in current environment.
      That is kselftest framework requirement.

Changes in v2:
    - Code cleanup to make it more simple;
    - Now __vmalloc_node_range() is exported if CONFIG_TEST_VMALLOC_MODULE=m
    - Integrate vmalloc test suite into tools/testing/selftests/vm

Appreciate your comments and feedback, so please RFC v3.

Thank you.

Uladzislau Rezki (Sony) (3):
  vmalloc: export __vmalloc_node_range for CONFIG_TEST_VMALLOC_MODULE
  vmalloc: add test driver to analyse vmalloc allocator
  selftests/vm: add script helper for CONFIG_TEST_VMALLOC_MODULE

 lib/Kconfig.debug                          |  12 +
 lib/Makefile                               |   1 +
 lib/test_vmalloc.c                         | 543 +++++++++++++++++++++++++++++
 mm/vmalloc.c                               |   9 +
 tools/testing/selftests/vm/run_vmtests     |  16 +
 tools/testing/selftests/vm/test_vmalloc.sh | 176 ++++++++++
 6 files changed, 757 insertions(+)
 create mode 100644 lib/test_vmalloc.c
 create mode 100755 tools/testing/selftests/vm/test_vmalloc.sh

-- 
2.11.0

