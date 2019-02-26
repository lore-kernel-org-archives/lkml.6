Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A5EC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464F72173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQtFbopc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbfBZRzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:55:23 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37890 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbfBZRzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:55:22 -0500
Received: by mail-pg1-f194.google.com with SMTP id m2so6566107pgl.5;
        Tue, 26 Feb 2019 09:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HkweCmHpOLOCb8ww2AibeeNmBINYsPJ+LIpS2tWUIu0=;
        b=dQtFbopcdGebB9y0e12kPCYVMLTsUBI3tdobcjqLsn1RpLJqtl8mBY2Idf5E2CnBPx
         Tzj/mK3V5SR9WGvO2XHUmb5UWWi1F6de2oO3S13iyoScHSbywns8J2Bq4IwuX23udKz6
         t66u02a3lLMFP0sYLNzGgvGePdWY5NolZQb62pXElL+tXXR0k7EXA4eKMicKGYo3RPak
         pabdZzeL96rJJ8SSfgua+kZ/vctaqS9KrFRDkZbW/wRa+hdA4jBap3ldiaKqZxMLeXAj
         BXZ+gmCgi95Y3jRs6TWm9GxintPg7PgQ7PiZeEkkKPe3TXYbEOXo/o2+HCVJiT6HZEwJ
         QJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=HkweCmHpOLOCb8ww2AibeeNmBINYsPJ+LIpS2tWUIu0=;
        b=CYhOOJ/CV8wuohhNnDUEpwsBqgS7mw6vrFQXDFAGwN/ph62eRcQLYbRlYBhVtVeEgi
         jrkeRO7n4BmwR26v0xxAYsZmcagjzpP99+bstQHrlsQV9YQAC1Lwo83fMkqshi2ibJ9w
         LpqA9qOsjpARKUMJC+Dyh/y+N7bRJOvgBAJmEo6/u1iPfTed/7obAJ2qdjcIVNZ6qBhT
         XagY6K4KzOnSMYmJH9P0weN2eicGj6UcyM6/Es8Lenfh2CsQyJGsgQNVMconK0Q6K0Ym
         Luu02QwXdkjUkyQsMkTHzyNG8lBXSktXMkh5lKMkEXwj9CLyDsER4NOu7OmxLfyxmvhZ
         vdjg==
X-Gm-Message-State: AHQUAuZHRAVWfI5tJSgPUA/SnllqLi+4O/9Z8TIeucesqh+MdWKdbDX1
        ft45CQic6XHD+fxVY1EBhVthPsqZ
X-Google-Smtp-Source: AHgI3IZJ5+1oBC4uhRkRqPv+tq1C2NET1bkEVX9BK+Fn6WstwWq+fnLJUJ4Weo4DqFjC/7rzBhshHQ==
X-Received: by 2002:a63:591f:: with SMTP id n31mr25096138pgb.304.1551203721565;
        Tue, 26 Feb 2019 09:55:21 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f14sm14507328pgv.23.2019.02.26.09.55.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 09:55:20 -0800 (PST)
Date:   Tue, 26 Feb 2019 09:55:19 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] watchdog: pc87413: Mark expected switch fall-through
Message-ID: <20190226175519.GA26692@roeck-us.net>
References: <20190214202618.GA18658@embeddedor>
 <d7065d30-d56b-1b76-cfc6-e209aadc61c0@roeck-us.net>
 <81ad685a-054c-6d5d-4501-ca983da0fc9d@embeddedor.com>
 <ceb0ac6a-df12-4e01-167a-39e306723dde@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ceb0ac6a-df12-4e01-167a-39e306723dde@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 11:46:09AM -0600, Gustavo A. R. Silva wrote:
> Hi all,
> 
> Friendly ping:
> 
> Who can take this?
> 
Wim, presumably.

Guenter

> Thanks
> --
> Gustavo
> 
> 
> On 2/18/19 11:50 AM, Gustavo A. R. Silva wrote:
> > 
> > 
> > On 2/18/19 10:09 AM, Guenter Roeck wrote:
> >> On 2/14/19 12:26 PM, Gustavo A. R. Silva wrote:
> >>> In preparation to enabling -Wimplicit-fallthrough, mark switch
> >>> cases where we are expecting to fall through.
> >>>
> >>> This patch fixes the following warning:
> >>>
> >>> drivers/watchdog/pc87413_wdt.c: In function ‘pc87413_ioctl’:
> >>> drivers/watchdog/pc87413_wdt.c:439:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >>>     pc87413_refresh();
> >>>     ^~~~~~~~~~~~~~~~~
> >>> drivers/watchdog/pc87413_wdt.c:441:2: note: here
> >>>    case WDIOC_GETTIMEOUT:
> >>>    ^~~~
> >>>
> >>> Warning level 3 was used: -Wimplicit-fallthrough=3
> >>>
> >>> Notice that, in this particular case, the code comment is modified
> >>> in accordance with what GCC is expecting to find.
> >>>
> >>> This patch is part of the ongoing efforts to enable
> >>> -Wimplicit-fallthrough.
> >>>
> >>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >>
> >> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> >>
> > 
> > Thanks, Guenter.
> > 
> > --
> > Gustavo
> > 
