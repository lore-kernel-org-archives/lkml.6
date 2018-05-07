Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751947AbeEGGiy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 02:38:54 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:65015 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbeEGGiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 02:38:52 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w476ciEA003140
X-Nifty-SrcIP: [209.85.217.174]
X-Google-Smtp-Source: AB8JxZoxCEMS6GRF8AibUieGc07OjXMRaG7u1GJficsZtBqEOqXirLTWOH+yCrQ0Bgcom58QerAYda7rW8Zct0J7HSY=
MIME-Version: 1.0
In-Reply-To: <20180329180112.11055-3-labbott@redhat.com>
References: <20180329180112.11055-1-labbott@redhat.com> <20180329180112.11055-3-labbott@redhat.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 7 May 2018 15:38:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNARNCUZvRm2xAhhaMJ-MCz-cim5ft7tcL7pcx_fcx4hj1g@mail.gmail.com>
Message-ID: <CAK7LNARNCUZvRm2xAhhaMJ-MCz-cim5ft7tcL7pcx_fcx4hj1g@mail.gmail.com>
Subject: Re: [RFCv2 PATCH 2/3] kbuild: Link with generated build-salt header
To: Laura Abbott <labbott@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>, mjw@fedoraproject.org,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Clifton <nickc@redhat.com>, Cary Coutant <ccoutant@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-30 3:01 GMT+09:00 Laura Abbott <labbott@redhat.com>:

> diff --git a/scripts/build-salt.lds.S b/scripts/build-salt.lds.S
> new file mode 100644
> index 000000000000..f85981f1187e
> --- /dev/null
> +++ b/scripts/build-salt.lds.S
> @@ -0,0 +1,5 @@
> +#include <generated/build-salt.h>
> +
> +SECTIONS {
> +       BUILD_ID_SALT
> +}


Do you need this just for wrapping <generate/build-salt.h> ?


How about generating scripts/build-salt.lds
directly by scripts/gensalt ?

<generated/build-salt.h> is unneeded, then
"some sporadic failures about missing the generated header"
will be solved.



I think something like follows will be simpler and better.


always := $(hostprogs-y) $(hostprogs-m) build-salt.lds

define filechk_build-salt.lds
        ($(CONFIG_SHELL) $(srctree)/scripts/gensalt $(CONFIG_BUILD_ID_SALT))
endef

$(obj)/build-salt.lds: $(src)/gensalt FORCE
        $(call filechk,build-salt.lds)




-- 
Best Regards
Masahiro Yamada
