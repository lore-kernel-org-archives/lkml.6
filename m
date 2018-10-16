Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42779C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1133020881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1133020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeJPWQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:16:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59255 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbeJPWQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:16:26 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 33B20A8327;
        Tue, 16 Oct 2018 14:25:44 +0000 (UTC)
Received: from treble (ovpn-125-6.rdu2.redhat.com [10.10.125.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D3B127C3D;
        Tue, 16 Oct 2018 14:25:42 +0000 (UTC)
Date:   Tue, 16 Oct 2018 09:25:40 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Borislav Petkov <bp@suse.de>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] objtool: move libelf check out of top Makefile
Message-ID: <20181016142540.pxlwu3ft6n2b4pgj@treble>
References: <1539681053-24388-1-git-send-email-yamada.masahiro@socionext.com>
 <1539681053-24388-3-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1539681053-24388-3-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 16 Oct 2018 14:25:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 06:10:52PM +0900, Masahiro Yamada wrote:
> Another behavioral change is, missing libelf for CONFIG_STACK_VALIDATION
> was previously a warning, but now a error.

This behavioral change should be fine.  It was already an error for
UNWINDER_ORC, so this would only upgrade a warning to an error for
people using STACK_VALIDATION without ORC, which should be a small
number of people by this point.

> diff --git a/scripts/Makefile.toolcheck b/scripts/Makefile.toolcheck
> index f3c165d..bc26fc0 100644
> --- a/scripts/Makefile.toolcheck
> +++ b/scripts/Makefile.toolcheck
> @@ -12,6 +12,11 @@ include include/config/auto.conf
>  __toolcheck:
>  	@:
>  
> +chk_stack_validation = echo "int main() {}" | $(HOSTCC) -xc -o /dev/null -lelf -
> +msg_stack_validation = "libelf is necessary for building the objtool." \
> +		       "Please install libelf-dev, libelf-devel or elfutils-libelf-devel."
> +toolcheck-$(CONFIG_STACK_VALIDATION) += stack_validation
> +
>  PHONY += $(toolcheck-y)
>  __toolcheck: $(toolcheck-y)

This is a nice improvement.

It would probably be a good idea to clarify to the user which config
option(s) are the cause for the error, by putting
"CONFIG_STACK_VALIDATION" in the error string, for example.

Though, for this particular case, it would be clearer to have a
different error, based on which option is enabled, like we had before.

Like:


ifdef CONFIG_UNWINDER_ORC

chk_unwinder_orc = echo "int main() {}" | $(HOSTCC) -xc -o /dev/null -lelf -
msg_unwinder_orc = "Cannot build objtool to generate ORC metadata for CONFIG_UNWINDER_ORC=y.  " \
		       "Please install libelf-dev, libelf-devel or elfutils-libelf-devel."
toolcheck-$(CONFIG_UNWINDER_ORC) += unwinder_orc

else

chk_stack_validation = echo "int main() {}" | $(HOSTCC) -xc -o /dev/null -lelf -
msg_stack_validation = "Cannot build objtool for CONFIG_STACK_VALIDATION=y.  " \
		       "Please install libelf-dev, libelf-devel or elfutils-libelf-devel."
toolcheck-$(CONFIG_STACK_VALIDATION) += stack_validation

endif


What do you think?

-- 
Josh
