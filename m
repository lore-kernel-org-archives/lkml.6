Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D73C64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 04:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9B7213A2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 04:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="qWqMd31g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF9B7213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeJFLmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 07:42:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37568 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbeJFLmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 07:42:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id j23-v6so5970251pfi.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 21:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=buawwSaE4LVq8zBFZZNwx1NbiRZrm6PBPrDAaPIvISQ=;
        b=qWqMd31gcrcVQjNdxZoiBdKP0HWyFuwo0BIkNPbZ8HjshhBT3PwGuCf05pVfwBUl6b
         1qjMtOLs8ZIaGrn6tRCWkReXdgn3tOPwScftnwXowo8wrg7U1HFGMfcwwUbaxJ0+EhQm
         CE/QsbqS+FOcH3J7NeZsnNzRxmdZ1u70ZaGww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=buawwSaE4LVq8zBFZZNwx1NbiRZrm6PBPrDAaPIvISQ=;
        b=pJhfeRlp6q3iM7sYoFi1u+96d58QsRx/gWTh3te05EJWs1Xylp4y9pmadxxmGIOskU
         5swGJQeuhduOkC1eRfzUcuFAMS6B4Sxyv6J8kJEaVxxa1ouj90cDlt0CDkeIdeyPeJxE
         ym1z0rijp4hLbODD8uw0+g3aj5BfgYpA9Y8+3Mq4JrXt8RzO2ygiqziuXN2MjegFovKt
         1UtItiZas7t59VHv/h4noazEkigo669DZ5Y2Omk76pvWEQ8rBOEFb2NQwdCUsfHnozMm
         WOjHuPj8FOJIsWuRgtfjF4P4V5V3YDM3LY2CxviB0DgQlIsbRuF50oii2sG57rNbOS2Q
         EbxA==
X-Gm-Message-State: ABuFfoimaVBRChzWCvuR86xyT8XyUZ67LGFOfoIJRG2sifthdtr+6CRq
        L8cKjf7TrhICpbZChvcRmIMUYQ==
X-Google-Smtp-Source: ACcGV62ZJ35r8fo61+vj+CBq2/d4qs9WquhX1ssKrRQ7He+pzBe5xgq/yD9lCKUcKVssF5eJhkuCyw==
X-Received: by 2002:a63:d40c:: with SMTP id a12-v6mr12633830pgh.394.1538800860147;
        Fri, 05 Oct 2018 21:41:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id b3-v6sm17202258pfc.178.2018.10.05.21.40.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 21:40:58 -0700 (PDT)
Date:   Fri, 5 Oct 2018 21:40:57 -0700
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
Message-ID: <20181006044057.GA41279@joelaf.mtv.corp.google.com>
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

Could you annotate this pointer (sbi->s_qf_names) with __rcu so it can be
checked by sparse for proper usage? Its also point #16 in the checklist.txt
RCU document. I enclosed a diff to do this below.

I also saw a bunch of places in super.c where the pointer isn't accessed from
an rcu read section or rcu_dereference, but it was a quick look so sorry if I
missed something. If its true, then are you planning to convert these to use
rcu_dereference and wrapped by an rcu_read_lock/unlock as well?

> +		to_free[i] = rcu_dereference_protected(sbi->s_qf_names[i],
> +						       &sb->s_umount);

Also should this be the following?
		to_free[i] = rcu_dereference_protected(sbi->s_qf_names[i],
					       lockdep_is_held(&sb->s_umount));

> +		rcu_assign_pointer(sbi->s_qf_names[i], old_opts.s_qf_names[i]);
>  	}
> +	for (i = 0; i < EXT4_MAXQUOTAS; i++)
> +		kfree(to_free[i]);
> +	synchronize_rcu();

I had same concern as Paul here about synchronize_rcu done before the kfree.

thanks,

 - Joel

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 5863fd22e90b..eec1b3090d04 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5083,7 +5083,7 @@ struct ext4_mount_options {
 	u32 s_min_batch_time, s_max_batch_time;
 #ifdef CONFIG_QUOTA
 	int s_jquota_fmt;
-	char *s_qf_names[EXT4_MAXQUOTAS];
+	char __rcu *s_qf_names[EXT4_MAXQUOTAS];
 #endif
 };
 
