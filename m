Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7726C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3C92147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="VVkDKmCq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C3C92147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maine.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeHWV4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 17:56:05 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:41594 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeHWV4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 17:56:05 -0400
Received: by mail-qk0-f171.google.com with SMTP id h138-v6so4254564qke.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 11:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:message-id:user-agent:mime-version;
        bh=HKRjZCtEzlifLpJKhAO9ULHGt9CycvAjl4PA2sGorVs=;
        b=VVkDKmCqM/yDCEndXo8brNVElx1aZVUCrQjOfdVoc/B7vs4A/waTOkQLZrFVM7DBA4
         YPuot/3Y/Ns0kEI4lYHCUIku5rSH2KlUwsm1B6M4rB7v99sVFViTevcaqi48YyZFSyy1
         4fder52OL0RAqPS5AFdG7jhT+sYJa/Lu0CD2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=HKRjZCtEzlifLpJKhAO9ULHGt9CycvAjl4PA2sGorVs=;
        b=IaTK0McX/CHm8iG5OsdONYu4EdM4G9MrLl54PhsJrc3Wz64m0aijyWtvLCDRdC+90q
         iPh6N/KuGApq2q3DHqMsT8eaPfnwxnXt3MNZOcdeZ6LqTONMV8n2FYfBLpk9nxQ4xBiK
         W4SmiPTXSWUVUSz0m5MuQ2oOIKju0YjAAWxZ5qt5zKnJsxpfeB7FwP6rfTGuXjokWYxb
         mWev2stj8cUl0cG1mfAMVSXFR/T+Da2NmqeliVynX08NzeZ8C+hGHLiPpqDdjbsx2QeM
         vxAsjJHpaFbeaPodUY+eZCz9uOP30MlF7NikDCAqOonGNbxYwQztU0MLqr+CI7AOoXSe
         nyiQ==
X-Gm-Message-State: AOUpUlGq/4ecoklAS8Hs5KWTBXyBIhJC/R1rSiaVtkw9sl6bIylkFPPS
        gOII8GDSFp1Aqbq8cmqE/+EegTIyv7k=
X-Google-Smtp-Source: AA+uWPz96qsneYaGvqMmvZbRBV3zMNdjjRCJ3GV4P4s/K2IWhOykh1cUUppH0SOiNNikqV7ABXg2NQ==
X-Received: by 2002:a37:4453:: with SMTP id r80-v6mr56953200qka.79.1535048709234;
        Thu, 23 Aug 2018 11:25:09 -0700 (PDT)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id a17-v6sm3010243qkb.62.2018.08.23.11.25.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 11:25:08 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Thu, 23 Aug 2018 14:25:06 -0400 (EDT)
X-X-Sender: vince@macbook-air
To:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [perf] perf_event.h ABI visibility question
Message-ID: <alpine.DEB.2.21.1808231401440.28868@macbook-air>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I notice that Linux 4.18 has the following changeset which changes the
user visible perf_event.h file

	commit 6cbc304f2f360f25cc8607817239d6f4a2fd3dc5
	Author: Peter Zijlstra <peterz@infradead.org>
	Date:   Thu May 10 15:48:41 2018 +0200

    perf/x86/intel: Fix unwind errors from PEBS entries (mk-II)

which contains

--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -143,6 +143,8 @@ enum perf_event_sample_format {
        PERF_SAMPLE_PHYS_ADDR                   = 1U << 19,
 
        PERF_SAMPLE_MAX = 1U << 20,             /* non-ABI */
+
+       __PERF_SAMPLE_CALLCHAIN_EARLY           = 1ULL << 63,
 };


Is this supposed to be a user-visible interface?

I realize that if the user tries to set anything above PERF_SAMPLE_MAX
it will be caught and flagged as EINVAL.

However even with the double-underscore hint in 
__PERF_SAMPLE_CALLCHAIN_EARLY the value is still in the user-visible 
header so it's now part of the ABI and I guess the manpage has to document it.

Vince

