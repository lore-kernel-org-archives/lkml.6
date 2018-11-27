Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812A8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4275021104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4q4U9R6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4275021104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbeK1JsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 04:48:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:41066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbeK1JsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 04:48:23 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED3AA20873;
        Tue, 27 Nov 2018 22:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543358938;
        bh=QaK7pmnC3P6kbc400iwBlopV3gT1Ire+AyYPaFuBtFs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=h4q4U9R6MVg8CXKM/8qxZALHHnYthhW1UrV2O8ta/4GJ0Po4vnP2FB/hSasPi//fu
         Odjh/rtq4ItSiaruv8mDmHiCHzJ7VFAVNrs3ADCQUX/VLArte/LfAk01aSit7hjeS7
         kC2nY+pdGNEE+u6zT6ximWVMhawrMJYc9/l39NNU=
Message-ID: <1543358936.4223.3.camel@kernel.org>
Subject: Re: [PATCH v7 05/16] tracing: Generalize hist trigger onmax and
 save action
From:   Tom Zanussi <zanussi@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
Date:   Tue, 27 Nov 2018 16:48:56 -0600
In-Reply-To: <20181123070105.GA3838@sejong>
References: <cover.1542221862.git.tom.zanussi@linux.intel.com>
         <9baa2b4a9b708791b39f176e3b63c207163d8c3b.1542221863.git.tom.zanussi@linux.intel.com>
         <20181123070105.GA3838@sejong>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

On Fri, 2018-11-23 at 16:01 +0900, Namhyung Kim wrote:
> On Wed, Nov 14, 2018 at 02:18:02PM -0600, Tom Zanussi wrote:
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > 

[snip]

> > -
> > -	update_max_vars(hist_data, elt, rbe, rec);
> > +	if (update_track_val(hist_data, elt, data, var_ref_vals))
> > +		update_save_vars(hist_data, elt, rbe, rec);
> 
> ... and then it should look like:
> 
> 	if (check_track_val()) {
> 		save_track_val();
> 		update_save_vars();
> 	}
> 
> I also think update_save_vars() also needs to be renamed something
> like save_track_vars() or save_trace_data().
> 

Yes, this is much nicer - I've made these changes and more for v8. 
Thanks for the input.

Tom

