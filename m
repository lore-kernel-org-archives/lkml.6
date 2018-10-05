Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1EFC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A0F21479
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A0F21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbeJFB5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 21:57:05 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43850 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbeJFB5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 21:57:05 -0400
Received: by mail-yw1-f67.google.com with SMTP id j75-v6so5656410ywj.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 11:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1tCsJMkkppw7jkazA9j7eJEyDbmxqhWZwL2uVrD7i6Q=;
        b=kLUpIjuVE0OhMUEaG5QfpXF/hn3MuxrWDg3yqr95aH/ItqFnxwMB7fSAxGbXPMPrCu
         vO2+Y5aW72COcjK0AhJrBBcEYu48jNy6+b477Fv1wp9sJbAmlrkiwRqs9HjJ6mM7vCeQ
         zZ2GQyv02JbNy1pD+Lkr3cOM1rISn7zSQIlvP3MF721Op50gSo0heoJdM1kDBJ8ucxll
         1ODPTb5SUlFlNadezQL4N5/3BegOo5frDQSZs2fDogAEztL8jjWPB5Z5x0V/mlAIygyi
         ksW/fQ2p67tCUSbe0a7Y4KHrdtlENKF/ioEkeKXisWI0JjBZ2CtA1/dNIOhBYHVRo6Kx
         lwGw==
X-Gm-Message-State: ABuFfohNbJGOOS49JkMGY5GKclLdZxD/zJsqqEBys73L0eQTbtBuJmK5
        0EvYF2G+SD4u9QYE2CwgrYE=
X-Google-Smtp-Source: ACcGV601ts02tumKCEocn8tsUmYDh+mwIrih2JnbUMOIEkezDDXyjM8RQoQSKPItlA/crjzXadse8A==
X-Received: by 2002:a0d:cec5:: with SMTP id q188-v6mr7025532ywd.68.1538765824024;
        Fri, 05 Oct 2018 11:57:04 -0700 (PDT)
Received: from [192.168.1.10] (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id e82-v6sm6708547ywa.60.2018.10.05.11.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 11:57:03 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] mm: Fix for movable_node boot option
To:     Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>, linux-mm@kvack.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <20180925153532.6206-1-msys.mizuma@gmail.com>
 <alpine.DEB.2.21.1809272241130.8118@nanos.tec.linutronix.de>
 <20181002140111.GW18290@dhcp22.suse.cz>
From:   Pavel Tatashin <pavel.tatashin@microsoft.com>
Message-ID: <0e9b7c25-8e84-e37a-ce65-671641210aab@gmail.com>
Date:   Fri, 5 Oct 2018 14:57:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181002140111.GW18290@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/2/18 10:01 AM, Michal Hocko wrote:
> On Thu 27-09-18 22:41:36, Thomas Gleixner wrote:
>> On Tue, 25 Sep 2018, Masayoshi Mizuma wrote:
>>
>>> This patch series are the fix for movable_node boot option
>>> issue which was introduced by commit 124049decbb1 ("x86/e820:
>>> put !E820_TYPE_RAM regions into memblock.reserved").
>>>
>>> First patch, revert the commit. Second and third patch fix the
>>> original issue.
>>
>> Can the mm folks please comment on this?
> 
> I was under impression that Pavel who authored the original change which
> got reverted here has reviewed these patches.
> 

I have not reviewed them yet. I am waiting for Masayoshi to send a new
series with correct order as Ingo requested.

Pavel
