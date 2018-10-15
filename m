Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F51C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68960208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68960208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbeJPDdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 23:33:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37474 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbeJPDdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 23:33:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F3E283084026;
        Mon, 15 Oct 2018 19:47:00 +0000 (UTC)
Received: from jlaw-desktop.bos.csb (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D0AB5D78D;
        Mon, 15 Oct 2018 19:47:00 +0000 (UTC)
Subject: Re: [PATCH v13 12/12] selftests/livepatch: introduce tests
To:     Petr Mladek <pmladek@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181015123713.25868-1-pmladek@suse.com>
 <20181015123713.25868-13-pmladek@suse.com>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Organization: Red Hat
Message-ID: <635c8f9d-8378-519a-6003-a04c2f999d2d@redhat.com>
Date:   Mon, 15 Oct 2018 15:46:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20181015123713.25868-13-pmladek@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 15 Oct 2018 19:47:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/2018 08:37 AM, Petr Mladek wrote:
> From: Joe Lawrence <joe.lawrence@redhat.com>
> 
> Add a few livepatch modules and simple target modules that the included
> regression suite can run tests against:
> 
>   - basic livepatching (multiple patches, atomic replace)
>   - pre/post (un)patch callbacks
>   - shadow variable API
> 
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
>
> [ ... snip ... ]
>
> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> new file mode 100644
> index 000000000000..d448b115f06c
> --- /dev/null
> +++ b/tools/testing/selftests/livepatch/functions.sh
>
> [ ... snip ... ]
>
> +# disable_lp(modname) - disable a livepatch
> +#	modname - module name to unload
> +function disable_lp() {
> +	local mod="$1"
> +
> +	log "% echo 0 > /sys/kernel/livepatch/$mod/enabled"
> +	echo 0 > /sys/kernel/livepatch/"$mod"/enabled
> +
> + 	# Wait until the transition finishes and the livepatch gets
> +	# removed from sysfs...
> +	loop_until '[[ ! -e "/sys/kernel/livepatch/$mod" ]]' ||
> +		die "failed to disable livepatch $mod"

small nit in case there is a v14:

Applying: selftests/livepatch: introduce tests
/root/linux/.git/rebase-apply/patch:1513: space before tab in indent.
        # Wait until the transition finishes and the livepatch gets

And FWIW v13's selftests ran just fine on ppc64le over here.

-- Joe
