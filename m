Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE0EC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB83920851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ssi.gouv.fr header.i=@ssi.gouv.fr header.b="Q7K+FECm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB83920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ssi.gouv.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbeLMOXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:23:03 -0500
Received: from smtp-out.ssi.gouv.fr ([86.65.182.90]:51575 "EHLO
        smtp-out.ssi.gouv.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeLMOXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:23:02 -0500
Received: from smtp-out.ssi.gouv.fr (localhost [127.0.0.1])
        by smtp-out.ssi.gouv.fr (Postfix) with ESMTP id 4CFEDD0006B;
        Thu, 13 Dec 2018 15:23:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ssi.gouv.fr;
        s=20160407; t=1544710987;
        bh=XY7N8nFQJpFTTaSbi7mbOH98oOcm1qN4ImvLJfHG3mk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From:Subject;
        b=Q7K+FECmey2To1EhVIxM5xdJPI5oFKzSvY9kybvDrmTKKcEy+yAUC/yATqGyOg61Z
         /DqhI5iYpxBocjiLzBWB3tcA450HFW0KrQyxCCKmBMFu7n3yJk7F2cWEXja1rrXJWB
         h7kVrF+w0mtVsmmgGBpjRa4gz6hGaxW6QT60txGUuPW4Bbx08GsoPwA7ucGkFpUCdb
         BJyG5w3uyjNU+lxRTv1oaH5TaB5ONL1C5opA1NqT4IFiRrK8fhQxFbddU48fnYsCoT
         e2GZ3CNiEysBm/im8RO8WToyF2cCdeP6t1xzso2+vqcob6ApgOU1jCckbYeym22QCU
         LYjR2swD6fP/Q==
Subject: Re: [RFC PATCH v1 1/5] fs: Add support for an O_MAYEXEC flag on
 sys_open()
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Jan Kara <jack@suse.cz>
CC:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
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
        <linux-fsdevel@vger.kernel.org>, <sgrubb@redhat.com>
References: <20181212081712.32347-1-mic@digikod.net>
 <20181212081712.32347-2-mic@digikod.net>
 <20181212144306.GA19945@quack2.suse.cz>
 <20181213094658.GA996@lithium.mbobrowski.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>
Message-ID: <22489759-076e-206a-e367-c13202f05eea@ssi.gouv.fr>
Date:   Thu, 13 Dec 2018 15:23:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20181213094658.GA996@lithium.mbobrowski.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/12/2018 10:47, Matthew Bobrowski wrote:
> On Wed, Dec 12, 2018 at 03:43:06PM +0100, Jan Kara wrote:
>>> When the O_MAYEXEC flag is passed, sys_open() may be subject to
>>> additional restrictions depending on a security policy implemented by an
>>> LSM through the inode_permission hook.
>>>
>>> The underlying idea is to be able to restrict scripts interpretation
>>> according to a policy defined by the system administrator.  For this to
>>> be possible, script interpreters must use the O_MAYEXEC flag
>>> appropriately.  To be fully effective, these interpreters also need to
>>> handle the other ways to execute code (for which the kernel can't help):
>>> command line parameters (e.g., option -e for Perl), module loading
>>> (e.g., option -m for Python), stdin, file sourcing, environment
>>> variables, configuration files...  According to the threat model, it may
>>> be acceptable to allow some script interpreters (e.g. Bash) to interpret
>>> commands from stdin, may it be a TTY or a pipe, because it may not be
>>> enough to (directly) perform syscalls.
>>>
>>> A simple security policy implementation is available in a following
>>> patch for Yama.
>>>
>>> This is an updated subset of the patch initially written by Vincent
>>> Strubel for CLIP OS:
>>> https://github.com/clipos-archive/src_platform_clip-patches/blob/f5cb330d6b684752e403b4e41b39f7004d88e561/1901_open_mayexec.patch
>>> This patch has been used for more than 10 years with customized script
>>> interpreters.  Some examples can be found here:
>>> https://github.com/clipos-archive/clipos4_portage-overlay/search?q=O_MAYEXEC
>>>
>>> Signed-off-by: Mickaël Salaün <mic@digikod.net>
>>> Signed-off-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
>>> Signed-off-by: Vincent Strubel <vincent.strubel@ssi.gouv.fr>
>>> Reviewed-by: Philippe Trébuchet <philippe.trebuchet@ssi.gouv.fr>
>>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>>> Cc: Kees Cook <keescook@chromium.org>
>>> Cc: Mickaël Salaün <mickael.salaun@ssi.gouv.fr>
>>
>> ...
>>
>>> diff --git a/fs/open.c b/fs/open.c
>>> index 0285ce7dbd51..75479b79a58f 100644
>>> --- a/fs/open.c
>>> +++ b/fs/open.c
>>> @@ -974,6 +974,10 @@ static inline int build_open_flags(int flags, umode_t mode, struct open_flags *o
>>>  	if (flags & O_APPEND)
>>>  		acc_mode |= MAY_APPEND;
>>>  
>>> +	/* Check execution permissions on open. */
>>> +	if (flags & O_MAYEXEC)
>>> +		acc_mode |= MAY_OPENEXEC;
>>> +
>>>  	op->acc_mode = acc_mode;
>>>  
>>>  	op->intent = flags & O_PATH ? 0 : LOOKUP_OPEN;
>>
>> I don't feel experienced enough in security to tell whether we want this
>> functionality or not. But if we do this, shouldn't we also set FMODE_EXEC
>> on the resulting struct file? That way also security_file_open() can be
>> used to arbitrate such executable opens and in particular
>> fanotify permission event FAN_OPEN_EXEC will get properly generated which I
>> guess is desirable (support for it is sitting in my tree waiting for the
>> merge window) - adding some audit people involved in FAN_OPEN_EXEC to
>> CC. Just an idea...
> 
> If I'm understanding this patch series correctly, without an enforced LSM
> policy there's realistically no added benefit from a security perspective,
> right?

That's correct. The kernel knows the semantic but the enforcement is
delegated to an LSM and its policy.

> Also, I'm in agreement with what Jan has mentioned in regards to setting
> the __FMODE_EXEC flag when O_MAYEXEC has been specified. This is something that
> would work quite nicely in conjunction with some of the new file access
> notification events.

OK, I will add it in the next patch series (for the new FAN_OPEN_EXEC
support).
