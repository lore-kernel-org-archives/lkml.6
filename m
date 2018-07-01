Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D20DC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 08:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B86B24152
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 08:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpRgPiUI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B86B24152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeGAIhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 04:37:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751861AbeGAIgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 04:36:55 -0400
Received: from redbean.fritz.box (p5B33CB02.dip0.t-ipconnect.de [91.51.203.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A657D24152;
        Sun,  1 Jul 2018 08:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530434214;
        bh=H2bOrofOM0+qmMBZDpGIcxyMgQJDlPhAu97xUJRx1E8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GpRgPiUIRAQoHZiRLndGusUK3c8qNJtlKHRX7hJ4GE5wSMO6Tt1XIXkOcewzHfy2G
         IQG1lqUIGAbiQQrjA7thsknfHG4ksvOZcQWsAc23/IJGfDhNjd0xHp7c/RVJFiByq8
         TMBw2jzdb9TKRZIYjB3PSJgXlZg53HnP2vQDtLIs=
Date:   Sun, 1 Jul 2018 10:36:48 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] modsign: log module name in the event of an error
Message-ID: <20180701083648.5de5sbskp3atqat2@redbean.fritz.box>
References: <20180629155329.2076-1-jeyu@kernel.org>
 <15a087e0c207e87b0e1e7e0bdd5a09c5d336c224.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <15a087e0c207e87b0e1e7e0bdd5a09c5d336c224.camel@perches.com>
X-OS:   Linux redbean 4.17.2-100.fc27.x86_64 x86_64
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Joe Perches [29/06/18 21:04 -0700]:
>On Fri, 2018-06-29 at 17:53 +0200, Jessica Yu wrote:
>> Now that we have the load_info struct all initialized (including
>> info->name, which contains the name of the module) before
>> module_sig_check(), make the load_info struct and hence module name
>> available to mod_verify_sig() so that we can log the module name in the
>> event of an error.
>[]
>> diff --git a/kernel/module-internal.h b/kernel/module-internal.h
>[]
>> +extern int mod_verify_sig(const void *mod, struct load_info *info,
>> +			  unsigned long *_modlen);
>> diff --git a/kernel/module.c b/kernel/module.c
>[]
>> @@ -2778,7 +2758,7 @@ static int module_sig_check(struct load_info *info, int flags)
>>  	    memcmp(mod + info->len - markerlen, MODULE_SIG_STRING, markerlen) == 0) {
>>  		/* We truncate the module to discard the signature */
>>  		info->len -= markerlen;
>> -		err = mod_verify_sig(mod, &info->len);
>> +		err = mod_verify_sig(mod, info, &info->len);
>
>This is the only place this is used correct?
>So why pass info and info->member?
>
>info should be enough

Ah yeah you're right, thanks!

Jessica
