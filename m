Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F47C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0613120850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0613120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbeLDWen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:34:43 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:42128 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeLDWen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:34:43 -0500
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id CACDB3A2B88;
        Tue,  4 Dec 2018 23:24:21 +0100 (CET)
X-Originating-IP: 134.134.139.82
Received: from localhost (unknown [134.134.139.82])
        (Authenticated sender: josh@joshtriplett.org)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id DF8EEFF803;
        Tue,  4 Dec 2018 22:24:17 +0000 (UTC)
Date:   Tue, 4 Dec 2018 14:24:13 -0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        paulmck@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:core/rcu] rcutorture: Make initrd/init execute in userspace
Message-ID: <20181204222412.GA6874@localhost>
References: <tip-229ab0cb5be3bfbac5947df7240f6905470ca413@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-229ab0cb5be3bfbac5947df7240f6905470ca413@git.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 02:09:42PM -0800, tip-bot for Paul E. McKenney wrote:
> --- a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
> +++ b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
> @@ -39,9 +39,22 @@ mkdir $T
>  
>  cat > $T/init << '__EOF___'
>  #!/bin/sh
> +# Run in userspace a few milliseconds every second.  This helps to
> +# exercise the NO_HZ_FULL portions of RCU.
>  while :
>  do
> -	sleep 1000000
> +	q=
> +	for i in \
> +		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
> +		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
> +		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
> +		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
> +		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
> +		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a

Ow. If there's no better way to do this, please do at least comment how many 'a's
this is. (And why 186, exactly?)

Please also consider calibrating the delay loop as you do in the C code.
