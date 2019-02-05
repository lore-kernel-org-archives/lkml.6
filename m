Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D82C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4FE62080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="eWcKjS6Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbfBEQnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:43:25 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]:37005 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbfBEQnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 11:43:24 -0500
Received: by mail-qt1-f181.google.com with SMTP id t33so4550909qtt.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 08:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lzbublII2+hYOIz0r1P39cJtjHHFawWf7/THbJtZSpE=;
        b=eWcKjS6QnJ5D0Wj988XJQCMPCXakqUMrBJrAJxf5k0InjeCnj4eOZTW9iqGlF6IXuY
         3cgBpxD5usETAY0pt4VTahVm+vCCkkNPYuecA5XWXEs8eN49PPbmtobp138/CdJoQotg
         BAHQmhRzbg+aQ1ysYxPavuTuPTaRJO5/5GbqsHrak2fz6Xi4MOQNh/a/2Xpyg66URC84
         X1iFPal6VlF0QBixZV4EqAVjTQmVwoJQov8Jl1viWWGI2ZdffZI5oc3Lo/2WoHeo2TqQ
         ixekM1RQGVMF53fS057D2gdW250TrPSTcqLE1ER6h7uaPGWParV0LAzBY6amsINznc0g
         AWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lzbublII2+hYOIz0r1P39cJtjHHFawWf7/THbJtZSpE=;
        b=bF8YoFTGd1Dld2yaxMv9cCWLVcIS8Thwhc9kKtc/xKSZ4/1R/n4O75FhJJ5Q36ry4Y
         +spAndzjxK3FfnkWKtsMsfCVgCCtsqcZPUxW0Q8xvzHQLMHE/GuOymqBrSh7KZVf3mQP
         PsZY++OVCf7AiwP+lRMKHF9dgc0LMT/U43L6B4JWT949n05hScmLorHxGn7C77DTaH5s
         0SRsUMNTcvI+DLqUKB0oO2llu6ScYnTi+1XD4FuH8mwLLGUhsQ/Xn6KKQ7ifaODQYYL0
         p++OryFOYDi5EOPgXicpNJ1yS+3xGxE/fBe6pSzwuSBh9nBcAenS7K/YdLHk7UpVRP4L
         eQtQ==
X-Gm-Message-State: AHQUAubU3Ic1zQI83JW7kov70Jx8ReDeZJQHYPqrqkNr+TLazPFmtlUZ
        u6UJYewxSgSucPFKpnnXEAbzew==
X-Google-Smtp-Source: AHgI3IbV1MHc5Bckq09k1prt5wO82s0UfjkRwuBEy+uK/Vd6iGHeGL4w2JbCHRXk1DS65gT54Lr7Rw==
X-Received: by 2002:ac8:7416:: with SMTP id p22mr4294541qtq.318.1549385003864;
        Tue, 05 Feb 2019 08:43:23 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d78sm16138603qke.94.2019.02.05.08.43.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 08:43:23 -0800 (PST)
Subject: Re: mm: race in put_and_wait_on_page_locked()
To:     Hugh Dickins <hughd@google.com>, Artem Savkov <asavkov@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20190204091300.GB13536@shodan.usersys.redhat.com>
 <alpine.LSU.2.11.1902041201280.4441@eggly.anvils>
 <20190205121002.GA32424@shodan.usersys.redhat.com>
 <alpine.LSU.2.11.1902050725010.8467@eggly.anvils>
From:   Qian Cai <cai@lca.pw>
Message-ID: <1ce33d5f-1f0f-7144-2455-fbae7f5f82c8@lca.pw>
Date:   Tue, 5 Feb 2019 11:43:20 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.1902050725010.8467@eggly.anvils>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Cai, can you please check if you can reproduce this issue in your
>> environment with 5.0-rc5?
> 
> Yes, please do - practical confirmation more convincing than my certainty.

Indeed, I am no longer be able to reproduce this anymore.
