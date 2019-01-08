Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B3AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205D220883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="b782fHd9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbfAHWNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 17:13:45 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42641 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbfAHWNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 17:13:44 -0500
Received: by mail-qt1-f193.google.com with SMTP id d19so6220909qtq.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 14:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2EtvczNy6Z5emY4pBSHx+WcSBOrzhD0WHtdRLotowXk=;
        b=b782fHd9Imj/upFTtgwNxeAB+IMG8g0N70oP5euZIDHGehqB3MTKPQbM8pKALGyQwp
         2ZP+fd4TcynRnj0oy26oc5m0oBzbsN7DC9f99Pfq7GwqiBRx1IRULnLBvaGpuMoBTGRj
         grMezHqEzBPsKzj+RRdugl9lZoFx7HOYHx59dzahqMD42Lz4/d2UANmE+4Hw9fJe70aU
         jpYsojbPuEDORcP7uOGRnGuZthn029MUUM3q6k0ScrAke4lRuTKOskir+9m3cHvJwMPV
         E8jrIA5dcvwed9OSPSHtaeFwKkL8RYxIOvSpP3Qs9+D+FNAEeqYzvOMzjvzyaxJbbpO6
         5XZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2EtvczNy6Z5emY4pBSHx+WcSBOrzhD0WHtdRLotowXk=;
        b=JbfEjEIy9P7Xsxx8dROosocEbd1TiX3yzTw60jakb9PnpQ4gZpS3/z5t1EBL7I6O5N
         T1PwE295q9uUdCMjRWWjnoznHfwVXTDbPkYCn9kispBZbJzfWCjnnWLxzAe2cg6s8dcR
         SfytsW0dJsFQ14otS7BS+xVlBrZdEXzsk7Lw7SjLxD8uStP7CqegxaXKthUQbCoao/rb
         +TZ6A03hpwGMNb+Pz4odJCM3FInasaeL1YiaFoshxFaePkM50TTkF0gfWYm6oG0yq+ud
         E2Rep5ofUQr0L9zX152/3t6k2sbHPNYSGK26GXRVGzR1tQx2NauujxqXPIE997juUJSU
         AADA==
X-Gm-Message-State: AJcUukfSqElK+vKOvIgYZrCkMgCnkEUcr/Fnmv071WJD4v+bTHWEwNq1
        luTs28rBKu6MWp+pk2PUGJxLnwVLEoaylQ==
X-Google-Smtp-Source: ALg8bN7R6xRdWtrf1g71SueNQkWxTAdo591HZ3uNcuaWVSvoFvaGeoBp/1GwWfywMb58ScuBETC45g==
X-Received: by 2002:aed:32a5:: with SMTP id z34mr3379263qtd.311.1546985622884;
        Tue, 08 Jan 2019 14:13:42 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id n18sm3314385qkk.20.2019.01.08.14.13.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 14:13:42 -0800 (PST)
Subject: Re: [PATCH v3] mm/page_owner: fix for deferred struct page init
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Pavel.Tatashin@microsoft.com,
        mingo@kernel.org, mgorman@techsingularity.net,
        iamjoonsoo.kim@lge.com, tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190103202235.GE31793@dhcp22.suse.cz>
 <a5666d82-b7ad-4b90-5f4e-fd22afc3e1dc@lca.pw>
 <20190104130906.GO31793@dhcp22.suse.cz>
 <e4ad9d12-387d-1cc6-f404-cae6d43ccf80@lca.pw>
 <20190104151737.GT31793@dhcp22.suse.cz>
 <c8faf7eb-d23f-4ef7-3432-0acc7165f883@lca.pw>
 <20190104153245.GV31793@dhcp22.suse.cz>
 <fa135cd8-32e5-86f7-14ee-30685bca91b5@lca.pw>
 <20190107184309.GM31793@dhcp22.suse.cz>
 <bfcd017d-dcf4-b687-1aef-ab0810b12c73@lca.pw>
 <20190108082032.GP31793@dhcp22.suse.cz> <1546953547.6911.1.camel@lca.pw>
 <20190108140253.5b6db0ab37334b845e9d4fc2@linux-foundation.org>
From:   Qian Cai <cai@lca.pw>
Message-ID: <c7a80f25-c30b-01cc-d2ef-49834f2d6078@lca.pw>
Date:   Tue, 8 Jan 2019 17:13:41 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190108140253.5b6db0ab37334b845e9d4fc2@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/8/19 5:02 PM, Andrew Morton wrote:
> 
> It's unclear (to me) where we stand with this patch.  Shold we proceed
> with v3 for now, or is something else planned?

I don't have anything else plan for this right now. Michal particular don't like
that 4-line ifdef which supposes to avoid an immediately regression (arguably
small) that existing page_owner users with DEFERRED_STRUCT_PAGE_INIT deselected
that would start to miss tens of thousands early page allocation call sites. So,
feel free to choose v2 of this which has no ifdef if you agree with Michal too.
I am fine either way.

