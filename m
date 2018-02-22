Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751376AbeBVTy6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 14:54:58 -0500
Received: from s3.sipsolutions.net ([144.76.63.242]:46070 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751273AbeBVTy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 14:54:57 -0500
Message-ID: <1519329289.2637.12.camel@sipsolutions.net>
Subject: Re: nla_put_string() vs NLA_STRING
From: Johannes Berg <johannes@sipsolutions.net>
To: Kees Cook <keescook@google.com>, Thomas Graf <tgraf@suug.ch>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Micay <danielmicay@gmail.com>
Date: Thu, 22 Feb 2018 20:54:49 +0100
In-Reply-To: <CAGXu5jLg62737XeB3g0SOLTz-7NyF6_MvvH69kqFE4iqX2w7vQ@mail.gmail.com> (sfid-20180221_070030_986418_27F469F1)
References: <CAGXu5jLg62737XeB3g0SOLTz-7NyF6_MvvH69kqFE4iqX2w7vQ@mail.gmail.com>
         (sfid-20180221_070030_986418_27F469F1)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-02-20 at 22:00 -0800, Kees Cook wrote:

> It seems that in at least one case[1], nla_put_string() is being used
> on an NLA_STRING, which lacks a NULL terminator, which leads to
> silliness when nla_put_string() uses strlen() to figure out the size:

Fun! I'm not a big fan of the whole NLA_STRING thing with or without
NUL terminator anyway, it's a bit confusing at times :-)

> This is a problem at least here:
> 
> struct regulatory_request {
> ...
> char alpha2[2];
> ...
> 
> static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
> ...
> [NL80211_ATTR_REG_ALPHA2] = { .type = NLA_STRING, .len = 2 },
> ...

Yeah, this is clearly stupid. We already fixed one of these, see commit
a5fe8e7695dc ("regulatory: add NUL to alpha2"). I'll fix up the second
one too.

> So, this specific problem needs fixing (in at least two places calling
> nla_put_string(msg, NL80211_ATTR_REG_ALPHA2, ...)). While I suspect
> it's only ever written an extra byte from the following variable in
> the structure which is an enum nl80211_dfs_regions, 

Only one, since the other has alpha2[3] already :-)

And in that case, yes, on little endian and only if the dfs region is
non-zero, though the dfs region was added later so dunno what else
there was - but certainly this struct would have always contained some
enum value that had zero-bytes.

> I worry there
> might be a lot more of these (though I'd hope unterminated strings are
> uncommon for internal representation).

Generally they are, I'd argue.

> And more generally, it seems
> like only the NLA _input_ functions actually check nla_policy details.
> It seems that the output functions should do the same too, yes?

It doesn't really work that way - there's no real guarantee that the
policy is symmetric on input/output.

johannes
