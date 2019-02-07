Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C082CC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F356218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="jpFCPnJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfBGQyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:54:07 -0500
Received: from thorn.bewilderbeest.net ([71.19.156.171]:53186 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfBGQyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:54:06 -0500
Received: from hatter.bewilderbeest.net (hatter.bewilderbeest.net [IPv6:2001:470:c3f4:1::1:1])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 5CC8180536;
        Thu,  7 Feb 2019 08:54:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 thorn.bewilderbeest.net 5CC8180536
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1549558445;
        bh=u1nfQW2xml8J03+G1De1mU7DCIGkb14gBR31V4ysJX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jpFCPnJg8Sk5DzcgdGNFdIIMnU4ZOpt6ET9bJDW60pCFjA/pvXfHc+lNl0S4grHtW
         dX2Nzw4TRniDXCFf0KKrf9tz9EgKwq6QlKfz6Yk9IQkFmz9tW9cTHenauHTVznZ59j
         SqPaBwYSW9fwsrQ5kRPI65VdltTgUoNJtbTkCfwQ=
Date:   Thu, 7 Feb 2019 10:54:04 -0600
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, yzaikin@google.com,
        brendanhiggins@google.com
Subject: Re: [PATCH v2 0/3] sysctl: fix range-checking in
 do_proc_dointvec_minmax_conv()
Message-ID: <20190207165404.kbkikonfuy7j22rs@hatter.bewilderbeest.net>
References: <20190206195807.GG11489@garbanzo.do-not-panic.com>
 <20190207123426.9202-1-zev@bewilderbeest.net>
 <20190207155144.GH11489@garbanzo.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190207155144.GH11489@garbanzo.do-not-panic.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 09:51:44AM CST, Luis Chamberlain wrote:
>On Thu, Feb 07, 2019 at 06:34:23AM -0600, Zev Weiss wrote:
>> Hello,
>>
>> After being left with an unusable system after a typo executing
>> something like 'echo $((1<<24)) > /proc/sys/vm/max_map_count', I found
>> that do_proc_dointvec_minmax_conv() was missing a check to ensure that
>> the converted value actually fits in an int.
>>
>> The first of the following patches enhances the sysctl selftest such
>> that it detects this problem; the second provides a minimal fix
>> (suitable for -stable) such that the selftest passes.  The third patch
>> then performs a more thorough refactoring to eliminate the code
>> duplication that led to the bug in the first place (maintaining the
>> passing status of the selftest).
>>
>>
>> Changes in v2:
>>  - Rearranged selftest to also test negative values and provide more
>>    info in comments
>>  - Added intermediate patch as a minimal fix for -stable without the
>>    refactoring
>
>Thanks! For some reason I got all except the last patch, patch #3.
>Can you bounce me and others a copy?
>
>  Luis

Hmm, odd -- it does seem like each time I use git-send-email I manage to 
find a new way to botch it up, but in this case it *looks* like my 
server logs indicate that one should have been sent properly as far as I 
can tell.  No matter, resent it manually anyway, hopefully it gets 
through this time...(apologies if anyone gets duplicate copies).


Zev

