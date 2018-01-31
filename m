Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752523AbeAaE0a (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 23:26:30 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34734 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751635AbeAaE02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 23:26:28 -0500
X-Google-Smtp-Source: AH8x227w9yFeSGrhkDjEL7aK91/Cnl9sOuzuIsJp5ISelm9R7jsfT2H26+qmpKhXg9tEVD8OYoJ5Sg==
Date: Tue, 30 Jan 2018 20:26:19 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
cc: Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [RFC] mm/migrate: Consolidate page allocation helper functions
In-Reply-To: <53cf5454-405b-a812-1389-af4fd7527122@linux.vnet.ibm.com>
Message-ID: <alpine.LSU.2.11.1801302000200.8014@eggly.anvils>
References: <20180130050642.19834-1-khandual@linux.vnet.ibm.com> <20180130143635.GF21609@dhcp22.suse.cz> <53cf5454-405b-a812-1389-af4fd7527122@linux.vnet.ibm.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2018, Anshuman Khandual wrote:
> On 01/30/2018 08:06 PM, Michal Hocko wrote:
> > On Tue 30-01-18 10:36:42, Anshuman Khandual wrote:
> >> Allocation helper functions for migrate_pages() remmain scattered with
> >> similar names making them really confusing. Rename these functions based
> >> on the context for the migration and move them all into common migration
> >> header. Functionality remains unchanged.

I agree that their names could be made less confusing (though didn't
succeed very well when I tried); and maybe a couple of them are general
enough to be used from more than one callsite, and could well live in
mm/migrate.c.

But moving all of page migration's (currently static) new_page allocator
functions away from the code that relies on their special characteristics
(probably relayed to them through a private argument), and into a single
header file, just seems perverse to me.  And likely to be a nuisance when
adding more in future: private structures having to be made public just
to make them visible in that shared header file.

Would it make sense to keep the various functions that may be called by
rmap_walk() together in one rmap_walk.h?  The different filesystems'
writepage methods together in one writepage.h?  I don't think so.

Hugh
