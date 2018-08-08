Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A2EC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C4F21992
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C4F21992
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeHHOnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 10:43:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbeHHOnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 10:43:42 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86ABC21992;
        Wed,  8 Aug 2018 12:24:14 +0000 (UTC)
Date:   Wed, 8 Aug 2018 08:24:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Liu, Changcheng" <changcheng.liu@intel.com>
Cc:     broonie@opensource.wolfsonmicro.com,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] ASoC: trace: track dapm type in snd_soc_dapm_widget
Message-ID: <20180808082412.20f7bd92@gandalf.local.home>
In-Reply-To: <20180808092927.GA144203@sofia>
References: <20180808092927.GA144203@sofia>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Aug 2018 17:29:27 +0800
"Liu, Changcheng" <changcheng.liu@intel.com> wrote:

> Track snd_soc_dapm_widget:id which is used as dapm
> sequence index in dapm_down_seq/dapm_up_seq. It's
> useful for checking dapm seq after tracking it.
> 
> Signed-off-by: Liu Changcheng <changcheng.liu@intel.com>
> 
> diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
> index 40c300f..0bc935b 100644
> --- a/include/trace/events/asoc.h
> +++ b/include/trace/events/asoc.h
> @@ -92,16 +92,18 @@ DECLARE_EVENT_CLASS(snd_soc_dapm_widget,
>  
>  	TP_STRUCT__entry(
>  		__string(	name,	w->name		)
> +		__field(	int,	id		)
>  		__field(	int,	val		)
>  	),
>  
>  	TP_fast_assign(
>  		__assign_str(name, w->name);
> +		__entry->id = w->id;
>  		__entry->val = val;
>  	),
>  
> -	TP_printk("widget=%s val=%d", __get_str(name),
> -		  (int)__entry->val)
> +	TP_printk("widget=%s dapm_id=%d val=%d", __get_str(name),
> +		  (int)__entry->id, (int)__entry->val)

Not sure why it was there before, but the (int) typecast isn't needed
in either case. __field(int, val) makes __entry->val of type int. Same
for id.

-- Steve

>  );
>  
>  DEFINE_EVENT(snd_soc_dapm_widget, snd_soc_dapm_widget_power,

