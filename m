Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751626AbeBUGAc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 01:00:32 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:41858 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbeBUGAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 01:00:30 -0500
X-Google-Smtp-Source: AH8x225wmDuaGkR9B7DgqnrJy5oX5KM5VNzwPBZYW3xStuuw4eJLTEuJAo67/Edel/6ovx80+XGQh5SkhOAYsek53No=
MIME-Version: 1.0
From: Kees Cook <keescook@google.com>
Date: Tue, 20 Feb 2018 22:00:26 -0800
Message-ID: <CAGXu5jLg62737XeB3g0SOLTz-7NyF6_MvvH69kqFE4iqX2w7vQ@mail.gmail.com>
Subject: nla_put_string() vs NLA_STRING
To: Thomas Graf <tgraf@suug.ch>
Cc: Johannes Berg <johannes@sipsolutions.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Micay <danielmicay@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems that in at least one case[1], nla_put_string() is being used
on an NLA_STRING, which lacks a NULL terminator, which leads to
silliness when nla_put_string() uses strlen() to figure out the size:

/**
 * nla_put_string - Add a string netlink attribute to a socket buffer
 * @skb: socket buffer to add attribute to
 * @attrtype: attribute type
 * @str: NUL terminated string
*/
static inline int nla_put_string(struct sk_buff *skb, int attrtype,
const char *str)
{
    return nla_put(skb, attrtype, strlen(str) + 1, str);
}


This is a problem at least here:

struct regulatory_request {
...
char alpha2[2];
...

static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
...
[NL80211_ATTR_REG_ALPHA2] = { .type = NLA_STRING, .len = 2 },
...

AIUI, working with NLA_STRING needs nla_strlcpy() to "extract" them,
and that takes the nla_policy size normally to bounds-check the copy.


So, this specific problem needs fixing (in at least two places calling
nla_put_string(msg, NL80211_ATTR_REG_ALPHA2, ...)). While I suspect
it's only ever written an extra byte from the following variable in
the structure which is an enum nl80211_dfs_regions, I worry there
might be a lot more of these (though I'd hope unterminated strings are
uncommon for internal representation). And more generally, it seems
like only the NLA _input_ functions actually check nla_policy details.
It seems that the output functions should do the same too, yes?

-Kees

[1] https://github.com/copperhead/linux-hardened/issues/72

-- 
Kees Cook
Pixel Security
