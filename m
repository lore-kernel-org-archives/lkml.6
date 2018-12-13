Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D34C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DEA2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ssi.gouv.fr header.i=@ssi.gouv.fr header.b="R1LLWeuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DEA2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ssi.gouv.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbeLMO5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:57:11 -0500
Received: from smtp-out.ssi.gouv.fr ([86.65.182.90]:54644 "EHLO
        smtp-out.ssi.gouv.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeLMO5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:57:11 -0500
Received: from smtp-out.ssi.gouv.fr (localhost [127.0.0.1])
        by smtp-out.ssi.gouv.fr (Postfix) with ESMTP id 2B833D0006B;
        Thu, 13 Dec 2018 15:57:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ssi.gouv.fr;
        s=20160407; t=1544713037;
        bh=hmviYkZAUzSSN4VTzvQLUSCMhOsq6DYKpUiHzI6rReA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From:Subject;
        b=R1LLWeuFQXYicPyde+2L/5l1lnaFYwDfgRmEBw3E9WCmmCD6EgbN+Z6ZzJO73skY/
         WDLTEhYl0+oC3tiRw9wkRp4Web7BQeev58BsJpf+2Sz9/rWiuTl6ArElznFhvALliz
         k8WToO2CpmKORRXoZpFPemas/nO9etlNaSKND0yE76qsYk2tuyvgclN/h5x7PGqBVj
         jjlI7zoFsB1oMVgHUKPn74Vd2NhvkLTpX7hTekaIOBQdwcgLuyWRtb+gq+QcYQffg9
         DeDbusb/qwDu9nx18FzQAERzupwa9lp3FE/j3uZeDH/QZLSquDUh/HrBDfeA03E9/j
         tcixwdWCiP4cQ==
Subject: Re: [RFC PATCH v1 0/5] Add support for O_MAYEXEC
To:     Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>
CC:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?Q?Philippe_Tr=c3=a9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>, Shuah Khan <shuah@kernel.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        <kernel-hardening@lists.openwall.com>, <linux-api@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20181212081712.32347-1-mic@digikod.net>
 <alpine.LRH.2.21.1812130642250.29507@namei.org>
 <87lg4upkpv.fsf@oldenburg2.str.redhat.com>
 <alpine.LRH.2.21.1812131039400.7600@namei.org>
 <87ftv2ovp8.fsf@oldenburg2.str.redhat.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>
Message-ID: <21824ed9-0fe4-85dd-bdd2-d4426e97233d@ssi.gouv.fr>
Date:   Thu, 13 Dec 2018 15:57:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87ftv2ovp8.fsf@oldenburg2.str.redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/12/2018 06:13, Florian Weimer wrote:
> * James Morris:
> 
>> On Wed, 12 Dec 2018, Florian Weimer wrote:
>>
>>> * James Morris:
>>>
>>>> If you're depending on the script interpreter to flag that the user may 
>>>> execute code, this seems to be equivalent in security terms to depending 
>>>> on the user.  e.g. what if the user uses ptrace and clears O_MAYEXEC?

This security mechanism makes sense in an hardened system where the user
is not allowed to import and execute new file (write xor execute
policy). This can be enforced with appropriate mount points a more
advanced access control policy.

>>>
>>> The argument I've heard is this: Using ptrace (and adding the +x
>>> attribute) are auditable events.
>>
>> I guess you could also preload a modified libc which strips the flag.
> 
> My understanding is that this new libc would have to come somewhere, and
> making it executable would be an auditable even as well.

Auditing is a possible use case as well, but the W^X idea is to deny use
of libraries which are not in an executable mount point, i.e. only
execute trusted code.
