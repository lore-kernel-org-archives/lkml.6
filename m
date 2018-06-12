Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 48F4DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C9C208AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C9C208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934771AbeFLApp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:45:45 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:56595 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932893AbeFLApn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:45:43 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fSXRO-0005u5-Mv; Mon, 11 Jun 2018 18:45:42 -0600
Received: from 97-119-124-205.omah.qwest.net ([97.119.124.205] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fSXRO-0001O9-16; Mon, 11 Jun 2018 18:45:42 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jarrett Farnitano <jmf@amazon.com>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <1528738546-3328-1-git-send-email-jmf@amazon.com>
Date:   Mon, 11 Jun 2018 19:45:35 -0500
In-Reply-To: <1528738546-3328-1-git-send-email-jmf@amazon.com> (Jarrett
        Farnitano's message of "Mon, 11 Jun 2018 10:35:46 -0700")
Message-ID: <877en4suhc.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fSXRO-0001O9-16;;;mid=<877en4suhc.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/p1chMi4NIWj/Z9xtVTdtvauFpWK/hibI=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] kexec: yield to scheduler when loading kimage segments
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jarrett Farnitano <jmf@amazon.com> writes:

> Without yielding while loading kimage segments, a large initrd
> will block all other work on the CPU performing the load until
> it is completed. For example loading an initrd of 200MB on a
> low power single core system will lock up the system for a few
> seconds.
>
> To increase system responsiveness to other tasks at that time,
> call cond_resched() in both the crash kernel and normal kernel
> segment loading loops.
>
> Signed-off-by: Jarrett Farnitano <jmf@amazon.com>

Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>

> ---
>  kernel/kexec_core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 5616755..8ee07d6 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -783,6 +783,8 @@ static int kimage_load_normal_segment(struct kimage *image,
>  		else
>  			buf += mchunk;
>  		mbytes -= mchunk;
> +
> +		cond_resched();
>  	}
>  out:
>  	return result;
> @@ -847,6 +849,8 @@ static int kimage_load_crash_segment(struct kimage *image,
>  		else
>  			buf += mchunk;
>  		mbytes -= mchunk;
> +
> +		cond_resched();
>  	}
>  out:
>  	return result;
