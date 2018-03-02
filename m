Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932452AbeCBTyu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 14:54:50 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:33351 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932428AbeCBTyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 14:54:49 -0500
X-Google-Smtp-Source: AG47ELujyTFQEmiTkJabwecpwPNPfe2FWtKzW68JGmg896MiWvm+lLOHqbTyxBf1K3vLQ12B1p2sa+fGQMkvrVnp0ZM=
MIME-Version: 1.0
In-Reply-To: <20180226084602.GR21977@gate.crashing.org>
References: <20180225172236.29650-1-malat@debian.org> <20180225172236.29650-6-malat@debian.org>
 <55d52f37-c24d-c2da-43c6-73a55403d3b6@c-s.fr> <20180226084602.GR21977@gate.crashing.org>
From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 2 Mar 2018 20:54:27 +0100
X-Google-Sender-Auth: EPk2WlEEuv3Xd6l7qXRTgQWKdk4
Message-ID: <CA+7wUsz7srOXwehLjuSn_SEgCUkGxu9bq6aOw5AeOaiiipBNtg@mail.gmail.com>
Subject: Re: [PATCH 05/21] powerpc: Avoid comparison of unsigned long >= 0 in pfn_valid
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Christophe LEROY <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Paul Mackerras <paulus@samba.org>, LKML <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w22JswMI018156

On Mon, Feb 26, 2018 at 9:46 AM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
> On Mon, Feb 26, 2018 at 07:32:03AM +0100, Christophe LEROY wrote:
>> Le 25/02/2018 à 18:22, Mathieu Malaterre a écrit :
>> >-#define pfn_valid(pfn)              ((pfn) >= ARCH_PFN_OFFSET && (pfn) <
>> >max_mapnr)
>> >+#define pfn_valid(pfn) \
>> >+            (((pfn) - ARCH_PFN_OFFSET) < (max_mapnr - ARCH_PFN_OFFSET))
>>
>> What will happen when ARCH_PFN_OFFSET is not nul and pfn is lower than
>> ARCH_PFN_OFFSET ?
>
> It will work fine.
>
> Say you are asking for  a <= x < b  so (in actual integers, no overflow)
> that is  0 <= x-a < b-a  and you also assume x-a overflows, so that we
> are actually comparing  x-a+M < b-a  with M = 2**32 or such (the maximum
> value in the unsigned integer type plus one).  This comparison is
> obviously always false.
>
> (It also works if b < a btw).
>
>
Thanks Segher !

Christophe does that clarify things or do you want me to update the
commit message ?
