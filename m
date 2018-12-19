Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4A0C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A42A218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545231617;
	bh=KKCdey/4m7tAp86qIoTPpAXws5KemPCs2Oiue2/FbEE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=iEBVE8OWLFWg0qpWYO6s7UzLkgVqbSt9NwUQk8Qq3hc4q69A3zBTo+Lf0zF9i3ly2
	 qYScUI5MTdtg1IgH2AGjibWynh6as69dCvQPNXLgo+pw/CJWEhkIkD83ErrTA4+8vl
	 f/PnP/kzrI/nRfsGJfMJcTcP22Bq/OqhvItxntis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbeLSPAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:00:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:60486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729799AbeLSPAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:00:13 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4A5920874;
        Wed, 19 Dec 2018 15:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545231613;
        bh=KKCdey/4m7tAp86qIoTPpAXws5KemPCs2Oiue2/FbEE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Tnc+uWSeKwN4AaM5puERKTVo4Li/QSfvizulaaezK3GolWQQ644CX9MQBS4HxzBHu
         4uPlQveoODq5rnOPDXyeDm+h8lUNWJcLglURltJPlxbpWjUAEbHu/4HzgU/E7ZlmKP
         eMVGPG8brETOR8Iyzmj1VpL08rBY2nlnP1ZIE7tw=
Message-ID: <1545231608.4491.0.camel@kernel.org>
Subject: Re: [PATCH 0/7] tracing: Hist trigger var-ref cleanup and comments
From:   Tom Zanussi <zanussi@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
Date:   Wed, 19 Dec 2018 09:00:08 -0600
In-Reply-To: <20181219114517.GA19177@danjae.aot.lge.com>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
         <20181219114517.GA19177@danjae.aot.lge.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

On Wed, 2018-12-19 at 20:45 +0900, Namhyung Kim wrote:
> Hi Tom,
> 
> On Tue, Dec 18, 2018 at 02:33:19PM -0600, Tom Zanussi wrote:
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Hi,
> > 
> > This patchset is a standalone series broken out of the v8 version
> > of
> > the 'tracing: Hist trigger snapshot and onchange additions'
> > patchset.
> > 
> > It's a series of changes resulting from some suggestions from
> > Namhyung
> > for making the variable-reference handling code more understandable
> > through some refactoring and comments.
> > 
> > It also added a new patch changing all strlen() to sizeof() for
> > string
> > constants, in trace_events_hist.c
> > 
> > Also, in the 'tracing: Remove open-coding of hist trigger var_ref
> > management' patch, in create_var_ref(), moved the saving of
> > ref_field
> > and update of ref_field->var_ref_idx into the 'if' as pointed out
> > by
> > Dan Carpenter/smatch 0-day robot.
> > 
> > It doesn't introduce any functional changes and can be applied
> > independently of the other patchset.
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> 

Thanks!

Tom

