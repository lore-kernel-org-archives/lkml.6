Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2005C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB6E223FF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaOLWjEK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB6E223FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbeHJQhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:37:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727209AbeHJQhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:37:22 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C821C223FE;
        Fri, 10 Aug 2018 14:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533910038;
        bh=Eli3O4PfOuKFngnFh9LUjtVlZd7eWlqyjFteEnrCW7c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CaOLWjEK7j2Jl/jcbeoh09UYxjpBoO/BiSLwSPo/VgP6Un7pwfeR69WY+Yg/RTWAe
         pCwxOCIpenCFh5FUfLb++fJFZEjPmqZzMFMdgO4W9gxlGujIJ45AQzeuARSr8CnuGR
         6ecLzfvkynJTyn5PWww0UNldb1bNCpgpH8Mbcdg8=
Message-ID: <1533910036.1918.12.camel@kernel.org>
Subject: Re: [PATCH v3 6/7] tracing: Add snapshot action
From:   Tom Zanussi <zanussi@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
Date:   Fri, 10 Aug 2018 09:07:16 -0500
In-Reply-To: <20180810070404.GD479@sejong>
References: <cover.1533753152.git.tom.zanussi@linux.intel.com>
         <b3cfc09e0c3e55dc0d6682cd2b89525f3f446665.1533753152.git.tom.zanussi@linux.intel.com>
         <20180810070404.GD479@sejong>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-10 at 16:04 +0900, Namhyung Kim wrote:
> On Thu, Aug 09, 2018 at 09:34:16AM -0500, Tom Zanussi wrote:
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Add support for hist:handlerXXX($var).snapshot(), which will take a
> > snapshot of the current trace buffer whenever handlerXXX is hit.
> > 
> > As a first user, this also adds snapshot() action support for the
> > onmax() handler i.e. hist:onmax($var).snapshot().
> > 
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
> 
> [SNIP]
> > +static struct track_data *track_data_alloc(unsigned int key_len,
> > +					   struct action_data
> > *action_data,
> > +					   struct
> > hist_trigger_data *hist_data)
> > +{
> > +	struct track_data *data = kzalloc(sizeof(*data),
> > GFP_KERNEL);
> > +	unsigned int size = TASK_COMM_LEN;
> > +	struct hist_elt_data *elt_data;
> > +
> > +	if (!data)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	data->key = kzalloc(key_len, GFP_KERNEL);
> > +	if (!data->key) {
> > +		track_data_free(data);
> > +		return ERR_PTR(-ENOMEM);
> > +	}
> > +
> > +	data->key_len = key_len;
> > +	data->action_data = action_data;
> > +	data->hist_data = hist_data;
> > +
> > +	elt_data = kzalloc(sizeof(*elt_data), GFP_KERNEL);
> > +	if (!elt_data) {
> > +		track_data_free(data);
> > +		return ERR_PTR(-ENOMEM);
> > +	}
> > +	elt_data->comm = kzalloc(size, GFP_KERNEL);
> > +	if (!elt_data->comm) {
> > +		track_data_free(data);
> 
> It seems to leak 'elf_data' here.
> 

Yep, it does - thanks for pointing that out.

Tom


> Thanks,
> Namhyung
> 
> 
> > +		return ERR_PTR(-ENOMEM);
> > +	}
> > +
> > +	data->elt.private_data = elt_data;
> > +
> > +	return data;
> > +}
