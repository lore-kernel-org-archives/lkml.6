Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2435C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639622086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544576081;
	bh=Vhgei585mLF4vrCPwlRcNS1jRzqlme5ij0lBc6+WKXQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=z+MqSgSO6G20FNKvr2NmdU94F3b+wr5jtM/kNK08qn08qzrA/cBCpC+uWO6Ibqfsv
	 msgPxEFSap5w+44b7pH6aWvoLup5jtEqmpSyH66xeSZCdSGkvM3rnwvQgn6iIUn+Xi
	 uTY6hM1PLk4oipHvAmXdm3hDTSHIl+g/9crlivXY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639622086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbeLLAyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:54:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:44724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbeLLAyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 19:54:39 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0400020811;
        Wed, 12 Dec 2018 00:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544576079;
        bh=Vhgei585mLF4vrCPwlRcNS1jRzqlme5ij0lBc6+WKXQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FO77cQrUY3XtmXDb9pjCRLXLXHUtPtCju/55H+c1CMYMRy9RNh1lLsN3d7W/CSFep
         qKNYT24j0bhjXky0rJHl8HqTxpMbsWFM/2jf0Bduq9CZGsT/4m/EkfMu3Bx0IUUplE
         eHACAbn90mGhM15qrNrx3exnXI9vRZ32MMlSN9WY=
Subject: Re: [PATCH] selftests/seccomp: Remove SIGSTOP si_pid check
To:     Kees Cook <keescook@chromium.org>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, shuah <shuah@kernel.org>
References: <20181206235038.GA18273@beast>
 <CAGXu5jJ-OZho9Ft7imNuayNjr0Rnz3p4sKg-yZp2_d4go=G9fA@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <431274ac-9ddc-b5e2-dd00-b4d629d14562@kernel.org>
Date:   Tue, 11 Dec 2018 17:54:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJ-OZho9Ft7imNuayNjr0Rnz3p4sKg-yZp2_d4go=G9fA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/18 5:43 PM, Kees Cook wrote:
> On Thu, Dec 6, 2018 at 3:50 PM Kees Cook <keescook@chromium.org> wrote:
>>
>> Commit f149b3155744 ("signal: Never allocate siginfo for SIGKILL or SIGSTOP")
>> means that the seccomp selftest cannot check si_pid under SIGSTOP anymore.
>> Since it's believed[1] there are no other userspace things depending on the
>> old behavior, this removes the behavioral check in the selftest, since it's
>> more a "extra" sanity check (which turns out, maybe, not to have been
>> useful to test).
>>
>> [1] https://lkml.kernel.org/r/CAGXu5jJaZAOzP1qFz66tYrtbuywqb+UN2SOA1VLHpCCOiYvYeg@mail.gmail.com
>>
>> Reported-by: Tycho Andersen <tycho@tycho.ws>
>> Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>> Shuah, can you make sure that Linus gets this before v4.20 is released? Thanks!
> 
> Ping. Shuah, can you get this to Linus (or should I send it directly?)
> 

I will send this. Thanks for the ping.

-- Shuah

