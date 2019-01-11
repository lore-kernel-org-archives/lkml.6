Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07972C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54C720872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733034AbfAKPzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:55:06 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:43165 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730850AbfAKPzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:55:06 -0500
Received: by mail-pf1-f182.google.com with SMTP id w73so7126130pfk.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 07:55:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DVNv+L3D5rzXV4sCudk10OQd3dGwGv9if4k9ZxEJnN8=;
        b=f6LWL7fqjP1gw5+odgJo5q+7uI/EvN5zQX0J95jd2lDevBkHdIpNfvOUW0tPQh9ALA
         dHyatd68ja7Ljbtgrn/mnXNKoT3DVGTme0MUhiuJmJQCn+pI+5RToMplW/CAVhyy2gOU
         urzvgO6tLkgSvjbTvhB7953JT2luR2FddN7WluAqo+LjG+56V+Kz6x2SQapEfHkxHQ55
         8O5JImiFeeEiNEPOW9jh/RSoSCCuNFgFrjkWThSWUSAAD6CM98JC1u98fc+bQHiX0zu/
         9535qLUBDuN6C/m0emHtoYnjjfZ1vj4vNfid9foPEtgu4HmIv+sf20xmCF9+WmgeRDGr
         RHfg==
X-Gm-Message-State: AJcUukcQ9UJ+nwpdG50ZOTD/5lqokfzBJePE87PXXQJAhYpehyNNUdIO
        nf1ujoLh2z4Wt9iDVrrBKXU=
X-Google-Smtp-Source: ALg8bN4j1rvXoN6PCmQXnBJdEsN/DatRgCKOCj0nKcr0JGN8AiDnIH/5+W/Tu/hoej3HHmlqPSx9MQ==
X-Received: by 2002:a62:c21c:: with SMTP id l28mr14935750pfg.74.1547222105603;
        Fri, 11 Jan 2019 07:55:05 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id z9sm211455645pfd.99.2019.01.11.07.55.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 07:55:04 -0800 (PST)
Message-ID: <1547222103.83374.72.camel@acm.org>
Subject: Re: [PATCH v6 00/16] locking/lockdep: Add support for dynamic keys
From:   Bart Van Assche <bvanassche@acm.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org
Date:   Fri, 11 Jan 2019 07:55:03 -0800
In-Reply-To: <20190111124835.GP1900@hirez.programming.kicks-ass.net>
References: <20190109210204.192109-1-bvanassche@acm.org>
         <20190111124835.GP1900@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-11 at 13:48 +-0100, Peter Zijlstra wrote:
+AD4 I spotted this new v6 in my inbox and have rebased to it.

Thanks+ACE

+AD4 On Wed, Jan 09, 2019 at 01:01:48PM -0800, Bart Van Assche wrote:
+AD4 
+AD4 +AD4 The changes compared to v5 are:
+AD4 +AD4 - Modified zap+AF8-class() such that it doesn't try to free a list entry that
+AD4 +AD4   is already being freed.
+AD4 
+AD4 I however have a question on this+ADs this seems wrong. Once a list entry
+AD4 is enqueued it should not be reachable anymore. If we can reach an entry
+AD4 after call+AF8-rcu() happened, we've got a problem.

Apparently I confused you - sorry that I was not more clear. What I meant is
that I changed a single if test into a loop. The graph lock is held while that
loop is being executed so the code below is serialized against the code called
from inside the RCU callback:

+AEAAQA -4574,8 +-4563,9 +AEAAQA static void zap+AF8-class(struct pending+AF8-free +ACo-pf, struct lock
+AF8-class +ACo-class)
                entry +AD0 list+AF8-entries +- i+ADs
                if (entry-+AD4-class +ACEAPQ class +ACYAJg entry-+AD4-links+AF8-to +ACEAPQ class)
                        continue+ADs
-               if (+AF8AXw-test+AF8-and+AF8-set+AF8-bit(i, pf-+AD4-list+AF8-entries+AF8-being+AF8-freed))
+-               if (list+AF8-entry+AF8-being+AF8-freed(i))
                        continue+ADs
+-               set+AF8-bit(i, pf-+AD4-list+AF8-entries+AF8-being+AF8-freed)+ADs
                nr+AF8-list+AF8-entries--+ADs
                list+AF8-del+AF8-rcu(+ACY-entry-+AD4-entry)+ADs
        +AH0

Please let me know if you need more information.

Bart.

