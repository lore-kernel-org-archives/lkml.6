Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3818C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 11:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574CD208A6
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 11:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 574CD208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932865AbeGHK7x (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 06:59:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36182 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932757AbeGHK7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 06:59:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5FDEB77888;
        Sun,  8 Jul 2018 10:59:51 +0000 (UTC)
Received: from krava (ovpn-204-62.brq.redhat.com [10.40.204.62])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9C4392026D65;
        Sun,  8 Jul 2018 10:59:49 +0000 (UTC)
Date:   Sun, 8 Jul 2018 12:59:48 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Laura Abbott <labbott@redhat.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robin Jarry <robin.jarry@6wind.com>
Subject: Re: [PATCH 1/7] tools: build: Fixup host c flags
Message-ID: <20180708105948.GB29861@krava>
References: <20180707010709.16648-1-labbott@redhat.com>
 <20180707010709.16648-2-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180707010709.16648-2-labbott@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Sun, 08 Jul 2018 10:59:51 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Sun, 08 Jul 2018 10:59:51 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 06:07:03PM -0700, Laura Abbott wrote:
> Commit 0c3b7e42616f ("tools build: Add support for host programs format")
> introduced host_c_flags which referenced CHOSTFLAGS. The actual name of the
> variable is HOSTCFLAGS. Fix this up.
> 
> Fixes: 0c3b7e42616f ("tools build: Add support for host programs format")
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> This seemed like a typo to the best of my understanding and certain
> things wouldn't link properly until this was fixed.

ugh, thanks for finding this.. I think/hope it's typo ;-)

please also change the only perf user of this:

tools/perf/pmu-events/Build:CHOSTFLAGS_jevents.o   = -I$(srctree)/tools/include

jirka

> ---
>  tools/build/Build.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/build/Build.include b/tools/build/Build.include
> index a4bbb984941d..b5c679cd441c 100644
> --- a/tools/build/Build.include
> +++ b/tools/build/Build.include
> @@ -98,4 +98,4 @@ cxx_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(CXXFLAGS) -D"BUILD_STR(s)=\#s" $(CXX
>  ###
>  ## HOSTCC C flags
>  
> -host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(CHOSTFLAGS) -D"BUILD_STR(s)=\#s" $(CHOSTFLAGS_$(basetarget).o) $(CHOSTFLAGS_$(obj))
> +host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(HOSTCFLAGS) -D"BUILD_STR(s)=\#s" $(HOSTCFLAGS_$(basetarget).o) $(HOSTCFLAGS_$(obj))
> -- 
> 2.17.1
> 
