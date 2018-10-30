Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34D1C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41B520827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41B520827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbeJ3ST7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:19:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50434 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbeJ3ST7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:19:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C1009C0495A0;
        Tue, 30 Oct 2018 09:27:19 +0000 (UTC)
Received: from krava (unknown [10.43.17.150])
        by smtp.corp.redhat.com (Postfix) with SMTP id 88962601A1;
        Tue, 30 Oct 2018 09:27:18 +0000 (UTC)
Date:   Tue, 30 Oct 2018 10:27:16 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Markus Mayer <mmayer@broadcom.com>,
        "Herton R. Krzesinski" <herton@redhat.com>
Subject: Re: [PATCH 06/10] tools thermal tmon: Override CFLAGS assignments
Message-ID: <20181030092716.GC19259@krava>
References: <20181016150614.21260-1-jolsa@kernel.org>
 <20181016150614.21260-7-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016150614.21260-7-jolsa@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 30 Oct 2018 09:27:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

thanks,
jirka

On Tue, Oct 16, 2018 at 05:06:11PM +0200, Jiri Olsa wrote:
> So user could specify outside CFLAGS values.
> 
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Markus Mayer <mmayer@broadcom.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/thermal/tmon/Makefile | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/thermal/tmon/Makefile b/tools/thermal/tmon/Makefile
> index 735a510230c3..89a2444c1df2 100644
> --- a/tools/thermal/tmon/Makefile
> +++ b/tools/thermal/tmon/Makefile
> @@ -6,13 +6,13 @@ VERSION = 1.0
>  
>  BINDIR=usr/bin
>  WARNFLAGS=-Wall -Wshadow -W -Wformat -Wimplicit-function-declaration -Wimplicit-int
> -CFLAGS+= -O1 ${WARNFLAGS}
> +override CFLAGS+= -O1 ${WARNFLAGS}
>  # Add "-fstack-protector" only if toolchain supports it.
> -CFLAGS+= $(call cc-option,-fstack-protector)
> +override CFLAGS+= $(call cc-option,-fstack-protector-strong)
>  CC?= $(CROSS_COMPILE)gcc
>  PKG_CONFIG?= pkg-config
>  
> -CFLAGS+=-D VERSION=\"$(VERSION)\"
> +override CFLAGS+=-D VERSION=\"$(VERSION)\"
>  LDFLAGS+=
>  TARGET=tmon
>  
> @@ -29,7 +29,7 @@ TMON_LIBS += $(shell $(PKG_CONFIG) --libs $(STATIC) panelw ncursesw 2> /dev/null
>  		     $(PKG_CONFIG) --libs $(STATIC) panel ncurses 2> /dev/null || \
>  		     echo -lpanel -lncurses)
>  
> -CFLAGS    += $(shell $(PKG_CONFIG) --cflags $(STATIC) panelw ncursesw 2> /dev/null || \
> +override CFLAGS += $(shell $(PKG_CONFIG) --cflags $(STATIC) panelw ncursesw 2> /dev/null || \
>  		     $(PKG_CONFIG) --cflags $(STATIC) panel ncurses 2> /dev/null)
>  
>  OBJS = tmon.o tui.o sysfs.o pid.o
> -- 
> 2.17.2
> 
