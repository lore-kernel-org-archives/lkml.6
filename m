Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753464AbeBKPOj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 10:14:39 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:50888 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbeBKPOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 10:14:37 -0500
X-Google-Smtp-Source: AH8x227I/ZmplV1DOQvKTiYvKlhJWp31Be8NRaEEWVWeoUZXZtKuf/h3mBQmakIm1c+FfLPKEPnCwA==
Date: Sun, 11 Feb 2018 18:14:33 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] mm/huge_memory.c: reorder operations in
 __split_huge_page_tail()
Message-ID: <20180211151433.xvza2mugfybyocoi@node.shutemov.name>
References: <4f64569f-b8ce-54f8-33d9-0e67216bb54c@yandex-team.ru>
 <151835937752.185602.5640977700089242532.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151835937752.185602.5640977700089242532.stgit@buzz>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 05:29:37PM +0300, Konstantin Khlebnikov wrote:
> And replace page_ref_inc()/page_ref_add() with page_ref_unfreeze() which
> is made especially for that and has semantic of smp_store_release().

Nak on this part.

page_ref_unfreeze() uses atomic_set() which neglects the situation in the
comment you're removing.

You need at least explain why it's safe now.

I would rather leave page_ref_inc()/page_ref_add() + explcit
smp_mb__before_atomic().

-- 
 Kirill A. Shutemov
