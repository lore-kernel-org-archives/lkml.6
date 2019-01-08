Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C2AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717B22089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfAHHFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 02:05:52 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:38430 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbfAHHFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 02:05:51 -0500
Received: from light.dominikbrodowski.net (isilmar.linta [10.0.0.1])
        by isilmar-4.linta.de (Postfix) with ESMTPS id C803A200944;
        Tue,  8 Jan 2019 07:05:48 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id AEA1E20484; Tue,  8 Jan 2019 08:01:10 +0100 (CET)
Date:   Tue, 8 Jan 2019 08:01:10 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Christian Brauner <christian@brauner.io>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        mcgrof@kernel.org, joe.lawrence@redhat.com, longman@redhat.com,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com,
        linux-api@vger.kernel.org
Subject: Re: [RESEND PATCH v3 2/2] sysctl: handle overflow for file-max
Message-ID: <20190108070110.GA7998@light.dominikbrodowski.net>
References: <20190107222700.15954-1-christian@brauner.io>
 <20190107222700.15954-3-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107222700.15954-3-christian@brauner.io>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 11:27:00PM +0100, Christian Brauner wrote:
> @@ -2833,6 +2836,10 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
>  				break;
>  			if (neg)
>  				continue;
> +			if ((max && val > *max) || (min && val < *min)) {
> +				err = -EINVAL;
> +				break;
> +			}
>  			val = convmul * val / convdiv;
>  			if ((min && val < *min) || (max && val > *max))
>  				continue;

This is a generic change which affects all users of
do_proc_doulongvec_minmax() that have extra1 or extra2 set. In sysctl.c, I
do not see another user of proc_doulongvec_minmax() that has extra1 or
extra2 set. However, have you verified whether your patch changes the
behaviour for other files that make use of proc_doulongvec_minmax() or
proc_doulongvec_ms_jiffies_minmax(), and not only of the file-max sysctl?

Thanks,
	Dominik
