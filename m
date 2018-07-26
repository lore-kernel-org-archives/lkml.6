Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3981C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6898120891
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6898120891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732121AbeGZRy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:54:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57770 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730768AbeGZRy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:54:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A2E44022909;
        Thu, 26 Jul 2018 16:36:49 +0000 (UTC)
Received: from treble (ovpn-120-3.rdu2.redhat.com [10.10.120.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C1B55111DCF1;
        Thu, 26 Jul 2018 16:36:48 +0000 (UTC)
Date:   Thu, 26 Jul 2018 11:36:47 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Allan Xavier <allan.x.xavier@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Support multiple rodata sections.
Message-ID: <20180726163647.xxn5u6c2ekxtk2b4@treble>
References: <20180725141754.29644-1-allan.x.xavier@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180725141754.29644-1-allan.x.xavier@oracle.com>
User-Agent: NeoMutt/20180323
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 26 Jul 2018 16:36:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 26 Jul 2018 16:36:49 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 03:17:53PM +0100, Allan Xavier wrote:
> This commit adds support for processing switch jump tables in objects
> with multiple .rodata sections, such as those created when using
> -ffunction-sections and -fdata-sections.  Currently, objtool always
> looks in .rodata for jump table information which results in many
> "sibling call from callable instruction with modified stack frame"
> warnings with objects compiled using those flags.

Thanks for the patch!  kpatch-build also uses those flags and has a
similar issue, so it's good this will be useful for multiple users.

> @@ -930,10 +931,13 @@ static struct rela *find_switch_table(struct objtool_file *file,
>  		/* look for a relocation which references .rodata */
>  		text_rela = find_rela_by_dest_range(insn->sec, insn->offset,
>  						    insn->len);
> -		if (!text_rela || text_rela->sym != file->rodata->sym)
> +		if (!text_rela || !text_rela->sym->sec->rodata
> +			       || text_rela->sym != text_rela->sym->sec->sym)
>  			continue;

This last condition is a bit hard to follow.  I think we can just check
that the sym type is STT_SECTION.  Also the formatting deviates a bit
from the kernel style.  How about something like this?

		if (!text_rela || text_rela->sym->type != STT_SECTION ||
		    !text_rela->sym->sec->rodata)
			continue;

> @@ -2133,6 +2137,20 @@ static void cleanup(struct objtool_file *file)
>  	elf_close(file->elf);
>  }
>  
> +static bool mark_rodata(struct objtool_file *file)
> +{
> +	struct section *sec;
> +	bool found = false;
> +
> +	for_each_sec(file, sec)

Please use brackets for the outer loop.

> +		if (strstr(sec->name, ".rodata") == sec->name) {
> +			sec->rodata = true;
> +			found = true;

This check is too broad.  It will also match the following sections:

.rodata.str1.8
.rodata.str1.1
.rela.rodata
.init.rodata

Also, the loop should break once it finds an rodata section.


> +		}
> +
> +	return found;
> +}
> +
>  int check(const char *_objname, bool orc)
>  {
>  	struct objtool_file file;
> @@ -2147,10 +2165,10 @@ int check(const char *_objname, bool orc)
>  	INIT_LIST_HEAD(&file.insn_list);
>  	hash_init(file.insn_hash);
>  	file.whitelist = find_section_by_name(file.elf, ".discard.func_stack_frame_non_standard");
> -	file.rodata = find_section_by_name(file.elf, ".rodata");
>  	file.c_file = find_section_by_name(file.elf, ".comment");
>  	file.ignore_unreachables = no_unreachable;
>  	file.hints = false;
> +	file.rodata = mark_rodata(&file);

I believe it would be cleaner to call mark_rodata() from
decode_sections().  And file.rodata bool should be set from within
mark_rodata().

-- 
Josh
