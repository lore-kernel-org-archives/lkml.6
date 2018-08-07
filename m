Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28516C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31222172F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKVd6GFz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D31222172F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389925AbeHGVH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:07:28 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34692 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbeHGVH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:07:28 -0400
Received: by mail-yw1-f67.google.com with SMTP id j68-v6so5328678ywg.1;
        Tue, 07 Aug 2018 11:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QfKl/bgHlm83BZJ1sAv0SmilVlGdx7xbIP86Rv59nVk=;
        b=UKVd6GFze1oAOHs1o/WfXHGTCVqqgd2iM07lXiwtVFRtVvQ0hXvzzn+kSgK604YaGa
         fG1wAMSYslHyFLp1k8KvIvI6H8ul6Wzaxusn1m4lWSq6byd428HfyGdBvB4Br/Y3YU18
         8FPubj+6rxIv5phrddLnhS8dGnyFcOVBOq62e+DzEQhD+6Q9JHGYEh/Fggt/qPp565Nv
         u16dcuHUabBboY/Q0fbYjvRLXYzs3rvf4Y7vZi0VeIE54yf1wR5WtEpyrgNsV223i26Y
         K/CAxzQCp0q5mQlP0ReVEl3Nhkup1PkgTgCJrBaIlWdksUu8cIIupqXnl0DxjFQyvqG9
         ROMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QfKl/bgHlm83BZJ1sAv0SmilVlGdx7xbIP86Rv59nVk=;
        b=ZvExprzsVIgU2wq9NeeuAYBtWikTFFuYCS8+aGHh/rXHB105TC0Di3LYh0XyZ1WbDI
         IuNs0IfzhgxgGy6VG/2cihPJuz5tykwLgvE/V2mfkwFB3TLdhcKcxH7ts47cRox8o+uG
         LW0GGf70YRjhQvGAFy8v7lmBC9gl/KhOBiTjqE1UzIokoRvb65Uy53hxeUZ4TYnVIZtJ
         xpVSGsU5Xbr8nIfcpAEYB/y1Xg6X9l3UuVV1o1t6RhpzljczHfClHn6XK2kC4iLPmkxY
         gO+/sqGZDgxO/VYQ20waGKdXqtfkbo7A32n1UHsl4JQgyWTtQZ16eoBN3eWIMRTTGRwd
         Mv9w==
X-Gm-Message-State: AOUpUlFofhwMQL1OX+MNn4Pe7IH0wbqnT10wN674ojbwkSFJnp5kdiyz
        mqb8Cw6bljyudQ/9uBqeGQY=
X-Google-Smtp-Source: AAOMgpcyxzHx4uxLoT10eY14488gDLM8fHXe7wQ859hVyAjaj7Fjr5g4XZkgnk4E0GJ5SIpOG944Mg==
X-Received: by 2002:a81:25d6:: with SMTP id l205-v6mr10687118ywl.242.1533667905111;
        Tue, 07 Aug 2018 11:51:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:2c4b])
        by smtp.gmail.com with ESMTPSA id g16-v6sm1240401ywe.11.2018.08.07.11.51.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 11:51:44 -0700 (PDT)
Date:   Tue, 7 Aug 2018 11:51:41 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Lameter <cl@linux.com>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>, kernel-team@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2] proc: add percpu populated pages count to meminfo
Message-ID: <20180807185141.GC3978217@devbig004.ftw2.facebook.com>
References: <20180807184723.74919-1-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807184723.74919-1-dennisszhou@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Dennis.

On Tue, Aug 07, 2018 at 11:47:23AM -0700, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> Currently, percpu memory only exposes allocation and utilization
> information via debugfs. This more or less is only really useful for
> understanding the fragmentation and allocation information at a
> per-chunk level with a few global counters. This is also gated behind a
> config. BPF and cgroup, for example, have seen an increase use causing
> increased use of percpu memory. Let's make it easier for someone to
> identify how much memory is being used.
> 
> This patch adds the "Percpu" stat to meminfo to more easily look up how
> much percpu memory is in use. This number includes the cost for all
> allocated backing pages and not just isnight at the a unit, per chunk
> level. Metadata is excluded. I think excluding metadata is fair because
> the backing memory scales with the numbere of cpus and can quickly
> outweigh the metadata. It also makes this calculation light.
> 
> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Andrew, if this looks good, can you please route this?

Thanks.

-- 
tejun
