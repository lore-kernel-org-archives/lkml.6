Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755416AbeDTOx4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:53:56 -0400
Received: from resqmta-ch2-06v.sys.comcast.net ([69.252.207.38]:48978 "EHLO
        resqmta-ch2-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755234AbeDTOxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:53:55 -0400
Date: Fri, 20 Apr 2018 09:53:53 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Michal Hocko <mhocko@kernel.org>
cc: Vlastimil Babka <vbabka@suse.cz>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org,
        dm-devel@redhat.com, David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SLUB: Do not fallback to mininum order if __GFP_NORETRY
 is set
In-Reply-To: <20180419110051.GB16083@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.20.1804200952230.18006@nuc-kabylake>
References: <alpine.DEB.2.20.1804180944180.1062@nuc-kabylake> <20180419110051.GB16083@dhcp22.suse.cz>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfLG2F4Q8peAuO9L/0cRlAM3/YH8XqExASWsBtksX6eak3NvWqD5t+hUULQxECxskI+klYVaDpfpbPuSA5YxoGlceEJEyvIMIq5Yuzg1mBvdAhOmff9xU
 PrqA0wP5Y7XhaS0/3iSG4b6i5tuUPBYzXVAFIZDTn9xs5GWQ+3kYmB6BbbGUVHxxksBJ/nopgYVLgWuAgpwRGrSAGg3IoCiAmdmItSCX/fGwvDiKysvppEdc
 hdcBsMazBdqZ6m839+FOBTgC4+rlaqxuw0EkMryz8ENJnf3zZAgPGTM9LJQaOHztpUu7C5p6kXq0QLTqp3lMk7yvIL7PQOwIDUUoCNIA+9TQolC2+ptSeFOZ
 p42obiwNxiqdIgY518UYKBulGJjldBD9AVf+z0G+ucCD4ZkOIMm9zQmLh6SvBJS4tzSkqVqeY8c3gGimShL2fqakGWAwwC1JSmoqpEPE+uAUQroMSED1COrV
 fR8a0aT7cslM0Cr6SZJsDCTbKCcLQLzBmgCsxQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2018, Michal Hocko wrote:

> Overriding __GFP_NORETRY is just a bad idea. It will make the semantic
> of the flag just more confusing. Note there are users who use
> __GFP_NORETRY as a way to suppress heavy memory pressure and/or the OOM
> killer. You do not want to change the semantic for them.

Redoing the allocation after failing a large order alloc is a retry. I
would say its confusing right now because a retry occurs despite
specifying GFP_NORETRY,

> Besides that the changelog is less than optimal. What is the actual
> problem? Why somebody doesn't want a fallback? Is there a configuration
> that could prevent the same?

The problem is that SLUB does not honor GFP_NORETRY. The semantics of
GFP_NORETRY are not followed.
