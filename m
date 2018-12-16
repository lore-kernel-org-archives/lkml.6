Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8592FC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 18:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E72B2086C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 18:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbeLPSzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 13:55:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38752 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730593AbeLPSzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 13:55:43 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6B8F4E3E19;
        Sun, 16 Dec 2018 18:55:43 +0000 (UTC)
Received: from ovpn-116-87.ams2.redhat.com (ovpn-116-87.ams2.redhat.com [10.36.116.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6611B1055006;
        Sun, 16 Dec 2018 18:55:41 +0000 (UTC)
Message-ID: <2444a44091ae292166c6cad1e31fd85ed2b77fe7.camel@redhat.com>
Subject: Re: [PATCH net-next v3 0/4] net: mitigate retpoline overhead
From:   Paolo Abeni <pabeni@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, eric.dumazet@gmail.com, pjt@google.com,
        linux-kernel@vger.kernel.org, ecree@solarflare.com,
        dwmw2@infradead.org
Date:   Sun, 16 Dec 2018 19:55:40 +0100
In-Reply-To: <20181215.132333.867660599141318055.davem@davemloft.net>
References: <cover.1544784419.git.pabeni@redhat.com>
         <20181215.132333.867660599141318055.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sun, 16 Dec 2018 18:55:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-12-15 at 13:23 -0800, David Miller wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> Date: Fri, 14 Dec 2018 11:51:56 +0100
> 
> > The spectre v2 counter-measures, aka retpolines, are a source of measurable
> > overhead[1]. We can partially address that when the function pointer refers to
> > a builtin symbol resorting to a list of tests vs well-known builtin function and
> > direct calls.
> > 
> > Experimental results show that replacing a single indirect call via
> > retpoline with several branches and a direct call gives performance gains
> > even when multiple branches are added - 5 or more, as reported in [2].
> > 
> > This may lead to some uglification around the indirect calls. In netconf 2018
> > Eric Dumazet described a technique to hide the most relevant part of the needed
> > boilerplate with some macro help.
> > 
> > This series is a [re-]implementation of such idea, exposing the introduced
> > helpers in a new header file. They are later leveraged to avoid the indirect
> > call overhead in the GRO path, when possible.
> > 
> > Overall this gives > 10% performance improvement for UDP GRO benchmark and
> > smaller but measurable for TCP syn flood.
> > 
> > The added infra can be used in follow-up patches to cope with retpoline overhead
> > in other points of the networking stack (e.g. at the qdisc layer) and possibly
> > even in other subsystems.
>  ...
> 
> Series applied, I'll push this out after a build check completes.

Again, I messed it! I'm really sorry to waste everybody's time.
I was unable to give proper coverage with different configs. I tested
vs.:

CONFIG_IPV6=ymn
CONFIG_INET=yn

but

# CONFIG_RETPOLINE is not set

fooled me. The following patch should fix. I'll try more
configurations. Is there any way to try/tests all kbuild robot configs?

Please feel free to give me an hard stop if this sounds too much a
trial and error thing.

Paolo

--
diff --git a/include/linux/indirect_call_wrapper.h b/include/linux/indirect_call_wrapper.h
index 7c8b7f4..00d7e8e9 100644
--- a/include/linux/indirect_call_wrapper.h
+++ b/include/linux/indirect_call_wrapper.h
@@ -28,8 +28,8 @@
 #define INDIRECT_CALLABLE_SCOPE
 
 #else
-#define INDIRECT_CALL_1(f, name, ...) f(__VA_ARGS__)
-#define INDIRECT_CALL_2(f, name, ...) f(__VA_ARGS__)
+#define INDIRECT_CALL_1(f, f1, ...) f(__VA_ARGS__)
+#define INDIRECT_CALL_2(f, f2, f1, ...) f(__VA_ARGS__)
 #define INDIRECT_CALLABLE_DECLARE(f)
 #define INDIRECT_CALLABLE_SCOPE                static
 #endif

