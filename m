Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0D7C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F9B205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Sga727bc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F9B205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbeJ3H0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 03:26:30 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:32860 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbeJ3H0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 03:26:30 -0400
Received: by mail-ed1-f68.google.com with SMTP id f1-v6so8797357edi.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 15:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FF8g/pMdvQa6yv/XmJbBWW+3kAF157w5oAKda6jmcyA=;
        b=Sga727bckwW9O6pQdlOxfkvF3ii5uggDoeHe3Ac8YUPPqDh48yMVw2zERFdiv4+3Ub
         OFBAiRFexgkBWRW12K/F75ggrhIunrr7XMYsAUm3/uMq2EHVDnxX0Hm2aQesHG2m40Ci
         9FhrD3L9XlWYRAvlOd+U4moG/7AG1QS7wsh1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FF8g/pMdvQa6yv/XmJbBWW+3kAF157w5oAKda6jmcyA=;
        b=O5LxJeHf/PUeQCJyUN/gUZYtsOsk8imR1JG5IafCD6K77pO9EZikGyAvjZ2+XuT4/J
         ewQ+KAqzGylhsVw/WM8xPCy7eHLrBTDKA0IX+yttssSJ5iaYcosV963jagX/YjjEK2a8
         U4AFMdJiB3CLurNXz/VSYQ0/0Lb4lxKAn0QnGRfbbbnMzliga2gLC2cSTO/JK2uK92LJ
         kmSEBJZg6urSYqiPmDeFlyCqLN6EnKnnCzT5PDy/DvblsBKmOfsM+5JIp9tFhuQQgLSH
         /+Zb+Razoop+s6RsL21usruNFwLmbcB9/4YjUhoFLyAJqJip0t+CPMokZeuyWbIQu+qM
         hsCQ==
X-Gm-Message-State: AGRZ1gLhgFM6iXUQYuCQ+MpwuTxPe3CEy28+LyzCoUNYhUSxVPN41Uo+
        nURQ+KlyHq8Teu6CA9b0q3t4Yw==
X-Google-Smtp-Source: AJdET5fvuektJCvEsX7dnl+A7WYtZth7BEVsiIgHR6+beG63UVzrw9tpfuQGfz0MCdqsmQMbBcM8tg==
X-Received: by 2002:a50:ce5e:: with SMTP id k30-v6mr14247131edj.207.1540852546231;
        Mon, 29 Oct 2018 15:35:46 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id h3-v6sm7146380ede.42.2018.10.29.15.35.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Oct 2018 15:35:45 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 0/3] tracing: a few simplifying patches
Date:   Mon, 29 Oct 2018 23:35:39 +0100
Message-Id: <20181029223542.26175-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181026211347.2442-1-linux@rasmusvillemoes.dk>
References: <20181026211347.2442-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Playing around with -Wformat-nonliteral, I stumbled on two instances
in trace_output.c. Looking at the code a bit, turns out one can remove
the use of the non-constant format string and eliminate some code
duplication at the same time.

v2: Include cover letter, rename argument with_offset -> offset.

Rasmus Villemoes (3):
  tracing: merge seq_print_sym_short() and seq_print_sym_offset()
  tracing: avoid -Wformat-nonliteral warning
  tracing: simplify printf'ing in seq_print_sym

 kernel/trace/trace_output.c | 38 ++++++++-----------------------------
 1 file changed, 8 insertions(+), 30 deletions(-)

-- 
2.19.1.6.gbde171bbf5

