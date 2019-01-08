Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E222C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E5F206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDfKWdW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732659AbfAHTnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:43:00 -0500
Received: from mail-ua1-f53.google.com ([209.85.222.53]:36609 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731824AbfAHTdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:33:53 -0500
Received: by mail-ua1-f53.google.com with SMTP id j3so1659982uap.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 11:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=hHgjSR+cFz9cVJF2AiQcA/E5dfRyPx4pM1LbWcyflfs=;
        b=gDfKWdW0lqlrLLLrqdDzCMLtCb8AjYetd4Vk23ASrEWs1qKuABGK1/mK33z7x9vFPb
         22OWP4HWo+s/avWZLHY7L5vBntK1MB6SA3an9PvDSzNykH+LlRkB80kx5meN/ISKUZJE
         SnWFmp+tjECaE8XtZFTA+2WKKVcsmdbnMWVXSzIV1G3bEYGzoa4eGW0MPoTAXJliOQaS
         64RAwtPViHTdmkiCtBclRzE3LHlcMCPKgDn/LPuQcU4l1PFtA4p1LCXORuWMhl8xULKe
         W700pRZ+Q0eCebFojIsBxG1IeuZ1aRC0WhgGVk7dI+iiegG0sS/AtT2NUCLZUvM63mqU
         JHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hHgjSR+cFz9cVJF2AiQcA/E5dfRyPx4pM1LbWcyflfs=;
        b=oIL777NvVN9nt6X+V35gctEzHeU6OHZ8XBGttI69adtd+cMgTN78QRFnILoU5EGP5/
         JPUkiEggk9s8mI9WpsBV28xOm5RFMH+1VVK5ZGojg3Z/m0QS8AKTGagUn+lElHyQ7oub
         LAafuCcGVKBKxMBZmHL00bppFjBbSrN6ZpB4K0Z9QUXo0YH6utWYWN3xL9hpfKFcqln+
         15YLPdX5Ta2PqA21YXFF59s57jVtoigM7lf2KOY/QGfDGzsF6T+CK2Ww8vqrj7xxHY3S
         RQj6njxIIzvHriAfBraF/KGC5K3TkIB+QtuiEtB8+eQzmNSabGqrBompI36UrWkygadc
         +mmg==
X-Gm-Message-State: AJcUukfd6vHAqH31FAg6sw50A/1uEU4setK+Uxx3b8+tBvfmG0bUAlBO
        lJDJpjZ5cXLhZ2V6Xmj0CtIfPL3Sg6DUnp+QHJk=
X-Google-Smtp-Source: ALg8bN6vuPmtlIecQq+SAOsllXHIkImZowdrJmWLz8yt5x00lwrnYSQ5x9ArEHwMt74sry2Aug/zRiWW9fp5sMfISKQ=
X-Received: by 2002:ab0:9d4:: with SMTP id e20mr1068521uah.22.1546976031529;
 Tue, 08 Jan 2019 11:33:51 -0800 (PST)
MIME-Version: 1.0
From:   Anatol Pomozov <anatol.pomozov@gmail.com>
Date:   Tue, 8 Jan 2019 11:33:39 -0800
Message-ID: <CAOMFOmU=t9YbE68YpoQn0Ug0XN1F+0iuJp9J=htCRRrbdaPSVA@mail.gmail.com>
Subject: seqcount usage in xt_replace_table()
To:     fw@strlen.de, Dmitry Vyukov <dvyukov@google.com>,
        paulmck@linux.ibm.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,

A bit of context what I am doing. I am trying to port KTSAN (Kernel
Thread Sanitizer) tool to v4.20. That tool tracks shared data usage
and makes sure it is accessed in a thread-safe manner.

seqlock is a synchronization primitive used by Linux kernel. KTSAN
annotates read_seqbegin()/read_seqretry() and tracks what data been
accessed in its critical section.

During KTSAN port I found and interesting seqcount usage introduced in
commit 80055dab5de0c8677bc148c4717ddfc753a9148e

If I read this commit correctly xt_replace_table() does not use
seqlock in a canonical way to specify a critical section. Instead the
code reads the counter and waits until it gets to a specific value.

Now I want KTSAN to play with this code nicely. I need to tell KTSAN
something like "this raw_read_seqcount() does not start a critical
section, just ignore it". So temporary I introduced
raw_read_seqcount_nocritical() function that is ignored by KTSAN. Is
it a good solution?

Or maybe xt_replace_table() can be enhanced? When I hear that
something waits until an event happens on all CPUs I think about
wait_event() function. Would it be better for xt_replace_table() to
introduce an atomic counter that is decremented by CPUs, and the main
CPU waits until the counter gets zero?

WDYT?
