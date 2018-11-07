Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C57C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675DF20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oz38I4dX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675DF20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbeKHAId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:08:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:36108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbeKHAIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:08:32 -0500
Received: from linux-8ccs (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27C902081D;
        Wed,  7 Nov 2018 14:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541601475;
        bh=Uhhz85+fb48saS+inscMZIOvBce3D0inWWQwMnEk9Uw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oz38I4dXDsZp9Rd+qW0pxoSTyPG21fVOoti71yRJpne68Y2JV6eBxPsl2aAbB5tgE
         Xkj8LUbvYV9H3fDnQxNvh1STUrLxdvnXzSTXXBu3oBhOFKCwRyoW8lgsu9i+2cKiVy
         GQihRh1Px5gQrp9hkc38YLOhYHom2FaskMyS7CgU=
Date:   Wed, 7 Nov 2018 15:37:51 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Ke Wu <mikewu@google.com>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] modsign: use all trusted keys to verify module
 signature
Message-ID: <20181107143750.GA26862@linux-8ccs>
References: <20181022222614.41016-1-mikewu@google.com>
 <20181106232130.33932-1-mikewu@google.com>
 <CANRnR9QkiiNNxSBzLUeFHw--xPGVEd5E0RfqNTgj4ji8LmVz7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CANRnR9QkiiNNxSBzLUeFHw--xPGVEd5E0RfqNTgj4ji8LmVz7g@mail.gmail.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.22-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Ke Wu [06/11/18 15:23 -0800]:
>Thanks for the comment! I switched to use
>VERIFY_USE_SECONDARY_KEYRING, please take a look.

Patch has been queued on modules-next. Thanks!

Jessica

>On Tue, Nov 6, 2018 at 3:21 PM Ke Wu <mikewu@google.com> wrote:
>>
>> Make mod_verify_sig to use all trusted keys. This allows keys in
>> secondary_trusted_keys to be used to verify PKCS#7 signature on a
>> kernel module.
>>
>> Signed-off-by: Ke Wu <mikewu@google.com>
>> ---
>> Changelog since v1:
>> - Use VERIFY_USE_SECONDARY_KEYRING rather than (void *)1UL
>>
>>  kernel/module_signing.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/module_signing.c b/kernel/module_signing.c
>> index f2075ce8e4b3..6b9a926fd86b 100644
>> --- a/kernel/module_signing.c
>> +++ b/kernel/module_signing.c
>> @@ -83,6 +83,7 @@ int mod_verify_sig(const void *mod, struct load_info *info)
>>         }
>>
>>         return verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
>> -                                     NULL, VERIFYING_MODULE_SIGNATURE,
>> +                                     VERIFY_USE_SECONDARY_KEYRING,
>> +                                     VERIFYING_MODULE_SIGNATURE,
>>                                       NULL, NULL);
>>  }
>> --
>> 2.19.1.930.g4563a0d9d0-goog
>>
>
>
>-- 
>Ke Wu | Software Engineer | mikewu@google.com | Google Inc.
