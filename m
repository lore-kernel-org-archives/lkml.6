Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909F9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650B320859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfBTNzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:55:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60811 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfBTNzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:55:36 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DF8D530EF81;
        Wed, 20 Feb 2019 13:55:35 +0000 (UTC)
Received: from darcari.bos.csb (ovpn-116-179.phx2.redhat.com [10.3.116.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 897F761D1F;
        Wed, 20 Feb 2019 13:55:31 +0000 (UTC)
Subject: Re: [PATCH] tools/power turbostat: return the exit status of a
 command
To:     linux-pm@vger.kernel.org
Cc:     Len Brown <len.brown@intel.com>, Jirka Hladky <jhladky@redhat.com>,
        linux-kernel@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>
References: <1549982079-23516-1-git-send-email-darcari@redhat.com>
From:   David Arcari <darcari@redhat.com>
Organization: Red Hat
Message-ID: <1365e035-3218-aff5-6d86-05215ce25073@redhat.com>
Date:   Wed, 20 Feb 2019 08:55:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1549982079-23516-1-git-send-email-darcari@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 20 Feb 2019 13:55:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ping -- just want to make sure this doesn't get lost.

Thanks!

On 02/12/2019 09:34 AM, David Arcari wrote:
> turbostat failed to return a non-zero exit status even though the
> supplied command (turbostat <command>) failed.  Currently when turbostat
> forks a command it returns zero instead of the actual exit status of the
> command.  Modify the code to return the exit status.
> 
> Signed-off-by: David Arcari <darcari@redhat.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Jirka Hladky <jhladky@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> ---
>  tools/power/x86/turbostat/turbostat.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 9327c0d..c3fad06 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -5077,6 +5077,9 @@ int fork_it(char **argv)
>  		signal(SIGQUIT, SIG_IGN);
>  		if (waitpid(child_pid, &status, 0) == -1)
>  			err(status, "waitpid");
> +
> +		if (WIFEXITED(status))
> +			status = WEXITSTATUS(status);
>  	}
>  	/*
>  	 * n.b. fork_it() does not check for errors from for_all_cpus()
> 

