Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB0CC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DECF4223D9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DECF4223D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeHJJci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 05:32:38 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:34770 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726961AbeHJJch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 05:32:37 -0400
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.53 with ESMTP; 10 Aug 2018 16:04:04 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.151 with ESMTP; 10 Aug 2018 16:04:04 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Fri, 10 Aug 2018 16:04:04 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH v3 6/7] tracing: Add snapshot action
Message-ID: <20180810070404.GD479@sejong>
References: <cover.1533753152.git.tom.zanussi@linux.intel.com>
 <b3cfc09e0c3e55dc0d6682cd2b89525f3f446665.1533753152.git.tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b3cfc09e0c3e55dc0d6682cd2b89525f3f446665.1533753152.git.tom.zanussi@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 09:34:16AM -0500, Tom Zanussi wrote:
> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Add support for hist:handlerXXX($var).snapshot(), which will take a
> snapshot of the current trace buffer whenever handlerXXX is hit.
> 
> As a first user, this also adds snapshot() action support for the
> onmax() handler i.e. hist:onmax($var).snapshot().
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---

[SNIP]
> +static struct track_data *track_data_alloc(unsigned int key_len,
> +					   struct action_data *action_data,
> +					   struct hist_trigger_data *hist_data)
> +{
> +	struct track_data *data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	unsigned int size = TASK_COMM_LEN;
> +	struct hist_elt_data *elt_data;
> +
> +	if (!data)
> +		return ERR_PTR(-ENOMEM);
> +
> +	data->key = kzalloc(key_len, GFP_KERNEL);
> +	if (!data->key) {
> +		track_data_free(data);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	data->key_len = key_len;
> +	data->action_data = action_data;
> +	data->hist_data = hist_data;
> +
> +	elt_data = kzalloc(sizeof(*elt_data), GFP_KERNEL);
> +	if (!elt_data) {
> +		track_data_free(data);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +	elt_data->comm = kzalloc(size, GFP_KERNEL);
> +	if (!elt_data->comm) {
> +		track_data_free(data);

It seems to leak 'elf_data' here.

Thanks,
Namhyung


> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	data->elt.private_data = elt_data;
> +
> +	return data;
> +}
