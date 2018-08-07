Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8351C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E55721736
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="d5KoyyMd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FUoGYTsT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E55721736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeHHA6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 20:58:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60202 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeHHA6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 20:58:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0F3FE60B22; Tue,  7 Aug 2018 22:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533681702;
        bh=HftTJFQpewgrmnTRTEUtCkT0uj3a1JsncM5on3skTy8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d5KoyyMdDnScru+cRgqJEEwbFypPXFuyF085I3NJqsOYU/ANQSiABQcS8bmftPVKo
         BOZashGaBsrfOnL85q+V/q+/vKxMAgGtFCKpx/RWKDlr3IDyIO6kWzybq0kEHgReGT
         S0Ql7QkNf8/E7DglarSQ/A8HMI5EWxbFmligHzDk=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 305FD60115;
        Tue,  7 Aug 2018 22:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533681701;
        bh=HftTJFQpewgrmnTRTEUtCkT0uj3a1JsncM5on3skTy8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FUoGYTsT9manneDd6Rd83yjN4cCuSRn68NscWJT9TgyFpKXKO6IXhJs8nFjnpqEEV
         JaNyzBxxmN6FH65ya/1UvI9c0lpNSGYtkKQrNKba7kpHQHL+Rgr6xzwTIthoNne3qv
         aT7s5wrvSB3BsOu4mUH8TVIbArVPAksTA7MzTprA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 07 Aug 2018 15:41:41 -0700
From:   rishabhb@codeaurora.org
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ard.biesheuvel@linaro.org, vbabka@suse.cz, riel@surriel.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        ckadabi@codeaurora.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, Vikram Mulukutla <markivx@codeaurora.org>
Subject: Re: [PATCH] firmware: Fix security issue with
 request_firmware_into_buf()
In-Reply-To: <CAB=NE6XfwMOMgZK9YrE=kq0++wT109bNQQ0QYcu=0vfuuDyF3g@mail.gmail.com>
References: <1533165956-23727-1-git-send-email-rishabhb@codeaurora.org>
 <CAB=NE6XfwMOMgZK9YrE=kq0++wT109bNQQ0QYcu=0vfuuDyF3g@mail.gmail.com>
Message-ID: <aad4d3d0a66f00e429fcc08604c4ed0a@codeaurora.org>
X-Sender: rishabhb@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-02 14:58, Luis Chamberlain wrote:
> On Wed, Aug 1, 2018, 4:26 PM Rishabh Bhatnagar
> <rishabhb@codeaurora.org> wrote:
> 
>> When calling request_firmware_into_buf() with the FW_OPT_NOCACHE
>> flag
>> it is expected that firmware is loaded into buffer from memory.
>> But inside alloc_lookup_fw_priv every new firmware that is loaded is
>> added to the firmware cache (fwc) list head. So if any driver
>> requests
>> a firmware that is already loaded the code iterates over the above
>> mentioned list and it can end up giving a pointer to other device
>> driver's
>> firmware buffer.
>> Also the existing copy may either be modified by drivers, remote
>> processors
>> or even freed. This causes a potential security issue with batched
>> requests
>> when using request_firmware_into_buf.
>> 
>> Fix alloc_lookup_fw_priv to not add to the fwc head list if
>> FW_OPT_NOCACHE
>> is set, and also don't do the lookup in the list.
>> 
>> Fixes: 0e742e9275 ("firmware: provide infrastructure to make fw
>> caching optional")
>> 
>> Signed-off-by: Vikram Mulukutla <markivx@codeaurora.org>
>> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
>> ---
> 
> Did you test with the tools/testing/selftests/firmware/ scripts? If
> not please do so and report back and confirm no regressions are found.
> 
> Brownie points for you to add a test case to show the issue
> highlighted in this patch, and which it fixes. I believe this fix
> should be pushed to stable, so I'll do that after you confirm no
> regressions were found.
> 
> The new selftests changed you'd make would not go to stable, however
> there are Linux distributions and 0day that test the latest tools
> directory against older kernels. So this test would help capture gaps
> later.
> 
>   Luis

I ran the selftests and observed no regressions with this change.
I'm still working on adding a test case though.

-Rishabh
