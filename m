Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5495AC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150AF2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="OJ4GOB/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150AF2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387934AbeKFGxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:53:53 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42556 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbeKFGxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:53:52 -0500
Received: by mail-lf1-f68.google.com with SMTP id q6-v6so7278791lfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 13:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=LsFPFhBLJB11GHLpDen7k1aYKDgLKc8b7zvpsJDLdIg=;
        b=OJ4GOB/8Bpk9IBW2SlH5m9JkZl/mDSIWTBJ5dBnVos9X1YAvybtyu5dz4WJT8JXPJu
         FGSrKanim7SQhnd/liNuL3Os6rWrN5oR7KWqwSW8sQr7ZXqvOyNe6xzOgL7ou2bRGhlD
         VptyYLB2HTy2lfO/KgY2kZVyuEKzGSTMk4BFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=LsFPFhBLJB11GHLpDen7k1aYKDgLKc8b7zvpsJDLdIg=;
        b=BiXHR+qNW0wA4OVy+YvzjdmKi/Rh7wyR0aivSXlvtHwgs4hXItplIdxZ9VdfBNTnr+
         JUVI0zGvSodCNb6Mrg0cp+udHtXrOfDuEYc+WBhr/e2pzb455VA8oHCYfLHLg9KEvjQT
         u0kGUNU18+bjrD1ReV9/j6ciLdcevjLF7e3kDLYP63/2/rGRFbcv3RsPxBtF/2eAt44k
         /ZBWf3Dy0KHFsS/k2Ch7ef3dEkC0smVNQJo8OPYaDAOPujRFNEuW90nA8t0Yt3+eX8+x
         /Whf/eoi26IkNtnz0+4r0zJYmmy7EVdI6/jBrJDizosprKh/c9fTE6S75EkvRzxKY/yp
         Eb6w==
X-Gm-Message-State: AGRZ1gIAYpZwZ5gc9H+NyoUlrOtbIMfnRa2w3WG9LpsJ9XlTYbjYZTWW
        URqYvVooGUHrIW2HJPeItFra2A==
X-Google-Smtp-Source: AJdET5cLdibq9BwbgN+mxuvy7wzfMuWYcF2D+GgBhlIaXyhkA1AFdCNCSPUl0RAowvQN+27wgMwGog==
X-Received: by 2002:a19:d381:: with SMTP id k123mr14195649lfg.101.1541453529775;
        Mon, 05 Nov 2018 13:32:09 -0800 (PST)
Received: from [10.60.17.127] (31-208-49-160.cust.bredband2.com. [31.208.49.160])
        by smtp.gmail.com with ESMTPSA id o3-v6sm1635922lfe.22.2018.11.05.13.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 13:32:09 -0800 (PST)
To:     Kees Cook <keescook@chromium.org>, Michal Hocko <mhocko@suse.cz>,
        Jordan Crouse <jcrouse@codeaurora.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: kstrdup_quotable_cmdline and gfp flags
Message-ID: <84197642-f414-81dc-ee68-1a4c1cdea5ae@rasmusvillemoes.dk>
Date:   Mon, 5 Nov 2018 22:32:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kstrdup_quotable_cmdline takes gfp flags and passes those on to
kstrdup_quotable, but before that it has done a kmalloc(PAGE_SIZE) with
a hard-coded GFP_KERNEL. There is one caller of kstrdup_quotable_cmdline
which passes GFP_ATOMIC, and the commit introducing that (65a3c2748e)
conveniently has this piece of history:

    v2: Use GFP_ATOMIC while holding the rcu lock per Chris Wilson

So, should the GFP_KERNEL in kstrdup_quotable_cmdline simply be changed
to use the passed-in gfp, or is there some deeper reason for the
GFP_KERNEL (in which case it doesn't really make sense to take gfp at
all...)? It came from a tree-wide GFP_TEMPORARY -> GFP_KERNEL conversion.

Rasmus
