Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8341C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21546206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544803782;
	bh=YQ6AGzFDNJrkYLN9gcs1gpWI2Mab76i/0jiGgUmBwyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Zbcj4DgeZRZWvbTc9f6qzqG+rsqlGcN0J0Pok2GN1ssG5PuJasaR3/RP22phtxNka
	 DVrdATGLvJtbK5v1rovIyoD/HCYhfvPQCAyV7QzN44fGvU1TUPIs4th2DgHJx5MgNl
	 2Lf6VW+O006VFShvMAm7uxu5TQ/XomOib3Q1PlYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbeLNQJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:09:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:42946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbeLNQJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:09:40 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7F1D206BA;
        Fri, 14 Dec 2018 16:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544803780;
        bh=YQ6AGzFDNJrkYLN9gcs1gpWI2Mab76i/0jiGgUmBwyM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qbMCrEv3KuwwpcfzAsTeJGBs/ZzfAA0EDM0hTjRbdBtkEPOafsLi6KAkVkPlEjU9u
         2vkBMuGT6CNrg0YiQafeKKkb7pHN3rPGjTKMLk3Jvcl0ekxOVpODkLILp8Debq0rWt
         s8fi/KMK+1BZ+Poo4ZUOB0Cl+Dcpj7UlVFPieKzI=
Date:   Sat, 15 Dec 2018 01:09:36 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v8 10/22] tracing: Add hist trigger onchange() handler
Message-Id: <20181215010936.ac9ae50716be12c332f30d58@kernel.org>
In-Reply-To: <033a34023c6ef2a64adba8fd0a6c00061873f80c.1544483273.git.tom.zanussi@linux.intel.com>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
        <033a34023c6ef2a64adba8fd0a6c00061873f80c.1544483273.git.tom.zanussi@linux.intel.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

Just a nitpick.

On Mon, 10 Dec 2018 18:01:24 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

>  enum action_id {
> @@ -1961,7 +1962,8 @@ static int parse_action(char *str, struct hist_trigger_attrs *attrs)
>  		return ret;
>  
>  	if ((strncmp(str, "onmatch(", strlen("onmatch(")) == 0) ||
> -	    (strncmp(str, "onmax(", strlen("onmax(")) == 0)) {
> +	    (strncmp(str, "onmax(", strlen("onmax(")) == 0) ||
> +	    (strncmp(str, "onchange(", strlen("onchange(")) == 0)) {

You can use sizeof() instead of strlen() for static string.

[...]
> @@ -4740,6 +4767,15 @@ static int parse_actions(struct hist_trigger_data *hist_data)
>  				ret = PTR_ERR(data);
>  				break;
>  			}
> +		} else if (strncmp(str, "onchange(", strlen("onchange(")) == 0) {
> +			char *action_str = str + strlen("onchange(");

Ditto.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
