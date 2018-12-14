Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC50C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182A02080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbeLNWmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:42:24 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:29888 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729752AbeLNWmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:42:23 -0500
X-RZG-AUTH: ":OH8QVVOrc/CP6za/qRmbF3BWedPGA1vjs2e0bDjfg8OiOrPJifeRMRhMbfKobJAvSmsJbFO0KIY="
X-RZG-CLASS-ID: mo00
Received: from [192.168.2.24]
        by smtp.strato.de (RZmta 44.8 DYNA|AUTH)
        with ESMTPSA id V03c59uBEMg16wE
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 14 Dec 2018 23:42:01 +0100 (CET)
Subject: Re: [PATCH] acpi / apei: fix NULL deref during init
To:     Thomas Schoebel-Theuer <tst@schoebel-theuer.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        linux-acpi@vger.kernel.org
References: <20181214181514.29891-1-tst@schoebel-theuer.de>
 <20181214202406.GI11710@zn.tnic>
 <c8d62037-4a26-e18b-51a3-73fc99e76e5b@schoebel-theuer.de>
From:   =?UTF-8?Q?Thomas_Sch=c3=b6bel-Theuer?= <thomas@schoebel-theuer.de>
Message-ID: <5ec69dad-7943-343b-5ced-9a962652e14c@schoebel-theuer.de>
Date:   Fri, 14 Dec 2018 23:42:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <c8d62037-4a26-e18b-51a3-73fc99e76e5b@schoebel-theuer.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/18 22:27, Thomas Schoebel-Theuer wrote:
> On 12/14/18 21:24, Borislav Petkov wrote:
>>
>> Because apei_resources_fini() happens under the same condition check and
>> if arch_apei_filter_addr was false, it should not become true, all of a
>> sudden. Or?
>
> please take a look at the stacktrace. For some reason, and only at 
> that specific hardware, the condition is false, there but later the 
> indicated error exit is taken whose message you can see immediately 
> before the stack trace.
>

Ah, I overlooked that commit e56c92565dfe2 is already providing a 
different solution to the same problem in newer kernels _only_, as a 
_side_ effect (not clear to me from the description, but clear from 
reading the code).

But this patch is not present at the 4.4.166 kernel where I found the 
problem and fixed it internally in a different way.

The 4.4.166 code looks like this, without the if-statement you are 
mentioning, unconditionally trying to free the unitinialized variable 
under certain circumstances:

d91525eb8ee6a (Chen, Gong     2014-12-10 13:53:26 -0800 553) arch_res_fini:
d91525eb8ee6a (Chen, Gong     2014-12-10 13:53:26 -0800 554) 
apei_resources_fini(&arch_res);
d91525eb8ee6a (Chen, Gong     2014-12-10 13:53:26 -0800 555) nvs_res_fini:
4134b8c8811f2 (Huang Ying     2011-12-08 11:25:50 +0800 556) 
apei_resources_fini(&nvs_resources);
23f124ca3dda9 (Huang Ying     2010-09-29 19:53:54 +0800 557) return rc;

So another alternative would be backporting e56c92565dfe2 to the 4.4 LTS 
series. Also fine for me.


