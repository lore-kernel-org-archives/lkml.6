Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D388C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46AA72145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="gp2V2+sh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46AA72145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeJSHjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 03:39:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40150 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeJSHjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 03:39:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id g21-v6so8598869pfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 16:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6351bzF+lI5O7U+wVHUEhoKIEgDmwbDIUIJo2+Hv3CA=;
        b=gp2V2+sh3pf79Q5b82iwczYpxVQKD+ivSXxKfcreGwG5o3XUy/gDPr/KLsnIDmxApp
         Dd55qQWT2vW7SHiA2qaJEEVW9EryuCkrjUIgmkFJbgIRcpR7fU5UiXPJBh7RaQS72lV2
         As4Jqh8mzwj4z0QiAJ8nEtQ0EXrRU0SA2jPfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6351bzF+lI5O7U+wVHUEhoKIEgDmwbDIUIJo2+Hv3CA=;
        b=VLn/+7p0sG3i58lY+uysFgz5FcnYv0Ij7wF8/7BbnlEV3SRdpcMRSJzagLbwFZMXFt
         nxgf8ia5JJMK/czuvdZKTsVXAYxUJdg1j1u1JusatCZRt9pbDBVjk9adfM9R1hkpYPK3
         BI9P891q42m55GdAmrEPo7CeGOm+hG6xYGoRDQQni+UGvrPb49pluV+rM+/Y75jr3cLR
         G80H+pzS6zMBuyOEdZpd1p9+9IYlqSGaaZW04IUi+ENKVZ2Ez6fEM2hVmZx1/Tedg+Nw
         JPtDrutVo479KT+DzSBZA5BQm62pblADdiL0F42otXq5aOkT+EzAtVLUDfbqG0lAU6G2
         MsFA==
X-Gm-Message-State: ABuFfojTm/sRX5z6hbVdSwRE7uE8GS3xd4MfU4jhI5Ma/+PAalSPGWUc
        HxCC8juLCCcKQY6VmJ84Igw/cA==
X-Google-Smtp-Source: ACcGV60uSpxrngFCukJXEejoH91rsDzorzREBpfgoKoxblJT2/SJePhVHH1tE3J/rAsMHoxxrzzEKA==
X-Received: by 2002:a63:3c46:: with SMTP id i6-v6mr30050434pgn.286.1539905795753;
        Thu, 18 Oct 2018 16:36:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id e3-v6sm28220163pgc.71.2018.10.18.16.36.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 16:36:34 -0700 (PDT)
Date:   Thu, 18 Oct 2018 16:36:33 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joelaf@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        netdev <netdev@vger.kernel.org>,
        Lorenzo Colitti <lorenzo@google.com>,
        Chenbo Feng <fengc@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, stable@vger.kernel.org
Subject: Re: [PATCH v4] Wait for running BPF programs when updating map-in-map
Message-ID: <20181018233633.GA89903@joelaf.mtv.corp.google.com>
References: <20180816040145.gqzqicab4s6kcbye@ast-mbp.dhcp.thefacebook.com>
 <20181012105427.243779-1-dancol@google.com>
 <20181013023138.m445q6itdmyxdtoc@ast-mbp.dhcp.thefacebook.com>
 <CAEXW_YQFs9mcw5Qv04ZRv=ZAK7YeBLJKByQxXYLj34iigS-Q=Q@mail.gmail.com>
 <20181018154657.ehgj3ozy62zy47hi@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018154657.ehgj3ozy62zy47hi@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 08:46:59AM -0700, Alexei Starovoitov wrote:
> On Tue, Oct 16, 2018 at 10:39:57AM -0700, Joel Fernandes wrote:
> > On Fri, Oct 12, 2018 at 7:31 PM, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > > On Fri, Oct 12, 2018 at 03:54:27AM -0700, Daniel Colascione wrote:
> > >> The map-in-map frequently serves as a mechanism for atomic
> > >> snapshotting of state that a BPF program might record.  The current
> > >> implementation is dangerous to use in this way, however, since
> > >> userspace has no way of knowing when all programs that might have
> > >> retrieved the "old" value of the map may have completed.
> > >>
> > >> This change ensures that map update operations on map-in-map map types
> > >> always wait for all references to the old map to drop before returning
> > >> to userspace.
> > >>
> > >> Signed-off-by: Daniel Colascione <dancol@google.com>
> > >> ---
> > >>  kernel/bpf/syscall.c | 14 ++++++++++++++
> > >>  1 file changed, 14 insertions(+)
> > >>
> > >> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > >> index 8339d81cba1d..d7c16ae1e85a 100644
> > >> --- a/kernel/bpf/syscall.c
> > >> +++ b/kernel/bpf/syscall.c
> > >> @@ -741,6 +741,18 @@ static int map_lookup_elem(union bpf_attr *attr)
> > >>       return err;
> > >>  }
> > >>
> > >> +static void maybe_wait_bpf_programs(struct bpf_map *map)
> > >> +{
> > >> +     /* Wait for any running BPF programs to complete so that
> > >> +      * userspace, when we return to it, knows that all programs
> > >> +      * that could be running use the new map value.
> > >> +      */
> > >> +     if (map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS ||
> > >> +         map->map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS) {
> > >> +             synchronize_rcu();
> > >> +     }
> > >
> > > extra {} were not necessary. I removed them while applying to bpf-next.
> > > Please run checkpatch.pl next time.
> > > Thanks
> > 
> > Thanks Alexei for taking it. Me and Lorenzo were discussing that not
> > having this causes incorrect behavior for apps using map-in-map for
> > this. So I CC'd stable as well.
> 
> It is too late in the release cycle.
> We can submit it to stable releases after the merge window.
> 

Sounds good, thanks.

- Joel

