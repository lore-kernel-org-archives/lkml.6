Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F10AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 14:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD9F2086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 14:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD9F2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389859AbeKQARO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 19:17:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:29840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727999AbeKQARO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 19:17:14 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9AABB83F40;
        Fri, 16 Nov 2018 14:04:40 +0000 (UTC)
Received: from localhost (ovpn-200-47.brq.redhat.com [10.40.200.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C025600C2;
        Fri, 16 Nov 2018 14:04:37 +0000 (UTC)
Date:   Fri, 16 Nov 2018 15:04:32 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Joe Perches <joe@perches.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] geneve: Use empty braces for addr6
 initializer
Message-ID: <20181116150432.2408a075@redhat.com>
In-Reply-To: <20181113061146.12182-1-natechancellor@gmail.com>
References: <20181112221248.11477-1-natechancellor@gmail.com>
        <20181113061146.12182-1-natechancellor@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 16 Nov 2018 14:04:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018 23:11:47 -0700
Nathan Chancellor <natechancellor@gmail.com> wrote:

> Clang warns:
> 
> drivers/net/geneve.c:428:29: error: suggest braces around initialization
> of subobject [-Werror,-Wmissing-braces]
>                 struct in6_addr addr6 = { 0 };
>                                           ^
>                                           {}
> 
> Most initializations of structs in the kernel seem to use this format.

Actually, even with this, we get a warning with gcc 4.4 and 4.8. I tried a
few compilers:

$ gcc-4.4 --version | head -n1
rhel-6.9-gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
$ gcc-4.8 --version | head -n1
rhel-7.5-gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
$ gcc-7.3 --version | head -n1
gcc-7.3-gcc (GCC) 7.3.0
$ gcc-8.2 --version | head -n1
gcc (Debian 8.2.0-9) 8.2.0
$ clang --version | head -n1
clang version 6.0.1-9.2 (tags/RELEASE_601/final)

$ cat init.c
#include <linux/in6.h>
 
int main()
{
        struct in6_addr addr6 = INIT;
 
        return addr6.in6_u.u6_addr8[0];
}

$ gcc-4.4 -DINIT="{ }" -S -Wall -Wextra -o init init.c 2>&1 | grep warning | head -n1
init.c:5: warning: missing initializer
$ gcc-4.4 -DINIT="{ 0 }" -S -Wall -Wextra -o init init.c 2>&1 | grep warning | head -n1
init.c:5: warning: missing braces around initializer
$ gcc-4.4 -DINIT="{ { { 0 } } }" -S -Wall -Wextra -o init init.c 2>&1 | grep warning | head -n1

$ gcc-4.8 -DINIT="{ }" -S -Wall -Wextra -o init init.c 2>&1 | grep warning | head -n1
init.c:5:16: warning: missing initializer for field 'in6_u' of 'struct in6_addr' [-Wmissing-field-initializers]
$ gcc-4.8 -DINIT="{ 0 }" -S -Wall -Wextra -o init init.c 2>&1 | grep warning | head -n1
init.c:5:16: warning: missing braces around initializer [-Wmissing-braces]
$ gcc-4.8 -DINIT="{ { { 0 } } }" -S -Wall -Wextra -o init init.c 2>&1 | grep warning | head -n1

$ gcc-7.3 -DINIT="{ }" -S -Wall -Wextra -o init init.c 2>&1 | grep warning | head -n1
$ gcc-7.3 -DINIT="{ 0 }" -S -Wall -Wextra -o init init.c 2>&1 | grep warning | head -n1
$ gcc-7.3 -DINIT="{ { { 0 } } }" -S -Wall -Wextra -o init init.c 2>&1 | grep warning | head -n1

$ gcc-8.2 -DINIT="{ }" -S -Wall -Wextra -o init init.c 2>&1 | grep warning | head -n1
$ gcc-8.2 -DINIT="{ 0 }" -S -Wall -Wextra -o init init.c 2>&1 | grep warning | head -n1
$ gcc-8.2 -DINIT="{ { { 0 } } }" -S -Wall -Wextra -o init init.c 2>&1 | grep warning | head -n1

$ clang -DINIT="{ }" -S -Wall -Wextra -o init init.c 2>&1 | grep warning | head -n1
$ clang -DINIT="{ 0 }" -S -Wall -Wextra -o init init.c 2>&1 | grep warning | head -n1
init.c:5:33: warning: suggest braces around initialization of subobject [-Wmissing-braces]
$ clang -DINIT="{ { { 0 } } }" -S -Wall -Wextra -o init init.c 2>&1 | grep warning | head -n1

So { { { 0 } } } seems to be the safest option. We could go with static
but it looks even uglier to me.

Joe, suggestions?

-- 
Stefano
