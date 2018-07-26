Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47485C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF56F20846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Eu6Qs8Vp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF56F20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732841AbeGZS5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 14:57:19 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46694 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732107AbeGZS5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 14:57:18 -0400
Received: by mail-pl0-f68.google.com with SMTP id t17-v6so1121726ply.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 10:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6Ig0fyc+6vGNwjbZv3x13AGsMzcYWVNuGcdn4Xc/T9M=;
        b=Eu6Qs8Vp7VG60oBmKYwudzNtB5Y4IExBFcM0er9iZz5XGbWxP6OVEzg/wq5LDPnheO
         vD2EVrLy/xAeWmjS9baLgO4q+FeZVwgLjSVUafDfK6VCmIdjvTY7cqYXF/FSQHSy6Hak
         vuizaxtJxRrMevQGI4lm3ju4cf27M8CGTZDdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6Ig0fyc+6vGNwjbZv3x13AGsMzcYWVNuGcdn4Xc/T9M=;
        b=dR44v81BnHALwKVLSDJhOCpQpWM4TF7Y7sSbLtbTaOkTTV1m6eoLMpF0NY91GvGULY
         IWe98/Z43tmYlvysDUQG/iO5G6sSDsT2byXxQ7Vflo/rrPwWn9+aNKEGAjQcGKn49AWT
         PN390FH/1f6P3ts49s/K6xF2K3hXTcKfOygNJMQkG4W0EgYl88tnwGLWlAUaY8Pd1ksd
         K2YuaQ1NAhjV9l8TB73NNcPmEVVVqSajaD6QsCf7O5+dTPehn3Ge8E3g/3F0vKWayDfh
         rFyRXlVUgZL7bbqRJsQjOL9Eh8RPSl3E4l75/za7Ahm1yNhFeXzPbjq96lFLLXvD2MYZ
         slaA==
X-Gm-Message-State: AOUpUlHr9FtpkXLc8KX7x/CCi8OVsqHbb3s0gg+S920+L4nP/BHh104g
        TB9Hhk5HcIVR1dbHL57cAifeKQ==
X-Google-Smtp-Source: AAOMgpcO9lPx5TG6l8SSU23CDvsCoPB7Wpn4tJGFsIQfTEGTAMIunjW3jpZ8bwhBxEKfppZB2QdiXA==
X-Received: by 2002:a17:902:8215:: with SMTP id x21-v6mr2778439pln.175.1532626768318;
        Thu, 26 Jul 2018 10:39:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id y63-v6sm3189279pgd.94.2018.07.26.10.39.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 10:39:27 -0700 (PDT)
Date:   Thu, 26 Jul 2018 10:39:27 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org
Subject: Re: [LKP] [rcutorture]  3b745c8969:
 WARNING:at_mm/slab_common.c:#kmalloc_slab
Message-ID: <20180726173927.GA105223@joelaf.mtv.corp.google.com>
References: <20180726085015.GA29979@shao2-debian>
 <20180726115325.GE24813@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726115325.GE24813@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 04:53:25AM -0700, Paul E. McKenney wrote:
> On Thu, Jul 26, 2018 at 04:50:15PM +0800, kernel test robot wrote:
> > 
> > FYI, we noticed the following commit (built with gcc-5):
> > 
> > commit: 3b745c8969c752601cb68c82a06735363563ab42 ("rcutorture: Make boost test more robust")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > in testcase: boot
> > 
> > on test machine: qemu-system-x86_64 -enable-kvm -smp 2 -m 512M
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> Is this fixed by 4babd855fd61 ("rcutorture: Add support to detect
> if boost kthread prio is too low")?  That could address the
> rcu_torture_stats_print() failures, depending on exactly what they were.
> (Yes, I should have reversed these two commits, but they are in -tip
> now, so that ship has sailed.)
> 
> Joel, any other thoughts?

Last I tried to reproduce this issue on my setup, I wasn't able to. I can try
again to reproduct it in LKP today if you feel its a real issue triggered by
the rcutorture boost patches.

> That aside, the 450efca718 column has zeroes all the way down, so I do
> have some questions about that.  ;-)

Yes me too ;-) It seems quite odd all those columns show failures. Especially
the Kmalloc test failure and the warning in the enclosed dmesg log seems
nothing to do with the RCU boost patches.

Could it be a cascading effect of the failures where one failure triggers
another?

thanks!

 - Joel
 
