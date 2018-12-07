Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C61C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7541D20837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7541D20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbeLGQ1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:27:35 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36086 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeLGQ1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:27:35 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so1943286pgm.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 08:27:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ec28YoBD4helV81kQpcKCMSx9yQxwyEZYWDKtyCm0wc=;
        b=I255t3GMRtsSJkG0kH4KaJ9POAwhc/p/VSOb6Gjq8fwcbMRJcB6HZy+gTvcKhAYcOO
         eAe6n0A6WN3DsL3PVBon/ALYqdrv0BxUCAHx3MKwPS54xS8tgJykCkyPL5yoDemHvekF
         VpCKESU6lwXKljal5oZNBsFlobTRCll0R0we10EJ5nb4y0KbRpqRRzec9An83Oo77A2P
         sEkJ4+po2eaAxHZMu+mpJfN5amVL6KiIab4uqT6NpX8q/qJUBmi1jSYtyaBJsz8v6XXT
         iSP8hPD8z6E8MY3D86i0vSV398Da5foIzWLjR4IEGIYdLojlsJ1QLMA3aHDhK8c2oT+w
         A7/A==
X-Gm-Message-State: AA+aEWarMPJpijS57837Zg/K5ArB1p2slATj7mkuLxNAvnS2hk5EvG9Y
        3+0aEPjDDbVAT/treCSgoeU=
X-Google-Smtp-Source: AFSGD/WXX0akFnj0NhoojBIdb8Ha+aIxo51TgbPXw83DlFrBzOVYUWpEgnpsSr9BAMOgboumPCxdmA==
X-Received: by 2002:a63:2a4a:: with SMTP id q71mr2530772pgq.374.1544200053927;
        Fri, 07 Dec 2018 08:27:33 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id l22sm8793610pfj.179.2018.12.07.08.27.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 08:27:33 -0800 (PST)
Message-ID: <1544200052.185366.308.camel@acm.org>
Subject: Re: [PATCH v3 17/24] locking/lockdep: Free lock classes that are no
 longer in use
From:   Bart Van Assche <bvanassche@acm.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Date:   Fri, 07 Dec 2018 08:27:32 -0800
In-Reply-To: <20181207121429.GI2237@hirez.programming.kicks-ass.net>
References: <20181207011148.251812-1-bvanassche@acm.org>
         <20181207011148.251812-18-bvanassche@acm.org>
         <20181207121429.GI2237@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-12-07 at 13:14 +-0100, Peter Zijlstra wrote:
+AD4 On Thu, Dec 06, 2018 at 05:11:41PM -0800, Bart Van Assche wrote:
+AD4 +AD4 +-	if (WARN+AF8-ON+AF8-ONCE(+ACE-hlock+AF8-class(prev)-+AD4-hash+AF8-entry.pprev) +AHwAfA
+AD4 +AD4 +-	    WARN+AF8-ONCE(+ACE-hlock+AF8-class(next)-+AD4-hash+AF8-entry.pprev,
+AD4 +AD4 +-		      KERN+AF8-INFO +ACI-Detected use-after-free of lock class +ACU-s+AFw-n+ACI,
+AD4 +AD4 +-		      hlock+AF8-class(next)-+AD4-name)) +AHs
+AD4 +AD4 +-		return 2+ADs
+AD4 +AD4 +-	+AH0
+AD4 
+AD4 Ah, this is that UaF on -+AD4-name, but it only happens when there's already
+AD4 been a UaF, so that's fine I suppose. Still a note on that earlier
+AD4 Changelog would've been nice I suppose.

How about reporting the class pointer only as is done elsewhere in the
lockdep code?

+AD4 +AD4 +-/+ACo Must be called with the graph lock held. +ACo-/
+AD4 +AD4 +-static void remove+AF8-class+AF8-from+AF8-lock+AF8-chain(struct lock+AF8-chain +ACo-chain,
+AD4 +AD4 +-					 struct lock+AF8-class +ACo-class)
+AD4 +AD4 +-+AHs
+AD4 +AD4 +-	u64 chain+AF8-key+ADs
+AD4 +AD4 +-	int i+ADs
+AD4 +AD4 +-
+AD4 +AD4 +-+ACM-ifdef CONFIG+AF8-PROVE+AF8-LOCKING
+AD4 +AD4 +-	for (i +AD0 chain-+AD4-base+ADs i +ADw chain-+AD4-base +- chain-+AD4-depth+ADs i+-+-) +AHs
+AD4 +AD4 +-		if (chain+AF8-hlocks+AFs-i+AF0 +ACEAPQ class - lock+AF8-classes)
+AD4 +AD4 +-			continue+ADs
+AD4 +AD4 +-		if (--chain-+AD4-depth +AD4 0)
+AD4 
+AD4  +AHs
+AD4 +AD4 +-			memmove(+ACY-chain+AF8-hlocks+AFs-i+AF0, +ACY-chain+AF8-hlocks+AFs-i +- 1+AF0,
+AD4 +AD4 +-				(chain-+AD4-base +- chain-+AD4-depth - i) +ACo
+AD4 +AD4 +-				sizeof(chain+AF8-hlocks+AFs-0+AF0))+ADs
+AD4 
+AD4  +AH0
+AD4 
+AD4 Also, I suppose a comment here that notes we 'leak' chain+AF8-hlock+AFsAXQ
+AD4 entries would be appropriate here.

OK, I will add such a comment.

+AD4 If Waiman cares, it is possible to reclaim then by extending the above
+AD4 memmove() to cover the +AF8-entire+AF8 tail of the array and then going around
+AD4 and fixing up all the chain-+AD4-base 'pointers' that are in the moved part.

Since that change is outside the scope of what I want to realize I will leave
this to Waiman.

Bart.
