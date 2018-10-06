Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642BDC64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 04:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD19208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 04:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="odrT4GTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD19208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeJFLws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 07:52:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39917 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbeJFLwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 07:52:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id c25-v6so5653011pfe.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 21:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AF4T9q6esTLB9832L9cypGeKj5NxUnXSBfgWcHmtG0U=;
        b=odrT4GTFlpJvDxlR4nIgw8X0R6i3f2AzSRdyvPIQe5VSrbjpWInyH7jo0N8lNoG8Wo
         SZ3Ri2Xn2PC1EDpo1SreQ3xxQDEmP6i7Z8AANK6vaDP5HJHQ5wAfBVbp5ULOMzQV8U+V
         DfbIVhkKoiCAMh6D8zYqbW2i+A0aLyO6NDtQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AF4T9q6esTLB9832L9cypGeKj5NxUnXSBfgWcHmtG0U=;
        b=cADgJn60c3qKG4iqazRJ67i7hUnC+uFkAe7ky93Tj4gjm4cKHRSBGbbMVbrqtmXbwt
         NKkzs+6gK3BuOOUYNext+PWRrhb51YSETCikT7K9M6nfL2XCWdPRTtsWYAf4WiuWlHJB
         e9xJ34XckBvJ51a35JRF3+Lfoiym8SPvRfIZFuvy5Yy25sdUErwpmkIwcsXpGe8jnTpy
         civzDvVX4+v2jqm1PRCNO+tF7opkbXcl9h4xJpUUlSTSj4oKaHv5EpYJRxliYM/jKwx2
         HXpPiEa28XQWg8HitnfrD1shxwDoks9IZd+wixrGkV9ifI00BafeOVbOw/nTbip+/yat
         XleA==
X-Gm-Message-State: ABuFfoiUVHfMr0nygk88mAAtbuuro7BZuyrQ60XGWWPrmN81xT58p9uV
        aZ1MmJYB1riA1mI2+j+EwrvOKyPDEBQ=
X-Google-Smtp-Source: ACcGV60h+geK1KC/8rtGoe23+Kn55XRCc8yelEJJxqFCpIUioSqikNRQlm31nafX5Warp1jDvBfjIg==
X-Received: by 2002:a62:5343:: with SMTP id h64-v6mr14831002pfb.226.1538801456098;
        Fri, 05 Oct 2018 21:50:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id m10-v6sm13653157pfg.180.2018.10.05.21.50.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 21:50:54 -0700 (PDT)
Date:   Fri, 5 Oct 2018 21:50:53 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>, pantin@google.com
Subject: Re: [PATCH RFC 0/5] rcu doc updates for whatisRCU and checklist
Message-ID: <20181006045053.GA99811@joelaf.mtv.corp.google.com>
References: <20181005231815.170433-1-joel@joelfernandes.org>
 <20181005234628.GB2548@thunk.org>
 <20181006034540.GM2674@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181006034540.GM2674@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 08:45:40PM -0700, Paul E. McKenney wrote:
> On Fri, Oct 05, 2018 at 07:46:28PM -0400, Theodore Y. Ts'o wrote:
> > On Fri, Oct 05, 2018 at 04:18:09PM -0700, Joel Fernandes (Google) wrote:
> > > 
> > > Here are this week's rcu doc updates based on combing through whatisRCU and
> > > checklists. Hopefully you agree with them. I left several old _bh and _sched
> > > API references as is, since I don't think its a good idea to remove them till
> > > the APIs themselves are removed, however I did remove several of them as well
> > > (like in the first patch in this series) since I feel its better to "encourage"
> > > new users not to use the old API.
> > 
> > Hi Joel,
> > 
> > As it so happens, I just recently wrote my first RCU patch[1] (file
> > systems, especially on-disk data structures, generally tend not to be
> > good candidates for RCU semantics).
> > 
> > [1] http://patchwork.ozlabs.org/patch/979779/
> 
> Very cool!
> 
> One question...  In the following hunk:
> 
> ------------------------------------------------------------------------
> 
> @@ -5353,9 +5362,13 @@  static int ext4_remount(struct super_block *sb, int *flags, char *data)
>  #ifdef CONFIG_QUOTA
>  	sbi->s_jquota_fmt = old_opts.s_jquota_fmt;
>  	for (i = 0; i < EXT4_MAXQUOTAS; i++) {
> -		kfree(sbi->s_qf_names[i]);
> -		sbi->s_qf_names[i] = old_opts.s_qf_names[i];
> +		to_free[i] = rcu_dereference_protected(sbi->s_qf_names[i],
> +						       &sb->s_umount);
> +		rcu_assign_pointer(sbi->s_qf_names[i], old_opts.s_qf_names[i]);
>  	}
> +	for (i = 0; i < EXT4_MAXQUOTAS; i++)
> +		kfree(to_free[i]);
> +	synchronize_rcu();
>  #endif
>  	kfree(orig_data);
>  	return err;
> 
> ------------------------------------------------------------------------
> 
> Shouldn't the synchronize_rcu() precede the loop doing the kfree()
> calls?  Or am I missing something subtle?
> 
> Otherwise, looks good!  I was worried that seq_show_option() might
> sleep, but it looks like it is just putting characters into an
> array.  If there is lingering concern, CONFIG_PROVE_LOCKING will
> usually catch that sort of thing.

Also I was wondering if the "if (sbi->s_qf_names[USRQUOTA])" in the patch
should be "if (rcu_dereference(sbi->s_qf_names[USRQUOTA]))". I don't think
the compiler could optimize the access in this case, bit IMO using the
rcu_dereference would serve to document that its an RCU protected pointer
anyway.

thanks,

 - Joel

