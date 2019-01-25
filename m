Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0DCC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 22:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA5E21855
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 22:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nsB65D8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbfAYWvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 17:51:52 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40351 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728657AbfAYWvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 17:51:52 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so5195198plq.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 14:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0ygU07R7hyqZ5EvZoT2Dyb5b73qPfby1PdmJeQH3/Uc=;
        b=nsB65D8/DniVOkgnbvyJoWy7zeASW1oikpY/J3rHOkVgsAfFNjO5z7EMy+ntRvV9nB
         Qvo3bMF8jJLPEXXZruvfQJ+5coIBmQtshiVd0FsTwrkiJ670YnSyH3k7exg01WkGTpQt
         SUCohCLVnf4rHi6ZqC2cl+W62PWX2v3TBOJXBa+ZHfQWjy/l1sMmJySjQPDMcJNnUOqh
         XEYuwlMQvD41/q7zhKm16ZgRHKypWbAwbXSjbUAl62Lx1NGKPGY+Tlz3oM6ti8fypygw
         j1kFfs6XGWBrWzzBztERiwRzxAJG3ac0Cy17jh7ROklbn3IhwwAg0HX/WWnLvJvi5Z+q
         qv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0ygU07R7hyqZ5EvZoT2Dyb5b73qPfby1PdmJeQH3/Uc=;
        b=oGSbXesuEo29ddvmPNNeWrtR3a2I7rZX/v2ysDnbNCK2/VtwsBOTPS0QOMx1ktU0Tc
         vxESPzZyKTHelf/x4avpdcavGvURJhEAFTCUcKrhoZtZ4HmjEZQNCfX8tsVn/cxBEJsG
         Dya1Nu3oV9blj3GxdzoxuQ9mA/Rs/xUKbr0gm+VoxMAs0Ihjr8DRD0IN/BVHcYl+YGzR
         NfnFnQ0gXLffTsSBO71z0kcNhJwvX8n6MrqaaCVwjny5DuEeQWwiwHcj9Pj1moXKa56F
         IlMgsRiIuj613EAJE2Hc4jfCPdNri388P941yVMv5PqVssnwvQKBjulg0PfDYYdL8UUz
         Know==
X-Gm-Message-State: AJcUukdjid4S7JpgN7jH2fIKcvynNyOOE+1HUv/6kxPOghkTvX2bJbj5
        y6TO21mdFtYM8W0+t8k8l0OqQA==
X-Google-Smtp-Source: ALg8bN5reauIh3/PdGthHww/x6n4d67UER4Lk8vS6vaseKA2BpdpQCV+/QuRpBOl1tGXE308W8WjxA==
X-Received: by 2002:a17:902:4a0c:: with SMTP id w12mr13014850pld.8.1548456711420;
        Fri, 25 Jan 2019 14:51:51 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id l22sm45918689pfj.179.2019.01.25.14.51.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 14:51:50 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gnAKD-0001S8-TS; Fri, 25 Jan 2019 15:51:49 -0700
Date:   Fri, 25 Jan 2019 15:51:49 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Nelson Escobar <neescoba@cisco.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        linux-kernel@vger.kernel.org, Lijun Ou <oulijun@huawei.com>,
        Steve Wise <swise@chelsio.com>, target-devel@vger.kernel.org,
        Christian Benvenuti <benve@cisco.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: Re: [PATCH 0/2] infiniband: trivial header search path fixups
Message-ID: <20190125225149.GA5556@ziepe.ca>
References: <1548391171-6407-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548391171-6407-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 01:39:29PM +0900, Masahiro Yamada wrote:
> My main motivation is to get rid of crappy header search path manipulation
> from Kbuild core.
> 
> Before that, I want to do as many treewide cleanups as possible.
> 
> If you are interested in the big picture of this work,
> the full patch set is available at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git build-test
> 
> 
> 
> Masahiro Yamada (2):
>   infiniband: remove unneeded header search paths
>   infiniband: prefix header search paths with $(srctree)/

Still compiles for me too, applied to rdam for-next

Thanks,
Jason
