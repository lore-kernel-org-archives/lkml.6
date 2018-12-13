Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C81C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E6820873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E6820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbeLMFWI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 00:22:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44472 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbeLMFWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 00:22:07 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 624738E588;
        Thu, 13 Dec 2018 05:22:07 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-82.ams2.redhat.com [10.36.116.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF8C85D9C7;
        Thu, 13 Dec 2018 05:22:02 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?utf-8?Q?Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>, Shuah Khan <shuah@kernel.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/5] Add support for O_MAYEXEC
References: <20181212081712.32347-1-mic@digikod.net>
        <20181213030228.GM6830@bombadil.infradead.org>
Date:   Thu, 13 Dec 2018 06:22:00 +0100
In-Reply-To: <20181213030228.GM6830@bombadil.infradead.org> (Matthew Wilcox's
        message of "Wed, 12 Dec 2018 19:02:28 -0800")
Message-ID: <87bm5qovbb.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 13 Dec 2018 05:22:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Matthew Wilcox:

> On Wed, Dec 12, 2018 at 09:17:07AM +0100, Mickaël Salaün wrote:
>> The goal of this patch series is to control script interpretation.  A
>> new O_MAYEXEC flag used by sys_open() is added to enable userland script
>> interpreter to delegate to the kernel (and thus the system security
>> policy) the permission to interpret scripts or other files containing
>> what can be seen as commands.
>
> I don't have a problem with the concept, but we're running low on O_ bits.
> Does this have to be done before the process gets a file descriptor,
> or could we have a new syscall?  Since we're going to be changing the
> interpreters anyway, it doesn't seem like too much of an imposition to
> ask them to use:
>
> 	int verify_for_exec(int fd)
>
> instead of adding an O_MAYEXEC.

Will this work for auditing?

Maybe add an interface which explicitly upgrades O_PATH descriptors, and
give that a separate flag argument?  I suppose that would be more
friendly to auditing.

Thanks,
Florian
