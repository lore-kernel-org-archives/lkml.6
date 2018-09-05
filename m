Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E145C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5254B2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5254B2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mba.ocn.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbeIEUV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 16:21:26 -0400
Received: from mfdf0181.ocn.ad.jp ([153.128.50.75]:50843 "EHLO
        mfdf0181.ocn.ad.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeIEUV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 16:21:26 -0400
X-Greylist: delayed 814 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Sep 2018 16:21:25 EDT
Received: from mogw0633.ocn.ad.jp (mogw0633.ocn.ad.jp [153.149.228.34])
        by mfdf0181.ocn.ad.jp (Postfix) with ESMTP id D7B9F501D57
        for <linux-kernel@vger.kernel.org>; Thu,  6 Sep 2018 00:37:07 +0900 (JST)
Received: from mf-smf-ucb022c1 (mf-smf-ucb022c1.ocn.ad.jp [153.153.66.139])
        by mogw0633.ocn.ad.jp (Postfix) with ESMTP id 283D0E8023E;
        Thu,  6 Sep 2018 00:37:06 +0900 (JST)
Received: from ntt.pod01.mv-mta-ucb027 ([153.149.142.101])
        by mf-smf-ucb022c1 with ESMTP
        id xZrPfBvBHeuR1xZrefi78h; Thu, 06 Sep 2018 00:37:06 +0900
Received: from smtp.ocn.ne.jp ([153.149.227.167])
        by ntt.pod01.mv-mta-ucb027 with 
        id Xrd51y0043dLKTM01rd5gw; Wed, 05 Sep 2018 15:37:06 +0000
Received: from localhost (p935071-ipngn2102funabasi.chiba.ocn.ne.jp [180.56.175.71])
        by smtp.ocn.ne.jp (Postfix) with ESMTPA;
        Thu,  6 Sep 2018 00:37:05 +0900 (JST)
Date:   Thu, 06 Sep 2018 00:37:01 +0900 (JST)
Message-Id: <20180906.003701.1191480642819924726.anemo@mba.ocn.ne.jp>
To:     dingxiang@cmss.chinamobile.com
Cc:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mips: txx9: fix resource leak after register fail
From:   Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1536146539-26131-1-git-send-email-dingxiang@cmss.chinamobile.com>
References: <1536146539-26131-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 6.7 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  5 Sep 2018 19:22:19 +0800, Ding Xiang <dingxiang@cmss.chinamobile.com> wrote:
> the memory allocated and ioremap address need free after
> device_register return error.
...
>  exit_put:
>  	put_device(&dev->dev);
> -	return;
> +exit_free:
> +	iounmap(dev->base);
> +	kfree(dev);

This change will break exit_put error path.
I think kfree will be called from txx9_device_release by put_device.

Please refer James's comment on previous trial:
<https://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20180305221833.GJ4197%40saruman>

---
Atsushi Nemoto
