Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FA9C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 08:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67320208FC
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 08:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67320208FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752944AbeGGINx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 04:13:53 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:56144 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751693AbeGGINu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 04:13:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id AE099CDE;
        Sat,  7 Jul 2018 10:13:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pIDrT28NW_Ev; Sat,  7 Jul 2018 10:13:47 +0200 (CEST)
Received: from var.youpi.perso.aquilenet.fr (dhcp-64-205.ens-lyon.fr [140.77.64.205])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id D791273E;
        Sat,  7 Jul 2018 10:13:47 +0200 (CEST)
Received: from samy by var.youpi.perso.aquilenet.fr with local (Exim 4.91)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1fbiLj-0001KD-D1; Sat, 07 Jul 2018 10:13:47 +0200
Date:   Sat, 7 Jul 2018 10:13:47 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Jann Horn <jannh@google.com>
Cc:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, speakup@linux-speakup.org,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH] staging: speakup: fix wraparound in uaccess length check
Message-ID: <20180707081347.czde44j6rjepjpkf@var.youpi.perso.aquilenet.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Jann Horn <jannh@google.com>, William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, speakup@linux-speakup.org,
        devel@driverdev.osuosl.org
References: <20180707015344.146672-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180707015344.146672-1-jannh@google.com>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann Horn, le sam. 07 juil. 2018 03:53:44 +0200, a ecrit:
> @@ -257,6 +257,8 @@ static ssize_t softsynthx_read(struct file *fp, char __user *buf, size_t count,
>  				0x80 | (ch & 0x3f)
>  			};
>  
> +			if (chars_sent + 2 > count)
> +				break;
>  			if (copy_to_user(cp, s, sizeof(s)))
>  				return -EFAULT;

Err, but then we have lost 'ch' that was consumed by the
synth_buffer_getc() call, so the fix seems wrong to me.

Nacked-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Samuel
