Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E92C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E16E2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Qf8jeHdZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E16E2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbeLJKgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:36:53 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33067 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLJKgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:36:51 -0500
Received: by mail-ed1-f68.google.com with SMTP id p6so9050451eds.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 02:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YV7Au+Xoi18K0aIfE4y7asb18jxEh8D3vpzvdu6CgE4=;
        b=Qf8jeHdZ8ydZwtk1HtyaUYsbuLnQ9OuLcGcbhNE9PYj5kuDCL1k3/GiBdBKSveH1I1
         2slyNbHPQWwwhr2hxeuXQqoeZIopHSnlirJx8JGMe4O5OIs9LsYmd+AxJeGPQiWd7Y5M
         m+TwZqZVPWGd4dHfGkAWqRQlOnwC50qjNAWn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YV7Au+Xoi18K0aIfE4y7asb18jxEh8D3vpzvdu6CgE4=;
        b=oKnJ0eLEo688wQbE27w8rhmTKt0OnEeTBrcdaWIrQHcb2YVCDStywDqZTnWvz3910q
         buvX4oAxQWfFQG5/TQ4EVEZedI+U29kwtyCB2Kd0uqWpQidc+2j08RydHGKnG1K8N9Zd
         TueRf7PPrATCMnUUixGOUQVqELlsL2OWiiMXjN/0S9MTCzRdhqjItvdYSEBReAiBHYQp
         eEDGw/xb01ZGO1VNFxuIvt0GAowvt3QfRIDUIkyEnCj1F12Nu8k7QzcGVmhAqGePkhHx
         kNbwzIaNrglRFRAAtfKKm4EU+W52SdKpw03h56lZPEaCJKYpy5Q88qw56BnR3EIojYVR
         aFsQ==
X-Gm-Message-State: AA+aEWZMmaEBJ5V428DUAQEzBFPcidDnmgOutVEggVkRpLqRXZbxdCEZ
        zwH5Er/Sn1BLaTFKFyvgXN6vxQ==
X-Google-Smtp-Source: AFSGD/WTiRBF+bnXbP47+tF0zKNIaU09U2WUgwi3pvFZef2cryiPBMTWKH+CBkawc01/ebuF3XXHbg==
X-Received: by 2002:a50:cf41:: with SMTP id d1mr11169344edk.242.1544438209386;
        Mon, 10 Dec 2018 02:36:49 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id q50sm3223862edd.66.2018.12.10.02.36.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 02:36:48 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 1/4] mm: Check if mmu notifier callbacks are allowed to fail
Date:   Mon, 10 Dec 2018 11:36:38 +0100
Message-Id: <20181210103641.31259-2-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181210103641.31259-1-daniel.vetter@ffwll.ch>
References: <20181210103641.31259-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a bit of paranoia, since if we start pushing this deep into
callchains it's hard to spot all places where an mmu notifier
implementation might fail when it's not allowed to.

Inspired by some confusion we had discussing i915 mmu notifiers and
whether we could use the newly-introduced return value to handle some
corner cases. Until we realized that these are only for when a task
has been killed by the oom reaper.

An alternative approach would be to split the callback into two
versions, one with the int return value, and the other with void
return value like in older kernels. But that's a lot more churn for
fairly little gain I think.

Summary from the m-l discussion on why we want something at warning
level: This allows automated tooling in CI to catch bugs without
humans having to look at everything. If we just upgrade the existing
pr_info to a pr_warn, then we'll have false positives. And as-is, no
one will ever spot the problem since it's lost in the massive amounts
of overall dmesg noise.

v2: Drop the full WARN_ON backtrace in favour of just a pr_warn for
the problematic case (Michal Hocko).

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: linux-mm@kvack.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 mm/mmu_notifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 5119ff846769..ccc22f21b735 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -190,6 +190,9 @@ int __mmu_notifier_invalidate_range_start(struct mm_struct *mm,
 				pr_info("%pS callback failed with %d in %sblockable context.\n",
 						mn->ops->invalidate_range_start, _ret,
 						!blockable ? "non-" : "");
+				if (blockable)
+					pr_warn("%pS callback failure not allowed\n",
+						mn->ops->invalidate_range_start);
 				ret = _ret;
 			}
 		}
-- 
2.20.0.rc1

