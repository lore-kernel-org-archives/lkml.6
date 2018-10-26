Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC7DECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB5B2085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="KwhMjbOS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB5B2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbeJ0FAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 01:00:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34974 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbeJ0FAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 01:00:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id l17-v6so1088859pff.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 13:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pqVgULwRW+OGf6K4lu81tzNyYIbVseg9dapkgcAUZko=;
        b=KwhMjbOSnYQnqfsMRbhvCG1ZN5vbp0kVABo/sSHuiKHJgtfHSxD31pHyI4C4cqx23Y
         d/l3Zm246saXYzsYwbcV/ZtJhFY3Ut+/Pj1Pnrq/VH/f03H9WQ2tWJvNdag0TbLvIU1M
         ezmD7xgA4xbizvxGjgBcTTBEpQFSIxUGIjx14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pqVgULwRW+OGf6K4lu81tzNyYIbVseg9dapkgcAUZko=;
        b=MItIH6poauPHWxSt4eLMtHlbg12Tf7OWfx51S28+9WVpMsZ14TSe9+LJ3u7P+2EbYq
         ksF5/0YLoMebcudKVAVeLNY4WEJcaNi+dVwZM2sgsxfL3figvsG0OhgdoWi+itpC/9Zk
         tgeoNzMdzsIWfABNsTNR4WRMr8Y43IagmPG9P4qyegBaBYwmzEjGHrSNUJs67WBYphDW
         SHh+82zzMUXD7N3I5MUJvpIf0P0vW+MBcPV4fmAjxjx0aoVf4BjDad0QUf0CVPerIQVO
         wjqV2CXj+Ho0uhjTHgp4SBcOIuSE8B/ODNOz76RWOZ7qGv51ZhcI3WV4Oubgki2ZrelL
         Q63g==
X-Gm-Message-State: AGRZ1gJxZ2g17CEqn7BV33/aqc//C+rDa9AwAT+C6lhcys4bnN7vq+Oq
        ScVXled3gP1hO5KAuGRYp6jtOw==
X-Google-Smtp-Source: AJdET5f4qY2D8x55WcSW/ezZgcFT7m7uBGsIKjfPQmkf8E9KsXOob5ZMDOo5g95whPp1Eid4ipZOGw==
X-Received: by 2002:a65:4c8d:: with SMTP id m13-v6mr4510988pgt.83.1540585328049;
        Fri, 26 Oct 2018 13:22:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id v189-v6sm17294270pfb.54.2018.10.26.13.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 13:22:06 -0700 (PDT)
Date:   Fri, 26 Oct 2018 13:22:05 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [RFC 5/6] pstore: donot treat empty buffers as valid
Message-ID: <20181026202205.GB129228@joelaf.mtv.corp.google.com>
References: <20181026180042.52199-1-joel@joelfernandes.org>
 <20181026180042.52199-5-joel@joelfernandes.org>
 <CAGXu5jKtZjZVr=7dAHQPU0OGtBpEKDZBO68-RTvFLbK6qB+cEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKtZjZVr=7dAHQPU0OGtBpEKDZBO68-RTvFLbK6qB+cEA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 08:39:13PM +0100, Kees Cook wrote:
> On Fri, Oct 26, 2018 at 7:00 PM, Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> > pstore currently calls persistent_ram_save_old even if a buffer is
> > empty. While this appears to work, it is simply not the right thing to
> > do and could lead to bugs so lets avoid that. It also prevent misleading
> > prints in the logs which claim the buffer is valid.
> 
> I need to be better convinced that a present zero length record is the
> same as a non-present record. This seems true, but there is
> potentially still metadata available from a backend. What were the
> misleading prints in logs?

I got something like:
found existing buffer, size 0, start 0

When I was expecting:
no valid data in buffer (sig = ...)

The other thing is a call to persistent_ram_zap is also prevented on the
buffer, which prevent zero-initialize prz->ecc_info.par. Since we are
dropping patch 6/6, the zap will not happen. But I'm not super familiar with
the ecc bits of this code to say that if that's an issue.

About the present zero-length record, I would argue that it should not be
"present" at all. When the system first boots, the record is not present but
the signatures are initialized, then on reboots because the signatures were
initialized, the buffer appears as valid even if it was unused. So for dmesg,
all the max_dump_cnt number of buffers would appear as if they are valid
which is a bit strange because there was no crash at all so it should be in
the same state on reboot, as if there was no crash. That could be a matter of
perspective though so I leave it you how you prefer to do it :)

thanks,

- Joel

