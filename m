Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbeDQT4Z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 15:56:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:13617 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751878AbeDQT4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 15:56:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,464,1517904000";
   d="scan'208";a="221210499"
Subject: Re: 4.17.0-rc1 doesn't boot.
To: Dave Hansen <dave.hansen@linux.intel.com>,
        Mike Galbraith <efault@gmx.de>, Borislav Petkov <bp@alien8.de>,
        =?UTF-8?Q?J=c3=b6rg_Otte?= <jrg.otte@gmail.com>
References: <CADDKRnAp1EKCAosD-kLNRaJ4qJppUtmmP1n76wzcvNUVa0fQzg@mail.gmail.com>
 <20180417081458.GA2894@pd.tnic>
 <CADDKRnDmycResXxAsfYfM6sFoWffD_v_cMoR4XF7OxUps3mU+Q@mail.gmail.com>
 <20180417142715.GL18640@pd.tnic>
 <CADDKRnBtQKz5S3EdJbrVH8PN9_qTrSQ3owcK=PfxToHdxpu8rA@mail.gmail.com>
 <20180417153101.GB2894@pd.tnic> <1523980839.7093.1.camel@gmx.de>
 <017d65c5-748b-eeae-a020-fa4473f4507c@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@nokia.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <db545641-9fb4-6ef1-32f4-2afc987261b0@intel.com>
Date: Tue, 17 Apr 2018 12:56:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <017d65c5-748b-eeae-a020-fa4473f4507c@linux.intel.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heh, your .config is insidious:

ffffffff9ffe3000 B __brk_base
ffffffff9ffe3000 B __bss_stop
ffffffff9fff3000 b .brk.dmi_alloc
ffffffffa0003000 b .brk.early_pgt_alloc
ffffffffa000f000 B _end
ffffffffa000f000 B __brk_limit

dmi_alloc is __init, so it gets freed at some point and the PTEs zeroed
out.  That causes the warning when change_page_attr() sees the zero'd
PTE.  We just need to special-case the __init section along with the
linear map in pageattr.c.

I'll have some patches to do this shortly.
